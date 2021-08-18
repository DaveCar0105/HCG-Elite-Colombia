using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Models
{
    public class CirculoCalidad
    {
        public CirculoCalidad()
        {
            CirculoCalidadProducto = new HashSet<CirculoCalidadProducto>();
            CirculoCalidadCliente = new HashSet<CirculoCalidadCliente>();
            CirculoCalidadFalencia = new HashSet<CirculoCalidadFalencia>();
            CirculoCalidadVariedad = new HashSet<CirculoCalidadVariedad>();
            CirculoCalidadNumeroMesa = new HashSet<CirculoCalidadNumeroMesa>();
            CirculoCalidadLinea = new HashSet<CirculoCalidadLinea>();
        }
        public int CirculoCalidadId { get; set; }
        public int CirculoCalidadRevisados { get; set; }
        public int CirculoCalidadRechazados { get; set; }
        public double CirculoCalidadPorcentajeNoConforme { get; set; }
        public int CirculoCalidadNumeroReunion { get; set; }
        public string CirculoCalidadSupervisor { get; set; }
        public string CirculoCalidadSupervisor2 { get; set; }
        public string CirculoCalidadEvaluacionSupervisor { get; set; }
        public string CirculoCalidadEvaluacionSupervisor2 { get; set; }
        public string CirculoCalidadComentario { get; set; }
        public DateTime? CirculoCalidadFecha { get; set; }
        public int? PostcosechaId { get; set; }
        public Postcosecha Postcosecha { get; set; }

        public ICollection<CirculoCalidadProducto> CirculoCalidadProducto { get; set; }
        public ICollection<CirculoCalidadCliente> CirculoCalidadCliente { get; set; }
        public ICollection<CirculoCalidadFalencia> CirculoCalidadFalencia { get; set; }
        public ICollection<CirculoCalidadVariedad> CirculoCalidadVariedad { get; set; }
        public ICollection<CirculoCalidadNumeroMesa> CirculoCalidadNumeroMesa { get; set; }
        public ICollection<CirculoCalidadLinea> CirculoCalidadLinea { get; set; }

    }

    public class CirculoCalidadProducto
    {
        public int CirculoCalidadProductoId { get; set; }
        public int Revisados { get; set; }
        public int Rechazados { get; set; }
        public float Porcentaje { get; set; }
        public int CirculoCalidadId { get; set; }
        public int ProductoId { get; set; }
        public CirculoCalidad CirculoCalidad { get; set; }
        public Producto Producto { get; set; }
    }

    public class CirculoCalidadCliente
    {
        public int CirculoCalidadClienteId { get; set; }
        public int Revisados { get; set; }
        public int Rechazados { get; set; }
        public float Porcentaje { get; set; }
        public int CirculoCalidadId { get; set; }
        public int ClienteId { get; set; }
        public CirculoCalidad CirculoCalidad { get; set; }
        public Cliente Cliente { get; set; }
    }

    public class CirculoCalidadFalencia
    {
        public int CirculoCalidadFalenciaId { get; set; }
        public int Revisados { get; set; }
        public int Rechazados { get; set; }
        public float Porcentaje { get; set; }
        public int CirculoCalidadId { get; set; }
        public int FalenciaramosId { get; set; }
        public CirculoCalidad CirculoCalidad { get; set; }
        public Falenciaramo Falenciaramo { get; set; }
    }

    public class CirculoCalidadVariedad
    {
        public int CirculoCalidadVariedadId { get; set; }
        public string CirculoCalidadVariedadNombre { get; set; }
        public int Revisados { get; set; }
        public int Rechazados { get; set; }
        public float Porcentaje { get; set; }
        public int CirculoCalidadId { get; set; }
        public CirculoCalidad CirculoCalidad { get; set; }
    }

    public class CirculoCalidadNumeroMesa
    {
        public int CirculoCalidadNumeroMesaId { get; set; }
        public string CirculoCalidadNumeroMesaNombre { get; set; }
        public int Revisados { get; set; }
        public int Rechazados { get; set; }
        public float Porcentaje { get; set; }
        public int CirculoCalidadId { get; set; }
        public CirculoCalidad CirculoCalidad { get; set; }
    }

    public class CirculoCalidadLinea
    {
        public int CirculoCalidadLineaId { get; set; }
        public string CirculoCalidadLineaNombre { get; set; }
        public int Revisados { get; set; }
        public int Rechazados { get; set; }
        public float Porcentaje { get; set; }
        public int CirculoCalidadId { get; set; }
        public CirculoCalidad CirculoCalidad { get; set; }
    }
}
