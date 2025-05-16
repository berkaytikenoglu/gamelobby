import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/models/api/contents.dart';
import 'package:gamelobby/helper/models/api/friendinvitations.dart';
import 'package:gamelobby/helper/models/api/friendsearch.dart';
import 'package:gamelobby/helper/models/api/friendship.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_information.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_invitation_list.dart';
import 'package:gamelobby/helper/models/api/login.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum RequestType { GET, POST, PUT, DELETE }

enum NewsUpdateEventCategory {
  event,
  update,
  news,
}

class APIService extends GetConnect {
  static final APIService instance = APIService._internal();
  APIService._internal();
  final String baseUrls = 'http://185.93.68.107/Api/'; // HOST buraya tanımlandı
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  String? getToken() {
    return _token;
  }

  Future<Response?> apiRequest({
    required String endpoint,
    required RequestType type,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    bool showLogs = false,
  }) async {
    final headers = {
      'Authorization': _token != null ? 'Bearer $_token' : '',
      'Content-Type': 'application/json',
      'Language-Id': 'tr',
    };

    final String url = '$baseUrls$endpoint'; // URL otomatik oluşturuluyor

    if (showLogs) {
      log("GAMEINFO_URL -> $url");
      // log("GAMEINFO_HEADERS -> $headers");
    }
    try {
      Response response;
      switch (type) {
        case RequestType.GET:
          response = await get(url, query: queryParams, headers: headers);

        case RequestType.POST:
          response = await post(url, data, headers: headers);
        case RequestType.PUT:
          response = await put(url, data, headers: headers);
        case RequestType.DELETE:
          response = await delete(url, headers: headers);
      }

      //Sunucudan Olumsuz Mesaj Döndür

      if (showLogs) {
        log("GAMEINFO -> ${response.isOk} (${response.statusCode.toString()})");
        log("GAMEINFO RESPONSE -> ${response.body.toString()}");
      }

      if (!response.isOk) {
        try {
          Get.snackbar(
            "Bilgi",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            icon: Icon(
              Icons.warning_rounded,
              color: Colors.amber,
            ),
            response.body['Message'].toString(),
          );
        } catch (e) {
          log("SNACKBAR HATASI 1____$e");
        }

        return null;
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        //İnternet Bağlantı Sorunu
        print('API Error: $e');
        Get.snackbar(
          "Bilgi",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          icon: Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
          "İnternet Bağlantısı Sorunu",
        );
      }
      return null;
    }
  }

  Future<APILogin?> login({
    required String username,
    required String password,
  }) async {
    Response<dynamic>? response = await apiRequest(
      endpoint: "users/login",
      type: RequestType.POST,
      data: {
        "username": username,
        "password": password,
      },
    );

    if (response == null) {
      return null;
    }

    APILogin? gameResponse;
    if (response.body != null && response.isOk) {
      try {
        gameResponse = APILogin(
          accessToken: response.body['accessToken'],
          userId: response.body['userId'],
          expiresIn: response.body['expiresIn'],
          refreshToken: response.body['refreshToken'],
        );

        setToken(response.body['accessToken']);
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  Future<List<APIFriendship>?> friendships() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Friendships",
      type: RequestType.GET,
      data: {},
    );

    if (response == null) {
      return null;
    }

    List<APIFriendship> gameResponse = [];
    if (response.body != null && response.isOk) {
      try {
        for (var element in response.body) {
          gameResponse.add(
            APIFriendship(
              id: element['id'],
              username: element['username'],
              avatarId: element['avatarId'],
              isOnline: element['isOnline'],
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  Future<bool> addfriend({required String username}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Friendships",
      type: RequestType.POST,
      data: {"username": username},
    );

    if (response == null) {
      return false;
    }

    return true;
  }

  Future<bool> friendInviteResponse({
    required int invitationId,
    required bool acceptState,
  }) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Friendships",
      type: RequestType.PUT,
      data: {
        "invitationId": invitationId,
        "acceptState": acceptState,
      },
    );

    if (response == null) {
      return false;
    }

    if (!response.isOk) {
      return false;
    }

    return true;
  }

  Future<bool> deletefriend({required int userId}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Friendships?UserId=$userId",
      type: RequestType.DELETE,
    );

    if (response == null) {
      return false;
    }

    return true;
  }

  Future<List<APIFriendinvitations>?> friendInvitations() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Friendships/Invitations",
      type: RequestType.GET,
      data: {},
    );

    if (response == null) {
      return null;
    }

    List<APIFriendinvitations> gameResponse = [];
    if (response.body != null && response.isOk) {
      try {
        for (var element in response.body) {
          gameResponse.add(
            APIFriendinvitations(
              id: element['id'],
              invitor: APIFriendship(
                id: element['invitor']['id'],
                username: element['invitor']['username'],
                avatarId: element['invitor']['avatarId'],
                isOnline: element['invitor']['isOnline'],
              ),
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  ////////FriendsShip///////////////

  Future<List<APIFriendsearch>?> userSearch({required String username}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Users/Search",
      type: RequestType.GET,
      data: {"username": username},
    );

    if (response == null) {
      return null;
    }

    List<APIFriendsearch> gameResponse = [];
    if (response.body != null && response.isOk) {
      try {
        for (var element in response.body) {
          gameResponse.add(
            APIFriendsearch(
              id: element['invitor']['id'],
              username: element['invitor']['username'],
              avatarId: element['invitor']['avatarId'],
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  ////////////////////HAERLER GÜNCELLEMELER ETKİNLİKLER////////////////////////
  ///

  Future<List<APIContents>?> newsupdateseventsFetch(
      NewsUpdateEventCategory $category) async {
    log($category.name[0].toUpperCase() +
        $category.name.substring(1).toLowerCase());
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Contents/Search",
      type: RequestType.GET,
      queryParams: {
        "Type": $category.name[0].toUpperCase() +
            $category.name.substring(1).toLowerCase()
      },
    );

    if (response == null) {
      return null;
    }

    List<APIContents> contentsResponse = [];
    if (response.body != null && response.isOk) {
      try {
        for (var element in response.body['data']) {
          contentsResponse.add(
            APIContents(
              id: element['id'],
              title: element['title'],
              createdDate: element['createdDate'],
              youtubeUrl: element['youtubeUrl'],
              bannerId: element['bannerId'],
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return contentsResponse;
  }

  /////////////////Matches /////////////////
  Future<bool> matchStartSearch() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Matches/Search/Start",
      type: RequestType.POST,
      data: {},
    );

    if (response == null) {
      return false;
    }

    return true;
  }

  Future<bool> matchStopSearch() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Matches/Search/Stop",
      type: RequestType.PUT,
      data: {},
    );

    if (response == null) {
      return false;
    }

    return true;
  }

  Future<bool> matchSearchRespond(
      {required String matchedSearchId, required bool accepted}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Matches/Search/Respond",
      type: RequestType.PUT,
      data: {
        "matchedSearchId": matchedSearchId,
        "accepted": accepted,
      },
    );

    if (response == null) {
      return false;
    }

    return true;
  }

  Future<LobbyInformation?> lobbyInformation() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Lobbies/Information",
      type: RequestType.GET,
      data: {},
    );

    if (response == null) {
      return null;
    }

    LobbyInformation? gameResponse;
    if (response.body != null && response.isOk) {
      try {
        gameResponse = LobbyInformation.fromJson(response.body);
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  Future<bool> lobbyinviteplayer({required int userID}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Lobbies/Invite",
      type: RequestType.POST,
      data: {"userId": userID},
    );

    if (response == null) {
      return false;
    }

    return true;
  }

  Future<LobbyInformation?> lobbyinviteResponse(
      {required int invitationID, required bool answer}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Lobbies/Invite",
      type: RequestType.PUT,
      data: {"inviteToLobbyId": invitationID, "acceptState": answer},
    );

    if (response == null) {
      return null;
    }

    LobbyInformation? gameResponse;
    if (response.body != null && response.isOk) {
      try {
        gameResponse = LobbyInformation.fromJson(response.body);
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  Future<List<LobbyinvatitionInformation>?> lobbyinvitationList() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Lobbies/Invitations",
      type: RequestType.GET,
      data: {},
    );

    if (response == null) {
      return null;
    }

    List<LobbyinvatitionInformation> gameResponse = [];
    if (response.body != null && response.isOk) {
      try {
        for (var element in response.body) {
          gameResponse.add(LobbyinvatitionInformation.fromJson(element));
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  Future<LobbyInformation?> lobbyquit() async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Lobbies/Quit",
      type: RequestType.POST,
      data: {},
    );

    if (response == null) {
      return null;
    }

    LobbyInformation? gameResponse;
    if (response.body != null && response.isOk) {
      try {
        gameResponse = LobbyInformation.fromJson(response.body);
      } catch (e) {
        log(e.toString());
      }
    }

    return gameResponse;
  }

  Future<bool> lobbykick({required int userID}) async {
    Response<dynamic>? response = await apiRequest(
      showLogs: true,
      endpoint: "Lobbies/Kick",
      type: RequestType.POST,
      data: {"userId": userID},
    );

    if (response == null) {
      return false;
    }

    return true;
  }
}
