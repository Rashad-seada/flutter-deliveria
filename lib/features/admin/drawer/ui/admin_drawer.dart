import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/admin/drawer/ui/widgets/menu_item_button_drawer_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
         return Drawer(
          width: 231.w,
          backgroundColor:
             AppColors.lightGrey,
          child: SafeArea(
            child: Column(
              children: [
                verticalSpace(100),
                MenuItemButtonDrawerAdmin(),
              ],
            ),
          ),
        );
      
  }
}