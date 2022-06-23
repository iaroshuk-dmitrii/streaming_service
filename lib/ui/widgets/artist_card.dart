import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  final String artistName;
  final String photoUrl;

  const ArtistCard({
    Key? key,
    required this.artistName,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 75,
            child: SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: photoUrl,
                placeholder: (context, url) => const ColoredBox(color: Colors.grey),
                errorWidget: (context, url, error) => const ColoredBox(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 45,
            child: ColoredBox(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    artistName,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
