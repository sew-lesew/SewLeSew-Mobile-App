import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'ethiopian_phone_validator.dart';

class SignUpController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  String? handleEmailSignUp(
      BuildContext context, String fieldName, String value) {
    final SignUpStates state = context.read<SignUpBloc>().state;
    switch (fieldName) {
      case 'firstName':
        if (value.isEmpty) {
          return "First name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;

      case 'lastName':
        if (value.isEmpty) {
          return "Last name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;

      case 'contact':
        if (value.isEmpty) {
          return "Email or phone number can't be empty";
        }
        if (!EthiopianPhoneValidator.isValidPhoneNumber(
                EthiopianPhoneValidator.normalize(value)) &&
            !value.isEmail()) {
          return "Please enter a valid phone number or email address";
        }

        break;
      case 'password':
        if (value.isEmpty) {
          return "Password can't be empty ";
        }
        break;
      case 'repassword':
        if (value.isEmpty) {
          return "Your password confirmation is wrong";
        }
        if (value != state.password) {
          return "The passwords do not match";
        }
        break;

      default:
        return null;
    }

    return null;
  }

  String? handleProfileBuild(
      BuildContext context, String fieldName, String value) {
    switch (fieldName) {
      case 'firstName':
        if (value.isEmpty) {
          return "First name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;
      case 'middleName':
        if (value.isEmpty) {
          return "Middle name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;
      case 'lastName':
        if (value.isEmpty) {
          return "Last name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;

      default:
        return null;
    }

    return null;
  }
}
  //   PhoneNumber? phoneNumber = state.phoneNumber;
  //   // String? phoneNumber = state.phoneNumber;
  //   String dateOfBirth = state.dateOfBirth;
  //   if (state is GenderSelectionState) {
  //     String? gender = state.selectedGender;
  //     if (gender.isEmpty) {
  //       "gender cannot be empty";
  //     }
  //   }

  //   if (firstName.isEmpty) {
  //     "first name can not be empty";
  //   }
  //   if (middleName.isEmpty) {
  //     "middle name can not be empty";
  //   }
  //   if (lastName.isEmpty) {
  //     "last name can not be empty";
  //   }
  //   // if (location.isEmpty) {
  //   //   toastInfo(msg: "location can not be empty");
  //   //   return;
  //   // }
  //   if (phoneNumber.toString().isEmpty) {
  //     "phone number can not be empty";
  //     return;
  //   }
  //   if (dateOfBirth.isEmpty) {
  //     "date of birth can not be empty";
  //   }
  //   try {
  //     toastInfo(msg: "Profile Created Succesfully");
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
  //     return;
  //   } catch (e) {
  //     print(e.toString());
  //   }

