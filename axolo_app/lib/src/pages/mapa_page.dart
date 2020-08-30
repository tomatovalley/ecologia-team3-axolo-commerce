import 'dart:convert';

import 'package:axolo_app/src/models/acopio_model.dart';
import 'package:axolo_app/src/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driving_directions/flutter_driving_directions.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Future<List<AcopioModel>> futureAcopio;
  final map = new MapController();
  String tipoMapa = 'light';
  @override
  void initState() {
    super.initState();
    futureAcopio = _fetchAcopios();
  }

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.my_location),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () async {
        final pos = await _obtenerUbicacion();
        map.move(pos, 14);
      },
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FutureBuilder<List<AcopioModel>>(
      future: futureAcopio,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return Text(snapshot.data);
          print('ahuevo');
          return FlutterMap(
            mapController: map,
            options: MapOptions(zoom: 9),
            layers: [_crearMapa(), _crearMarcadores(snapshot.data.toList())],
          );
        } else if (snapshot.hasError) {
          print("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<AcopioModel>> _fetchAcopios() async {
    final response =
        await http.get('https://axolo-commerce.herokuapp.com/acopios/');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var acopios = new List<AcopioModel>();
      Iterable list = json.decode(response.body);
      acopios = list.map((model) => AcopioModel.fromJson(model)).toList();
      return acopios;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load acopios');
    }
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
          'id': 'mapbox.$tipoMapa'
          // streets, dark, light, outdoors, satellite
        });
  }

  Future<LatLng> _obtenerUbicacion() async {
    final location = await geo.Geolocator()
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    return LatLng(location.latitude, location.longitude);
  }

  _crearMarcadores(List<AcopioModel> acopios) {
    List<Marker> marcadores = acopios
        .toList()
        .map((acopio) => Marker(
              width: 180.0,
              height: 180.0,
              point: LatLng(acopio.lat, acopio.lng),
              builder: (context) => Container(
                  child: Column(
                children: [
                  Text(acopio.name),
                  SizedBox(height: 20),
                  InkWell(
                      onTap: () async {
                        try {
                          await FlutterDrivingDirections.launchDirections(
                              latitude: acopio.lat,
                              longitude: acopio.lng,
                              address: '');
                        } on PlatformException {
                          debugPrint('Failed to launch directions.');
                        }
                      },
                      child: Icon(
                        Icons.location_on,
                        size: 70.0,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              )),
            ))
        .toList();
    return MarkerLayerOptions(markers: marcadores);
  }
}
