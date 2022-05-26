import 'package:flutter/material.dart';
import 'package:streaming_service/models/top_artist_response.dart';
import 'package:streaming_service/repositories/api_client.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();
    return Column(
      children: [
        AppBar(
          title: const Text('Популярные исполнители'),
        ),
        TextButton(
            onPressed: () async {
              TopArtistResponse topArtistResponse = await apiClient.getTopArtist(limit: 10);
              print(topArtistResponse.toString());
            },
            child: Text('Получить'))
      ],
    );
  }
}
