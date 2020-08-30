import 'package:axolo_app/src/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AdnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('🧬 ADN'),
      ),
      body: Column(
        children: <Widget>[
          _header(scan),
          Expanded(child: _crearTimeline(scan)),
        ],
      ),
    );
  }

  Widget _header(ScanModel scan) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FadeInImage(
                height: 200,
                placeholder: AssetImage('assets/placeholder.png'),
                image: NetworkImage(scan.imagen)),
            SizedBox(
              height: 10,
            ),
            Text(
              'UUID: ' + scan.uuid,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Producto',
                      ),
                      Text(scan.producto,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Fecha',
                      ),
                      Text("Hoy",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearTimeline(ScanModel scan) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            isFirst: true,
            indicatorStyle: IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            rightChild: _parentInfo(
              scan.imagen,
              'Estado actual',
              'Este producto ahora está contigo',
            ),
            topLineStyle: LineStyle(color: Colors.greenAccent),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            isFirst: false,
            indicatorStyle: IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            rightChild: _parentInfo(
              'assets/delivery/order_placed.png',
              'Antes',
              'IAJSDIPAJS3232',
            ),
            topLineStyle: LineStyle(color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }

  Widget _parentInfo(String asset, String title, String message) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: FadeInImage(
                placeholder: AssetImage('assets/placeholder.png'),
                height: 20,
                image: NetworkImage(asset)),
            opacity: 1,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6),
              Text(
                message,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
