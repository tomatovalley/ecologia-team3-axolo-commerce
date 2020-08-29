import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AdnPage extends StatelessWidget {
  const AdnPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TimelineTile(
      alignment: TimelineAlign.center,
      rightChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        color: Colors.lightGreenAccent,
      ),
      leftChild: Container(
        color: Colors.amberAccent,
      ),
    ));
  }
}
