import 'package:flutter/material.dart';

class MusicCatalog extends StatelessWidget {
  const MusicCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      color: const Color(0xFF151515),
      child: Column(
        children: [
          const Text(
            "🎵 Repertório da Noite",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          Wrap(
            spacing: 10,
            children: [
              _genreButton("Todos"),
              _genreButton("Sertanejo"),
              _genreButton("MPB"),
              _genreButton("Rock"),
              _genreButton("Pop"),
              _genreButton("Samba"),
            ],
          ),

          const SizedBox(height: 40),

          _musicCard("Evidências", "Chitãozinho & Xororó"),

          const SizedBox(height: 15),

          _musicCard("Boate Azul", "Bruno & Marrone"),

          const SizedBox(height: 15),

          _musicCard(
            "Ainda Ontem Chorei de Saudade",
            "João Mineiro & Marciano",
          ),
        ],
      ),
    );
  }

  Widget _genreButton(String text) {
    return ElevatedButton(onPressed: () {}, child: Text(text));
  }

  Widget _musicCard(String musica, String artista) {
    return Card(
      color: const Color(0xFF222222),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(musica),
        subtitle: Text(artista),
        trailing: ElevatedButton(onPressed: () {}, child: const Text("Pedir")),
      ),
    );
  }
}
