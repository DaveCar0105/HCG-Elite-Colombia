using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Falenciaempaque
    {
        public Falenciaempaque()
        {
            Falenciacontrolempaque = new HashSet<Falenciacontrolempaque>();
        }

        public int FalenciaEmpaqueId { get; set; }
        public int? CategoriaFalenciaEmpaque { get; set; }
        public int? MacroFalenciaId { get; set; }
        public string FalenciaEmpaqueNombre { get; set; }
        public int? Elite { get; set; }
        public string Codigo { get; set; }

        public Categoriafalenciaempaque CategoriaFalenciaEmpaqueNavigation { get; set; }
        public Macrofalencia MacroFalencia { get; set; }
        public ICollection<Falenciacontrolempaque> Falenciacontrolempaque { get; set; }
    }
}
