import 'package:shop_app/models/Change_FavoritesModel.dart';
import 'package:shop_app/models/categoriesProduct_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/register_model.dart';

abstract class ShopStates {
  final HomeModel? homeModel;
  final CategoriesModel? categoriesModel;
  final FavoritesModel? favoritesModel;
  final ProfileModel? profileModel;
  ShopStates(
      {this.homeModel,
      this.categoriesModel,
      this.favoritesModel,
      this.profileModel});
}
class ShopInitialState extends ShopStates {

}

class ShopLoginChangePasswordVisibilityState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessState extends ShopStates {
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class SearchErrorState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopHomeGetDataSuccessState extends ShopStates {
  final HomeModel homeModel;

  ShopHomeGetDataSuccessState(this.homeModel) : super(homeModel: homeModel);
}

class ShopHomeGetDataLoadingState extends ShopStates {}

class ShopHomeGetDataErrorState extends ShopStates {
  final String error;

  ShopHomeGetDataErrorState(this.error);
}

class ShopCategoriesGetDataSuccessState extends ShopStates {
  final CategoriesModel categoriesModel;

  ShopCategoriesGetDataSuccessState(this.categoriesModel)
      : super(categoriesModel: categoriesModel);
}

class ShopCategoriesGetDataLoadingState extends ShopStates {}

class ShopCategoriesGetDataErrorState extends ShopStates {
  final String error;

  ShopCategoriesGetDataErrorState(this.error);
}

class ShopCategoriesProductGetDataSuccessState extends ShopStates {
  final CategoriesProductModel categoriesProductModel;

  ShopCategoriesProductGetDataSuccessState(this.categoriesProductModel);
}

class ShopCategoriesProductGetDataLoadingState extends ShopStates {}

class ShopCategoriesProductGetDataErrorState extends ShopStates {
  final String error;

  ShopCategoriesProductGetDataErrorState(this.error);
}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesErrorState extends ShopStates {}

class ShopFavoritesGetDataSuccessState extends ShopStates {
  final FavoritesModel favoritesModel;

  ShopFavoritesGetDataSuccessState(this.favoritesModel)
      : super(favoritesModel: favoritesModel);
}

class ShopFavoritesGetDataLoadingState extends ShopStates {}

class ShopFavoritesGetDataErrorState extends ShopStates {
  final String error;

  ShopFavoritesGetDataErrorState(this.error);
}

class ShopGetProfileDataSuccessState extends ShopStates {
  final ProfileModel userModel;

  ShopGetProfileDataSuccessState(this.userModel)
      : super(profileModel: userModel);
}

class ShopGetProfileDataErrorState extends ShopStates {
  final String error;

  ShopGetProfileDataErrorState(this.error);
}

class ShopUpdateDataSuccessState extends ShopStates {
  final ProfileModel userModel;

  ShopUpdateDataSuccessState(this.userModel);
}

class ShopUpdateDataLoadingState extends ShopStates {}

class ShopUpdateDataErrorState extends ShopStates {
  final String error;

  ShopUpdateDataErrorState(this.error);
}

class ShopRegisterInitialState extends ShopStates {}

class ShopRegisterChangePasswordVisibilityState extends ShopStates {}

class ShopRegisterLoadingState extends ShopStates {}

class ShopRegisterSuccessState extends ShopStates {
  final RegisterModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopStates {
  final String error;

  ShopRegisterErrorState(this.error);
}
