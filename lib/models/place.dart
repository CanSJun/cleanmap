import 'package:cleanmap/utils/parser.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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