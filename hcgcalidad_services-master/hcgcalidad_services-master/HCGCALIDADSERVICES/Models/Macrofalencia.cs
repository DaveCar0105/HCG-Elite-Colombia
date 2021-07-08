using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Macrofalencia
    {
        public Macrofalencia()
        {
            Falenciaempaque = new HashSet<Falenciaempaque>();
            Falenciaramo = new HashSet<Falenciaramo>();
        }

        public int MacroFalenciaId { get; set; }
        public string MacroFalenciaNombre { get; set; }

        public ICollection<Falenciaempaque> Falenciaempaque { get; set; }
        public ICollection<Falenciaramo> Falenciaramo { get; set; }
    }
}
