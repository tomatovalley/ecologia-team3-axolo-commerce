import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TiendaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: WebView(
        initialUrl: 'https://axolo-commerce.herokuapp.com/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
