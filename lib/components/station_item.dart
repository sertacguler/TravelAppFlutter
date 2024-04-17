import 'package:flutter/material.dart';

class StationItem extends StatelessWidget {
  final String imagePath;  // Resim dosyasının yolu
  final String title;      // Durak adı
  final String details;    // Durak detayları
  final String country;    // Ülke adı
  final VoidCallback onRemove;  // Çıkarma işlemi için callback

  const StationItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.details,
    required this.country,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 120,  // Sabit yükseklik
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imagePath),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 3),
                Flexible(
                  child: Text(
                    details,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      country,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    CustomDeleteButton(onRemove: onRemove),
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

class CustomDeleteButton extends StatelessWidget {
  final VoidCallback onRemove;

  const CustomDeleteButton({Key? key, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRemove,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}