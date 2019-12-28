import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favourite_bloc.dart';
import 'package:fluttertube/blocs/video_bloc.dart';
import 'package:fluttertube/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocProvider(
        child: MaterialApp(
          home: Home(),
          title: 'FlutterTube',
          debugShowCheckedModeBanner: false,
        ),
        bloc: FavouriteBlock(),
      ),
      bloc: VideosBloc(),
    );
  }
}
