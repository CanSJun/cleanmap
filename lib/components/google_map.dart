import 'dart:async';

import 'package:cleanmap/models/place.dart';
import 'package:cleanmap/utils/parser.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PlacesMap extends StatefulWidget {
  const PlacesMap({super.key});

  @override
  State<PlacesMap> createState() => PlacesMapState();
}

class PlacesMapState extends State<PlacesMap> {
  final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

  // 대전광역시 유성구 계룡로113번길 73
  static const CameraPosition _kDefault = CameraPosition(
    target: LatLng(36.356752, 127.344406),
    zoom: 18.0
  );

  Set<Place> places = {};

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: FutureBuilder(
        future: loadDataset(),
        builder: (BuildContext context,
          AsyncSnapshot<Iterable<Place>> snapshot) {
          if (snapshot.hasData) {
            places = snapshot.data!.toSet();
          }

          return GoogleMap(
            initialCameraPosition: _kDefault,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: places,
            onTap: (LatLng latLng) async {
              final GoogleMapController controller = await _controller
                .future;

              controller.animateCamera(CameraUpdate.newLatLng(latLng));
            },
          );
        }
      )
    );
  }
}