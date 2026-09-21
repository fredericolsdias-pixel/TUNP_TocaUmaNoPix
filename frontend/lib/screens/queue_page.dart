import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  static const _base = 'http://127.0.0.1:8000/api/publico';

  Timer? _atualizador;
  Map<String, dynamic>? _fila;
  String? _erro;
  bool _buscando = false;

  @override
  void initState() {
    super.initState();
    _atualizar();

    _atualizador = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _atualizar(),
    );
  }

  @override
  void dispose() {
    _atualizador?.cancel();
    super.dispose();
  }

  Future<dynamic> _buscar(String caminho) async {
    final resposta = await http.get(
      Uri.parse('$_base$caminho'),
      headers: {'Accept': 'application/json'},
    );

    final json = jsonDecode(utf8.decode(resposta.bodyBytes));

    if (resposta.statusCode < 200 || resposta.statusCode >= 300) {
      throw Exception(
        json is Map
            ? json['message'] ?? 'Erro ao atualizar a fila.'
            : 'Erro ao atualizar a fila.',
      );
    }

    return json;
  }

  Future<void> _atualizar() async {
    if (_buscando) return;

    _buscando = true;

    try {
      final respostaShows = await _buscar('/shows');
      final shows = respostaShows['data'] as List;

      if (shows.isEmpty) {
        if (!mounted) return;

        setState(() {
          _fila = {'ao_vivo': null, 'fila': []};
          _erro = null;
        });
        return;
      }

      final showId = (shows.first as Map)['id'];
      final dados = await _buscar('/shows/$showId/fila');

      if (!mounted) return;

      setState(() {
        _fila = Map<String, dynamic>.from(dados as Map);
        _erro = null;
      });
    } catch (erro) {
      if (!mounted) return;

      setState(() {
        _erro = '$erro'.replaceFirst('Exception: ', '');
      });
    } finally {
      _buscando = false;
    }
  }

  Widget _musica(Map<String, dynamic> pedido, {int? posicao}) {
    final status = pedido['status']?.toString() ?? 'PENDENTE';
    final valor = pedido['valor_gorjeta']?.toString() ?? '0.00';

    return Card(
      color: const Color(0xFF161229),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF7C3AED),
          child: posicao == null
              ? const Icon(Icons.graphic_eq, color: Colors.white)
              : Text(
                  '$posicao',
                  style: const TextStyle(color: Colors.white),
                ),
        ),
        title: Text(pedido['musica']?.toString() ?? 'Música'),
        subtitle: Text(
          '${pedido['nome_cliente'] ?? 'Cliente'}'
          ' • ${status == 'ACEITO' ? 'Aceito' : status == 'TOCANDO' ? 'Tocando' : 'Pendente'}'
          '\nGorjeta informada: R\$ ${valor.replaceAll('.', ',')}',
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aoVivo = _fila?['ao_vivo'];
    final pedidos = _fila?['fila'] as List? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF08061A),
      appBar: AppBar(
        title: const Text('Fila e ao vivo agora'),
        backgroundColor: const Color(0xFF08061A),
        actions: [
          IconButton(
            tooltip: 'Atualizar agora',
            onPressed: _atualizar,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _fila == null && _erro == null
          ? const Center(child: CircularProgressIndicator())
          : _fila == null
              ? Center(child: Text(_erro!))
              : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        if (_erro != null)
                          Text(
                            'Atualização indisponível: $_erro',
                            style: const TextStyle(color: Colors.orangeAccent),
                          ),
                        const Text(
                          'Ao vivo agora',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        aoVivo == null
                            ? const Text('Nenhuma música tocando agora.')
                            : _musica(
                                Map<String, dynamic>.from(aoVivo as Map),
                              ),
                        const SizedBox(height: 30),
                        Text(
                          'Próximos pedidos (${pedidos.length})',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (pedidos.isEmpty)
                          const Text('A fila está vazia.'),
                        for (var i = 0; i < pedidos.length; i++)
                          _musica(
                            Map<String, dynamic>.from(pedidos[i] as Map),
                            posicao: i + 1,
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}