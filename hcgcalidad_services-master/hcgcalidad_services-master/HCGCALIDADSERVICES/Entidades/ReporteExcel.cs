namespace HCGCALIDADSERVICES.Entidades
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class ReporteExcel
    {
        [JsonProperty("baseRamos")]
        public List<BaseRamo> BaseRamos { get; set; }

        [JsonProperty("baseCajas")]
        public List<BaseCaja> BaseCajas { get; set; }

        [JsonProperty("problemasRamoEmpaque")]
        public List<BaseTotalRamo> ProblemasRamoEmpaque { get; set; }

        [JsonProperty("baseTotalRamos")]
        public List<BaseTotalRamo> BaseTotalRamos { get; set; }

        [JsonProperty("chlHidratacion")]
        public List<ChlEmpaque> ChlHidratacion { get; set; }

        [JsonProperty("chlEmpaque")]
        public List<ChlEmpaque> ChlEmpaque { get; set; }

        [JsonProperty("actividadesQC")]
        public List<ActividadesQc> ActividadesQc { get; set; }

        [JsonProperty("temperaturas")]
        public List<ChlEmpaque> Temperaturas { get; set; }

        public ReporteExcel()
        {
            this.BaseRamos = new List<BaseRamo>();
            this.BaseCajas = new List<BaseCaja>();
            this.ProblemasRamoEmpaque = new List<BaseTotalRamo>();
            this.BaseTotalRamos = new List<BaseTotalRamo>();
            this.ChlHidratacion = new List<ChlEmpaque>();
            this.ChlEmpaque = new List<ChlEmpaque>();
            this.ActividadesQc = new List<ActividadesQc>();
            this.Temperaturas = new List<ChlEmpaque>();
        }
    }

    public partial class ActividadesQc
    {
        /*[JsonProperty("semana")]
        public string Semana { get; set; }

        [JsonProperty("mes")]
        public string Mes { get; set; }*/

        [JsonProperty("fecha")]
        public string Fecha { get; set; }

        [JsonProperty("postCosecha")]
        public string PostCosecha { get; set; }

        [JsonProperty("codigoQC")]
        public string CodigoQc { get; set; }

        [JsonProperty("actividad")]
        public string Actividad { get; set; }

        [JsonProperty("tiempo")]
        public decimal Tiempo { get; set; }
    }

    public partial class BaseCaja
    {/*
        [JsonProperty("semana")]
        public string Semana { get; set; }

        [JsonProperty("mes")]
        public string Mes { get; set; }*/

        [JsonProperty("fecha")]
        public string Fecha { get; set; }

        [JsonProperty("clienteMacro")]
        public string ClienteMacro { get; set; }

        [JsonProperty("cliente")]
        public string Cliente { get; set; }

        [JsonProperty("postCosecha")]
        public string PostCosecha { get; set; }

        [JsonProperty("producto")]
        public string Producto { get; set; }

        [JsonProperty("ordenNo")]
        public string OrdenNo { get; set; }

        [JsonProperty("marca")]
        public string Marca { get; set; }

        [JsonProperty("ramosCaja")]
        public int RamosCaja { get; set; }

        [JsonProperty("tallosRamo")]
        public int TallosRamo { get; set; }

        [JsonProperty("cajasDespachar")]
        public int CajasDespachar { get; set; }

        [JsonProperty("inspeccionado")]
        public decimal Inspeccionado { get; set; }

        [JsonProperty("cajasRevisadas")]
        public int CajasRevisadas { get; set; }

        [JsonProperty("cajasNoConformes")]
        public int CajasNoConformes { get; set; }

        [JsonProperty("porcentajeNoConformes")]
        public decimal PorcentajeNoConformes { get; set; }

        [JsonProperty("Qc")]
        public string Qc { get; set; }
    }

    public partial class BaseRamo
    {/*
        [JsonProperty("semana")]
        public string Semana { get; set; }

        [JsonProperty("mes")]
        public string Mes { get; set; }*/

        [JsonProperty("fecha")]
        public string Fecha { get; set; }

        [JsonProperty("clienteMacro")]
        public string ClienteMacro { get; set; }

        [JsonProperty("cliente")]
        public string Cliente { get; set; }

        [JsonProperty("postCosecha")]
        public string PostCosecha { get; set; }

        [JsonProperty("producto")]
        public string Producto { get; set; }

        [JsonProperty("ordenNo")]
        public string OrdenNo { get; set; }

        [JsonProperty("marca")]
        public string Marca { get; set; }

        [JsonProperty("tipo")]
        public string Tipo { get; set; }

        [JsonProperty("tallos")]
        public int Tallos { get; set; }

        [JsonProperty("ramosDespachar")]
        public int RamosDespachar { get; set; }

        [JsonProperty("ramosElaborados")]
        public int RamosElaborados { get; set; }

        [JsonProperty("inspeccionado")]
        public decimal Inspeccionado { get; set; }

        [JsonProperty("ramosRevisados")]
        public int RamosRevisados { get; set; }

        [JsonProperty("ramosNoConformes")]
        public int RamosNoConformes { get; set; }

        [JsonProperty("porcentajeNoConformes")]
        public decimal PorcentajeNoConformes { get; set; }

        [JsonProperty("ramosConformes")]
        public int RamosConformes { get; set; }

        [JsonProperty("tallosRevisados")]
        public int TallosRevisados { get; set; }

        [JsonProperty("porcentajeConformidad")]
        public decimal PorcentajeConformidad { get; set; }

        [JsonProperty("atendidoPor")]
        public string AtendidoPor { get; set; }

        [JsonProperty("qc")]
        public string Qc { get; set; }

        [JsonProperty("derrogacion")]
        public bool Derrogacion { get; set; }

        [JsonProperty("derrogadoPor")]
        public string DerrogadoPor { get; set; }
    }

    public partial class BaseTotalRamo
    {/*
        [JsonProperty("semana")]
        public string Semana { get; set; }

        [JsonProperty("mes")]
        public string Mes { get; set; }*/

        [JsonProperty("fecha")]
        public string Fecha { get; set; }

        [JsonProperty("clienteMacro")]
        public string ClienteMacro { get; set; }

        [JsonProperty("cliente")]
        public string Cliente { get; set; }

        [JsonProperty("postCosecha")]
        public string PostCosecha { get; set; }

        [JsonProperty("producto")]
        public string Producto { get; set; }

        [JsonProperty("ordenNo")]
        public string OrdenNo { get; set; }

        [JsonProperty("marca")]
        public string Marca { get; set; }

        [JsonProperty("indicador")]
        public string Indicador { get; set; }

        [JsonProperty("causa")]
        public string Causa { get; set; }

        [JsonProperty("codigoItem")]
        public string CodigoItem { get; set; }

        [JsonProperty("causaRelacionada")]
        public string CausaRelacionada { get; set; }

        [JsonProperty("totalRamosCajas", NullValueHandling = NullValueHandling.Ignore)]
        public int? TotalRamosCajas { get; set; }

        [JsonProperty("tipo")]
        public string Tipo { get; set; }

        [JsonProperty("repeticion", NullValueHandling = NullValueHandling.Ignore)]
        public int? Repeticion { get; set; }
    }

    public partial class ChlEmpaque
    {/*
        [JsonProperty("semana")]
        public string Semana { get; set; }

        [JsonProperty("mes")]
        public string Mes { get; set; }*/

        [JsonProperty("fecha")]
        public string Fecha { get; set; }

        [JsonProperty("postCosecha")]
        public string PostCosecha { get; set; }

        [JsonProperty("itemControl")]
        public string ItemControl { get; set; }

        [JsonProperty("cumple", NullValueHandling = NullValueHandling.Ignore)]
        public bool? Cumple { get; set; }

        [JsonProperty("valor", NullValueHandling = NullValueHandling.Ignore)]
        public decimal? Valor { get; set; }
    }
}
