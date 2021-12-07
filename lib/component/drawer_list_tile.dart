import 'package:flutter/material.dart';
import 'package:habit_tracker_app/constant/color.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;
  final Color iconColor;

  const DrawerListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : habitTrackerAppWhite,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListTile(
          title: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color:
                      isSelected ? habitTrackerAppWhite : habitTrackerAppBlack,
                ),
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
