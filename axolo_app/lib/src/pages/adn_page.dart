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
          Expanded(child: _crearTimeline()),
        ],
      ),
    );
  }

  Widget _header(ScanModel scan) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                      Text(scan.descripcion,
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

  Widget _crearTimeline() {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            rightChild: const _ParentInfo(
              asset: 'assets/delivery/order_placed.png',
              title: 'Estado actual',
              message: 'Este producto ahora está contigo',
            ),
            topLineStyle: const LineStyle(color: Colors.greenAccent),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            isFirst: false,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            rightChild: const _ParentInfo(
              asset: 'assets/delivery/order_placed.png',
              title: 'Antes',
              message: 'IAJSDIPAJS3232',
            ),
            topLineStyle: const LineStyle(color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }
}

class _ParentInfo extends StatelessWidget {
  const _ParentInfo({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: FadeInImage(
                placeholder: AssetImage('assets/placeholder.png'),
                height: 55,
                image: NetworkImage(
                    'https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14.jpg')),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
              ),
              const SizedBox(height: 6),
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
