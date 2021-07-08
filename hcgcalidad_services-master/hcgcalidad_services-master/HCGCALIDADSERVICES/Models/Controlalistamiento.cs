using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlalistamiento
    {
        public int ControlAlistamientoId { get; set; }
        public int? UsuarioControlId { get; set; }
        public DateTime? ControlAlistamientoFecha { get; set; }
        public int? ControlAlistamientoTotal { get; set; }
        public int? ControlAlistamientoAprobado { get; set; }
        public int? PostcosechaId { get; set; }
        public int? ClienteId { get; set; }
        public int? TipoControlId { get; set; }
        public int? DetalleFirmaId { get; set; }

        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public TipoControl TipoControl { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
    }
}
