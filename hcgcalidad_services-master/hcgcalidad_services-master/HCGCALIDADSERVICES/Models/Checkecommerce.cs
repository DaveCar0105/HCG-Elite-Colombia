using System;
using System.Collections.Generic;

namespace HCGCALIDADSERVICES.Models
{
    public partial class Checkecommerce
    {
        public int CheckEcommerceId { get; set; }
        public int? ControlEcommerceId { get; set; }
        public int? ProblemaEcommerceId { get; set; }
        public int? CheckEcommerceValor { get; set; }

        public Controlecommerce ControlEcommerce { get; set; }
        public Problemasecommerce ProblemaEcommerce { get; set; }
    }
}
