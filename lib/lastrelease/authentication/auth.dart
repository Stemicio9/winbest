


import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:win/lastrelease/costanti/coloriestili.dart';

class Auth {

  var token;

  Auth._privateConstructor();

  static final Auth instance = Auth._privateConstructor();


  Future<bool> entra(username, password) async {
    final authorizationEndpoint =
    Uri.parse(baseurl + "oauth/token");
    final identifier = "admin";
    final secret = "ciao";
    var client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint, username, password,
        identifier: identifier, secret: secret);
    if (client.credentials.accessToken != null){
      token = client.credentials.accessToken;
      return true;
    }
    return false;
  }



}