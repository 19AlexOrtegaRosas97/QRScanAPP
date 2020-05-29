import 'package:flutter/material.dart';
import 'package:qrapp/src/bloc/Scans_bloc.dart';
import 'package:qrapp/src/models/scan_model.dart';
import 'package:qrapp/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if(scans.length == 0){
          return Center(child: Text('No hay datos'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context,i) => Dismissible(
          onDismissed: (direction)=> scansBloc.borrarScan(scans[i].id),
            key: UniqueKey(),
            background: Container(color: Colors.red),
            child: ListTile(
              leading: Icon(Icons.computer,color: Theme.of(context).primaryColor,),
              title: Text(scans[i].valor),
              subtitle: Text('ID:'+scans[i].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
              onTap: (){
                utils.abrirScan(context,scans[i]);
              },
            ),
          )
        );
      },
    );
  }
}