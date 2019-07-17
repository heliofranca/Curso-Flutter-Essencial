import 'dart:async';
import 'dart:convert';

import 'package:carros/domain/response.dart';
import 'package:carros/model/carro.dart';
import 'package:http/http.dart' as http;

class CarroList{

  static Future<List<Carro>> getCarros(String tipo) async{

    final url = "http://livrowebservices.com.br/rest/carros$tipo";
    print("> get: $url");

    final response = await http.get(url);

    //print("< : ${response.body}");

    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();

    final carros = mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();

    return carros;
  }

  static Future<Response> salvar(Carro c) async {

    final url = "http://livrowebservices.com.br/rest/carros";
    print("> post: $url");

    final headers = {"Content-Type":"application/json"};
    final body = json.encode(c.toMap());
    print("    > $body");

    final response = await http.post(url, headers: headers, body: body);
    final s = response.body;
    print("    < $s");

    return Response.fromJson(json.decode(s));
  }

  static Future<String> getLoremIpsim() async {
    final url = "https://loripsum.net/api";

    final response = await http.get(url);

    var body = response.body;
    body = body.replaceAll("<p>", "");
    body = body.replaceAll("</p>", "");

    return body;
  }
}