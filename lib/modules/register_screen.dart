import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(state.registerModel.message, Colors.green));
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                pushAndFinish(context, ShopAppLayout());
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(state.registerModel.message, Colors.red));
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black)),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            decoration: InputDecoration(
                                label: Text('Name'),
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder())),
                        SizedBox(height: 15.0,),
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
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is too shot';
                            }
                          },
                          decoration: InputDecoration(
                            label: Text('Password'),
                            prefixIcon: Icon(Icons.lock_outlined),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: ShopCubit.get(context).isObscureRegister
                                  ? Icon(Icons.visibility_outlined)
                                  : Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                ShopCubit.get(context).showPasswordRegister();
                              },
                            ),
                          ),
                          obscureText: ShopCubit.get(context).isObscureRegister,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            decoration: InputDecoration(
                                label: Text('Phone number'),
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder())),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                try{
                                  if (formKey.currentState!.validate()) {
                                    ShopCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text);
                                  }
                                }catch(error){
                                  print(error.toString());
                                }

                              },
                              text: 'Register'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );

  }
}
