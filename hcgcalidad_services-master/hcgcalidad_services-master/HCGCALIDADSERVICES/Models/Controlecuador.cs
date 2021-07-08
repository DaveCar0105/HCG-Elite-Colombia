using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlecuador
    {
        public Controlecuador()
        {
            Alertasecuador = new HashSet<Alertasecuador>();
            Problemasecuador = new HashSet<Problemasecuador>();
        }

        public int ControlEcuadorId { get; set; }
        public int? ProductoId { get; set; }
        public int? UsuarioControlId { get; set; }
        public DateTime? ControlEcuadorFecha { get; set; }
        public string ControlEcuadorNumeroOrden { get; set; }
        public int? ControlEcuadorTotal { get; set; }
        public int? ControlEcuadorAprobado { get; set; }
        public double? ControlEcuadorTiempo { get; set; }
        public int? ControlEcuadorTallos { get; set; }
        public int? ControlEcuadorDespachar { get; set; }
        public int? ControlEcuadorElaborados { get; set; }
        public string ControlEcuadorDerogado { get; set; }
        public int? PostcosechaId { get; set; }
        public string Marca { get; set; }
        public int? ClienteId { get; set; }
        public int? DetalleFirmaId { get; set; }

        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Producto Producto { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public ICollection<Alertasecuador> Alertasecuador { get; set; }
        public ICollection<Problemasecuador> Problemasecuador { get; set; }
    }
}
