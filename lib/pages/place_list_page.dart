import 'package:flutter/material.dart';
import '../components/station_item.dart'; // StationItem widget'ının bulunduğu dosya
import '../components/theme.dart'; // Tema renklerini içeren dosya
import '../components/add_place_modal.dart'; 
import '../info/placeData.dart';

class PlaceListPage extends StatefulWidget {
  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  final List<PlaceData> places = [
    PlaceData(
        id: "1",
        imageUrl: "https://source.unsplash.com/random/300x300?v=3",
        title: "Eiffel Tower",
        details: "Amazing view!",
        country: "Italy"
     ),
    PlaceData(
      id: "2",
      imageUrl: "https://source.unsplash.com/random/300x300?v=4",
      title: "Colosseum",
      details: "Iconic ancient Roman gladiatorial arena aklsgudş lıahseg oıadjkgb laıhsşfoıgh oıasoıdhu.",
      country: "France",
    ),
    // Diğer yerler eklenebilir
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yerler Listesi"),
        automaticallyImplyLeading: false,  // Geri butonunu kaldır
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          var place = places[index];
          return InkWell(
            onTap: () {
              String? placeId = place.id;
              Navigator.pushNamed(context, '/stationList', arguments: placeId);
            },
            child: StationItem(
              imagePath: place.imageUrl!,
              title: place.title!,
              details: place.details!,
              country: place.country!,
              onRemove: () => removePlace(index),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          onPressed: () {
            _showAddPlaceModal();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange, // Button background color
            foregroundColor: AppColors.navyBlue, // Text and icon color
          ),
          child: Text(
            'Seyahat Ekle',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );

  }

  void removePlace(int index) {
    setState(() {
      places.removeAt(index);
    });
  }

  void _addNewPlace(String title, String details, String country) {
      setState(() {
        places.add(PlaceData(
          id: DateTime.now().toString(),
          imageUrl: "https://source.unsplash.com/random/300x300?v=${places.length + 3}",
          title: title,
          details: details,
          country: country
        ));
      });
    }

    void _showAddPlaceModal() {
      showModalBottomSheet(
        context: context,
        builder: (_) => AddPlaceModal(addPlaceCallback: _addNewPlace),
      );
    }
  }
