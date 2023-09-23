import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/formButton.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/text_form_field.dart';
import 'package:ecommerce/features/home/presentation/views/home_view.dart';
import 'package:ecommerce/features/layout/presentation/views/layout_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../managers/auth_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static final passwordController = TextEditingController();
  static final String thePassword=passwordController.text;
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  bool obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LayoutView(),
              ),
            );
          }
          else if (state is RegisterFailureState) {
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
               padding:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.03,left: MediaQuery.sizeOf(context).width*0.03,top: MediaQuery.sizeOf(context).height*0.03,bottom: MediaQuery.sizeOf(context).height*0.01,),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: const Text(
                              'Register Account',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Center(
                            child: Text(
                              'Fill your details to Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                                color: color5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.03,
                          ),
                          const Text(
                            'Your Name',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.02,
                          ),
                          buildTextFormField(
                              label: 'User Name',
                              prefixIcon: Icons.person,
                              controller: userNameController,
                              keyboardType: TextInputType.name),
                          //user name

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.03,
                          ),
                          const Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.02,
                          ),
                          buildTextFormField(
                            label: 'Email',
                            prefixIcon: Icons.email,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.03,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.02,
                          ),
                          buildPasswordTextFormField(),
                          //password

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.03,
                          ),
                          const Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.02,
                          ),
                          buildTextFormField(
                            label: 'Phone',
                            prefixIcon: Icons.phone,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*0.03,
                          ),

                          buildFormButton(
                            context: context,
                            text: state is RegisterLoadingState
                                ? 'Loading...'
                                : 'Register',
                            onPressed: () {
                              if (formKey.currentState!.validate() == true) {
                                BlocProvider.of<AuthCubit>(context).registerUser(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  password: RegisterView.passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          // register button

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: color5)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
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
              ));
        },
      ),
    );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
                        controller: RegisterView.passwordController,
                        obscureText: obscureText,
                        obscuringCharacter: '*',
                        cursorColor: color9,
                        validator: (value) {
                          if (RegisterView.passwordController.text.isEmpty) {
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
                          label: const Text(
                            '●●●●●●',
                            style: TextStyle(fontSize: 15,color: color5,),
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
