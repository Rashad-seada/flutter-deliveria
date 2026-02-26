import 'package:delveria/features/admin/loyalty/data/models/admin_loyalty_models.dart';
import 'package:delveria/features/admin/loyalty/data/repo/admin_loyalty_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// States
abstract class AdminLoyaltyState {}

class AdminLoyaltyInitial extends AdminLoyaltyState {}

class AdminLoyaltyLoading extends AdminLoyaltyState {}

class AdminLoyaltyTiersLoaded extends AdminLoyaltyState {
  final List<AdminRewardTier> tiers;
  AdminLoyaltyTiersLoaded(this.tiers);
}

class AdminLoyaltyUsersLoaded extends AdminLoyaltyState {
  final List<UserPointsSummary> users;
  AdminLoyaltyUsersLoaded(this.users);
}

class AdminLoyaltyError extends AdminLoyaltyState {
  final String message;
  AdminLoyaltyError(this.message);
}

class AdminLoyaltyOperationSuccess extends AdminLoyaltyState {
  final String message;
  AdminLoyaltyOperationSuccess(this.message);
}

// Cubit
class AdminLoyaltyCubit extends Cubit<AdminLoyaltyState> {
  final AdminLoyaltyRepo _repo;
  
  List<AdminRewardTier> _cachedTiers = [];
  List<UserPointsSummary> _cachedUsers = [];
  
  AdminLoyaltyCubit(this._repo) : super(AdminLoyaltyInitial());

  int _currentPage = 1;
  static const int _limit = 20;
  bool _isLoadingMore = false;
  bool _hasReachedMax = false;
  String? _currentSearchQuery;

  List<AdminRewardTier> get cachedTiers => _cachedTiers;
  List<UserPointsSummary> get cachedUsers => _cachedUsers;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasReachedMax => _hasReachedMax;

  /// Fetch all reward tiers
  Future<void> fetchTiers() async {
    if (isClosed) return;
    emit(AdminLoyaltyLoading());
    
    final result = await _repo.getAllTiers();
    if (isClosed) return;
    
    result.when(
      success: (response) {
        _cachedTiers = response.data ?? [];
        if (!isClosed) emit(AdminLoyaltyTiersLoaded(_cachedTiers));
      },
      failure: (error) {
        if (!isClosed) emit(AdminLoyaltyError(error.message ?? 'Failed to load tiers'));
      },
    );
  }

  /// Create a new tier
  Future<bool> createTier({
    required String name,
    required int pointsRequired,
    required num discountValue,
    required String discountType,
    num? maxDiscount,
    String? description,
  }) async {
    if (isClosed) return false;
    emit(AdminLoyaltyLoading());
    
    final result = await _repo.createTier(
      name: name,
      pointsRequired: pointsRequired,
      discountValue: discountValue,
      discountType: discountType,
      maxDiscount: maxDiscount,
      description: description,
    );
    if (isClosed) return false;
    
    bool success = false;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(AdminLoyaltyOperationSuccess('Tier created successfully'));
        success = true;
        fetchTiers(); // Refresh list
      },
      failure: (error) {
        if (!isClosed) emit(AdminLoyaltyError(error.message ?? 'Failed to create tier'));
      },
    );
    
    return success;
  }

  /// Update an existing tier
  Future<bool> updateTier(
    String tierId, {
    String? name,
    int? pointsRequired,
    num? discountValue,
    String? discountType,
    num? maxDiscount,
    String? description,
    bool? isActive,
  }) async {
    if (isClosed) return false;
    emit(AdminLoyaltyLoading());
    
    final result = await _repo.updateTier(
      tierId: tierId,
      name: name,
      pointsRequired: pointsRequired,
      discountValue: discountValue,
      discountType: discountType,
      maxDiscount: maxDiscount,
      description: description,
      isActive: isActive,
    );
    if (isClosed) return false;
    
    bool success = false;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(AdminLoyaltyOperationSuccess('Tier updated successfully'));
        success = true;
        fetchTiers();
      },
      failure: (error) {
        if (!isClosed) emit(AdminLoyaltyError(error.message ?? 'Failed to update tier'));
      },
    );
    
    return success;
  }

  /// Delete a tier
  Future<bool> deleteTier(String tierId) async {
    if (isClosed) return false;
    emit(AdminLoyaltyLoading());
    
    final result = await _repo.deleteTier(tierId);
    if (isClosed) return false;
    
    bool success = false;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(AdminLoyaltyOperationSuccess('Tier deleted successfully'));
        success = true;
        fetchTiers();
      },
      failure: (error) {
        if (!isClosed) emit(AdminLoyaltyError(error.message ?? 'Failed to delete tier'));
      },
    );
    
    return success;
  }

  /// Fetch users (Initial or Refresh)
  Future<void> fetchUsers({String? searchQuery, bool isRefresh = false}) async {
    if (isClosed) return;
    
    if (searchQuery != null) {
      _currentSearchQuery = searchQuery;
    }
    
    if (isRefresh || searchQuery != null) {
        _currentPage = 1;
        _hasReachedMax = false;
        _cachedUsers = [];
    }

    emit(AdminLoyaltyLoading());
    
    final result = await _repo.getUsersWithPoints(
      page: _currentPage,
      limit: _limit,
      searchQuery: _currentSearchQuery,
    );

    if (isClosed) return;
    
    result.when(
      success: (response) {
        final newUsers = response.data ?? [];
        if (newUsers.length < _limit) {
          _hasReachedMax = true;
        }
        _cachedUsers = newUsers;
        if (!isClosed) emit(AdminLoyaltyUsersLoaded(_cachedUsers));
      },
      failure: (error) {
        if (!isClosed) emit(AdminLoyaltyError(error.message ?? 'Failed to load users'));
      },
    );
  }

  /// Load more users (Infinite Scroll)
  Future<void> loadMoreUsers() async {
    if (isClosed || _isLoadingMore || _hasReachedMax) return;
    
    _isLoadingMore = true;
    // Emit loading state? Usually keep showing current list with spinner
    // For now we just append data and emit Loaded again
    
    final nextPage = _currentPage + 1;
    
    final result = await _repo.getUsersWithPoints(
      page: nextPage,
      limit: _limit,
      searchQuery: _currentSearchQuery,
    );
    
    _isLoadingMore = false;
    if (isClosed) return;

    result.when(
      success: (response) {
        final newUsers = response.data ?? [];
        if (newUsers.isNotEmpty) {
           _currentPage = nextPage;
           _cachedUsers.addAll(newUsers);
           if (newUsers.length < _limit) {
             _hasReachedMax = true;
           }
        } else {
          _hasReachedMax = true;
        }
        if (!isClosed) emit(AdminLoyaltyUsersLoaded(_cachedUsers));
      },
      failure: (error) {
        // Silent failure for pagination or show snackbar via listener
      },
    );
  }

  /// Adjust user points
  Future<bool> adjustUserPoints({
    required String userId,
    required int points,
    String? reason,
  }) async {
    if (isClosed) return false;
    emit(AdminLoyaltyLoading());
    
    final result = await _repo.adjustPoints(
      userId: userId,
      points: points,
      reason: reason,
    );
    if (isClosed) return false;
    
    bool success = false;
    
    result.when(
      success: (response) {
        if (!isClosed) emit(AdminLoyaltyOperationSuccess('Points adjusted successfully'));
        success = true;
        // Refresh the current list to reflect changes
        fetchUsers(isRefresh: true);
      },
      failure: (error) {
        if (!isClosed) emit(AdminLoyaltyError(error.message ?? 'Failed to adjust points'));
      },
    );
    
    return success;
  }
}
