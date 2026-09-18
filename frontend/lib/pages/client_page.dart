import 'package:flutter/material.dart';

import '../screens/request_page.dart';
import '../screens/queue_page.dart';
import '../screens/painel_cantor_page.dart';
import '../screens/login_cantor_page.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String _categoriaSelecionada = "Todos";

  // Controlador de rolagem e chave para identificar a seção "Como Funciona"
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _comoFuncionaKey = GlobalKey();

  // Função simples para rolar até a seção
  void _rolarAteComoFunciona() {
    final context = _comoFuncionaKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  final List<Map<String, String>> _todasAsMusicas = [
    // --- SERTANEJO (10) ---
    {
      "titulo": "Evidências",
      "artista": "Chitãozinho & Xororó",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "Boate Azul",
      "artista": "Bruno & Marrone",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "O Alvo",
      "artista": "Diego & Victor Hugo",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "Telefone Mudo",
      "artista": "Trio Parada Dura",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "Ainda Ontem Chorei de Saudade",
      "artista": "João Mineiro & Marciano",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "Frio da Madrugada",
      "artista": "Rionegro & Solimões",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "Dormi na Praça",
      "artista": "Bruno & Marrone",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "Saudade da Minha Terra",
      "artista": "Sérgio Reis",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "É o Amor",
      "artista": "Zezé Di Camargo & Luciano",
      "categoria": "Sertanejo",
    },
    {
      "titulo": "A Mala É Falsa",
      "artista": "Felipe Araújo",
      "categoria": "Sertanejo",
    },

    // --- MPB (10) ---
    {"titulo": "Anunciação", "artista": "Alceu Valença", "categoria": "MPB"},
    {
      "titulo": "Como Nossos Pais",
      "artista": "Elis Regina",
      "categoria": "MPB",
    },
    {"titulo": "Sozinho", "artista": "Caetano Veloso", "categoria": "MPB"},
    {"titulo": "Sampa", "artista": "Caetano Veloso", "categoria": "MPB"},
    {"titulo": "O Leãozinho", "artista": "Caetano Veloso", "categoria": "MPB"},
    {
      "titulo": "Tarde em Itapuã",
      "artista": "Toquinho & Vinicius de Moraes",
      "categoria": "MPB",
    },
    {"titulo": "Malandragem", "artista": "Cássia Eller", "categoria": "MPB"},
    {"titulo": "O Caderno", "artista": "Toquinho", "categoria": "MPB"},
    {"titulo": "Espumas ao Vento", "artista": "Fagner", "categoria": "MPB"},
    {"titulo": "Açaí", "artista": "Djavan", "categoria": "MPB"},

    // --- ROCK (10) ---
    {
      "titulo": "Primeiros Erros",
      "artista": "Capital Inicial",
      "categoria": "Rock",
    },
    {
      "titulo": "Pais e Filhos",
      "artista": "Legião Urbana",
      "categoria": "Rock",
    },
    {"titulo": "Exagerado", "artista": "Cazuza", "categoria": "Rock"},
    {
      "titulo": "Tempo Perdido",
      "artista": "Legião Urbana",
      "categoria": "Rock",
    },
    {
      "titulo": "Proibida Pra Mim",
      "artista": "Charlie Brown Jr.",
      "categoria": "Rock",
    },
    {"titulo": "Me Adora", "artista": "Pitty", "categoria": "Rock"},
    {
      "titulo": "O Passageiro",
      "artista": "Capital Inicial",
      "categoria": "Rock",
    },
    {"titulo": "Vou Deixar", "artista": "Skank", "categoria": "Rock"},
    {"titulo": "Anna Julia", "artista": "Los Hermanos", "categoria": "Rock"},
    {
      "titulo": "Música Urbana",
      "artista": "Capital Inicial",
      "categoria": "Rock",
    },

    // --- POP (10) ---
    {"titulo": "O Sol", "artista": "Vitor Kley", "categoria": "Pop"},
    {"titulo": "Ouvi Dizer", "artista": "Melim", "categoria": "Pop"},
    {"titulo": "Meu Abrigo", "artista": "Melim", "categoria": "Pop"},
    {
      "titulo": "Pesadão",
      "artista": "IZA & Marcelo Falcão",
      "categoria": "Pop",
    },
    {"titulo": "Dona Cisa", "artista": "Anavitória", "categoria": "Pop"},
    {
      "titulo": "Trevo (Tu)",
      "artista": "Anavitória & Tiago Iorc",
      "categoria": "Pop",
    },
    {"titulo": "Coisa Linda", "artista": "Tiago Iorc", "categoria": "Pop"},
    {
      "titulo": "Fica",
      "artista": "Anavitória & Matheus & Kauan",
      "categoria": "Pop",
    },
    {"titulo": "Brisa", "artista": "IZA", "categoria": "Pop"},
    {
      "titulo": "Cerveja de Garrafa",
      "artista": "Atitude 67",
      "categoria": "Pop",
    },

    // --- SAMBA (10) ---
    {"titulo": "Péssimo Negócio", "artista": "Dilsinho", "categoria": "Samba"},
    {
      "titulo": "Trem das Onze",
      "artista": "Demônios da Garoa",
      "categoria": "Samba",
    },
    {
      "titulo": "Vou Festejar",
      "artista": "Beth Carvalho",
      "categoria": "Samba",
    },
    {
      "titulo": "O Show Tem Que Continuar",
      "artista": "Grupo Fundo de Quintal",
      "categoria": "Samba",
    },
    {"titulo": "Conselho", "artista": "Almir Guineto", "categoria": "Samba"},
    {"titulo": "Maneiras", "artista": "Zeca Pagodinho", "categoria": "Samba"},
    {
      "titulo": "Deixa Acontecer",
      "artista": "Grupo Revelação",
      "categoria": "Samba",
    },
    {
      "titulo": "Tá Escrito",
      "artista": "Grupo Revelação",
      "categoria": "Samba",
    },
    {"titulo": "Sufoco", "artista": "Alcione", "categoria": "Samba"},
    {"titulo": "Verdade", "artista": "Zeca Pagodinho", "categoria": "Samba"},
  ];

  List<Map<String, String>> get _musicasFiltradas {
    if (_categoriaSelecionada == "Todos") {
      return _todasAsMusicas;
    }
    return _todasAsMusicas
        .where((m) => m["categoria"] == _categoriaSelecionada)
        .toList();
  }

  final List<String> _categorias = [
    "Todos",
    "Sertanejo",
    "MPB",
    "Rock",
    "Pop",
    "Samba",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09080E),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // Header Topo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C3AED),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TUNP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Toca Uma No Pix",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E182A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFC9922B).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.mic, color: Color(0xFFC9922B), size: 14),
                        SizedBox(width: 6),
                        Text(
                          "Hoje: Banda Sorriso Aberto",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Banner Peça uma música
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Peça uma música",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Escolha seu hit. A fila aparece em tempo real para todo mundo.",
                    style: TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE2B93B),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            "Ver cardápio",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _rolarAteComoFunciona,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFF2A2438)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text("Como funciona"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF15121E),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_list_bulleted,
                                color: Colors.white60,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Fila transparente",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QueuePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.graphic_eq, size: 16),
                              SizedBox(width: 8),
                              Text(
                                "Ao vivo agora",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Cardápio Musical e Filtros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CARDÁPIO MUSICAL",
                    style: TextStyle(
                      color: Color(0xFFC9922B),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Escolha seu hit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              "Ver tudo",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white60,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categorias.map((categoria) {
                        final bool isSelected =
                            _categoriaSelecionada == categoria;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(categoria),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _categoriaSelecionada = categoria;
                              });
                            },
                            selectedColor: const Color(0xFF7C3AED),
                            backgroundColor: const Color(0xFF15121E),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.white60,
                              fontSize: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide.none,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _musicasFiltradas.length,
                    itemBuilder: (context, index) {
                      final musica = _musicasFiltradas[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF13101B),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              musica["titulo"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              musica["artista"]!,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RequestPage(
                                        musica: musica["titulo"]!,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add, size: 16),
                                label: const Text("Pedir música"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B5CF6),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Como Funciona
            Padding(
              key: _comoFuncionaKey,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "COMO FUNCIONA",
                    style: TextStyle(
                      color: Color(0xFFC9922B),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "3 passos simples",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    "1",
                    "Escolha a música",
                    "Selecione no cardápio e confirme o valor.",
                  ),
                  const SizedBox(height: 10),
                  _buildStepItem(
                    "2",
                    "Aguarde na fila",
                    "Veja sua posição em tempo real e acompanhe a ordem.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Fila de Pedidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "FILA DE PEDIDOS",
                    style: TextStyle(
                      color: Color(0xFFC9922B),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Veja quem está tocando agora",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildQueueItem(
                    "1",
                    "Ai, Se Eu Te Pego",
                    "Michel Teló",
                    "Marina",
                    "Tocando agora",
                    const Color(0xFF8B5CF6),
                  ),
                  _buildQueueItem(
                    "2",
                    "Mas, que Nada!",
                    "Jorge Ben Jor",
                    "Pedro",
                    "Próxima",
                    Colors.white24,
                  ),
                  _buildQueueItem(
                    "3",
                    "Lança Perfume",
                    "Rita Lee",
                    "Luana",
                    "Na fila",
                    Colors.white24,
                  ),
                  _buildQueueItem(
                    "4",
                    "Aquarela do Brasil",
                    "Ary Barroso",
                    "Bruno",
                    "Na fila",
                    Colors.white24,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Rodapé
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C3AED),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "TUNP",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Powered by TUNP - Toca Uma No Pix",
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "© 2026 TUNP. Todos os direitos reservados.",
                    style: TextStyle(color: Colors.white24, fontSize: 10),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String step, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF13101B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF7C3AED),
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
        ],
      ),
    );
  }

  Widget _buildQueueItem(
    String pos,
    String song,
    String artist,
    String user,
    String status,
    Color tagColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF13101B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            pos,
            style: const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  artist,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                user,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginCantorPage()),
                  );
                },
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC9922B),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
