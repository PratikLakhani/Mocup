import 'package:flutter/material.dart';
import 'package:plug2go/main.dart';
import 'package:plug2go/widgets/loading_pop_up.dart';

@immutable
final class LoadingOverlay {
  /// returns already created [_singleton] instances to avoid duplication of [LoadingOverlay]
  factory LoadingOverlay() {
    return _singleton;
  }

  /// private constructor
  const LoadingOverlay._internal();

  static const LoadingOverlay _singleton = LoadingOverlay._internal();

  /// to access instance flexibility like [LoadingOverlay.instance]
  static LoadingOverlay get instance => _singleton;

  static bool _isLoading = false;

  bool get isLoading => _isLoading;

  void show({String title = 'Loading...', String body = 'Please wait'}) {
    _isLoading = true;
    showDialog<void>(
      context: rootNavKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            _isLoading = !didPop;
          },
          child: LoadingPopUp(title: title, body: body),
        );
      },
    );
  }

  void hide() {
    if (_isLoading) {
      _isLoading = false;
      Navigator.pop(rootNavKey.currentContext!);
    }
  }
}
