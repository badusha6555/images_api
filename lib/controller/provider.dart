import 'package:album_api/model/model.dart';
import 'package:album_api/services/services.dart';
import 'package:flutter/material.dart';

class AlbumProvider extends ChangeNotifier {
  List<AlbumModel> albumList = [];
  AlbumServices albumServices = AlbumServices();
  bool isLoading = false;
  Future<List<AlbumModel?>> getAlbums() async {
    isLoading = true;
    notifyListeners();
    try {
      albumList = await albumServices.getAlbums();
      isLoading = false;
      notifyListeners();
      return albumList;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error getting albums:$e");
    }
  }
}
