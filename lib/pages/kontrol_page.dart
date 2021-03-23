// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Kontrol extends StatefulWidget {
  Kontrol({this.app});
  final FirebaseApp app;

  @override
  _KontrolState createState() => _KontrolState();
}

class _KontrolState extends State<Kontrol> {
  int _counter;
  DatabaseReference _counterRef;
  StreamSubscription<Event> _counterSubscription;

  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    _counterRef = FirebaseDatabase.instance.reference().child('counter');

    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
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
    _counterSubscription.cancel();
  }

  Future<void> _increment() async {
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontrol Alat'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: _error == null
                  ? Text(
                      'Button tapped $_counter time${_counter == 1 ? '' : 's'}.\n\n'
                      'This includes all devices, ever.',
                    )
                  : Text(
                      'Error retrieving button tap count:\n${_error.message}',
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
