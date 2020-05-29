import 'package:flutter/material.dart';

import 'package:qrapp/src/pages/home_page.dart';
import 'package:qrapp/src/pages/mapa_page.dart';
import 'package:qrapp/src/pages/mapas_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'mapas' : (BuildContext context) => MapasPage(),
        'mapa' : (BuildContext context) => MapaPage()
      },
      theme: ThemeData(
        primaryColor: Colors.red[300]
      ),
    );
  }
}