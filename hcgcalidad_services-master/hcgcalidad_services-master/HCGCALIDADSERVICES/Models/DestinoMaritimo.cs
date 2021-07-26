﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class DestinoMaritimo
    {
        public DestinoMaritimo()
        {
            ProcesoMaritimo = new HashSet<ProcesoMaritimo>();
        }
        public int DestinoMaritimoId { get; set; }
        public string DestinoMaritimoNombre { get; set; }

        public ICollection<ProcesoMaritimo> ProcesoMaritimo { get; set; }
    }
}
