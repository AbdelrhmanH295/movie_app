class MovieData {
  final int? movieCount;
  final List<Movie>? movies;

  MovieData({this.movieCount, this.movies});

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      movieCount: json['movie_count'] as int?,
      movies: (json['movies'] != null)
          ? (json['movies'] as List<dynamic>)
              .map((movieJson) => Movie.fromJson(movieJson))
              .toList()
          : null,
    );
  }
}

class Movie {
  final int? id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? summary;
  final String? descriptionFull;
  final String? synopsis;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String? mediumCoverImage;
  final String? state;
  final List<Torrent>? torrents;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int?,
      url: json['url'] as String?,
      imdbCode: json['imdb_code'] as String?,
      title: json['title'] as String?,
      titleEnglish: json['title_english'] as String?,
      titleLong: json['title_long'] as String?,
      slug: json['slug'] as String?,
      year: json['year'] as int?,
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      runtime: json['runtime'] as int?,
      genres: (json['genres'] != null)
          ? List<String>.from(json['genres'])
          : null,
      summary: json['summary'] as String?,
      descriptionFull: json['description_full'] as String?,
      synopsis: json['synopsis'] as String?,
      ytTrailerCode: json['yt_trailer_code'] as String?,
      language: json['language'] as String?,
      mpaRating: json['mpa_rating'] as String?,
      backgroundImage: json['background_image'] as String?,
      backgroundImageOriginal: json['background_image_original'] as String?,
      smallCoverImage: json['small_cover_image'] as String?,
      mediumCoverImage: json['medium_cover_image'] as String?,
      state: json['state'] as String?,
      torrents: (json['torrents'] != null)
          ? (json['torrents'] as List<dynamic>)
              .map((torrentJson) => Torrent.fromJson(torrentJson))
              .toList()
          : null,
      dateUploaded: json['date_uploaded'] as String?,
      dateUploadedUnix: json['date_uploaded_unix'] as int?,
    );
  }
}

class Torrent {
  final String? url;
  final String? hash;
  final String? quality;
  final String? isRepack;
  final String? videoCodec;
  final String? bitDepth;
  final String? audioChannels;
  final int? seeds;
  final int? peers;
  final String? size;
  final int? sizeBytes;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'] as String?,
      hash: json['hash'] as String?,
      quality: json['quality'] as String?,
      isRepack: json['is_repack'] as String?,
      videoCodec: json['video_codec'] as String?,
      bitDepth: json['bit_depth'] as String?,
      audioChannels: json['audio_channels'] as String?,
      seeds: json['seeds'] as int?,
      peers: json['peers'] as int?,
      size: json['size'] as String?,
      sizeBytes: json['size_bytes'] as int?,
      dateUploaded: json['date_uploaded'] as String?,
      dateUploadedUnix: json['date_uploaded_unix'] as int?,
    );
  }
}

class Meta {
  final int? serverTime;
  final String? serverTimezone;
  final int? apiVersion;
  final String? executionTime;

  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      serverTime: json['server_time'] as int?,
      serverTimezone: json['server_timezone'] as String?,
      apiVersion: json['api_version'] as int?,
      executionTime: json['execution_time'] as String?,
    );
  }
}