import 'package:e_it/screens/authentication/auth_viewmodel.dart';
import 'package:e_it/screens/authentication/signin_screen.dart';
import 'package:e_it/widgets/custom_text_button.dart';
import 'package:e_it/widgets/custom_text_field.dart';
import 'package:e_it/widgets/unfocus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: UnFocus(
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
                    key: context.watch<AuthViewModel>().signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                            controller: context
                                .watch<AuthViewModel>()
                                .firstNameTextEditingController,
                            hintText: "FirstName",
                            validator: (value) {}),
                        CustomTextFormField(
                            controller: context
                                .watch<AuthViewModel>()
                                .lastNameTextEditingController,
                            hintText: "LastName",
                            validator: (value) {}),
                        CustomTextFormField(
                            controller: context
                                .watch<AuthViewModel>()
                                .usernameTextEditingController,
                            hintText: "Username",
                            validator: (value) {}),
                        CustomTextFormField(
                          controller: context
                              .watch<AuthViewModel>()
                              .emailTextEditingController,
                          validator: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                        ),
                        CustomTextFormField(
                          controller: context
                              .watch<AuthViewModel>()
                              .passwordTextEditingController,
                          hintText: "Password",
                          validator: (value) {},
                          obscureText:
                              !context.watch<AuthViewModel>().isPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => context
                                    .watch<AuthViewModel>()
                                    .isPasswordVisible =
                                !context
                                    .watch<AuthViewModel>()
                                    .isPasswordVisible),
                            splashRadius: 25,
                            icon: Icon(
                              !context.watch<AuthViewModel>().isPasswordVisible
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
                  context.watch<AuthViewModel>().isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomRoundedRectangularButton(
                          onPressed: () {
                            context
                                .read<AuthViewModel>()
                                .performSignUp(context);
                          },
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
      ),
    );
  }
}
