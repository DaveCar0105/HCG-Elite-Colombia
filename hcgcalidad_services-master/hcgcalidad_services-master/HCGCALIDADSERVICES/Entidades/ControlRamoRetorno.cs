using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Entidades
{
    public class ControlRamoRetorno
    {
        public string semana { get; set; }
        public string mes { get; set; }
        public DateTime fecha { get; set; }
        public string macroCliente { get; set; }
        public string cliente { get; set; }
        public string postCosecha { get; set; }
        public string producto { get; set; }
        public string noOrden { get; set; }
        public string marca { get; set; }
        public int tallos { get; set; }
        public int ramosDespacho { get; set; }
        public int ramosElaborados { get; set; }
        public int ramosRevisados { get; set; }
        public string atendidoPor { get; set; }
        public string qc { get; set; }
        public string derogacion { get; set; }
        public string derogadoPor { get; set; }
        public List<ControlRamoDetalleRetorno> detalles { get; set; }

        public ControlRamoRetorno()
        {
            detalles = new List<ControlRamoDetalleRetorno>();
        }

    }
    public class ControlRamoDetalleRetorno
    {
        public string semana { get; set; }
        public string mes { get; set; }
        public DateTime fecha { get; set; }
        public string macroCliente { get; set; }
        public string cliente { get; set; }
        public string postCosecha { get; set; }
        public string producto { get; set; }
        public string noOrden { get; set; }
        public string marca { get; set; }
        public string indicador { get; set; }
        public string macroCausa { get; set; }
        public string codigoItem { get; set; }
        public string microCause { get; set; }
        public int nroRamos { get; set; }
        public int nroRamosTotal { get; set; }

    }
}
