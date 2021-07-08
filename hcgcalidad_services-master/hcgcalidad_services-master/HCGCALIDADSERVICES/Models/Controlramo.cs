using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Controlramo
    {
        public Controlramo()
        {
            Ramo = new HashSet<Ramo>();
        }

        public int ControlRamoId { get; set; }
        public int? DetalleFirmaId { get; set; }
        public int? ProductoId { get; set; }
        public int? UsuarioControlId { get; set; }
        public DateTime? ControlRamoFecha { get; set; }
        public string ControlRamoNumeroOrden { get; set; }
        public int? ControlRamoTotal { get; set; }
        public int? ControlRamoAprobado { get; set; }
        public double? ControlRamoTiempo { get; set; }
        public int? ControlRamoTallos { get; set; }
        public int? ControlRamoDespachar { get; set; }
        public int? ControlRamoElaborados { get; set; }
        public string ControlRamoDerogado { get; set; }
        public int? PostcosechaId { get; set; }
        public string Marca { get; set; }
        public int? ClienteId { get; set; }
        public string ClienteMacro { get; set; }

        public Cliente Cliente { get; set; }
        public DetalleFirma DetalleFirma { get; set; }
        public Postcosecha Postcosecha { get; set; }
        public Producto Producto { get; set; }
        public Usuariocontrol UsuarioControl { get; set; }
        public ICollection<Ramo> Ramo { get; set; }
    }
}
