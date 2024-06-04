import 'dart:async';
import 'dart:ui';

import 'package:cleanmap/models/place.dart';
import 'package:cleanmap/utils/parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PlacesMap extends StatefulWidget {
  const PlacesMap({super.key, required this.stream});

  final Stream<List<bool>> stream;

  @override
  State<PlacesMap> createState() => PlacesMapState();
}

class PlacesMapState extends State<PlacesMap> {
  // 대전광역시 유성구 계룡로113번길 73
  final CameraPosition _kDefault = const CameraPosition(
      target: LatLng(36.356752, 127.344406),
      zoom: 18.0
  );

  final Completer<GoogleMapController> _completer =
    Completer<GoogleMapController>();

  final List<bool> _selectedFilters = <bool>[false, false, false];

  late ClusterManager _manager;

  Set<Marker> _markers = <Marker>{};
  List<Place> _places = <Place>[];

  @override
  void initState() {
    super.initState();

    _manager = ClusterManager<Place>(
        _places,
        _updateMarkers,
        markerBuilder: _markerBuilder,
        extraPercent: 0.35
    );
  }

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: FutureBuilder(
        future: loadDataset(),
        builder: (BuildContext context,
          AsyncSnapshot<Iterable<Place>> snapshot) {
          if (snapshot.hasData) {
            Iterable<Place> placeIterator = snapshot.data!;

            return StreamBuilder<List<bool>>(
              stream: widget.stream,
              builder: (BuildContext context,
                AsyncSnapshot<List<bool>> snapshot) {
                if (snapshot.hasData) {
                  if (!listEquals(_selectedFilters, snapshot.data!)) {
                    _places = placeIterator.where(
                      (Place x) {
                          int i = switch (x.wasteType) {
                            WasteType.food => 1,
                            WasteType.recyclable => 2,
                            _ => 0
                          };

                          return snapshot.data![i];
                        }
                    ).toList();

                    _manager.setItems(_places);

                    for (int i = 0; i < snapshot.data!.length; i++) {
                      _selectedFilters[i] = snapshot.data![i];
                    }
                  }
                }

                return GoogleMap(
                  initialCameraPosition: _kDefault,
                  onMapCreated: (GoogleMapController controller) {
                    _completer.complete(controller);
                    _manager.setMapId(controller.mapId);
                  },
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  onCameraMove: _manager.onCameraMove,
                  onCameraIdle: _manager.updateMap
                );
              }
            );
          } else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        }
      )
    );
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder {
    return (Cluster<Place> cluster) async {
      if (cluster.isMultiple) {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          icon: await _getMarkerBitmap(
            size: 60,
            text: cluster.count.toString()
          ),
          position: cluster.location,
        );
      } else {
        final Place place = cluster.items.first;

        return Marker(
          markerId: MarkerId(cluster.getId()),
          icon: place.icon,
          position: cluster.location
        );
      }
    };
  }

  Future<BitmapDescriptor> _getMarkerBitmap({
    required int size,
    required String text
  }) async {
    if (kIsWeb) {
      size = (size / 2).floor();
    }

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint innerColor = Paint()..color = Colors.green.shade500;
    final Paint outerColor = Paint()..color = Colors.green.shade800;

    final Offset circleOffset = Offset(size / 2, size / 2);

    canvas.drawCircle(circleOffset, size / 2.0, outerColor);
    canvas.drawCircle(circleOffset, size / 2.15, innerColor);

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

    painter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: size / 2,
        color: Colors.white,
        fontWeight: FontWeight.normal
      ),
    );

    painter.layout();

    painter.paint(
      canvas,
      Offset(
        (size - painter.width) / 2,
        (size - painter.height)  / 2
      ),
    );

    final image = await pictureRecorder.endRecording().toImage(size, size);
    final byteData = await image.toByteData(format: ImageByteFormat.png)
      as ByteData;

    return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      _markers = markers;
    });
  }
}