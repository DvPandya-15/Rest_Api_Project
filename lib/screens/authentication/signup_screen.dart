import 'package:e_it/model/auth_user.dart';
import 'package:e_it/screens/all_user_screen.dart';
import 'package:e_it/screens/authentication/signin_screen.dart';
import 'package:e_it/services/auth_service.dart';
import 'package:e_it/widgets/custom_text_button.dart';
import 'package:e_it/widgets/custom_text_field.dart';
import 'package:e_it/widgets/unfocus.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _firstNameTextEditingController = TextEditingController();
  final _lastNameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return UnFocus(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  "Electrum IT",
                  style: TextStyle(fontSize: 29),
                ),
                SizedBox(height: 50),
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          controller: _firstNameTextEditingController,
                          hintText: "FirstName",
                          validator: (value) {}),
                      CustomTextFormField(
                          controller: _lastNameTextEditingController,
                          hintText: "LastName",
                          validator: (value) {}),
                      CustomTextFormField(
                          controller: _usernameTextEditingController,
                          hintText: "Username",
                          validator: (value) {}),
                      CustomTextFormField(
                        controller: _emailTextEditingController,
                        validator: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                      ),
                      CustomTextFormField(
                        controller: _passwordTextEditingController,
                        hintText: "Password",
                        validator: (value) {},
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                              () => isPasswordVisible = !isPasswordVisible),
                          splashRadius: 25,
                          icon: Icon(
                            !isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        hintText: "Confirm Password",
                        validator: (value) {},
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomRoundedRectangularButton(
                        onPressed: _performSignUp,
                        color: Colors.redAccent,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      text: "Already have an account?  ",
                      children: [
                        TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                          text: "Log in",
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _performSignUp() async {
    if (!_signUpFormKey.currentState!.validate()) return;

    final firstName = _firstNameTextEditingController.text.trim();
    final lastName = _lastNameTextEditingController.text.trim();
    final userName = _usernameTextEditingController.text.trim().toLowerCase();
    final password = _passwordTextEditingController.text.trim();
    final email = _emailTextEditingController.text.trim();

    final auth = AuthService();

    setState(() => isLoading = true);

    AuthUser authUser = AuthUser(
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
    );

    try {
      await auth.signUp(authUser, password);
      setState(() => isLoading = false);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AllUserScreen()));
    } catch (e) {
      setState(() => isLoading = false);
      print("SignUp Error : $e");
    }
  }
}
