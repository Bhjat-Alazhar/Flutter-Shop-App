import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/models/categoriesProduct_model.dart';
import 'detailsCategoryProduct_Screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class DetailsCategoryScreen extends StatelessWidget {
  final int index;
  DetailsCategoryScreen( this.index);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${ ShopCubit.get(context).categoriesModel!.data.data[index].name}'),
          ),
          body: Column(
            children: [
              if (state is ShopCategoriesProductGetDataLoadingState ||
                  state is ShopChangeFavoritesState)
                LinearProgressIndicator(),
              if (state is ShopCategoriesProductGetDataSuccessState ||
                  state is ShopChangeFavoritesSuccessState ||
                  state is ShopFavoritesGetDataSuccessState)
                Expanded(
                  child: ConditionalBuilder(
                    condition:
                        ShopCubit.get(context).categoriesProductModel != null,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCategoriesProductItem(
                                ShopCubit.get(context)
                                    .categoriesProductModel!
                                    .data
                                    .data[index],
                                context,
                                index),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: ShopCubit.get(context)
                            .categoriesProductModel!
                            .data
                            .data
                            .length),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCategoriesProductItem(Product model, context, index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            navigateTo(context, DetailsCategoryProductScreen(index));
          },
          child: Container(
            height: 120,
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage('${model.image}'),
                      width: 120,
                      height: 120,
                    ),
                    if (model.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      )
                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, height: 1.4),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (1 != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: TextStyle(
                                fontSize: 10.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context).changeFavorite(model.id);
                              },
                              icon: ConditionalBuilder(
                                condition: ShopCubit.get(context)
                                        .favorites[model.id] ==
                                    true,
                                builder: (context) => CircleAvatar(
                                  backgroundColor: defaultColor,
                                  radius: 25,
                                  child: Icon(
                                    Icons.remove_shopping_cart_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                fallback: (context) => CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 25,
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
