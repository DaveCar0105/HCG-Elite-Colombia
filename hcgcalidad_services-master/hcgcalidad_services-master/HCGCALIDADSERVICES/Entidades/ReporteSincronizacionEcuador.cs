using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Entidades
{
    public class ReporteSincronizacionEcuador
    {
        [JsonProperty("firmas")]
        public List<Firma> Firmas { get; set; }
        [JsonProperty("detallesFirma")]
        public List<DetallesFirma> DetallesFirma { get; set; }
        [JsonProperty("listaEcuador")]
        public List<AlertaSincroEcuador> ListaEcuador { get; set; }
    }
    public partial class AlertaSincroEcuador
    {
        [JsonProperty("controlBandaId")]
        public int ControlBandaId { get; set; }

        [JsonProperty("controlNumeroOrden")]
        public string ControlNumeroOrden { get; set; }

        [JsonProperty("bandaRamos")]
        public int BandaRamos { get; set; }

        [JsonProperty("bandaFecha")]
        public DateTime BandaFecha { get; set; }

        [JsonProperty("bandaAprobado")]
        public int BandaAprobado { get; set; }

        [JsonProperty("bandaTallos")]
        public int BandaTallos { get; set; }

        [JsonProperty("bandaDerogado")]
        public string BandaDerogado { get; set; }

        [JsonProperty("bandaElaborado")]
        public int BandaElaborado { get; set; }

        [JsonProperty("bandaDespachado")]
        public int BandaDespachado { get; set; }

        [JsonProperty("postCosechaId")]
        public int PostCosechaId { get; set; }

        [JsonProperty("clienteId")]
        public int ClienteId { get; set; }

        [JsonProperty("productoId")]
        public int ProductoId { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }

        [JsonProperty("marca")]
        public string Marca { get; set; }

        [JsonProperty("ecuadorProblemas")]
        public List<EcuadorProblema> EcuadorProblemas { get; set; }

        [JsonProperty("alertas")]
        public List<Alerta> Alertas { get; set; }

        [JsonProperty("detalleFirmaId")]
        public int DetalleFirmaId { get; set; }

        public AlertaSincroEcuador()
        {
            this.EcuadorProblemas = new List<EcuadorProblema>();
            this.Alertas = new List<Alerta>();
        }
    }

    public partial class Alerta
    {
        [JsonProperty("alertaEcuadorId")]
        public int AlertaEcuadorId { get; set; }

        [JsonProperty("falenciaRamosId")]
        public int FalenciaRamosId { get; set; }

        [JsonProperty("productoId")]
        public int ProductoId { get; set; }

        [JsonProperty("variedadNombre")]
        public string VariedadNombre { get; set; }

        [JsonProperty("tallosMuestra")]
        public int TallosMuestra { get; set; }

        [JsonProperty("tallosAfectados")]
        public int TallosAfectados { get; set; }
    }

    public partial class EcuadorProblema
    {
        [JsonProperty("falenciaRamosId")]
        public int FalenciaRamosId { get; set; }

        [JsonProperty("falenciaEcuadorId")]
        public int FalenciaEcuadorId { get; set; }

        [JsonProperty("tipoControlId")]
        public int TipoControlId { get; set; }

        [JsonProperty("falenciaBandaRamos")]
        public int FalenciaBandaRamos { get; set; }
    }

}
