import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../info/stationData.dart';
import '../components/theme.dart';

class BottomDetailWidget extends StatelessWidget {
  final StationData stationData;
  final VoidCallback onClose;

  const BottomDetailWidget({
    Key? key,
    required this.stationData,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // Ekranın %90 genişliğinde
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05, // Her iki yandan %5 boşluk
        vertical: 20, // Üstten ve alttan 20 piksel boşluk
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.90),
        borderRadius: BorderRadius.all(Radius.circular(40)), // Kenarları yuvarlatılmış
      ),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.navyBlue, size: 35), // Marker iconu
                    SizedBox(width: 10), // Icon ve metin arası boşluk
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${stationData.title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("${stationData.details}"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Konum: ${stationData.lng.toStringAsFixed(6)}, ${stationData.lat.toStringAsFixed(6)}"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        foregroundColor: AppColors.navyBlue,
                      ),
                      onPressed: onClose,
                      child: Text('Close'),
                    ),
                    IconButton(
                      icon: Icon(Icons.qr_code, color: AppColors.navyBlue, size: 30),
                      onPressed: () {
                        // QR kod ile yapılacak işlem buraya yazılabilir
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}