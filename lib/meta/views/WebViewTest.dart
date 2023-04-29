
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../utils/Utils/Utils.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: InAppWebViewPage()
    );
  }
}

class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  late InAppWebViewController _webViewController;

  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("InAppWebView")
        ),
        body: Column(children: <Widget>[
          Expanded(
            child:
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse("https://goyalpratham.me/project/facerecognition/")),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                    javaScriptCanOpenWindowsAutomatically: true,
                    javaScriptEnabled: true,
                    allowUniversalAccessFromFileURLs: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller , Uri? uri){

                },

                onLoadStop: (InAppWebViewController controller , Uri? uri){

                },

                onLoadError: (InAppWebViewController controller, Uri? uri, int i, String msg) {

                },

                onLoadHttpError: (InAppWebViewController controller, Uri? uri, int i, String msg) {

                },

                androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                }
            ),
          ),
        ])
    );
  }
}
