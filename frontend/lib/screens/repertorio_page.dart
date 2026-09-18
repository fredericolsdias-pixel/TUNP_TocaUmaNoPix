import 'package:flutter/material.dart';

class RepertorioPage extends StatefulWidget {
  const RepertorioPage({super.key});

  @override
  State<RepertorioPage> createState() => _RepertorioPageState();
}

class _RepertorioPageState extends State<RepertorioPage> {
  // ============================================================
  // DADOS TEMPORÁRIOS
  // ============================================================

  final List<Map<String, dynamic>> musicas = [
    {
      'titulo': 'Evidências',
      'artista': 'Chitãozinho & Xororó',
      'genero': 'Sertanejo',
      'disponivel': true,
      'valor_minimo': 0.00,
    },
    {
      'titulo': 'Boate Azul',
      'artista': 'Bruno & Marrone',
      'genero': 'Sertanejo',
      'disponivel': true,
      'valor_minimo': 5.00,
    },
    {
      'titulo': 'Pais e Filhos',
      'artista': 'Legião Urbana',
      'genero': 'Rock',
      'disponivel': false,
      'valor_minimo': 0.00,
    },
    {
      'titulo': 'Garota de Ipanema',
      'artista': 'Tom Jobim',
      'genero': 'MPB',
      'disponivel': true,
      'valor_minimo': 10.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF08061A),
        elevation: 0,
        title: const Text(
          'Gerenciar Repertório',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ======================================================
            // CABEÇALHO
            // ======================================================

            const Center(
              child: Column(
                children: [

                  Icon(
                    Icons.library_music,
                    color: Color(0xFF7C3AED),
                    size: 80,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Meu Repertório',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Gerencie as músicas disponíveis no seu show.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // ======================================================
            // BOTÃO ADICIONAR
            // ======================================================

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _adicionarMusica,

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  'Adicionar música',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // TÍTULO
            // ======================================================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  'Músicas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '${musicas.length} músicas',
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ======================================================
            // LISTA DE MÚSICAS
            // ======================================================

            ...musicas.asMap().entries.map((entry) {

              final int index = entry.key;
              final musica = entry.value;

              return _buildMusicCard(
                index: index,
                titulo: musica['titulo'],
                artista: musica['artista'],
                genero: musica['genero'],
                disponivel: musica['disponivel'],
                valorMinimo: musica['valor_minimo'],
              );
            }),

            const SizedBox(height: 30),

            // ======================================================
            // INFORMAÇÃO
            // ======================================================

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),

                border: Border.all(
                  color: const Color(0xFF7C3AED),
                ),
              ),

              child: const Column(
                children: [

                  Icon(
                    Icons.info_outline,
                    color: Color(0xFF7C3AED),
                    size: 35,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Sobre o repertório',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'As músicas marcadas como disponíveis poderão ser solicitadas pelos clientes durante o show.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CARD DA MÚSICA
  // ============================================================

  Widget _buildMusicCard({
    required int index,
    required String titulo,
    required String artista,
    required String genero,
    required bool disponivel,
    required double valorMinimo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF161229),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ÍCONE

              const Icon(
                Icons.music_note,
                color: Color(0xFF7C3AED),
                size: 35,
              ),

              const SizedBox(width: 15),

              // INFORMAÇÕES

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      artista,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Text(
                        genero,
                        style: const TextStyle(
                          color: Color(0xFFB794F4),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // MENU

              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white70,
                ),

                color: const Color(0xFF161229),

                onSelected: (valor) {

                  if (valor == 'editar') {
                    _editarMusica(index);
                  }

                  if (valor == 'excluir') {
                    _excluirMusica(index);
                  }
                },

                itemBuilder: (context) => const [

                  PopupMenuItem(
                    value: 'editar',
                    child: Text(
                      'Editar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  PopupMenuItem(
                    value: 'excluir',
                    child: Text(
                      'Excluir',
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ========================================================
          // LINHA INFERIOR
          // ========================================================

          Row(
            children: [

              Expanded(
                child: Text(
                  valorMinimo > 0
                      ? 'Gorjeta mínima: R\$ ${valorMinimo.toStringAsFixed(2).replaceAll('.', ',')}'
                      : 'Sem valor mínimo',

                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),

              const Text(
                'Disponível',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(width: 8),

              Switch(
                value: disponivel,

                activeColor: const Color(0xFF7C3AED),

                onChanged: (valor) {

                  setState(() {
                    musicas[index]['disponivel'] = valor;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ADICIONAR MÚSICA
  // ============================================================

  void _adicionarMusica() {

    final tituloController = TextEditingController();
    final artistaController = TextEditingController();
    final generoController = TextEditingController();
    final valorController = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          backgroundColor: const Color(0xFF161229),

          title: const Text(
            'Adicionar música',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              children: [

                _buildDialogField(
                  controller: tituloController,
                  label: 'Nome da música',
                  icon: Icons.music_note,
                ),

                const SizedBox(height: 15),

                _buildDialogField(
                  controller: artistaController,
                  label: 'Artista original',
                  icon: Icons.person,
                ),

                const SizedBox(height: 15),

                _buildDialogField(
                  controller: generoController,
                  label: 'Gênero',
                  icon: Icons.category,
                ),

                const SizedBox(height: 15),

                _buildDialogField(
                  controller: valorController,
                  label: 'Gorjeta mínima',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {

                if (tituloController.text.trim().isEmpty) {
                  return;
                }

                setState(() {

                  musicas.add({
                    'titulo': tituloController.text,
                    'artista': artistaController.text,
                    'genero': generoController.text,
                    'disponivel': true,
                    'valor_minimo':
                        double.tryParse(
                              valorController.text.replaceAll(',', '.'),
                            ) ??
                            0.00,
                  });
                });

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
              ),

              child: const Text(
                'Adicionar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CAMPO DO DIALOG
  // ============================================================

  Widget _buildDialogField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboardType,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        labelText: label,

        labelStyle: const TextStyle(
          color: Colors.white70,
        ),

        prefixIcon: Icon(
          icon,
          color: const Color(0xFF7C3AED),
        ),

        filled: true,

        fillColor: const Color(0xFF08061A),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ============================================================
  // EDITAR
  // ============================================================

  void _editarMusica(int index) {

    final musica = musicas[index];

    final tituloController = TextEditingController(
      text: musica['titulo'],
    );

    final artistaController = TextEditingController(
      text: musica['artista'],
    );

    final generoController = TextEditingController(
      text: musica['genero'],
    );

    final valorController = TextEditingController(
      text: musica['valor_minimo'].toString(),
    );

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          backgroundColor: const Color(0xFF161229),

          title: const Text(
            'Editar música',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              children: [

                _buildDialogField(
                  controller: tituloController,
                  label: 'Nome da música',
                  icon: Icons.music_note,
                ),

                const SizedBox(height: 15),

                _buildDialogField(
                  controller: artistaController,
                  label: 'Artista original',
                  icon: Icons.person,
                ),

                const SizedBox(height: 15),

                _buildDialogField(
                  controller: generoController,
                  label: 'Gênero',
                  icon: Icons.category,
                ),

                const SizedBox(height: 15),

                _buildDialogField(
                  controller: valorController,
                  label: 'Gorjeta mínima',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {

                setState(() {

                  musicas[index]['titulo'] =
                      tituloController.text;

                  musicas[index]['artista'] =
                      artistaController.text;

                  musicas[index]['genero'] =
                      generoController.text;

                  musicas[index]['valor_minimo'] =
                      double.tryParse(
                            valorController.text.replaceAll(',', '.'),
                          ) ??
                          0.00;
                });

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
              ),

              child: const Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // EXCLUIR
  // ============================================================

  void _excluirMusica(int index) {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          backgroundColor: const Color(0xFF161229),

          title: const Text(
            'Excluir música?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            'Essa música será removida do repertório.',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {

                setState(() {
                  musicas.removeAt(index);
                });

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),

              child: const Text(
                'Excluir',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}