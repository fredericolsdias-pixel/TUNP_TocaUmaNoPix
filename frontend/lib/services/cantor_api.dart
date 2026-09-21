import 'dart:convert';

import 'package:http/http.dart' as http;

class CantorApi {
  static const String _base = 'http://127.0.0.1:8000/api/cantor';

  // Sessão somente em memória: ao atualizar o navegador, entre novamente.
  static String? _token;

  static bool get estaLogado => _token != null;

  static Map<String, String> get _headers => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  static dynamic _resultado(http.Response response) {
    final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final mensagem = json is Map
          ? json['message']?.toString()
          : null;

      throw Exception(mensagem ?? 'Erro ${response.statusCode} na API.');
    }

    return json['data'];
  }

  static Future<void> entrar(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$_base/entrar'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'password': senha,
      }),
    );

    final data = _resultado(response) as Map<String, dynamic>;
    _token = data['token'] as String;
  }

  static Future<Map<String, dynamic>> meusDados() async {
    final response = await http.get(
      Uri.parse('$_base/me'),
      headers: _headers,
    );

    return Map<String, dynamic>.from(_resultado(response) as Map);
  }

  static Future<void> atualizarDados(Map<String, dynamic> dados) async {
    final response = await http.put(
      Uri.parse('$_base/me'),
      headers: _headers,
      body: jsonEncode(dados),
    );

    _resultado(response);
  }

  static Future<List<Map<String, dynamic>>> repertorio() async {
    final response = await http.get(
      Uri.parse('$_base/repertorio'),
      headers: _headers,
    );

    final itens = _resultado(response) as List;
    return itens
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  static Future<void> adicionarMusica(Map<String, dynamic> dados) async {
    final response = await http.post(
      Uri.parse('$_base/repertorio'),
      headers: _headers,
      body: jsonEncode(dados),
    );

    _resultado(response);
  }

  static Future<void> atualizarMusica(
    int repertorioId,
    Map<String, dynamic> dados,
  ) async {
    final response = await http.patch(
      Uri.parse('$_base/repertorio/$repertorioId'),
      headers: _headers,
      body: jsonEncode(dados),
    );

    _resultado(response);
  }

  static Future<void> arquivarMusica(int repertorioId) async {
    final response = await http.delete(
      Uri.parse('$_base/repertorio/$repertorioId'),
      headers: _headers,
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      _resultado(response);
    }
  }

  static Future<void> sair() async {
    try {
      if (_token != null) {
        await http.post(Uri.parse('$_base/sair'), headers: _headers);
      }
    } finally {
      _token = null;
    }
  }

  static Future<Map<String, dynamic>> pedidos() async {
    final response = await http.get(
      Uri.parse('$_base/pedidos'),
      headers: _headers,
    );

    return Map<String, dynamic>.from(_resultado(response) as Map);
  }

  static Future<void> mudarStatus(int pedidoId, String status) async {
    final response = await http.patch(
      Uri.parse('$_base/pedidos/$pedidoId/status'),
      headers: _headers,
      body: jsonEncode({'status': status}),
    );

    _resultado(response);
  }
}