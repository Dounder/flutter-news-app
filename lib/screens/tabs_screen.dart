import 'package:flutter/material.dart';
import 'package:news_app/screens/tab1_screen.dart';
import 'package:news_app/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Screens(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.actualPage,
      onTap: (i) => navigationModel.actualPage = i,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  final PageController _pageController = PageController();

  int get actualPage => _actualPage;

  set actualPage(int val) {
    _actualPage = val;

    _pageController.animateToPage(
      val,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
