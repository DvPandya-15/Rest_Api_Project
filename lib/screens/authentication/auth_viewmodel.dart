import 'package:e_it/model/auth_user.dart';
import 'package:e_it/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../all_users_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final usernameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isLoading = false;

  final loginFormKey = GlobalKey<FormState>();

  void performSignUp(BuildContext context) async {
    if (!signUpFormKey.currentState!.validate()) return;

    final firstName = firstNameTextEditingController.text.trim();
    final lastName = lastNameTextEditingController.text.trim();
    final userName = usernameTextEditingController.text.trim().toLowerCase();
    final password = passwordTextEditingController.text.trim();
    final email = emailTextEditingController.text.trim();

    final auth = AuthService();

    isLoading = true;

    AuthUser authUser = AuthUser(
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
    );

    try {
      await auth.signUp(authUser, password);
      isLoading = false;
      notifyListeners();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AllUserScreen()));
    } catch (e) {
      isLoading = false;
      print("SignUp Error : $e");
    }
  }

  void performLogin(BuildContext context) async {
    if (!loginFormKey.currentState!.validate()) return;

    final email = emailTextEditingController.text.trim();
    final password = passwordTextEditingController.text.trim();
    final auth = AuthService();

    try {
      isLoading = true;
      AuthUser? user = await auth.signIn(email, password);

      isLoading = false;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Failed : User not found")));
        return;
      }
      notifyListeners();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AllUserScreen()));
    } catch (e) {
      isLoading = false;
      print("SignIn Error :$e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Failed")));
    }
  }
}
