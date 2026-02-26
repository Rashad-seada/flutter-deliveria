part of 'branches_cubit.dart';

abstract class BranchesState {}

class BranchesInitial extends BranchesState {}

class BranchesLoading extends BranchesState {}

class BranchesLoaded extends BranchesState {
  final List<BranchModel> branches;
  final BranchModel? parent;
  
  BranchesLoaded(this.branches, this.parent);
}

class BranchesError extends BranchesState {
  final String message;
  
  BranchesError(this.message);
}

class BranchActionLoading extends BranchesState {}

class BranchActionSuccess extends BranchesState {
  final String message;
  
  BranchActionSuccess(this.message);
}

class BranchActionError extends BranchesState {
  final String message;
  
  BranchActionError(this.message);
}
