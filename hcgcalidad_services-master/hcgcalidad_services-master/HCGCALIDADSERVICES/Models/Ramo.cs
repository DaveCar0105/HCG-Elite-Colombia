using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Ramo
    {
        public Ramo()
        {
            Falenciascontrolramo = new HashSet<Falenciascontrolramo>();
        }

        public int RamoId { get; set; }
        public int ControlRamoId { get; set; }

        public Controlramo ControlRamo { get; set; }
        public ICollection<Falenciascontrolramo> Falenciascontrolramo { get; set; }
    }
}
