using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Categoriafalenciaempaque
    {
        public Categoriafalenciaempaque()
        {
            Falenciaempaque = new HashSet<Falenciaempaque>();
        }

        public int CategoriaFalenciaEmpaque1 { get; set; }
        public string CategoriaFalenciaNombre { get; set; }
        public int? CategoriaFalenciaTipo { get; set; }

        public ICollection<Falenciaempaque> Falenciaempaque { get; set; }
    }
}
