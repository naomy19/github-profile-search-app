import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController usuarioController = TextEditingController();
  String info_usuario = '';
  String info_avatar = 'https://icones.pro/wp-content/uploads/2021/06/icone-github-grise.png';

  _recuperarUsuario() async {
    String url = 'https://api.github.com/users/${usuarioController.text}';

    print(url);

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String foto = retorno["avatar_url"];
    double id = retorno["id"];
    String nome = retorno["name"];
    double repositorios = retorno["public_repos"];
    String criado_em = retorno["created_at"];
    double seguidores = retorno["followers"];
    double seguindo = retorno["following"];

    setState(() {
      info_avatar = foto;
      info_usuario = 'ID: $id \n Nome: $nome \n Repositórios: $repositorios \n Criado em: $criado_em \n Seguidores: $seguidores \n Seguindo: $seguindo';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        title: Text("Perfil dos Devs", style: TextStyle(fontSize: 25.0)),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _foto(),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Digite o login do GitHub", labelStyle: TextStyle(color: Colors.purple.shade200)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.purple.shade400, fontSize: 25.0),
              controller: usuarioController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: _recuperarUsuario,
                  child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: Colors.purple.shade300,
                ),
              ),
            ),
            Text(info_usuario, style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 20.0)),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.0),
            //   child: Container(
            //     child: Text(info_usuario, style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 20.0)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _foto() {
    return Expanded(
      child: Image.network(info_avatar),
    );
  }
}
