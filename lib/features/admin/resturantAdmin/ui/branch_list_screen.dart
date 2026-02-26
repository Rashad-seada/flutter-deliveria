import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/image_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/delete_confirmation_dialog.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/branch_model.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/branches_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/edit_branch_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchListScreen extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;

  const BranchListScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BranchesCubit>()..getBranches(restaurantId),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: ArrowBackAppBarWithTitle(
            showTitle: true,
            title: "$restaurantName - Branches",
            titleStyle: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              onPressed: () => _navigateToAddBranch(context),
              backgroundColor: AppColors.primaryDeafult,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text("Add Branch", style: TextStyle(color: Colors.white)),
            );
          }
        ),
        body: BlocConsumer<BranchesCubit, BranchesState>(
          listener: (context, state) {
            if (state is BranchActionSuccess) {
              showSuccessSnackBar(context, state.message);
            } else if (state is BranchActionError) {
              showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BranchesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state is BranchesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red),
                    verticalSpace(16),
                    Text(state.message),
                    verticalSpace(16),
                    AppButton(
                      title: "Retry",
                      onPressed: () => context.read<BranchesCubit>().getBranches(restaurantId),
                    ),
                  ],
                ),
              );
            }
            
            final cubit = context.read<BranchesCubit>();
            final branches = cubit.branches;
            
            if (branches.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.store_mall_directory_outlined, size: 64, color: Colors.grey),
                    verticalSpace(16),
                    Text("No branches yet", style: TextStyles.bimini16W700),
                    verticalSpace(8),
                    Text("Tap + to add a new branch", style: TextStyles.bimini14W500),
                  ],
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () => cubit.getBranches(restaurantId),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: branches.length,
                separatorBuilder: (_, __) => verticalSpace(12),
                itemBuilder: (context, index) {
                  final branch = branches[index];
                  return _BranchCard(
                    branch: branch,
                    restaurantId: restaurantId,
                    onEdit: () => _navigateToEditBranch(context, branch),
                    onDelete: () => _confirmDelete(context, branch),
                    onToggle: () => cubit.toggleBranch(branch.id!, restaurantId),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToAddBranch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BranchesCubit>(),
          child: EditBranchScreen(
            restaurantId: restaurantId,
            restaurantName: restaurantName,
          ),
        ),
      ),
    );
  }

  void _navigateToEditBranch(BuildContext context, BranchModel branch) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BranchesCubit>(),
          child: EditBranchScreen(
            restaurantId: restaurantId,
            restaurantName: restaurantName,
            branch: branch,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, BranchModel branch) {
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: "Delete Branch",
        message: "Are you sure you want to delete '${branch.branchName ?? 'this branch'}'?",
        itemName: branch.branchName ?? "Unknown Branch",
        onConfirm: () {
          context.read<BranchesCubit>().deleteBranch(branch.id!, restaurantId);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  final BranchModel branch;
  final String restaurantId;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const _BranchCard({
    required this.branch,
    required this.restaurantId,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = branch.isShow ?? true;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.red.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              // Branch Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.store,
                  color: AppColors.primaryDeafult,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              // Branch Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            branch.branchName ?? "Unnamed Branch",
                            style: TextStyles.bimini16W700,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Status Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isActive ? Icons.check_circle : Icons.pause_circle,
                                size: 12.sp,
                                color: isActive ? Colors.green : Colors.red,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                isActive ? "Active" : "Paused",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (branch.branchCode != null)
                      Text(
                        "Code: ${branch.branchCode}",
                        style: TextStyles.bimini12W400Grey.copyWith(color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(12),
          
          // Details Row
          Row(
            children: [
              _InfoChip(icon: Icons.phone, text: branch.phone ?? "No phone"),
              SizedBox(width: 12.w),
              _InfoChip(icon: Icons.access_time, text: "${branch.openHour ?? '--'} - ${branch.closeHour ?? '--'}"),
            ],
          ),
          if (branch.locationMap != null && branch.locationMap!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      branch.locationMap!,
                      style: TextStyles.bimini12W400Grey.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          
          verticalSpace(12),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ActionButton(
                icon: Icons.edit,
                label: "Edit",
                color: AppColors.primaryDeafult,
                onTap: onEdit,
              ),
              SizedBox(width: 8.w),
              _ActionButton(
                icon: isActive ? Icons.pause : Icons.play_arrow,
                label: isActive ? "Pause" : "Resume",
                color: isActive ? Colors.orange : Colors.green,
                onTap: onToggle,
              ),
              SizedBox(width: 8.w),
              _ActionButton(
                icon: Icons.delete_outline,
                label: "Delete",
                color: Colors.red,
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        Text(text, style: TextStyles.bimini12W400Grey.copyWith(color: Colors.grey)),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp, color: color),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
