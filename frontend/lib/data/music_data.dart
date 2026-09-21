class MusicaItem {
  final String titulo;
  final String artista;
  final String categoria;

  const MusicaItem(this.titulo, this.artista, this.categoria);
}

// Dados temporários. Na integração com o backend, esta lista será
// substituída pelas músicas recebidas da API.
const List<MusicaItem> musicasDoShow = [
  MusicaItem('Evidências', 'Chitãozinho & Xororó', 'Sertanejo'),
  MusicaItem('Boate Azul', 'Bruno & Marrone', 'Sertanejo'),
  MusicaItem('O Alvo', 'Diego & Victor Hugo', 'Sertanejo'),
  MusicaItem('Telefone Mudo', 'Trio Parada Dura', 'Sertanejo'),
  MusicaItem(
    'Ainda Ontem Chorei de Saudade',
    'João Mineiro & Marciano',
    'Sertanejo',
  ),
  MusicaItem('Frio da Madrugada', 'Rionegro & Solimões', 'Sertanejo'),
  MusicaItem('Dormi na Praça', 'Bruno & Marrone', 'Sertanejo'),
  MusicaItem('Saudade da Minha Terra', 'Sérgio Reis', 'Sertanejo'),
  MusicaItem('É o Amor', 'Zezé Di Camargo & Luciano', 'Sertanejo'),
  MusicaItem('A Mala É Falsa', 'Felipe Araújo', 'Sertanejo'),

  MusicaItem('Anunciação', 'Alceu Valença', 'MPB'),
  MusicaItem('Como Nossos Pais', 'Elis Regina', 'MPB'),
  MusicaItem('Sozinho', 'Caetano Veloso', 'MPB'),
  MusicaItem('Sampa', 'Caetano Veloso', 'MPB'),
  MusicaItem('O Leãozinho', 'Caetano Veloso', 'MPB'),
  MusicaItem('Tarde em Itapuã', 'Toquinho & Vinicius de Moraes', 'MPB'),
  MusicaItem('Malandragem', 'Cássia Eller', 'MPB'),
  MusicaItem('O Caderno', 'Toquinho', 'MPB'),
  MusicaItem('Espumas ao Vento', 'Fagner', 'MPB'),
  MusicaItem('Açaí', 'Djavan', 'MPB'),

  MusicaItem('Primeiros Erros', 'Capital Inicial', 'Rock'),
  MusicaItem('Pais e Filhos', 'Legião Urbana', 'Rock'),
  MusicaItem('Exagerado', 'Cazuza', 'Rock'),
  MusicaItem('Tempo Perdido', 'Legião Urbana', 'Rock'),
  MusicaItem('Proibida Pra Mim', 'Charlie Brown Jr.', 'Rock'),
  MusicaItem('Me Adora', 'Pitty', 'Rock'),
  MusicaItem('O Passageiro', 'Capital Inicial', 'Rock'),
  MusicaItem('Vou Deixar', 'Skank', 'Rock'),
  MusicaItem('Anna Julia', 'Los Hermanos', 'Rock'),
  MusicaItem('Música Urbana', 'Capital Inicial', 'Rock'),

  MusicaItem('O Sol', 'Vitor Kley', 'Pop'),
  MusicaItem('Ouvi Dizer', 'Melim', 'Pop'),
  MusicaItem('Meu Abrigo', 'Melim', 'Pop'),
  MusicaItem('Pesadão', 'IZA & Marcelo Falcão', 'Pop'),
  MusicaItem('Dona Cisa', 'Anavitória', 'Pop'),
  MusicaItem('Trevo (Tu)', 'Anavitória & Tiago Iorc', 'Pop'),
  MusicaItem('Coisa Linda', 'Tiago Iorc', 'Pop'),
  MusicaItem('Fica', 'Anavitória & Matheus & Kauan', 'Pop'),
  MusicaItem('Brisa', 'IZA', 'Pop'),
  MusicaItem('Cerveja de Garrafa', 'Atitude 67', 'Pop'),

  MusicaItem('Péssimo Negócio', 'Dilsinho', 'Samba'),
  MusicaItem('Trem das Onze', 'Demônios da Garoa', 'Samba'),
  MusicaItem('Vou Festejar', 'Beth Carvalho', 'Samba'),
  MusicaItem(
    'O Show Tem Que Continuar',
    'Grupo Fundo de Quintal',
    'Samba',
  ),
  MusicaItem('Conselho', 'Almir Guineto', 'Samba'),
  MusicaItem('Maneiras', 'Zeca Pagodinho', 'Samba'),
  MusicaItem('Deixa Acontecer', 'Grupo Revelação', 'Samba'),
  MusicaItem('Tá Escrito', 'Grupo Revelação', 'Samba'),
  MusicaItem('Sufoco', 'Alcione', 'Samba'),
  MusicaItem('Verdade', 'Zeca Pagodinho', 'Samba'),
];