import 'package:flutter/material.dart';
import '../components/station_item.dart';
import '../components/theme.dart';
import '../info/stationData.dart'; // StationData sınıfını içeren dosya
import 'package:qr_flutter/qr_flutter.dart';

class StationListPage extends StatefulWidget {
  final String? placeId;

  StationListPage({this.placeId});

  @override
  _StationListPageState createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {

  final List<StationData> stations = [
    StationData(
      id: "1",
      imageUrl: "https://source.unsplash.com/random/300x300?v=1",
      title: "Durak 1",
      details: "Açıklama 1",
      type: "default",
      lat: 39.993936,
      lng: 32.887406
    ),
    StationData(
      id: "2",
      imageUrl: "https://source.unsplash.com/random/300x300?v=2",
      title: "Durak 2",
      details: "Açıklama 2",
      type: "default",
      lat: 37.774000,
      lng: -74.006080
    )
  ];

  @override
  Widget build(BuildContext context) {
    List<StationData> filteredStations = stations.where((station) => station.id == widget.placeId).toList();

    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.navyBlue),
          onPressed: () {
            // İstediğiniz yere yönlendirme yapın
             Navigator.pushNamed(context, '/placeList');
          },
        ),
        title: Text("Durak Listesi", style: TextStyle(color: AppColors.navyBlue)),
        backgroundColor: AppColors.white,
      ),
      body: ListView.separated(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          StationData station = filteredStations[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(station.imageUrl),
                radius: 30,
              ),
              title: Text(station.title, style: TextStyle(color: AppColors.navyBlue)),
              subtitle: Text(station.details, style: TextStyle(color: AppColors.navyBlue)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.location_on, color: AppColors.navyBlue),
                    onPressed: () {
                      // Haritada durağı göster
                      Navigator.pushNamed(
                        context,
                        '/mapPage',
                        arguments: {
                          "placeId": widget.placeId,
                          "latitude": station.lat,
                          "longitude": station.lng
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.qr_code, color: AppColors.navyBlue),
                    onPressed: () { _showQrModal(context,station);},
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: AppColors.orange),
                    onPressed: () {removePlace(index);},
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni durak ekleme sayfasına yönlendirme yapabilirsiniz
         Navigator.pushNamed(
                        context,
                        '/mapPage',
                        arguments: {
                          "placeId": widget.placeId,
                          "latitude": null,
                          "longitude": null
                        },
                      );
        },
        backgroundColor: AppColors.navyBlue,
        child: Icon(Icons.add, color: AppColors.orange),
        tooltip: 'Yeni Durak Ekle',
      ),
    );
  }
  
  void removePlace(int index) {
    setState(() {
      stations.removeAt(index);
    });
  }

  void _showQrModal(BuildContext context, StationData station) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 350,  // Adjust height as needed
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Scan this QR Code'),
                SizedBox(height: 20),
                QrImageView(
                  data: 'https://www.google.com/maps/@${station.lat},${station.lng},14z?entry=ttu',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}