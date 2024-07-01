import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../constants.dart' as constants;
import '../../Models/music.dart';

class MusicPlayer extends StatefulWidget {
  final String trackID;
  const MusicPlayer({required this.trackID});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState(trackID);
}

class _MusicPlayerState extends State<MusicPlayer> {
  final String trackID;
  final player = AudioPlayer();
  late Music music;
  bool isLoading = true; // Loading state indicator

  _MusicPlayerState(this.trackID) {
    music = Music(trackId: trackID);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final credentials =
        SpotifyApiCredentials(constants.clientId, constants.clientSecret);
    final spotify = SpotifyApi(credentials);
    spotify.tracks.get(music.trackId).then((track) async {
      String? tempSongName = track.name;
      if (tempSongName != null) {
        music.songName = tempSongName;
        music.artistName = track.artists?.first.name ?? "";
        String? image = track.album?.images?.first.url;
        if (image != null) {
          music.songImage = image;
          final tempSongColor = await getImagePalette(NetworkImage(image));
          if (tempSongColor != null) {
            music.songColor = tempSongColor;
          }
        }
        music.artistImage = track.artists?.first.images?.first.url;
        final yt = YoutubeExplode();
        final video =
            (await yt.search.search("$tempSongName ${music.artistName ?? ""}"))
                .first;
        final videoId = video.id.value;
        music.duration = video.duration;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        player.play(UrlSource(audioUrl.toString()));
      }
      setState(() {
        isLoading = false; // Data is fully loaded
      });
    }).catchError((error) {
      print("Error loading data: $error");
      setState(() {
        isLoading = false; // Ensure loading is stopped if an error occurs
      });
    });
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: music.songColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.close, color: Colors.transparent),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Singing Now',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Color(0xFF1BB751)),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: music.artistImage != null
                                      ? NetworkImage(music.artistImage!)
                                      : null,
                                  radius: 10,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  music.artistName ?? '-',
                                  style: textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: ArtWorkImage(image: music.songImage),
                        )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    music.songName ?? '',
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    music.artistName ?? '-',
                                    style: textTheme.titleMedium
                                        ?.copyWith(color: Colors.white60),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        StreamBuilder(
                            stream: player.onPositionChanged,
                            builder: (context, data) {
                              return ProgressBar(
                                progress:
                                    data.data ?? const Duration(seconds: 0),
                                total: music.duration ??
                                    const Duration(minutes: 4),
                                bufferedBarColor: Colors.white38,
                                baseBarColor: Colors.white10,
                                thumbColor: Colors.white,
                                timeLabelTextStyle:
                                    const TextStyle(color: Colors.white),
                                progressBarColor: Colors.white,
                                onSeek: (duration) {
                                  player.seek(duration);
                                },
                              );
                            }),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.skip_previous,
                                    color: Colors.white, size: 36)),
                            IconButton(
                                onPressed: () async {
                                  if (player.state == PlayerState.playing) {
                                    await player.pause();
                                  } else {
                                    await player.resume();
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  player.state == PlayerState.playing
                                      ? Icons.pause
                                      : Icons.play_circle,
                                  color: Colors.white,
                                  size: 60,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.skip_next,
                                    color: Colors.white, size: 36)),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
        ),
      ),
    );
  }
}

class MusicScreen extends StatelessWidget {
  final Music music; // Assuming you have a Music class defined elsewhere

  MusicScreen({required this.music});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: music.artistImage != null
                    ? NetworkImage(music.artistImage!)
                    : null,
                radius: 10,
              ),
              const SizedBox(width: 4),
              Text(
                music.artistName ?? '-',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArtWorkImage extends StatelessWidget {
  final String? image;

  const ArtWorkImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * .4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: image != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image!),
                )
              : null),
    );
  }
}
