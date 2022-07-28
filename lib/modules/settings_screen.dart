import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileModel = ShopCubit.get(context).profileModel;
        nameController.text = profileModel!.data.name;
        emailController.text = profileModel.data.email;
        phoneController.text = profileModel.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateDataLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Name'),
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder())),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Email Address'),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder())),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number must not be empty';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Phone Number'),
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder())),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: 'update',
                      isUpperCase: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultButton(
                        function: () {
                          CacheHelper.clearData(key: 'token').then((value) {
                            if (value)
                              pushAndFinish(context, ShopLoginScreen());
                            ShopCubit.get(context).currentIndex = 0;
                          });
                        },
                        text: ' logout'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
