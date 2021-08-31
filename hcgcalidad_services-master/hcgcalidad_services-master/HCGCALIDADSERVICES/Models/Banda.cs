using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Banda
    {
        public Banda()
        {
            Falenciascontrolbanda = new HashSet<Problemabanda>();
        }

        public int BandaId { get; set; }

        public string NumeroMesa { get; set; }
        public string Variedad { get; set; }
        public string Linea { get; set; }

        public int ControlBandaId { get; set; }

        public Controlbanda ControlBanda { get; set; }
        public ICollection<Problemabanda> Falenciascontrolbanda { get; set; }
    }
}
