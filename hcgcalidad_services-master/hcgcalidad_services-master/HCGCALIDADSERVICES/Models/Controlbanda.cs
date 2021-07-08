using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlbanda
    {
        public Controlbanda()
        {
            Problemabanda = new HashSet<Problemabanda>();
        }

        public int ControlBandaId { get; set; }
        public int? ProductoId { get; set; }
        public int? UsuarioControlId { get; set; }
        public DateTime? ControlBandaFecha { get; set; }
        public string ControlBandaNumeroOrden { get; set; }
        public int? ControlBandaTotal { get; set; }
        public int? ControlBandaAprobado { get; set; }
        public double? ControlBandaTiempo { get; set; }
        public int? ControlBandaTallos { get; set; }
        public int? ControlBandaDespachar { get; set; }
        public int? ControlBandaElaborados { get; set; }
        public string ControlBandaDerogado { get; set; }
        public int? PostcosechaId { get; set; }
        public string Marca { get; set; }
        public int? ClienteId { get; set; }
        public string ClienteMacro { get; set; }
        public int? TipoControlId { get; set; }
        public int? DetalleFirmaId { get; set; }

        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Producto Producto { get; set; }
        public TipoControl TipoControl { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public ICollection<Problemabanda> Problemabanda { get; set; }
    }
}
