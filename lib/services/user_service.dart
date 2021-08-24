import 'dart:convert';
import 'dart:io';

import 'package:e_it/api/api_path.dart';
import 'package:e_it/model/user.dart';
import 'package:http/http.dart';

abstract class UserServiceBase {
  Future<List<User>> getAllUser(int pageNumber);
  Future<void> addUser(User user);
  Future<void> deleteUser(User user);
  Future<void> updateUser(User user);
}

class UserService implements UserServiceBase {
  @override
  //TO ADD USER
  Future<void> addUser(User user) async {
    Uri url = Uri.parse("$API/users");

    final Response response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 201) throw HttpException("couldn't get users");
  }

  //DELETE USER
  @override
  Future<void> deleteUser(User user) async {
    Uri url = Uri.parse("$API/users/${user.id}");
    final Response response = await delete(url);

    if (response.statusCode != 204) throw HttpException("User is not deleted!");
  }

  //GET THE LIST OF ALL USER
  @override
  Future<List<User>> getAllUser(int pageNumber) async {
    Uri url = Uri.parse("$API/users?page=$pageNumber&per_page=10");
    final Response response = await get(url);
    if (response.statusCode != 200)
      throw HttpException("Couldn't get all users !");

    final mapResponse = jsonDecode(response.body);

    if (mapResponse['data'] == null || !(mapResponse['data'] is List))
      throw HttpException("No 'data' element found in response");

    return (mapResponse['data'] as List).map((e) => User.fromJson(e)).toList();
  }

  //UPDATE EXISTING USER
  @override
  Future<void> updateUser(User user) async {
    Uri url = Uri.parse("$API/users/${user.id}");
    final Response response = await put(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()));

    if (response.statusCode != 200)
      throw HttpException("${user.id} is not updated");
  }
}
