using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Alertasecuador
    {
        public int AlertaEcuadorId { get; set; }
        public int? ProductoId { get; set; }
        public string VariedadNombre { get; set; }
        public int? TallosMuestra { get; set; }
        public int? TallosAfectados { get; set; }
        public int? ControlEcuadorId { get; set; }
        public int? FalenciaRamoId { get; set; }

        public Controlecuador ControlEcuador { get; set; }
        public Falenciaramo FalenciaRamo { get; set; }
        public Producto Producto { get; set; }
    }
}
