using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Empaque
    {
        public Empaque()
        {
            Falenciacontrolempaque = new HashSet<Falenciacontrolempaque>();
        }

        public int EmpaqueId { get; set; }
        public string NumeroMesa { get; set; }
        public string Variedad { get; set; }
        public string Linea { get; set; }
        public string CodigoEmpacador { get; set; }
        public int ControlEmpaqueId { get; set; }

        public Controlempaque ControlEmpaque { get; set; }
        public ICollection<Falenciacontrolempaque> Falenciacontrolempaque { get; set; }
    }
}
