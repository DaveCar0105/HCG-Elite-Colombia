using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Postcosecha
    {
        public Postcosecha()
        {
            Actividad = new HashSet<Actividad>();
            Controlalistamiento = new HashSet<Controlalistamiento>();
            Controlbanda = new HashSet<Controlbanda>();
            Controlboncheo = new HashSet<Controlboncheo>();
            Controlecommerce = new HashSet<Controlecommerce>();
            Controlecuador = new HashSet<Controlecuador>();
            Controlempaque = new HashSet<Controlempaque>();
            Controlramo = new HashSet<Controlramo>();
            ProcesoEmpaque = new HashSet<ProcesoEmpaque>();
            ProcesoHidratacion = new HashSet<ProcesoHidratacion>();
            Temperatura = new HashSet<Temperatura>();
        }

        public int PostcosechaId { get; set; }
        public string PostcosechaNombre { get; set; }
        public string PostcosechaApodo { get; set; }
        public int? Elite { get; set; }
        public string Codigo { get; set; }

        public ICollection<Actividad> Actividad { get; set; }
        public ICollection<Controlalistamiento> Controlalistamiento { get; set; }
        public ICollection<Controlbanda> Controlbanda { get; set; }
        public ICollection<Controlboncheo> Controlboncheo { get; set; }
        public ICollection<Controlecommerce> Controlecommerce { get; set; }
        public ICollection<Controlecuador> Controlecuador { get; set; }
        public ICollection<Controlempaque> Controlempaque { get; set; }
        public ICollection<Controlramo> Controlramo { get; set; }
        public ICollection<ProcesoEmpaque> ProcesoEmpaque { get; set; }
        public ICollection<ProcesoHidratacion> ProcesoHidratacion { get; set; }
        public ICollection<Temperatura> Temperatura { get; set; }
    }
}
