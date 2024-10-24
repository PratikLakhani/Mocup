import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plug2go/widgets/app_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
final class MapUtils {
  static Future<void> launchMap(BuildContext context, String latitude, String longitude) async {
    if (Platform.isIOS) {
      await _launchMapOnIOS(context, latitude, longitude);
    } else {
      await _launchMapOnAndroid(context, latitude, longitude);
    }
  }

  static Future<void> _launchMapOnIOS(BuildContext context, String latitude, String longitude) async {
    try {
      final url = Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        AppSnackbar.showSnackbar(context: context, message: 'Could not launch $url');
      }
    } catch (error) {
      if (context.mounted) {
        AppSnackbar.showSnackbar(context: context, message: error.toString());
      }
    }
  }

  static Future<void> _launchMapOnAndroid(BuildContext context, String latitude, String longitude) async {
    try {
      const markerLabel = 'Destination';
      final url = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude($markerLabel)');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        AppSnackbar.showSnackbar(context: context, message: 'Could not launch $url');
      }
    } catch (error) {
      if (context.mounted) {
        AppSnackbar.showSnackbar(context: context, message: error.toString());
      }
    }
  }
}
