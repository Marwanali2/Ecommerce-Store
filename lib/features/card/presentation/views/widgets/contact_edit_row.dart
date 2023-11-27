import 'package:ecommerce/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../auth/presentation/views/register_view.dart';
import '../../../../profile/presentation/managers/user_data_cubit.dart';

// ignore: must_be_immutable
class ContactEditRow extends StatefulWidget {
  static String theInputUserText = '';
  ContactEditRow({
    super.key,
    required this.icon,
    required this.mainText,
    required this.textType,
    this.onEditIconPressed,
    this.activeEdit = false,
    this.keyboardType,
  });

  final IconData icon;
  final String mainText;
  final String textType;
  final void Function()? onEditIconPressed;
  bool activeEdit;
  TextInputType? keyboardType;

  @override
  State<ContactEditRow> createState() => _ContactEditRowState();
}

class _ContactEditRowState extends State<ContactEditRow> {
  @override
  Widget build(BuildContext context) {
    UserDataCubit userDataCubit = BlocProvider.of<UserDataCubit>(context);
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: color12,
            maxRadius: 25,
            child: Icon(widget.icon) //icon,
            ),
        const SizedBox(
          width: 12,
        ),
        widget.activeEdit
            ? SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.65,
                child: CustomTextField(
                  keyboardType: widget.keyboardType,
                  label: 'Edit Your ${widget.textType}',
                  hintText: 'New ${widget.textType}',
                  onFieldSubmitted: (inputText) {
                    setState(() {
                      ContactEditRow.theInputUserText = inputText;
                      if (widget.textType == 'Name') {
                        inputText.isEmpty
                            ? userDataCubit.userModel?.name
                            : userDataCubit.userModel?.name = inputText;
                      } else if (widget.textType == 'Email') {
                        inputText.isEmpty
                            ? userDataCubit.userModel?.email
                            : userDataCubit.userModel?.email = inputText;
                      } else if (widget.textType == 'Phone') {
                        inputText.isEmpty
                            ? userDataCubit.userModel?.phone
                            : userDataCubit.userModel?.phone = inputText;
                      }
                      userDataCubit.editUser(
                        name: userDataCubit.userModel?.name,
                        email: userDataCubit.userModel?.email,
                        password: RegisterView.thePassword,
                        phone: userDataCubit.userModel?.phone,
                      );
                      widget.activeEdit = false;
                    });
                  },
                  inputTextColor: Colors.black,
                  borderColor: color9,
                  enabledBorderColor: color9,
                  focusedBorderColor: Colors.green,
                  labelTextColor: Colors.black,
                  hintTextColor: color5,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mainText,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: color10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    widget.textType,
                    style: const TextStyle(
                      color: color5,
                    ),
                  ),
                ],
              ),
        const Spacer(),
        widget.activeEdit
            ? GestureDetector(
                onTap: widget.onEditIconPressed,
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/svg/edit_Icon.svg',
                    width: 28.w,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    widget.activeEdit = true;
                  });
                },
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/svg/edit_Icon.svg',
                    width: 25.w,
                  ),
                ),
              ),
      ],
    );
  }
}
