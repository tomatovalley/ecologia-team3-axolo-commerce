import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TiendaPage extends StatefulWidget {
  @override
  _TiendaPageState createState() => _TiendaPageState();
}

class _TiendaPageState extends State<TiendaPage> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: Stack(
          children: [
            Center(child: _loading ? CircularProgressIndicator() : SizedBox()),
            WebView(
              onPageFinished: (url) => setState(() {
                _loading = false;
              }),
              initialUrl: 'https://axolo-commerce.herokuapp.com/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ],
        ));
  }
}
