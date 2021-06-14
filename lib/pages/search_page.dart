import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/plugin/MessageManager.dart';





class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Text("HELLO"),

        onTap: (){
          this._Click();
        },
      ),
    );
  }

  _Click() {
    print("click this");
    const object = {
      "message":"this is a flutter data"
    };
    MessageManager.openNewNativePage(object);
  }
}
