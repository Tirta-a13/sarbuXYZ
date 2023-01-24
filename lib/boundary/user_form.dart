import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/helper/widget/text_field.dart';

import '../controller/user_controller.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  final UserController usercontroller = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      Map<String, dynamic> map = {
        'email': _email.text,
        'nama': _nama.text,
        'telepon': _telepon.text,
        'password': _password.text,
        'role': 'SPB'
      };

      usercontroller.addUser(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah SPB'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInputFields(
                      controller: _email,
                      labelText: 'email',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Email Valid';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Mohon Masukan Email Valid';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _nama,
                      labelText: 'nama',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Nama';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _telepon,
                      labelText: 'Telepon',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Telepon';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
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
                      return null;
                    },
                    icon: Icons.data_array,
                    isObscure: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _confirmpass,
                      labelText: 'Konfirmasi Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi Password Tidak Sama';
                        }

                        if (value != _password.text) {
                          return 'Konfirmasi Password Tidak Sama';
                        }
                        // Return null if the entered password is valid

                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () => _trySubmitForm(),
                        child: const Text('Simpan')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
