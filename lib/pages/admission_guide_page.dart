import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common_firbase/utils/firebase_analytics_utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdmissionGuidePage extends StatefulWidget {
  @override
  _AdmissionGuidePageState createState() => _AdmissionGuidePageState();
}

enum _State { loading, finish, error, empty, offlineEmpty }

class _AdmissionGuidePageState extends State<AdmissionGuidePage> {
  ApLocalizations ap;

  _State state = _State.loading;

  WebViewController webViewController;

  @override
  void initState() {
    FirebaseAnalyticsUtils.instance
        .setCurrentScreen("AdmissionGuidePage", "admission_guide_page.dart");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ap = ApLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ap.admissionGuide),
        backgroundColor: ApTheme.of(context).blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if ((await webViewController?.canGoBack() ?? false))
                webViewController?.goBack();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if ((await webViewController?.canGoForward() ?? false))
                webViewController?.goForward();
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'https://leslietsai1.wixsite.com/nsysufreshman',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          this.webViewController = webViewController;
          //_controller.complete(webViewController);
        },
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
