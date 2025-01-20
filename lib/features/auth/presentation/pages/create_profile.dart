// // ignore_for_file: unused_field

// import 'dart:io';
// import 'package:flutter/material.dart';
// import "package:flutter_screenutil/flutter_screenutil.dart";
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/util/sign_up_controller.dart';
// import '../bloc/create_profile/create_profile_bloc.dart';
// import '../bloc/create_profile/create_profile_event.dart';

// class CreateProfile extends StatefulWidget {
//   const CreateProfile({super.key});

//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }

// class _CreateProfileState extends State<CreateProfile> {
//   late final File image;
//   final List<String> genders = ["MALE", "FEMALE"];
//   final _formKey = GlobalKey<FormState>();
//   final SignUpController _signUpController = SignUpController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();

//   late CreateProfileBloc _createProfileBloc;
//   String? _country;
//   String? _state;
//   String? _city;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     //   final UserRepository repository = UserRepository();
//     _createProfileBloc = BlocProvider.of<CreateProfileBloc>(context);
//     // _createProfileBloc = CreateProfileBloc(widget.userRepository);
//   }

//   @override
//   void dispose() {
//     _createProfileBloc.add(ProfileReset());
//     super.dispose();
//   }

//   void _handleProfile() {
//     var bloc = _createProfileBloc.state;
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       print('first name: ${bloc.firstName}');
//       print('date of Birth: ${bloc.dateOfBirth}');

//       print('Country: ${bloc.country}');

//       print('Gender: ${bloc.selected!.value}');

//       final userProfile = UserProfileEntity(
//           firstName: bloc.firstName,
//           middleName: bloc.middleName,
//           lastName: bloc.lastName,
//           birthDate: bloc.dateOfBirth,
//           country: bloc.country,
//           state: bloc.state,
//           city: bloc.city,
//           phoneNumber:
//               "${bloc.phoneNumber!.dialCode}${phoneNumberController.text}",
//           gender: bloc.selected!.value,
//           profilePicture: bloc.profileImage!.path);
//       _createProfileBloc.add(ProfileSubmitEvent(userProfile: userProfile));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CreateProfileBloc, CreateProfileState>(
//         listener: (context, state) {
//           if (state.isProfileSuccess) {
//             // Navigate to the verification screen
//             print("Successfully creat profile ");
//             // Navigator.of(context)
//             //     .pushNamed("/sign_up_verification", arguments: email);
//             // WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.of(context).pushNamed(AppRoutes.SIGN_IN);
//             //   return;
//             // });
//           }

//           // if (state.profileFailure != null) {
//           //   // Show error message
//           //   print("ERROR on build profile ${state.profileFailure}:");
//           //   // ScaffoldMessenger.of(context).showSnackBar(
//           //   //   SnackBar(content: Text(state.profileFailure!)),
//           //   // );
//           // }
//         },
//         child:
//             // String dateOfBirth = state.dateOfBirth;

//             // if (state is GenderSelectionState) {
//             //   selectedGender = state.selectedGender;
//             // }

//             Form(
//           key: _formKey,
//           child: Container(
//             color: AppColors.primaryBackground,
//             child: SafeArea(
//               child: Scaffold(
//                 backgroundColor: AppColors.primaryBackground,
//                 appBar: buildAppBarLarge("Create Your Profile"),
//                 body: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Center(
//                           child: reusableText(
//                               "Create Your Initial Profile To Get Started")),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       BlocBuilder<CreateProfileBloc, CreateProfileState>(
//                         builder: (context, state) {
//                           return Container(
//                             padding: EdgeInsets.only(left: 25.w, right: 25.w),
//                             margin: EdgeInsets.only(top: 50.h),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   reusableText("Upload Photo"),
//                                   Column(
//                                     children: [
//                                       if (state.imagePickState ==
//                                           ImagePickState.initialy)
//                                         buildInitialInput(context),
//                                       if (state.imagePickState ==
//                                           ImagePickState.picked)
//                                         buildImagePreview(state.profileImage!,
//                                             context, "profile"),
//                                       if (state.imagePickState ==
//                                           ImagePickState.failed)
//                                         buildFailedInput(
//                                             context, state.errorImage)
//                                       // the image is as for debugging not actual image
//                                     ],
//                                   ),
//                                   const SizedBox(height: 15),
//                                   reusableText("First Name"),
//                                   BlocBuilder<CreateProfileBloc,
//                                       CreateProfileState>(
//                                     builder: (context, state) {
//                                       return formField(
//                                           fieldName: "firstName",
//                                           value: state.firstName,
//                                           controller: _signUpController
//                                               .firstNameController,
//                                           textType: "profile",
//                                           hintText: "Enter your first name",
//                                           prefixIcon: const Icon(Icons.person),
//                                           inputType: TextInputType.name,
//                                           func: (value) {
//                                             context
//                                                 .read<CreateProfileBloc>()
//                                                 .add(NameChangedEvent(
//                                                     firstName: value));
//                                           },
//                                           formType: "sign up",
//                                           context: context);
//                                     },
//                                   ),
//                                   reusableText("Middle Name"),
//                                   formField(
//                                       fieldName: "middleName",
//                                       value: state.middleName,
//                                       controller: _signUpController
//                                           .middleNameController,
//                                       textType: "profile",
//                                       hintText: "Enter your middle name",
//                                       prefixIcon: const Icon(Icons.person),
//                                       inputType: TextInputType.name,
//                                       func: (value) {
//                                         context.read<CreateProfileBloc>().add(
//                                             NameChangedEvent(
//                                                 middleName: value));
//                                       },
//                                       formType: "sign up",
//                                       context: context),
//                                   reusableText("Last Name"),
//                                   formField(
//                                       fieldName: "lastName",
//                                       value: state.lastName,
//                                       controller:
//                                           _signUpController.lastNameController,
//                                       textType: "profile",
//                                       hintText: "Enter your last name",
//                                       prefixIcon: const Icon(Icons.person),
//                                       inputType: TextInputType.name,
//                                       func: (value) {
//                                         context.read<CreateProfileBloc>().add(
//                                             NameChangedEvent(lastName: value));
//                                       },
//                                       formType: "sign up",
//                                       context: context),
//                                   reusableText("Location"),
//                                   LocationFormField(
//                                     // Provide a unique key if necessary
//                                     context: context,

//                                     onSaved: (value) {
//                                       _country = value?['country'];
//                                       _state = value?['state'];
//                                       _city = value?['city'];
//                                     },
//                                     validator: (value) {
//                                       if (value?['country'] == null) {
//                                         return "Please select a valid location";
//                                       }
//                                       context.read<CreateProfileBloc>().add(
//                                           LocationEvent(
//                                               country: value?['country'],
//                                               state: value?['state'],
//                                               city: value?['city']));
//                                       print(value);
//                                       return null;
//                                     },
//                                   ),
//                                   // CscPicker(context),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   reusableText("Gender"),
//                                   BlocBuilder<CreateProfileBloc,
//                                       CreateProfileState>(
//                                     builder: (context, state) {
//                                       String selectedGender =
//                                           genderToString(state.selected!);

//                                       print(
//                                           "gender selected is : $selectedGender");
//                                       return SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.9,
//                                         child: dropDownField(
//                                             selected: selectedGender,
//                                             dropDown: Gender.values,
//                                             context: context,
//                                             hintText: "Select gender",
//                                             keyName: 'gender'),
//                                       );
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   reusableText("Phone Number"),
//                                   BlocBuilder<CreateProfileBloc,
//                                       CreateProfileState>(
//                                     builder: (context, state) {
//                                       PhoneNumber? number = state.phoneNumber;
//                                       return SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.9,
//                                           child: phoneNumberField(context,
//                                               number, phoneNumberController));
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   reusableText("Date Of Birth"),

//                                   // print("Date of Birth:$dateOfBirth");
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.9,
//                                     child: dateField(
//                                         context: context,
//                                         dateController: dateController,
//                                         date: state.dateOfBirth,
//                                         dateType: "birth",
//                                         whoseBirth: "userBirth"),
//                                   ),
//                                 ]),
//                           );
//                         },
//                       ),
//                       BlocBuilder<CreateProfileBloc, CreateProfileState>(
//                         builder: (context, state) {
//                           return state.isProfileLoading
//                               ? const Center(child: CircularProgressIndicator())
//                               : buildLogInAndRegButton(
//                                   "Build Profile", true, _handleProfile);
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }

//   Widget buildInitialInput(BuildContext context) {
//     // print("Image Pick Initial State");
//     return Center(
//       child: Column(
//         children: [
//           Container(
//             color: AppColors.cardColor,
//             child: Center(
//               child: Column(
//                 children: [
//                   IconButton(
//                     // color: AppColors.accentColor,
//                     // color: AppColors.accentColor,
//                     // style: const ButtonStyle(),
//                     onPressed: () {
//                       context.read<CreateProfileBloc>().add(PickImage());
//                     },
//                     icon: const Icon(
//                       Icons.upload,
//                       weight: 10,
//                     ),
//                   ),
//                   const Text(
//                     "Upload a Photo",
//                     style: TextStyle(
//                         color: AppColors.primaryText,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 15),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildImagePreview(File image, BuildContext context, String imageType) {
//     // print("ImagePreview");
//     bool isPressed = false;
//     return Center(
//       child: Column(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.9,
//             height: MediaQuery.of(context).size.height * 0.24,
//             child: Center(
//               child: Column(children: [
//                 imageType == "profile"
//                     ? CircleAvatar(
//                         radius: 50,
//                         backgroundImage: FileImage(image),
//                       )
//                     : MyTextField(
//                         controller: TextEditingController(text: image.path),
//                         hintText: "",
//                         obscureText: false,
//                         keyboardType: TextInputType.text),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     isPressed == false
//                         ? ElevatedButton(
//                             style: const ButtonStyle(
//                                 backgroundColor: WidgetStatePropertyAll(
//                                     AppColors.accentColor)),
//                             onPressed: () {
//                               isPressed = true;
//                               imageType == "profile"
//                                   ? toastInfo(msg: "Profile setted succesfully")
//                                   : toastInfo(
//                                       msg: "Missing image setted succesfully");
//                             },
//                             child: const Text(
//                               "Set",
//                               style: TextStyle(
//                                 color: AppColors.primaryBackground,
//                               ),
//                             ),
//                           )
//                         : Container(),
//                     ElevatedButton(
//                         style: const ButtonStyle(
//                             backgroundColor:
//                                 WidgetStatePropertyAll(AppColors.accentColor)),
//                         onPressed: () {
//                           context.read<CreateProfileBloc>().add(PickImage());
//                         },
//                         child: const Text(
//                           "Change",
//                           style: TextStyle(
//                             color: AppColors.primaryBackground,
//                           ),
//                         ))
//                   ],
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildFailedInput(BuildContext context, String? errorMsg) {
//     return Column(
//       children: [
//         Text(errorMsg!),
//         ElevatedButton(
//           style: const ButtonStyle(
//               backgroundColor: WidgetStatePropertyAll(AppColors.accentColor)),
//           onPressed: () {
//             context.read<CreateProfileBloc>().add(PickImage());
//           },
//           child: const Text(
//             'Retry',
//             style: TextStyle(
//               color: AppColors.primaryBackground,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget phoneNumberField(BuildContext context, PhoneNumber? phoneNumber,
//     TextEditingController controller) {
//   // final state = context.read<CreateProfileBloc>().state;

//   return InternationalPhoneNumberInput(
//     onInputChanged: (number) {
//       context.read<CreateProfileBloc>().add(PhoneNoChanged(number));
//     },
//     onInputValidated: (bool value) {
//       context.read<CreateProfileBloc>().add(
//             PhoneNoValidationChanged(value),
//           );
//     },
//     selectorConfig: const SelectorConfig(
//       selectorType: PhoneInputSelectorType.DIALOG,
//     ),
//     ignoreBlank: false,
//     autoValidateMode: AutovalidateMode.disabled,
//     selectorTextStyle: const TextStyle(
//       color: AppColors.primaryText,
//     ),
//     initialValue: phoneNumber,
//     textFieldController: controller,
//     inputBorder: const OutlineInputBorder(),
//     inputDecoration: InputDecoration(
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: AppColors.cardColor),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20),
//         borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
//       ),
//       fillColor: AppColors.cardColor,
//       filled: true,
//       hintText: "Enter your phone number",
//       hintStyle: const TextStyle(
//         color: Color.fromARGB(115, 88, 85, 85),
//       ),
//     ),
//     keyboardType: TextInputType.number,
//   );
// }
