import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/screens/artists_about_screen/artists_about_screen_model.dart';

class ArtistsAboutScreen extends StatelessWidget {
  const ArtistsAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      pinned: true,
      expandedHeight: (MediaQuery.of(context).size.width / 1.5),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(model.artist.name),
        centerTitle: true,
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: 'https://api.napster.com/imageserver/v2/artists/${model.artist.id}/images/633x422.jpg',
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
            child: Text(bio),
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
              child: ListTile(
                title: Text(model.tracks[index].name),
                subtitle: Text(model.tracks[index].albumName),
                leading: CachedNetworkImage(
                  height: 65,
                  width: 65,
                  // fit: BoxFit.fill,
                  imageUrl:
                      'https://api.napster.com/imageserver/v2/albums/${model.tracks[index].albumId}/images/300x300.jpg',
                  errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
                ),
                trailing: IconButton(
                    onPressed: () {
                      model.playTrack(model.tracks[index]);
                    },
                    icon: const Icon(Icons.play_circle_outline)),
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
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25)),
              ),
              onPressed: () => model.getTrackList(),
              child: const Text('Загрузить ещё'),
            ),
          ),
        ),
      );
    }
  }
}
