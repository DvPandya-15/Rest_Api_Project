import 'package:e_it/screens/authentication/auth_viewmodel.dart';
import 'package:e_it/screens/authentication/signup_screen.dart';
import 'package:e_it/widgets/custom_text_button.dart';
import 'package:e_it/widgets/custom_text_field.dart';
import 'package:e_it/widgets/unfocus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: UnFocus(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
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
                  SizedBox(height: 70),
                  Form(
                    key: context.watch<AuthViewModel>().loginFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: context
                              .watch<AuthViewModel>()
                              .emailTextEditingController,
                          validator: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email or Username",
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  context.watch<AuthViewModel>().isLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomRoundedRectangularButton(
                          onPressed: () {
                            context
                                .watch<AuthViewModel>()
                                .performLogin(context);
                          },
                          color: Colors.redAccent,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                  SizedBox(height: 10),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        text: "Don't have an account?  ",
                        children: [
                          TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                            text: "Sign Up",
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
