import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? userName;
  String? email;
  int? phone;
  String? password;
  bool obscureText=true;
  GlobalKey<FormState>formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 150,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter User Name';
                      }
                    },
                    onFieldSubmitted: (value) {
                      userName=value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      enabled: true,
                      label: const Text(
                        'User Name',
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
                  ), //user name

                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    onFieldSubmitted: (value) {
                      email=value;
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter Email';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      enabled: true,
                      label: const Text(
                        'Email',
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
                  ), //email

                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    obscureText: obscureText,
                    obscuringCharacter: '*',
                    onFieldSubmitted: (value) {
                      password=value;
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter password';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText=!obscureText;
                          });
                        },
                        child: obscureText?Icon(CupertinoIcons.eye,color: Colors.black,):Icon(CupertinoIcons.eye_slash,color: Colors.black,),),
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
                  ), //password

                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    onFieldSubmitted: (value) {
                      phone=value as int?;
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter phone';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      enabled: true,
                      label: const Text(
                        'phone',
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
                  ), //phone

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){}else{}
                      },
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
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ), // register button

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
                  ), // login row
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
