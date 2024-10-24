import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/main.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_button.dart';
import 'package:plug2go/widgets/app_spacebox.dart';

class PermissionHandlerProvider {
  final ValueNotifier<bool> _isDialogOpen = ValueNotifier(false);
  ValueNotifier<bool> get isDialogOpen => _isDialogOpen;

  Future<bool> requestPermission({
    required Permission permission,
    required String permissionName,
  }) async {
    var permissionGranted = false;
    if (await permission.isGranted) {
      return true;
    }

    // final status = await permission.request();
    // print('Requested permission: $permission');
    // print('Permission status: $status');

    await permission
        .onDeniedCallback(() {
          // _showPermissionDeniedDialog(permissionName.toLowerCase());
        })
        .onGrantedCallback(() {
          permissionGranted = true;
        })
        .onPermanentlyDeniedCallback(() {
          if (!isDialogOpen.value) {
            _showOpenSettingsDialog(permissionName.toLowerCase());
          }
        })
        .onRestrictedCallback(() {})
        .onLimitedCallback(() {
          permissionGranted = true;
        })
        .onProvisionalCallback(() {})
        .request();
    // switch (status) {
    //   case PermissionStatus.granted:
    //     return PermissionStatus.granted;
    //   case PermissionStatus.denied:
    //     _showPermissionDeniedDialog(permissionText);
    //     return PermissionStatus.denied;
    //   case PermissionStatus.permanentlyDenied:
    //     _showOpenSettingsDialog(permissionText);
    //     return PermissionStatus.permanentlyDenied;
    //   case PermissionStatus.restricted:
    //     return PermissionStatus.restricted;
    //   default:
    //     return permission.request();
    // }

    return permissionGranted;
  }

  // void _showPermissionDeniedDialog(String permissionName) {
  //   showDialog(
  //     context: rootNavKey.currentContext!,
  //     builder: (BuildContext dContext) {
  //       return AlertDialog(
  //         title: const Text('Permission Denied'),
  //         content: Text('Please allow $permissionName access to continue.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(dContext).pop();
  //               _showOpenSettingsDialog(permissionName);
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   return;
  // }

  void _showOpenSettingsDialog(String permissionName) {
    showDialog<dynamic>(
      barrierDismissible: false,
      context: rootNavKey.currentContext!,
      builder: (BuildContext dContext) {
        isDialogOpen.value = true;
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              isDialogOpen.value = false;
            }
          },
          child: Container(
            height: AppSize.h100,
            padding: EdgeInsets.symmetric(horizontal: AppSize.w20),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.r12),
              ),
              title: Text(
                'Permission Required',
                style: rootNavKey.currentContext!.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: AppSize.sp18,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Please allow $permissionName permission to continue',
                    textAlign: TextAlign.center,
                    style: rootNavKey.currentContext!.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontSize: AppSize.sp16,
                    ),
                  ),
                  SpaceV(AppSize.h14),
                  AppButton(
                    title: 'Open settings',
                    width: dContext.width,
                    height: AppSize.h40,
                    onTap: () {
                      isDialogOpen.value = false;
                      openAppSettings();
                      Navigator.of(dContext).pop();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      isDialogOpen.value = false;
                      Navigator.of(dContext).pop();
                    },
                    child: Text(
                      'Close',
                      style: rootNavKey.currentContext!.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                        fontSize: AppSize.sp16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
