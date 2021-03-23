import 'package:filterair/pages/login_daftar/register_page.dart';
import 'package:filterair/services/fade_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:filterair/services/auth_services.dart';

class Masuk extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Login'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: Text("Silahkan Masuk Dengan Akun Filter Air Desa"),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthServices>().signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                        child: Text("Masuk"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text('Atau Login Menggunakan Google'),
              ),
              Container(
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () {
                    context.read<AuthServices>().signInWithGoogle();
                  },
                  text: 'Masuk dengan Google',
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Anda Belum Punya Akun?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, FadeRoute(page: Daftar()));
                        },
                        child: Text("Daftar"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
