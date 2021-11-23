import 'package:flutter/material.dart';
import 'package:censo_aplicacion/db.dart';
import 'package:censo_aplicacion/censo.dart';

void main() {
  //runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Censos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        body: _MyList(title: 'Lista Censos'),
      ),
    );
  }
}

class _MyList extends StatefulWidget {
  const _MyList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  __MyListState createState() => __MyListState();
}

class __MyListState extends State<_MyList> {
  List<Censo> censos = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: censos.length,
      itemBuilder: (_, i) => _createItem(i),
    );
  }

  _loadData() async {
    List<Censo> auxCenso = await DB.censos();

    setState(() {
      censos = auxCenso;
    });
  }

  _createItem(int i) {
    return ListTile(
      title: Text(censos[i].nombre),
    );
  }
}
