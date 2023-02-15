class AudioModel {
  final String title;
  final String audioUrl;
  final String id;
  final bool isFav;

  AudioModel(
      {required this.title,
      required this.audioUrl,
      this.id = '',
      this.isFav = false});
}
