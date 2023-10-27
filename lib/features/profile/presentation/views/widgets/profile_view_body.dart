import 'dart:io';

import 'package:ecommerce/features/profile/presentation/managers/user_data_cubit.dart';
import 'package:ecommerce/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/colors.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({Key? key}) : super(key: key);

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {

    File?_selectedImage;
    Future _pickImageFromGalley()async{
      final returnedImage=await ImagePicker().pickImage(source: ImageSource.camera,);
      setState(() {
        _selectedImage=File(returnedImage!.path);
      });
    }

    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=BlocProvider.of<UserDataCubit>(context);
       return cubit.userModel!=null?
        Column(
       //  mainAxisAlignment: MainAxisAlignment.center,
         children: [
           // Text(cubit.userModel?.name??"john"),0

           // Text(cubit.userModel?.email??"johnDoe42@gmail.com"),
           // Text(cubit.userModel?.phone??"+01125727329"),
           const Center(
             child: Padding(
               padding: EdgeInsets.only(left: 10, top: 10, right: 10),
               child:  Text(
                 'Profile',
                 style: TextStyle(
                   color: color4,
                   //fontFamily: 'DancingScript',
                   fontSize: 20,
                 ),
               ),
             ),
           ),
           const SizedBox(height: 32,),
           Stack(
             children: [
                const CircleAvatar(
                 backgroundColor: Colors.grey,
                 maxRadius: 80,
               // backgroundImage: FileImage (image!),
               ),
               Positioned(
                 bottom: 0,
                 right: 0,
                 child:  CircleAvatar(
                   backgroundColor: Colors.black,
                   maxRadius: 25,
                   child: IconButton(onPressed: (){
                     _pickImageFromGalley();
                   }, icon: Icon(Icons.camera_alt,color: Colors.white,size: 25,))
                 ),
               ),
             ],
           ),
           const SizedBox(height: 32,),
           _selectedImage!=null?Image.file(_selectedImage!):Text('NONONONo'),
           ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) {
               return ProfileView();
             },));
           }, child: Text('profile view',),),
         ],
       )
           : const Center(child: CircularProgressIndicator(),);
      },
    );
  }



}

