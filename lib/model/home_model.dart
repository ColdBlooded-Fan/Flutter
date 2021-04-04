// ConfigModel config | Object	| NonNull
// `List<CommonModel>` bannerList | Array	|	NonNull
// `List<CommonModel>` localNavList | Array	| NonNull
// GridNavModel gridNav | Object	|	NonNull
// `List<CommonModel>` subNavList | Array	|	NonNull
// SalesBoxModel salesBox | Object	|	NonNull
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sale_box_model.dart';

class HomeModel {
  final ConfigModel configModel;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SaleBoxModel salesBox;


  HomeModel(
      {this.configModel,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((e) => CommonModel.fromJson(e)).toList();
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson(e)).toList();
    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    return HomeModel(
        configModel: ConfigModel.fromJson(json['config']),
        gridNav: GridNavModel.fromJson(json['gridNav']),
        bannerList: bannerList,
        localNavList: localNavList,
        subNavList: subNavList,
        salesBox:SaleBoxModel.fromJson(json['salesBox']));
  }
}
