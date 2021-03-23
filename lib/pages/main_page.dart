import 'package:filterair/pages/akun_page.dart';
import 'package:filterair/pages/diagnosis_page.dart';
import 'package:filterair/pages/info_page.dart';
import 'package:filterair/pages/diskusi_page.dart';
import 'package:filterair/pages/kontrol_page.dart';
import 'package:filterair/services/fade_transition.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:filterair/services/auth_services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Utama'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "selamat datang di halaman utama\n\n aplikasi filter air desa way belau"),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
                icon: Icons.visibility,
                text: 'Diagnosis',
                onTap: () {
                  _pushPage(context, Diagnosis());
                }),
            _createDrawerItem(
                icon: Icons.construction_rounded,
                text: 'Kontrol',
                onTap: () {
                  _pushPage(context, Kontrol());
                }),
            _createDrawerItem(
                icon: Icons.chat,
                text: 'Diskusi',
                onTap: () {
                  _pushPage(context, Diskusi());
                }),
            _createDrawerItem(
                icon: Icons.info,
                text: 'Info Project',
                onTap: () {
                  _pushPage(context, Info());
                }),
            _createDrawerItem(
                icon: Icons.person,
                text: 'Akun Saya',
                onTap: () {
                  _pushPage(context, Akun());
                }),
            Divider(),
            _createDrawerItem(
                icon: Icons.outbox,
                text: 'Keluar Akun',
                onTap: () {
                  context.read<AuthServices>().signOut();
                })
          ],
        ),
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Center(
          child: Text(
        'Menu Utama',
        style: TextStyle(fontSize: 30),
      )),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).pop();
  Navigator.push(context, FadeRoute(page: page));
}
