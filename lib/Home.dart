import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "Resultado";

  _recuperarCep()async{

    //String cep = "01001000";
    String url = "https://viacep.com.br/ws/01001000/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });

    print(
      "CEP: ${cep}, Logradouro: ${logradouro}, Complemento: ${complemento}, Bairro: ${bairro}, Localidade: ${localidade} "
    );

    //print(response.statusCode.toString());
    //print(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ) ,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Text(_resultado),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            )
          ],
        ),
      ) ,
    );
  }
}