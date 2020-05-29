import 'package:flutter/material.dart';
import 'package:qrapp/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final mapController = new MapController();
  String tipoMapa = 'mapbox/streets-v11';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: () {
              mapController.move(scan.getLatLng(), 15);
            }
          ),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante( BuildContext context){

    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        //streets-v11, dark-v10, light-v10, outdoors-v11, satellite-v9, satellite-streets-v11

        switch (tipoMapa) {
          case 'mapbox/streets-v11':
            tipoMapa='mapbox/dark-v10';
            break;
          case 'mapbox/dark-v10':
            tipoMapa='mapbox/light-v10';
            break;
          case 'mapbox/light-v10':
            tipoMapa='mapbox/outdoors-v11';
            break;
          case 'mapbox/outdoors-v11':
            tipoMapa='mapbox/satellite-v9';
            break;
          case 'mapbox/satellite-v9':
            tipoMapa='mapbox/satellite-streets-v11';
            break;
          case 'mapbox/satellite-streets-v11':
            tipoMapa = 'mapbox/streets-v11';
            break;
          default:
            tipoMapa='mapbox/dark-v10';
        }

        setState(() {});
      }
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      //maxNativeZoom: 18,
        urlTemplate: 'https://api.mapbox.com/styles/v1/'
            '{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken': 'pk.eyJ1IjoiMTlhbGV4OTciLCJhIjoiY2thcmJsbXhzMGY1ZDJ1bnRoanpkNDBrYyJ9.oydf1_ruY7puQSsZXUupBw',
          'id': tipoMapa,
          //streets-v11, dark-v10, light-v10, outdoors-v11, satellite-v9, satellite-streets-v11
        },
      );
  }

  _crearMarcadores(ScanModel scan){

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) =>Container(
            child: Icon(
              Icons.location_on, 
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        ),
      ]
    );
  }
}
