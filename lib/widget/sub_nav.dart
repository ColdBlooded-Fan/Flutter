import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/web/web_view.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> sublNavList;

  const SubNav({Key key, @required this.sublNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Padding(padding: EdgeInsets.all(7), child: _items(context)),
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          child: Column(
            children: [
              Image.network(
                model.icon,
                height: 18,
                width: 18,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebView(
                          url: model.url,
                          statusBarColor: model.statusBarColor,
                          hideAppBar: model.hideAppBar,
                          title: model.title,
                        )));
          },
        ));
  }

  _items(BuildContext context) {
    if (sublNavList == null) return null;
    List<Widget> _items = [];
    // 计算第一行展示的数量
    int separate = (sublNavList.length / 2 + 0.5).toInt();
    sublNavList.forEach((e) => _items.add(_item(context, e)));
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _items.sublist(separate, sublNavList.length),
          ),
        )
      ],
    );
  }
}
