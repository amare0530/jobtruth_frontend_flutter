import 'package:flutter/material.dart';
import 'pages/job_list_page.dart';
import 'pages/job_swipe_page.dart';
import 'pages/message_page.dart';
import 'pages/profile_page.dart';

class Routes {
  static const String home = '/';
  static const String swipe = '/swipe';

  static Map<String, WidgetBuilder> routes = {
    home: (ctx) => const JobListPage(), // 如果這行沒紅線就留著
    swipe: (ctx) => JobSwipePage(),      // 👈 拿掉 const
    '/messages': (ctx) => MessagePage(), // 👈 拿掉 const
    '/profile': (ctx) => const ProfilePage(),
  };
}