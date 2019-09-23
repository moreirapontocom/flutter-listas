import 'dart:developer';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _comidas = ["Nutella","mousse de chocolate","Sorvete","Açaí","Bag Burger - Easy Cheese","Outback","Pizza Pepperoni","Chocolate","Burger King","McDonalds","Lasanha","Nhoque","Duke n Duke"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listas"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _comidas.length,
          itemBuilder: (context, indice) {

            return ListTile(
              title: Text("Indice " + _comidas[indice]),
              subtitle: Text("Comidas que eu adoro"),
            );

          },
        ),
      ),
    );
  }
}