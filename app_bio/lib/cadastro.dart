import 'package:bio_if/home.dart';
import 'package:bio_if/postagem.dart';
import 'package:bio_if/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//cadastro dos usuarios
class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  var db = FirebaseFirestore.instance;
  String? _status = " ";

  Future _cadastrarUsuario() async {
    var auth = FirebaseAuth.instance;
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    try {
      var usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      print(
          "usuario criado com sucesso: ID: ${usuario.user!.uid} - Email ${usuario.user!.email}");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      setState(() {
        _status = "Usuário criado com sucesso!!";
      });
      Usuario user = Usuario(
          id: usuario.user!.uid, nome: nome, email: email, senha: senha);
      db.collection("Usuario").doc(usuario.user!.uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        setState(() {
          _status = "Email ja em uso!!";
        });
      } else if (e.code == "weak-password") {
        setState(() {
          _status = "Senha fraca, escolha uma senha mais dificil!!";
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

   final buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(18),
    shadowColor: Colors.amber[800]
  );

   final outrobuttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(18),
    shadowColor: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Cadastro"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          ElevatedButton.icon(
            onPressed: (){}, 
            icon: Icon(Icons.account_circle_rounded,size: 70,), 
            label:Text(''),
            style: outrobuttonStyle,
          ),

          Padding(padding: EdgeInsets.all(13)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Nome",
              border: OutlineInputBorder(),
            ),
            controller: _controllerNome,
          ),
          Padding(padding: EdgeInsets.all(13)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
            controller: _controllerEmail,
          ),
          Padding(padding: EdgeInsets.all(13)),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Senha",
              border: OutlineInputBorder(),
            ),
            controller: _controllerSenha,
          ),
          Padding(padding: EdgeInsets.all(13)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: buttonStyle,
              icon: const Icon(Icons.add_box_outlined),
              onPressed: _cadastrarUsuario,
              label: const Text('Cadastrar',style: TextStyle(color: Colors.black)),
            ),
          ),
          Text(_status!),
        ]),
      )),
    );
  }
}
