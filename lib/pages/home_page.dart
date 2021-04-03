import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const double APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.cdn.huabbao.com%2Fcase%2F20210220%2F6030f9b97e741.png%21th_1000&refer=http%3A%2F%2Fimg.cdn.huabbao.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619966601&t=aa5f4b74d59f89ceade98b3945295839',
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3417687404,3768940510&fm=26&gp=0.jpg',
    'https://wx2.sinaimg.cn/mw690/b9af179fly1go871lzl3lj20u016t7ey.jpg'
  ];

  double appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
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
                Container(
                  height: 800,
                )
              ]),
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
          )
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
}
