using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class ProblemaCirculoCalidad
    {
        public ProblemaCirculoCalidad()
        {
            CirculoCalidad1 = new HashSet<CirculoCalidad>();
            CirculoCalidad2 = new HashSet<CirculoCalidad>();
            CirculoCalidad3 = new HashSet<CirculoCalidad>();
            CirculoCalidad4 = new HashSet<CirculoCalidad>();
            CirculoCalidad5 = new HashSet<CirculoCalidad>();
        }
        public int ProblemaCirculoCalidadId { get; set; }
        public string ProblemaCirculoCalidadIndicador { get; set; }
        public string ProblemaCirculoCalidadCausaRelacional { get; set; }

        public ICollection<CirculoCalidad> CirculoCalidad1 { get; set; }
        public ICollection<CirculoCalidad> CirculoCalidad2 { get; set; }
        public ICollection<CirculoCalidad> CirculoCalidad3 { get; set; }
        public ICollection<CirculoCalidad> CirculoCalidad4 { get; set; }
        public ICollection<CirculoCalidad> CirculoCalidad5 { get; set; }
    }
}
