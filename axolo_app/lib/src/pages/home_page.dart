import 'package:axolo_app/src/bloc/scans_bloc.dart';
import 'package:axolo_app/src/models/scan_model.dart';
import 'package:axolo_app/src/pages/colecciones_page.dart';
import 'package:axolo_app/src/pages/tienda_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

import 'mapa_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      appBar: AppBar(
        title: Text('🌱 Axolo Commerce'),
        actions: <Widget>[
          IconButton(
              onPressed: () => _scanQR(context),
              icon: Icon(Icons.filter_center_focus))
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  void _scanQR(BuildContext context) async {
    String futureString = '';
    print('Scanning QR...');
    // geo:40.73255860802501,-73.89333143671877
    scansBloc.agregarScan(new ScanModel(
        uuid: '23ikiomomsdad',
        descripcion: 'Bla bla bla',
        fecha: '8/29/20',
        imagen: '',
        producto: 'Papel'));
    try {
      var result = await BarcodeScanner.scan(options: ScanOptions(strings: {}));
      futureString = result.rawContent;
    } catch (e) {
      futureString = e.toString();
    }
    if (futureString != null) {
      // hacer peticion http para obtener datos completos del QR

      //
      //final ScanModel scanModel = new ScanModel(valor: futureString);
      // scansBloc.agregarScan(scanModel);
    }
  }

  Widget _callPage(int pagActual) {
    switch (pagActual) {
      case 0:
        return TiendaPage();
        break;
      case 1:
        return ColeccionPage();
        break;
      default:
        return MapaPage();
    }
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 10.0,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            title: Text('Tienda'), icon: Icon(Icons.local_grocery_store)),
        BottomNavigationBarItem(
            title: Text('Colección'), icon: Icon(Icons.bookmark_border)),
        BottomNavigationBarItem(title: Text('Mapa'), icon: Icon(Icons.map)),
      ],
    );
  }
}
