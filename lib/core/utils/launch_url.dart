import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        webOnlyWindowName: '_blank', // opens in new tab
      );
    } else {
      log('Could not launch $url');
    }
  } catch (e) {
    log("EXCEPTION : exception occured while launching $url. exception was $e");
  }
}

Future<void> launchPhone({required String phoneNumber}) async {
  try {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    // NOTE:
    // On Web, canLaunchUrl may return false even when it works.
    // You can safely call launchUrl directly if needed.
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, webOnlyWindowName: '_self');
    } else {
      log('Could not launch dialer');
    }
  } catch (e) {
    log("EXCEPTION: Error launching phone dialer. $e");
  }
}

Future<void> launchEmail({
  required String toEmail,
  String? subject,
  String? body,
}) async {
  try {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        webOnlyWindowName: '_self', // opens mail client properly on web
      );
    } else {
      log('Could not launch email client');
    }
  } catch (e) {
    log("EXCEPTION: Error launching email. $e");
  }
}
