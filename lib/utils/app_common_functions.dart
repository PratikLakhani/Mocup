import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plug2go/features/notifications/notification_page.dart';
import 'package:plug2go/gen/assets.gen.dart';
import 'package:plug2go/utils/app_navigations.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/utils/logger.dart';
import 'package:plug2go/widgets/app_snackbar.dart';
import 'package:plug2go/widgets/option_pop_up.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCommonFunctions {
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<String?> getAddressDetails(LatLng latLng) async {
    var address = '';
    try {
      final placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      final place = placemarks[0];
      address = '${place.name}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}';
    } catch (e) {
      e.logD;
    }
    address.logE;
    return address;
  }

  static Future<LatLng?> getLatLongFromAddress({
    required String address,
  }) async {
    var data = <Location>[];
    try {
      data = await locationFromAddress(address);
    } catch (e) {
      e.logD;
    }
    return LatLng(data.elementAt(0).latitude, data.elementAt(0).longitude);
  }

  String formatPhoneNumber(String number, {bool isInput = false}) {
    final digitsOnly = number.replaceAll(RegExp(r'\D'), '');
    if (isInput) {
      if (digitsOnly.length <= 3) {
        return digitsOnly;
      } else if (digitsOnly.length <= 6) {
        return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
      } else if (digitsOnly.length == 10) {
        return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, 10)}';
      }
    } else {
      if (digitsOnly.length == 11 && digitsOnly.startsWith('1')) {
        return '+1 (${digitsOnly.substring(1, 4)}) ${digitsOnly.substring(4, 7)}-${digitsOnly.substring(7, 11)}';
      } else if (digitsOnly.length == 10) {
        return '+1 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, 10)}';
      }
    }
    return number;
  }

  String formatCardNumber(String value) {
    var result = value;
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    // Format the number into groups of 4
    for (var i = 0; i < digitsOnly.length; i += 4) {
      if (i + 4 < digitsOnly.length) {
        result += '${digitsOnly.substring(i, i + 4)} ';
      } else {
        result += digitsOnly.substring(i);
      }
    }

    return result;
  }

  static void openLoginWarningDialog(BuildContext ctx) {
    showDialog<void>(
      context: ctx,
      builder: (context) => OptionPopUp(
        title: 'Login Required',
        body: 'You are a guest user, Please login to unlock all the features!',
        onNegative: () {
          Navigator.pop(context);
        },
        onPositive: () {
          AppNavigations.pushAndRemoveAllScreen(
            context,
            const NotificationPage(),
          );
        },
        icon: Assets.icons.icProfile.svg(
          height: AppSize.h28,
          width: AppSize.h28,
        ),
        positive: 'Login',
        negative: 'Cancel',
      ),
    );
  }

  static Future<void> launchPhoneNo(BuildContext context, String mobileNo) async {
    try {
      final url = Uri(
        scheme: 'tel',
        path: mobileNo,
      );
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

class NoSpecialCharactersTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow only letters, numbers, and spaces
    final filteredText = newValue.text.replaceAll(RegExp(r'[^A-Za-z\s]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection.copyWith(
        baseOffset: filteredText.length,
        extentOffset: filteredText.length,
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange}) : assert(decimalRange >= 0, 'Value less than 0');
  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // Allow only one period and restrict to two decimal places
    if (newText == '') {
      return newValue;
    }

    if (RegExp(r'^\d+\.?\d{0,' + decimalRange.toString() + r'}$').hasMatch(newText)) {
      return newValue;
    }

    return oldValue;
  }
}
