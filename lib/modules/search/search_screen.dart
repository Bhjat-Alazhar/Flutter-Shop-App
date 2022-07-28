import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/modules/search/searchProducts_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search Screen',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 20, top: 10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                      },
                      onFieldSubmitted: (String text) {
                        ShopCubit.get(context).getSearchData(text: text);
                      },
                      decoration: InputDecoration(
                          label: Text('Search'),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder())),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (state is SearchLoadingState ||
                      state is ShopChangeFavoritesState)
                    LinearProgressIndicator(),
                  if (state is SearchSuccessState ||
                      state is ShopFavoritesGetDataSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildSearchProductItem(
                                  ShopCubit.get(context)
                                      .searchModel!
                                      .data
                                      .data![index],
                                  context,
                                  index,
                                  searchController.text),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: ShopCubit.get(context)
                              .searchModel!
                              .data
                              .data!
                              .length),
                    ),
                  if (state is SearchErrorState)
                    Text(
                      'No Results Founded',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchProductItem(model, context, index, text) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            navigateTo(context, SearchProductScreen(index));
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
                            '${model.price}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
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
                                    Icons.add_shopping_cart_outlined,
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
