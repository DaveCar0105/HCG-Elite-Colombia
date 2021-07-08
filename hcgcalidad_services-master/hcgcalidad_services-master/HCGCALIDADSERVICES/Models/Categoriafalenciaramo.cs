using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Categoriafalenciaramo
    {
        public Categoriafalenciaramo()
        {
            Falenciaramo = new HashSet<Falenciaramo>();
        }

        public int CategoriaFalenciaRamoId { get; set; }
        public string CategoriaFalenciaRamoNombre { get; set; }

        public ICollection<Falenciaramo> Falenciaramo { get; set; }
    }
}
