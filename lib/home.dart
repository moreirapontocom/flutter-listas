import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:listas/post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPosts() async {

    print("Recuperar posts");

    http.Response response = await http.get(urlBase + "/posts");
    var dadosJson = json.decode( response.body );

    List<Post> postagens = List();

    for (var item in dadosJson) {
      Post p = Post(item['userId'], item['id'], item['title'], item['body']);
      postagens.add(p);
    }

    return postagens;
  }

  Future _salvar() async {

    var _corpo = json.encode({
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    });

    http.Response response = await http.post(urlBase + "/posts", headers: {
        "Content-Type": "Application/json; charset=UTF-8"
      },
      body: _corpo
    );

    print("Resposta: " + response.statusCode.toString());
    print("Resposta: " + response.body);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sucesso"),
          content: Text("Dados salvos com sucesso"),
          actions: <Widget>[
            RaisedButton(
              child: Text("Ok", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listas"),
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("GET"),
                  onPressed: () {
                    setState(() => {}); // O setState aqui faz o loading aparecer sempre que clico pra atualizar
                    _recuperarPosts();
                  }
                ),
                RaisedButton(
                  child: Text("POST"),
                  onPressed: () {
                    setState(() => {});
                    _salvar();
                  },
                ),
                RaisedButton(
                  child: Text("PUT"),
                  onPressed: () => print("Atualizar"),
                ),
                RaisedButton(
                  child: Text("DELETE"),
                  onPressed: () => print("remover"),
                ),
              ],
            ),

            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPosts(),
                builder: (context, snapshot) {

                  switch ( snapshot.connectionState ) {
                    case ConnectionState.active :
                    case ConnectionState.none :
                    case ConnectionState.waiting :
                      return Center(child: CircularProgressIndicator());
                      break;

                    case ConnectionState.done :
                      if (snapshot.hasError) {
                        print("Erro ao carregar os dados: " + snapshot.error.toString());
                        return Center(child: Text("Erro"));
                      }

                    break;
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {

                      List<Post> lista = snapshot.data;
                      Post post = lista[index];

                      return ListTile(
                        title: Text( post.title ),
                        subtitle: Text( post.id.toString() ),
                        onTap: () {
                          
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Are you sure?"),
                                content: Text( post.title ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Ok", style: TextStyle(color: Colors.white),),
                                    color: Colors.blue,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            }
                          );

                        },
                      );

                    }
                  );

                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}