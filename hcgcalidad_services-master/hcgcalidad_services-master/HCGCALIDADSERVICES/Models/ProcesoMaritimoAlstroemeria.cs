using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class ProcesoMaritimoAlstroemeria
    {
        public int? ProcesoMaritimoAlstroemeriaId { get; set; }
        public int? ProcesoMaritimoAlstroemeriaUsuarioControlId { get; set; }
        public int ProcesoMaritimoAlstroemeriaNumeroGuia { get; set; }
        public int? ProcesoMaritimoAlstroemeriaDestinoId { get; set; }
        public string ProcesoMaritimoAlstroemeriaRealizadoPor { get; set; }
        public string ProcesoMaritimoAlstroemeriaAcompanamiento { get; set; }
        public int ProcesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad { get; set; }
        public int ProcesoMaritimoAlstroemeriaRecepcionLavaDesinfecta { get; set; }
        public int ProcesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionLongitudTallos { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionLibreMaltrato { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionTallosCumplePeso { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionDespachosMaritimos { get; set; }
        public int ProcesoMaritimoAlstroemeriaClasificacionAseguramientoRamo { get; set; }
        public int ProcesoMaritimoAlstroemeriaTratamientoBaldesTinas { get; set; }
        public int ProcesoMaritimoAlstroemeriaTratamientoSolucionHidratacion { get; set; }
        public int ProcesoMaritimoAlstroemeriaTratamientoNivelSolucion { get; set; }
        public int ProcesoMaritimoAlstroemeriaTratamientoCambioSolucion { get; set; }
        public int ProcesoMaritimoAlstroemeriaTratamientoTiempoSala { get; set; }
        public int ProcesoMaritimoAlstroemeriaHidratacionNumeroRamos { get; set; }
        public int ProcesoMaritimoAlstroemeriaHidratacionRamosHidratados { get; set; }
        public int ProcesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio { get; set; }
        public int ProcesoMaritimoAlstroemeriaHidratacionLimpioOrdenado { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueEdadFlor { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueEscurridoRamos { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueCajasDeformidad { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueTemperaturaHR { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto { get; set; }
        public int ProcesoMaritimoAlstroemeriaEmpaqueEmpacoHB { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteTemperauraCajas { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteTemperaturaPromedio { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteCamionTransporta { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteTemperaturaCamion { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteBuenaConexion { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteThermoking { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteCajasApiladas { get; set; }
        public int ProcesoMaritimoAlstroemeriaTransporteAcopioPreenfriado { get; set; }
        public int ProcesoMaritimoAlstromeriaTransporteTemperaturaFurgon { get; set; }
        public int ProcesoMaritimoAlstroemeriaPalletizadoEstibasLimpias { get; set; }
        public int ProcesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros { get; set; }
        public int ProcesoMaritimoAlstroemeriaPalletizadoPalletsAltura { get; set; }
        public int ProcesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido { get; set; }
        public int ProcesoMaritimoAlstroemeriaPalletizadoPalletIdentificado { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorGenset { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorFechaFabricacion { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorContenedorSeteo { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorContenedorPreenfriado { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorContenedorLavado { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorSachetsEthiblock { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorCierreSellado { get; set; }
        public int ProcesoMaritimoAlstroemeriaContenedorControlTemperatura { get; set; }
        public string ProcesoMaritimoAlstroemeriaContenedorObservaciones { get; set; }
        public string ProcesoMaritimoAlstroemeriaPalletizadoObservaciones { get; set; }
        public string ProcesoMaritimoAlstroemeriaTransporteObservaciones { get; set; }
        public string ProcesoMaritimoAlstroemeriaEmpaqueObservaciones { get; set; }
        public string ProcesoMaritimoAlstroemeriaHidratacionObservaciones { get; set; }
        public string ProcesoMaritimoAlstroemeriaTratamientoObservaciones { get; set; }
        public string ProcesoMaritimoAlstroemeriaClasificacionObservaciones { get; set; }
        public string ProcesoMaritimoAlstromeriaRecepcionObservaciones { get; set; }

        public DateTime? ProcesoMaritimoAlstroemeriaFecha { get; set; }
        public int ClienteId { get; set; }
        public int PostcosechaId { get; set; }
        public int? DetalleFirmaId { get; set; }
        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Usuariocontrol Usuariocontrol { get; set; }
        public DestinoMaritimo DestinoMaritimo { get; set; }
    }
}
