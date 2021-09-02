import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';

class DetalleRegistroProcesoMaritimoPage extends StatelessWidget {
  const DetalleRegistroProcesoMaritimoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Proceso Marítimo'),
      ),
      body: FutureBuilder(
        future: DatabaseProcesoMaritimo.getAllProcesoMaritimoAprobacion(),
        builder: (context, AsyncSnapshot<List<ProcesoMaritimo>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 7)
                          ]),
                      child: ListTile(
                        title: Text('HIDRATACIÓN \n'
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
                      ));
                });
          }

          return Container();
        },
      ),
    );
  }

  String _respuesta(int valor) {
    return valor == 0
        ? 'Cumple'
        : (valor == 1)
            ? 'No Cumple'
            : 'N/A';
  }
}
