import 'dart:io';
import '../const.dart';

class PersonClient{

  void getPerson(String login){

    HttpClient client = new HttpClient();
    final String url = 'https://'+Const.hostServer+':'+Const.hostPort.toString().trim()+'/api/person/login/'+login;
     client.getUrl(Uri.parse(url))
        ..then((HttpClientRequest request) {
      // Optionally set up headers...
      // Optionally write to the request object...
      // Then call close.

      return request.close();
    })
        .then((HttpClientResponse response) {
      // Process the response.

    });
  }


}
