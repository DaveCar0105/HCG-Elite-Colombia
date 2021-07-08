using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Problemabanda
    {
        public int ProblemaBandaId { get; set; }
        public int? ControlBandaId { get; set; }
        public int? FalenciaRamoId { get; set; }
        public int? RamosNoConformes { get; set; }

        public Controlbanda ControlBanda { get; set; }
        public Falenciaramo FalenciaRamo { get; set; }
    }
}
