import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:musicui/theme/colors.dart';

class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;

  const MusicDetailPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.color,
      required this.img,
      required this.songUrl})
      : super(key: key);

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  double _currentSliderValue = 20;

  // audio player here
  late AudioPlayer advancedPlayer;
  late AudioCache audioCache;
  bool isPlaying = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    playSound(widget.songUrl);
  }

  playSound(localPath) async {
    await audioCache.play(localPath);
  }

  stopSound(localPath) async {
    File audioFile = await audioCache.load(localPath);
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.stop();
  }

  seekSound() async {
    File audioFile = await audioCache.load(widget.songUrl);
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.seek(const Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopSound(widget.songUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar(),
      ),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: black,
      elevation: 0,
      actions: const [
        IconButton(
          icon: Icon(
            Feather.more_vertical,
            color: white,
          ),
          onPressed: null,
        )
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Stack(
                  children: [
                    Container(
                      width: size.width - 100,
                      height: size.width - 100,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: widget.color,
                                blurRadius: 50,
                                spreadRadius: 5,
                                offset: const Offset(-10, 40)),
                          ],
                          color: primary,
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Stack(
                  children: [
                    Container(
                      width: size.width - 60,
                      height: size.width - 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.img), fit: BoxFit.cover),
                          color: primary,
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: size.width - 80,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    AntDesign.addfolder,
                    color: white,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.description,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Feather.more_vertical,
                    color: white,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Slider(
              activeColor: primary,
              value: _currentSliderValue,
              min: 0,
              max: 200,
              onChanged: (value) {
                setState(() {
                  _currentSliderValue = value;
                });
                seekSound();
              }),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1:50",
                  style: TextStyle(color: white.withOpacity(0.5)),
                ),
                Text(
                  "4:68",
                  style: TextStyle(color: white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Feather.shuffle,
                    color: white.withOpacity(0.8),
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Feather.skip_back,
                    color: white.withOpacity(0.8),
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                    iconSize: 50,
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary,
                      ),
                      child: Center(
                        child: Icon(
                          isPlaying
                              ? Entypo.controller_stop
                              : Entypo.controller_play,
                          size: 28,
                          color: white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        stopSound(widget.songUrl);
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        playSound(widget.songUrl);
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    }),
                IconButton(
                  icon: Icon(
                    Feather.skip_forward,
                    color: white.withOpacity(0.8),
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Feather.repeat,
                    color: white.withOpacity(0.8),
                    size: 25,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Feather.tv,
                color: primary,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  "Airplay ready",
                  style: TextStyle(color: primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
