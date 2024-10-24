import 'package:flutter/material.dart';
import 'package:plug2go/db/app_db.dart';
import 'package:plug2go/di/injector.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/features/notifications/notification_page.dart';
import 'package:plug2go/gen/assets.gen.dart';
import 'package:plug2go/l10n/l10n.dart';
import 'package:plug2go/utils/app_padding.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_button.dart';

class NoInternetConnectionPage extends StatelessWidget {
  const NoInternetConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppPadding.symmetric(
          horizontal: AppSize.w20,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Center(
                child: Assets.lottie.noInternet.lottie(
                  height: AppSize.h130,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  context.l10n.noInternetConnection,
                  style: context.textTheme.bodyMedium?.copyWith(fontSize: AppSize.sp18),
                ),
              ),
              // Text(
              //   context.l10n.pleaseCheckYourInternetConnection,
              //   style: context.textTheme.bodyMedium,
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(height: AppSize.h30),
              AppButton(
                title: 'Retry',
                onTap: () async {
                  if (Injector.instance<AppDB>().internetStatus == 'connected') {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder<void>(
                        pageBuilder: (_, __, ___) => const NotificationPage(),// 
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
