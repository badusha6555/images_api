import 'package:album_api/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        final albumProvider =
            Provider.of<AlbumProvider>(context, listen: false);
        await albumProvider.getAlbums();
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Album View',
          style: GoogleFonts.laBelleAurore(color: Colors.deepPurple),
        ),
        centerTitle: true,
      ),
      body: Consumer<AlbumProvider>(
        builder: (context, albumProvider, child) {
          // Check if albumList is empty or null to show loading or error message
          if (albumProvider.albumList == null) {
            return Center(child: CircularProgressIndicator());
          } else if (albumProvider.albumList.isEmpty) {
            return Center(
              child: Text(
                'No albums available',
                style: GoogleFonts.laBelleAurore(
                    fontSize: 20, color: Colors.white),
              ),
            );
          } else {
            // Display GridView only if albumList has data
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: albumProvider.albumList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(7),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${albumProvider.albumList[index].title}',
                        style: GoogleFonts.laBelleAurore(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        '${albumProvider.albumList[index].url}',
                        height: 70,
                        width: 100,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
