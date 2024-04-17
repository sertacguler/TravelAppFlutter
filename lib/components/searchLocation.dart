import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../info/stationData.dart';

Future<StationData?> searchLocation(String query) async {
  final String apiUrl = 
  'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=pk.eyJ1Ijoic2VydGFjZyIsImEiOiJjbHV5ZnE2MjEwMnlkMmluazh0N2l6YnBnIn0.Qw2_nm9QqmOjqiTsIA_J3Q';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // Handle the JSON data returned from Mapbox
      print(data);
      // For example, extract coordinates from the first result
      if (data['features'] != null && data['features'].isNotEmpty) {
        String name = data['features'][0]['text'].toString();
        double longitude = data['features'][0]['center'][0];
        double latitude = data['features'][0]['center'][1];
        // Use these coordinates as needed in your app
        return StationData(id: DateTime.now().toString(), title:name, imageUrl: "", lng:longitude, lat:latitude, type: 'default', details: "");
      } return null;  // Return null if no features found
    } else {
      throw Exception('Failed to load location data');
    }
  } catch (e) {
    print('Error making API call: $e');
     return null;  // Return null in case of errors
  }
}