import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static openEmail({
    required String toEmail,
    required String subject,
  }) async {
    final url = 'mailto:$toEmail?subject=${Uri.encodeFull(subject)}';
    await _launchUrl(url);
  }

  static Future openLink({required String url}) => _launchUrl(url);
}
