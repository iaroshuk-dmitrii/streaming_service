import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:streaming_service/configuration/configuration.dart';
import 'package:streaming_service/models/artist_top_tracks_response.dart';
import 'package:streaming_service/models/search_artist_response.dart';
import 'package:streaming_service/models/top_artist_response.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    receiveTimeout: 10000,
    baseUrl: Configuration.baseUrl,
    headers: {'apikey': Configuration.apiKey},
  ));

  Future<TopArtistResponse> getTopArtists({required int limit, int? offset}) async {
    try {
      final response = await _dio.get('artists/top', queryParameters: {
        'limit': limit,
        'offset': offset ?? 0,
        'lang': 'ru-RU',
      });
      _validateResponse(response);
      final json = response.data as Map<String, dynamic>;
      final topArtistResponse = TopArtistResponse.fromJson(json);
      return topArtistResponse;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<SearchArtistResponse> searchArtist({required String searchString, required int limit, int? offset}) async {
    try {
      final response = await _dio.get('search', queryParameters: {
        'query': searchString,
        'type': 'artist',
        'limit': limit,
        'offset': offset ?? 0,
        'lang': 'ru-RU',
      });
      _validateResponse(response);
      final json = response.data as Map<String, dynamic>;
      final searchArtistResponse = SearchArtistResponse.fromJson(json);
      return searchArtistResponse;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<ArtistTopTracksResponse> getTopArtistTracks(
      {required String artistId, required int limit, int? offset}) async {
    try {
      final response = await _dio.get('artists/$artistId/tracks', queryParameters: {
        'limit': limit,
        'offset': offset ?? 0,
        'lang': 'ru-RU',
      });
      _validateResponse(response);
      final json = response.data as Map<String, dynamic>;
      final artistTopTracksResponse = ArtistTopTracksResponse.fromJson(json);

      return artistTopTracksResponse;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        throw ApiClientException(ApiClientExceptionType.api);
      default:
        throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

class ApiClientException implements Exception {
  ApiClientExceptionType exception;

  ApiClientException(
    this.exception,
  );
}

enum ApiClientExceptionType { network, other, api }
