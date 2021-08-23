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
        [JsonProperty("listaRamo")]
        public List<FinBanda> ListaBanda { get; set; }
    }
    public partial class FinBanda
    {
        [JsonProperty("controlRamosId")]
        public int ControlBandaId { get; set; }

        [JsonProperty("ramosNumeroOrden")]
        public string ControlNumeroOrden { get; set; }

        [JsonProperty("ramosTotal")]
        public int BandaRamos { get; set; }

        [JsonProperty("ramosFecha")]
        public DateTime BandaFecha { get; set; }

        [JsonProperty("detalleFirmaId")]
        public int DetalleFirmaId { get; set; }

        [JsonProperty("clienteId")]
        public int ClienteId { get; set; }

        [JsonProperty("productoId")]
        public int ProductoId { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }

        [JsonProperty("ramosTallos")]
        public int BandaTallos { get; set; }

        [JsonProperty("ramosDespachar")]
        public int BandaDespachado { get; set; }

        [JsonProperty("ramosElaborados")]
        public int BandaElaborado { get; set; }

        [JsonProperty("ramosDerogado")]
        public string BandaDerogado { get; set; }

        [JsonProperty("ramosTiempo")]
        public double RamosTiempo { get; set; }

        [JsonProperty("postcosechaId")]
        public int PostCosechaId { get; set; }

        [JsonProperty("ramosMarca")]
        public string Marca { get; set; }

        [JsonProperty("tipoId")]
        public int TipoId { get; set; }

        [JsonProperty("bandas")]
        public List<Banda> Bandas { get; set; }

    }


    public partial class Banda
    {
        [JsonProperty("controlRamosId")]
        public int ControlRamosId { get; set; }

        [JsonProperty("bandaId")]
        public int BandaId { get; set; }

        [JsonProperty("falencias")]
        public List<BandaProblema> Falencias { get; set; }
    }

    public partial class BandaProblema
    {
        [JsonProperty("falenciaBandaId")]
        public int FalenciaBandaId { get; set; }

        [JsonProperty("falenciaRamoId")]
        public int FalenciaRamosId { get; set; }

        [JsonProperty("falenciaBandaRamos")]
        public int FalenciaBandaRamos { get; set; }
    }
}
