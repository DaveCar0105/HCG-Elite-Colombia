using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Problemaalistamiento
    {
        public int ProblemaAlistamientoId { get; set; }
        public int? FalenciaRamoId { get; set; }
        public int? ProductoId { get; set; }
        public string VariedadNombre { get; set; }
        public int? TallosMuestra { get; set; }
        public int? TallosAfectados { get; set; }

        public Falenciaramo FalenciaRamo { get; set; }
        public Producto Producto { get; set; }
    }
}
