import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/delete_confirmation_dialog.dart';
import 'package:delveria/core/widgets/search_row_with_controller.dart';
import 'package:delveria/features/ResturantOwner/branches/data/models/branch_model.dart';
import 'package:delveria/features/ResturantOwner/branches/logic/cubit/branches_cubit.dart';
import 'package:delveria/features/ResturantOwner/branches/logic/cubit/branches_state.dart';
import 'package:delveria/features/ResturantOwner/branches/ui/add_edit_branch_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchesScreen extends StatefulWidget {
  final String restaurantId;
  const BranchesScreen({super.key, required this.restaurantId});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<BranchModel> _allBranches = [];
  List<BranchModel> _filteredBranches = [];

  @override
  void initState() {
    super.initState();
    context.read<BranchesCubit>().getBranches(widget.restaurantId);
    _searchController.addListener(_filterBranches);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBranches() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBranches = _allBranches.where((branch) {
        return (branch.branchName?.toLowerCase().contains(query) ?? false) ||
               (branch.address?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  void _deleteBranch(String branchId) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: AppStrings.deleteBranch.tr(),
        message: AppStrings.confirmDeleteBranch.tr(),
        itemName: _allBranches.firstWhere((b) => b.id == branchId).branchName ?? "Branch",
        onConfirm: () {
          // Implement delete logic here if API supports it
          // context.read<BranchesCubit>().deleteBranch(branchId);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFD),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          title: AppStrings.manageBranches.tr(),
          showTitle: true,
          titleStyle: TextStyles.bimini20W700.copyWith(color: AppColors.primaryDeafult),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<BranchesCubit>(),
                child: AddEditBranchScreen(restaurantId: widget.restaurantId),
              ),
            ),
          ).then((value) {
            context.read<BranchesCubit>().getBranches(widget.restaurantId);
          });
        },
        backgroundColor: AppColors.primaryDeafult,
        icon: const Icon(Icons.add_location_alt_outlined, color: Colors.white),
        label: Text(AppStrings.addNewBranch.tr(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SearchRowWithController(
                controller: _searchController,
                showButton: false, 
              ),
            ),
            Expanded(
              child: BlocConsumer<BranchesCubit, BranchesState>(
                listener: (context, state) {
                   state.whenOrNull(
                    getBranchesSuccess: (response) {
                      _allBranches = response.data?.branches ?? [];
                      _filterBranches(); 
                    },
                   );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    getBranchesSuccess: (response) {
                      if (_filteredBranches.isEmpty) {
                         // ... Empty state ...
                         return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.store_mall_directory_outlined, size: 80.sp, color: Colors.grey.shade300),
                              verticalSpace(16),
                              Text(AppStrings.noBranchesFound.tr(), style: TextStyles.bimini16W700.copyWith(color: Colors.grey)),
                            ],
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                           await context.read<BranchesCubit>().getBranches(widget.restaurantId);
                        },
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 80.h), // Bottom padding for FAB
                          itemCount: _filteredBranches.length,
                          separatorBuilder: (context, index) => verticalSpace(16),
                          itemBuilder: (context, index) {
                            final branch = _filteredBranches[index];
                            final isOpen = branch.isOpen ?? false; // or logical check with hours

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                children: [
                                  // Header with Name and Status
                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Container(
                                          width: 48.w,
                                          height: 48.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryDeafult.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(12.r),
                                          ),
                                          child: Icon(Icons.store_rounded, color: AppColors.primaryDeafult, size: 28.sp),
                                        ),
                                        horizontalSpace(12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      branch.branchName ?? "Unnamed",
                                                      style: TextStyles.bimini16W700.copyWith(color: Colors.black87),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                                    decoration: BoxDecoration(
                                                      color: isOpen ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(8.r),
                                                    ),
                                                    child: Text(
                                                      isOpen ? AppStrings.open.tr() : AppStrings.closed.tr(),
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: isOpen ? Colors.green : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(4),
                                              if (branch.address != null)
                                                Text(
                                                  branch.address!,
                                                  style: TextStyles.bimini14W400Body.copyWith(color: Colors.grey.shade600, fontSize: 12.sp),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Divider(height: 1, color: Colors.grey.shade100),
                                  ),

                                  // Details Row (Cost, Time, Hours)
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        _buildInfoItem(Icons.delivery_dining_outlined, "${branch.deliveryCost ?? 0} ${AppStrings.le.tr()}"),
                                        _buildInfoItem(Icons.timer_outlined, "${branch.deliveryTime ?? 30} ${AppStrings.mins.tr()}"),
                                        _buildInfoItem(Icons.access_time, "${branch.openHour ?? '9:00'} - ${branch.closeHour ?? '22:00'}"),
                                      ],
                                    ),
                                  ),

                                  // Action Buttons
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16.r),
                                        bottomRight: Radius.circular(16.r),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => _deleteBranch(branch.id ?? ""),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 12.h),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.delete_outline, color: Colors.red, size: 18.sp),
                                                  horizontalSpace(8),
                                                  Text(AppStrings.delete.tr(), style: TextStyle(color: Colors.red, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(width: 1, height: 40.h, color: Colors.grey.shade200),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => BlocProvider.value(
                                                      value: context.read<BranchesCubit>(),
                                                      child: AddEditBranchScreen(
                                                        restaurantId: widget.restaurantId,
                                                        branch: branch,
                                                      ),
                                                    ),
                                                  ),
                                                ).then((value) {
                                                  context.read<BranchesCubit>().getBranches(widget.restaurantId);
                                                });
                                            },
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.r)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 12.h),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.edit_outlined, color: AppColors.primaryDeafult, size: 18.sp),
                                                  horizontalSpace(8),
                                                  Text(AppStrings.edit.tr(), style: TextStyle(color: AppColors.primaryDeafult, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    getBranchesError: (error) => Center(child: Text(error)),
                    orElse: () => const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey.shade500),
        horizontalSpace(4),
        Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
