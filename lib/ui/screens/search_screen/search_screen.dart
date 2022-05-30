import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/screens/search_screen/search_screen_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:streaming_service/ui/navigation.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchScreenModel>();
    return Column(
      children: [
        AppBar(
          title: const Text('Поиск'),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => model.changeSearchString(value),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
                ),
                onPressed: () => model.searchArtistList(),
                child: const Text('Поиск'),
              ),
            ],
          ),
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
                  model.searchArtistList();
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
                    Navigator.of(context).pushNamed(Screens.artistsAbout, arguments: model.artists[index]);
                  },
                );
              }),
        )
      ],
    );
  }
}
