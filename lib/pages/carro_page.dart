import 'package:carros/model/carro.dart';
import 'package:carros/model/carro_db.dart';
import 'package:carros/model/carro_list.dart';
import 'package:carros/utils/navigation.dart';
import 'package:flutter/material.dart';

import 'carro_form_page.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  const CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  get carro => widget.carro;

  bool _isFavorito = false;

  @override
  void initState() {
    super.initState();

    CarroDB.getInstance().exists(carro).then((b) {
      setState(() {
        _isFavorito = b;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              _onClickPopupMenu(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Editar"),
                  value: "Editar",
                ),
                PopupMenuItem(
                  child: Text("Deletar"),
                  value: "Deletar",
                ),
                PopupMenuItem(
                  child: Text("Compartilhar"),
                  value: "Compartilhar",
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Image.network(carro.urlFoto),
        _bloco1(),
        _bloco2(),
      ],
    );
  }

  _bloco1() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                carro.nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                carro.tipo,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            _onClickFavorito(context, carro);
          },
          child: Icon(
            Icons.favorite,
            color: _isFavorito ? Colors.red : Colors.grey,
            size: 36,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.share,
            size: 36,
          ),
        ),
      ],
    );
  }

  _bloco2() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            carro.desc,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<String>(
            future: CarroList.getLoremIpsim(),
            builder: (context, snapshot) {
              return Center(
                child: snapshot.hasData
                    ? Text(snapshot.data)
                    : CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  _onClickFavorito(BuildContext context, carro) async {
    final db = CarroDB.getInstance();

    if (_isFavorito) {
      int id = carro.id;
      await db.deleteCarro(carro.id);
      print('Carro deletado $id');
    } else {
      int id = await db.saveCarro(carro);
      print('Carro salvo $id');
    }

    setState(() {
      _isFavorito = !_isFavorito;
    });
  }

  _onClickPopupMenu(String value) {
    if (value == "Editar") {
      push(context, CarroFormPage(carro: carro));
    }
  }
}
