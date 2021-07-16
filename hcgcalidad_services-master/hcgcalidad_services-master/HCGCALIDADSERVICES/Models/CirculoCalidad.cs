using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class CirculoCalidad
    {
        public int CirculoCalidadId { get; set; }
        public int RamosRevisados { get; set; }
        public int RamosRechazados { get; set; }
        public int ReunionCalidad { get; set; }

        public int? ProblemaCirculoCalidadId1 { get; set; }
        public int? ProblemaCirculoCalidadId2 { get; set; }
        public int? ProblemaCirculoCalidadId3 { get; set; }
        public int? ProblemaCirculoCalidadId4 { get; set; }
        public int? ProblemaCirculoCalidadId5 { get; set; }

        public int? ClienteId1 { get; set; }
        public int? ClienteId2 { get; set; }
        public int? ProductoId1 { get; set; }
        public int? ProductoId2 { get; set; }

        public string Variedad1 { get; set; }
        public string Variedad2 { get; set; }
        public string CodigoMesa { get; set; }
        public int Linea { get; set; }
        public string Supervisor1 { get; set; }
        public string Supervisor2 { get; set; }
        public string EvaluacionSupervisor1 { get; set; }
        public string EvaluacionSupervisor2 { get; set; }

        public string Comentarios { get; set; }

        public ProblemaCirculoCalidad ProblemaCirculoCalidad1 { get; set; }
        public ProblemaCirculoCalidad ProblemaCirculoCalidad2 { get; set; }
        public ProblemaCirculoCalidad ProblemaCirculoCalidad3 { get; set; }
        public ProblemaCirculoCalidad ProblemaCirculoCalidad4 { get; set; }
        public ProblemaCirculoCalidad ProblemaCirculoCalidad5 { get; set; }

        public Cliente Cliente1 { get; set; }
        public Cliente Cliente2 { get; set; }
        public Producto Producto1 { get; set; }
        public Producto Producto2 { get; set; }


    }
}
