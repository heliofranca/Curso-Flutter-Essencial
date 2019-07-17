import 'package:carros/model/carro.dart';
import 'package:carros/model/carro_list.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/navigation.dart';
import 'package:carros/widgets/listview_carros.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  const CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(12),
      child: FutureBuilder(
        future: CarroList.getCarros(widget.tipo),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Nenhum carro disponível",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListViewCarros(snapshot.data);
          }
        },
      ),
    );
  }
}
