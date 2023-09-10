import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/formButton.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/text_form_field.dart';
import 'package:ecommerce/features/home/presentation/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../managers/auth_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                builder: (context) => const HomeView(),
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
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/shopping-seamless-pattern-with-colorful-doodle_67074-1139.jpg'),
                    opacity: 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 150,
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          buildTextFormField(
                              label: 'User Name',
                              prefixIcon: Icons.person,
                              controller: userNameController,
                              keyboardType: TextInputType.name),
                          //user name

                          const SizedBox(
                            height: 20,
                          ),

                          buildTextFormField(
                            label: 'Email',
                            prefixIcon: Icons.email,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          buildPasswordTextFormField(),
                          //password

                          const SizedBox(
                            height: 20,
                          ),

                          buildTextFormField(
                            label: 'Phone',
                            prefixIcon: Icons.phone,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          buildFormButton(
                            text: state is RegisterLoadingState
                                ? 'Loading...'
                                : 'Register',
                            onPressed: () {
                              if (formKey.currentState!.validate() == true) {
                                BlocProvider.of<AuthCubit>(context).registerUser(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          // register button

                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
                          label: const Text(
                            'password',
                            style: TextStyle(fontSize: 20),
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
