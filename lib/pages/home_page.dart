import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sale_box_model.dart';
import 'package:flutter_trip/widget/card_nav.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/seach_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

const double APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = "网红打卡经典 酒店 美食";

class HomePage extends StatefulWidget {
  static ConfigModel configModel;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [];

  double appBarAlpha = 0;

  String showInfo = '';
  List<CommonModel> gridNavList = [];
  GridNavModel cardNavList;
  List<CommonModel> sublNavList;
  SaleBoxModel salesBox;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: NotificationListener(
                onNotification: _onScrollNotificationListner,
                child: _listView,
              ),
            ),
          ),
          _appBar,
        ],
      ),
    );
  }

  Widget get _listView {
    return ListView(
        children: [
          Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _imageUrls[index],
                    fit: BoxFit.fill,
                  );
                },
                pagination: SwiperPagination(),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
              child: GridNav(localNavList: gridNavList)),
          Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: CardNav(gridNavModel: cardNavList),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SubNav(sublNavList: sublNavList),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SalesBox(
              salesBox: salesBox,
            ),
          ),
        ]);
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

  _jumpToSearch() {}

  _jumpToSpeak() {}

  _onTextChanged(tetx) {}

  void _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  //监听listView滚动事件
  bool _onScrollNotificationListner(Notification notification) {
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      _onScroll(notification.metrics.pixels);
    }
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel homeModel = await HomeDao.fetch();
      List<String> _list = [];
      setState(() {
        HomePage.configModel = homeModel.configModel;
        showInfo = jsonEncode(homeModel.configModel.searchUrl);
        for (int i = 0; i < homeModel.bannerList.length; i++) {
          CommonModel commonModel = homeModel.bannerList[i];
          _list.add(commonModel.icon);
        }
        _imageUrls = _list;
        print(homeModel.gridNav);
        gridNavList = homeModel.localNavList;

        cardNavList = homeModel.gridNav;
        sublNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;
      });
    } catch (e) {
      print('fanjingwei' + e.toString());
    }
  }
}
