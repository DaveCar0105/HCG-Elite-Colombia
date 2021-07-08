using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Problemasecommerce
    {
        public Problemasecommerce()
        {
            Checkecommerce = new HashSet<Checkecommerce>();
        }

        public int ProblemaEcommerceId { get; set; }
        public int? ProblemaEcommerceNumero { get; set; }
        public string ProblemaEcommerceNombre { get; set; }
        public int? ProblemaEcommerceTipo { get; set; }

        public ICollection<Checkecommerce> Checkecommerce { get; set; }
    }
}
