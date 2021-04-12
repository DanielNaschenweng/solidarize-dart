import 'dart:async';
import 'dart:io';
import 'package:oauth2/oauth2.dart' as oauth2;
import '../const.dart';
import 'package:path_provider/path_provider.dart';

class AuthHttp {

  static final String hostAuth =
      'http://' + Const.hostServer + ':' + Const.hostPort.toString().trim();
  static final authorizationEndpoint = Uri.parse(hostAuth + '/api/status');
  static final tokenEndpoint = Uri.parse(hostAuth + '/oauth/token');
    static final redirectUrl = Uri.parse(hostAuth + '/api/status');

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _credential async {
    final path = await _localPath;
    return File('$path/credentials.json');
  }

  Future<oauth2.Client> connect() async {

    final identifier = '01093575-79c8-4f46-bf9c-f1d366acde60';
    final secret = 'd67df9f4-8243-4e64-9ada-1edaa668e5b3';

    final username = 'daniel';
    final password = '123';

    final File credentialsFile = await _credential;

    print(credentialsFile);

    var exists = await credentialsFile.exists();

    print('exists:'+exists.toString());

    var client;
    bool credentialExpired = false;

    // If the OAuth2 credentials have already been saved from a previous run, we
    // just want to reload them.
    if (exists) {
      var credentials =
          oauth2.Credentials.fromJson(await credentialsFile.readAsString());

      if (credentials.expiration.isBefore(DateTime.now())) {
        credentialExpired = true;
      } else {
        try {
          client =
              oauth2.Client(
                  credentials, identifier: identifier, secret: secret);
        } on Exception catch (_) {
          client = null;
        }
      }
    }

    if ((!exists) || credentialExpired) {
      //var grant =
      // oauth2.AuthorizationCodeGrant(
      //     identifier, authorizationEndpoint, tokenEndpoint,
      //     secret: secret);

      client = await oauth2.resourceOwnerPasswordGrant(
          tokenEndpoint, username, password,
          identifier: identifier, secret: secret);

      await credentialsFile.writeAsString(client.credentials.toJson());
    }

    // Once you have a Client, you can use it just like any other HTTP client.
    //print(await client.read(redirectUrl));

    return Future.value(client);
  }

  Future<String> getPerson(String login) async {

    oauth2.Client client = await connect();
    String redirectUrl = hostAuth + '/api/person/login/'+login;

    Future<String> futureStr = client.read(Uri.parse(redirectUrl));

    return futureStr.then((value) {
      return value;
    })
      ..onError((error, stackTrace) {
        Future<File> credentialsFile = _credential;
        credentialsFile.then((value){
          value.delete();
        }
        );

        return Future.error(error);
      })
    ..timeout(Duration(minutes: 1));
  }


}
