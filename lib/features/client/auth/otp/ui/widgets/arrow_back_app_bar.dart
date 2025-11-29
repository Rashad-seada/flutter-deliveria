import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';

class ArrowBackAppBar extends StatelessWidget {
  const ArrowBackAppBar({super.key,  this.theme});
  final ThemeState? theme;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor:
          theme?.themeMode == ThemeMode.dark ? Colors.black12 : Colors.white,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.primaryDeafult,
          size: 20,
        ),
      ),
    );
  }
}
