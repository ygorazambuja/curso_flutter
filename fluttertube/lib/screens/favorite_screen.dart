import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/blocs/favourite_bloc.dart';
import 'package:fluttertube/model/video.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBlock>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values
                .map(
                  (item) => InkWell(
                    onLongPress: () {
                      bloc.toggleFavourite(item);
                    },
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                          apiKey: API_KEY, videoId: item.id);
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.network(item.thumb),
                        ),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
