import 'package:gamelobby/helper/models/api/contents.dart';
import 'package:gamelobby/helper/models/api/friendinvitations.dart';
import 'package:gamelobby/helper/models/api/friendship.dart';
import 'package:gamelobby/models/music.dart';
import 'package:get/get.dart';

class AppLists {
  static String imgURL =
      "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/";
  static Rxn<List<APIFriendship>> friendsList = Rxn();

  static Rxn<List<APIFriendship>> offlinefriendsList = Rxn();
  static Rxn<List<APIFriendship>> onlinefriendsList = Rxn();

  static Rxn<List<APIFriendinvitations>> friendsInvitationList = Rxn();
  static Rxn<List<APIFriendinvitations>> lobbyInvitationList = Rxn();

  static Rxn<List<APIContents>> newsList = Rxn();
  static Rxn<List<APIContents>> updateList = Rxn();
  static Rxn<List<APIContents>> eventList = Rxn();

  static List<String> backgroundImages = [
    "assets/images/wallpapers/1.png",
    "assets/images/wallpapers/2.png",
    "assets/images/wallpapers/3.png",
    "assets/images/wallpapers/4.png",
    "assets/images/wallpapers/5.png",
    "assets/images/wallpapers/6.jpg",
    "assets/images/wallpapers/7.jpg",
    "assets/images/wallpapers/8.jpg",
    "assets/images/wallpapers/9.jpg",
  ];

  static List<Music> musicList = <Music>[
    Music(
      name: "ScaryHorror Music",
      path: "sounds/musics/music1.mp3",
      img: "https://cdn.pixabay.com/audio/2025/05/29/07-46-14-803_200x200.png",
      owner: "DELOSound",
    ),
    Music(
      name: "Horror Thriller",
      path: "sounds/musics/music2.mp3",
      img: "https://cdn.pixabay.com/audio/2025/05/13/04-04-28-777_200x200.jpg",
      owner: "Catelectrician",
    ),
  ];
}
