import 'package:album_api/model/model.dart';
import 'package:dio/dio.dart';

class AlbumServices {
  final url = "https://jsonplaceholder.typicode.com/photos";
  final Dio dio = Dio();

  Future<List<AlbumModel>> getAlbums() async {
    try {
      Response response = await dio.get(url);
      List<AlbumModel> albums =
          (response.data as List).map((e) => AlbumModel.fromJson(e)).toList();
      print(albums);
      return albums;
    } catch (e) {
      throw Exception("Error getting albums:$e");
    }
  }
}
