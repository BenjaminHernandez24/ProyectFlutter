import 'package:censo_aplicacion/censo.dart';
import 'package:censo_aplicacion/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

//Programa nuevo, a editar y subir
void main() {
  //var registro = new RegisterPage();
  runApp(const MyApp());
  //runApp(registro);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Censo Vacunas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Censo Vacunas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue[400],
        ),
        backgroundColor: Colors.blue[100], //Color de fondo
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Botones(
                title1: "Registrar Datos",
                icon1: Icons.article_outlined,
                color: Colors.blue,
              ),
              Botones(
                title1: "Visualizar Datos",
                icon1: Icons.assessment,
                color: Colors.blue,
              ),
            ],
          ),
        ));
  }
}

class Botones extends StatelessWidget {
  final String title1;
  final IconData? icon1;
  final MaterialColor? color;
  Botones({this.title1 = "", this.icon1, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          switch (title1) {
            case "Registrar Datos":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
              break;
            case "Visualizar Datos":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
                //MaterialPageRoute(builder: (context) => const Consultar()),
              );
              break;
          }
        }, //acción del "Onclick" del widget Card
        splashColor: Colors.grey[10],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon1, size: 70.0, color: color),
              Text(title1, style: new TextStyle(fontSize: 12.0))
            ],
          ),
        ),
      ),
    );
  }
}

GlobalKey<FormState> keyForm = new GlobalKey();

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//Variables
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController correoCtrl = new TextEditingController();
  TextEditingController numHabCtrl = new TextEditingController();
  TextEditingController numVacCtrl = new TextEditingController();
  TextEditingController direcionCtrl = new TextEditingController();
  TextEditingController postalCtrl = new TextEditingController();

  cargarCensos() async {
    List<Censo> auxCenso = await DB.censos();

    for (var i = 0; i < auxCenso.length; i++) {
      print(auxCenso[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Registrar Datos Vacunas'),
          centerTitle: true,
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(25.0),
            child: new Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  //Todo nuestro formulario
  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nombreCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre completo:',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.email,
            TextFormField(
              controller: correoCtrl,
              decoration: new InputDecoration(
                labelText: 'Correo electrónico:',
              ),
              validator: validateEmail,
            )),
        formItemsDesign(
            Icons.people,
            TextFormField(
              controller: numHabCtrl,
              decoration: new InputDecoration(
                labelText: 'Total de habitantes:',
              ),
              keyboardType: TextInputType.phone,
              validator: validateNumeroVacio,
            )),
        formItemsDesign(
            Icons.coronavirus_sharp,
            TextFormField(
              controller: numVacCtrl,
              decoration: new InputDecoration(
                labelText: 'Personas vacunadas:',
              ),
              keyboardType: TextInputType.phone,
              validator: validateNumeroVacio,
            )),
        formItemsDesign(
            Icons.directions,
            TextFormField(
              controller: direcionCtrl,
              decoration: new InputDecoration(
                labelText: 'Dirección:',
              ),
              validator: validateCadenaVacia,
            )),
        formItemsDesign(
            Icons.markunread_mailbox,
            TextFormField(
              controller: postalCtrl,
              decoration: new InputDecoration(
                labelText: 'Código Postal:',
              ),
              validator: validateNumeroVacio,
            )),
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Colors.green,
              ),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 10, bottom: 13),
            ))
      ],
    );
  }

  String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*[a-zA-Z]$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.length == 0) {
      return "Ingrese un nombre.";
    } else if ((value[value.length - 1] == " ") & (value.trim().length > 1)) {
      return "Sin espacios al final.";
    } else if (!regExp.hasMatch(value)) {
      return "Ingrese un nombre válido.";
    }
  }

  String? validateCadenaVacia(String? value) {
    String patttern = r'(^[a-zA-Z][\w\W]*[a-zA-Z0-9]$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      return "No puede dejar el campo vacío.";
    } else if ((value[value.length - 1] == " ") & (value.trim().length > 1)) {
      return "Sin espacios al final.";
    } else if (!regExp.hasMatch(value)) {
      return "Ingrese datos válidos.";
    }
  }

  String? validateNumeroVacio(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      return "No puede dejar el campo vacío.";
    } else if (!regExp.hasMatch(value)) {
      return "Sólo se aceptan números.";
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r'(^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.length == 0) {
      return "Ingrese un correo electrónico.";
    } else if (!regExp.hasMatch(value)) {
      return "Correo inválido";
    }
  }

  //Funciones y metodos
  save() {
    if (keyForm.currentState!.validate()) {
      String nombre = nombreCtrl.text;
      String correo = correoCtrl.text;
      int habitantes = int.parse(numHabCtrl.text);
      int vacunados = int.parse(numVacCtrl.text);
      String direccion = direcionCtrl.text;
      int cp = int.parse(postalCtrl.text);

      Censo censo = Censo(nombre, correo, habitantes, vacunados, direccion, cp);

      DB.insert(censo);
      cargarCensos();
      print("Nombre: ${nombreCtrl.text}");
      print("Correo: ${correoCtrl.text}");
      print("Numero de habitantes: ${numHabCtrl.text}");
      print("Vacunados: ${numVacCtrl.text}");
      print("Direccion: ${direcionCtrl.text}");
      print("CP: ${postalCtrl.text}");
      keyForm.currentState!.reset();
    }
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
