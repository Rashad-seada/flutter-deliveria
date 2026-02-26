import 'package:bloc/bloc.dart';
import 'package:delveria/features/ResturantOwner/branches/data/repo/branches_repo.dart';
import 'package:delveria/features/ResturantOwner/branches/logic/cubit/branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  final BranchesRepo _branchesRepo;

  BranchesCubit(this._branchesRepo) : super(const BranchesState.initial());

  Future<void> getBranches(String restaurantId) async {
    emit(const BranchesState.loading());
    final response = await _branchesRepo.getBranches(restaurantId);
    response.when(
      success: (data) => emit(BranchesState.getBranchesSuccess(data)),
      failure: (error) => emit(BranchesState.getBranchesError(error.message ?? "")),
    );
  }

  Future<void> createBranch(String restaurantId, Map<String, dynamic> body) async {
    emit(const BranchesState.createBranchLoading());
    final response = await _branchesRepo.createBranch(restaurantId, body);
    response.when(
      success: (data) => emit(BranchesState.createBranchSuccess(data)),
      failure: (error) => emit(BranchesState.createBranchError(error.message ?? "")),
    );
  }

  Future<void> updateBranch(String branchId, Map<String, dynamic> body) async {
    emit(const BranchesState.updateBranchLoading());
    final response = await _branchesRepo.updateBranch(branchId, body);
    response.when(
      success: (data) => emit(BranchesState.updateBranchSuccess(data)),
      failure: (error) => emit(BranchesState.updateBranchError(error.message ?? "")),
    );
  }

  Future<void> toggleBranchStatus(String branchId) async {
    emit(const BranchesState.toggleBranchStatusLoading());
    final response = await _branchesRepo.toggleBranchStatus(branchId);
    response.when(
      success: (data) => emit(BranchesState.toggleBranchStatusSuccess(data)),
      failure: (error) => emit(BranchesState.toggleBranchStatusError(error.message ?? "")),
    );
  }

  Future<void> deleteBranch(String branchId) async {
    emit(const BranchesState.deleteBranchLoading());
    final response = await _branchesRepo.deleteBranch(branchId);
    response.when(
      success: (data) => emit(BranchesState.deleteBranchSuccess(data)),
      failure: (error) => emit(BranchesState.deleteBranchError(error.message ?? "")),
    );
  }
}
