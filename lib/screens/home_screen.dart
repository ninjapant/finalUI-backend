import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinddd/models/user_data.dart';
import 'package:vinddd/screens/activity_screen.dart';
import 'package:vinddd/screens/create_post_screen.dart';
import 'package:vinddd/screens/feed_screen.dart';
import 'package:vinddd/screens/profile.dart';
import 'package:vinddd/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:vinddd/discover/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Main(),
          CreatePostScreen(),
          SearchScreen(),
          ActivityScreen(currentUserId: currentUserId),
          ProfilePage()
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      );

  }
}
