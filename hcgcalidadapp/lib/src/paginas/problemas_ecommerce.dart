
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/control_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/problema_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';

class CheckEcommercePage extends StatefulWidget {
  int controlId;
  bool primera;
  CheckEcommercePage(this.controlId,this.primera);
  @override
  _CheckEcommercePageState createState() => _CheckEcommercePageState(this.controlId,this.primera);
}

class _CheckEcommercePageState extends State<CheckEcommercePage> {
  List<Widget> listaRecepcion = [];
  List<Widget> listaSurtido = [];
  List<Widget> listaAlistamiento = [];
  List<Widget> listaPreAlistamientoEnCaja = [];
  List<Widget> listaEmpaque = [];
  List<Widget> listaPaletizado = [];
  List<Widget> listaCuartoFrio = [];
  int controlId;
  bool primera;
  _CheckEcommercePageState(this.controlId,this.primera){
    cargarListasEcommerce();
  }
  cargarListasEcommerce() async{
    listaRecepcion = [];
    listaSurtido = [];
    listaCuartoFrio = [];
    listaPaletizado = [];
    listaEmpaque = [];
    listaPreAlistamientoEnCaja = [];
    listaAlistamiento = [];
    if(primera){
      List<ProblemaEcommerce> listaTmp = [];
      listaTmp = await DatabaseEcommerce.getProblemas();
      for(final item in listaTmp){
        await DatabaseEcommerce.addProblemas(controlId, 3, item.id);
      }
    }


    List<ControlEcommerce> listaControles =[];
    listaControles = await DatabaseEcommerce.getAllProblemasXEcommerceId(controlId);
    for(final cont in listaControles){
      if(cont.tipo == 1){
        listaRecepcion.add(itemCheck(cont));
        listaRecepcion.add(Divider());
      }
      else if(cont.tipo == 2){
        listaSurtido.add(itemCheck(cont));
        listaSurtido.add(Divider());
      }
      else if(cont.tipo == 3){
        listaAlistamiento.add(itemCheck(cont));
        listaAlistamiento.add(Divider());
      }
      else if(cont.tipo == 4){
        listaPreAlistamientoEnCaja.add(itemCheck(cont));
        listaPreAlistamientoEnCaja.add(Divider());
      }
      else if(cont.tipo == 5){
        listaEmpaque.add(itemCheck(cont));
        listaEmpaque.add(Divider());
      }
      else if(cont.tipo == 6){
        listaPaletizado.add(itemCheck(cont));
        listaPaletizado.add(Divider());
      }
      else if(cont.tipo == 7){
        listaCuartoFrio.add(itemCheck(cont));
        listaCuartoFrio.add(Divider());
      }

    }
    setState(() {

    });

  }

  cargarEcommerce()async{
    listaRecepcion = [];
    listaSurtido = [];
    listaCuartoFrio = [];
    listaPaletizado = [];
    listaEmpaque = [];
    listaPreAlistamientoEnCaja = [];
    listaAlistamiento = [];
    List<ControlEcommerce> listaControles =[];
    listaControles = await DatabaseEcommerce.getAllProblemasXEcommerceId(controlId);
    for(final cont in listaControles){
      if(cont.tipo == 1){
        listaRecepcion.add(itemCheck(cont));
        listaRecepcion.add(Divider());
      }
      else if(cont.tipo == 2){
        listaSurtido.add(itemCheck(cont));
        listaSurtido.add(Divider());
      }
      else if(cont.tipo == 3){
        listaAlistamiento.add(itemCheck(cont));
        listaAlistamiento.add(Divider());
      }
      else if(cont.tipo == 4){
        listaPreAlistamientoEnCaja.add(itemCheck(cont));
        listaPreAlistamientoEnCaja.add(Divider());
      }
      else if(cont.tipo == 5){
        listaEmpaque.add(itemCheck(cont));
        listaEmpaque.add(Divider());
      }
      else if(cont.tipo == 6){
        listaPaletizado.add(itemCheck(cont));
        listaPaletizado.add(Divider());
      }
      else if(cont.tipo == 7){
        listaCuartoFrio.add(itemCheck(cont));
        listaCuartoFrio.add(Divider());
      }

    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Check list'),
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Guardar',style: TextStyle(
                color: Colors.black
              ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                ControlRamos fin = new ControlRamos();
                fin.ramosAprobado = 1;
                fin.controlRamosId = controlId;
                await DatabaseEcommerce.finEcommerce(fin);
                Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
      body: Container(
        child: _expansionCheck(),
      ),
    );
  }

  _expansionCheck() {
    return ListView(
      children: [
        ExpansionTile(
          title: Text('Recepción',style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          children: listaRecepcion,
          leading: Icon(Icons.receipt,color: Colors.red,),
        ),
        ExpansionTile(
          title: Text('Surtido',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          children: listaSurtido,
          leading: Icon(Icons.track_changes,color: Colors.red,),
        ),
        ExpansionTile(
          title: Text('Alistamiento',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          children: listaAlistamiento,
          leading: Icon(Icons.fact_check,color: Colors.red,),
        ),
        ExpansionTile(
          title: Text('Pre alistamiento en caja',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          children: listaPreAlistamientoEnCaja,
          leading: Icon(Icons.check_box,color: Colors.red,),
        ),
        ExpansionTile(
          title: Text('Empaque',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          children: listaEmpaque,
          leading: Icon(Icons.all_inbox_rounded,color: Colors.red,),
        ),
        ExpansionTile(
          title: Text('Paletizado',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
          ),),
          children: listaPaletizado,
          leading: Icon(Icons.inventory,color: Colors.red,),
        ),
        ExpansionTile(
          title: Text('Cuarto frio',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          children: listaCuartoFrio,
          leading: Icon(Icons.device_thermostat,color: Colors.red,),
        ),
      ],
    );
  }
  itemCheck(ControlEcommerce item){
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.08,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width*0.07,
            alignment: Alignment.center,
            child: Text(
              item.numero.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              textScaleFactor: 1,
            ),
          ),
          Container(
            width: size.width*0.58,
            child: Text(
              item.nombre,
              style: TextStyle(
                fontSize: 15,
              ),
              textScaleFactor: 1,
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            width: size.width*0.35,
            child: RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              labelStyle: TextStyle(
                fontSize: 10
              ),
              labels: [
                "Cumple",
                "No cumple",
                "No aplica"
              ],
              picked: item.cumple?'Cumple':item.noCumple?'No cumple':item.noAplica?"No aplica":"No aplica",
              onSelected: (valor) async{
                int numeroValor = 3;
                if(valor.compareTo('Cumple')==0){
                  numeroValor =1;
                }
                else if(valor.compareTo('No cumple')==0){
                  numeroValor =2;
                }
                else if(valor.compareTo('No aplica')==0){
                  numeroValor =3;
                }

                await DatabaseEcommerce.updateProblemasXEcommerce(item.id, numeroValor);
                await cargarEcommerce();
                setState(() {

                });
              },
            ),
          )

        ],
      ),
    );
  }
}

