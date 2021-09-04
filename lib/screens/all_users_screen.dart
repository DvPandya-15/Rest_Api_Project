import 'package:e_it/screens/all_users_viewmodel.dart';
import 'package:e_it/widgets/show_modal_bottomsheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  _AllUserScreenState createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllUsersViewModel>(
      create: (_) => AllUsersViewModel(),
      child: Scaffold(
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
        body: context.watch<AllUsersViewModel>().hasError
            ? Center(child: Text("Something Went Wrong!"))
            : !context.watch<AllUsersViewModel>().hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemCount: context.watch<AllUsersViewModel>().hasMoreData
                        ? context.watch<AllUsersViewModel>().users.length + 1
                        : context.watch<AllUsersViewModel>().users.length,
                    itemBuilder: (context, index) {
                      if (index >=
                              context.watch<AllUsersViewModel>().users.length &&
                          context.watch<AllUsersViewModel>().hasMoreData) {
                        context.read<AllUsersViewModel>().getUsers();
                        return Center(child: CircularProgressIndicator());
                      }

                      final users = context.watch<AllUsersViewModel>().users;
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
                              context
                                  .read<AllUsersViewModel>()
                                  .deleteUser(users[index]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "user ${users[index].id} is deleted"),
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
      ),
    );
  }
}
