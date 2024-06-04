import 'package:cleanmap/utils/parser.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
class Place extends Marker {
  final WasteType wasteType;

  const Place({
    required super.markerId,
    super.icon,
    super.infoWindow,
    super.position,
    this.wasteType = WasteType.general
  });
}
*/

class Place with ClusterItem {
  final BitmapDescriptor icon;
  final LatLng latLng;

  final String name, address, disposalDays, disposalTime;

  final WasteType wasteType;

  Place({
    required this.name,
    required this.latLng,
    required this.address,
    required this.wasteType,
    required this.disposalDays,
    required this.disposalTime,
    required this.icon
  });

  @override
  LatLng get location => latLng;
}