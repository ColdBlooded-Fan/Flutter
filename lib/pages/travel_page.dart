import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<TravelTab> _tabs = [];

  TravelTabModel _travelTabModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("TravelPage.initState");

    _tabController = TabController(length: _tabs.length, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _tabController = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        _tabs = model.tabs;
        _travelTabModel = model;
      });
    }).catchError((onError) {
      print("onError" + onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: _tabs.map<Tab>((TravelTab tab) {
                    return Tab(
                      text: tab.labelName,
                    );
                  }).toList(),
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xff2fcfbb), width: 3),
                      insets: EdgeInsets.only(bottom: 10)),
                ),
              ),
              Flexible(child: TabBarView(
                  controller: _tabController,
                  children: _tabs.map((TravelTab tab) {
                    return Text(tab.groupChannelCode);
                  }).toList()))
            ],
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
    print("TravelPage.dispose");
  }
}
