import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo_alstroemeria.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_ordenes_clientes_banda_page.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_ordenes_clientes_page.dart';

class AprobacionPage extends StatefulWidget {
  @override
  _AprobacionPageState createState() => _AprobacionPageState();
}

class _AprobacionPageState extends State<AprobacionPage> {
  List<ReporteAprobacion> listaReportes = [];
  List<ReporteAprobacionBanda> listaBandas = [];
  List<Map<String, dynamic>> listaEcuador = [];
  List<ProcesoMaritimo> listaProcesoMaritimo = [];
  List<ProcesoMaritimoAlstroemeria> listaProcesoMaritimoAlstroemeria = [];
  bool inicio = false;
  @override
  void initState() {
    cargarReportes();
    super.initState();
  }

  cargarReportes() async {
    List<ReporteAprobacion> lista = [];
    lista = await DatabaseReportesAprobacion.getAllReportes();
    listaReportes = lista;
    List<ReporteAprobacionBanda> listaB = [];
    listaB = await DatabaseReportesAprobacion.getAllReportesBandas();
    listaBandas = listaB;
    listaEcuador = await DatabaseEcuador.getAllEcuadorAprobacion();
    listaProcesoMaritimo =
        await DatabaseProcesoMaritimo.getAllProcesoMaritimoAprobacion();
    listaProcesoMaritimoAlstroemeria = await DatabaseProcesoMaritimoAlstroemeria
        .getAllProcesoMaritimoAlstromeriaAprobacion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.local_florist),
              ),
              Tab(
                icon: Icon(Icons.set_meal),
              ),
              Tab(
                icon: Icon(Icons.flag),
              ),
              Tab(
                icon: Icon(Icons.directions_boat),
              ),
              Tab(
                icon: Icon(Icons.anchor_rounded),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: listaReportes.length,
              itemBuilder: (context, index) =>
                  _itemReporte(listaReportes[index], w),
            ),
            ListView.builder(
              itemCount: listaBandas.length,
              itemBuilder: (context, index) => _itemResumenBanda(
                  listaBandas[index], w), //cambiar la variable despues
            ),
            ListView.builder(
              itemCount: listaEcuador.length,
              itemBuilder: (context, index) =>
                  _itemResumenEcuador(listaEcuador[index]),
            ),
            ListView.builder(
              itemCount: listaProcesoMaritimo.length,
              itemBuilder: (context, index) =>
                  _itemResumenProcesoMaritimo(listaProcesoMaritimo, index),
            ),
            ListView.builder(
              itemCount: listaProcesoMaritimoAlstroemeria.length,
              itemBuilder: (context, index) =>
                  _itemResumenProcesoMaritimoAlstroemeria(
                      listaProcesoMaritimoAlstroemeria, index),
            )
          ],
        ),
        floatingActionButton: listaReportes.length +
                    listaBandas.length +
                    listaEcuador.length +
                    listaProcesoMaritimo.length +
                    listaProcesoMaritimoAlstroemeria.length >
                0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'listaFirma');
                },
                child: Icon(Icons.assignment_turned_in_rounded),
              )
            : null,
      ),
    );
  }

  Widget _itemResumenBanda(ReporteAprobacionBanda report, double w) {
    int ramos = 0;
    ramos = report.totalRamosRevisadosBanda;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DetalleOrdenesClienteBanda(
                    report.clienteBandaId))); //item['controlBandaId']
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellowAccent,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                report.clienteBandaNombre, //item['clienteNombre']
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ramos > 0
                ? Text(
                    'Resumen control Banda',
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  )
                : Container(),
            ramos > 0
                ? itemTexto('Promedio % No conformidad: ',
                    report.inconformidadBandaP.toStringAsFixed(2), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalRamosRamosBanda.toString(), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Problema principal: ',
                    report.falenciaPrincipalBanda, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Problema secundario: ',
                    report.falenciaSegundariaBanda, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalRamosRevisadosBanda.toString(), w - 20)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _itemResumenEcuador(Map<String, dynamic> item) {
    List<Map<String, dynamic>> problemas = [];
    problemas = item['ecuadorProblemas'];
    String problemaBanda = '';
    if (problemas.length > 0) {
      problemas.forEach((element) {
        problemaBanda += element['falenciaRamosNombre'] +
            ' - Ramos: ' +
            element['falenciaBandaRamos'].toString() +
            '\n';
      });
    }
    return ListTile(
      title: Text(item['controlNumeroOrden'] +
          '\n' +
          item['clienteNombre'] +
          '\n' +
          item['postcosechaNombre'] +
          '\n' +
          item['productoNombre']),
      subtitle: Text(problemaBanda),
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Confirmar eliminar'),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await DatabaseEcuador.deleteEcuador(
                            item['controlBandaId']);
                        await cargarReportes();
                        Navigator.pop(context);
                      },
                      child: Text('Aceptar'),
                    ),
                  ],
                ));
      },
    );
  }

  Widget _itemReporte(ReporteAprobacion report, double w) {
    int ramos = 0;
    int empaque = 0;
    ramos = report.totalRamosRevisados;
    empaque =
        report.totalEmpaqueRamosRevisados + report.totalEmpaqueCajasRevisadas;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetalleOrdenesCliente(report.clienteId)));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 100)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                report.clienteNombre,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ramos > 0
                ? Text(
                    'Resumen control Ramos',
                    style: TextStyle(fontSize: 21, color: Colors.blueAccent),
                  )
                : Container(),
            ramos > 0
                ? itemTexto('Promedio % No conformidad: ',
                    report.inconformidadP.toStringAsFixed(2), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalRamosRamos.toString(), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto(
                    'Problema principal: ', report.falenciaPrincipal, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto(
                    'Problema secundario: ', report.falenciaSegundaria, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalRamosRevisados.toString(), w - 20)
                : Container(),
            empaque > 0
                ? Text(
                    'Resumen control Empaque',
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  )
                : Container(),
            empaque > 0
                ? itemTexto(
                    'Promedio % No conformes Cajas: ',
                    report.inconformidadEmpaqueCajasP.toStringAsFixed(2),
                    w - 20)
                : Container(),
            empaque > 0
                ? itemTexto(
                    'Promedio % No conformes Ramos: ',
                    report.inconformidadEmpaqueRamosP.toStringAsFixed(2),
                    w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cantidad Cajas No conformes: ',
                    report.totalEmpaqueCajas.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalEmpaqueRamos.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Problema principal: ',
                    report.falenciaPrincipalEmpaque.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Problema secundario: ',
                    report.falenciaSegundariaEmpaque.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalEmpaqueRamosRevisados.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cajas revisadas: ',
                    report.totalEmpaqueCajasRevisadas.toString(), w - 20)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _itemResumenProcesoMaritimo(List<ProcesoMaritimo> data, int i) {
    return Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 7)]),
        child: ListTile(
          title: Text('INFORMACIÓN GENERAL \n'
              'Número de Guía: ${data[i].procesoMaritimoNumeroGuia}\n'
              'Realizado: ${data[i].procesoMaritimoRealizadoPor}\n'
              '\nHIDRATACIÓN \n'
              '1.1. Nombre de hidratante, dosis y fecha de elaboración: ${_respuesta(data[i].procesoMaritimoNombreHidratante)}\n'
              '1.2. Ph soluciones 3.5 a 4.5: ${_respuesta(data[i].procesoMaritimoPhSoluciones)}\n'
              '1.3. El nivel de solución en las tinas de hidratación es de 10 cm todas las especies exepto Alstroemeria: ${_respuesta(data[i].procesoMaritimoNivelSolucionTinas)}\n'
              '1.4. Las soluciones de hidratación están limpias y libres de material vegetal: ${_respuesta(data[i].procesoMaritimoSolucionHidratacionSinVegetal)}\n'
              '1.5. La temperatura del cuarto frio donde se hidrata la flor esta entre 1 a 3°C: ${_respuesta(data[i].procesoMaritimoTemperaturaCuartoFrio)}\n'
              '1.6. La temperatura de las soluciones de hidratación es menor a los 6°C: ${_respuesta(data[i].procesoMaritimoTemperaturaSolucionesHidratacion)}\n'
              '\nEMPAQUE\n'
              '2.1. El empaque es realizado en un ambiente con una temperatura que oscile entre 1º y 3ºC: ${_respuesta(data[i].procesoMaritimoEmpaqueAmbienteTemperatura)}\n'
              '2.2. La flor a ser empacada tiene una rotación máxima de 4 dias: ${_respuesta(data[i].procesoMaritimoFlorEmpacada)}\n'
              '2.3. Se coloca en todas las cajas TransportCare en el empaque, verificando su posición y cantidad de láminas por caja: ${_respuesta(data[i].procesoMaritimoTransportCareEmpaque)}\n'
              '2.4. Las cajas visualmente no están deformes, tienen una adecuada resistencia y están correctamente zunchadas: ${_respuesta(data[i].procesoMaritimoCajasVisualDeformes)}\n'
              '2.5. Etiquetas de cajas ubicadas correctamente evitando sean tapadas con  esquineros de pallet: ${_respuesta(data[i].procesoMaritimoEtiquetasCajasUbicadas)}\n'
              '\nTRANSFERENCIAS\n'
              '3.1. La temperatura cubículo camión transferencia entre 1ºC ${_respuesta(data[i].procesoMaritimoTemperaturaCubiculoCamion)}\n'
              '3.2. La temperatura de  cajas de transferencia están entre 1° a 3 C: ${_respuesta(data[i].procesoMaritimoTemperaturaCajasTransferencia)}\n'
              '3.3. La apariencia de las cajas de transferencia estan en buen estado, no mojadas, correctamente marcadas, no deformes: ${_respuesta(data[i].procesoMaritimoAparenciaCajasTransferencia)}\n'
              '\nPALLETIZADO\n'
              '4.1. Las estibas de madera están debidamente selladas, limpias, en buen estado,  correctamente armadas y del tamaño adecuado: ${_respuesta(data[i].procesoMaritimoEstibasDebidamenteSelladas)}\n'
              '4.2. Pallets con esquineros con altura que coincide, resistentes y  correctamente ajustados con 4 zunchos transversales y 4 zunchos  verticales: ${_respuesta(data[i].procesoMaritimoPalletsEsquinerosCorrectamenteAjustados)}\n'
              '4.3. Pallets con altura no mayor a 2.35m? Los pallets no deben sobrepasar  la línea roja del contenedor: ${_respuesta(data[i].procesoMaritimoPalletsAlturaContenedor)}\n'
              '4.4. 4 registradores de temperatura distribuidos proporcionalmente en los  pallet del contenedor? Cajas debidamente identificadas: ${_respuesta(data[i].procesoMaritimoTemperaturaPalletContenedor)}\n'
              '4.5. Cada pallet identificado con el número de pallet, ciudad de destino y  número de piezas.: ${_respuesta(data[i].procesoMaritimoPalletIdentificadoNumero)}\n'
              '4.6. Toma y registro de temperaturas tomadas en mínimo 2 cajas de cada  pallet: ${_respuesta(data[i].procesoMaritimoTomaRegistroTemperaturas)}\n'
              '\nLLENADO CONTENEDOR\n'
              '5.1. Genset (generador de energía del contenedor) con autonomía para 60  horas?: ${_respuesta(data[i].procesoMaritimoGenset)}\n'
              '5.2. Contenedor con edad de fabricación no mayor a 5 años (empaquetadura  y cierres de puerta en buen estado y libre de cualquier objeto extraño al  interior: ${_respuesta(data[i].procesoMaritimoContenedorEdadFabricacion)}\n'
              '5.3. Contenedor cumpliendo el siguiente seteo: temperatura 0.5ºC, Defrost  o descongelamiento por demanda, Humedad relativa: OFF, Ventilación:  5%, desagues cerrados: ${_respuesta(data[i].procesoMaritimoContenedorCumplimientoSeteo)}\n'
              '5.4. Contenedor preenfriado durante 120 minutos garantizando temperatura  de retorno máxima de 1.5ºC: ${_respuesta(data[i].procesoMaritimoContenedorPreEnfriado)}\n'
              '5.5. Contenedor lavado y desinfectado libre de malos olores: ${_respuesta(data[i].procesoMaritimoContenedorlavadoDesinfectado)}\n'
              '5.6. 60 minutos antes de iniciar el cargue sachets de Ethilblock previamente humedecidos con agua potable ubicados dentro de cada caja: ${_respuesta(data[i].procesoMartimoCarguePreviamenteHumedecidos)}\n'
              '5.7. Realizado el llegando el cierre y sellado de las puertas se realiza a más  tardar 3 minutos después de desconectado el contenedor del muelle de  carga: ${_respuesta(data[i].procesoMaritimoLlegandoCierreSellado)}\n'
              '\nREQUERIMIENTOS CRÍTICOS\n'
              '6.1. Las estibas presenta sello del ICA  de manera visible : ${_respuesta(data[i].procesoMaritimoEstibasSelloICA)}\n'
              '6.2. Los pallets se enuentran con una adecuada tensión de zunchos: ${_respuesta(data[i].procesoMaritimoPalletsTensionZunchos)}\n'
              '6.3. Pallet debidamente identificado con etiqueta numeración pallet: ${_respuesta(data[i].procesoMaritimoPalletIdentificadoEtiqueta)}\n'
              '6.4. Componente de pallet se encuentra sin mezcla de destinos y etiquetas: ${_respuesta(data[i].procesoMaritimoComponentePalletDestinosEtiquetas)}\n'
              '6.5. El camión se encuentra con sello de seguridad de contenedor: ${_respuesta(data[i].procesoMaritimoCamionSelloSeguridadContenedor)}\n'
              '6.6. Verificación de encendido adecuado de termógrafo, respaldo etiqueta, código: ${_respuesta(data[i].procesoMaritimoVerificacionEncendidoTermografo)}\n'
              '6.7. Fotografías de cargue pallets de la empresa cuando es contenedor compartido: ${_respuesta(data[i].procesoMaritimoFotografiaPalletsEmpresaContenor)}\n'),
          subtitle: Text(
              'Fecha: ${data[i].procesoMaritimoFecha.toString().substring(0, 19)}'),
          leading: Text((i + 1).toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Confirmar eliminar'),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await DatabaseProcesoMaritimo.deleteProcesoMaritimo(
                                data[i].procesoMaritimoId);
                            await cargarReportes();
                            Navigator.pop(context);
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    ));
          },
        ));
  }

  Widget _itemResumenProcesoMaritimoAlstroemeria(
      List<ProcesoMaritimoAlstroemeria> data, int i) {
    return Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 7)]),
        child: ListTile(
          title: Text('INFORMACIÓN GENERAL \n'
              'Número de Guía: ${data[i].procesoMaritimoAlstroemeriaNumeroGuia}\n'
              'Realizado: ${data[i].procesoMaritimoAlstroemeriaRealizadoPor}\n'
              '\nRECEPCIÓN \n'
              '1.1. El producto a su llegada a la postcosecha es ubicado en un lugar con condiciones de temperatura no mayores a 15ºC y humedad relativa entre 55 a 65%. Se poseen registros: ${_respuesta(data[i].procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad)}\n'
              '1.2. Se lava y desinfecta la sala acorde a lo programado en el cronograma de Aseo de postcosecha y programa de aspersión. Se cuenta con registros. Visualmente las mesas, gillotinas, pisos, tinas de surtido y mesas de empaque se encuentran limpios: ${_respuesta(data[i].procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta)}\n'
              '1.3. Se tiene establecido y se esta cumpliendo el sistema de identificacion para garantizar que lo primero que entre a la sala es lo primero que se procese (PEPS ): ${_respuesta(data[i].procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion)}\n'
              '\nCLASIFICACIÓN Y BONCHEO \n'
              '2.1. Las mesas de clasificación cuentan con guías que permiten definir la longitud de los tallos, el nivel de deshoje y el grado de tolerancia a la torcidez; asi como guías para verificar el calibre de los tallos y balanza para verificar el peso del ramo.  El personal conoce el uso de la herramienta y aplica los requerimientos establecidos por el cliente: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionLongitudTallos)}\n'
              '2.2. Existen registros de capacitación al personal de clasificación y boncheo y a los empacadores sobre las especificaciones de clasificación, boncheo y empaque de los ramos y cajas para despacho marítimo: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal)}\n'
              '2.3. A cada ramo se le coloca un capuchon biorentado transparente, Si los ramos son de 6 tallos se utiliza capuchón macro perforado de (35 x 10 x 45) y si son de 10 tallos se utiliza capuchón microperforado de (35 x 10 x 50) y no se les coloca papel durante el armado: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado)}\n'
              '2.4. Se Asegura el capuchón y el flower food con cinta (para ramos de 6 tallos) o con doble caucho (para ramos de 10 tallos): ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood)}\n'
              '2.5. El producto bonchado se encuentra  libre de maltrato fuerte, deshidratación, decoloración  y cumple con el punto de apertura establecido: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionLibreMaltrato)}\n'
              '2.6. Los tallos cumplen con el peso y los requerimientos establecidos por el cliente: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso)}\n'
              '2.7. Los ramos armados para despachos marítimos cumplen con todos los requerimientos de calidad establecidos  y el porcentaje de conformidad del despacho, acorde a la evaluación realizada por el Inspector de calidad. Se encuentra en ( Mínimo 85%)  Registrar Causas: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos)}\n'
              '2.8. Se realiza aseguramiento de ramo terminado a mínimo el 50% del despacho, por parte del Jefe de poscosecha, líder de calidad de la sala y supervisor de poscosecha: ${_respuesta(data[i].procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo)}\n'
              '\nTRATAMIENTO DE HIDRATACIÓN \n'
              '3.1. Los baldes/tinas que se utilizan para el proceso de hidratación, fueron lavados y desinfectados, se encuentran limpios y libres de residuos de material vegetal  y/o suciedad acumulada en fondo y/o paredes de los mismos: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTratamientoBaldesTinas)}\n'
              '3.2. Se está preparando la solución de hidratación con las condiciones de pH del agua origen y las condiciones finales de la solución preparada (pH entre 4,5 a 5,5  medido con pHmétro o 4 – 5 con cinta indicadora marca Merck, ausencia de cloro y concentración de plata).  Registrar información en formato de preparación de soluciones de hidratación poscosecha: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion)}\n'
              '3.3. El nivel de solución en las tinas de hidratación es de 7 cm y en baldes de 3 cm, se garantiza que todos los tallos estén inmersos en la solución: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTratamientoNivelSolucion)}\n'
              '3.4. Se realiza el cambio de la solución de hidratación máximo 3 días: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTratamientoCambioSolucion)}\n'
              '3.5. El tiempo en sala de la flor no debe ser mayor a 40 minutos: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTratamientoTiempoSala)}\n'
              '\nHIDRATACIÓN \n'
              '4.1. Cumple con el número de ramos máximos permitidos por tina de hidratación ( 30 ramos de 5 tallos, 25 ramos de 6 tallos, 20 ramos de 10 tallos, 15 ramos de 12 tallos, 9 ramos de 18 tallos): ${_respuesta(data[i].procesoMaritimoAlstroemeriaHidratacionNumeroRamos)}\n'
              '4.2. Los ramos son hidratados por 4 horas a temperatura ambiente en solución STS y luego en cuarto frío mínimo 12 horas en esa misma solución: ${_respuesta(data[i].procesoMaritimoAlstroemeriaHidratacionRamosHidratados)}\n'
              '4.3. La temperatura de cuarto frío de hidratación oscila entre 0.5 ºC y 1.5 ºC y una humedad relativa de 80% a 85%. Se llevan registros: ${_respuesta(data[i].procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio)}\n'
              '4.4. El cuarto frío de hidratación se encuentra limpio y ordenado. Se lava y desinfecta acorde a lo programado en el cronograma de aseo y desinfección de poscosecha: ${_respuesta(data[i].procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado)}\n'
              '\nEMPAQUE\n'
              '5.1. Los empacadores recibieron capacitación en el requerimiento de empaque de las cajas marítimas. Existen registros de capacitación: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion)}\n'
              '5.2. La edad de la flor utilizada para el empaque de las cajas marítimas es de acuerdo al cliente: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueEdadFlor)}\n'
              '5.3. Se realiza escurrido a los ramos antes de ser empacados: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos)}\n'
              '5.4. Se revisó la temperatura de los ramos antes de ser empacados y estos se encontraban en máximo 2 °C: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos)}\n'
              '5.5. Las cajas empacadas cumplen con los requerimientos establecidos: uso de cajas especiales para marítimo, uso de láminas de transport care en la base y la parte superior de la caja previamente activadas con agua, distribución de los ramos y zunchado acorde a lo establecido: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento)}\n'
              '5.6. Se ubicó dentro de 1 de las cajas del despacho marítimo 1 registrador de temperatura que permita ver el comportamiento de la temperatura durante el transporte al centro de acopio. Caja debidamente indentificada?: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo)}\n'
              '5.7. Las cajas se encuentran sin deformidad, visualmente resistentes, correctamente zunchadas: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad)}\n'
              '5.8. Las etiquetas de cajas se encuentran ubicadas correctamente evitando sean tapadas con esquineros de pallet?: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas)}\n'
              '5.9. El producto empacado listo para el cargue se encuentra en estibas que coinciden con el tamaño de las cajas: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue)}\n'
              '5.10. El cuarto frío de empaque y el de despachos  se encuentra a una temperatura de 0.5 a 2 °C y una HR de 80 a 85%. Se controlan y llevan registros: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR)}\n'
              '5.11. Se realiza auditoría de producto terminado a mínimo 1 caja del despacho marítimo por parte del jefe de sala, líder de calidad y supervisor de sala: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto)}\n'
              '5.12. Se empaco 1 HB  con ramos tomados al azar y que hayan seguido todo el  proceso del marítimo y se envió al  Dpto de calidad para evaluacion de viaje simulado y de vida en florero: ${_respuesta(data[i].procesoMaritimoAlstroemeriaEmpaqueEmpacoHB)}\n'
              '\nTRANSPORTE AL CENTRO DE ACOPIO\n'
              '6.1. Se tomaron temperaturas al 20% de las cajas del despacho y se dejó evidencia en el formato de Control de Temperaturas de Despacho. Se llevan registros: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteTemperauraCajas)}\n'
              "6.2. La temperatura promedio de las cajas de despacho fue menor a 2 °C. En caso contrario se pasaron las cajas a precooler: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio)}\n"
              '6.3. El camión que transporta las cajas al centro de acopio fue previamente lavado y desinfectado con Timsen (2 g/lt). Hay registros que lo evidencien: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteCamionTransporta)}\n'
              '6.4. Se mide y registra la temperatura del camión al abrir la puerta: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteTemperaturaCamion)}\n'
              '6.5. El cargue de las cajas se realizó garantizando una buena conexión de la puerta del camión y el cuarto frío: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteBuenaConexion)}\n'
              '6.6. Durante el  cargue y descargue el camion que realiza el transporte de la carga se mantuvo encendido el thermoking: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteThermoking)}\n'
              '6.7. Las cajas en el camión fueron apiladas una sobre otra sin cubrir la salida de aire frío del difusor del furgón y se dejó un espacio libre de 20 a 30 cm entre la línea de salida de aire del difusor y la última caja: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteCajasApiladas)}\n'
              '6.8. El camión utilizado para el transporte de las cajas al centro de acopio fue preenfriado dos horas antes de iniciar el cargue y lleva un termómetro de máximos y mínimos: ${_respuesta(data[i].procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado)}\n'
              '6.9. La temperatura del furgon en el momento del cargue era de máximo 1.5°C (verificar esta información con el termómetro de aguja o laser) y el thermoking del camión se graduó a una temperatura de 0.5 °C a 1.5 °C: ${_respuesta(data[i].procesoMaritimoAlstromeriaTransporteTemperaturaFurgon)}\n'
              '\nPALLETIZADO\n'
              '7.1. Las estibas que se usan para palletizar estan debidamente limpias, en buen estado, correctamente armadas y del tamaño adecuado: ${_respuesta(data[i].procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias)}\n'
              "7.2. Los pallet's poseen esquineros con altura que coincide, resistentes y correctamente ajustados con 4 zunchos transversales y 4 verticales: ${_respuesta(data[i].procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros)}\n"
              '7.3. Los pallets tienen una altura máxima de 2,35 m. y  no sobrepasan la línea roja del contenedor: ${_respuesta(data[i].procesoMaritimoAlstroemeriaPalletizadoPalletsAltura)}\n'
              '7.4. Se colocan 5 registradores de temperatura distribuidos proporcionalmente en los pallet del contenedor y las cajas se encuentran debidamente identificadas: ${_respuesta(data[i].procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido)}\n'
              '7.5. Cada pallet se encuentra identificado con el número de pallet, ciudad de destino y número de piezas: ${_respuesta(data[i].procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado)}\n'
              '\nLLENADO CONTENEDOR\n'
              '8.1. El Genset (generador de energía del contenedor) tiene autonomía para 60 horas: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorGenset)}\n'
              '8.2. El contenedor tiene una fecha de fabricación no mayor a 5 años: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorFechaFabricacion)}\n'
              '8.3. El contenedor cumple el siguiente seteo: temperatura 0.5ºC, defrost o descongelamiento por demanda, Humedad relativa: OFF, ventilación: 5%, desagües cerrados: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorContenedorSeteo)}\n'
              '8.4. El contenedor preenfriado durante 120 minutos garantizando temperatura de retorno máxima de 1.5ºC / para despachos consolidados el retorno del contenedor debe ser inferior a 2.5ºC: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado)}\n'
              '8.5. El contenedor se encuentra lavado, desinfectado y libre de malos olores: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorContenedorLavado)}\n'
              "8.6. 60 minutos antes de iniciar el cargue se ubicaron sachet's de Ethilblock previamente humedecidos con agua potable dentro de cada caja de acuerdo al procedmiento: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorSachetsEthiblock)}\n"
              '8.7. El cierre y sellado de las puertas se realiza a más tardar 3 minutos después de desconectado el contenedor del muelle de carga: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorCierreSellado)}\n'
              "8.8. Antes del cargue de las cajas al contenedor de exportación se le realiza un control de la temperatura interna de las cajas al 20% de las cajas a ser despachadas (3 cajas por pallet). Se deja registro en el formato de distribución de pallet´s: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorControlTemperatura)}\n"),
          subtitle: Text(
              'Fecha: ${data[i].procesoMaritimoAlstroemeriaFecha != null ? data[i].procesoMaritimoAlstroemeriaFecha.toString().substring(0, 19) : "S/I"}'),
          leading: Text((i + 1).toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Confirmar eliminar'),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await DatabaseProcesoMaritimoAlstroemeria
                                .deleteProcesoMaritimoAlstroemeria(
                                    data[i].procesoMaritimoAlstroemeriaId);
                            await cargarReportes();
                            Navigator.pop(context);
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    ));
          },
        ));
  }

  itemTexto(String clave, String valor, double w) {
    return Container(
        width: w,
        child: Wrap(
          children: <Widget>[
            Container(
              width: w,
              child: Text(
                clave,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            Container(
              child: Text(
                valor,
                style: TextStyle(
                  fontSize: 18,
                ),
                textScaleFactor: 1,
              ),
            )
          ],
        ));
  }

  String _respuesta(int valor) {
    return valor == 0
        ? 'Cumple'
        : (valor == 1)
            ? 'No Cumple'
            : 'N/A';
  }
}
