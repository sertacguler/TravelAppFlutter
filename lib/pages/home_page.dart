import 'package:flutter/material.dart';
import 'place_list_page.dart'; // PlaceListPage'ı import ediyoruz.

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaceListPage(); // Artık ana ekran olarak PlaceListPage'ı kullanıyoruz.
  }
}
