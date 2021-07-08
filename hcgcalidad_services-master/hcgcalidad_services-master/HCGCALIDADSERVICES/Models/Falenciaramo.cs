using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Falenciaramo
    {
        public Falenciaramo()
        {
            Alertasecuador = new HashSet<Alertasecuador>();
            Falenciascontrolramo = new HashSet<Falenciascontrolramo>();
            Problemaalistamiento = new HashSet<Problemaalistamiento>();
            Problemabanda = new HashSet<Problemabanda>();
            Problemaboncheo = new HashSet<Problemaboncheo>();
            Problemasecuador = new HashSet<Problemasecuador>();
        }

        public int FalenciaRamoId { get; set; }
        public int? MacroFalenciaId { get; set; }
        public int? CategoriaFalenciaRamoId { get; set; }
        public string FalenciaRamoNombre { get; set; }
        public int? Elite { get; set; }
        public string Codigo { get; set; }

        public Categoriafalenciaramo CategoriaFalenciaRamo { get; set; }
        public Macrofalencia MacroFalencia { get; set; }
        public ICollection<Alertasecuador> Alertasecuador { get; set; }
        public ICollection<Falenciascontrolramo> Falenciascontrolramo { get; set; }
        public ICollection<Problemaalistamiento> Problemaalistamiento { get; set; }
        public ICollection<Problemabanda> Problemabanda { get; set; }
        public ICollection<Problemaboncheo> Problemaboncheo { get; set; }
        public ICollection<Problemasecuador> Problemasecuador { get; set; }
    }
}
