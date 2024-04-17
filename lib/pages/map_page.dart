import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../components/custom_button.dart'; // Eğer path yanlış ise güncelleyin
import '../components/theme.dart';
import '../components/searchLocation.dart'; 
import '../components/location_dialog.dart';
import '../components/bottom_detail_widget.dart'; 
import '../info/stationData.dart';
import '../info/locationData.dart';
import './station_list_page.dart';
import './home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MapPage extends StatefulWidget { 
  final String placeId;
  double? initialLat;
  double? initialLng;
  MapPage({Key? key, required this.placeId, this.initialLat, this.initialLng}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> markers = [];
  List<StationData> markersInfo = [];
  late MapController mapController;
  double currentZoom = 15.0; // Örnek bir başlangıç zoom seviyesi
  
  @override
  void initState() {
      super.initState();
      mapController = MapController();      
  }

  void _addMarker(StationData stationData, String markerType) {
    Icon icon;
    switch (markerType) {
      case 'Restaurant':
        icon = Icon(Icons.location_on,  color: Colors.red);
        break;
      case 'Park':
        icon = Icon(Icons.location_on, color: Colors.green);
        break;
      case 'Hotel':
        icon = Icon(Icons.location_on, color: Colors.blue);
        break;
      default:
        icon = Icon(Icons.location_on,  color: AppColors.navyBlue);
    }

    final marker = Marker(
      point: LatLng(stationData.lat, stationData.lng),
      child: GestureDetector(
        onTap: () { _showBottomDialog(context, stationData); },
        child: Center(child: icon),
      ),
    );

    setState(() {
      markers.add(marker);
      markersInfo.add(stationData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(widget.initialLat ?? 30.042328, widget.initialLng ?? 31.2324968),
              zoom: widget.initialLat != null ? 18.0 : currentZoom,
              onTap: (_, position) => _showLocationDialog(position)
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            left: 20,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: () {_showSearchInput(context);},
              child: Icon(Icons.search, color: AppColors.white),
              backgroundColor: AppColors.navyBlue,
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      text: 'İptal',
                      onPressed: () {
                        // Ana sayfaya döner ve tüm önceki yığınları temizler
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => StationListPage(placeId: widget.placeId)),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 20), // Butonlar arasında boşluk bırakmak için
                  Expanded(
                    child: CustomButton(
                      text: 'Durakları Kaydet',
                      onPressed: () { _navigateToStationListPage(); /*_saveMarkers()*/ },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showLocationDialog(LatLng position) async {
    LocationData? result = await showDialog<LocationData>(
      context: context,
      builder: (BuildContext context) {
        return LocationDialog(position: position); // Örnek bir koordinat
      },
    );

    if (result != null) {
      print("Yer adı: ${result.name}, Yorum: ${result.comment}, Marker Tipi: ${result.markerType}");
      _addMarker(StationData(id: DateTime.now().toString(), title: result.name, details: result.comment, imageUrl: "", lng: position.longitude, lat: position.latitude, type: result.markerType), result.markerType);
    }
  }

  void _showSearchInput(BuildContext context)  {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        TextEditingController searchController = TextEditingController();
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: "Search",
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async{
                  StationData? stationData = await searchLocation(searchController.text);
                  if (stationData != null) {
                    _addMarker(stationData, 'default');
                    print(stationData);
                    mapController.move(LatLng(stationData.lat, stationData.lng), mapController.zoom);
                  }
                  Navigator.pop(context); // Optionally close the sheet after search
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomDialog(BuildContext context, StationData stationData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return BottomDetailWidget(
          stationData: stationData,
          onClose: () => Navigator.pop(ctx),
        );
      },
    );
  }

  void _navigateToStationListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationListPage(placeId: widget.placeId)),
    );
  }

  /*void _saveMarkers() {
    // Burada yerel bir veritabanı veya global durum yönetimi ile kaydetme işlemini yapabilirsiniz.
    // Diyelim ki bu markerlar başka bir sayfada bir liste olarak gösterilecek.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StopsPage(markers: markers)),
    );
  }*/
  
}