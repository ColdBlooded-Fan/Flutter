import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.cdn.huabbao.com%2Fcase%2F20210220%2F6030f9b97e741.png%21th_1000&refer=http%3A%2F%2Fimg.cdn.huabbao.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619966601&t=aa5f4b74d59f89ceade98b3945295839',
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3417687404,3768940510&fm=26&gp=0.jpg',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fusa.dug8.com%3A8080%2Ffile%2Fmanhua2%2F189%2F27254%2F001_bbba46.jpg&refer=http%3A%2F%2Fusa.dug8.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619966674&t=04c3a24347f70d50f829a268768884bc'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
              ))
        ],
      ),
    );
  }
}
