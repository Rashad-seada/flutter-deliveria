import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/add_icon_container.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/accepted_orders_screen.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/orders_for_each_agent_screen.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/widgets/agent_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryAgentsScreen extends StatefulWidget {
  const DeliveryAgentsScreen({super.key});

  @override
  _DeliveryAgentsScreenState createState() => _DeliveryAgentsScreenState();
}

class _DeliveryAgentsScreenState extends State<DeliveryAgentsScreen> {
  List<bool> isSelectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          showRefresh: true,
          widget: GestureDetector(
            onTap: () {
              context.read<AgentsCubit>().getAllAgents();
            },
            child: Icon(Icons.refresh, color: AppColors.primaryDeafult),
          ),
          title: AppStrings.deliveryAgents.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<AgentsCubit, AgentsState>(
        builder: (context, state) {
          final agentCubit = context.read<AgentsCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              //number of orders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create:
                                        (context) =>
                                            getIt<AgentsCubit>()
                                              ..getAllOrders(),
                                  ),
                                ],
                                child: AcceptedOrdersScreen(
                                  isAccepted: true,
                                  agents: agentCubit.allAgents,
                                ),
                              ),
                        ),
                      );
                    },
                    child: Text(
                      " Accepted orders : ${agentCubit.acceptedOrders.length}",
                      style: TextStyles.bimini16W700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create:
                                        (context) =>
                                            getIt<AgentsCubit>()
                                              ..getAllOrders(),
                                  ),
                                ],
                                child: AcceptedOrdersScreen(
                                  isAccepted: false,
                                  agents: agentCubit.allAgents,
                                ),
                              ),
                        ),
                      );
                    },
                    child: Text(
                      " Not Accepted orders : ${agentCubit.notAcceptedOrders.length}",
                      style: TextStyles.bimini16W700,
                    ),
                  ),
                ],
              ),
              verticalSpace(20),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<AgentsCubit, AgentsState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return CustomLoading();
                      }
                      final cubit = context.read<AgentsCubit>();
                      // Initialize isSelectedList based on backend ban status
                      if (isSelectedList.length != cubit.allAgents.length) {
                        isSelectedList =
                            cubit.allAgents
                                .map((agent) => agent.ban ?? false)
                                .toList();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.sqaureIcon,
                                width: 24.w,
                                height: 24.h,
                              ),
                              SizedBox(width: 8),
                              Text(
                                AppStrings.deliveryAgentsList.tr(),
                                style: TextStyles.bimini20W700,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(Routes.addDeliveryAgent);
                                },
                                child: AddIconContainer(),
                              ),
                            ],
                          ),
                          verticalSpace(33),

                          ...cubit.allAgents.asMap().entries.map((agent) {
                            // Get the number of orders for this agent
                            final ordersCount =
                                agent.value.orders!
                                    .where(
                                      (e) =>
                                          e.status != "Canceled" &&
                                          e.status != "Completed",
                                    )
                                    .length ??
                                0;
                            final showMulti = ordersCount > 1;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 32.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => BlocProvider(
                                            create:
                                                (context) =>
                                                    getIt<AgentsCubit>()
                                                      ..getAllOrdersEachAgent(
                                                        agent.value.id,
                                                      ),
                                            child: OrdersForEachAgentScreen(id: agent.value.id,
                                            
                                            ),
                                          ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AgentCard(
                                      widget: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Orders: $ordersCount",
                                              style: TextStyles.bimini14W700
                                                  .copyWith(
                                                    color:
                                                        AppColors
                                                            .primaryDeafult,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      isSelected: isSelectedList,
                                      onCheckTap: () {
                                        setState(() {
                                          isSelectedList[agent.key] =
                                              !isSelectedList[agent.key];
                                        });
                                        cubit.banAgent(agentId: agent.value.id);
                                      },
                                      name: agent.value.name,
                                      phone: agent.value.phone,
                                      index: agent.key,
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 24),

                          // Center(
                          //   child: AppButton(
                          //     title: AppStrings.addNewAgent.tr(),

                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
