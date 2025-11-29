
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlHelper(String url, {required LaunchMode mode}) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: mode);
  }
}
