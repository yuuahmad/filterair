import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:filterair/services/auth_services.dart';

class Daftar extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Daftar'),
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
                      child: Text("Silahkan Daftar Akun Filter Air Desa"),
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
                          context.read<AuthServices>().signUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                        child: Text("Daftar"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text('Atau Daftar Menggunakan Google'),
              ),
              Container(
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () {
                    context.read<AuthServices>().signInWithGoogle();
                  },
                  text: 'Daftar dengan Google',
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Anda Sudah Punya Akun Filter Air Desa?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Login"))
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
