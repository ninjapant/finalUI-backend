import 'package:flutter/material.dart';
import 'package:vinddd/discover//utils/tik_tok_icons_icons.dart';

class AnotherToolbar extends StatelessWidget {
  // Full dimensions of an action
  static const double ActionWidgetSize = 60.0;

// The size of the icon showen for Social Actions
  static const double ActionIconSize = 35.0;

// The size of the share social icon
  static const double ShareActionIconSize = 25.0;

// The size of the profile image in the follow Action
  static const double ProfileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
  static const double PlusIconSize = 20.0;

  final String numLikes;
  final String numComments;

  AnotherToolbar(this.numLikes , this.numComments);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0 ,
      child: Column(mainAxisSize: MainAxisSize.min , children: [
        _getSocialAction(icon: TikTokIcons.heart , title: numLikes) ,
        _getSocialAction(icon: TikTokIcons.chat_bubble , title: numComments) ,
        _getSocialAction(
            icon: TikTokIcons.reply , title: 'Share' , isShare: true) ,
      ]) ,
    );
  }

  Widget _getSocialAction(
      {String title , IconData icon , bool isShare = false}) {
    return Container(
        margin: EdgeInsets.only(top: 15.0) ,
        width: 60.0 ,
        height: 60.0 ,
        child: Column(children: [
          Icon(icon , size: isShare ? 25.0 : 35.0 , color: Colors.grey[300]) ,
          Padding(
            padding: EdgeInsets.only(top: isShare ? 5.0 : 2.0) ,
            child:
            Text(title , style: TextStyle(fontSize: isShare ? 10.0 : 12.0)) ,
          )
        ]));
  }


  LinearGradient get musicGradient =>
      LinearGradient(
          colors: [
            Colors.grey[800] ,
            Colors.grey[900] ,
            Colors.grey[900] ,
            Colors.grey[800]
          ] ,
          stops: [0.0 , 0.4 , 0.6 , 1.0] ,
          begin: Alignment.bottomLeft ,
          end: Alignment.topRight
      );

}