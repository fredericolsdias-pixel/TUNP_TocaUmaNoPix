import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/music_data.dart';

class ShowInfo {
  final int id;
  final String nome;
  final String nomeArtista;

  const ShowInfo({
    required this.id,
    required this.nome,
    required this.nomeArtista,
  });

  factory ShowInfo.fromJson(Map<String, dynamic> json) {
    final musico = json['musico'] as Map<String, dynamic>;

    return ShowInfo(
      id: (json['id'] as num).toInt(),
      nome: json['nome'] as String,
      nomeArtista: musico['nome_artistico'] as String,
    );
  }
}

class TunpApi {
  TunpApi._();

  static final TunpApi instance = TunpApi._();

  static const String baseUrl = String.fromEnvironment(
    'TUNP_API_URL',
    defaultValue: 'http://127.0.0.1:8000/api',
  );

  Future<Map<String, dynamic>> _get(String path) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: const {
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    if (resposta.statusCode != 200) {
      throw Exception(
        'Não foi possível consultar o servidor '
        '(HTTP ${resposta.statusCode}).',
      );
    }

    final texto = utf8.decode(resposta.bodyBytes);
    return jsonDecode(texto) as Map<String, dynamic>;
  }

  Future<ShowInfo?> showAtual() async {
    final json = await _get('/publico/shows');
    final shows = json['data'] as List<dynamic>;

    if (shows.isEmpty) {
      return null;
    }

    return ShowInfo.fromJson(
      shows.first as Map<String, dynamic>,
    );
  }

  Future<List<MusicaItem>> repertorio(int showId) async {
    final json = await _get(
      '/publico/shows/$showId/repertorio',
    );

    final musicas = json['data'] as List<dynamic>;

    return musicas
        .map(
          (item) => MusicaItem.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}