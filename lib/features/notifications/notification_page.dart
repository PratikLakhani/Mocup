import 'package:flutter/material.dart';
import 'package:plug2go/db/app_db.dart';
import 'package:plug2go/di/injector.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/extensions/ext_date_time.dart';
import 'package:plug2go/features/notifications/provider/notification_provider.dart';
import 'package:plug2go/gen/assets.gen.dart';
import 'package:plug2go/l10n/l10n.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_common_functions.dart';
import 'package:plug2go/utils/app_padding.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/utils/logger.dart';
import 'package:plug2go/widgets/app_button.dart';
import 'package:plug2go/widgets/app_snackbar.dart';
import 'package:plug2go/widgets/app_spacebox.dart';
import 'package:plug2go/widgets/app_text_widget.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, this.isGuestMode = false});
  final bool isGuestMode;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final prov = context.read<NotificationProvider>();
        'hello world'.logD;
        prov.notificationListModel?.response.logD;
        prov.notificationListModel.logD;
        widget.isGuestMode.logD;
        prov.notificationCount.value = 0;
        if (widget.isGuestMode == false) {
          if (prov.notificationListModel == null) {
            if (prov.notificationListModel?.response == null) {
              await context.read<NotificationProvider>().getNotifications(isRefresh: false);
            }
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, prov, child) {
        return SafeArea(
          child: AppPadding.symmetric(
            horizontal: AppSize.w20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SpaceV(AppSize.h20),
                Text(
                  context.l10n.notifications,
                  style: context.textTheme.bodySmall,
                ),
                SpaceV(AppSize.h20),
                if (widget.isGuestMode == false) ...{
                  if (prov.notificationListModel != null &&
                      prov.notificationListModel!.response != null &&
                      prov.notificationListModel!.response!.isNotEmpty &&
                      !prov.isLoading)
                    Expanded(
                      child:
                          // RefreshIndicator(
                          //   onRefresh: () async {
                          //     await context.read<NotificationProvider>().getNotifications(isRefresh: true);
                          //   },
                          //   backgroundColor: AppColors.black,
                          //   color: AppColors.white,
                          //   child:
                          ListView.builder(
                        controller: prov.scrollController,
                        itemCount: prov.notificationListModel!.response!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // var notification = prov.notificationListModel!.response![index];
                          return GestureDetector(
                            onTap: () {
                              final isEvUser = Injector.instance<AppDB>().isEvUser;
                              if (prov.notificationListModel!.response![index].requestStatus == 'accepted' ||
                                  prov.notificationListModel!.response![index].requestStatus == 'pending') {
                                isEvUser.logD;

                              } else {
                                AppSnackbar.showSnackbar(
                                  message: 'Session expired',
                                  context: context,
                                );
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.w14,
                                vertical: AppSize.h14,
                              ),
                              margin: EdgeInsets.only(
                                bottom: AppSize.h14,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.sp16),
                                border: Border.all(color: AppColors.borderColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(AppSize.h13),
                                        decoration: BoxDecoration(
                                          color: AppColors.greyButtonColor,
                                          borderRadius: BorderRadius.circular(AppSize.sp12),
                                        ),
                                        child: Assets.icons.icNotification.svg(
                                          colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                        ),
                                      ),
                                      SpaceH(AppSize.w14),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prov.notificationListModel!.response![index].createdAt
                                                    ?.timeAgoSinceDate() ??
                                                '',
                                            style: context.textTheme.titleSmall?.copyWith(
                                              color: AppColors.hintTextColors,
                                            ),
                                          ),
                                          Text(
                                            prov.notificationListModel!.response![index].description ?? '',
                                            style: context.textTheme.titleMedium?.copyWith(color: AppColors.textColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SpaceV(AppSize.h14),
                                  if (prov.notificationListModel!.response![index].requestStatus == 'accepted' &&
                                      Injector.instance<AppDB>().isEvUser)
                                    AppButton(
                                      onTap: () {
                                        if (widget.isGuestMode) {
                                          AppCommonFunctions.openLoginWarningDialog(
                                            context,
                                          );
                                        } else {
                                          if (Injector.instance<AppDB>().isEvUser) {
                                      
                                          } else {
                                            AppSnackbar.showSnackbar(
                                              message: 'Switch to EV role to continue',
                                              context: context,
                                            );
                                          }
                                        }
                                      },
                                      title: prov.notificationListModel!.response![index].startTime == null
                                          ? 'Start Charging'
                                          : 'Stop Charging',
                                      height: AppSize.h40,
                                      width: AppSize.w130,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // ),
                    )
                  else
                    prov.isLoading == false
                        ? Expanded(
                            child:
                                // RefreshIndicator(
                                //   onRefresh: () async {
                                //     await context.read<NotificationProvider>().getNotifications(isRefresh: true);
                                //   },
                                //   backgroundColor: AppColors.black,
                                //   color: AppColors.white,
                                //   child:
                                Stack(
                              children: [
                                ListView(),
                                Center(
                                  child: AppTextWidget(
                                    context.l10n.noNotifications,
                                    style: context.textTheme.bodySmall?.copyWith(
                                      fontSize: AppSize.sp20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                } else if (widget.isGuestMode)
                  Expanded(
                    child:
                        // RefreshIndicator(
                        //   onRefresh: () async {
                        //     await context.read<NotificationProvider>().getNotifications(isRefresh: true);
                        //   },
                        //   backgroundColor: AppColors.black,
                        //   color: AppColors.white,
                        //   child:
                        Stack(
                      children: [
                        ListView(),
                        Center(
                          child: AppTextWidget(
                            context.l10n.noNotifications,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: AppSize.sp20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
