import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';



import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;
import 'package:provider_base/core/constants/app_contstants.dart';





class SecureClient {
  SecureClient(this.token);
  String token;
  Future<http.Response> post(String url,Map data,
      {String bodyContentType}) async {
//    if (data == null) throw ('Asset is Required');
    final String _token = token ?? "";
    //encode Map to JSON
    var body = json.encode(data);
    final http.Response response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
        "content-type":"application/json"
      },
      method: HttpMethod.post,
    );

    if (response.headers.containsValue("json"))
      return json.decode(response.body);

    return response;
  }
  Future<http.Response> get(String url, {Map data}) async {
    http.Response response  ;
    if (token == null) throw ('Token is Required');
    final String _token = token ?? "";
    if (data != null){
      response = await getHttpReponse(
        url,
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_token",
          "content-type":"application/json"
        },
        method: HttpMethod.get,
      );
    }
     response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
        "content-type":"application/json"
      },
      method: HttpMethod.get,
    );

    if (response.headers.containsValue("json"))
      return json.decode(response.body);

    return response;
  }


  Future<http.Response> getHttpReponse(
      String url, {
        dynamic body,
        Map<String, String> headers,
        HttpMethod method = HttpMethod.get,
      }) async {
    final inner.IOClient _client = getClient();
    http.Response response;
    try {
      switch (method) {
        case HttpMethod.post:
          response = await _client.post(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.get:
          response = await _client.get(
            url,
            headers: headers,
          );
      }

      print("URL: $url");
      print("Body: $body");
      print("Response Code: " + response.statusCode.toString());
      print("Response Body: " + response.body.toString());

      if (response.statusCode >= 400) {
        // if (response.statusCode == 404) return response.body; // Not Found Message
        if (response.statusCode == 401) {

        } // Not Authorized
        if (devMode) throw ('An error occurred: ' + response.body);
      }
    } catch (e) {
      print('Error with URL: $e');
    }

    return response;
  }

  inner.IOClient getClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);
    inner.IOClient ioClient = new inner.IOClient(httpClient);
    return ioClient;
  }
  ///can be used for file upload to the server
  Future<http.Response> multiPartRequest(String url, String field, dynamic fileName, Map<String, String> data) async{


    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      HttpHeaders.authorizationHeader: "Bearer $token",
      "content-type":"application/json"
    },);
    request.files.add(await http.MultipartFile.fromPath(field, fileName));
    request.fields.addAll(data);

    var _data = await request.send();
    var response = await http.Response.fromStream(_data);


    /*if(response.statusCode != 200){
      return null;
    }*/
    print("URL: $url");
    print("status code from multipath: ${response.statusCode}");
    print("Response from multipath: ${response.body}");
    print("Response from multipath ----: $response");
    return response;


  }
///can be used to upload FIle Array to the server
  Future<http.Response> multiPartRequestArray({String url, dynamic formThreeDocument, dynamic billOfLading, Map<String, String> data}) async{


    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      HttpHeaders.authorizationHeader: "Bearer $token",
      "content-type":"application/json"
    },);
    var fileArray = [await http.MultipartFile.fromPath('Document', billOfLading),await http.MultipartFile.fromPath('Document', formThreeDocument)] ;
    request.files.addAll(fileArray);
    request.fields.addAll(data);



    var _data = await request.send();
    var response = await http.Response.fromStream(_data);


    /*if(response.statusCode != 200){
      return null;
    }*/
    print("URL: $url");
    print("status code from multipath: ${response.statusCode}");
    print("Response from multipath: ${response.body}");
    print("Response from multipath ----: $response");
    return response;


  }

}


enum HttpMethod { get, post, put, delete }
