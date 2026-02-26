import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/branch_model.dart';
import 'package:delveria/features/admin/resturantAdmin/data/repo/branches_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  final BranchesRepo branchesRepo;
  
  BranchesCubit(this.branchesRepo) : super(BranchesInitial());

  List<BranchModel> branches = [];
  BranchModel? parentRestaurant;

  Future<void> getBranches(String restaurantId) async {
    if (isClosed) return;
    emit(BranchesLoading());
    
    final result = await branchesRepo.getBranches(restaurantId: restaurantId);
    if (isClosed) return;
    
    result.when(
      success: (response) {
        parentRestaurant = response.data?.parent;
        branches = response.data?.branches ?? [];
        if (!isClosed) emit(BranchesLoaded(branches, parentRestaurant));
      },
      failure: (error) {
        if (!isClosed) emit(BranchesError(error.message ?? 'Failed to load branches'));
      },
    );
  }

  Future<void> createBranch(String restaurantId, Map<String, dynamic> data) async {
    if (isClosed) return;
    emit(BranchActionLoading());
    
    final result = await branchesRepo.createBranch(
      restaurantId: restaurantId,
      branchData: data,
    );
    if (isClosed) return;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(BranchActionSuccess('Branch created successfully'));
        getBranches(restaurantId); // Refresh list
      },
      failure: (error) {
        if (!isClosed) emit(BranchActionError(error.message ?? 'Failed to create branch'));
      },
    );
  }

  Future<void> updateBranch(String branchId, String restaurantId, Map<String, dynamic> data) async {
    if (isClosed) return;
    emit(BranchActionLoading());
    
    final result = await branchesRepo.updateBranch(
      branchId: branchId,
      branchData: data,
    );
    if (isClosed) return;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(BranchActionSuccess('Branch updated successfully'));
        getBranches(restaurantId); // Refresh list
      },
      failure: (error) {
        if (!isClosed) emit(BranchActionError(error.message ?? 'Failed to update branch'));
      },
    );
  }

  Future<void> deleteBranch(String branchId, String restaurantId) async {
    if (isClosed) return;
    emit(BranchActionLoading());
    
    final result = await branchesRepo.deleteBranch(branchId: branchId);
    if (isClosed) return;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(BranchActionSuccess('Branch deleted successfully'));
        getBranches(restaurantId); // Refresh list
      },
      failure: (error) {
        if (!isClosed) emit(BranchActionError(error.message ?? 'Failed to delete branch'));
      },
    );
  }

  Future<void> toggleBranch(String branchId, String restaurantId) async {
    if (isClosed) return;
    emit(BranchActionLoading());
    
    final result = await branchesRepo.toggleBranch(branchId: branchId);
    if (isClosed) return;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(BranchActionSuccess('Branch status updated'));
        getBranches(restaurantId); // Refresh list
      },
      failure: (error) {
        if (!isClosed) emit(BranchActionError(error.message ?? 'Failed to toggle branch'));
      },
    );
  }
}
