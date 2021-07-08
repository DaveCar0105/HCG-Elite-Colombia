/*
class FalenciaEmpaqueCajaPage extends StatefulWidget {
  @override
  _FalenciaEmpaqueCajaPageState createState() => _FalenciaEmpaqueCajaPageState();
}

class _FalenciaEmpaqueCajaPageState extends State<FalenciaEmpaqueCajaPage> {
  bool iniciado = false;

  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = new List<AutoComplete>();
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;

  List<FalenciaReporteEmpaque> listaFalenciasReporte = List();

  iniciarCarga(int empaqueId) async{
    if(!iniciado){
      List<FalenciaReporteEmpaque> falencias = List();
      falencias = await DatabaseFalenciaReporteEmpaque.getAllFalenciasXEmpaqueId(empaqueId);
      setState(() {
        listaFalenciasReporte = falencias;
      });
      iniciado = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    final Empaque arguments = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    iniciarCarga(arguments.empaqueId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Falencias'),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            textColor: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            elevation: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Siguiente',style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onPressed: () async{
              final empaque = Empaque(
                  empaqueHasta: DateTime.now().millisecondsSinceEpoch,
                  empaqueId: arguments.empaqueId,
                  empaqueAprobado: 1
              );
              await DatabaseEmpaque.finEmpaques(empaque);
              Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: listaFalenciasReporte.length,
            itemBuilder: (context, index)=>_itemFalencia(listaFalenciasReporte[index],size)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          List<FalenciaEmpaque> falenciaEmpaque = List();
          falenciaEmpaque = await DatabaseFalenciaEmpaque.getAllFalenciaEmpaque();
          falenciaEmpaque.forEach((element) {
            listaFalencias.add(AutoComplete(id:element.falenciaEmpaqueId,nombre: element.falenciaEmpaqueNombre));
          });
          setState(() {
            falenciaEnable = true;
          });
          showDialog(context: context,builder: (BuildContext context)=>Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Nueva Falencia',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  falenciaEnable?ListaBusqueda(
                    key: _keyFalencias,
                    lista: listaFalencias,
                    hintText: "Falencias",
                    valorDefecto: falenciaNombre,
                    hintSearchText: "Escriba el nombre de la falencia",
                    icon: Icon(Icons.bug_report),
                    width: 200.0,
                    style: TextStyle(
                        fontSize: 20
                    ),
                    parentAction: (value){
                      AutoComplete falencia = listaFalencias.firstWhere((item){
                        return item.nombre == value;
                      });
                      falenciaId = falencia.id;
                    },
                  ):Container(
                    child: CircularProgressIndicator(),
                  ),
                  Expanded(child: Container()),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: (){
                      agregarFalencia(arguments.empaqueId);
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 150,
                      child: Text('Agregar'),
                    ),
                  )
                ],
              ),
            ),
          ));
        },
        child: Icon(Icons.add_circle_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemFalencia(FalenciaReporteEmpaque falencia,Size size) {

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 5
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width*0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  falencia.falenciaEmpaqueNombre,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
                Text(
                  "Cantidad: ${falencia.falenciasReporteEmpaqueCantidad}",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                Text(
                  "Porcentaje: ${falencia.falenciasReporteEmpaquePorcentaje} %",
                  style: TextStyle(
                      fontSize: 15
                  ),)
              ],
            ),
          ),
          Container(
            height: 80,
            width: size.width*0.4-40,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,

            child: RaisedButton(
              onPressed: (){
                aumentarFalencia(falencia);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.red,
              textColor: Colors.white,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.add)
              ),
            ),
          )
        ],
      ),
    );
  }

  agregarFalencia(int ramosId) async{
    final falenciaReporteEmpaque = FalenciaReporteEmpaque();
    falenciaReporteEmpaque.falenciaEmpaqueId = falenciaId;
    falenciaReporteEmpaque.empaqueId = ramosId;
    falenciaReporteEmpaque.falenciaEmpaqueNombre = falenciaNombre;
    falenciaReporteEmpaque.falenciasReporteEmpaqueCantidad = 1;
    int id = 0;
    try{
      id = listaFalenciasReporte.firstWhere((element) => element.falenciaEmpaqueId==falenciaReporteEmpaque.falenciaEmpaqueId).falenciasReporteEmpaqueId;
    }catch(e){
      id = 0;
    }

    if(id > 0 ){
      return 0;
    }

    await DatabaseFalenciaReporteEmpaque.addFalenciaReporteEmpaque(falenciaReporteEmpaque);

    await cargarLista(ramosId);
  }
  cargarLista(int ramoId) async{
    List<FalenciaReporteEmpaque> falencias = List();
    falencias = await DatabaseFalenciaReporteEmpaque.getAllFalenciasXEmpaqueId(ramoId);
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }

  aumentarFalencia(FalenciaReporteEmpaque falenciaReporteEmpaque)async {

    print(falenciaReporteEmpaque.falenciasReporteEmpaqueCantidad);
    print(falenciaReporteEmpaque.total);
    if(falenciaReporteEmpaque.falenciasReporteEmpaqueCantidad < falenciaReporteEmpaque.total){
      falenciaReporteEmpaque.falenciasReporteEmpaqueCantidad++;
      await DatabaseFalenciaReporteEmpaque.updateCantidadFalenciaReporteEmpaque(falenciaReporteEmpaque);
    }

    cargarLista(falenciaReporteEmpaque.empaqueId);
  }
}
*/