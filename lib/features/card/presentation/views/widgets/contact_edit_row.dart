import 'package:ecommerce/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../profile/presentation/managers/user_data_cubit.dart';

class ContactEditRow extends StatefulWidget {

  ContactEditRow({
    super.key,
    required this.icon,
    required this.mainText,
    required this.textType,
    this.onEditIconPressed,
    this.activeEdit = false,
  });

  final IconData icon;
  final String mainText;
  final String textType;
  final void Function()? onEditIconPressed;
  bool activeEdit;

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
            backgroundColor: color12, maxRadius: 25, child: Icon(widget.icon) //icon,
            ),
        const SizedBox(
          width: 12,
        ),
        widget.activeEdit
            ? SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.65,
                child: CustomTextField(
                  label: 'Edit Your Name',
                  hintText: 'New name',
                 onFieldSubmitted: (inputText) {
                    setState(() {
                      userDataCubit.userModel?.name=inputText;
                      widget.activeEdit=false;
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
                    style: const TextStyle(
                      fontSize: 15,
                      color: color10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
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
      widget.activeEdit?
          GestureDetector(
           onTap: widget.onEditIconPressed,
            child: Container(
              width: 35,
              height: 60,
              decoration: BoxDecoration(
                color: color9,
                borderRadius: BorderRadius.circular(10,),
              ),
              child: Icon(Icons.check,),
            ),
          )
          :GestureDetector(
        //  onTap: widget.onEditIconPressed,
        onTap: () {
          setState(() {
            widget.activeEdit=true;
          });
        },
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/svg/edit_Icon.svg',
              width: 28,
            ),
          ),
        ),
      ],
    );
  }
}