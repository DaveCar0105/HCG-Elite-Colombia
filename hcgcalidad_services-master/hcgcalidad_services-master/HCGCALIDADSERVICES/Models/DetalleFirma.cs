using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class DetalleFirma
    {
        public DetalleFirma()
        {
            Controlalistamiento = new HashSet<Controlalistamiento>();
            Controlbanda = new HashSet<Controlbanda>();
            Controlboncheo = new HashSet<Controlboncheo>();
            Controlecommerce = new HashSet<Controlecommerce>();
            Controlecuador = new HashSet<Controlecuador>();
            Controlempaque = new HashSet<Controlempaque>();
            Controlramo = new HashSet<Controlramo>();
        }

        public int DetalleFirmaId { get; set; }
        public int FirmaId { get; set; }
        public string DetalleFirmaCodigo { get; set; }

        public Firma Firma { get; set; }
        public ICollection<Controlalistamiento> Controlalistamiento { get; set; }
        public ICollection<Controlbanda> Controlbanda { get; set; }
        public ICollection<Controlboncheo> Controlboncheo { get; set; }
        public ICollection<Controlecommerce> Controlecommerce { get; set; }
        public ICollection<Controlecuador> Controlecuador { get; set; }
        public ICollection<Controlempaque> Controlempaque { get; set; }
        public ICollection<Controlramo> Controlramo { get; set; }
    }
}
