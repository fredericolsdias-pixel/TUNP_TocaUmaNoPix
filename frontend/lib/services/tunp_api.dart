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

class FilaPedido {
  final int id;
  final String nomeCliente;
  final String titulo;
  final String artista;
  final String status;
  final String valorGorjeta;

  const FilaPedido({
    required this.id,
    required this.nomeCliente,
    required this.titulo,
    required this.artista,
    required this.status,
    required this.valorGorjeta,
  });

  factory FilaPedido.fromJson(Map<String, dynamic> json) {
    return FilaPedido(
      id: (json['id'] as num).toInt(),
      nomeCliente: json['nome_cliente'] as String,
      titulo: json['titulo'] as String,
      artista: json['artista'] as String,
      status: json['status'] as String,
      valorGorjeta:
          json['valor_gorjeta']?.toString() ?? '0.00',
    );
  }
}

class FilaDoShow {
  final FilaPedido? aoVivo;
  final List<FilaPedido> pedidos;

  const FilaDoShow({
    required this.aoVivo,
    required this.pedidos,
  });

  factory FilaDoShow.fromJson(Map<String, dynamic> json) {
    final aoVivoJson = json['ao_vivo'];
    final filaJson = json['fila'] as List<dynamic>;

    return FilaDoShow(
      aoVivo: aoVivoJson == null
          ? null
          : FilaPedido.fromJson(
              aoVivoJson as Map<String, dynamic>,
            ),
      pedidos: filaJson
          .map(
            (item) => FilaPedido.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

class PixDoPedido {
  final String tipoChave;
  final String chave;
  final String valor;

  const PixDoPedido({
    required this.tipoChave,
    required this.chave,
    required this.valor,
  });

  factory PixDoPedido.fromJson(Map<String, dynamic> json) {
    return PixDoPedido(
      tipoChave: json['tipo_chave'] as String,
      chave: json['chave'] as String,
      valor: json['valor'].toString(),
    );
  }
}

class PedidoCriado {
  final int id;
  final String valorGorjeta;
  final PixDoPedido? pix;

  const PedidoCriado({
    required this.id,
    required this.valorGorjeta,
    required this.pix,
  });

  factory PedidoCriado.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final pixJson = data['pix'];

    return PedidoCriado(
      id: (data['id'] as num).toInt(),
      valorGorjeta: data['valor_gorjeta'].toString(),
      pix: pixJson == null
          ? null
          : PixDoPedido.fromJson(
              pixJson as Map<String, dynamic>,
            ),
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

  Map<String, dynamic> _decodificar(http.Response resposta) {
    final texto = utf8.decode(resposta.bodyBytes);
    final json = jsonDecode(texto) as Map<String, dynamic>;

    if (resposta.statusCode < 200 ||
        resposta.statusCode >= 300) {
      final mensagem = json['message']?.toString() ??
          'Erro HTTP ${resposta.statusCode}.';

      throw Exception(mensagem);
    }

    return json;
  }

  Future<Map<String, dynamic>> _get(String path) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: const {
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    return _decodificar(resposta);
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

  Future<FilaDoShow> fila(int showId) async {
    final json = await _get(
      '/publico/shows/$showId/fila',
    );

    return FilaDoShow.fromJson(json);
  }

  Future<PedidoCriado> criarPedido({
    required int showId,
    required int repertorioId,
    required String nomeCliente,
    required String identificadorMesa,
    required String mensagem,
    required String valorGorjeta,
  }) async {
    final resposta = await http.post(
      Uri.parse(
        '$baseUrl/publico/shows/$showId/pedidos',
      ),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'repertorio_show_id': repertorioId,
        'nome_cliente': nomeCliente,
        'identificador_mesa': identificadorMesa,
        'mensagem': mensagem,
        'valor_gorjeta': valorGorjeta,
      }),
    ).timeout(const Duration(seconds: 10));

    return PedidoCriado.fromJson(
      _decodificar(resposta),
    );
  }
}