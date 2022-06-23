import 'package:streaming_service/configuration/configuration.dart';

String getArtistPhotoUrl(String artistId) {
  return '${Configuration.imageServerUrl}artists/$artistId/images/633x422.jpg';
}

String getAlbumPhotoUrl(String albumId) {
  return '${Configuration.imageServerUrl}albums/$albumId/images/300x300.jpg';
}
