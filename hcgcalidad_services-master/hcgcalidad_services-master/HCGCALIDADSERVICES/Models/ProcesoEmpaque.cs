using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class ProcesoEmpaque
    {
        public int ProcesoEmpaqueId { get; set; }
        public int? ProcesoEmpaqueAltura { get; set; }
        public int? ProcesoEmpaqueCajas { get; set; }
        public int? ProcesoEmpaqueSujeccion { get; set; }
        public int? ProcesoEmpaqueMovimientos { get; set; }
        public int? ProcesoEmpaqueTemperaturaCuartoFrio { get; set; }
        public int? ProcesoEmpaqueTemperaturaCajas { get; set; }
        public int? ProcesoEmpaqueTemperaturaCamion { get; set; }
        public int? ProcesoEmpaqueApilamiento { get; set; }
        public DateTime? ProcesoEmpaqueFecha { get; set; }
        public int? UsuarioControlId { get; set; }
        public int? PostcosechaId { get; set; }

        public Postcosecha Postcosecha { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
    }
}
