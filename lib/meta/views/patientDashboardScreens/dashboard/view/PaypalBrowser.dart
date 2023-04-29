
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../app/routes/app.routes.dart';
import '../../../../../app/shared/utils/image_constant.dart';

/// Represents Homepage for Navigation
class PaypalBrowser extends StatefulWidget {
  final String passedUrl;
  final String appointmentGuId;

  const PaypalBrowser({Key? key, required this.passedUrl, required this.appointmentGuId}) : super(key: key);

  @override
  _PaypalBrowser createState() => _PaypalBrowser();
}

class _PaypalBrowser extends State<PaypalBrowser> {
  late InAppWebViewController _webViewController;

  Utils utils = Utils();

  @override
  void initState() {
    // TODO: implement initState
    // _documentData();
    super.initState();
    permissions();
  }

  Future<void> permissions() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(context);
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white70,
              leading: IconButton(
                icon: SvgPicture.asset(ImageConstant
                    .imgBack2,
                    fit: BoxFit.fill),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body:
            Container(
                margin: const EdgeInsets.only(top: 25.0),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
                child:   InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.passedUrl)),
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
                      print("onLoadStart : "+ uri.toString());
                      utils.showProgressDialog(context);
                    },

                    onLoadStop: (InAppWebViewController controller , Uri? uri){
                      print("onLoadStop : "+ uri.toString());

                      if (uri.toString().isNotEmpty) {
                        utils.dismissProgressDialog();
                        if (uri.toString().contains("mob-pay-success")) {
                          Navigator.of(context).pushNamed(appointmentSuccessfully, arguments: [
                            widget.appointmentGuId
                          ]);
                        }else if (uri.toString().contains("mob-pay-failed")){
                          Navigator.of(context).pop();
                        }
                      }
                      utils.dismissProgressDialog();
                    },

                    onLoadError: (InAppWebViewController controller, Uri? uri, int i, String msg) {
                      print("onLoadError : "+ msg);

                      utils.dismissProgressDialog();
                    },

                    onLoadHttpError: (InAppWebViewController controller, Uri? uri, int i, String msg) {
                      print("onLoadHttpError : "+ msg);
                      utils.dismissProgressDialog();
                    },

                    onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage){
                      print("onConsoleMessage : "+ consoleMessage.toString());


                    },

                    androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                      return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                    }
                ),


            )
        ));
  }
}

/*WebView(
// key: _key1,
//  initialUrl: Uri.encodeFull('$videoUrl'),
initialUrl: "",
javascriptMode:
JavascriptMode.unrestricted,
onPageFinished: (value) {
setState(() {
if (value != null) {
utils.dismissProgressDialog();
if (value.contains("mob-pay-success")) {
Navigator.of(context).pushNamed(appointmentSuccessfully, arguments: [
widget.appointmentGuId
]);
}else if (value.contains("mob-pay-failed")){
Navigator.of(context).pop();
}
}
});
},
onWebResourceError: (error) {
print(error);
utils.dismissProgressDialog();
},
onWebViewCreated: (controller) {
_webController = controller;
_webController.loadUrl(widget.passedUrl);
},

)*/
