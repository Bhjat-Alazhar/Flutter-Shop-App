import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';


class DetailsProductScreen extends StatelessWidget {
  final int itemIndex;

  const DetailsProductScreen(this.itemIndex);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              elevation: 0,
              title: Text('${ShopCubit.get(context).homeModel!.data.products[itemIndex].name}',maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            body: detailsBody(
                ShopCubit.get(context).homeModel!.data.products[itemIndex],
                context));
      },
    );
  }

  Widget detailsBody(ProductModel model, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    height: 380,
                    width: 300,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Image(
                              image: NetworkImage(model.image),
                              width: double.infinity,
                              height: 200.0,
                            ),
                            if (model.discount != 0)
                              Container(
                                color: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.name,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.4,
                                    color: Colors.black),
                              ),
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
                                  if (model.discount != 0)
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
                                        ShopCubit.get(context)
                                            .changeFavorite(model.id);
                                      },
                                      icon: ConditionalBuilder(
                                        condition: ShopCubit.get(context)
                                                .favorites[model.id] ==
                                            true,
                                        builder: (context) => CircleAvatar(
                                          backgroundColor: defaultColor,
                                          radius: 30,
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        fallback: (context) => CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 30,
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            size: 20,
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
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
                'Description',style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(model.description),
            ),
          ],
        ),
      );
}
