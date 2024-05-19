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

  static double currentRadius = 300.0;

  List<Circle> circles = [
    Circle(
      circleId: const CircleId("0"),
      center: _kDefault.target,
      radius: currentRadius,
      fillColor: Colors.blue.shade100.withOpacity(0.5),
      strokeColor:  Colors.blue.shade100.withOpacity(0.15),
    )
  ];

  List<Marker> markers = [
    Marker(
      markerId: const MarkerId("0"),
      position: _kDefault.target
    )
  ];

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
              circles: circles.toSet(),
              markers: markers.toSet(),
              onTap: (LatLng latLng) async {
                final GoogleMapController controller = await _controller.future;

                controller.animateCamera(CameraUpdate.newLatLng(latLng));

                setState(() {
                  circles[0] = circles[0].copyWith(centerParam: latLng);
                  markers[0] = markers[0].copyWith(positionParam: latLng);
                });
              },
              onCameraMove: (CameraPosition position) {
                setState(() {
                  circles[0] = circles[0].copyWith(centerParam: position.target);
                  markers[0] = markers[0].copyWith(positionParam: position.target);
                });
              }
            )
          ),
        ),
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          24.0, 16.0, 0.0, 0.0
                      ),
                      child: Text(
                        "탐색 범위",
                      )
                  )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Slider(
                      min: 200.0,
                      max: 400.0,
                      value: currentRadius,
                      onChanged: (double value) {
                        setState(() {
                          circles[0] = circles[0].copyWith(radiusParam: value);

                          currentRadius = value;
                        });
                      }
                  ),
                ),
              )
            ],
          )
        )
      ]
    );
  }
}