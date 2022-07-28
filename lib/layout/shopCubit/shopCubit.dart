import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/models/Change_FavoritesModel.dart';
import 'package:shop_app/models/categoriesProduct_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/search_model.dart';
import '../../modules/category/cateogries_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import '../../modules/home/products_screen.dart';
import '../../modules/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/api_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  bool isObscure = true;

  void showPassword() {
    isObscure = !isObscure;
    emit(ShopLoginChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': '$email',
      'password': '$password',
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopHomeGetDataLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });

      });


      emit(ShopHomeGetDataSuccessState(homeModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeGetDataErrorState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopCategoriesGetDataLoadingState());
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesGetDataSuccessState(categoriesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesGetDataErrorState(error));
    });
  }

  CategoriesProductModel? categoriesProductModel;

  void getProductCategoriesData({required int id}) {
    emit(ShopCategoriesProductGetDataLoadingState());
    DioHelper.getData(
            url: GET_CATEGORIES_Product,
            query: {'category_id': id},
            token: token)
        .then((value) {
      categoriesProductModel = CategoriesProductModel.fromJson(value.data);
      emit(ShopCategoriesProductGetDataSuccessState(categoriesProductModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesProductGetDataErrorState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);


      print(value.data.toString());
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopChangeFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopFavoritesGetDataLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      favoritesModel!.data.data.forEach((element) {
      });
      emit(ShopFavoritesGetDataSuccessState(favoritesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesGetDataErrorState(error));
    });
  }

  ProfileModel? profileModel;

  void getProfileData() {
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ShopGetProfileDataSuccessState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileDataErrorState(error));
    });
  }

  RegisterModel? registerModel;
  bool isObscureRegister = true;

  void showPasswordRegister() {
    isObscureRegister = !isObscureRegister;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void updateData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateDataLoadingState());
    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ShopUpdateDataSuccessState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateDataErrorState(error));
    });
  }
  SearchModel? searchModel;

  void getSearchData({
    required String text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {

      emit(SearchErrorState());
    });
  }
}
