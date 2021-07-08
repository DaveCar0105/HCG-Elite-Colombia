using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlempaque
    {
        public Controlempaque()
        {
            Empaque = new HashSet<Empaque>();
        }

        public int ControlEmpaqueId { get; set; }
        public int? DetalleFirmaId { get; set; }
        public int? UsuarioControlId { get; set; }
        public int? ProductoId { get; set; }
        public DateTime? ControlEmpaqueFecha { get; set; }
        public int? ControlEmpaqueTotal { get; set; }
        public int? ControlEmpaqueAprobado { get; set; }
        public double? ControlEmpaqueTiempo { get; set; }
        public string ControlEmpaqueDerogado { get; set; }
        public int? ControlEmpaqueRamosRevisar { get; set; }
        public int? ControlEmpaqueTallos { get; set; }
        public int? PostcosechaId { get; set; }
        public string Marca { get; set; }
        public int? ClienteId { get; set; }
        public int? ControlEmpaqueDespachar { get; set; }
        public int? ControlEmpaqueRamosCaja { get; set; }
        public string ClienteMacro { get; set; }
        public string ControlEmpaqueNumeroOrden { get; set; }

        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Producto Producto { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public ICollection<Empaque> Empaque { get; set; }
    }
}
