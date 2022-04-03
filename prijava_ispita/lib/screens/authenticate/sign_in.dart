import 'package:flutter/material.dart';
import 'package:prijava_ispita/screens/authenticate/register.dart';
import 'package:prijava_ispita/services/auth_service.dart';
import 'package:prijava_ispita/shared/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text('Prijava'),
        leading: appBarBanner,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                validator: (String? val) => val!.isEmpty ? 'Email ne moze biti prazan' : null,
                controller: emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: textImportDecoration.copyWith(hintText: 'Email')
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (String? val) => val!.length < 6 ? 'Sifra ne moze biti kraca od 6 karaktera' : null,
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: textImportDecoration.copyWith(hintText: 'Sifra')
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _authService.signIn(emailController.text, passwordController.text, context);
                    if(result == null) {
                      setState(() => error = 'ne radi ti ovo');
                    }
                  }
                },
                style: TextButton.styleFrom(primary: Colors.blue),
                child: const Text('Prijava', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Registration()));
                },
                child: const Text("Kreirajte novi nalog",
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline)),
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
