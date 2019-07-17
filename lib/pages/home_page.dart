import 'package:carros/model/carro.dart';
import 'package:carros/model/carro_list.dart';
import 'package:carros/utils/navigation.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/carros_page.dart';
import 'package:carros/widgets/favoritos_page.dart';
import 'package:carros/widgets/listview_carros.dart';
import 'package:flutter/material.dart';

import 'carro_form_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    Prefs.getInt("tabIndex").then((idx) {
      tabController.index = idx;
    });

    tabController.addListener(() async {
      int idx = tabController.index;

      print(idx);

      Prefs.setInt("tabIndex", idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(controller: tabController, tabs: [
          //Tab(text: "Todos"),
          Tab(
            text: "Clássicos",
            icon: Icon(Icons.directions_car),
          ),
          Tab(
            text: "Esportivos",
            icon: Icon(Icons.directions_car),
          ),
          Tab(
            text: "Luxo",
            icon: Icon(Icons.directions_car),
          ),
          Tab(
            text: "Favoritos",
            icon: Icon(Icons.favorite),
          ),
        ]),
      ),
      body: TabBarView(controller: tabController, children: [
        //ListViewCarros(TipoCarro.all),
        CarrosPage(TipoCarro.classicos),
        CarrosPage(TipoCarro.esportivos),
        CarrosPage(TipoCarro.luxo),
        FavoritosPage(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          push(context, CarroFormPage());
        },
      ),
    );
  }
}
