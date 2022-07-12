import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LowyatState with ChangeNotifier {
  final String? lowyatEndpoint = 'https://forum.lowyat.net/';
  final int? splashDuration = 0x2;

  WebViewController? webViewController;

  bool? isVisible = true;
  bool? canPop = true;
  int? progress = 1;

  Future<void> onWillPop() async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
      canPop = Future.value(false) as bool?;
    }

    canPop = Future.value(true) as bool?;

    notifyListeners();
  }
}
