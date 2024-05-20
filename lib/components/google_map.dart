import 'dart:async';

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
      zoom: 16.0
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PointerInterceptor(
            child: GoogleMap(
              initialCameraPosition: _kDefault,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (LatLng latLng) async {
                final GoogleMapController controller = await _controller.future;

                controller.animateCamera(CameraUpdate.newLatLng(latLng));
              },
              onCameraMove: (CameraPosition position) {
              }
            )
          ),
        )
      ]
    );
  }
}