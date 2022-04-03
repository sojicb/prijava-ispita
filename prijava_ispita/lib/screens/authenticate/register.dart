import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/user.dart';
import 'package:prijava_ispita/services/auth_service.dart';
import 'package:prijava_ispita/shared/constants.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  final AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text('Registracija'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (String? val) => val!.isEmpty ? 'Ime ne moze biti prazno' : null,
                controller: nameController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                decoration: textImportDecoration.copyWith(hintText: 'Ime')
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (String? val) => val!.isEmpty ? 'Prezime ne moze biti prazno' : null,
                controller: lastNameController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                decoration: textImportDecoration.copyWith(hintText: 'Prezime')
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (String? val) => val!.isEmpty ? 'Email ne moze biti prazan' : null,
                controller: emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: textImportDecoration.copyWith(hintText: 'Email')
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (String? val) => val!.length < 6 ? 'Sifra ne moze imati manje od 6 karatkera' : null,
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: textImportDecoration.copyWith(hintText: 'Sifra')
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (String? val) => val == passwordController.text ? null : 'Sifre se ne pokalapaju!',
                controller: rePasswordController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: textImportDecoration.copyWith(hintText: 'Ponovi Sifru')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _authService.register(emailController.text, passwordController.text,
                        AppUser(null, null, nameController.text, lastNameController.text, null, null));
                    Navigator.pop(context);
                    if(result == null) {
                      setState(() => error = 'Doslo je do greske!');
                    }
                  }
                },
                style: TextButton.styleFrom(
                    primary: Colors.blue
                ),
                child: const Text(
                  'Registracija',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                error!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
