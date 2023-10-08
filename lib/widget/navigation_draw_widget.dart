import 'package:flutter/material.dart';

import '../pages/dash_board_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.amber.shade600,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 100),
            UserAccountsDrawerHeader(
              accountName: Text("Swandovia"),
              accountEmail: Text("Sswhh@gmail.com"),
              currentAccountPicture:
                  CircleAvatar(child: ClipOval(), backgroundColor: Colors.blue),
            ),
            buildMenuItem(
              text: "Dashboard",
              icon: Icons.dashboard_rounded,
              onClicked: () => selectedItem(context, 0),
            ),

            // divider
            const SizedBox(height: 350),
            Divider(color: Colors.white),
            const SizedBox(height: 10),

            const SizedBox(width: 200, height: 40),
            buildMenuItem(text: '', icon: Icons.help_outline_rounded),
          ],
        ),
      ),
    );
  }

  // TO DO: actions once button been clicked
  /**index : index position of the box on sidebar */
  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoardPage()));
    }
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white60; //color while clicking

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked, //action once clicked
    );
  }
}
