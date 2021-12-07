import 'package:flutter/material.dart';
import 'package:habit_tracker_app/component/drawer_list_tile.dart';
import 'package:habit_tracker_app/service/storage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void _logoutHandler(context) async {
    logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/img/tea-cup.png',
                  height: 50,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'GOAL TRACKER',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.dashboard,
            iconColor: const Color.fromRGBO(251, 99, 64, 1.0),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != "/dashboard") {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            },
            isSelected: ModalRoute.of(context)!.settings.name == '/dashboard',
          ),
          DrawerListTile(
            title: "Achivements",
            icon: Icons.emoji_events,
            iconColor: Colors.yellow[800]!,
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != "/achivements") {
                Navigator.pushReplacementNamed(context, '/achivements');
              }
            },
            isSelected: ModalRoute.of(context)!.settings.name == '/achivements',
          ),
          Divider(height: 4, thickness: 1, color: Colors.grey[200]),
          const Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
            child: Text(
              "DOCUMENTATION",
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontSize: 15,
              ),
            ),
          ),
          DrawerListTile(
            title: "Logout",
            icon: Icons.logout,
            iconColor: Colors.grey,
            onTap: () => _logoutHandler(context),
            isSelected: false,
          ),
        ],
      ),
    );
  }
}
