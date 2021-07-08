using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Producto
    {
        public Producto()
        {
            Alertasecuador = new HashSet<Alertasecuador>();
            Controlbanda = new HashSet<Controlbanda>();
            Controlboncheo = new HashSet<Controlboncheo>();
            Controlecuador = new HashSet<Controlecuador>();
            Controlempaque = new HashSet<Controlempaque>();
            Controlramo = new HashSet<Controlramo>();
            Problemaalistamiento = new HashSet<Problemaalistamiento>();
        }

        public int ProductoId { get; set; }
        public string ProductoNombre { get; set; }
        public int? Elite { get; set; }

        public ICollection<Alertasecuador> Alertasecuador { get; set; }
        public ICollection<Controlbanda> Controlbanda { get; set; }
        public ICollection<Controlboncheo> Controlboncheo { get; set; }
        public ICollection<Controlecuador> Controlecuador { get; set; }
        public ICollection<Controlempaque> Controlempaque { get; set; }
        public ICollection<Controlramo> Controlramo { get; set; }
        public ICollection<Problemaalistamiento> Problemaalistamiento { get; set; }
    }
}
