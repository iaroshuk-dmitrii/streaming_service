import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/configuration/configuration.dart';
import 'package:streaming_service/ui/screens/search_screen/search_screen_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:streaming_service/ui/navigation.dart';
import 'package:streaming_service/ui/widgets/rounded_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchScreenModel>();
    return Column(
      children: [
        AppBar(
          toolbarHeight: 75,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextField(
              cursorColor: Theme.of(context).hintColor,
              decoration: const InputDecoration(
                iconColor: Colors.amber,
                isCollapsed: true,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                prefixIconConstraints: BoxConstraints.tightFor(),
                hintText: 'Поиск',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              autofocus: true,
              onChanged: (value) => model.searchInString(value),
            ),
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
                                '${Configuration.imageServerUrl}artists/${model.artists[index].id}/images/633x422.jpg',
                            placeholder: (context, url) => const ColoredBox(color: Colors.grey),
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
