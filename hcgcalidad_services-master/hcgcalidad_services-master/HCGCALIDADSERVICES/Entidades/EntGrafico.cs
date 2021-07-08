namespace HCGCALIDADSERVICES.Entidades
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class EntGrafico
    {
        [JsonProperty("data")]
        public Data Data { get; set; }
        public EntGrafico()
        {
            this.Data = new Data();
        }
    }

    public partial class Data
    {
        [JsonProperty("Ramos a despachar")]
        public int RamosADespachar { get; set; }

        [JsonProperty("Ramos elaborados")]
        public int RamosElaborados { get; set; }

        [JsonProperty("Ramos revisados")]
        public int RamosRevisados { get; set; }

        [JsonProperty("Ramos no conformes")]
        public int RamosNoConformes { get; set; }

        [JsonProperty("postcosechas")]
        public List<Cliente> Postcosechas { get; set; }

        [JsonProperty("producto")]
        public List<Cliente> Producto { get; set; }

        [JsonProperty("cliente")]
        public List<Cliente> Cliente { get; set; }

        [JsonProperty("MacroFalencia")]
        public List<MacroFalencia> MacroFalencia { get; set; }

        public Data()
        {
            this.Postcosechas = new List<Cliente>();
            this.Producto = new List<Cliente>();
            this.Cliente = new List<Cliente>();
            this.MacroFalencia = new List<MacroFalencia>();
        }
    }

    public partial class Cliente
    {
        [JsonProperty("nombre")]
        public string Nombre { get; set; }

        [JsonProperty("% no conforme")]
        public decimal NoConforme { get; set; }
    }

    public partial class MacroFalencia
    {
        [JsonProperty("nombre")]
        public string Nombre { get; set; }

        [JsonProperty("cantidad")]
        public int Cantidad { get; set; }

        [JsonProperty("Falencias")]
        public List<Falencia> Falencias { get; set; }
        public MacroFalencia()
        {
            this.Falencias = new List<Falencia>();
        }
    }

    public partial class Falencia
    {
        [JsonProperty("nombre")]
        public string Nombre { get; set; }

        [JsonProperty("cantidad")]
        public int Cantidad { get; set; }
    }
}
