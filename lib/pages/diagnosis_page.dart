import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Diagnosis extends StatefulWidget {
  Diagnosis({this.app});
  final FirebaseApp app;

  @override
  _DiagnosisState createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  int _tinggiair;
  int _suhuair;

  DatabaseReference _tinggiairRef;
  DatabaseReference _suhuairRef;

  StreamSubscription<Event> _tinggiairSubscription;
  StreamSubscription<Event> _suhuairSubscription;

  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    _tinggiairRef = FirebaseDatabase.instance.reference().child('tinggiair');
    _suhuairRef = FirebaseDatabase.instance.reference().child('suhuair');

    _tinggiairRef.keepSynced(true);
    _suhuairRef.keepSynced(true);

    _tinggiairSubscription = _tinggiairRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _tinggiair = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });

    _suhuairSubscription = _suhuairRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _suhuair = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tinggiairSubscription.cancel();
    _suhuairSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Alat'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: _error == null
                  ? Text('tinggi air : $_tinggiair \n\n')
                  : Text(
                      'error membaca nilai tinggi air karena :\n${_error.message}',
                    ),
            ),
          ),
          Flexible(
            child: Center(
              child: _error == null
                  ? Text('suhu air : $_suhuair \n\n')
                  : Text(
                      'error membaca nilai suhu air karena :\n${_error.message}',
                    ),
            ),
          ),
          SfRadialGauge(
              title: GaugeTitle(
                  text: 'Speedometer',
                  textStyle: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              axes: <RadialAxis>[
                RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 50,
                      color: Colors.green,
                      startWidth: 10,
                      endWidth: 10),
                  GaugeRange(
                      startValue: 50,
                      endValue: 100,
                      color: Colors.orange,
                      startWidth: 10,
                      endWidth: 10),
                  GaugeRange(
                      startValue: 100,
                      endValue: 150,
                      color: Colors.red,
                      startWidth: 10,
                      endWidth: 10)
                ], pointers: <GaugePointer>[
                  NeedlePointer(
                      value: _suhuair.toDouble(),
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                          child: const Text('90.0',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold))),
                      angle: 90,
                      positionFactor: 0.5)
                ])
              ])
        ],
      ),
    );
  }
}
