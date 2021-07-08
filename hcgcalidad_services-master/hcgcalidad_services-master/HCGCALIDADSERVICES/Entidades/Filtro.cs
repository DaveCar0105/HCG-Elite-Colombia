using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Entidades
{
    public class Filtro
    {
        public int tipo { get; set; }
        public DateTime fecha_desde { get; set; }
        public DateTime fecha_hasta { get; set; }
    }
    public class Control
    {
        public int id { get; set; }
    }
    public class EntFiltro
    {
        public DateTime fecha_desde { get; set; }
        public DateTime fecha_hasta { get; set; }
    }
}
