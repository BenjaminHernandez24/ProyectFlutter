import 'package:flutter/material.dart';
import 'package:censo_aplicacion/db.dart';
import 'package:censo_aplicacion/censo.dart';
import 'package:censo_aplicacion/main.dart';

class verDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        body: SingleChildScrollView(
            child: new Container(child: _MyList(title: 'Lista Censos'))),
        appBar: new AppBar(
          actions: [
            Container(
                child: new Text("Lista Censos", style: TextStyle(fontSize: 20)),
                width: 250.0,
                height: 30.0,
                margin: EdgeInsets.only(top: 16.0, right: 5.0)),
          ],
          title: Container(
            child: __MyListState().atraS1(context),
            width: 50.0,
          ),
        ),
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
    /* return DataTable(
      sortColumnIndex: 2,
      dataRowHeight: 40,
      showBottomBorder: true,
      sortAscending: false,
      columns: [
        DataColumn(label: Text("Nombre")),
        DataColumn(label: Text("Email")),
        DataColumn(label: Text("Habitantes"), numeric: true),
        DataColumn(label: Text("Vacunados"), numeric: true),
        DataColumn(label: Text("Dirección")),
        DataColumn(label: Text("CP")),
      ],
      rows: censos
          .map((censos) => DataRow(cells: [
                DataCell(Text(censos.nombre)),
                DataCell(Text(censos.correo)),
                DataCell(Text(censos.habitantes.toString())),
                DataCell(Text(censos.vacunados.toString())),
                DataCell(Text(censos.direccion)),
                DataCell(Text(censos.cp.toString())),
              ]))
          .toList(),
    );
  */

    List<TableRow> rows = [];

    rows.add(TableRow(children: [
      Text(""),
      Text(""),
      Text(""),
      Text(""),
      Text(""),
      Text(""),
    ]));

    rows.add(TableRow(children: [
      Text("Nombre", textAlign: TextAlign.center),
      Text("Email", textAlign: TextAlign.center),
      Text("Habitantes", textAlign: TextAlign.center),
      Text("Vacunados", textAlign: TextAlign.center),
      Text("Dirección", textAlign: TextAlign.center),
      Text("CP", textAlign: TextAlign.center),
    ]));

    rows.add(TableRow(children: [
      Text(""),
      Text(""),
      Text(""),
      Text(""),
      Text(""),
      Text(""),
    ]));

    rows.add(TableRow(children: [
      Text("---------------"),
      Text("---------------"),
      Text("---------------"),
      Text("---------------"),
      Text("---------------"),
      Text("---------------"),
    ]));

    for (int i = 0; i < censos.length; i++) {
      rows.add(TableRow(children: [
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('${censos[i].nombre}', textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('${censos[i].correo}', textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.all(5.0),
            child:
                Text('${censos[i].habitantes}', textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('${censos[i].vacunados}', textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('${censos[i].direccion}', textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('${censos[i].cp}', textAlign: TextAlign.center)),
      ]));

      rows.add(TableRow(children: [
        Text("---------------"),
        Text("---------------"),
        Text("---------------"),
        Text("---------------"),
        Text("---------------"),
        Text("---------------"),
      ]));
    }
    return Table(children: rows);
  }

  _loadData() async {
    List<Censo> auxCenso = await DB.censos();

    setState(() {
      censos = auxCenso;
    });
  }

  //Boton atras dek formulario
  Widget atraS1(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          color: Colors.blue,
        ),
      ],
    );
  }
}
