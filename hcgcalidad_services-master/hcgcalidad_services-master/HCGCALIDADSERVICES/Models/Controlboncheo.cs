using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlboncheo
    {
        public Controlboncheo()
        {
            Problemaboncheo = new HashSet<Problemaboncheo>();
        }

        public int ControlBoncheoId { get; set; }
        public int? ProductoId { get; set; }
        public int? UsuarioControlId { get; set; }
        public DateTime? ControlBoncheoFecha { get; set; }
        public int? ControlBoncheoTotal { get; set; }
        public int? ControlBoncheoAprobado { get; set; }
        public double? ControlBoncheoTiempo { get; set; }
        public int? ControlBoncheoMesa { get; set; }
        public int? PostcosechaId { get; set; }
        public int? ClienteId { get; set; }
        public int? DetalleFirmaId { get; set; }

        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Producto Producto { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public ICollection<Problemaboncheo> Problemaboncheo { get; set; }
    }
}
