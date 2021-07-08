using HCGCALIDADSERVICES.Entidades;
using HCGCALIDADSERVICES.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GraficoController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;
        public GraficoController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        [HttpPost]
        public dynamic Post([FromBody] EntFiltro filtro)
        {

            DateTime fechaDesde = new DateTime(filtro.fecha_desde.Year, filtro.fecha_desde.Month, filtro.fecha_desde.Day, 0, 0, 0);
            DateTime fechaHasta = new DateTime(filtro.fecha_hasta.Year, filtro.fecha_hasta.Month, filtro.fecha_hasta.Day, 0, 0, 0);
            List<Models.Controlramo> listaControlRamo = _context.Controlramo
                .Where(e => e.ControlRamoFecha >= fechaDesde && e.ControlRamoFecha <= fechaHasta)
                .Include(e => e.Cliente)
                .Include(e => e.Producto)
                .Include(e => e.Postcosecha)
                .Include(e => e.UsuarioControl)
                .Include(e => e.DetalleFirma)
                    .ThenInclude(d => d.Firma)
                .Where(c => c.Cliente.Elite == 1).ToList();
            EntGrafico graficoRetorno = new EntGrafico();

            graficoRetorno.Data.RamosElaborados = (int)listaControlRamo.Sum(s => s.ControlRamoElaborados);
            graficoRetorno.Data.RamosADespachar = (int)listaControlRamo.Sum(s => s.ControlRamoDespachar);
            graficoRetorno.Data.RamosRevisados  = (int)listaControlRamo.Sum(s => s.ControlRamoTotal);
            List<Models.Controlramo> listaControlRamoTmp = listaControlRamo.ToList();
            List<Models.Controlramo> listaProducto = listaControlRamo.ToList();
            List<Models.Controlramo> listaPostCosecha = listaControlRamo.ToList();
            List<Models.Controlramo> listaCliente = listaControlRamo.ToList();
            int ramosFalla = 0;
            List<Models.Falenciascontrolramo> listFalRamo = new List<Falenciascontrolramo>();
            List<Models.Macrofalencia> listaMacro = new List<Macrofalencia>();
            listaMacro = _context.Macrofalencia.ToList();
            while (listaControlRamoTmp.Count > 0)
            {
                int controlRamoId = listaControlRamoTmp[0].ControlRamoId;
                
                List<Models.Ramo> ramos = new List<Models.Ramo>();
                
                ramos = _context.Ramo.Where(em => em.ControlRamoId == controlRamoId).ToList();
                ramosFalla += ramos.Count();
                for (int i = 0; i < ramos.Count; i++)
                {
                    try
                    {
                        List<Models.Falenciascontrolramo> falRamo = new List<Falenciascontrolramo>();
                        falRamo = _context.Falenciascontrolramo
                            .Where(fe => fe.RamoId == ramos[i].RamoId)
                            .Include(fe => fe.FalenciaRamo).ThenInclude(fe => fe.MacroFalencia)
                            .Include(f => f.FalenciaRamo).ThenInclude(fe => fe.CategoriaFalenciaRamo)
                            .ToList();
                        listFalRamo.AddRange(falRamo);

                    }
                    catch (Exception e)
                    {

                    }

                }


                listaControlRamoTmp.RemoveAll(c=>c.ControlRamoId == controlRamoId);
            }

            while (listaMacro.Count>0)
            {
                MacroFalencia itemMacro = new MacroFalencia();
                int macroId = listaMacro[0].MacroFalenciaId;
                int cantidad = 0;
                itemMacro.Nombre = listaMacro[0].MacroFalenciaNombre;
                List<Falenciaramo> listaFalencias = new List<Falenciaramo>();
                listaFalencias = _context.Falenciaramo.Where(c => c.MacroFalenciaId == macroId).ToList();
                while (listaFalencias.Count>0)
                {
                    int falenciaRamoId = listaFalencias[0].FalenciaRamoId;
                    List<Models.Falenciascontrolramo> falRamo = new List<Falenciascontrolramo>();
                    falRamo = listFalRamo.Where(fe => fe.FalenciaRamoId == falenciaRamoId).ToList();
                    Falencia falenciaItem = new Falencia();
                    if(falRamo.Count > 0)
                    {
                        falenciaItem.Nombre = falRamo[0].FalenciaRamo.FalenciaRamoNombre;
                        falenciaItem.Cantidad = falRamo.Count();
                        cantidad += falRamo.Count();
                        itemMacro.Falencias.Add(falenciaItem);
                    }
                    
                    listaFalencias.RemoveAll(ra => ra.FalenciaRamoId == falenciaRamoId);
                }
                itemMacro.Cantidad = cantidad;
                graficoRetorno.Data.MacroFalencia.Add(itemMacro);
                listaMacro.RemoveAll(lm => lm.MacroFalenciaId == macroId);
            }
            graficoRetorno.Data.RamosNoConformes = ramosFalla;

            while (listaProducto.Count > 0)
            {
                int productoId = (int)listaProducto[0].ProductoId;
                Entidades.Cliente producto = new Entidades.Cliente();
                producto.Nombre = listaProducto[0].Producto.ProductoNombre;
                List<Models.Controlramo> listaProductoTmp = listaProducto.Where(lP=>lP.ProductoId == productoId ).ToList();
                decimal ramosRevisado = 0;
                decimal ramosInconformes = 0;
                for (int i = 0; i < listaProductoTmp.Count; i++)
                {
                    int controlRamoId = listaProductoTmp[i].ControlRamoId;
                    ramosRevisado += (int)listaProductoTmp[i].ControlRamoTotal;
                    List<Models.Ramo> ramos = new List<Models.Ramo>();
                    ramos = _context.Ramo.Where(em => em.ControlRamoId == controlRamoId).ToList();
                    ramosInconformes += ramos.Count();

                }

                producto.NoConforme = Math.Round((ramosInconformes / ramosRevisado), 2);
                graficoRetorno.Data.Producto.Add(producto);
                listaProducto.RemoveAll(c => c.ProductoId == productoId);
            }


            while (listaPostCosecha.Count > 0)
            {
                int postcosechaId = (int)listaPostCosecha[0].PostcosechaId;
                Entidades.Cliente postcosecha = new Entidades.Cliente();
                postcosecha.Nombre = listaPostCosecha[0].Postcosecha.PostcosechaNombre;
                List<Models.Controlramo> listaPostCosechaTmp = listaPostCosecha.Where(lP => lP.PostcosechaId == postcosechaId).ToList();
                decimal ramosRevisado = 0;
                decimal ramosInconformes = 0;
                for (int i = 0; i < listaPostCosechaTmp.Count; i++)
                {
                    int controlRamoId = listaPostCosechaTmp[i].ControlRamoId;
                    ramosRevisado += (int)listaPostCosechaTmp[i].ControlRamoTotal;
                    List<Models.Ramo> ramos = new List<Models.Ramo>();
                    ramos = _context.Ramo.Where(em => em.ControlRamoId == controlRamoId).ToList();
                    ramosInconformes += ramos.Count();

                }

                postcosecha.NoConforme = Math.Round((ramosInconformes / ramosRevisado), 2);
                graficoRetorno.Data.Postcosechas.Add(postcosecha);
                listaPostCosecha.RemoveAll(c => c.PostcosechaId == postcosechaId);


            }

            while (listaCliente.Count > 0)
            {
                int clienteId = (int)listaCliente[0].ClienteId;
                Entidades.Cliente cliente = new Entidades.Cliente();
                cliente.Nombre = listaCliente[0].Postcosecha.PostcosechaNombre;
                List<Models.Controlramo> listaClienteTmp = listaCliente.Where(lP => lP.ClienteId == clienteId).ToList();
                decimal ramosRevisado = 0;
                decimal ramosInconformes = 0;
                for (int i = 0; i < listaClienteTmp.Count; i++)
                {
                    int controlRamoId = listaClienteTmp[i].ControlRamoId;
                    ramosRevisado += (int)listaClienteTmp[i].ControlRamoTotal;
                    List<Models.Ramo> ramos = new List<Models.Ramo>();
                    ramos = _context.Ramo.Where(em => em.ControlRamoId == controlRamoId).ToList();
                    ramosInconformes += ramos.Count();

                }

                cliente.NoConforme = Math.Round((ramosInconformes / ramosRevisado), 2);
                graficoRetorno.Data.Cliente.Add(cliente);
                listaCliente.RemoveAll(c => c.ClienteId == clienteId);


            }



            return graficoRetorno;

        }
    }
}
