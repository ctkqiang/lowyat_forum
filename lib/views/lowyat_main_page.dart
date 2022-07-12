import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lowyat_forum/providers/lowyat_state.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LowyatMainScreen extends StatefulWidget {
  const LowyatMainScreen({Key? key}) : super(key: key);

  @override
  State<LowyatMainScreen> createState() => _LowyatMainScreenState();
}

class _LowyatMainScreenState extends State<LowyatMainScreen> {
  final Completer<WebViewController> _cc = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0.0, 0.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: super.context.read<LowyatState>().progress!,
          children: [
            WillPopScope(
              onWillPop: () async {
                if (await super
                    .context
                    .read<LowyatState>()
                    .webViewController!
                    .canGoBack()) {
                  super.context.read<LowyatState>().webViewController!.goBack();
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
              child: WebView(
                initialUrl: super.context.read<LowyatState>().lowyatEndpoint!,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                zoomEnabled: true,
                onPageStarted: (_) {
                  if (_ == super.context.read<LowyatState>().lowyatEndpoint!) {
                    super.setState(() {
                      super.context.read<LowyatState>().progress = 1;
                    });
                  }
                },
                onPageFinished: (_) {
                  if (_ == super.context.read<LowyatState>().lowyatEndpoint!) {
                    super.setState(() {
                      super.context.read<LowyatState>().progress = 0;
                    });
                  }
                },
                onProgress: (_) => super.context.read<LowyatState>().progress!,
                onWebViewCreated: (_) {
                  super.context.read<LowyatState>().webViewController = _;
                  _cc.future.then((t) =>
                      super.context.read<LowyatState>().webViewController = _);
                  _cc.complete(_);
                },
              ),
            ),
            const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 146, 11, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
