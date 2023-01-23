import 'dart:io';

import 'package:bio_if/postagem.dart';
import 'package:bio_if/sobre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'ajuda.dart';

class Especies extends StatefulWidget {
  const Especies({super.key});

  @override
  State<Especies> createState() => _EspeciesState();
}

class _EspeciesState extends State<Especies> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  String? _campoSelecionado = "";
  String _resultado = "";
  XFile? _arquivoImagem;
  String? dataHora = DateTime.now().toString();
  var db = FirebaseFirestore.instance;
  String? _urlImagem = null;
  String? _status = "*";
  int? contagem = 0;

  Future _capturaFoto(bool daCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? imagem;

    if (daCamera) {
      imagem = await picker.pickImage(source: ImageSource.camera);
    } else {
      imagem = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _arquivoImagem = imagem;
    });
  }

  void _selecao() {
    if (_campoSelecionado == "") {
      setState(() {
        _resultado = "Não Informado";
      });
    } else if (_campoSelecionado == 'P') {
      setState(() {
        _resultado = "Planta";
      });
    } else {
      setState(() {
        _resultado = "Animal";
      });
    }
  }

  Future _postagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child("fotos")
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    UploadTask task = arquivo.putFile(File(_arquivoImagem!.path));

    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
        setState(() {
          _status = "Realizando postagem";
        });
      } else if (taskSnapshot.state == TaskState.success) {
        _recuperarImagem(taskSnapshot);
        setState(() {
          _status = "Postagem realizada com sucesso";
        });
      }
    });
  }

  Future _recuperarImagem(TaskSnapshot taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    print("URL: $url");

    setState(() {
      _urlImagem = url;
    });

    _selecao();

    Postagem postagem = Postagem(
        nome: _controllerNome.text,
        descricao: _controllerDescricao.text,
        tipo: _resultado,
        dataHora: dataHora,
        foto: _urlImagem,
        like: contagem,
        dislike: contagem);

    db.collection("Postagem").add(postagem.toMap());
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
        backgroundColor: Colors.amber[800],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Cadastro de Espécies",style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Digite o Nome Popular",
                  border: OutlineInputBorder(),
                ),
                controller: _controllerNome,
              ),
              Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Deixe uma Descrição",
                  border: OutlineInputBorder(),
                ),
                controller: _controllerDescricao,
              ),
              Padding(padding: EdgeInsets.all(10)),
              //Row(children: [
                const Divider(
                height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Color.fromARGB(255, 255, 145, 0),
              ),
              Padding(padding: EdgeInsets.all(10)),
              const Text("Tipo da Espécie:",style: TextStyle(fontSize: 20),),
              RadioListTile(
                  title: const Text("Planta",style: TextStyle(fontSize: 18),),
                  value: "P",
                  groupValue: _campoSelecionado,
                  onChanged: (String? resultado) {
                    setState(() {
                      _campoSelecionado = resultado;
                    });
                  }),
              RadioListTile(
                  title: const Text("Animal",style: TextStyle(fontSize: 18),),
                  value: "A",
                  groupValue: _campoSelecionado,
                  onChanged: (String? resultado) {
                    setState(() {
                      _campoSelecionado = resultado;
                    });
                  }),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Color.fromARGB(255, 255, 145, 0),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
              const Text("Tire uma Foto para deixarmos registrado:",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              _arquivoImagem != null
                  ? Image.file(
                      File(_arquivoImagem!.path),
                      fit: BoxFit.cover,
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.folder_outlined),
                    onPressed: () {
                      _capturaFoto(false);
                    },
                    iconSize: 40,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      _capturaFoto(true);
                    },
                    iconSize: 40,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(25)),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _postagem();
                  },
                  icon: const Icon(Icons.check),
                  style: buttonStyle,
                  label: const Text('Cadastrar Espécie',style: TextStyle(color: Colors.black)),
                ),
              ),
              Text(_status!),
            ],
          ),
        ),
      ),
    );
  }
}
