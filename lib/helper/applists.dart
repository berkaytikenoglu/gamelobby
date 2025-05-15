import 'package:flutter/material.dart';
import 'package:gamelobby/helper/models/api/friendinvitations.dart';
import 'package:gamelobby/helper/models/api/friendship.dart';
import 'package:gamelobby/helper/models/app/game_model.dart';
import 'package:gamelobby/helper/models/app/game_settings.dart';
import 'package:gamelobby/helper/models/app/map_model.dart';
import 'package:gamelobby/helper/models/app/team_model.dart';
import 'package:gamelobby/helper/models/app/weapon_model.dart';
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
      name: "Firuze",
      path: "sounds/musics/melike-sahin-firuze.m4a",
      img:
          "https://cdn.powergroup.com.tr/image/700x700/powerapp/u/Contents/m/e/melike-sahin-1710937027.png",
      owner: "Melike Şahin",
    ),
    Music(
      name: "Aşkın Olayım",
      path: "sounds/musics/simge-askin-olayim.m4a",
      img: "https://www.escturkey.com/wp-content/uploads/2020/07/simge.jpg",
      owner: "Simge",
    ),
    Music(
      name: "Bir Zamanlar Deli Gönlüm",
      path: "sounds/musics/sezen-aksu-bir-zamanlar-deli-gonlum.m4a",
      img: "https://i.scdn.co/image/ab67616100005174921bc8ec2fae6d0b6f8a7834",
      owner: "Sezen Aksu",
    ),
    Music(
      name: "Bangır bangır",
      path: "sounds/musics/gulsen-bangir-bangir.m4a",
      img:
          "https://static.bianet.org/system/uploads/1/articles/spot_image/000/266/783/original/11bb.jpg",
      owner: "Gülşen",
    ),
    Music(
      name: "Seni Sever Miydim",
      path: "sounds/musics/hande-unsal-seni-sever-miydim.m4a",
      img:
          "https://images.genius.com/a19793a04abf81039af22e6edd610bd4.640x640x1.jpg",
      owner: "Hande Ünsal",
    ),
    Music(
      name: "Kanunlar Gibi",
      path: "sounds/musics/derya-ulug-kanunlar-gibi.mp3",
      img:
          "https://image.hurimg.com/i/hurriyet/75/0x0/5ddce6402269a218e4fcf2aa.jpg",
      owner: "Derya Uluğ",
    ),
    Music(
      name: "Nimet",
      path: "sounds/musics/didomido-nimet.mp3",
      img: "https://i.ytimg.com/vi/idqdUopJazc/maxresdefault.jpg",
      owner: "Didomido",
    ),
    Music(
      name: "Tuttu Fırlattı Kalbimi",
      path: "sounds/musics/gokce-tuttu-firlatti.mp3",
      img:
          "https://cdn-images.dzcdn.net/images/artist/0ee1a6e82eb2af906c025fb5ac5e3be7/1900x1900-000000-80-0-0.jpg",
      owner: "Gökçe",
    ),
  ];
  static List<MapModel> mapList = [
    MapModel(
      id: 1,
      name: "ASCENT",
      img:
          "https://static.wikia.nocookie.net/valorant/images/e/e7/Loading_Screen_Ascent.png",
      playerLimit: 10,
      game: Game(
        name: "İKİLİNİN İNTİKAMI",
        settings: GameSettings(),
        teams: [
          Team(
            id: 1,
            name: "TAKIM A",
            color: Colors.red,
            logoUrl: "logoUrl",
            players: [],
          ),
          Team(
            id: 2,
            name: "TAKIM B",
            color: Colors.lightBlue,
            logoUrl: "logoUrl",
            players: [],
          ),
        ],
      ),
    ),
    MapModel(
      id: 2,
      name: "SUNSET",
      img:
          "https://static.wikia.nocookie.net/valorant/images/5/5c/Loading_Screen_Sunset.png/revision/latest?cb=20230829125442",
      playerLimit: 10,
      game: Game(
        name: "İKİLİNİN İNTİKAMI",
        settings: GameSettings(),
        teams: [
          Team(
            id: 1,
            name: "TAKIM A",
            color: Colors.red,
            logoUrl: "logoUrl",
            players: [],
          ),
          Team(
            id: 2,
            name: "TAKIM B",
            color: Colors.lightBlue,
            logoUrl: "logoUrl",
            players: [],
          ),
        ],
      ),
    ),
    MapModel(
      id: 3,
      name: "LOTUS",
      img:
          "https://static.wikia.nocookie.net/valorant/images/d/d0/Loading_Screen_Lotus.png/revision/latest/scale-to-width-down/1000?cb=20230106163526",
      playerLimit: 10,
      game: Game(
        name: "İKİLİNİN İNTİKAMI",
        settings: GameSettings(),
        teams: [
          Team(
            id: 1,
            name: "TAKIM A",
            color: Colors.red,
            logoUrl: "logoUrl",
            players: [],
          ),
          Team(
            id: 2,
            name: "TAKIM B",
            color: Colors.lightBlue,
            logoUrl: "logoUrl",
            players: [],
          ),
        ],
      ),
    ),
    MapModel(
      id: 4,
      name: "PEARL",
      img:
          "https://static.wikia.nocookie.net/valorant/images/a/af/Loading_Screen_Pearl.png/revision/latest/scale-to-width-down/1000?cb=20220622132842",
      playerLimit: 10,
      game: Game(
        name: "İKİLİNİN İNTİKAMI",
        settings: GameSettings(),
        teams: [
          Team(
            id: 1,
            name: "TAKIM A",
            color: Colors.red,
            logoUrl: "logoUrl",
            players: [],
          ),
          Team(
            id: 2,
            name: "TAKIM B",
            color: Colors.lightBlue,
            logoUrl: "logoUrl",
            players: [],
          ),
        ],
      ),
    ),
  ];
  static List<WeaponModel> weaponList = [
    WeaponModel(
      id: 1,
      name: "CLASSIC",
      damage: 10,
      weight: 5,
      type: WeaponType.sidearms,
      imageUrl:
          "https://static.wikia.nocookie.net/valorant/images/5/57/Classic.png/revision/latest?cb=20230711205256",
    ),
    WeaponModel(
      id: 1,
      name: "VANDAL",
      damage: 10,
      weight: 5,
      type: WeaponType.rifles,
      imageUrl:
          "https://static.wikia.nocookie.net/valorant/images/5/56/Vandal.png",
    ),
  ];
}
