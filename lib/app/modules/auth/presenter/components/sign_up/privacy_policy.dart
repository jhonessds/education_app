import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late String privacyPolicy;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    privacyPolicy = 'https://camporionline.org/privacy_app.html';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(privacyPolicy));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                right: 8,
                left: 8,
                top: 6,
                bottom: 5,
              ),
              child: WebViewWidget(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
