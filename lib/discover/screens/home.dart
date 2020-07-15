import 'package:flutter/material.dart';
import 'package:vinddd/discover//bloc/videos.bloc.dart';
import 'package:vinddd/discover//data/videos_api.dart';
import 'package:vinddd/discover//models/videos.dart';
import 'package:vinddd/discover//widgets/actions_toolbar.dart';
import 'package:vinddd/discover//widgets/another_toolbar.dart';
import 'package:vinddd/discover//widgets/bottom_toolbar.dart';
import 'package:vinddd/discover//widgets/video_description.dart';
import 'package:video_player/video_player.dart';
import 'package:vinddd/discover//data/firebase.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream<List<Video>> listVideos;
  VideosBloc _videosBloc;

  @override
  void initState() {
    super.initState();
    _videosBloc = VideosBloc(VideosAPI());
    listVideos = _videosBloc.listVideos;
  }

  Widget get topSection => Container(
    height: 100.0,
    padding: EdgeInsets.only(bottom: 15.0),
    alignment: Alignment(0.0, 1.0),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Following'),
          Container(
            width: 15.0,
          ),
          Text('For you',
              style: TextStyle(
                  fontSize: 17.0, fontWeight: FontWeight.bold))
        ]),
  );

  Widget videoViewer(){

    return Container(
        child: Center(
            child: StreamBuilder(
                initialData: List<Video>(),
                stream: listVideos,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  List<Video> videos = snapshot.data;
                  if(videos.length > 0){
                    return PageView.builder(
                      controller: PageController(
                        initialPage: 0,
                        viewportFraction: 1,
                      ),
                      onPageChanged: (index){
                        index = index % (videos.length);
                        _videosBloc.videoManager.changeVideo(index);
                      },
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context,index){
                        index = index % (videos.length);
                        return videoCard(_videosBloc.videoManager.listVideos[index]);
                      },
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                }
            )
        ));
  }

  Widget videoCard(Video video){
    var controller = video.controller;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        controller != null && controller.value.initialized ?
        GestureDetector(
            onTap: () {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            },
            child:
            SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size?.width ?? 0,
                    height: controller.value.size?.height ?? 0,
                    child: VideoPlayer(controller),
                  ),
                )
            )
        ) : Column(mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            LinearProgressIndicator(),
            SizedBox(height: 56,)
          ],),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AnotherToolbar(video.likes,video.comments),
              VideoDescription(video.user,video.videoTitle,video.songName),
              ActionsToolbar(video.userPic),
            ],
          ),
          SizedBox(height: 65)
        ],)
      ],
    );
  }

  Widget get middleSection => Expanded(
      child: videoViewer());

  Widget screenUI(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        topSection,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Stack(children: <Widget>[
        Column(
          children: <Widget>[
            middleSection,
          ],
        ),
        screenUI()
      ]
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}