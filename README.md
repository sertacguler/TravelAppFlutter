# my_travel_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


 urlTemplate: "https://api.mapbox.com/styles/v1/sertacg/cluyger49004501phcfgm097c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2VydGFjZyIsImEiOiJjbHV5ZnE2MjEwMnlkMmluazh0N2l6YnBnIn0.Qw2_nm9QqmOjqiTsIA_J3Q",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1Ijoic2VydGFjZyIsImEiOiJjbHV5ZnE2MjEwMnlkMmluazh0N2l6YnBnIn0.Qw2_nm9QqmOjqiTsIA_J3Q', // Buraya Mapbox Access Token'ınızı girin
                  'id': 'mapbox.mapbox-streets-v8', // Kullanmak istediğiniz Mapbox harita stili
                },




                import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../components/custom_button.dart'; // Eğer path yanlış ise güncelleyin
import '../components/theme.dart'; // Tema ayarlarınızı içeren dosya, path kontrol edilmeli

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> markers = [];

  void _addMarker(LatLng position) {
    final marker = Marker(
      width: 80.0,
      height: 80.0,
      point: position,
      child: Container(
        child: Icon(Icons.location_on, color: AppColors.navyBlue),
      ),
    );

    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Durak Ekle'),
        backgroundColor: AppColors.navyBlue,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(39.925533, 32.866743), // Ankara'nın koordinatları
              zoom: 13.0,
              onTap: (_, position) => _addMarker(position),
            ),
            children: [
              TileLayer(
               urlTemplate: "https://api.mapbox.com/styles/v1/sertacg/cluyger49004501phcfgm097c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2VydGFjZyIsImEiOiJjbHV5ZnE2MjEwMnlkMmluazh0N2l6YnBnIn0.Qw2_nm9QqmOjqiTsIA_J3Q",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1Ijoic2VydGFjZyIsImEiOiJjbHV5ZnE2MjEwMnlkMmluazh0N2l6YnBnIn0.Qw2_nm9QqmOjqiTsIA_J3Q', // Buraya Mapbox Access Token'ınızı girin
                  'id': 'mapbox.mapbox-streets-v8', // Kullanmak istediğiniz Mapbox harita stili
                },
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            left: 20,
            top: 20,
            child: FloatingActionButton(
              onPressed: () {/* Arama işlemi burada yapılacak */},
              child: Icon(Icons.search),
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomButton(
              text: 'Durak Kaydet',
              onPressed: () {/* Kaydet işlemi burada yapılacak */},
            ),
          ),
        ],
      ),
    );
  }
}
