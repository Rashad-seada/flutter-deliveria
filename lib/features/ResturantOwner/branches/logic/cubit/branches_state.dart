import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delveria/features/ResturantOwner/branches/data/models/branch_model.dart';

part 'branches_state.freezed.dart';

@freezed
class BranchesState<T> with _$BranchesState<T> {
  const factory BranchesState.initial() = _Initial;
  
  const factory BranchesState.loading() = Loading;
  const factory BranchesState.getBranchesSuccess(GetBranchesResponse data) = GetBranchesSuccess;
  const factory BranchesState.getBranchesError(String error) = GetBranchesError;

  const factory BranchesState.createBranchLoading() = CreateBranchLoading;
  const factory BranchesState.createBranchSuccess(dynamic data) = CreateBranchSuccess;
  const factory BranchesState.createBranchError(String error) = CreateBranchError;

  const factory BranchesState.updateBranchLoading() = UpdateBranchLoading;
  const factory BranchesState.updateBranchSuccess(dynamic data) = UpdateBranchSuccess;
  const factory BranchesState.updateBranchError(String error) = UpdateBranchError;

  const factory BranchesState.toggleBranchStatusLoading() = ToggleBranchStatusLoading;
  const factory BranchesState.toggleBranchStatusSuccess(dynamic data) = ToggleBranchStatusSuccess;
  const factory BranchesState.toggleBranchStatusError(String error) = ToggleBranchStatusError;

  const factory BranchesState.deleteBranchLoading() = DeleteBranchLoading;
  const factory BranchesState.deleteBranchSuccess(dynamic data) = DeleteBranchSuccess;
  const factory BranchesState.deleteBranchError(String error) = DeleteBranchError;
}
