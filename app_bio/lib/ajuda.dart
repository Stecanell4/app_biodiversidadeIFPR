import 'package:flutter/material.dart';

//instruçoes do app

class Ajuda extends StatefulWidget {
  const Ajuda({super.key});

  @override
  State<Ajuda> createState() => _AjudaState();
}

   final buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(18),
    shadowColor: Colors.amber[800]
  );

class _AjudaState extends State<Ajuda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Ajuda",style: TextStyle(color: Colors.white),),
      ),
      body:SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        
        child: Column(children: [
          Text("Caso tenha alguma duvida ou sugestão, pode deixar um comentário que responderemos o mais breve possivel",style: TextStyle(fontSize: 20),textAlign:TextAlign.center,),
                    Padding(padding: EdgeInsets.all(13)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Nome",
              border: OutlineInputBorder(),
            ),
          ),
          Padding(padding: EdgeInsets.all(13)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          Padding(padding: EdgeInsets.all(13)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Comentário",
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
          ),
          Padding(padding: EdgeInsets.all(13)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: buttonStyle,
              icon: const Icon(Icons.add_task_outlined),
              onPressed: (){},
              label: const Text('Enviar',style: TextStyle(color: Colors.black)),
            ),
          ),
        ]),
          ),
    ),
    );
  }
}
