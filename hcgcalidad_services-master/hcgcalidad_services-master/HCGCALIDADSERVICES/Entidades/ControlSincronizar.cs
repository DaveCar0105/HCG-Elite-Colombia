namespace HCGCALIDADSERVICES.Entidades
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class ReporteSincronizacion
    {
        [JsonProperty("firmas")]
        public List<Firma> Firmas { get; set; }
        [JsonProperty("detallesFirma")]
        public List<DetallesFirma> DetallesFirma { get; set; }
        [JsonProperty("listaEmpaque")]
        public List<ListaEmpaque> ListaEmpaque { get; set; }
    }
    public partial class ReporteSincronizacionRamos
    {
        [JsonProperty("firmas")]
        public List<Firma> Firmas { get; set; }
        [JsonProperty("detallesFirma")]
        public List<DetallesFirma> DetallesFirma { get; set; }
        [JsonProperty("listaRamo")]
        public List<ListaRamo> ListaRamo { get; set; }
    }

    public partial class Actividade
    {
        [JsonProperty("actividadUsuarioControlId")]
        public int ActividadUsuarioControlId { get; set; }

        [JsonProperty("actividadDetalle")]
        public string ActividadDetalle { get; set; }

        [JsonProperty("actividadHoraInicio")]
        public string ActividadHoraInicio { get; set; }

        [JsonProperty("actividadHoraFin")]
        public string ActividadHoraFin { get; set; }

        [JsonProperty("actividadFecha")]
        public string ActividadFecha { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }
        [JsonProperty("postcosechaId")]
        public int PostcosechaId { get; set; }
    }

    public partial class DetallesFirma
    {
        [JsonProperty("detalleFirmaId")]
        public int DetalleFirmaId { get; set; }

        [JsonProperty("firmaId")]
        public int FirmaId { get; set; }

        [JsonProperty("firmaReal")]
        public int FirmaReal { get; set; }

        [JsonProperty("firmaCodigo")]
        public string FirmaCodigo { get; set; }
    }

    public partial class Firma
    {
        [JsonProperty("firmaId")]
        public int FirmaId { get; set; }

        [JsonProperty("firmaReal")]
        public int FirmaReal { get; set; }

        [JsonProperty("firmaNombre")]
        public string FirmaNombre { get; set; }

        [JsonProperty("firmaCargo")]
        public string FirmaCargo { get; set; }

        [JsonProperty("firmaCorreo")]
        public string FirmaCorreo { get; set; }

        [JsonProperty("firmaCodigo")]
        public string FirmaCodigo { get; set; }
    }

    public partial class ListaEmpaque
    {
        [JsonProperty("controlEmpaqueId")]
        public int ControlEmpaqueId { get; set; }


        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }

        [JsonProperty("empaqueNumeroOrden")]
        public string EmpaqueNumeroOrden { get; set; }

        [JsonProperty("empaqueTotal")]
        public int EmpaqueTotal { get; set; }

        [JsonProperty("clienteId")]
        public int ClienteId { get; set; }

        [JsonProperty("postcosechaId")]
        public int PostcosechaId { get; set; }

        [JsonProperty("productoId")]
        public int ProductoId { get; set; }

        [JsonProperty("empaqueDerogado")]
        public string EmpaqueDerogado { get; set; }

        [JsonProperty("empaqueDespachar")]
        public int EmpaqueDespachar { get; set; }

        [JsonProperty("empaqueRamos")]
        public int EmpaqueRamos { get; set; }

        [JsonProperty("empaqueTallos")]
        public int EmpaqueTallos { get; set; }

        [JsonProperty("empaqueFecha")]
        public string EmpaqueFecha { get; set; }

        [JsonProperty("detalleFirmaId")]
        public int DetalleFirmaId { get; set; }

        [JsonProperty("empaqueMarca ")]
        public string EmpaqueMarca { get; set; }

        [JsonProperty("ramosRevisar ")]
        public int RamosRevisar { get; set; }

        [JsonProperty("empaqueTiempo")]
        public double EmpaqueTiempo { get; set; }

        [JsonProperty("empaqueRamosRevisar")]
        public int EmpaqueRamosRevisar { get; set; }


        [JsonProperty("empaques")]
        public List<Empaque> Empaques { get; set; }
    }

    public partial class Empaque
    {
        [JsonProperty("controlEmpaqueId")]
        public int ControlEmpaqueId { get; set; }

        [JsonProperty("empaqueId")]
        public int EmpaqueId { get; set; }

        [JsonProperty("numeroMesa")]
        public string NumeroMesa { get; set; }

        [JsonProperty("variedad")]
        public string Variedad { get; set; }

        [JsonProperty("codigoEmpacador")]
        public string CodigoEmpacador { get; set; }

        [JsonProperty("linea")]
        public string Linea { get; set; }

        [JsonProperty("falencias")]
        public List<EmpaqueFalencia> Falencias { get; set; }
    }

    public partial class EmpaqueFalencia
    {
        [JsonProperty("falenciaReporteEmpaqueId")]
        public int FalenciaReporteEmpaqueId { get; set; }

        [JsonProperty("falenciaEmpaqueId")]
        public int FalenciaEmpaqueId { get; set; }

        [JsonProperty("cantidad")]
        public int Cantidad { get; set; }
    }

    public partial class ListaRamo
    {
        [JsonProperty("controlRamosId")]
        public int ControlRamosId { get; set; }

        [JsonProperty("ramosNumeroOrden")]
        public string RamosNumeroOrden { get; set; }

        [JsonProperty("ramosTotal")]
        public int RamosTotal { get; set; }

        [JsonProperty("ramosFecha")]
        public string RamosFecha { get; set; }

        [JsonProperty("detalleFirmaId")]
        public int DetalleFirmaId { get; set; }

        [JsonProperty("clienteId")]
        public int ClienteId { get; set; }

        [JsonProperty("productoId")]
        public int ProductoId { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }

        [JsonProperty("ramosTallos")]
        public int RamosTallos { get; set; }

        [JsonProperty("ramosDespachar")]
        public int RamosDespachar { get; set; }

        [JsonProperty("ramosElaborados")]
        public int RamosElaborados { get; set; }

        [JsonProperty("ramosDerogado")]
        public string RamosDerogado { get; set; }

        [JsonProperty("ramosTiempo")]
        public double RamosTiempo { get; set; }

        [JsonProperty("postcosechaId")]
        public int PostcosechaId { get; set; }

        [JsonProperty("ramosMarca")]
        public string RamosMarca { get; set; }


        [JsonProperty("ramos")]
        public List<Ramo> Ramos { get; set; }
    }

    public partial class Ramo
    {
        [JsonProperty("controlRamosId")]
        public int ControlRamosId { get; set; }

        [JsonProperty("ramoId")]
        public int RamoId { get; set; }

        [JsonProperty("numeroMesa")]
        public string NumeroMesa { get; set; }

        [JsonProperty("variedad")]
        public string Variedad { get; set; }

        [JsonProperty("linea")]
        public string Linea { get; set; }

        [JsonProperty("falencias")]
        public List<RamoFalencia> Falencias { get; set; }
    }

    public partial class RamoFalencia
    {
        [JsonProperty("falenciaReporteRamoId")]
        public int FalenciaReporteRamoId { get; set; }

        [JsonProperty("falenciaRamoId")]
        public int FalenciaRamoId { get; set; }

        [JsonProperty("cantidad")]
        public int Cantidad { get; set; }
    }

    public partial class ProcesoEmpaque
    {
        [JsonProperty("procesoEmpaqueUsuarioControlId")]
        public int ProcesoEmpaqueUsuarioControlId { get; set; }

        [JsonProperty("procesoEmpaqueAltura")]
        public int ProcesoEmpaqueAltura { get; set; }

        [JsonProperty("procesoEmpaqueCajas")]
        public int ProcesoEmpaqueCajas { get; set; }

        [JsonProperty("procesoEmpaqueSujeccion")]
        public int ProcesoEmpaqueSujeccion { get; set; }

        [JsonProperty("procesoEmpaqueMovimientos")]
        public int ProcesoEmpaqueMovimientos { get; set; }

        [JsonProperty("procesoEmpaqueTemperaturaCuartoFrio")]
        public int ProcesoEmpaqueTemperaturaCuartoFrio { get; set; }

        [JsonProperty("procesoEmpaqueTemperaturaCajas")]
        public int ProcesoEmpaqueTemperaturaCajas { get; set; }

        [JsonProperty("procesoEmpaqueTemperaturaCamion")]
        public int ProcesoEmpaqueTemperaturaCamion { get; set; }

        [JsonProperty("procesoEmpaqueApilamiento")]
        public int ProcesoEmpaqueApilamiento { get; set; }

        [JsonProperty("procesoEmpaqueFecha")]
        public string ProcesoEmpaqueFecha { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }
        [JsonProperty("postcosechaId")]
        public int PostcosechaId { get; set; }
    }

    public partial class RegistroHidratacion
    {
        [JsonProperty("procesoHidratacionUsuarioControlId")]
        public int ProcesoHidratacionUsuarioControlId { get; set; }

        [JsonProperty("procesoHidratacionEstadoSoluciones")]
        public int ProcesoHidratacionEstadoSoluciones { get; set; }

        [JsonProperty("procesoHidratacionTiemposHidratacion")]
        public int ProcesoHidratacionTiemposHidratacion { get; set; }

        [JsonProperty("procesoHidratacionCantidadRamos")]
        public int ProcesoHidratacionCantidadRamos { get; set; }

        [JsonProperty("procesoHidratacionPhSolucion")]
        public double ProcesoHidratacionPhSolucion { get; set; }

        [JsonProperty("procesoHidratacionNivelSolucion")]
        public double ProcesoHidratacionNivelSolucion { get; set; }

        [JsonProperty("procesoHidratacionFecha")]
        public string ProcesoHidratacionFecha { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }
        [JsonProperty("postcosechaId")]
        public int PostcosechaId { get; set; }
    }

    public partial class RegistroTemperatura
    {
        [JsonProperty("temperaturaUsuarioControlId")]
        public int TemperaturaUsuarioControlId { get; set; }

        [JsonProperty("temperaturaInterna")]
        public double TemperaturaInterna { get; set; }

        [JsonProperty("temperaturaExterna")]
        public double TemperaturaExterna { get; set; }

        [JsonProperty("temperaturaFecha")]
        public string TemperaturaFecha { get; set; }

        [JsonProperty("usuarioId")]
        public int UsuarioId { get; set; }
        [JsonProperty("postcosechaId")]
        public int PostcosechaId { get; set; }
    }
}
