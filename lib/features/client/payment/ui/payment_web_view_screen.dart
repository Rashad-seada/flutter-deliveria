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

    _controller = WebViewController()
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
            // Check URL-based success detection (more reliable)
            _checkUrlForPaymentResult(url);
            // Also check page content as fallback
            _checkPageContentForSuccess();
          },
          onNavigationRequest: (NavigationRequest request) {
            // Intercept Paymob redirect URLs
            _checkUrlForPaymentResult(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  /// Primary detection: Check URL query parameters for payment result
  /// Paymob redirects to a URL with ?success=true or ?success=false
  void _checkUrlForPaymentResult(String url) {
    if (hasTriggeredSuccess) return;

    try {
      final uri = Uri.parse(url);
      final queryParams = uri.queryParameters;

      // Paymob includes 'success' parameter in the redirect URL
      if (queryParams.containsKey('success')) {
        final success = queryParams['success']?.toLowerCase();
        if (success == 'true') {
          _handlePaymentSuccess();
        } else if (success == 'false') {
          _handlePaymentFailure();
        }
      }

      // Also check for transaction response data in URL
      if (queryParams.containsKey('txn_response_code')) {
        final responseCode = queryParams['txn_response_code'];
        if (responseCode == 'APPROVED') {
          _handlePaymentSuccess();
        }
      }
    } catch (e) {
      print('Error parsing payment URL: $e');
    }
  }

  /// Fallback detection: Check page content via JavaScript
  void _checkPageContentForSuccess() {
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
          } else {
            pageText = content.toString();
          }

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
      print("✅ Payment approved detected!");

      widget.onPaymentApproved();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Payment Successful!'),
              ],
            ),
            backgroundColor: Color(0xFF2ECC71),
            duration: Duration(seconds: 2),
          ),
        );

        // Brief delay for user to see success, then pop
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        });
      }
    }
  }

  void _handlePaymentFailure() {
    if (!hasTriggeredSuccess && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Payment failed. Please try again.'),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );

      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          Navigator.of(context).pop(false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.primaryDeafult),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Done',
              style: TextStyles.bimini16W700.copyWith(
                color: AppColors.primaryDeafult,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CustomLoading()),
        ],
      ),
    );
  }
}
