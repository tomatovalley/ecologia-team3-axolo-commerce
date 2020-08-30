import 'dart:convert';

import 'package:axolo_app/src/bloc/scans_bloc.dart';
import 'package:axolo_app/src/models/scan_model.dart';
import 'package:axolo_app/src/pages/colecciones_page.dart';
import 'package:axolo_app/src/pages/tienda_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    try {
      var result = await BarcodeScanner.scan(options: ScanOptions(strings: {}));
      futureString = result.rawContent;
    } catch (e) {
      futureString = e.toString();
    }
    if (futureString != null) {
      // hacer peticion http para obtener datos completos del QR
      final fetched = await _fetchProduct(futureString);
      print('fetched');
      print(fetched.uuid + ' | ' + fetched.producto);
      print(fetched.toJson());
      scansBloc.agregarScan(new ScanModel(
          descripcion: fetched.descripcion,
          imagen: fetched.imagen,
          producto: fetched.producto,
          uuid: fetched.uuid));
      //
      //final ScanModel scanModel = new ScanModel(valor: futureString);
      // scansBloc.agregarScan(scanModel);
    }
  }

  Future<ScanModel> _fetchProduct(String uuid) async {
    final response = await http
        .get('https://axolo-commerce.herokuapp.com/api/products/uuid/"$uuid"');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var productos = new List<ScanModel>();
      Iterable list = json.decode(response.body);
      productos = list.map((model) => ScanModel.fromJson(model)).toList();
      final producto = productos[0];
      return producto;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load acopios');
    }
  }

  Widget _callPage(int pagActual) {
    switch (pagActual) {
      case 0:
        return TiendaPage();
        break;
      case 1:
        //return Container();
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
