using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlecommerce
    {
        public Controlecommerce()
        {
            Checkecommerce = new HashSet<Checkecommerce>();
        }

        public int ControlEcommerceId { get; set; }
        public int? PostcosechaId { get; set; }
        public DateTime? ControlEcommerceFecha { get; set; }
        public int? ControlEcommerceTurno { get; set; }
        public int? UsuarioControlId { get; set; }
        public int? DetalleFirmaId { get; set; }

        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public ICollection<Checkecommerce> Checkecommerce { get; set; }
    }
}
