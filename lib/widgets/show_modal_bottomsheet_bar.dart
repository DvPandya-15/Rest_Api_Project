import 'package:e_it/model/user.dart';
import 'package:e_it/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowModalBottomSheet extends StatefulWidget {
  const ShowModalBottomSheet({this.user});
  final User? user;

  @override
  _ShowModalBottomSheetState createState() => _ShowModalBottomSheetState();
}

class _ShowModalBottomSheetState extends State<ShowModalBottomSheet> {
  UserService userService = new UserService();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();

  bool isNewUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preDefineUser();
    if (widget.user == null) {
      isNewUser = true;
    }
  }

  void preDefineUser() {
    if (widget.user != null) {
      firstNameController.text = widget.user!.first_name ?? '';
      lastNameController.text = widget.user!.last_name ?? '';
      emailController.text = widget.user!.email ?? '';
    }
  }

  void editUser() async {
    if (!formKey.currentState!.validate()) return;

    User user = User(
      email: emailController.text,
      first_name: firstNameController.text,
      last_name: lastNameController.text,
    );
    await userService.updateUser(user);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "User edited successfully!",
        ),
      ),
    );
  }

  void addUser() async {
    if (!formKey.currentState!.validate()) return;

    User user = User(
      email: emailController.text,
      first_name: firstNameController.text,
      last_name: lastNameController.text,
    );

    await userService.addUser(user);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "User Added successfully!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              isNewUser ? "Add User" : "Edit User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
              },
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First name is required';
                }
              },
              decoration: InputDecoration(hintText: "First Name"),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last name is required';
                }
              },
              decoration: InputDecoration(hintText: "Last Name"),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: isNewUser ? addUser : editUser,
              child: Text(
                isNewUser ? "Add User" : "Edit User",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.redAccent),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
