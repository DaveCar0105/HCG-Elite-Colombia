using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class TipoControl
    {
        public TipoControl()
        {
            Controlalistamiento = new HashSet<Controlalistamiento>();
            Controlbanda = new HashSet<Controlbanda>();
            Problemasecuador = new HashSet<Problemasecuador>();
        }

        public int TipoControlId { get; set; }
        public string TipoControlNombre { get; set; }
        public int? ClaseControl { get; set; }

        public ICollection<Controlalistamiento> Controlalistamiento { get; set; }
        public ICollection<Controlbanda> Controlbanda { get; set; }
        public ICollection<Problemasecuador> Problemasecuador { get; set; }
    }
}
