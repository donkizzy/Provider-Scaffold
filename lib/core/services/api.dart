import 'dart:convert';

import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://sbsc.com';
  
  var client = new http.Client();

}
