using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Actividad
    {
        public int ActividadId { get; set; }
        public string ActividadDetalle { get; set; }
        public string ActividadHoraInicio { get; set; }
        public string ActividadHoraFin { get; set; }
        public DateTime? ActividadFecha { get; set; }
        public int? UsuarioControlId { get; set; }
        public int? PostcosechaId { get; set; }
        public int? TipoActividadId { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public TipoActividad TipoActividad { get; set; }

    }
}
