using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Temperatura
    {
        public int TemperaturaId { get; set; }
        public int? UsuarioControlId { get; set; }
        public double? TemperaturaInterna1 { get; set; }
        public double? TemperaturaInterna2 { get; set; }
        public double? TemperaturaInterna3 { get; set; }
        public double? TemperaturaExterna { get; set; }
        public DateTime? TemperaturaFecha { get; set; }
        public int? PostcosechaId { get; set; }

        public Postcosecha Postcosecha { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
    }
}
