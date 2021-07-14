using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class TipoCliente
    {
        public TipoCliente()
        {
            Cliente = new HashSet<Cliente>();
        }
        public int TipoClienteId { get; set; }
        public string TipoClienteNombre { get; set; }

        public ICollection<Cliente> Cliente { get; set; }
    }
}
