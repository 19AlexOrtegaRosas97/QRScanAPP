import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qrapp/src/bloc/Scans_bloc.dart';
import 'package:qrapp/src/models/scan_model.dart';

import 'package:qrapp/src/pages/direcciones_page.dart';
import 'package:qrapp/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:qrapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int currentIndex=0;
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed:scansBloc.borrarScansTodos,
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_center_focus),
        onPressed:() => _scanQR(context),
      ),
    );
  }

  _scanQR(BuildContext context) async{

    //https://fernando-herrera.com
    //geo:40.73255860802501,-73.89333143671877

    //dynamic futureString ='https://aobio-993a6.firebaseapp.com/#/homeS';
    dynamic futureString;
    try {
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString=e.toString();
    }
 
    //print('Future String: ${futureString.rawContent}');

    if(futureString != null){
      final scan = ScanModel(valor:futureString.rawContent);
      scansBloc.agregarScan(scan);

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750),(){
          utils.abrirScan(context, scan);
        });
      }else{
        utils.abrirScan(context, scan);
      }
    }
  }

  Widget _crearBottonNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Map'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.computer),
          title: Text('Pages'),
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex=index;
        });
      },
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();

    }
  }
}
