import 'dart:io';

import 'package:dio/dio.dart';
import 'package:streaming_service/configuration/configuration.dart';
import 'package:streaming_service/models/top_artist_response.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    receiveTimeout: 10000,
    baseUrl: Configuration.baseUrl,
  ));

  Future<TopArtistResponse> getTopArtist({required int limit, int? offset}) async {
    try {
      final response = await _dio.get('artists/top', queryParameters: {
        'apikey': Configuration.apiKey,
        'limit': limit,
        'offset': offset ?? 0,
      });
      print(response.realUri);
      _validateResponse(response);
      final json = response.data as Map<String, dynamic>;
      final topArtistResponse = TopArtistResponse.fromJson(json);
      return topArtistResponse;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      print(e.toString());
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
