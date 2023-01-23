import 'package:bio_if/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String? _status = "";

  Future _Login() async {
    var auth = FirebaseAuth.instance;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    try {
      var usuario =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      setState(() {
        _status = "Login realizado com sucesso";
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  final buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(18),
    shadowColor: Colors.amber[800]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login",style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.amber[800],
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(20)),
                Text("",style: TextStyle(fontSize: 22),),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  controller: _controllerEmail,
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Senha",
                  ),
                  controller: _controllerSenha,
                ),
                Padding(padding: EdgeInsets.all(20)),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    style: buttonStyle,
                    icon: const Icon(Icons.check),
                    onPressed: _Login, 
                    label: const Text('Entrar',style: TextStyle(color: Colors.black)),
                  ),
                ),
                Text(_status!),
              ],
            ),
          ),
        ));
  }
}
