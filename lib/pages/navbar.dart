import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onItemTap;
  final int currentIndex;

  CustomNavBar({required this.onItemTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            iconPath: 'assets/icons/home.svg',
            isSelected: currentIndex == 0,
            onTap: () => onItemTap(0),
          ),
          NavBarItem(
            iconPath: 'assets/icons/service.svg',
            isSelected: currentIndex == 1,
            onTap: () => onItemTap(1),
          ),
          // GestureDetector(
          //   onTap: () => onItemTap(2),
          //   child: Container(
          //     width: 60,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       color: Colors.blue,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //       size: 30,
          //     ),
          //   ),
          // ),
          NavBarItem(
            iconPath: 'assets/icons/service.svg',
            isSelected: currentIndex == 3,
            onTap: () => onItemTap(3),
          ),
          NavBarItem(
            iconPath: 'assets/icons/profile.svg',
            isSelected: currentIndex == 4,
            onTap: () => onItemTap(4),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  NavBarItem({
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            color: isSelected ? Colors.blue : Colors.grey,
            width: 24,
            height: 24,
          ),
          SizedBox(height: 6),
          if (isSelected)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
