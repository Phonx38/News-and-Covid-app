import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  const ArticleView({Key key, this.blogUrl}) : super(key: key);
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  bool _loading = true;
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Samachar",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily:'AbrilFatface-Regular'),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width ,
      child: WebView(
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.blogUrl,
        onWebViewCreated: ((WebViewController webViewController){
          _completer.complete(webViewController);
        }),
        
        onPageFinished: (finish) {
              setState(() {
                _loading = false;
              });
            },
      )
    )    

    );
  }
}