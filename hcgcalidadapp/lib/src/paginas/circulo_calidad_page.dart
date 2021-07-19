import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/basedatos/database_circulo_calidad.dart';

import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/paginas/lista_ramos_page.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class circuloCalidadPage extends StatefulWidget {
  bool valor;
  int ramosId;
  //var supervisor1Check = ['Regular','Bueno','Excelente'];
  
  circuloCalidadPage() {
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _circuloCalidadPageState createState() => _circuloCalidadPageState();
}

class _circuloCalidadPageState extends State<circuloCalidadPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var supervisor1Check = ['Regular','Bueno','Excelente'];
  var supervisor2Check = ['Regular','Bueno','Excelente'];
  Map<String, bool>supervisorListValues ={};
  Map<String, bool>supervisorListValues2 ={};
  //final totalRamos = TextEditingController();
  //final tallosRamos = TextEditingController();
  final ramosRechazados = TextEditingController();
  final ramosRevisados = TextEditingController();
  final derogacion = TextEditingController();
  final numeroReunionCirculoCalidad = TextEditingController();
  final codigoMesa = TextEditingController();
  final linea = TextEditingController();
  final supervisor1 = TextEditingController();
  final supervisor2 = TextEditingController();
  final comentarios = TextEditingController();
  final ordenModal = TextEditingController();
  circuloCalidad circulo = new circuloCalidad();
  String numeroOrden = '';

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = new List<AutoComplete>();
  String productoNombre = "";
  int productoId = 0;
  bool prodEnable = false;

  GlobalKey<ListaBusquedaState> _keyProducto2 = GlobalKey();
  static List<AutoComplete> listaProducto2 = new List<AutoComplete>();
  String productoNombre2 = "";
  int productoId2 = 0;
  bool prodEnable2 = false;

  GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  static List<AutoComplete> listaCliente = new List<AutoComplete>();
  String clienteNombre = "";
  int clienteId = 0;
  bool clientEnable = false;

  GlobalKey<ListaBusquedaState> _keyCliente2 = GlobalKey();
  static List<AutoComplete> listaCliente2 = new List<AutoComplete>();
  String clienteNombre2 = "";
  int clienteId2 = 0;
  bool clientEnable2 = false;

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;
  //PROBLEMAS
  GlobalKey<ListaBusquedaState> _keyProblema1 = GlobalKey();
  static List<AutoComplete> listaProblema1 = new List<AutoComplete>();
  String problema1Nombre = "";
  int problema1Id = 0;
  bool problema1Enable = false;

    GlobalKey<ListaBusquedaState> _keyProblema2 = GlobalKey();
  static List<AutoComplete> listaProblema2 = new List<AutoComplete>();
  String problema2Nombre = "";
  int problema2Id = 0;
  bool problema2Enable = false;
    GlobalKey<ListaBusquedaState> _keyProblema3 = GlobalKey();
  static List<AutoComplete> listaProblema3 = new List<AutoComplete>();
  String problema3Nombre = "";
  int problema3Id = 0;
  bool problema3Enable = false;
    GlobalKey<ListaBusquedaState> _keyProblema4 = GlobalKey();
  static List<AutoComplete> listaProblema4 = new List<AutoComplete>();
  String problema4Nombre = "";
  int problema4Id = 0;
  bool problema4Enable = false;
    GlobalKey<ListaBusquedaState> _keyProblema5 = GlobalKey();
  static List<AutoComplete> listaProblema5 = new List<AutoComplete>();
  String problema5Nombre = "";
  int problema5Id = 0;
  bool problema5Enable = false;

  /*GlobalKey<ListaBusquedaState> _keyTipoCliente = GlobalKey();
  static List<AutoComplete> listaTipoCliente = new List<AutoComplete>();
  String clienteTipo = "";
  int clienteTipoID = 0;
  bool clienteTipoEnable = false;*/

  bool elite = false;
  bool problemas = false;
  _circuloCalidadPageState() {
    print("ingreso al circulad de calidad");
    elite = true;
    cargarRamos(1);
  }

  _guardarReporteCirculoCalidad() async {
    
    //ramos.ramosNumeroOrden = numeroOrden;
    circulo.clienteId2 = int.parse(ramosRevisados.text);
    circulo.clienteId1 = int.parse(ramosRechazados.text);
    //circulo.productoId1= int.parse(source)
    circulo.ramosRevisados = int.parse(ramosRevisados.text);
    circulo.calidadReunion = 0;
    circulo.problemaId2 = clienteId;
    circulo.problemaId3 = productoId;
    
    //ramos.ramosTallos = int.parse(tallosRamos.text);
    circulo.ramosRechazados =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    circulo.productoId1 = derogacion.text;
    circulo.postcosechaId = postcosechaId;
    //ramos.ramosMarca = marca.text;
    circulo.problemaId4 = 0;
    if (circulo.circuloCalidadId != null) {
      await DatabaseCirculoCalidad.updateCirculoCalidad(circulo);
    } else {
      circulo.productoId2 = DateTime.now().millisecondsSinceEpoch;
      //circulo.circuloCalidadId await DatabaseCirculoCalidad.addcirculoCalidad(circulo);
    }
  }

  // _showSnackBar() {
  //   final snackBar = SnackBar(
  //     content: Text(
  //         'Número de orden debe ser escaneado \nTodos los números deben ser enteros'),
  //     action: SnackBarAction(
  //       label: 'Ok',
  //       onPressed: () {},
  //     ),
  //   );
  //   scaffoldKey.currentState.showSnackBar(snackBar);
  // }

  // cargarProblemas(int problemasId) async{
  //   listaProblema1 = List<AutoComplete>(); 
  //   listaProblema2 = List<AutoComplete>(); 
  //   listaProblema3 = List<AutoComplete>(); 
  //   listaProblema4 = List<AutoComplete>(); 
  //   listaProblema5 = List<AutoComplete>();  


  //   int problema = 0;
  //   if (problemas) {
  //     problema = 1;
  //   }



  //   List<FalenciaRamos> problema1 = List();
  //   problema1 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
  //   problema1.forEach((element) {
  //     listaProblema1.add(
  //         AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
  //   });
  //    List<FalenciaRamos> problema2 = List();
  //   problema2 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
  //   problema2.forEach((element) {
  //     listaProblema2.add(
  //         AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
  //   });
  //   List<FalenciaRamos> problema3 = List();
  //   problema3 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
  //   problema3.forEach((element) {
  //     listaProblema3.add(
  //         AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
  //   });
  //   List<FalenciaRamos> problema4 = List();
  //   problema4 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
  //   problema4.forEach((element) {
  //     listaProblema4.add(
  //         AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
  //   });
  //   List<FalenciaRamos> problema5 = List();
  //   problema5 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
  //   problema5.forEach((element) {
  //     listaProblema5.add(
  //         AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
  //   });


  //   setState(() {
  //     print("ingreso ");
  //     problema1Enable = true;
  //     problema2Enable =true;
  //     problema3Enable =true;
  //     problema4Enable =true;
  //     problema5Enable =true;

  //   });
  // }

  cargarRamos(int ramosId) async {
    print("ingreso a cargar la informacion");
    listaProducto = List<AutoComplete>();
    listaProducto2 = List<AutoComplete>();
    listaCliente = List<AutoComplete>();
    listaPostcosecha = List<AutoComplete>();
    listaCliente2 = List<AutoComplete>();
    listaProblema1 = List<AutoComplete>(); 
    listaProblema2 = List<AutoComplete>(); 
    listaProblema3 = List<AutoComplete>(); 
    listaProblema4 = List<AutoComplete>(); 
    listaProblema5 = List<AutoComplete>();
    

    int valor = 0;
    if (elite) {
      valor = 1;
    }
    //PROBLEMAS 
    List<FalenciaRamos> problema1 = List();
    problema1 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    problema1.forEach((element) {
      listaProblema1.add(
          AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
    });
     List<FalenciaRamos> problema2 = List();
    problema2 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    problema2.forEach((element) {
      listaProblema2.add(
          AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
    });
    List<FalenciaRamos> problema3 = List();
    problema3 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    problema3.forEach((element) {
      listaProblema3.add(
          AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
    });
    List<FalenciaRamos> problema4 = List();
    problema4 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    problema4.forEach((element) {
      listaProblema4.add(
          AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
    });
    List<FalenciaRamos> problema5 = List();
    problema5 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    problema5.forEach((element) {
      listaProblema5.add(
          AutoComplete(id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
    });



    ///
    print("va a cargar");
    List<Producto> productos = List<Producto>();
    productos = await DatabaseProducto.getAllProductos(valor);
    print("cantidad de productos: " + productos.length.toString());
    productos.forEach((element) {
      listaProducto.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
    });

    List<Producto> productos2 = List<Producto>();
    productos2 = await DatabaseProducto.getAllProductos(valor);
    print("cantidad de productos: " + productos2.length.toString());
    productos2.forEach((element) {
      listaProducto2.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
    });

    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(valor);
    clientes.forEach((element) {
      listaCliente.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    List<Cliente> clientes2 = List();
    clientes2 = await DatabaseCliente.getAllCliente(valor);
    clientes2.forEach((element) {
      listaCliente2.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    ////////////PROBLEMAS 
      
    //////

    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });
    print("postcosecha cargada: " + listaPostcosecha.length.toString());

    setState(() {
      print("ingreso ");
      prodEnable = true;
      prodEnable2=true;
      clientEnable = true;
      clientEnable2 = true;
      postcosechaEnable = true;
      problema1Enable = true;
      problema2Enable = true;
      problema3Enable = true;
      problema4Enable = true;
      problema5Enable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('CIRCULO DE CALIDAD'),
      ),
      body: Container(
          width: double.infinity,
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // _tipoCliente(),
                    // _numeroOrden(),
                    _postcosecha(),
                    _cantidadRamosRevisados(),
                    _cantidadRamosRechazados(),
                    _numeroDeReunionCirculoCalidad(),
                    _problema1(),
                    _problema2(),
                    _problema3(),
                    _problema4(),
                    _problema5(),
                    _cliente1(),
                    _cliente2(),
                    _producto1(),
                    _producto2(),
                    
                    //problema2

                    //_cantidadRamos(), //ramos revisados
                    //_cantidadTallos(),
                    _codigoMesa(),
                    _linea(),
                    _supervisor1(),
                    //_superVisor1Check(),
                    _supervisor2(),
                    // _derogacion(),
                    
                    Divider(),
                    Column(children:[Text('Evaluacion supervisor#1',style: Theme.of(context).textTheme.subtitle1)] ),
                    Column(children: _superVisor1Check()),
                    Divider(),
                    Column(children:[Text('Evaluacion supervisor#2',style: Theme.of(context).textTheme.subtitle1)] ),
                    Column(children:_superVisor2Check()),
                    _comentarios(),
                    _botonGuardar(context),

                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              
                Column(
                   //_botonGuardar(context),
                )
              ],
            ),
          )),
    );
  }

  /* Widget _tipoCliente() {
    return Container(
      width: 250,
      height: 90,
      child: clientEnable
          ? ListaBusqueda(
              key: _keyCliente,
              lista: listaTipoCliente,
              hintText: "Cliente",
              valorDefecto: clienteTipo,
              hintSearchText: "Seleccione el tipo del cliente",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete clienteTipo = listaCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId = clienteTipo.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }*/

  /*Widget _numeroOrden() {
    return Container(
      height: 100,
      width: 200,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: numeroOrden == ''
                ? RaisedButton(
                    onPressed: () {
                      _bottomSheetOrden(context);
                    },
                    color: Colors.red,
                    child: Text('Ingresar Orden'),
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                  )
                : Container(
                    child: Text(
                      numeroOrden == null ? "" : numeroOrden,
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          numeroOrden == ''
              ? SizedBox()
              : RaisedButton(
                  shape: CircleBorder(),
                  color: Colors.red,
                  child: Icon(
                    Icons.create,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _bottomSheetOrden(context);
                  })
        ],
      ),
    );
  }*/

  // Widget _cantidadRamos() {
  //   return Container(
  //     width: 200,
  //     height: 90,
  //     child: TextField(
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //           hintText: 'Ramos revisados', labelText: 'Ramos Revisados'),
  //       controller: totalRamos,
  //     ),
  //   );
  // }

  // Widget _cantidadTallos() {
  //   return Container(
  //     width: 200,
  //     height: 90,
  //     child: TextField(
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //           hintText: 'Tallos por ramo', labelText: 'Tallos por ramo'),
  //       controller: tallosRamos,
  //     ),
  //   );
  // }


  Widget _cantidadRamosRechazados() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos Rechazados',
          labelText: 'Ramos Rechazados',
        ),
        controller: ramosRechazados,
      ),
    );
  }

  Widget _cantidadRamosRevisados() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos Revisados',
          labelText: 'Ramos Revisados',
        ),
        controller: ramosRevisados,
      ),
    );
  }

  // Widget _derogacion() {
  //   return Container(
  //     width: 200,
  //     height: 90,
  //     child: TextField(
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         hintText: 'Derogacion',
  //         labelText: 'Derogacion',
  //       ),
  //       controller: derogacion,
  //     ),
  //   );
  // }

  _botonGuardar(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          //if (_validarRamos() ) {
            //&&_validarTallos
            final util = Utilidades();
            if (//numeroOrden != '' &&
                //util.isNumberEntero(totalRamos.text) &&
                //util.isNumberEntero(tallosRamos.text) &&
                //derogacion.text != '' &&
                util.isNumberEntero(ramosRechazados.text) &&
                util.isNumberEntero(ramosRevisados.text) &&
                clienteId != 0 &&
                clienteId2 != 0 &&
                productoId != 0 &&
                productoId2 != 0 &&
                problema1Id!=0&&
                problema2Id!=0&&
                problema3Id!=0&&
                problema4Id!=0&&
                problema5Id!=0&&
                numeroReunionCirculoCalidad.text != '' &&
                codigoMesa.text != '' &&
                linea.text != '' &&
                supervisor1.text != '' &&
                supervisor2.text != '' &&
                comentarios.text != '' &&
                postcosechaId != 0) {
              await _guardarReporteCirculoCalidad()();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => circuloCalidadPage()));
            
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.red,
        textColor: Colors.white,
        child: Container(
          height: 60,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Guardar'),
              Icon(Icons.save)
            ],
          ),
        ),
      ),
    );
  }


  Widget _problema1(){
    return Container(
      width: 250,
      height: 90,
      child: problema1Enable
          ? ListaBusqueda(
              key: _keyProblema1,
              lista: listaProblema1,
              hintText: "Problema1",
              valorDefecto: problema1Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema1 = listaProblema1.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = problema1.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }
  Widget _problema2(){
    return Container(
      width: 250,
      height: 90,
      child: problema2Enable
          ? ListaBusqueda(
              key: _keyProblema2,
              lista: listaProblema2,
              hintText: "Problema2",
              valorDefecto: problema2Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema2 = listaProblema2.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = problema2.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }
  Widget _problema3(){
    return Container(
      width: 250,
      height: 90,
      child: problema3Enable
          ? ListaBusqueda(
              key: _keyProblema3,
              lista: listaProblema3,
              hintText: "Problema3",
              valorDefecto: problema3Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema3 = listaProblema3.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = problema3.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }
  Widget _problema4(){
    return Container(
      width: 250,
      height: 90,
      child: problema4Enable
          ? ListaBusqueda(
              key: _keyProblema4,
              lista: listaProblema4,
              hintText: "Problema4",
              valorDefecto: problema4Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema4 = listaProblema4.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = problema4.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }
  Widget _problema5(){
    return Container(
      width: 250,
      height: 90,
      child: problema5Enable
          ? ListaBusqueda(
              key: _keyProblema5,
              lista: listaProblema5,
              hintText: "Problema5",
              valorDefecto: problema5Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema5 = listaProblema5.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = problema5.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }


  Widget _producto1() {
    return Container(
      width: 250,
      height: 90,
      child: prodEnable
          ? ListaBusqueda(
              key: _keyProducto,
              lista: listaProducto,
              hintText: "Producto1",
              valorDefecto: productoNombre,
              hintSearchText: "Selecione el nombre del producto",
              icon: Icon(Icons.local_florist),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete producto = listaProducto.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = producto.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _producto2() {
    return Container(
      width: 250,
      height: 90,
      child: prodEnable
          ? ListaBusqueda(
              key: _keyProducto2,
              lista: listaProducto2,
              hintText: "Producto2",
              valorDefecto: productoNombre2,
              hintSearchText: "Selecione el nombre del producto",
              icon: Icon(Icons.local_florist),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete producto2 = listaProducto.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = producto2.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _cliente1() {
    return Container(
      width: 250,
      height: 90,
      child: clientEnable
          ? ListaBusqueda(
              key: _keyCliente,
              lista: listaCliente,
              hintText: "Cliente1",
              valorDefecto: clienteNombre,
              hintSearchText: "Seleccione el nombre del cliente1",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete cliente = listaCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId = cliente.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _cliente2() {
    return Container(
      width: 250,
      height: 90,
      child: clientEnable2
          ? ListaBusqueda(
              key: _keyCliente2,
              lista: listaCliente2,
              hintText: "Cliente2",
              valorDefecto: clienteNombre2,
              hintSearchText: "Seleccione el nombre del cliente2",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete cliente2 = listaCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId = cliente2.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _postcosecha() {
    print("postcosecha: " + postcosechaEnable.toString());
    return Container(
      width: 250,
      height: 90,
      child: postcosechaEnable
          ? ListaBusqueda(
              key: _keyPostcosecha,
              lista: listaPostcosecha,
              hintText: "Post Cosecha",
              valorDefecto: postcosechaNombre,
              hintSearchText: "Escriba el nombre de Postcosecha",
              icon: Icon(Icons.move_to_inbox),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete postcosecha = listaPostcosecha.firstWhere((item) {
                  return item.nombre == value;
                });
                postcosechaId = postcosecha.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _numeroDeReunionCirculoCalidad() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Numero de reunion',
          labelText: 'Numero de reunion',
        ),
        controller: numeroReunionCirculoCalidad,
      ),
    );
  }

  Widget _codigoMesa() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Codigo de Mesa',
          labelText: 'Codigo de mesa',
        ),
        controller: codigoMesa,
      ),
    );
  }

  Widget _linea() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Linea',
          labelText: 'Linea',
        ),
        controller: linea,
      ),
    );
  }

  Widget _supervisor1() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Supervisor1',
          labelText: 'Supervisor1',
        ),
        controller: supervisor1,
      ),
    );
  }

  Widget _supervisor2() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Supervisor2',
          labelText: 'Supervispor2',
        ),
        controller: supervisor2,
      ),
    );
  }

  Widget _comentarios() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Comentarios',
          labelText: 'Comentarios',
        ),
        controller: comentarios,
      ),
    );
  }

  bool  _validarRamos() {
    if (ramosRechazados.text == '' ||
        ramosRevisados.text == '' 
        ) {  //totalRamos.text == ''
      mostrarSnackbar('Llenar Ramos', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosRechazados.text) < int.parse(ramosRevisados.text)) {
      mostrarSnackbar('Error en Ramos Elaborados', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosRevisados.text) < int.parse(ramosRevisados.text)) {
      mostrarSnackbar('Error en Ramos a revisar', null, scaffoldKey);
      return false;
    }

    return true;
  }

  List <Widget>_superVisor2Check(){

    return (
      
      supervisor2Check.map((label) => CheckboxListTile(title: Text(label),value: supervisorListValues2[label]??false, onChanged: (newValue){
        setState(() {
          if(supervisorListValues2[label] == null){
            supervisorListValues2[label]=true;
          }
          else{
            //supervisor1Check[label]==false;
          }
          supervisorListValues2[label] = !supervisorListValues2[label];
        });
      })).toList());
    
  }

  List <Widget>_superVisor1Check(){

    return (
      
      supervisor1Check.map((label) => CheckboxListTile(title: Text(label),value: supervisorListValues[label]??false, onChanged: (newValue){
        setState(() {
          if(supervisorListValues[label] == null){
            supervisorListValues[label]=true;
          }
          else{
            //supervisor1Check[label]==false;
          }
          supervisorListValues[label] = !supervisorListValues[label];
        });
      })).toList());
    
  }

  // bool _validarTallos() {
  //   if (tallosRamos.text == '') {
  //     mostrarSnackbar('Llenar los tallos por ramo', null, scaffoldKey);
  //     return false;
  //   }
  //   return true;
  // }

  // _bottomSheetOrden(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           child: Wrap(
  //             children: <Widget>[
  //               ListTile(
  //                 leading: Icon(
  //                   Icons.camera_alt,
  //                   color: Colors.red,
  //                 ),
  //                 title: Text('Codigo QR'),
  //                 onTap: () async {
  //                   Navigator.maybePop(context);
  //                   try {
  //                     numeroOrden = await scanner.scan();
  //                   } catch (e) {
  //                     numeroOrden = "";
  //                   }

  //                   setState(() {});
  //                 },
  //               ),
  //               ListTile(
  //                 leading: Icon(
  //                   Icons.font_download,
  //                   color: Colors.red,
  //                 ),
  //                 title: Text('Ingresar Orden'),
  //                 onTap: () async {
  //                   await showDialog(
  //                       context: context,
  //                       builder: (_) => new AlertDialog(
  //                             title: Text("Ingresa el número de orden"),
  //                             content: TextField(
  //                               controller: ordenModal,
  //                               decoration:
  //                                   InputDecoration(hintText: '# de Orden'),
  //                             ),
  //                             actions: <Widget>[
  //                               FlatButton(
  //                                 child: Text('Guardar'),
  //                                 onPressed: () {
  //                                   numeroOrden = ordenModal.text;
  //                                   setState(() {});
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                               FlatButton(
  //                                 child: Text('Cancelar'),
  //                                 onPressed: () {
  //                                   Navigator.pop(context);
  //                                 },
  //                               )
  //                             ],
  //                           ));
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
