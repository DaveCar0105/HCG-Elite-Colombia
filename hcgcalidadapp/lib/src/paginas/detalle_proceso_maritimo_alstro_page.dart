import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo_alstroemeria.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';

class DetalleRegistroProcesoMaritimoAlstroemeriaPage extends StatelessWidget {
  const DetalleRegistroProcesoMaritimoAlstroemeriaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Proceso Marítimo Alstroemeria'),
      ),
      body: FutureBuilder(
        future: DatabaseProcesoMaritimoAlstroemeria.getAllProcesoMaritimoAlstromeria(),
        builder: (context, AsyncSnapshot<List<ProcesoMaritimoAlstroemeria>> snapshot) {
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
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 7
                        )
                      ]
                  ),
                  child: ListTile(
                    title: Text(
                        'INFORMACIÓN GENERAL \n'
                        'Número de Guía: ${data[i].procesoMaritimoAlstroemeriaNumeroGuia}\n'
                        //'Postcosecha: ${_getValueData(data[i],DatabaseCreator.postcosechaNombre)}\n'
                        //'Cliente: ${_getValueData(data[i],DatabaseCreator.clienteNombre)}\n'
                        //'Destino: ${_getValueData(data[i],DatabaseCreator.procesoMaritimoDestinoNombre)}\n'
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
                        "8.8. Antes del cargue de las cajas al contenedor de exportación se le realiza un control de la temperatura interna de las cajas al 20% de las cajas a ser despachadas (3 cajas por pallet). Se deja registro en el formato de distribución de pallet´s: ${_respuesta(data[i].procesoMaritimoAlstroemeriaContenedorControlTemperatura)}\n"
                        ),
                    subtitle: Text(
                        'Fecha: ${data[i].procesoMaritimoAlstroemeriaFecha!=null? data[i].procesoMaritimoAlstroemeriaFecha.toString().substring(0, 19) : "S/I"}'),
                    leading: Text((i + 1).toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                );
              }
            );
          }

          return Container();
        },
      ),
    );
  }

  String _respuesta(int valor) {
    return valor == 0 ? 'Cumple' : (valor == 1)? 'No Cumple' : 'N/A';
  }

  String _getValueData(ProcesoMaritimoAlstroemeria procesoMaritimoAlstroemeria, String keys) {
    //final routeArgs = procesoMaritimoAlstroemeria as Map;
    //return routeArgs[keys] != null ? routeArgs[keys] : 'S/I';
    return "asdasd";
  }
}
