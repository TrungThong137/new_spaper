
import 'package:flutter/material.dart';
import 'package:new_spaper/diaglog.dart/loading_diaglog.dart';
import 'package:new_spaper/diaglog.dart/msg_diaglog.dart';
import 'package:new_spaper/firebase/firebase_auth.dart';
import 'package:new_spaper/pages/newspaer.dart';
import 'package:new_spaper/pages/register.dart';
import 'package:new_spaper/widgets/button_page.dart';
import 'package:new_spaper/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FireAuth _fireAuth= FireAuth();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/logoNewSpaper.png',
                  color: Colors.black,
                  width: 200,
                ),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(height: 50),
                const Text(
                  "Login to Your Account",
                ),
                const SizedBox(height: 30),
                TextFieldPage(
                    controller: _emailController,
                    text: 'Email',
                    icon: const Icon(
                      Icons.mail_outline,
                      color: Colors.black26,
                    ),
                  ),
                TextFieldPage(
                    controller: _passController,
                    text: 'Password',
                    obscureText: true,
                    icon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.black26,
                )),
                const SizedBox(height: 20),
                ButtonPage(
                  onTap: _onLoginClick,
                  text: 'Sign In',
                  color: Colors.black,
                  colortext: Colors.white,
                  width: double.maxFinite,
                  height: 50,
                ),
              
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();

    LoadingDiaglog.showLoadingDialog(context, 'loading...');
    _fireAuth.signIn(_emailController.text.trim(), _passController.text.trim(),
        () {
      LoadingDiaglog.hideLoadingDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NewSpaperPage()));
    }, (msg) {
      LoadingDiaglog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, 'Error', msg);
    });
  }
}
