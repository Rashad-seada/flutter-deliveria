import 'package:delveria/features/admin/notificationsAdmin/ui/widgets/resturants_tap_body.dart';
import 'package:delveria/features/admin/notificationsAdmin/ui/widgets/users_tap_body.dart';
import 'package:flutter/material.dart';

class NotificationsTabBody extends StatelessWidget {
  const NotificationsTabBody({
    super.key,
    required this.tabController,
    required this.messageController,
    required this.titleController,
  });
  final TabController tabController;
  final TextEditingController messageController;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
 
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          UsersTapBody(
            messageController: messageController,
            titleController: titleController,
          ),
          ResturantsTapBody(
            messageController: messageController,
            titleController: titleController,
          ),
        ],
      ),
    );
  }
}

