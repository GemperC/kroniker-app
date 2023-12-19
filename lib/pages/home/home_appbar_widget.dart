import 'package:flutter/material.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      title: Text('Custom AppBar'),
      actions: [],
      // You can add more AppBar properties here as needed
    );
  }
}
