import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/screens/artists_screen/top_artists_screen_model.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TopArtistsScreenModel>();
    return Column(
      children: [
        AppBar(
          title: const Text('Популярные исполнители'),
        ),
        Expanded(
          child: GridView.builder(
              controller: model.scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: (155 / 120),
              ),
              itemCount: model.artists.length,
              itemBuilder: (BuildContext context, int index) {
                if (index >= model.artists.length - 4) {
                  model.getArtistList();
                }
                return GestureDetector(
                  child: Card(
                    color: Colors.black54,
                    margin: const EdgeInsets.all(15.0),
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                'https://api.napster.com/imageserver/v2/artists/${model.artists[index].id}/images/633x422.jpg',
                            // placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              model.artists[index].name,
                              style: const TextStyle(fontSize: 20),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    //TODO
                  },
                );
              }),
        )
      ],
    );
  }
}
