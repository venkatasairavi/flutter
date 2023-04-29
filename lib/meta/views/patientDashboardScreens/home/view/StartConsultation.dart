
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import 'dart:async';

/// Represents Homepage for Navigation
class StartConsultation extends StatefulWidget {
  final String passedUrl;
  final String userType;

  const StartConsultation({Key? key, required this.passedUrl, required this.userType}) : super(key: key);

  @override
  _StartConsultation createState() => _StartConsultation();
}

class _StartConsultation extends State<StartConsultation> {
  late InAppWebViewController _webViewController;

  Utils utils = Utils();

  @override
  void initState() {
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
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: SvgPicture.asset(ImageConstant.imgBack2, fit: BoxFit.fill),
                onPressed: () {
                  if(widget.userType == 'PATIENT'){
                    Navigator.of(context).pushNamed(PatientDashboardScreen);
                  }else if(widget.userType == 'DOCTOR'){
                    Navigator.of(context).pushNamed(HomeRoute);
                  }
                },
              ),
            ),
            body:
            SizedBox(
              child:
              InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.passedUrl)),
                  initialOptions: InAppWebViewGroupOptions(
                    ios: IOSInAppWebViewOptions(
                        disallowOverScroll : true,
                        enableViewportScale: true,
                        suppressesIncrementalRendering: true,
                        allowsAirPlayForMediaPlayback : false,
                        allowsBackForwardNavigationGestures : false,
                        allowsLinkPreview: false,
                        ignoresViewportScaleLimits : true,
                        allowsInlineMediaPlayback : true,
                    ),
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                      javaScriptEnabled: true,
                      javaScriptCanOpenWindowsAutomatically: false,
                      allowUniversalAccessFromFileURLs: false,
                      clearCache: false,
                      verticalScrollBarEnabled: false,
                      disableHorizontalScroll: true,
                      disableVerticalScroll: true,
                      supportZoom: false,
                      
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  // onCloseWindow: (InAppWebViewController contoller ,CloseButton closeButton){
                  //   print("onclosewindow : "+ );
                  //    utils.dismissProgressDialog();
                  // },

                  onLoadStart: (InAppWebViewController controller , Uri? uri){
                    print("onLoadStart : "+ uri.toString());
                    utils.showProgressDialog(context);

                    if (uri.toString().isNotEmpty) {
                      if (uri.toString().contains("gtcure.com/vc-ended")) {
                        if (widget.userType == 'PATIENT') {
                          Navigator.of(context)
                              .pushNamed(PatientDashboardScreen);
                        } else if (widget.userType == 'DOCTOR') {
                          Navigator.of(context).pushNamed(HomeRoute);
                        }
                      }
                    }
                    utils.dismissProgressDialog();
                  },

                  onLoadStop: (InAppWebViewController controller , Uri? uri){
                    print("onLoadStop : "+ uri.toString());
                    utils.dismissProgressDialog();

                    if (uri.toString().isNotEmpty) {
                      if (uri.toString().contains("gtcure.com/vc-ended")) {
                        if (widget.userType == 'PATIENT') {
                          Navigator.of(context)
                              .pushNamed(PatientDashboardScreen);
                        } else if (widget.userType == 'DOCTOR') {
                          Navigator.of(context).pushNamed(HomeRoute);
                        }
                      }
                    }
                  },

                  onProgressChanged : (InAppWebViewController controller, int i){
                    print("onProgressChanged : "+ i.toString());
                    if(i.toString() == 100){
                      utils.dismissProgressDialog();
                    }
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
                    if(consoleMessage.toString().contains("participantLeft")){
                      if (widget.userType == 'PATIENT') {
                        Navigator.of(context)
                            .pushNamed(PatientDashboardScreen);
                      } else if (widget.userType == 'DOCTOR') {
                        Navigator.of(context).pushNamed(HomeRoute);
                      }
                    }
                    utils.dismissProgressDialog();
                  },

                  androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                    return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                  }
              ),
            )
        )
    );
  }
}
