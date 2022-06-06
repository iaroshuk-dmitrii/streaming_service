import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/models/stored_track_model.dart';
import 'package:streaming_service/ui/screens/collection_screen/collection_screen_model.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';
import 'package:streaming_service/ui/widgets/rounded_button.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showPlayer(context);
    return Column(
      children: [
        AppBar(
          title: const Text('Коллекция'),
          actions: const [
            _SortButton(),
          ],
        ),
        const Expanded(child: _TrackList()),
      ],
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CollectionScreenModel>();
    return IconButton(onPressed: () => model.changeSort(), icon: const Icon(Icons.sort));
  }
}

class _TrackList extends StatelessWidget {
  const _TrackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CollectionScreenModel>();
    return ListView.builder(
      controller: model.scrollController,
      itemCount: model.tracks.length,
      itemBuilder: (BuildContext context, int index) {
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
              onPressed: () => model.showPlayer(model.tracks[index]),
              icon: const Icon(Icons.play_circle_outline),
            ),
            onLongPress: () => _showDeleteDialog(context, trackID: model.tracks[index].id),
          ),
        );
      },
    );
  }
}

_showDeleteDialog(BuildContext context, {required String trackID}) {
  final model = context.read<CollectionScreenModel>();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Вы уверены, что хотите удалить трек?',
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                child: const Text('Да'),
                onPressed: () {
                  model.deleteTrack(trackID: trackID);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Нет'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25.0),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15.0),
      );
    },
  );
}

Future<void> _showPlayer(BuildContext context) async {
  final model = context.read<CollectionScreenModel>();
  bool playerIsShown = context.select((CollectionScreenModel model) => model.playerIsShown);
  StoredTrackModel? currentTrack = context.select((CollectionScreenModel model) => model.currentTrack);
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
                  Row(
                    children: [
                      CachedNetworkImage(
                        height: 100,
                        width: 100,
                        // fit: BoxFit.fill,
                        imageUrl:
                            'https://api.napster.com/imageserver/v2/albums/${currentTrack.albumId}/images/300x300.jpg',
                        errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
                      ),
                      const SizedBox(width: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentTrack.albumName),
                          Text(currentTrack.name),
                        ],
                      ),
                    ],
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
