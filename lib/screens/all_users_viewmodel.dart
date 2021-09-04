import 'package:e_it/model/user.dart';
import 'package:e_it/services/user_service.dart';
import 'package:flutter/material.dart';

class AllUsersViewModel extends ChangeNotifier {
  AllUsersViewModel() {
    getUsers();
  }

  final _userService = UserService();

  //TODO: change to isLoading
  bool _hasData = false;
  bool _hasError = false;
  bool _hasMoreData = false;
  final List<User> users = [];
  int pageNumber = 1;

  bool get hasMoreData => _hasMoreData;
  bool get hasError => _hasError;
  bool get hasData => _hasData;

  void getUsers() async {
    //TODO: handle exceptions
    final newUsers = await _userService.getAllUser(pageNumber);

    if (newUsers.isEmpty) {
      _hasMoreData = false;
      return;
    }

    users.addAll(newUsers);

    _hasData = true;
    _hasMoreData = true;
    pageNumber++;
    notifyListeners();
  }

  void deleteUser(User user) async {
    try {
      await _userService.deleteUser(user);
    } catch (e) {
      print(e.toString());
    }
  }
}
