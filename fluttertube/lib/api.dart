import 'dart:convert';

import 'package:fluttertube/model/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = 'AIzaSyApAutRp9eRO0wRpTVtkvnyB2Sx_KugkVg';

class Api {
  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      _nextToken = decoded['nextPageToken'];
      return decoded['items']
          .map<Video>((item) => Video.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");
    return decode(response);
  }
}
