import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/mappers/bpi_api_mappers.dart';
import '../models.dart';
import 'api_exception.dart';
import 'bpi_api_models.dart';

class BpiApiService {
  BpiApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Uri _uri(String path) {
    final String normalizedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return Uri.parse('$normalizedBase$path');
  }

  Future<Map<String, dynamic>> ping() async {
    final http.Response response = await _client.get(
      _uri('/'),
      headers: _jsonHeaders(),
    );

    final Object? body = _decodeBody(response);
    _throwIfNotSuccess(response, body);

    return _asMap(body);
  }

  Future<Map<String, dynamic>> getBalanceRaw({required String accountId}) async {
    final http.Response response = await _client.get(
      _uri('/balance/$accountId'),
      headers: _jsonHeaders(),
    );

    final Object? body = _decodeBody(response);
    _throwIfNotSuccess(response, body);

    return _asMap(body);
  }

  Future<double> getBalance({required String accountId}) async {
    final Map<String, dynamic> body = await getBalanceRaw(accountId: accountId);
    return BpiApiMappers.mapBalanceResponse(body, accountId: accountId);
  }

  Future<Map<String, dynamic>> getTransactionHistoryRaw({
    required String userId,
  }) async {
    final http.Response response = await _client.get(
      _uri('/transactions/$userId'),
      headers: _jsonHeaders(),
    );

    final Object? body = _decodeBody(response);
    _throwIfNotSuccess(response, body);

    return _asMap(body);
  }

  Future<List<BankTransaction>> getTransactionHistory({
    required String userId,
  }) async {
    final Map<String, dynamic> body = await getTransactionHistoryRaw(
      userId: userId,
    );
    return BpiApiMappers.mapTransactionsResponse(body);
  }

  Future<Map<String, dynamic>> internalCredit({
    required Map<String, dynamic> payload,
  }) async {
    final http.Response response = await _client.post(
      _uri('/internal/credit'),
      headers: _jsonHeaders(),
      body: jsonEncode(payload),
    );

    final Object? body = _decodeBody(response);
    _throwIfNotSuccess(response, body);

    return _asMap(body);
  }

  Future<BpiTransferResult> transferFunds({
    required BpiTransferRequest request,
  }) async {
    final http.Response response = await _client.post(
      _uri('/transfer'),
      headers: _jsonHeaders(),
      body: jsonEncode(request.toJson()),
    );

    final Object? body = _decodeBody(response);
    _throwIfNotSuccess(response, body);

    return BpiApiMappers.mapTransferResponse(body);
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

  Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    return <String, dynamic>{};
  }
}
