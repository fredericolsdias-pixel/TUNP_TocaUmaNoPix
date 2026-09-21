import 'dart:async';

import 'package:flutter/material.dart';

import '../services/cantor_api.dart';

class PedidosCantorPage extends StatefulWidget {
  const PedidosCantorPage({super.key});

  @override
  State<PedidosCantorPage> createState() => _PedidosCantorPageState();
}

class _PedidosCantorPageState extends State<PedidosCantorPage> {
  Timer? _atualizador;
  Map<String, dynamic>? _dados;
  String? _erro;
  bool _buscando = false;
  bool _alterando = false;

  @override
  void initState() {
    super.initState();
    _carregar();

    _atualizador = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _carregar(),
    );
  }

  @override
  void dispose() {
    _atualizador?.cancel();
    super.dispose();
  }

  Future<void> _carregar() async {
    if (_buscando || _alterando) return;

    _buscando = true;

    try {
      final resposta = await CantorApi.pedidos();

      if (!mounted) return;

      setState(() {
        _dados = resposta;
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

  Future<void> _mudar(Map<String, dynamic> pedido, String status) async {
    if (_alterando) return;

    if (status == 'RECUSADO') {
      final confirmou = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Recusar pedido?'),
          content: Text(
            'O pedido de ${pedido['nome_cliente']} sairá da fila.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Recusar'),
            ),
          ],
        ),
      );

      if (confirmou != true || !mounted) return;
    }

    setState(() => _alterando = true);

    try {
      await CantorApi.mudarStatus(pedido['id'] as int, status);

      if (mounted) {
        setState(() => _alterando = false);
        await _carregar();
      }
    } catch (erro) {
      if (!mounted) return;

      setState(() => _alterando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$erro'.replaceFirst('Exception: ', '')),
        ),
      );

      await _carregar();
    }
  }

  Widget _card(Map<String, dynamic> pedido) {
    final status = pedido['status']?.toString() ?? '';
    final gorjeta = pedido['valor_gorjeta']?.toString() ?? '0.00';

    return Card(
      color: const Color(0xFF161229),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pedido['musica']?.toString() ?? 'Música',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${pedido['nome_cliente']}'
              '${pedido['identificador_mesa'] == null ? '' : ' • Mesa ${pedido['identificador_mesa']}'}',
            ),
            const SizedBox(height: 5),
            Text('Estado: $status'),
            Text('Gorjeta informada: R\$ ${gorjeta.replaceAll('.', ',')}'),
            if ((pedido['mensagem']?.toString() ?? '').isNotEmpty) ...[
              const SizedBox(height: 5),
              Text('Mensagem: ${pedido['mensagem']}'),
            ],
            if (status == 'PENDENTE' ||
                status == 'ACEITO' ||
                status == 'TOCANDO') ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (status == 'PENDENTE')
                    FilledButton(
                      onPressed: _alterando
                          ? null
                          : () => _mudar(pedido, 'ACEITO'),
                      child: const Text('Aceitar'),
                    ),
                  if (status == 'ACEITO')
                    FilledButton.icon(
                      onPressed: _alterando
                          ? null
                          : () => _mudar(pedido, 'TOCANDO'),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Iniciar música'),
                    ),
                  if (status == 'TOCANDO')
                    FilledButton.icon(
                      onPressed: _alterando
                          ? null
                          : () => _mudar(pedido, 'CONCLUIDO'),
                      icon: const Icon(Icons.check),
                      label: const Text('Concluir'),
                    ),
                  if (status == 'PENDENTE' || status == 'ACEITO')
                    OutlinedButton(
                      onPressed: _alterando
                          ? null
                          : () => _mudar(pedido, 'RECUSADO'),
                      child: const Text('Recusar'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aoVivo = _dados?['ao_vivo'];
    final fila = (_dados?['fila'] as List? ?? []);
    final historico = (_dados?['historico'] as List? ?? []);

    return Scaffold(
      backgroundColor: const Color(0xFF08061A),
      appBar: AppBar(
        title: const Text('Pedidos do show'),
        backgroundColor: const Color(0xFF08061A),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            onPressed: _carregar,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _dados == null && _erro == null
          ? const Center(child: CircularProgressIndicator())
          : _dados == null
              ? Center(child: Text(_erro!))
              : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        if (_erro != null)
                          Text(
                            'Não foi possível atualizar: $_erro',
                            style: const TextStyle(color: Colors.orangeAccent),
                          ),
                        const Text(
                          'Ao vivo agora',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        aoVivo == null
                            ? const Text('Nenhuma música está tocando.')
                            : _card(
                                Map<String, dynamic>.from(aoVivo as Map),
                              ),
                        const SizedBox(height: 28),
                        Text(
                          'Fila (${fila.length})',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (fila.isEmpty)
                          const Text('Nenhum pedido aguardando.'),
                        for (final item in fila)
                          _card(Map<String, dynamic>.from(item as Map)),
                        const SizedBox(height: 28),
                        const Text(
                          'Últimos pedidos finalizados',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (historico.isEmpty)
                          const Text('Ainda não há pedidos finalizados.'),
                        for (final item in historico)
                          _card(Map<String, dynamic>.from(item as Map)),
                      ],
                    ),
                  ),
                ),
    );
  }
}
