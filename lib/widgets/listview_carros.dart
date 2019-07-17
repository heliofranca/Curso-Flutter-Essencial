import 'package:carros/model/carro.dart';
import 'package:carros/model/carro_list.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/navigation.dart';
import 'package:flutter/material.dart';

class ListViewCarros extends StatelessWidget {

  final List<Carro> carros;

  const ListViewCarros(this.carros);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (ctx, idx) {
        final carro = carros[idx];

        return Container(
          child: InkWell(
            onTap: (){
              _onClickCarro(context, carro);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        carro.urlFoto,
                      ),
                    ),
                    Text(
                      carro.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      carro.desc,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _onClickCarro(context, carro);
                            },
                            child: Text("DETALHES"),
                          ),
                          FlatButton(
                            onPressed: () {
                              print("Share");
                            },
                            child: Icon(Icons.share),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _onClickCarro(BuildContext context, Carro carro) {
    push(context, CarroPage(carro));
  }
}
