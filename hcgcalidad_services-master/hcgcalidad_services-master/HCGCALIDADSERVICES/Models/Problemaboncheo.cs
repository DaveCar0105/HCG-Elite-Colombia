using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Problemaboncheo
    {
        public int ProblemaBoncheoId { get; set; }
        public int? ControlBoncheoId { get; set; }
        public int? FalenciaRamoId { get; set; }
        public int? RamosNoConformes { get; set; }

        public Controlboncheo ControlBoncheo { get; set; }
        public Falenciaramo FalenciaRamo { get; set; }
    }
}
