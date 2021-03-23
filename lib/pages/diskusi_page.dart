import 'package:flutter/material.dart';

class Diskusi extends StatefulWidget {
  @override
  _DiskusiState createState() => _DiskusiState();
}

class _DiskusiState extends State<Diskusi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diskusi"),
        centerTitle: true,
      ),
    );
  }
}
