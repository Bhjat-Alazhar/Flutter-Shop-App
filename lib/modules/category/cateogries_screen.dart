import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'detailsCategory_Screen.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel != null,
            builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index],context,index),
                separatorBuilder: (context, index) => Divider(),
                itemCount:ShopCubit.get(context).categoriesModel!.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),

          );
        });
  }

  Widget buildCatItem(DataModel model , context,index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: (){
            ShopCubit.get(context).getProductCategoriesData(id:model.id);
            navigateTo(context,DetailsCategoryScreen(index));
          },
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                model.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      );
}
