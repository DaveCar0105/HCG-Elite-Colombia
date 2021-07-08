
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecommerce.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/paginas/problemas_ecommerce.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

class EcommercePage extends StatefulWidget {
  @override
  _EcommercePageState createState() => _EcommercePageState();
}

class _EcommercePageState extends State<EcommercePage> {
  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = [];
  String postcosechaNombre = "";
  int postcosechaId=0;
  bool postcosechaEnable = false;
  int turno = 1;
  String valorTurno = 'Dia';
  int controlId =0;
  cargarRamos() async{
    listaPostcosecha = [];
    int valor = 1;
    List<PostCosecha> postcosechas = [];
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(id:element.postCosechaId,nombre: element.postCosechaNombre));
    });

    setState(() {
      postcosechaEnable = true;
    });
  }
  @override
  void initState() {
    cargarRamos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _postcosecha(),
            _turno(size),
            _botonSiguiente(context)
          ],
        ),
      ),
    );
  }

  Widget _postcosecha() {
    return Container(
      width: 250,
      height: 70,
      child: postcosechaEnable?ListaBusqueda(
        key: _keyPostcosecha,
        lista: listaPostcosecha,
        hintText: "Post Cosecha",
        valorDefecto: postcosechaNombre,
        hintSearchText: "Escriba el nombre de Postcosecha",
        icon: Icon(Icons.move_to_inbox),
        width: 200.0,
        style: TextStyle(
          fontSize: 13,
        ),
        parentAction: (value){
          AutoComplete postcosecha= listaPostcosecha.firstWhere((item){
            return item.nombre == value;
          });
          postcosechaId = postcosecha.id;
        },
      ):Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _turno(Size size) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        width: size.width*0.4,
        child: RadioButtonGroup(
          orientation: GroupedButtonsOrientation.VERTICAL,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          picked: valorTurno,
          labels: <String>[
            "Dia",
            "Noche"
          ],
          onSelected: (select){
            if(select.compareTo('Dia')==0){
              turno = 1;
              valorTurno = 'Dia';
            }
            else{
              turno=2;
              valorTurno = 'Noche';
            }
            setState(() {

            });
          },
        ),
      )
    );
  }

  Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async{
          ControlRamos controlRamos = new ControlRamos();
          if(postcosechaId>0 && controlId ==0){
            controlRamos.elite = turno;
            controlRamos.ramosAprobado = 0;
            controlRamos.postcosechaId = postcosechaId;
            controlRamos.ramosFecha = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
            controlRamos.controlRamosId=await DatabaseEcommerce.addEcommerce(controlRamos);
            controlId = controlRamos.controlRamosId;
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CheckEcommercePage(controlRamos.controlRamosId,true)));
          }else if(controlId>0){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CheckEcommercePage(controlId,false)));
          }

        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        color: Colors.red,
        textColor: Colors.white,
        child: Container(
          height: 60,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Siguiente'),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }


}
