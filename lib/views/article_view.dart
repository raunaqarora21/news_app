
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {
  final String imageUrl;

  ArticleView({this.imageUrl});


  @override
  _ArticleViewState createState() => _ArticleViewState();
}


class _ArticleViewState extends State<ArticleView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter',style: TextStyle(color: Colors.black),),
            Text('News',style : TextStyle(color: Colors.blue),),
          ],

        ),
        actions: [
          Opacity(opacity: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.save),

          ),),

        ],
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ) ,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.imageUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}

