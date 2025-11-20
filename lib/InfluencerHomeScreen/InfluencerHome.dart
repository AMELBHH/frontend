import 'package:flutter/material.dart';
import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';

class Influencerhome extends StatelessWidget {
  final RoleService roleService = RoleService();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لوحة المؤثر'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await roleService.clearRole();
              Navigator.pushReplacementNamed(context, '/role-selection');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.purple),
            SizedBox(height: 24),
            Text(
              'مرحباً بك في لوحة المؤثر',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
