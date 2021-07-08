using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Falenciacontrolempaque
    {
        public int FalenciaControlEmpaqueId { get; set; }
        public int? EmpaqueId { get; set; }
        public int FalenciaEmpaqueId { get; set; }
        public int? FalenciaControlEmpaqueCantidad { get; set; }

        public Empaque Empaque { get; set; }
        public Falenciaempaque FalenciaEmpaque { get; set; }
    }
}
