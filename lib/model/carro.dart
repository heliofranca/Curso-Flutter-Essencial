class TipoCarro {
  static const String all = "";
  static const String classicos = "/tipo/classicos";
  static const String esportivos = "/tipo/esportivos";
  static const String luxo = "/tipo/luxo";
}

class Carro {
  final int id;
  final String tipo;
  final String nome;
  final String desc;
  final String urlFoto;
  final String urlVideo;
  final String latitude;
  final String longitude;

  Carro(
      {this.id,
      this.tipo,
      this.nome,
      this.desc,
      this.urlFoto,
      this.urlVideo,
      this.latitude,
      this.longitude});

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
      id: json['id'] as int,
      tipo: json['tipo'] as String,
      nome: json['nome'] as String,
      desc: json['desc'] as String,
      urlFoto: json['urlFoto'] as String,
      urlVideo: json['urlVideo'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "nome": nome,
      "tipo": tipo,
      "desc": desc,
      "urlFoto": urlFoto,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Carro[$id]: $nome";
  }
}
