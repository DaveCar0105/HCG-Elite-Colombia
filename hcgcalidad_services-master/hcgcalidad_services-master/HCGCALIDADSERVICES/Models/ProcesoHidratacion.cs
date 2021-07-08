using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class ProcesoHidratacion
    {
        public int ProcesoHidratacionId { get; set; }
        public int? ProcesoHidratacionEstadoSoluciones { get; set; }
        public int? ProcesoHidratacionCantidadRamos { get; set; }
        public double? ProcesoHidratacionPhSolucion { get; set; }
        public double? ProcesoHidratacionNivelSolucion { get; set; }
        public DateTime? ProcesoHidratacionFecha { get; set; }
        public int? UsuarioControlId { get; set; }
        public int? ProcesoHidratacionTiempo { get; set; }
        public int? PostcosechaId { get; set; }

        public Postcosecha Postcosecha { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
    }
}
