import 'package:axolo_app/src/bloc/scans_bloc.dart';
import 'package:axolo_app/src/models/scan_model.dart';
import 'package:flutter/material.dart';

class ColeccionPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      // initialData: [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(child: Text('No has añadido productos a tu colección'));
        } else {
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (direction) {
                scansBloc.borrarScan(scans[index].uuid);
              },
              background: Container(
                  color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_sweep, color: Colors.white),
                          Text(
                            'Borrar',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  )),
              key: UniqueKey(),
              child: ListTile(
                onTap: () => {
                  // scans[index]
                },
                leading:
                    Icon(Icons.cloud, color: Theme.of(context).primaryColor),
                title: Text(scans[index].producto),
                trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                subtitle: Text('ID: ${scans[index].uuid}'),
              ),
            ),
          );
        }
      },
    );
  }
}
