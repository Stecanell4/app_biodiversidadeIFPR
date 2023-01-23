import 'package:flutter/material.dart';

//informaçoes do app (desenvolvedores...)
class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Sobre o Aplicativo",style: TextStyle(color: Colors.white),),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
        Image.asset('imagens/home.png'),

        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("O Aplicativo tem o intuito de cadastrar e informar a biodiversidade do Campus IFPR Palmas.",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
          ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Este projeto foi desenvolvido por Julio Stecanella e Peterson Procópio, no 6° Semestre do curso de Sistemas de Informação",style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
          
          )
        ]
      ),
    );
  }
}
