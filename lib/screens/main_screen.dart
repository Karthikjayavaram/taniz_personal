import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tanizkart/screens/categories_screen.dart';
import 'package:tanizkart/screens/store_screen.dart';
import 'package:tanizkart/screens/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    Placeholder(),
    StoreScreen(),
    CategoriesScreen(),
    CartScreen(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,

      body: pages[selectedIndex],

      bottomNavigationBar: selectedIndex == 3 
        ? const SizedBox.shrink() // Hide navbar on Cart page
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: const IconThemeData(size: 26),
                unselectedIconTheme: const IconThemeData(size: 24),
                selectedFontSize: 12,
                unselectedFontSize: 12,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                backgroundColor: const Color(0xFF041AA5),
                showSelectedLabels: true,
                showUnselectedLabels: true,
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
          ),
    );
  }
}
