import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final VoidCallback onPaymentApproved;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.onPaymentApproved,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool hasTriggeredSuccess = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                setState(() {
                  isLoading = true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });
                _checkForPaymentSuccess();
              },
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkForPaymentSuccess() {
    if (hasTriggeredSuccess) return;

    _controller
        .runJavaScriptReturningResult('''
      document.documentElement.innerText.toLowerCase();
    ''')
        .then((content) {
          String? pageText;
          if (content is String) {
            pageText = content;
            if (pageText.startsWith('"') && pageText.endsWith('"')) {
              pageText = pageText.substring(1, pageText.length - 1);
            }
            pageText = pageText.replaceAll(r'\"', '"').replaceAll(r'\n', '\n');
          } else          pageText = content.toString();
        


          if (pageText.contains('approved') ||
              pageText.contains('thank you') ||
              pageText.contains('success') ||
              pageText.contains('payment successful')) {
            _handlePaymentSuccess();
          }
        })
        .catchError((error) {
          print('Error checking page content: $error');
        });
  }

  void _handlePaymentSuccess() {
    if (!hasTriggeredSuccess) {
      hasTriggeredSuccess = true;
      print("Payment approved detected in WebView!");

      widget.onPaymentApproved();

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: TextStyles.bimini20W700.copyWith(
          color: AppColors.primaryDeafult
        ),),
        iconTheme: IconThemeData(
          color: AppColors.primaryDeafult
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),

            child: Text('Done', style: TextStyles.bimini16W700.copyWith(
              color: AppColors.primaryDeafult
            )),
          ),
        ],
      ),
      body: Stack(
        
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            Center(
              child: CustomLoading(),
            ),
        ],
      ),
    );
  }
}
