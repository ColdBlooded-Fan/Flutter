

import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/web/web_view.dart';

class CardNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const CardNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhysicalModel(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: Column(
        children: _cardNavItems(context),
      ),
    );
  }

  _cardNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;

    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context,gridNavModel.hotel,true));
    }

    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context,gridNavModel.flight,false));
    }

    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context,gridNavModel.travel,false));
    }
    return items;

  }

  _gridNavItem(BuildContext context, GridNavItem item, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, item.mainItem));
    items.add(_doubleItem(context, item.item1,item.item2));
    items.add(_doubleItem(context, item.item3,item.item4));

    List<Widget> expandedItems = [];
    items.forEach((element) {
      expandedItems.add(Expanded(child: element,flex: 1,));
    });

    Color startColor = Color(int.parse('0xff' + item.startColor));
    Color endColor = Color(int.parse('0xff' + item.endColor));
    return Container(
      height: 88,
        margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor]),

      ),
      child: Row(
        children: expandedItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel commonModel) {
    return _wrapGesture(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.network(commonModel.icon,
                fit: BoxFit.contain,
                height: 88,
                width: 121,
                alignment: AlignmentDirectional.bottomEnd),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                commonModel.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        commonModel);
  }

  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return _wrapGesture(
        context,
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  left: borderSide,
                  bottom: first ? borderSide : BorderSide.none),
            ),
            child: Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ),
        item);
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url: commonModel.url,
                    statusBarColor: commonModel.statusBarColor,
                    title: commonModel.title,
                    hideAppBar: commonModel.hideAppBar)));
      },
      child: widget,
    );
  }
}
