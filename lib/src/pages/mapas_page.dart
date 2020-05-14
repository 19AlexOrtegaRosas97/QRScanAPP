import 'package:flutter/material.dart';
import 'package:qrapp/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getTodosScans(),
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
          onDismissed: (direction)=> DBProvider.db.deleteScan(scans[i].id),
            key: UniqueKey(),
            background: Container(color: Colors.red),
            child: ListTile(
              leading: Icon(Icons.cloud_queue,color: Theme.of(context).primaryColor,),
              title: Text(scans[i].valor),
              subtitle: Text('ID:'+scans[i].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            ),
          )
        );
      },
    );
  }
}