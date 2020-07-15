import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _getPostsList(context),
          _getHeader(context),
          _getBottomBarShadow(context),

        ],
      ),
    );
  }
}

_getHeader(context) {
  return Positioned(
    top: 0,
    child: Container(
      padding: EdgeInsets.fromLTRB(15, 35, 15, 15),
      height: 350,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 5))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.arrow_back),
              Text('Charlie Damelio',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Icon(Icons.more_horiz)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _getAvatar(),
          SizedBox(height: 10),
          Text(
            'Charlie Damelio',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Text('I love my life', style: TextStyle(fontSize: 14)),
          SizedBox(height: 10),
          _getUserStats(),
          SizedBox(
            height: 10,
          ),
          _getUserBtns(),
        ],
      ),
    ),
  );
}

_getUserBtns() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.orange.shade400, Colors.pink]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          'Follow/Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300),
        child: Icon(Icons.near_me),
      )
    ],
  );
}

_getUserStats() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              border:
              Border(right: BorderSide(color: Colors.grey, width: 0.5))),
          child: Column(
            children: <Widget>[
              Text('56'),
              Text('Posts', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              border:
              Border(right: BorderSide(color: Colors.grey, width: 0.5))),
          child: Column(
            children: <Widget>[
              Text('2852'),
              Text('Followers', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
      Expanded(
        child: Column(
          children: <Widget>[
            Text('452'),
            Text('Following', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    ],
  );
}

_getAvatar() {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: <Widget>[
      Container(
        width: 73,
        height: 73,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.orange.shade400, Colors.pink]),
            borderRadius: BorderRadius.circular(50)),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        radius: 35,
      ),
      CircleAvatar(
        backgroundImage: AssetImage('image/charlie.jpg'),
        radius: 30,
      ),
    ],
  );
}

_getPostsList(context) {
  return Container(
    color: Colors.grey.withOpacity(0.35),
    child: GridView.count(
      padding: EdgeInsets.fromLTRB(10, 365, 10, 110),
      crossAxisCount: 2,
      children: <Widget>[
        _getPost(context: context, image: AssetImage('image/first.jpg')),
        _getPost(context: context, image: AssetImage('image/second.jpg')),
        _getPost(context: context, image: AssetImage('image/third.png')),
        _getPost(context: context, image: AssetImage('image/fourth.jpg')),
        _getPost(context: context, image: AssetImage('image/fifth.jpg')),
        _getPost(context: context, image: AssetImage('image/sixth.jpeg')),
      ],
    ),
  );
}

_getPost({context, ImageProvider image}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.width * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: image,
          ),
          borderRadius: BorderRadius.circular(20)),
    ),
  );
}

_getBottomBarShadow(context) {
  return Positioned(
    bottom: 0,
    child: Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.grey.withOpacity(0.8),
                Colors.grey.withOpacity(0.01),
              ])),
    ),
  );
}


class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.moveTo(0, sh * 0.35);
    path.lineTo(sw * 0.3, sh * 0.35);
    path.cubicTo(sw * 0.4, sh * 0.35, sw * 0.4, 0, sw * 0.5, 0);
    path.cubicTo(sw * 0.6, 0, sw * 0.6, sh * 0.35, sw * 0.7, sh * 0.35);
    path.lineTo(sw, sh * 0.35);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}