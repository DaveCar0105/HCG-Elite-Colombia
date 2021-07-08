using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Entidades
{
    public class BaseOrdenes
    {
        public string prioridades   { get; set; }
        public string nomBodega     { get; set; }
        public string postcosecha   { get; set; }
        public string nomShip       { get; set; }
        public string nomShop       { get; set; }
        public string marca         { get; set; }
        public string numPed        { get; set; }
        public string pO            { get; set; }
        public string tipoDes       { get; set; }
        public string total         { get; set; }
    }
}
