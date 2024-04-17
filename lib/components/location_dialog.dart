import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../info/locationData.dart';

class LocationDialog extends StatefulWidget {
  final LatLng position;

  const LocationDialog({Key? key, required this.position}) : super(key: key);

  @override
  _LocationDialogState createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String selectedMarkerType = 'Default';
  List<String> markerTypes = ['Default', 'Restaurant', 'Hotel', 'Park'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Yeni Konum Ekle", style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Enlem: ${widget.position.latitude}, Boylam: ${widget.position.longitude}", style: GoogleFonts.nunito(fontSize: 16)),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Yer adı giriniz",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.place),
                labelStyle: GoogleFonts.nunito(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: "Yorumunuzu giriniz",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.comment),
                labelStyle: GoogleFonts.nunito(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Marker Tipi Seçin",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
              value: selectedMarkerType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMarkerType = newValue!;
                });
              },
              items: markerTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.nunito()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('İptal', style: GoogleFonts.nunito(color: Colors.red)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Kaydet', style: GoogleFonts.nunito(color: Colors.green)),
          onPressed: () {
            if (nameController.text.isNotEmpty) {
               LocationData result = LocationData(
                name: nameController.text,
                comment: commentController.text,
                markerType: selectedMarkerType,
              );
              Navigator.of(context).pop(result);
            }
          },
        ),
      ],
    );
  }
}
