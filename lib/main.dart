import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/services/services.dart';
import 'package:news_app/screens/screens.dart';
import 'package:news_app/theme/dark_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        home: const TabsScreen(),
        theme: myTheme,
      ),
    );
  }
}
