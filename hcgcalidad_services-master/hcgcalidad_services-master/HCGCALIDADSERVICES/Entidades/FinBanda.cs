namespace HCGCALIDADSERVICES.Entidades
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;
    public partial class ReporteSincronizacionBanda
    {
        [JsonProperty("firmas")]
        public List<Firma> Firmas { get; set; }
        [JsonProperty("detallesFirma")]
        public List<DetallesFirma> DetallesFirma { get; set; }
        [JsonProperty("listaBanda")]
        public List<FinBanda> ListaBanda { get; set; }
    }
    public partial class FinBanda
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

        [JsonProperty("bandaProblemas")]
        public List<BandaProblema> BandaProblemas { get; set; }

        [JsonProperty("tipoId")]
        public int TipoId { get; set; }
        [JsonProperty("detalleFirmaId")]
        public int DetalleFirmaId { get; set; }
    }

    public partial class BandaProblema
    {
        [JsonProperty("falenciaRamosId")]
        public int FalenciaRamosId { get; set; }

        [JsonProperty("falenciaBandaId")]
        public int FalenciaBandaId { get; set; }

        [JsonProperty("falenciaBandaRamos")]
        public int FalenciaBandaRamos { get; set; }
    }
}
