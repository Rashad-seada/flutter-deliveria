import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/widgets/create_agent_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewAgentScreen extends StatefulWidget {
  const AddNewAgentScreen({super.key});

  @override
  _AddNewAgentScreenState createState() => _AddNewAgentScreenState();
}

class _AddNewAgentScreenState extends State<AddNewAgentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop: true,
          onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
          showTitle: true,
          title: AppStrings.addNewAgent.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<AgentsCubit, AgentsState>(
        builder: (context, state) {
          final cubit = context.read<AgentsCubit>();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(90),
                  CustomFormW(
                    spaceHeaders: 8,
                    spacing: 32,
                    showButton: false,
                    padding: EdgeInsetsGeometry.zero,
                    children: [
                      CustomTextField(
                        controller: cubit.nameController,
                        headerText: AppStrings.agentName.tr(),
                        headerTextStyle: TextStyles.bimini16W400Body,
                        hint: AppStrings.enterAgentName.tr(),
                        hintStyle: TextStyles.bimini13W400Grey,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      CustomTextField(
                        controller: cubit.phoneController,
                        headerText: AppStrings.mobileNumber.tr(),
                        headerTextStyle: TextStyles.bimini16W400Body,
                        hint: AppStrings.agentMobile.tr(),
                        hintStyle: TextStyles.bimini13W400Grey,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      CustomTextField(
                        controller: cubit.passwordContoller,
                        headerText: AppStrings.agentPassword.tr(),
                        headerTextStyle: TextStyles.bimini16W400Body,
                        hint: AppStrings.agentPassword.tr(),
                        hintStyle: TextStyles.bimini13W400Grey,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ],
                  ),
                  verticalSpace(30),
                  CreateAgentBlocListener(
                    child: Center(
                      child: AppButton(
                        title: AppStrings.add.tr(),
                        onPressed: () {
                          cubit.createAgent();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
