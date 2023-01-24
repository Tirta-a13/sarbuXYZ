import 'package:flutter/material.dart';

import 'package:sarbu/controller/auth_controller.dart';
import 'package:sarbu/helper/widget/text_field.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  String? pass;

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      AuthController().login(_email.text, _password.text);
      AuthController().check(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/applogo.png',
                      scale: 2.5,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "UMKM XYZ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInputFields(
                        controller: _email,
                        labelText: 'Email',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Mohon Masukan Email Valid';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Mohon Masukan Email Valid';
                          }
                          return null;
                        },
                        icon: Icons.email),
                    const SizedBox(
                      height: 25,
                    ),
                    TextInputFields(
                      controller: _password,
                      labelText: 'Password',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Password';
                        }
                        if (value.trim().length < 8) {
                          return 'Password  harus 8 karakter';
                        }
                        // Return null if the entered password is valid
                        pass = value;
                        return null;
                      },
                      icon: Icons.key,
                      isObscure: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () => _trySubmitForm(),
                          child: const Text('Login')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
