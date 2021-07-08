using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Errores
    {
        public int ErroresId { get; set; }
        public string ErroresCadena { get; set; }
        public int? EmpleadoId { get; set; }
    }
}
