using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Problemasecuador
    {
        public int ProblemasEcuadorId { get; set; }
        public int? ControlEcuadorId { get; set; }
        public int? TipoControlId { get; set; }
        public int? FalenciaRamoId { get; set; }
        public int? ProblemasEcuadorRamos { get; set; }

        public Controlecuador ControlEcuador { get; set; }
        public Falenciaramo FalenciaRamo { get; set; }
        public TipoControl TipoControl { get; set; }
    }
}
