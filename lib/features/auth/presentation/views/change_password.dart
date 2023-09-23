import 'package:ecommerce/features/auth/presentation/views/widgets/formButton.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentPassController = TextEditingController();
    var newPassController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    return SafeArea(
      child: Scaffold(
        backgroundColor: color3,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Change Password',
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
                    'Enter Current Password And New Password',
                    style: TextStyle(
                      fontSize: 15,
                      color: color5,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                const Text(
                  'Current Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02,
                ),
                buildTextFormField(
                    label: 'Enter Current Password',
                    prefixIcon: Icons.password,
                    controller: currentPassController,
                    keyboardType: TextInputType.name),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                ),
                const Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02,
                ),
                buildTextFormField(
                    label: 'Enter New Password',
                    prefixIcon: Icons.password,
                    controller: newPassController,
                    keyboardType: TextInputType.name),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.02,
                ),
                buildFormButton(
                  context: context,
                  text: 'Change Password',
                  onPressed: () {
                    if (formKey.currentState!.validate() == true) {

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
