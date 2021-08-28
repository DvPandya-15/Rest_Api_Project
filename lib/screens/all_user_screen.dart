import 'package:e_it/model/user.dart';
import 'package:e_it/services/user_service.dart';
import 'package:e_it/widgets/show_modal_bottomsheet_bar.dart';
import 'package:flutter/material.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  _AllUserScreenState createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  UserService userService = new UserService();
  final emailController = new TextEditingController();
  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();

  bool hasData = false;
  bool hasError = false;
  bool hasMoreData = false;
  List<User> users = [];
  int pageNumber = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  void getUsers() async {
    final newUsers = await userService.getAllUser(pageNumber);
    if (newUsers.isEmpty) {
      setState(() {
        hasMoreData = false;
      });
      return;
    }
    setState(() {
      users.addAll(newUsers);
      hasData = true;
      hasMoreData = true;
      pageNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("HI, "),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Dashboard"),
      ),
      body: hasError
          ? Center(child: Text("Something Went Wrong!"))
          : !hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: hasMoreData ? users.length + 1 : users.length,
                  itemBuilder: (context, index) {
                    if (index >= users.length && hasMoreData) {
                      getUsers();
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ShowModalBottomSheet(
                                user: users[index],
                              );
                            });
                      },
                      title: Text(users[index].first_name!),
                      subtitle: Text(users[index].last_name!),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          users[index].avatar == null
                              ? "https://i.stack.imgur.com/y9DpT.jpg"
                              : users[index].avatar!,
                          scale: 10,
                        ),
                      ),
                      trailing: GestureDetector(
                          onTap: () async {
                            try {
                              await userService.deleteUser(users[index]);
                            } catch (e) {
                              print(e.toString());
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("user ${users[index].id} is deleted"),
                              ),
                            );
                          },
                          child: Icon(Icons.delete)),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ShowModalBottomSheet();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
