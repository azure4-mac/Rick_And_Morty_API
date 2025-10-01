class Info {
  int count;
  int pages;
  String? next;
  String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}

class Episode {
  final int id;
  final String name;
  final String air_date;
  final String episode;
  final List<String> characters;
  final String url;
  final String createed;

  const Episode({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
    required this.createed,
  });
}

class EpisodeResponse {
  final Info info;
  final List<Episode> results;

  const EpisodeResponse({required this.info, required this.results});

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Episode> episodeList = list.map((i) => Episode.fromJson(i)).toList();

    return EpisodeResponse(
      info: Info.fromJson(json['info']),
      results: episodeList,
    );
  }
}
