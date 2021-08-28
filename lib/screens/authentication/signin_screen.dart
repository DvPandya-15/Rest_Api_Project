import 'package:e_it/model/auth_user.dart';
import 'package:e_it/screens/all_user_screen.dart';
import 'package:e_it/screens/authentication/signup_screen.dart';
import 'package:e_it/services/auth_service.dart';
import 'package:e_it/widgets/custom_text_button.dart';
import 'package:e_it/widgets/custom_text_field.dart';
import 'package:e_it/widgets/unfocus.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  // final _authService;

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return UnFocus(
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
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailTextEditingController,
                        validator: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email or Username",
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
                    ],
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomRoundedRectangularButton(
                        onPressed: _performLogin,
                        color: Colors.redAccent,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }

  _performLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    final email = _emailTextEditingController.text.trim();
    final password = _passwordTextEditingController.text.trim();
    final auth = AuthService();

    try {
      setState(() => isLoading = true);
      AuthUser? user = await auth.signIn(email, password);

      setState(() => isLoading = false);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Failed : User not found")));
        return;
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AllUserScreen()));
    } catch (e) {
      setState(() => isLoading = false);
      print("SignIn Error :$e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Failed")));
    }
  }
}
