import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/web/web_view.dart';

class GridNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const GridNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _items(context),
        ),
      ),
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      child: Column(
        children: [
          Image.network(
            model.icon,
            height: 32,
            width: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
            title: model.title,
          )
        ));
      },
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> _items = [];
    localNavList.forEach((e) => _items.add(_item(context, e)));
    return _items;
  }
}
