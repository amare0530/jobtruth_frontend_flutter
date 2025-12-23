import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const JobTruthApp());
}

class JobTruthApp extends StatelessWidget {
  const JobTruthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobTruth',
      // 🚀 加上下面這行，右上角的 DEBUG 紅條就會消失
      debugShowCheckedModeBanner: false, 
      
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      initialRoute: Routes.home,
      routes: Routes.routes,
    );
  }
}