import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopCubit/shopCubit.dart';
import 'package:shop_app/layout/shopCubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopLoginSuccessState) {
        if (state.loginModel.status) {
          ScaffoldMessenger.of(context).showSnackBar(
              buildSnackBar(state.loginModel.message, Colors.green));
          CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token)
              .then((value) {
            token = state.loginModel.data!.token;
            pushAndFinish(context, ShopAppLayout());
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              buildSnackBar(state.loginModel.message, Colors.red));
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LOGIN', style: Theme.of(context).textTheme.bodyText1),
                    Text(
                      'Login now to browse our hot offers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
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
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: ShopCubit.get(context).isObscure
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            ShopCubit.get(context).showPassword();
                          },
                        ),
                      ),
                      obscureText: ShopCubit.get(context).isObscure,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'Login'),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 18, color: Colors.grey),
                        ),
                        defaultTextButton(
                            function: () {
                              navigateTo(context, RegisterScreen());
                            },
                            text: 'Register'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
