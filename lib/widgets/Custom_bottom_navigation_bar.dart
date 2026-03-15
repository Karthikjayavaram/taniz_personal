import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 30,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          onTap: onTap,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,

          selectedIconTheme: const IconThemeData(size: 26),
          unselectedIconTheme: const IconThemeData(size: 24),

          selectedFontSize: 12,
          unselectedFontSize: 12,

          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,

          backgroundColor: const Color(0xFF041AA5),

          items: [
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.house()),
              activeIcon: Icon(PhosphorIconsFill.house),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.storefront()),
              activeIcon: Icon(PhosphorIconsFill.storefront),
              label: "Store",
            ),

            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.playCircle()),
              activeIcon: Icon(PhosphorIconsFill.playCircle),
              label: "Reels",
            ),

            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.shoppingCartSimple()),
              activeIcon: Icon(PhosphorIconsFill.shoppingCartSimple),
              label: "Cart",
            ),

            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.userCircle()),
              activeIcon: Icon(PhosphorIconsFill.userCircle),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}
