import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  const BottomNav({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        switch (i) {
          case 0: Navigator.pushReplacementNamed(context, '/'); break;
          case 1: Navigator.pushReplacementNamed(context, '/swipe'); break;
          case 2: Navigator.pushReplacementNamed(context, '/messages'); break;
          case 3: Navigator.pushReplacementNamed(context, '/profile'); break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '找工作'),
        BottomNavigationBarItem(icon: Icon(Icons.view_carousel), label: '滑卡'),
        BottomNavigationBarItem(icon: Stack(children: [Icon(Icons.chat_bubble_outline), Positioned(right: 0, top: 0, child: CircleAvatar(radius: 4, backgroundColor: Colors.red))]), label: '訊息'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '我'),
      ],
    );
  }
}
