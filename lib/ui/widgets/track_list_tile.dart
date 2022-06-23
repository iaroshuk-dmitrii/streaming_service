import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:streaming_service/ui/widgets/marquee_widget.dart';
import 'package:streaming_service/utils/get_image_url.dart';

class TrackListTile extends StatelessWidget {
  final String id;
  final String? name;
  final String? artistName;
  final String? albumName;
  final void Function()? onIconPressed;

  const TrackListTile({
    Key? key,
    required this.id,
    this.name,
    this.albumName,
    this.artistName,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        children: [
          CachedNetworkImage(
            height: 65,
            width: 65,
            imageUrl: getAlbumPhotoUrl(id),
            placeholder: (context, url) => const ColoredBox(color: Colors.grey),
            errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  artistName != null
                      ? MarqueeWidget(
                          child: Text(
                          artistName!,
                          style: Theme.of(context).textTheme.labelSmall,
                        ))
                      : const SizedBox.shrink(),
                  name != null
                      ? MarqueeWidget(
                          child: Text(
                          name!,
                          style: Theme.of(context).textTheme.labelLarge,
                        ))
                      : const SizedBox.shrink(),
                  albumName != null
                      ? MarqueeWidget(
                          child: Text(
                          albumName!,
                          style: Theme.of(context).textTheme.labelMedium,
                        ))
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              padding: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.primary,
              onPressed: onIconPressed,
              icon: const Icon(
                Icons.play_circle_outline,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
