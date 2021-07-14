using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public partial class TipoActividad
    {
        public TipoActividad()
        {
            Actividad = new HashSet<Actividad>();
        }

        public int TipoActividadId { get; set; }
        public string TipoActividadDescripcion { get; set; }

        public ICollection<Actividad> Actividad { get; set; }
    }
}
