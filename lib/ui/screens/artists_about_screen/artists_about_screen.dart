import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/screens/artists_about_screen/artists_about_screen_model.dart';

class ArtistsAboutScreen extends StatelessWidget {
  const ArtistsAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ArtistsAboutScreenModel>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(model.artist.name),
        ),
        SliverToBoxAdapter(
          child: Container(),
        ),
      ],
    );
  }
}
