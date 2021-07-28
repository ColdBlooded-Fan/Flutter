import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/plugin/MessageManager.dart';
import 'package:flutter_trip/widget/seach_bar.dart';





class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SearchBar(
            hideLeft: true,
            defaultText: "哈哈哈哈",
            hint: "this is",
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          )
        ],
      ),
    );
  }

  _onTextChanged(text) {

  }

  _Click() {
    print("click this");
    const object = {
      "message":"this is a flutter data"
    };
    MessageManager.openNewNativePage(object);
  }
}
