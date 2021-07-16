using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Cliente
    {
        public Cliente()
        {
            Controlalistamiento = new HashSet<Controlalistamiento>();
            Controlbanda = new HashSet<Controlbanda>();
            Controlboncheo = new HashSet<Controlboncheo>();
            Controlecuador = new HashSet<Controlecuador>();
            Controlempaque = new HashSet<Controlempaque>();
            Controlramo = new HashSet<Controlramo>();
            Temperatura = new HashSet<Temperatura>();
            CirculoCalidad1 = new HashSet<CirculoCalidad>();
            CirculoCalidad2 = new HashSet<CirculoCalidad>();
        }

        public int ClienteId { get; set; }
        public string ClienteNombre { get; set; }
        public string ClienteNombreMacro { get; set; }
        public int? Elite { get; set; }

        public int? TipoClienteId { get; set; }

        public TipoCliente TipoCliente { get; set; }
        public ICollection<Controlalistamiento> Controlalistamiento { get; set; }
        public ICollection<Controlbanda> Controlbanda { get; set; }
        public ICollection<Controlboncheo> Controlboncheo { get; set; }
        public ICollection<Controlecuador> Controlecuador { get; set; }
        public ICollection<Controlempaque> Controlempaque { get; set; }
        public ICollection<Controlramo> Controlramo { get; set; }
        public ICollection<Temperatura> Temperatura { get; set; }

        public ICollection<CirculoCalidad> CirculoCalidad1 { get; set; }
        public ICollection<CirculoCalidad> CirculoCalidad2 { get; set; }
    }
}
