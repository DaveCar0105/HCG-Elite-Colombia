using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Falenciascontrolramo
    {
        public int FalenciasControlRamoId { get; set; }
        public int? RamoId { get; set; }
        public int FalenciaRamoId { get; set; }
        public int? FalenciaControlRamoCantidad { get; set; }

        public Falenciaramo FalenciaRamo { get; set; }
        public Ramo Ramo { get; set; }
    }
}
