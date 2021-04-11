import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sale_box_model.dart';
import 'package:flutter_trip/widget/card_nav.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

const double APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
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
                child: ListView(children: [
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
                ]),
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.only(top: 8),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
      List<String> _list =[];
      setState(() {
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
