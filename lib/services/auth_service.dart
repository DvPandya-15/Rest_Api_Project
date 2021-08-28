import 'package:crypt/crypt.dart';
import 'package:e_it/model/auth_user.dart';
import 'package:e_it/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

abstract class AuthServiceBase {
  Future<AuthUser?> signIn(String email, String password);
  Future signUp(AuthUser authUser, String password);
}

class AuthService implements AuthServiceBase {
  DatabaseService databaseService = new DatabaseService();
  @override
  Future<AuthUser?> signIn(String email, String password) async {
    final Database? db = await databaseService.getDatabase();
    // print("get encrypt : ${getEncryptedPassword(password)}");
    final List<Map<String, dynamic>>? users = await db?.rawQuery(
        "SELECT * FROM users where email='$email' AND password = '${getEncryptedPassword(password)}'");

    if (users == null || users.length != 1) return null;

    return AuthUser.fromJson(users[0]);
  }

  @override
  Future signUp(AuthUser authUser, String password) async {
    try {
      final db = await databaseService.getDatabase();

      final Map<String, dynamic> authUserMap = authUser.toJson();
      authUserMap['password'] = getEncryptedPassword(password);

      authUser.id = await db?.insert("users", authUserMap);
    } catch (e) {
      print("SignUp Error: $e");
    }
  }

  String getEncryptedPassword(String password) {
    return Crypt.sha256(password, salt: 'password').toString();
  }

  bool isEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
