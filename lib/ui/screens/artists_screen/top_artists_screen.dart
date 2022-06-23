import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/navigation.dart';
import 'package:streaming_service/ui/screens/artists_screen/top_artists_screen_model.dart';
import 'package:streaming_service/ui/widgets/artist_card.dart';
import 'package:streaming_service/utils/get_image_url.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TopArtistsScreenModel>();
    return Column(
      children: [
        AppBar(
          title: const Text('Исполнители'),
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
                  model.getArtistList();
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
