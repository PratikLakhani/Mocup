import 'package:flutter/material.dart';

class AppLoaderWidget extends StatelessWidget {
  const AppLoaderWidget({
    required this.isShowLoader,
    required this.child,
    this.isFullOpecity = false,
    super.key,
  });
  final bool isShowLoader;
  final bool isFullOpecity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: isShowLoader,
          child: Opacity(
            opacity: isFullOpecity
                ? 1
                : isShowLoader
                    ? 0.5
                    : 1,
            child: child,
          ),
        ),
        if (isShowLoader)
          const Center(
            child: CircularProgressIndicator(),
            // Lottie.asset(
            //   'assets/json/simple_loader.json',
            //   height: AppSize.h70,
            // ),
          ),
      ],
    );
  }
}
