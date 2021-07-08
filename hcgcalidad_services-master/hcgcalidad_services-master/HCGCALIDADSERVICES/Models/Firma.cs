using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Firma
    {
        public Firma()
        {
            DetalleFirma = new HashSet<DetalleFirma>();
        }

        public int FirmaId { get; set; }
        public string FirmaNombre { get; set; }
        public string FirmaCargo { get; set; }
        public string FirmaCodigo { get; set; }
        public string FirmaCorreo { get; set; }
        public int? Repetido { get; set; }

        public ICollection<DetalleFirma> DetalleFirma { get; set; }
    }
}
