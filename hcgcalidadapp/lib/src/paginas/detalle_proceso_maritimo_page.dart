import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';
import 'package:hcgcalidadapp/src/paginas/sincronizar_page.dart';

class DetalleRegistroProcesoMaritimoPage extends StatelessWidget {
  const DetalleRegistroProcesoMaritimoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETALLE PROCESO MARITIMO'),
      ),
      body: FutureBuilder(
        future: DatabaseProcesoMaritimo.getAllProcesoMaritimo(),
        builder: (context, AsyncSnapshot<List<ProcesoMaritimo>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text('HIDRATACION \n'
                        '*Nombre de Hidratante, dosis y fecha de elaboración: ${_respuesta(data[i].procesoMaritimoNombreHidratante)}\n'
                        '*pH soluciones 3.5 a 4.5: ${_respuesta(data[i].procesoMaritimoPhSoluciones)}\n'
                        '*El nivel de solución en las tinas de hidratación es de 10 cm todas las especies exepto Alstroemeria: ${_respuesta(data[i].procesoMaritimoNivelSolucionTinas)}\n'
                        '*Las soluciones de hidratación están limpias y libres de material vegetal: ${data[i].procesoMaritimoSolucionHidratacionSinVegetal}\n'
                        '*La temperatura del cuarto frio donde se hidrata la flor esta entre 1 a 3°C: ${data[i].procesoMaritimoTemperaturaCuartoFrio}\n'
                        '*La temperatura de las soluciones de hidratación es menor a los 6°C: ${_respuesta(data[i].procesoMaritimoTemperaturaSolucionesHidratacion)}\n'
                        'EMPAQUE\n'
                        '*El empaque es realizado en un ambiente con una temperatura que oscile entre 1º y 3ºC: ${_respuesta(data[i].procesoMaritimoEmpaqueAmbienteTemperatura)}\n'
                        '*La flor a ser empacada tiene una rotación máxima de 4 dias: ${_respuesta(data[i].procesoMaritimoFlorEmpacada)}\n'
                        '*Se coloca en todas las cajas TransportCare en el empaque, verificando su posición y cantidad de láminas por caja: ${_respuesta(data[i].procesoMaritimoTransportCareEmpaque)}\n'
                        '*Las cajas visualmente no están deformes, tienen una adecuada resistencia y están correctamente zunchadas: ${_respuesta(data[i].procesoMaritimoCajasVisualDeformes)}\n'
                        '* Etiquetas de cajas ubicadas correctamente evitando sean tapadas con  esquineros de pallet: ${_respuesta(data[i].procesoMaritimoEtiquetasCajasUbicadas)}\n'
                        'TRANSFERENCIAS\n'
                        '*La temperatura cubículo camión transferencia entre 1ºC ${_respuesta(data[i].procesoMaritimoTemperaturaCubiculoCamion)}\n'
                        '*La temperatura de  cajas de transferencia están entre 1° a 3 C: ${_respuesta(data[i].procesoMaritimoTemperaturaCajasTransferencia)}\n'
                        '*La apariencia de las cajas de transferencia estan en buen estado, no mojadas, correctamente marcadas, no deformes: ${_respuesta(data[i].procesoMaritimoAparenciaCajasTransferencia)}\n'
                        'PALLETIZADO\n'
                        '*Las estibas de madera están debidamente selladas, limpias, en buen estado,  correctamente armadas y del tamaño adecuado: ${_respuesta(data[i].procesoMaritimoEstibasDebidamenteSelladas)}\n'
                        '*Pallets con esquineros con altura que coincide, resistentes y  correctamente ajustados con 4 zunchos transversales y 4 zunchos  verticales: ${_respuesta(data[i].procesoMaritimoPalletsEsquinerosCorrectamenteAjustados)}\n'
                        '*Pallets con altura no mayor a 2.35m? Los pallets no deben sobrepasar  la línea roja del contenedor: ${_respuesta(data[i].procesoMaritimoPalletsAlturaContenedor)}\n'
                        '*4 registradores de temperatura distribuidos proporcionalmente en los  pallet del contenedor? Cajas debidamente identificadas: ${_respuesta(data[i].procesoMaritimoTemperaturaPalletContenedor)}\n'
                        '*Cada pallet identificado con el número de pallet, ciudad de destino y  número de piezas.: ${_respuesta(data[i].procesoMaritimoPalletIdentificadoNumero)}\n'
                        '*Toma y registro de temperaturas tomadas en mínimo 2 cajas de cada  pallet: ${_respuesta(data[i].procesoMaritimoTomaRegistroTemperaturas)}\n'
                        'LLENADO CONTENEDOR\n'
                        '*Genset (generador de energía del contenedor) con autonomía para 60  horas?: ${_respuesta(data[i].procesoMaritimoGenset)}\n'
                        '* Contenedor con edad de fabricación no mayor a 5 años (empaquetadura  y cierres de puerta en buen estado y libre de cualquier objeto extraño al  interior: ${_respuesta(data[i].procesoMaritimoContenedorEdadFabricacion)}\n'
                        '*Contenedor cumpliendo el siguiente seteo: temperatura 0.5ºC, Defrost  o descongelamiento por demanda, Humedad relativa: OFF, Ventilación:  5%, desagues cerrados: ${_respuesta(data[i].procesoMaritimoContenedorCumplimientoSeteo)}\n'
                        '*Contenedor preenfriado durante 120 minutos garantizando temperatura  de retorno máxima de 1.5ºC: ${_respuesta(data[i].procesoMaritimoContenedorPreEnfriado)}\n'
                        '*Contenedor lavado y desinfectado libre de malos olores: ${_respuesta(data[i].procesoMaritimoContenedorlavadoDesinfectado)}\n'
                        '*60 minutos antes de iniciar el cargue sachets de Ethilblock previamente humedecidos con agua potable ubicados dentro de cada caja: ${_respuesta(data[i].procesoMartimoCarguePreviamenteHumedecidos)}\n'
                        '*Realizado el llegando el cierre y sellado de las puertas se realiza a más  tardar 3 minutos después de desconectado el contenedor del muelle de  carga: ${_respuesta(data[i].procesoMaritimoLlegandoCierreSellado)}\n'
                        'REQUERIMIENTOS CRITICOS\n'
                        '*Las estibas presenta sello del ICA  de manera visible : ${_respuesta(data[i].procesoMaritimoEstibasSelloICA)}\n'
                        '*los pallets se enuentran con una adecuada tensión de zunchos: ${_respuesta(data[i].procesoMaritimoPalletsTensionZunchos)}\n'
                        '*Pallet debidamente identificado con etiqueta numeración pallet: ${_respuesta(data[i].procesoMaritimoPalletIdentificadoEtiqueta)}\n'
                        '*Componente de pallet se encuentra sin mezcla de destinos y etiquetas: ${_respuesta(data[i].procesoMaritimoComponentePalletDestinosEtiquetas)}\n'
                        '*El camión se encuentra con sello de seguridad de contenedor: ${_respuesta(data[i].procesoMaritimoCamionSelloSeguridadContenedor)}\n'
                        '*Verificación de encendido adecuado de termógrafo, respaldo etiqueta, código: ${_respuesta(data[i].procesoMaritimoVerificacionEncendidoTermografo)}\n'
                        '*Fotografías de cargue pallets de la empresa cuando es contenedor compartido: ${_respuesta(data[i].procesoMaritimoFotografiaPalletsEmpresaContenor)}\n'),
                    subtitle: Text(
                        'Fecha: ${data[i].procesoMaritimoFecha.toString().substring(0, 19)}'),
                    leading: Text((i + 1).toString()),
                  );
                });
          }

          return Container();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: RaisedButton(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => SincronizarPage()));
      //     },
      //     shape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //     color: Colors.green,
      //     textColor: Colors.white,
      //     child: Container(
      //       width: 130,
      //       height: 70,
      //       child: Row(
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: <Widget>[
      //           // Text(
      //           //   'FORMULARIOS',
      //           //   style: TextStyle(fontSize: 15),
      //           // ),
      //           Icon(Icons.update)
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  String _respuesta(int valor) {
    return valor == 0 ? 'Cumple' : 'No Cumple';
  }
}
