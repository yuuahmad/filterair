import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:filterair/pages/login_daftar/login_page.dart';
import 'package:filterair/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'services/auth_services.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (_) => AuthServices(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthServices>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Filter Air Way Belau',
        theme: ThemeData.dark(),
        home: PenentuAuth(),
      ),
    );
  }
}

class PenentuAuth extends StatelessWidget {
  const PenentuAuth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Home();
    }
    return Masuk();
  }
}
