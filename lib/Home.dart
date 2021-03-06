import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  _recuperarCep()async{

    String cepInserido = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepInserido}/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade} - ${uf}";
    });

    print(
      "CEP: ${cep}, Logradouro: ${logradouro}, Complemento: ${complemento}, Bairro: ${bairro}, Localidade: ${localidade}, Estado: ${uf}"
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
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Informe o CEP: ex:00000000",
                //labelStyle: TextStyle(color: Colors.black)
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
              controller: _controllerCep
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            ),
            Text(_resultado),
          ],
        ),
      ) ,
    );
  }
}