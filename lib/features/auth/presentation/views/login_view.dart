import 'package:ecommerce/core/utils/app_router.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:ecommerce/core/widgets/show_snack_bar.dart';
import 'package:ecommerce/features/auth/presentation/views/register_view.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/formButton.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/text_form_field.dart';
import 'package:ecommerce/features/splach/presentation/splach_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/colors.dart';
import '../../../layout/presentation/views/layout_view.dart';
import '../managers/auth_cubit.dart';

import '../../../profile/presentation/managers/user_data_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static UserDataCubit userDataCubit = UserDataCubit();
  static String emailTest = '';
  static String passwordTest = '';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          userToken == LoginView.userDataCubit.userModel?.token;
          if (state is LoginSuccessState) {
            userToken == LoginView.userDataCubit.userModel?.token;
            /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashView(),
                )); */
            GoRouter.of(context).push(AppRouter.kLayoutView);
          } else if (state is LoginFailureState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    '${state.errorMessage}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: color3,
            body: Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width * 0.03,
                left: MediaQuery.sizeOf(context).width * 0.03,
                top: MediaQuery.sizeOf(context).height * 0.1,
                bottom: MediaQuery.sizeOf(context).height * 0.01,
              ),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Hello Again!',
                            style: TextStyle(
                              fontSize: 33.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: Text(
                            'Fill your details to sign in',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: color5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),
                        Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        buildTextFormField(
                          label: 'xyz@gmail.com',
                          prefixIcon: Icons.email,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        buildPasswordTextFormField(), //password
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.1,
                        ),

                        buildFormButton(
                          context: context,
                          text: state is LoginLoadingState
                              ? 'Loading...'
                              : 'Sign In',
                          onPressed: () {
                            LoginView.emailTest = emailController.text;
                            LoginView.passwordTest = passwordController.text;
                            if (formKey.currentState!.validate() == true) {
                              BlocProvider.of<AuthCubit>(context).loginUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              //GoRouter.of(context).push(AppRouter.kmain);
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New User?',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: color5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterView(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // login row
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: (value) {
        if (passwordController.text.isEmpty) {
          return 'Please Enter password';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: obscureText
              ? const Icon(
                  CupertinoIcons.eye,
                  color: Colors.black,
                )
              : const Icon(
                  CupertinoIcons.eye_slash,
                  color: Colors.black,
                ),
        ),
        enabled: true,
        label: Text(
          '●●●●●●',
          style: TextStyle(
            fontSize: 13.sp,
            color: color5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    );
  }
}
