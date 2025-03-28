import 'package:ec_com_admin_01/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UserListPage extends StatelessWidget {
  static const String routeName = '/userlist';

  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Colors.white70,
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.userList.length,
          itemBuilder: (context, index) {
            final user = provider.userList[index];
            return ListTile(
              title: Text(user.displayName ?? 'No Display name'),
              subtitle: Text(user.email),
              trailing: Text(
                  'Joined \n ${getDifference(user.userCreationTime!.toDate()).inDays}day(s) ago'),
            );
          },
        ),
      ),
    );
  }
}
