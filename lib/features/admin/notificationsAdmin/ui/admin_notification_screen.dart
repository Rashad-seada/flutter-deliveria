// lib/features/admin/notifications/ui/admin_notifications_screen.dart
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/notificationsAdmin/ui/widgets/notifications_tab_body.dart';
import 'package:delveria/features/admin/notificationsAdmin/ui/widgets/notifications_taps.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController messageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    messageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          dontShowArrow: true,
          title:AppStrings.notifications.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(30),
              NotificationTabs(tabController: tabController),
              verticalSpace(40),
              NotificationsTabBody(
                tabController: tabController,
                messageController: messageController,
                titleController: titleController,
              ),
          ],
          ),
        ),
      ),
    );
  }
}

