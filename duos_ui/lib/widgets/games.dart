class Games {
  final String title;
  final String urlImage;

  const Games({required this.title, required this.urlImage});

  static List<String> listGames(List<Games> input) {
    List<String> result = [];
    for (Games game in input) {
      result.add(game.title);
    }
    return result;
  }
}

const allGames = [
  Games(title: 'Valorant', urlImage: ''),
  Games(title: 'League of Legends', urlImage: ''),
  Games(title: 'Stardew Valley', urlImage: ''),
  Games(title: 'Overwatch 2', urlImage: '')
];
