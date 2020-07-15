import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:vinddd/discover//data/videos_api.dart';
import 'package:vinddd/discover//screens/home.dart';

import 'bloc/videos.bloc.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        blocs: [
          Bloc((i) => VideosBloc(VideosAPI())),
        ],
        child:
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // Uncomment in phase 3 to apply white to text
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white
            ),
          ),
          home: Home(),
        )
    );
  }
}