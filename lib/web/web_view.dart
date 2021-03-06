import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  String url;
  String statusBarColor;
  String title;
  bool hideAppBar;
  bool backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  static const CATCH_URLS = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ];
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((event) {});
    //监听导航发生变化
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged event) {

      switch (event.type) {
        case WebViewState.startLoad:
          if (_isToMain(event.url)) {
            if (widget.backForbid) {
              webviewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError = webviewReference.onHttpError.listen((event) {});
  }

  bool _isToMain(String url) {
    bool isToMain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        isToMain = true;
        break;
      }
    }
    return isToMain;
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting....'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  _appBar(Color backGroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backGroundColor,
        height: 30,
      );
    }

    return Container(
      color: backGroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
                child: Center(
              child: Text(
                widget.title ?? "",
              ),
            ))
          ],
        ),
      ),
    );
  }
}
