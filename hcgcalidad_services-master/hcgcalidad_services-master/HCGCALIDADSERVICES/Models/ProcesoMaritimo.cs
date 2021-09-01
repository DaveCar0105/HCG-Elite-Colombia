using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class ProcesoMaritimo
    {
        public int? ProcesoMaritimoId { get; set; }
        public int? ProcesoMaritimoUsuarioControlId { get; set; }
        public int ProcesoMaritimoNumeroGuia { get; set; }
        public int? ProcesoMaritimoDestinoId { get; set; }
        public string ProcesoMaritimoRealizadoPor { get; set; }
        public string ProcesoMaritimoAcompanamiento { get; set; }
        public int ProcesoMaritimoNombreHidratante { get; set; }
        public int ProcesoMaritimoPhSoluciones { get; set; }
        public int ProcesoMaritimoNivelSolucionTinas { get; set; }
        public int ProcesoMaritimoSolucionHidratacionSinVegetal { get; set; }
        public int ProcesoMaritimoTemperaturaCuartoFrio { get; set; }
        public int ProcesoMaritimoTemperaturaSolucionesHidratacion { get; set; }
        public int ProcesoMaritimoEmpaqueAmbienteTemperatura { get; set; }
        public int ProcesoMaritimoFlorEmpacada { get; set; }
        public int ProcesoMaritimoTransportCareEmpaque { get; set; }
        public int ProcesoMaritimoCajasVisualDeformes { get; set; }
        public int ProcesoMaritimoEtiquetasCajasUbicadas { get; set; }
        public int ProcesoMaritimoTemperaturaCubiculoCamion { get; set; }
        public int ProcesoMaritimoTemperaturaCajasTransferencia { get; set; }
        public int ProcesoMaritimoAparenciaCajasTransferencia { get; set; }
        public int ProcesoMaritimoEstibasDebidamenteSelladas { get; set; }
        public int ProcesoMaritimoPalletsEsquinerosCorrectamenteAjustados { get; set; }
        public int ProcesoMaritimoPalletsAlturaContenedor { get; set; }
        public int ProcesoMaritimoTemperaturaPalletContenedor { get; set; }
        public int ProcesoMaritimoPalletIdentificadoNumero { get; set; }
        public int ProcesoMaritimoTomaRegistroTemperaturas { get; set; }
        public int ProcesoMaritimoGenset { get; set; }
        public int ProcesoMaritimoContenedorEdadFabricacion { get; set; }
        public int ProcesoMaritimoContenedorCumplimientoSeteo { get; set; }
        public int ProcesoMaritimoContenedorPreEnfriado { get; set; }
        public int ProcesoMaritimoContenedorlavadoDesinfectado { get; set; }
        public int ProcesoMaritimoCarguePreviamenteHumedecidos { get; set; }
        public int ProcesoMaritimoLlegandoCierreSellado { get; set; }
        public int ProcesoMaritimoEstibasSelloICA { get; set; }
        public int ProcesoMaritimoPalletsTensionZunchos { get; set; }
        public int ProcesoMaritimoPalletIdentificadoEtiqueta { get; set; }
        public int ProcesoMaritimoComponentePalletDestinosEtiquetas { get; set; }
        public int ProcesoMaritimoCamionSelloSeguridadContenedor { get; set; }
        public int ProcesoMaritimoVerificacionEncendidoTermografo { get; set; }
        public int ProcesoMaritimoFotografiaPalletsEmpresaContenor { get; set; }


        public string ProcesoMaritimoObservacionesHidratacion { get; set; }
        public string ProcesoMaritimoObservacionesEmpaque { get; set; }
        public string ProcesoMaritimoObservacionesTransferencias { get; set; }
        public string ProcesoMaritimoObservacionesPalletizado { get; set; }
        public string ProcesoMaritimoObservacionesLlenadoContenedor { get; set; }
        public string ProcesoMaritimoObservacionesRequerimientosCriticos { get; set; }
        public DateTime? ProcesoMaritimoFecha { get; set; }
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
