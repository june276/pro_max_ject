import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';
import 'package:pro_max_ject/models/shelter_map.dart';
import 'package:pro_max_ject/screen/web_view_page.dart';
import 'package:provider/provider.dart';
import 'package:pro_max_ject/api/shelter_provider.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double lat = 0;
  double lng = 0;
  Location location = Location();
  bool _serviceEnabled = true;
  late PermissionStatus _permissionGranted;
  Set<Marker> markers = {}; // 마커 변수
  KakaoMapController? mapController;
  List<Shelter> shelters = []; // 대피소 목록

  @override
  void initState() {
    super.initState();
    _locateMe(); // 현재 위치를 가져와 지도에 마커를 찍고, 지도 중심을 이동
  }

  Future<void> _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      lat = locationData.latitude!;
      lng = locationData.longitude!;
      final currentLatLng = LatLng(lat, lng);

      // 현재 위치에 마커 추가
      markers.add(
        Marker(
          markerId: UniqueKey().toString(),
          latLng: currentLatLng,
          markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
        ),
      );

      // 맵 컨트롤러가 있다면 지도 중심을 현재 위치로 이동
      if (mapController != null) {
        mapController!.setCenter(currentLatLng);
        mapController!.setLevel(5); // 지도 줌 레벨 설정 (필요에 따라 조정)
      }
    });

    // 대피소 데이터를 불러와 지도에 마커 추가
    await _loadShelters();
  }

  Future<void> _loadShelters() async {
    final provider = Provider.of<ShelterProvider>(context, listen: false);
    try {
      // 대피소를 검색하여 마커를 추가합니다.
      await provider.searchShelters(pageNo: 1, numOfRows: 10); // 필요한 페이지 번호와 개수로 호출

      // 대피소 마커를 추가합니다.
      final loadedShelters = provider.shelters;
      setState(() {
        shelters = loadedShelters;
        for (var shelter in shelters) {
          final distance = Geolocator.distanceBetween(
            lat,
            lng,
            shelter.latitude,
            shelter.longitude,
          );
          shelter.distance = distance; // 거리 저장
        }

        markers.addAll(
          shelters.map(
                (shelter) => Marker(
              markerId: shelter.name, // 쉘터의 이름을 마커 ID로 사용
              latLng: LatLng(shelter.latitude, shelter.longitude),
            ),
          ),
        );

        // 지도 중심을 대피소가 있는 위치로 이동할 수 있습니다.
        if (shelters.isNotEmpty && mapController != null) {
          final firstShelter = shelters.first;
          mapController!.setCenter(LatLng(firstShelter.latitude, firstShelter.longitude));
        }
      });
    } catch (e) {
      print('Error loading shelters: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F0),
      appBar: AppBar(
        title: Text(
          '이재난녕',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.07,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        backgroundColor: const Color(0xEF537052),
        elevation: 4,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: KakaoMap(
              onMapCreated: (controller) {
                mapController = controller;
                // 맵이 처음 생성될 때 위치를 한 번 더 가져와 중심을 설정
                if (lat != 0 && lng != 0) {
                  mapController!.setCenter(LatLng(lat, lng));
                }
              },
              markers: markers.toList(),
              center: LatLng(lat, lng),
              onMarkerTap: ((markerId, latLng, zoomLevel) {}),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shelters.length,
              itemBuilder: (context, index) {
                final shelter = shelters[index];
                final distanceKm = (shelter.distance ?? 0) / 1000;
                final latLng = '${shelter.latitude},${shelter.longitude}';
                return ListTile(
                  title: Text(shelter.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(shelter.address),
                      Text(
                        '${shelter.type}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${distanceKm.toStringAsFixed(2)} km',
                    style: const TextStyle(color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const Icon(Icons.location_on),
                  onTap: () {
                    // 웹뷰로 이동하기 위한 URL을 생성합니다.
                    final url = 'https://map.kakao.com/link/map/${shelter.name},${shelter.latitude},${shelter.longitude}';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapViewPage(url: url),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
