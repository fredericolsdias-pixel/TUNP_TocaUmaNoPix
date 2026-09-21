import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/tunp_api.dart';
import '../theme/app_theme.dart';

class RequestPage extends StatefulWidget {
  final String musica;
  final int showId;
  final int repertorioId;

  const RequestPage({
    super.key,
    required this.musica,
    required this.showId,
    required this.repertorioId,
  });

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final mesaController = TextEditingController();
  final mensagemController = TextEditingController();
  final gorjetaController = TextEditingController();

  bool enviando = false;

  @override
  void dispose() {
    nomeController.dispose();
    mesaController.dispose();
    mensagemController.dispose();
    gorjetaController.dispose();
    super.dispose();
  }

  String? _validarGorjeta(String? valor) {
    final normalizado =
        (valor ?? '').trim().replaceAll(',', '.');

    if (normalizado.isEmpty) {
      return null;
    }

    final formatoValido = RegExp(
      r'^\d{1,8}(\.\d{1,2})?$',
    ).hasMatch(normalizado);

    if (!formatoValido) {
      return 'Use um valor como 5,00 ou deixe em branco.';
    }

    return null;
  }

  Future<void> _confirmarPedido() async {
    if (enviando || !_formKey.currentState!.validate()) {
      return;
    }

    final gorjetaDigitada =
        gorjetaController.text.trim().replaceAll(',', '.');

    final valorGorjeta = gorjetaDigitada.isEmpty
        ? '0.00'
        : double.parse(
            gorjetaDigitada,
          ).toStringAsFixed(2);

    setState(() {
      enviando = true;
    });

    try {
      final resultado =
          await TunpApi.instance.criarPedido(
        showId: widget.showId,
        repertorioId: widget.repertorioId,
        nomeCliente: nomeController.text.trim(),
        identificadorMesa: mesaController.text.trim(),
        mensagem: mensagemController.text.trim(),
        valorGorjeta: valorGorjeta,
      );

      if (!mounted) return;

      setState(() {
        enviando = false;
      });

      await _mostrarResultado(resultado);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (erro) {
      if (!mounted) return;

      setState(() {
        enviando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            erro.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
        ),
      );
    }
  }

  Future<void> _mostrarResultado(
    PedidoCriado pedido,
  ) async {
    final valor = double.tryParse(
          pedido.valorGorjeta,
        ) ??
        0;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Pedido #${pedido.id} registrado',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Sua música entrou na fila do show.',
              ),

              if (pedido.pix != null) ...[
                const SizedBox(height: 18),
                Text(
                  'Gorjeta: R\$ ${pedido.pix!.valor.replaceAll('.', ',')}',
                ),
                const SizedBox(height: 10),
                Text(
                  'Chave Pix (${pedido.pix!.tipoChave}):',
                ),
                const SizedBox(height: 5),
                SelectableText(
                  pedido.pix!.chave,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Faça a transferência no seu aplicativo bancário. '
                  'O TUNP não confirma pagamentos automaticamente.',
                ),
              ] else if (valor > 0) ...[
                const SizedBox(height: 18),
                const Text(
                  'A gorjeta foi anotada, mas este show ainda '
                  'não possui uma chave Pix real cadastrada. '
                  'Não faça uma transferência para a chave de demonstração.',
                ),
              ],
            ],
          ),
          actions: [
            if (pedido.pix != null)
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: pedido.pix!.chave,
                    ),
                  );

                  if (dialogContext.mounted) {
                    ScaffoldMessenger.of(
                      dialogContext,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Chave Pix copiada.',
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copiar chave'),
              ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Concluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pedir música'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.musica,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Preencha os dados do seu pedido.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 26),

                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Seu nome',
                      ),
                      validator: (valor) {
                        if (valor == null ||
                            valor.trim().isEmpty) {
                          return 'Informe seu nome.';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: mesaController,
                      decoration: const InputDecoration(
                        labelText: 'Mesa (opcional)',
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: mensagemController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText:
                            'Mensagem para o músico (opcional)',
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: gorjetaController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText:
                            'Gorjeta em R\$ (opcional)',
                        hintText: 'Ex.: 5,00',
                      ),
                      validator: _validarGorjeta,
                    ),

                    const SizedBox(height: 9),

                    const Text(
                      'Deixe em branco para pedir sem gorjeta. '
                      'Se informar um valor e houver chave Pix '
                      'cadastrada, ela aparecerá após o pedido.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: enviando
                            ? null
                            : _confirmarPedido,
                        icon: enviando
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send),
                        label: Text(
                          enviando
                              ? 'Enviando...'
                              : 'Confirmar pedido',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}