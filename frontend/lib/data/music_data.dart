class MusicaItem {
  final int id;
  final String titulo;
  final String artista;
  final String categoria;

  const MusicaItem({
    required this.id,
    required this.titulo,
    required this.artista,
    required this.categoria,
  });

  factory MusicaItem.fromJson(Map<String, dynamic> json) {
    return MusicaItem(
      // Este é o ID do item no repertório do show.
      // Ele será usado para cadastrar o pedido.
      id: (json['id'] as num).toInt(),
      titulo: json['titulo'] as String,
      artista: json['artista'] as String,
      categoria: (json['categoria'] as String?) ?? 'Outros',
    );
  }
}