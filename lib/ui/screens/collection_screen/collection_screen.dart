import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/configuration/configuration.dart';
import 'package:streaming_service/models/stored_track_model.dart';
import 'package:streaming_service/ui/screens/collection_screen/collection_screen_model.dart';
import 'package:streaming_service/ui/widgets/marquee_widget.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';
import 'package:streaming_service/ui/widgets/rounded_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:streaming_service/ui/widgets/track_list_tile.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showPlayer(context);
    return Column(
      children: [
        AppBar(
          toolbarHeight: 60,
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
          child: Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => _showDeleteDialog(context, trackID: model.tracks[index].id),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                )
              ],
            ),
            child: TrackListTile(
              id: model.tracks[index].albumId,
              artistName: model.tracks[index].artistName,
              name: model.tracks[index].name,
              albumName: 'Album: ${model.tracks[index].albumName}',
              onIconPressed: () => model.showPlayer(model.tracks[index]),
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedButton(
                buttonTitle: 'Да',
                onPressed: () {
                  model.deleteTrack(trackID: trackID);
                  Navigator.of(context).pop();
                },
                transparent: true,
                minimumSize: const Size(110, 0),
              ),
              RoundedButton(
                buttonTitle: 'Нет',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                transparent: true,
                minimumSize: const Size(110, 0),
              ),
            ],
          ),
        ],
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        titlePadding: const EdgeInsets.fromLTRB(24, 25, 24, 5),
        actionsPadding: const EdgeInsets.fromLTRB(30, 5, 30, 24),
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
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            height: 100,
                            width: 100,
                            imageUrl:
                                '${Configuration.imageServerUrl}albums/${currentTrack.albumId}/images/300x300.jpg',
                            placeholder: (context, url) => const ColoredBox(color: Colors.grey),
                            errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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
