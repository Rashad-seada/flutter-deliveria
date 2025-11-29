import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/fav/data/models/get_fav_response.dart';
import 'package:delveria/features/client/fav/data/repo/favorite_repo.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo favoriteRepo;
  FavoriteCubit(this.favoriteRepo) : super(FavoriteState.initial());
  List<FavouriteRestaurant> favRes = [];
  void addToFav({required String resId}) async {
    emit(FavoriteState.addToFavLoading());
    try {
      final response = await favoriteRepo.addToFav(resId: resId);
      response.when(
        success: (favres) {
          emit(FavoriteState.addToFavSuccess(favres));
        },
        failure: (error) => emit(FavoriteState.addToFavFail(error)),
      );
    } catch (e) {
      emit(FavoriteState.addToFavFail(ApiErrorHandler.handle(e)));
    }
  }

  void getFav() async {
    emit(FavoriteState.getFavLoading());
    try {
      final response = await favoriteRepo.getFav();
      response.when(
        success: (favres) {
          favRes = favres.response?.favourites??[];
          emit(FavoriteState.getFavSuccess(favres));
        },
        failure: (error) => emit(FavoriteState.getFavFail(error)),
      );
    } catch (e) {
      emit(FavoriteState.getFavFail(ApiErrorHandler.handle(e)));
    }
  }
  void deleteFav({required String resId}) async {
    emit(FavoriteState.deleteFavLoading());
    try {
      final response = await favoriteRepo.deleteFav(resId: resId);
      response.when(
        success: (favres) {
          emit(FavoriteState.deleteFavSuccess(favres));
        },
        failure: (error) => emit(FavoriteState.deleteFavFail(error)),
      );
    } catch (e) {
      emit(FavoriteState.deleteFavFail(ApiErrorHandler.handle(e)));
    }
  }
}
