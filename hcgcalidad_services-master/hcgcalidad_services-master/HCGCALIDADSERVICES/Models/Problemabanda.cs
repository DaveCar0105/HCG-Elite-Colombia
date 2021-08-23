using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Problemabanda
    {
        public int ProblemaBandaId { get; set; }
        public int? BandaId { get; set; }
        public int? FalenciaRamoId { get; set; }
        public int? RamosNoConformes { get; set; }

        public Banda Banda { get; set; }
        public Falenciaramo FalenciaRamo { get; set; }
    }
}
