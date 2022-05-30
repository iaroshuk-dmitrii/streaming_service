import 'package:flutter/material.dart';
import 'package:streaming_service/models/artist_model.dart';

class ArtistsAboutScreenModel extends ChangeNotifier {
  final ArtistModel artist;

  ArtistsAboutScreenModel({required this.artist});
}
