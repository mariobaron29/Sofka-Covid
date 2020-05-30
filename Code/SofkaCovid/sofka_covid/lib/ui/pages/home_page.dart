import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sofkacovid/ui/pages/main_page.dart';
import 'package:sofkacovid/ui/pages/secondary_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Duration animationDurationMilli = Duration(milliseconds: 550);
  var currentPage = 0;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.index = 0;
    tabController.animation;
    _loadPages();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.amber[900],
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        animationDuration: animationDurationMilli,
        height: deviceHeight * 0.08,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.amber[900],
          ),
          Icon(
            Icons.public,
            size: 30,
            color: Colors.amber[900],
          ),
        ],
        backgroundColor: Colors.amber[900],
        onTap: (index) {
          setState(() {
            changeTab(index);
          });
        },
      ),
    );
  }

  void _loadPages() {
    pages = [];
    pages.add(MainPage());
    pages.add(SecondaryPage());
  }

  void _onItemTapped(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void changeTab(int index) {
    setState(() {
      currentPage = index;
      tabController.animateTo(index, duration: animationDurationMilli);
    });
  }
}
