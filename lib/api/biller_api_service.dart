import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

class BillerApiService {
  BillerApiService({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Uri _uri(String path) {
    final String normalizedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return Uri.parse('$normalizedBase$path');
  }

  Future<Map<String, dynamic>> getSupportedBillersRaw() async {
    final http.Response response = await _client.get(
      _uri('/supported-billers'),
      headers: _jsonHeaders(),
    );

    final Object? body = _decodeBody(response);
    _throwIfNotSuccess(response, body);

    if (body is Map<String, dynamic>) {
      return body;
    }

    return <String, dynamic>{};
  }

  void dispose() {
    _client.close();
  }

  Map<String, String> _jsonHeaders() {
    return const <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Object? _decodeBody(http.Response response) {
    if (response.body.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(response.body);
    } catch (_) {
      return response.body;
    }
  }

  void _throwIfNotSuccess(http.Response response, Object? body) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    final String message = _extractErrorMessage(body) ?? 'Request failed';
    throw ApiException(
      message: message,
      statusCode: response.statusCode,
      details: body,
    );
  }

  String? _extractErrorMessage(Object? body) {
    if (body is String && body.isNotEmpty) {
      return body;
    }

    if (body is Map<String, dynamic>) {
      final Object? detail = body['detail'];
      if (detail is String && detail.isNotEmpty) {
        return detail;
      }
      final Object? message = body['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return null;
  }
}
