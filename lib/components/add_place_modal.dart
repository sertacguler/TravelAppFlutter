import 'package:flutter/material.dart';
import '../components/theme.dart';

class AddPlaceModal extends StatefulWidget {
  final Function addPlaceCallback;

  AddPlaceModal({required this.addPlaceCallback});

  @override
  _AddPlaceModalState createState() => _AddPlaceModalState();
}

class _AddPlaceModalState extends State<AddPlaceModal> {
  String title = '';
  String details = '';
  String country = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 24, color: AppColors.navyBlue),
              ),
            ),
          ),
          TextField(
            onChanged: (value) => title = value,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            onChanged: (value) => details = value,
            decoration: InputDecoration(labelText: 'Details'),
          ),
          TextField(
            onChanged: (value) => country = value,
            decoration: InputDecoration(labelText: 'Country'),
          ),
          SizedBox(height: 10), // Burada 20 piksel yükseklikte boşluk ekleniyor
          ElevatedButton(
            onPressed: () {
              widget.addPlaceCallback(title, details, country);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              foregroundColor: AppColors.navyBlue,
            ),
            child: Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}
