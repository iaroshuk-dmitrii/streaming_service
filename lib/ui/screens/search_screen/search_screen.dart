import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/screens/search_screen/search_screen_model.dart';
import 'package:streaming_service/ui/navigation.dart';
import 'package:streaming_service/ui/widgets/artist_card.dart';
import 'package:streaming_service/utils/get_image_url.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchScreenModel>();
    return Column(
      children: [
        AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              cursorColor: Theme.of(context).hintColor,
              decoration: const InputDecoration(
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
              autofocus: false,
              onChanged: (value) => model.searchInString(value),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
              controller: model.scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                childAspectRatio: (155 / 120),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              itemCount: model.artists.length,
              itemBuilder: (BuildContext context, int index) {
                if (index >= model.artists.length - 4) {
                  model.searchArtistList();
                }
                return GestureDetector(
                  child: ArtistCard(
                    artistName: model.artists[index].name,
                    photoUrl: getArtistPhotoUrl(model.artists[index].id),
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
