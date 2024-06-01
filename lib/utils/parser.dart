import 'package:cleanmap/models/place.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String datasetPath = "datasets/15109940-20221212.csv";

Future<Iterable<Place>> loadDataset() async {
  return rootBundle.loadString(datasetPath).then(
    (String datasetData) {
      List<List<dynamic>> datasetRows = const CsvToListConverter()
        .convert(datasetData, eol: "\n");

      /*
        [연번, 고유 번호, 위치 번호, 유형,
         시도, 시군, 동, 도로명 주소,
         지번 주소, 상세 주소, 위도, 경도,
         사용자 고유 번호, 등록일, 사용 유무, 카메라 유무,
         공공 쓰레기통 유무, 헌옷수거함 유무, 일반 쓰레기 배출 요일, 일반 쓰레기 배출 시간,
         음식물 쓰레기 배출 요일, 음식물 쓰레기 배출 시간, 재활용품 배출 요일, 재활용품 배출 시간,
         미수거일, 이미지 고유 번호] (26)
       */

      return datasetRows.skip(1).map(
        (List<dynamic> value) {
          final double latitude = double.parse(value[10].toString());
          final double longitude = double.parse(value[11].toString());

          return Place(
            markerId: MarkerId(value[1]),
            position: LatLng(latitude, longitude)
          );
        }
      );
    }
  );
}