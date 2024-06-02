import 'dart:async';

import 'package:cleanmap/models/place.dart';
import 'package:cleanmap/utils/parser.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PlacesMap extends StatefulWidget {
  const PlacesMap({super.key, required this.stream});

  final Stream<List<bool>> stream;

  @override
  State<PlacesMap> createState() => PlacesMapState();
}

class PlacesMapState extends State<PlacesMap> {
  final Completer<GoogleMapController> _completer =
    Completer<GoogleMapController>();

  // 대전광역시 유성구 계룡로113번길 73
  static const CameraPosition _kDefault = CameraPosition(
    target: LatLng(36.356752, 127.344406),
    zoom: 18.0
  );

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: FutureBuilder(
        future: loadDataset(),
        builder: (BuildContext context,
          AsyncSnapshot<Iterable<Place>> snapshot) {
          List<Set<Place>> placeSets = [ {}, {}, {} ];

          if (snapshot.hasData) {
            Iterable<Place> placeIterator = snapshot.data!;

            for (int i = 0; i < 3; i++) {
              placeSets[i] = placeIterator.where(
                (Place x) {
                  int j = switch (x.wasteType) {
                    WasteType.food => 1,
                    WasteType.recyclable => 2,
                    _ => 0
                  };

                  return (i == j);
                }
              ).toSet();
            }

            Set<Place> places = {};

            return StreamBuilder<List<bool>>(
              stream: widget.stream,
              builder: (BuildContext context,
                AsyncSnapshot<List<bool>> snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i < 3; i++) {
                    if (snapshot.data![i]) {
                      places.addAll(placeSets[i]);
                    } else {
                      places = places.difference(placeSets[i]);
                    }
                  }
                }

                return GoogleMap(
                  initialCameraPosition: _kDefault,
                  onMapCreated: (GoogleMapController controller) {
                    _completer.complete(controller);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: places,
                  onTap: (LatLng latLng) async {
                    final GoogleMapController controller = await _completer.future;

                    controller.animateCamera(CameraUpdate.newLatLng(latLng));
                  },
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
}