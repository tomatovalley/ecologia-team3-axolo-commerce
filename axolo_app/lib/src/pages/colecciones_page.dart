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
              itemBuilder: (context, index) {
                final ScanModel producto = scans[index];
                return Dismissible(
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
                            Navigator.pushNamed(context, 'adn',
                                arguments: scans[index])
                          },
                      leading: FadeInImage(
                          image: NetworkImage(producto.imagen),
                          height: 20,
                          placeholder: AssetImage('assets/placeholder.png')),
                      title: Text(producto.producto,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ID: ${producto.uuid}'),
                        ],
                      )),
                );
              });
        }
      },
    );
  }
}
