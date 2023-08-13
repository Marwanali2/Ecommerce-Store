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
  final userNameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final phoneController=TextEditingController();

  bool obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is RegisterSuccessState){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(),),);
            }
            else if(state is RegisterFailureState){
              showDialog(context: context, builder: (context) {
                return AlertDialog(content: Text('${state.errorMessage}',style: TextStyle(color: Colors.white,),),backgroundColor: Colors.red,);
              },
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 150,
                  ),
                  child: Form(
                    key: formKey,
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
                            keyboardType: TextInputType.emailAddress,),
                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
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
                        ),
                        //password

                        const SizedBox(
                          height: 20,
                        ),

                        buildTextFormField(
                            label: 'Phone',
                            prefixIcon: Icons.phone,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,),

                        const SizedBox(
                          height: 20,
                        ),

                        buildFormButton(
                          text:state is RegisterLoadingState? 'Loading...':'Register',
                          onPressed: () {
                            if (formKey.currentState!.validate()==true) {
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
                            const Text('Already have an account? '),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Login',
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
            );
          },
        ),
      ),
    );
  }

  SizedBox buildFormButton({required void Function() onPressed,required String text}) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            Colors.blue.withOpacity(0.5),
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.purple,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
        ),
        child:  Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(
      {required String label,
      required IconData prefixIcon,
      required TextEditingController controller,
      required TextInputType keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (controller.text.isEmpty) {
          return 'Please Enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon,),
        enabled: true,
        label: Text(
          label,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ), // shape of border when validator is empty
      ),
    );
  }
}
