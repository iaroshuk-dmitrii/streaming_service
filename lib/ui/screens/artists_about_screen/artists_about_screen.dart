import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/models/track_model.dart';
import 'package:streaming_service/ui/screens/artists_about_screen/artists_about_screen_model.dart';
import 'package:streaming_service/ui/widgets/marquee_widget.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';
import 'package:streaming_service/ui/widgets/rounded_button.dart';
import 'package:streaming_service/ui/widgets/track_list_tile.dart';
import 'package:streaming_service/utils/get_image_url.dart';

class ArtistsAboutScreen extends StatelessWidget {
  const ArtistsAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showPlayer(context);
    return const Material(
      color: Colors.black,
      child: CustomScrollView(
        slivers: [
          _PhotoAppBar(),
          _BioList(),
          _TrackList(),
          _LoadButton(),
        ],
      ),
    );
  }
}

class _PhotoAppBar extends StatelessWidget {
  const _PhotoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ArtistsAboutScreenModel>();
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      pinned: true,
      expandedHeight: (MediaQuery.of(context).size.width / 1.5),
      flexibleSpace: FlexibleSpaceBar(
        title: MarqueeWidget(child: Text(model.artist.name)),
        centerTitle: true,
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: getArtistPhotoUrl(model.artist.id),
          placeholder: (context, url) => const ColoredBox(color: Colors.grey),
          errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
        ),
      ),
    );
  }
}

class _BioList extends StatelessWidget {
  const _BioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ArtistsAboutScreenModel>();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: model.artist.bios?.length ?? 0,
        (BuildContext context, int index) {
          final bio = model.artist.bios?[index]?.bio ?? '';
          return Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
            ),
            child: Html(data: bio),
          );
        },
      ),
    );
  }
}

class _TrackList extends StatelessWidget {
  const _TrackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ArtistsAboutScreenModel>();
    if (model.tracks.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: model.tracks.length,
          (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TrackListTile(
                id: model.tracks[index].albumId,
                name: model.tracks[index].name,
                albumName: model.tracks[index].albumName,
                onIconPressed: () => model.showPlayer(model.tracks[index]),
              ),
            );
          },
        ),
      );
    } else {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
  }
}

class _LoadButton extends StatelessWidget {
  const _LoadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ArtistsAboutScreenModel>();
    if (model.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: RoundedButton(
              buttonTitle: 'Загрузить ещё',
              onPressed: () => model.getTrackList(),
            ),
          ),
        ),
      );
    }
  }
}

Future<void> _showPlayer(BuildContext context) async {
  final model = context.read<ArtistsAboutScreenModel>();
  bool playerIsShown = context.select((ArtistsAboutScreenModel model) => model.playerIsShown);
  TrackModel? currentTrack = context.select((ArtistsAboutScreenModel model) => model.currentTrack);
  if (playerIsShown && currentTrack != null) {
    context.read<PlayerWidgetModel>().setParams(trackUrl: currentTrack.previewURL);
    Future.microtask(
      () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            height: 100,
                            width: 100,
                            imageUrl: getAlbumPhotoUrl(currentTrack.albumId),
                            placeholder: (context, url) => const ColoredBox(color: Colors.grey),
                            errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MarqueeWidget(
                                child: Text(
                              currentTrack.albumName,
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                            MarqueeWidget(
                                child: Text(
                              currentTrack.name,
                              style: Theme.of(context).textTheme.labelLarge,
                            )),
                            const Expanded(child: SizedBox.shrink()),
                            SmallRoundedButton(
                              buttonTitle: 'В коллекцию',
                              onPressed: () => model.addToCollection(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const PlayerWidget(),
                ],
              ),
            ),
          );
        },
      ).whenComplete(() {
        model.hidePlayer();
        context.read<PlayerWidgetModel>().reset();
      }),
    );
  }
}
