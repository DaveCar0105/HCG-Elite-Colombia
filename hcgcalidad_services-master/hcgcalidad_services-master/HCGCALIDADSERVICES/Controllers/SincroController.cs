using HCGCALIDADSERVICES.Entidades;
using HCGCALIDADSERVICES.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SincroController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;
        public SincroController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }
        [HttpPost("Reporte")]
        public dynamic PostReporte(Filtro filtro)
        {
            ReporteExcel reporte = new ReporteExcel();
            List<Baseorden> baseOrdenes = new List<Baseorden>();
            

            DateTime fechaDesde = new DateTime(filtro.fecha_desde.Year, filtro.fecha_desde.Month, filtro.fecha_desde.Day,0,0,0);
            DateTime fechaHasta = new DateTime(filtro.fecha_hasta.Year, filtro.fecha_hasta.Month, filtro.fecha_hasta.Day, 0, 0, 0);
            baseOrdenes = _context.Baseorden.ToList();
            

            if(filtro.tipo == 2)
            {
                List<Models.Controlecuador> listaBanda = _context.Controlecuador
                    .Where(b => b.ControlEcuadorFecha >= fechaDesde && b.ControlEcuadorFecha <= fechaHasta)
                    .Include(b => b.Cliente)
                    .Include(b => b.Producto)
                    .Include(b => b.Postcosecha)
                    .Include(b => b.UsuarioControl)
                    .Include(b => b.DetalleFirma)
                        .ThenInclude(d => d.Firma)
                    .ToList();
                while (listaBanda.Count > 0)
                {
                    int listaBandaId = listaBanda[0].ControlEcuadorId;

                    List<Models.Problemasecuador> falBanda = new List<Problemasecuador>();
                    falBanda = _context.Problemasecuador
                        .Where(pb => pb.ControlEcuadorId == listaBandaId)
                        .Include(fe => fe.FalenciaRamo).ThenInclude(fe => fe.MacroFalencia)
                        .Include(f => f.FalenciaRamo).ThenInclude(fe => fe.CategoriaFalenciaRamo)
                        .ToList();



                    BaseRamo itemBaseRamo = new BaseRamo();
                    string[] fecha = transformarFecha(Convert.ToDateTime(listaBanda[0].ControlEcuadorFecha));
                    itemBaseRamo.Semana = fecha[0];
                    itemBaseRamo.Mes = fecha[1];
                    itemBaseRamo.Fecha = fecha[2];
                    try
                    {
                        List<Baseorden> baseOrdenTmp = baseOrdenes.Where(c => c.NumPed == listaBanda[0].ControlEcuadorNumeroOrden).ToList();
                        if (baseOrdenTmp.Count == 1)
                        {

                            itemBaseRamo.Marca = baseOrdenTmp[0].Marca;
                        }
                        else
                        {

                            itemBaseRamo.Marca = listaBanda[0].Marca;
                        }
                        itemBaseRamo.Cliente = listaBanda[0].Cliente.ClienteNombre;
                        itemBaseRamo.ClienteMacro = listaBanda[0].Cliente.ClienteNombreMacro;
                        itemBaseRamo.PostCosecha = listaBanda[0].Postcosecha.PostcosechaNombre;
                    }
                    catch (Exception)
                    {
                        itemBaseRamo.Cliente = "";
                        itemBaseRamo.ClienteMacro = "";
                        itemBaseRamo.PostCosecha = "";
                        itemBaseRamo.Marca = "";
                    }
                    itemBaseRamo.Tipo = "Hidratación";
                    itemBaseRamo.OrdenNo = listaBanda[0].ControlEcuadorNumeroOrden;
                    itemBaseRamo.Tallos = (int)listaBanda[0].ControlEcuadorTallos;
                    itemBaseRamo.Producto = listaBanda[0].Producto.ProductoNombre;
                    itemBaseRamo.RamosDespachar = (int)listaBanda[0].ControlEcuadorDespachar;
                    itemBaseRamo.RamosElaborados = (int)listaBanda[0].ControlEcuadorElaborados;
                    itemBaseRamo.Inspeccionado = (int)listaBanda[0].ControlEcuadorTotal * 100 / itemBaseRamo.RamosElaborados;
                    itemBaseRamo.RamosRevisados = (int)listaBanda[0].ControlEcuadorTotal;
                    itemBaseRamo.RamosNoConformes = (int)falBanda.Sum(f => f.ProblemasEcuadorRamos);
                    itemBaseRamo.PorcentajeNoConformes = (int)falBanda.Sum(f => f.ProblemasEcuadorRamos) * 100 / itemBaseRamo.RamosRevisados;
                    itemBaseRamo.RamosConformes = itemBaseRamo.RamosRevisados - (int)falBanda.Sum(f => f.ProblemasEcuadorRamos);
                    itemBaseRamo.TallosRevisados = ((int)listaBanda[0].ControlEcuadorTallos * itemBaseRamo.RamosRevisados);
                    itemBaseRamo.PorcentajeConformidad = 100 - itemBaseRamo.PorcentajeNoConformes;
                    itemBaseRamo.AtendidoPor = listaBanda[0].DetalleFirma.Firma.FirmaNombre;
                    itemBaseRamo.Qc = listaBanda[0].UsuarioControl.UsuarioControlCodigo;
                    itemBaseRamo.DerrogadoPor = listaBanda[0].ControlEcuadorDerogado;
                    itemBaseRamo.Derrogacion = itemBaseRamo.DerrogadoPor.CompareTo("NO APLICA") == 0 ? false : true;
                    if (reporte.BaseRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseRamo.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseRamo.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseRamo.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseRamo.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseRamo.Producto) &&
                    bramos.Marca.Equals(itemBaseRamo.Marca) &&
                    bramos.Qc.Equals(itemBaseRamo.Qc) &&
                    bramos.RamosConformes == itemBaseRamo.RamosConformes &&
                    bramos.RamosDespachar == itemBaseRamo.RamosDespachar &&
                    bramos.RamosElaborados == itemBaseRamo.RamosElaborados &&
                    bramos.RamosRevisados == itemBaseRamo.RamosRevisados &&
                    bramos.Tipo.Equals(itemBaseRamo.Tipo)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseRamos.Add(itemBaseRamo);
                    }
                    listaBanda.RemoveAll(c => c.ControlEcuadorId == listaBandaId);
                    
                    while (falBanda.Count > 0)
                    {
                        int falenciaId = (int)falBanda[0].FalenciaRamoId;
                        List<Models.Problemasecuador> tmpFalencia = new List<Problemasecuador>();
                        tmpFalencia = falBanda.Where(lfe => lfe.FalenciaRamoId == falenciaId).ToList();
                        BaseTotalRamo itemProblema = new BaseTotalRamo();
                        itemProblema.Semana = fecha[0];
                        itemProblema.Mes = fecha[1];
                        itemProblema.Fecha = fecha[2];
                        itemProblema.ClienteMacro = itemBaseRamo.ClienteMacro;
                        itemProblema.Cliente = itemBaseRamo.Cliente;
                        itemProblema.PostCosecha = itemBaseRamo.PostCosecha;
                        itemProblema.Producto = itemBaseRamo.Producto;
                        itemProblema.OrdenNo = itemBaseRamo.OrdenNo;
                        itemProblema.Marca = itemBaseRamo.Marca;
                        itemProblema.Indicador = tmpFalencia[0].FalenciaRamo.CategoriaFalenciaRamo.CategoriaFalenciaRamoNombre;
                        itemProblema.Causa = tmpFalencia[0].FalenciaRamo.MacroFalencia.MacroFalenciaNombre;
                        itemProblema.CausaRelacionada = tmpFalencia[0].FalenciaRamo.FalenciaRamoNombre;
                        itemProblema.Repeticion = tmpFalencia.Sum(tF => tF.ProblemasEcuadorRamos);
                        itemProblema.Tipo = itemBaseRamo.Tipo;
                        itemProblema.CodigoItem = falBanda[0].FalenciaRamo.Codigo;
                        if (reporte.ProblemasRamoEmpaque.Count(bramos =>
                        bramos.Fecha.Equals(itemProblema.Fecha) &&
                        bramos.Cliente.Equals(itemProblema.Cliente) &&
                        bramos.ClienteMacro.Equals(itemProblema.ClienteMacro) &&
                        bramos.OrdenNo.Equals(itemProblema.OrdenNo) &&
                        bramos.PostCosecha.Equals(itemProblema.PostCosecha) &&
                        bramos.Producto.Equals(itemProblema.Producto) &&
                        bramos.Marca.Equals(itemProblema.Marca) &&
                        bramos.Causa.Equals(itemProblema.Causa) &&
                        bramos.Indicador.Equals(itemProblema.Indicador) &&
                        bramos.CausaRelacionada.Equals(itemProblema.CausaRelacionada) &&
                        bramos.TotalRamosCajas.Equals(itemProblema.TotalRamosCajas) &&
                        bramos.Tipo.Equals(itemProblema.Tipo)
                        ) > 0)
                        {

                        }
                        else
                        {
                            reporte.ProblemasRamoEmpaque.Add(itemProblema);
                        }

                        falBanda.RemoveAll(r => r.FalenciaRamoId == falenciaId);
                    }
                }
            }
            else
            {
                List<Models.Controlramo> listaControlRamo = _context.Controlramo
                .Where(e => e.ControlRamoFecha >= fechaDesde && e.ControlRamoFecha <= fechaHasta)
                .Include(e => e.Cliente)
                .Include(e => e.Producto)
                .Include(e => e.Postcosecha)
                .Include(e => e.UsuarioControl)
                .Include(e => e.DetalleFirma)
                    .ThenInclude(d => d.Firma)
                .Where(c => c.Cliente.Elite == filtro.tipo).ToList();

                List<Models.Controlbanda> listaBanda = _context.Controlbanda
                    .Where(b => b.ControlBandaFecha >= fechaDesde && b.ControlBandaFecha <= fechaHasta)
                    .Include(b => b.Cliente)
                    .Include(b => b.Producto)
                    .Include(b => b.Postcosecha)
                    .Include(b => b.UsuarioControl)
                    .Include(b => b.TipoControl)
                    .Include(b => b.DetalleFirma)
                        .ThenInclude(d => d.Firma)
                    .ToList();
                while (listaBanda.Count > 0)
                {
                    int listaBandaId = listaBanda[0].ControlBandaId;

                    List<Models.Problemabanda> falBanda = new List<Problemabanda>();
                    falBanda = _context.Problemabanda
                        .Where(pb => pb.ControlBandaId == listaBandaId)
                        .Include(fe => fe.FalenciaRamo).ThenInclude(fe => fe.MacroFalencia)
                        .Include(f => f.FalenciaRamo).ThenInclude(fe => fe.CategoriaFalenciaRamo)
                        .ToList();



                    BaseRamo itemBaseRamo = new BaseRamo();
                    string[] fecha = transformarFecha(Convert.ToDateTime(listaBanda[0].ControlBandaFecha));
                    itemBaseRamo.Semana = fecha[0];
                    itemBaseRamo.Mes = fecha[1];
                    itemBaseRamo.Fecha = fecha[2];
                    try
                    {
                        List<Baseorden> baseOrdenTmp = baseOrdenes.Where(c => c.NumPed == listaBanda[0].ControlBandaNumeroOrden).ToList();
                        if (baseOrdenTmp.Count == 1)
                        {

                            itemBaseRamo.Marca = baseOrdenTmp[0].Marca;
                        }
                        else
                        {

                            itemBaseRamo.Marca = listaBanda[0].Marca;
                        }
                        itemBaseRamo.Cliente = listaBanda[0].Cliente.ClienteNombre;
                        itemBaseRamo.ClienteMacro = listaBanda[0].Cliente.ClienteNombreMacro;
                        itemBaseRamo.PostCosecha = listaBanda[0].Postcosecha.PostcosechaNombre;
                    }
                    catch (Exception)
                    {
                        itemBaseRamo.Cliente = "";
                        itemBaseRamo.ClienteMacro = "";
                        itemBaseRamo.PostCosecha = "";
                        itemBaseRamo.Marca = "";
                    }
                    itemBaseRamo.Tipo = listaBanda[0].TipoControl.TipoControlNombre;
                    itemBaseRamo.OrdenNo = listaBanda[0].ControlBandaNumeroOrden;
                    itemBaseRamo.Tallos = (int)listaBanda[0].ControlBandaTallos;
                    itemBaseRamo.Producto = listaBanda[0].Producto.ProductoNombre;
                    itemBaseRamo.RamosDespachar = (int)listaBanda[0].ControlBandaDespachar;
                    itemBaseRamo.RamosElaborados = (int)listaBanda[0].ControlBandaElaborados;
                    itemBaseRamo.Inspeccionado = (int)listaBanda[0].ControlBandaTotal * 100 / itemBaseRamo.RamosElaborados;
                    itemBaseRamo.RamosRevisados = (int)listaBanda[0].ControlBandaTotal;
                    itemBaseRamo.RamosNoConformes = (int)falBanda.Sum(f => f.RamosNoConformes);
                    itemBaseRamo.PorcentajeNoConformes = (int)falBanda.Sum(f => f.RamosNoConformes) * 100 / itemBaseRamo.RamosRevisados;
                    itemBaseRamo.RamosConformes = itemBaseRamo.RamosRevisados - (int)falBanda.Sum(f => f.RamosNoConformes);
                    itemBaseRamo.TallosRevisados = ((int)listaBanda[0].ControlBandaTallos * itemBaseRamo.RamosRevisados);
                    itemBaseRamo.PorcentajeConformidad = 100 - itemBaseRamo.PorcentajeNoConformes;
                    itemBaseRamo.AtendidoPor = listaBanda[0].DetalleFirma.Firma.FirmaNombre;
                    itemBaseRamo.Qc = listaBanda[0].UsuarioControl.UsuarioControlCodigo;
                    itemBaseRamo.DerrogadoPor = listaBanda[0].ControlBandaDerogado;
                    itemBaseRamo.Derrogacion = itemBaseRamo.DerrogadoPor.CompareTo("NO APLICA") == 0 ? false : true;
                    if (reporte.BaseRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseRamo.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseRamo.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseRamo.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseRamo.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseRamo.Producto) &&
                    bramos.Marca.Equals(itemBaseRamo.Marca) &&
                    bramos.Qc.Equals(itemBaseRamo.Qc) &&
                    bramos.RamosConformes == itemBaseRamo.RamosConformes &&
                    bramos.RamosDespachar == itemBaseRamo.RamosDespachar &&
                    bramos.RamosElaborados == itemBaseRamo.RamosElaborados &&
                    bramos.RamosRevisados == itemBaseRamo.RamosRevisados &&
                    bramos.Tipo.Equals(itemBaseRamo.Tipo)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseRamos.Add(itemBaseRamo);
                    }
                    listaBanda.RemoveAll(c => c.ControlBandaId == listaBandaId);
                    BaseTotalRamo itemBaseTotalRamos = new BaseTotalRamo();
                    itemBaseTotalRamos.Semana = fecha[0];
                    itemBaseTotalRamos.Mes = fecha[1];
                    itemBaseTotalRamos.Fecha = fecha[2];
                    itemBaseTotalRamos.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamos.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamos.PostCosecha = itemBaseRamo.PostCosecha;
                    itemBaseTotalRamos.Producto = itemBaseRamo.Producto;
                    itemBaseTotalRamos.OrdenNo = itemBaseRamo.OrdenNo;
                    itemBaseTotalRamos.Marca = itemBaseRamo.Marca;
                    itemBaseTotalRamos.Indicador = "No conformidad";
                    itemBaseTotalRamos.Causa = "No conformes";
                    itemBaseTotalRamos.CausaRelacionada = "Ramos no conformes";
                    itemBaseTotalRamos.TotalRamosCajas = (int)falBanda.Sum(f => f.RamosNoConformes);
                    itemBaseTotalRamos.CodigoItem = "I";
                    itemBaseTotalRamos.Tipo = itemBaseRamo.Tipo;
                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalRamos.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalRamos.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalRamos.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalRamos.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalRamos.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalRamos.Marca) &&
                    bramos.Causa.Equals(itemBaseTotalRamos.Causa) &&
                    bramos.TotalRamosCajas.Equals(itemBaseTotalRamos.TotalRamosCajas) &&
                    bramos.Tipo.Equals(itemBaseTotalRamos.Tipo)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalRamos);
                    }

                    BaseTotalRamo itemBaseTotalRamosConf = new BaseTotalRamo();
                    itemBaseTotalRamosConf.Semana = fecha[0];
                    itemBaseTotalRamosConf.Mes = fecha[1];
                    itemBaseTotalRamosConf.Fecha = fecha[2];
                    itemBaseTotalRamosConf.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamosConf.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamosConf.PostCosecha = itemBaseRamo.PostCosecha;
                    itemBaseTotalRamosConf.Producto = itemBaseRamo.Producto;
                    itemBaseTotalRamosConf.OrdenNo = itemBaseRamo.OrdenNo;
                    itemBaseTotalRamosConf.Marca = itemBaseRamo.Marca;
                    itemBaseTotalRamosConf.Indicador = "Conformidad";
                    itemBaseTotalRamosConf.Causa = "Conformes";
                    itemBaseTotalRamosConf.CausaRelacionada = "Ramos conformes";
                    itemBaseTotalRamosConf.TotalRamosCajas = itemBaseRamo.RamosConformes;
                    itemBaseTotalRamosConf.Tipo = itemBaseRamo.Tipo;
                    itemBaseTotalRamosConf.CodigoItem = "0";
                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalRamosConf.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalRamosConf.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalRamosConf.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalRamosConf.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalRamosConf.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalRamosConf.Marca) &&
                    bramos.Causa.Equals(itemBaseTotalRamosConf.Causa) &&
                    bramos.TotalRamosCajas.Equals(itemBaseTotalRamosConf.TotalRamosCajas) &&
                    bramos.Tipo.Equals(itemBaseTotalRamosConf.Tipo)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalRamosConf);
                    }

                    while (falBanda.Count > 0)
                    {
                        int falenciaId = (int)falBanda[0].FalenciaRamoId;
                        List<Models.Problemabanda> tmpFalencia = new List<Problemabanda>();
                        tmpFalencia = falBanda.Where(lfe => lfe.FalenciaRamoId == falenciaId).ToList();
                        BaseTotalRamo itemProblema = new BaseTotalRamo();
                        itemProblema.Semana = fecha[0];
                        itemProblema.Mes = fecha[1];
                        itemProblema.Fecha = fecha[2];
                        itemProblema.ClienteMacro = itemBaseRamo.ClienteMacro;
                        itemProblema.Cliente = itemBaseRamo.Cliente;
                        itemProblema.PostCosecha = itemBaseRamo.PostCosecha;
                        itemProblema.Producto = itemBaseRamo.Producto;
                        itemProblema.OrdenNo = itemBaseRamo.OrdenNo;
                        itemProblema.Marca = itemBaseRamo.Marca;
                        itemProblema.Indicador = tmpFalencia[0].FalenciaRamo.CategoriaFalenciaRamo.CategoriaFalenciaRamoNombre;
                        itemProblema.Causa = tmpFalencia[0].FalenciaRamo.MacroFalencia.MacroFalenciaNombre;
                        itemProblema.CausaRelacionada = tmpFalencia[0].FalenciaRamo.FalenciaRamoNombre;
                        itemProblema.Repeticion = tmpFalencia.Sum(tF => tF.RamosNoConformes);
                        itemProblema.Tipo = itemBaseRamo.Tipo;
                        itemProblema.CodigoItem = falBanda[0].FalenciaRamo.Codigo;
                        if (reporte.ProblemasRamoEmpaque.Count(bramos =>
                        bramos.Fecha.Equals(itemProblema.Fecha) &&
                        bramos.Cliente.Equals(itemProblema.Cliente) &&
                        bramos.ClienteMacro.Equals(itemProblema.ClienteMacro) &&
                        bramos.OrdenNo.Equals(itemProblema.OrdenNo) &&
                        bramos.PostCosecha.Equals(itemProblema.PostCosecha) &&
                        bramos.Producto.Equals(itemProblema.Producto) &&
                        bramos.Marca.Equals(itemProblema.Marca) &&
                        bramos.Causa.Equals(itemProblema.Causa) &&
                        bramos.Indicador.Equals(itemProblema.Indicador) &&
                        bramos.CausaRelacionada.Equals(itemProblema.CausaRelacionada) &&
                        bramos.TotalRamosCajas.Equals(itemProblema.TotalRamosCajas) &&
                        bramos.Tipo.Equals(itemProblema.Tipo)
                        ) > 0)
                        {

                        }
                        else
                        {
                            reporte.ProblemasRamoEmpaque.Add(itemProblema);
                        }

                        falBanda.RemoveAll(r => r.FalenciaRamoId == falenciaId);
                    }
                }

                List<Models.Controlramo> listaControlRamoTmp = new List<Controlramo>();
                listaControlRamoTmp = listaControlRamo.ToList();
                int valorError = listaControlRamoTmp.Count();

                while (listaControlRamoTmp.Count > 0)
                {
                    int controlRamoId = listaControlRamoTmp[0].ControlRamoId;
                    int ramosFalla = 0;
                    List<Models.Ramo> ramos = new List<Models.Ramo>();
                    List<Models.Falenciascontrolramo> listFalRamo = new List<Falenciascontrolramo>();
                    ramos = _context.Ramo.Where(em => em.ControlRamoId == controlRamoId).ToList();
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

                            ramosFalla++;
                        }
                        catch (Exception e)
                        {

                        }

                    }
                    if (valorError < listaControlRamoTmp.Count())
                    {
                        int j = 100;
                    }
                    BaseRamo itemBaseRamo = new BaseRamo();
                    string[] fecha = transformarFecha(Convert.ToDateTime(listaControlRamoTmp[0].ControlRamoFecha));
                    itemBaseRamo.Semana = fecha[0];
                    itemBaseRamo.Mes = fecha[1];
                    itemBaseRamo.Fecha = fecha[2];
                    try
                    {
                        List<Baseorden> baseOrdenTmp = baseOrdenes.Where(c => c.NumPed == listaControlRamoTmp[0].ControlRamoNumeroOrden).ToList();
                        if (baseOrdenTmp.Count == 1)
                        {

                            itemBaseRamo.Marca = baseOrdenTmp[0].Marca;
                        }
                        else
                        {

                            itemBaseRamo.Marca = listaControlRamoTmp[0].Marca;
                        }
                        itemBaseRamo.Cliente = listaControlRamoTmp[0].Cliente.ClienteNombre;
                        itemBaseRamo.ClienteMacro = listaControlRamoTmp[0].Cliente.ClienteNombreMacro;
                        itemBaseRamo.PostCosecha = listaControlRamoTmp[0].Postcosecha.PostcosechaNombre;
                    }
                    catch (Exception)
                    {
                        itemBaseRamo.Cliente = "";
                        itemBaseRamo.ClienteMacro = "";
                        itemBaseRamo.PostCosecha = "";
                        itemBaseRamo.Marca = "";
                    }
                    itemBaseRamo.Tipo = "Hidratación";
                    itemBaseRamo.OrdenNo = listaControlRamoTmp[0].ControlRamoNumeroOrden;
                    itemBaseRamo.Tallos = (int)listaControlRamoTmp[0].ControlRamoTallos;
                    itemBaseRamo.Producto = listaControlRamoTmp[0].Producto.ProductoNombre;
                    itemBaseRamo.RamosDespachar = (int)listaControlRamoTmp[0].ControlRamoDespachar;
                    itemBaseRamo.RamosElaborados = (int)listaControlRamoTmp[0].ControlRamoElaborados;
                    itemBaseRamo.Inspeccionado = (int)listaControlRamoTmp[0].ControlRamoTotal * 100 / itemBaseRamo.RamosElaborados;
                    itemBaseRamo.RamosRevisados = (int)listaControlRamoTmp[0].ControlRamoTotal;
                    itemBaseRamo.RamosNoConformes = ramosFalla;
                    itemBaseRamo.PorcentajeNoConformes = ramosFalla * 100 / itemBaseRamo.RamosRevisados;
                    itemBaseRamo.RamosConformes = itemBaseRamo.RamosRevisados - ramosFalla;
                    itemBaseRamo.TallosRevisados = ((int)listaControlRamoTmp[0].ControlRamoTallos * itemBaseRamo.RamosRevisados);
                    itemBaseRamo.PorcentajeConformidad = 100 - itemBaseRamo.PorcentajeNoConformes;
                    itemBaseRamo.AtendidoPor = listaControlRamoTmp[0].DetalleFirma.Firma.FirmaNombre;
                    itemBaseRamo.Qc = listaControlRamoTmp[0].UsuarioControl.UsuarioControlCodigo;
                    itemBaseRamo.DerrogadoPor = listaControlRamoTmp[0].ControlRamoDerogado;
                    itemBaseRamo.Derrogacion = itemBaseRamo.DerrogadoPor.CompareTo("NO APLICA") == 0 ? false : true;

                    if (reporte.BaseRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseRamo.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseRamo.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseRamo.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseRamo.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseRamo.Producto) &&
                    bramos.Marca.Equals(itemBaseRamo.Marca) &&
                    bramos.Qc.Equals(itemBaseRamo.Qc) &&
                    bramos.RamosConformes == itemBaseRamo.RamosConformes &&
                    bramos.RamosDespachar == itemBaseRamo.RamosDespachar &&
                    bramos.RamosElaborados == itemBaseRamo.RamosElaborados &&
                    bramos.RamosRevisados == itemBaseRamo.RamosRevisados &&
                    bramos.Tipo.Equals(itemBaseRamo.Tipo)

                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseRamos.Add(itemBaseRamo);
                    }





                    valorError = listaControlRamoTmp.Count();
                    listaControlRamoTmp.RemoveAll(lt => lt.ControlRamoId == controlRamoId);

                    BaseTotalRamo itemBaseTotalRamos = new BaseTotalRamo();
                    itemBaseTotalRamos.Semana = fecha[0];
                    itemBaseTotalRamos.Mes = fecha[1];
                    itemBaseTotalRamos.Fecha = fecha[2];
                    itemBaseTotalRamos.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamos.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamos.PostCosecha = itemBaseRamo.PostCosecha;
                    itemBaseTotalRamos.Producto = itemBaseRamo.Producto;
                    itemBaseTotalRamos.OrdenNo = itemBaseRamo.OrdenNo;
                    itemBaseTotalRamos.Marca = itemBaseRamo.Marca;
                    itemBaseTotalRamos.Indicador = "No conformidad";
                    itemBaseTotalRamos.Causa = "No conformes";
                    itemBaseTotalRamos.CausaRelacionada = "Ramos no conformes";
                    itemBaseTotalRamos.TotalRamosCajas = ramosFalla;
                    itemBaseTotalRamos.CodigoItem = "I";
                    itemBaseTotalRamos.Tipo = itemBaseRamo.Tipo;
                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalRamos.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalRamos.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalRamos.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalRamos.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalRamos.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalRamos.Marca) &&
                    bramos.Causa.Equals(itemBaseTotalRamos.Causa) &&
                    bramos.TotalRamosCajas.Equals(itemBaseTotalRamos.TotalRamosCajas) &&
                    bramos.Tipo.Equals(itemBaseTotalRamos.Tipo)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalRamos);
                    }

                    BaseTotalRamo itemBaseTotalRamosConf = new BaseTotalRamo();
                    itemBaseTotalRamosConf.Semana = fecha[0];
                    itemBaseTotalRamosConf.Mes = fecha[1];
                    itemBaseTotalRamosConf.Fecha = fecha[2];
                    itemBaseTotalRamosConf.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamosConf.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamosConf.PostCosecha = itemBaseRamo.PostCosecha;
                    itemBaseTotalRamosConf.Producto = itemBaseRamo.Producto;
                    itemBaseTotalRamosConf.OrdenNo = itemBaseRamo.OrdenNo;
                    itemBaseTotalRamosConf.Marca = itemBaseRamo.Marca;
                    itemBaseTotalRamosConf.Indicador = "Conformidad";
                    itemBaseTotalRamosConf.Causa = "Conformes";
                    itemBaseTotalRamosConf.CausaRelacionada = "Ramos conformes";
                    itemBaseTotalRamosConf.TotalRamosCajas = itemBaseRamo.RamosConformes;
                    itemBaseTotalRamosConf.Tipo = itemBaseRamo.Tipo;
                    itemBaseTotalRamosConf.CodigoItem = "0";
                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalRamosConf.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalRamosConf.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalRamosConf.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalRamosConf.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalRamosConf.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalRamosConf.Marca) &&
                    bramos.Causa.Equals(itemBaseTotalRamosConf.Causa) &&
                    bramos.TotalRamosCajas.Equals(itemBaseTotalRamosConf.TotalRamosCajas) &&
                    bramos.Tipo.Equals(itemBaseTotalRamosConf.Tipo)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalRamosConf);
                    }
                    while (listFalRamo.Count > 0)
                    {
                        int falenciaId = listFalRamo[0].FalenciaRamoId;
                        List<Models.Falenciascontrolramo> tmpFalencia = new List<Falenciascontrolramo>();
                        tmpFalencia = listFalRamo.Where(lfe => lfe.FalenciaRamoId == falenciaId).ToList();
                        BaseTotalRamo itemProblema = new BaseTotalRamo();
                        itemProblema.Semana = fecha[0];
                        itemProblema.Mes = fecha[1];
                        itemProblema.Fecha = fecha[2];
                        itemProblema.ClienteMacro = itemBaseRamo.ClienteMacro;
                        itemProblema.Cliente = itemBaseRamo.Cliente;
                        itemProblema.PostCosecha = itemBaseRamo.PostCosecha;
                        itemProblema.Producto = itemBaseRamo.Producto;
                        itemProblema.OrdenNo = itemBaseRamo.OrdenNo;
                        itemProblema.Marca = itemBaseRamo.Marca;
                        itemProblema.Indicador = tmpFalencia[0].FalenciaRamo.CategoriaFalenciaRamo.CategoriaFalenciaRamoNombre;
                        itemProblema.Causa = tmpFalencia[0].FalenciaRamo.MacroFalencia.MacroFalenciaNombre;
                        itemProblema.CausaRelacionada = tmpFalencia[0].FalenciaRamo.FalenciaRamoNombre;
                        itemProblema.Repeticion = tmpFalencia.Count;
                        itemProblema.Tipo = itemBaseRamo.Tipo;
                        itemProblema.CodigoItem = listFalRamo[0].FalenciaRamo.Codigo;
                        if (reporte.ProblemasRamoEmpaque.Count(bramos =>
                        bramos.Fecha.Equals(itemProblema.Fecha) &&
                        bramos.Cliente.Equals(itemProblema.Cliente) &&
                        bramos.ClienteMacro.Equals(itemProblema.ClienteMacro) &&
                        bramos.OrdenNo.Equals(itemProblema.OrdenNo) &&
                        bramos.PostCosecha.Equals(itemProblema.PostCosecha) &&
                        bramos.Producto.Equals(itemProblema.Producto) &&
                        bramos.Marca.Equals(itemProblema.Marca) &&
                        bramos.Causa.Equals(itemProblema.Causa) &&
                        bramos.Indicador.Equals(itemProblema.Indicador) &&
                        bramos.CausaRelacionada.Equals(itemProblema.CausaRelacionada) &&
                        bramos.TotalRamosCajas.Equals(itemProblema.TotalRamosCajas) &&
                        bramos.Tipo.Equals(itemProblema.Tipo)
                        ) > 0)
                        {

                        }
                        else
                        {
                            reporte.ProblemasRamoEmpaque.Add(itemProblema);
                        }

                        listFalRamo.RemoveAll(r => r.FalenciaRamoId == falenciaId);
                    }



                }


                List<Models.Controlempaque> listaControlEmpaques = _context.Controlempaque
                    .Where(e => e.ControlEmpaqueFecha >= fechaDesde && e.ControlEmpaqueFecha <= fechaHasta)
                    .Include(e => e.Cliente)
                    .Include(e => e.Producto)
                    .Include(e => e.Postcosecha)
                    .Include(e => e.UsuarioControl)
                    .Include(e => e.DetalleFirma)
                        .ThenInclude(d => d.Firma)
                    .Where(c => c.Cliente.Elite == filtro.tipo).ToList();
                List<Models.Controlempaque> listaControlEmpaquesTmp = new List<Controlempaque>();
                listaControlEmpaquesTmp = listaControlEmpaques.ToList();


                while (listaControlEmpaquesTmp.Count > 0)
                {
                    int controlEmpaqueId = listaControlEmpaquesTmp[0].ControlEmpaqueId;
                    List<Models.Empaque> empaques = new List<Models.Empaque>();
                    int ramos = 0;
                    int cajas = 0;
                    List<Models.Falenciacontrolempaque> listFalEmpaque = new List<Falenciacontrolempaque>();
                    empaques = _context.Empaque.Where(em => em.ControlEmpaqueId == controlEmpaqueId).ToList();
                    for (int i = 0; i < empaques.Count; i++)
                    {
                        List<Models.Falenciacontrolempaque> falEmpaque = new List<Falenciacontrolempaque>();
                        falEmpaque = _context.Falenciacontrolempaque.Where(fe => fe.EmpaqueId == empaques[i].EmpaqueId)
                            .Include(fe => fe.FalenciaEmpaque).ThenInclude(fe => fe.MacroFalencia)
                            .Include(f => f.FalenciaEmpaque).ThenInclude(fe => fe.CategoriaFalenciaEmpaqueNavigation)
                            .ToList();
                        try
                        {
                            if (falEmpaque[0].FalenciaEmpaque.CategoriaFalenciaEmpaqueNavigation.CategoriaFalenciaTipo == 1)
                            {
                                ramos++;
                            }
                            else
                            {
                                cajas++;
                            }
                            listFalEmpaque.AddRange(falEmpaque);
                        }
                        catch (Exception e)
                        {

                        }


                    }

                    BaseRamo itemBaseRamo = new BaseRamo();
                    string[] fecha = transformarFecha(Convert.ToDateTime(listaControlEmpaquesTmp[0].ControlEmpaqueFecha));
                    itemBaseRamo.Semana = fecha[0];
                    itemBaseRamo.Mes = fecha[1];
                    itemBaseRamo.Fecha = fecha[2];
                    try
                    {
                        List<Baseorden> baseOrdenTmp = baseOrdenes.Where(c => c.NumPed == listaControlEmpaquesTmp[0].ControlEmpaqueNumeroOrden).ToList();
                        if (baseOrdenTmp.Count == 1)
                        {
                            itemBaseRamo.Marca = baseOrdenTmp[0].Marca;
                        }
                        else
                        {

                            itemBaseRamo.Marca = listaControlEmpaquesTmp[0].Marca;
                        }
                        itemBaseRamo.Cliente = listaControlEmpaquesTmp[0].Cliente.ClienteNombre;
                        itemBaseRamo.ClienteMacro = listaControlEmpaquesTmp[0].Cliente.ClienteNombreMacro;
                        itemBaseRamo.PostCosecha = listaControlEmpaquesTmp[0].Postcosecha.PostcosechaNombre;
                    }
                    catch (Exception)
                    {
                        itemBaseRamo.Cliente = "";
                        itemBaseRamo.ClienteMacro = "";
                        itemBaseRamo.PostCosecha = "";
                        itemBaseRamo.Marca = "";
                    }
                    itemBaseRamo.Tipo = "Empaque";
                    itemBaseRamo.OrdenNo = listaControlEmpaquesTmp[0].ControlEmpaqueNumeroOrden;
                    itemBaseRamo.Tallos = (int)listaControlEmpaquesTmp[0].ControlEmpaqueTallos;
                    itemBaseRamo.Producto = listaControlEmpaquesTmp[0].Producto.ProductoNombre;
                    itemBaseRamo.RamosDespachar = ((int)listaControlEmpaquesTmp[0].ControlEmpaqueRamosCaja * (int)listaControlEmpaquesTmp[0].ControlEmpaqueDespachar);
                    itemBaseRamo.RamosElaborados = itemBaseRamo.RamosDespachar;
                    itemBaseRamo.Inspeccionado = (int)listaControlEmpaquesTmp[0].ControlEmpaqueRamosRevisar * 100 / itemBaseRamo.RamosElaborados;
                    itemBaseRamo.RamosRevisados = (int)listaControlEmpaquesTmp[0].ControlEmpaqueRamosRevisar;
                    itemBaseRamo.RamosNoConformes = ramos;
                    itemBaseRamo.PorcentajeNoConformes = ramos * 100 / itemBaseRamo.RamosRevisados;
                    itemBaseRamo.RamosConformes = itemBaseRamo.RamosRevisados - ramos;
                    itemBaseRamo.TallosRevisados = ((int)listaControlEmpaquesTmp[0].ControlEmpaqueTallos * itemBaseRamo.RamosRevisados);
                    itemBaseRamo.PorcentajeConformidad = 100 - itemBaseRamo.PorcentajeNoConformes;
                    itemBaseRamo.AtendidoPor = listaControlEmpaquesTmp[0].DetalleFirma.Firma.FirmaNombre;
                    itemBaseRamo.Qc = listaControlEmpaquesTmp[0].UsuarioControl.UsuarioControlCodigo;
                    itemBaseRamo.DerrogadoPor = listaControlEmpaquesTmp[0].ControlEmpaqueDerogado;
                    itemBaseRamo.Derrogacion = itemBaseRamo.DerrogadoPor.CompareTo("NO APLICA") == 0 ? false : true;

                    BaseCaja itemBaseCaja = new BaseCaja();
                    itemBaseCaja.Semana = fecha[0];
                    itemBaseCaja.Mes = fecha[1];
                    itemBaseCaja.Fecha = fecha[2];
                    try
                    {
                        List<Baseorden> baseOrdenTmp = baseOrdenes.Where(c => c.NumPed == listaControlEmpaquesTmp[0].ControlEmpaqueNumeroOrden).ToList();
                        if (baseOrdenTmp.Count == 1)
                        {

                            itemBaseCaja.Marca = baseOrdenTmp[0].Marca;
                        }
                        else
                        {

                            itemBaseCaja.Marca = listaControlEmpaquesTmp[0].Marca;
                        }
                        itemBaseCaja.Cliente = listaControlEmpaquesTmp[0].Cliente.ClienteNombre;
                        itemBaseCaja.ClienteMacro = listaControlEmpaquesTmp[0].Cliente.ClienteNombreMacro;
                        itemBaseCaja.PostCosecha = listaControlEmpaquesTmp[0].Postcosecha.PostcosechaNombre;
                    }
                    catch (Exception)
                    {
                        itemBaseCaja.Cliente = "";
                        itemBaseCaja.ClienteMacro = "";
                        itemBaseCaja.PostCosecha = "";
                        itemBaseCaja.Marca = "";
                    }
                    itemBaseCaja.Producto = listaControlEmpaquesTmp[0].Producto.ProductoNombre;
                    itemBaseCaja.OrdenNo = listaControlEmpaquesTmp[0].ControlEmpaqueNumeroOrden;
                    itemBaseCaja.RamosCaja = (int)listaControlEmpaquesTmp[0].ControlEmpaqueRamosCaja;
                    itemBaseCaja.TallosRamo = (int)listaControlEmpaquesTmp[0].ControlEmpaqueTallos;
                    itemBaseCaja.CajasDespachar = (int)listaControlEmpaquesTmp[0].ControlEmpaqueDespachar;
                    itemBaseCaja.Inspeccionado = (int)listaControlEmpaquesTmp[0].ControlEmpaqueTotal * 100 / itemBaseCaja.CajasDespachar;
                    itemBaseCaja.CajasRevisadas = (int)listaControlEmpaquesTmp[0].ControlEmpaqueTotal;
                    itemBaseCaja.CajasNoConformes = cajas;
                    itemBaseCaja.PorcentajeNoConformes = cajas * 100 / itemBaseCaja.CajasRevisadas;
                    itemBaseCaja.Qc = listaControlEmpaquesTmp[0].UsuarioControl.UsuarioControlCodigo;


                    if (reporte.BaseRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseRamo.Fecha) &&
                    bramos.Cliente.Equals(itemBaseRamo.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseRamo.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseRamo.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseRamo.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseRamo.Producto) &&
                    bramos.Marca.Equals(itemBaseRamo.Marca) &&
                    bramos.AtendidoPor.Equals(itemBaseRamo.AtendidoPor) &&
                    bramos.RamosRevisados == itemBaseRamo.RamosRevisados &&
                    bramos.RamosDespachar == itemBaseRamo.RamosDespachar
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseRamos.Add(itemBaseRamo);
                    }
                    if (reporte.BaseCajas.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseCaja.Fecha) &&
                    bramos.Cliente.Equals(itemBaseCaja.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseCaja.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseCaja.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseCaja.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseCaja.Producto) &&
                    bramos.Marca.Equals(itemBaseCaja.Marca) &&
                    bramos.Qc.Equals(itemBaseCaja.Qc) &&
                    bramos.RamosCaja == itemBaseCaja.RamosCaja &&
                    bramos.CajasRevisadas == itemBaseCaja.CajasRevisadas
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseCajas.Add(itemBaseCaja);
                    }


                    listaControlEmpaquesTmp.RemoveAll(lt => lt.ControlEmpaqueId == controlEmpaqueId);
                    List<Baseorden> baseOrdenTmp1 = baseOrdenes.Where(c => c.NumPed == itemBaseRamo.OrdenNo).ToList();
                    BaseTotalRamo itemBaseTotalRamos = new BaseTotalRamo();
                    if (baseOrdenTmp1.Count == 1)
                    {

                        itemBaseTotalRamos.Marca = baseOrdenTmp1[0].Marca;
                    }
                    else
                    {

                        itemBaseTotalRamos.Marca = itemBaseRamo.Marca;
                    }
                    itemBaseTotalRamos.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamos.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamos.PostCosecha = itemBaseRamo.PostCosecha;

                    itemBaseTotalRamos.Semana = fecha[0];
                    itemBaseTotalRamos.Mes = fecha[1];
                    itemBaseTotalRamos.Fecha = fecha[2];
                    itemBaseTotalRamos.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamos.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamos.PostCosecha = itemBaseRamo.PostCosecha;
                    itemBaseTotalRamos.Producto = itemBaseRamo.Producto;
                    itemBaseTotalRamos.OrdenNo = itemBaseRamo.OrdenNo;
                    itemBaseTotalRamos.Marca = itemBaseRamo.Marca;
                    itemBaseTotalRamos.Indicador = "No conformidad";
                    itemBaseTotalRamos.Causa = "No conformes";
                    itemBaseTotalRamos.CausaRelacionada = "Ramos no conformes";
                    itemBaseTotalRamos.TotalRamosCajas = ramos;
                    itemBaseTotalRamos.CodigoItem = "I";
                    itemBaseTotalRamos.Tipo = itemBaseRamo.Tipo;

                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseTotalRamos.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalRamos.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalRamos.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalRamos.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalRamos.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalRamos.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalRamos.Marca) &&
                    bramos.CodigoItem.Equals(itemBaseTotalRamos.CodigoItem) &&
                    bramos.TotalRamosCajas == itemBaseTotalRamos.TotalRamosCajas &&
                    bramos.Repeticion == itemBaseTotalRamos.Repeticion
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalRamos);
                    }



                    BaseTotalRamo itemBaseTotalRamosConf = new BaseTotalRamo();
                    if (baseOrdenTmp1.Count == 1)
                    {

                        itemBaseTotalRamosConf.Marca = baseOrdenTmp1[0].Marca;
                    }
                    else
                    {

                        itemBaseTotalRamosConf.Marca = itemBaseRamo.Marca;
                    }
                    itemBaseTotalRamosConf.ClienteMacro = itemBaseRamo.ClienteMacro;
                    itemBaseTotalRamosConf.Cliente = itemBaseRamo.Cliente;
                    itemBaseTotalRamosConf.PostCosecha = itemBaseRamo.PostCosecha;
                    itemBaseTotalRamosConf.Semana = fecha[0];
                    itemBaseTotalRamosConf.Mes = fecha[1];
                    itemBaseTotalRamosConf.Fecha = fecha[2];
                    itemBaseTotalRamosConf.Producto = itemBaseRamo.Producto;
                    itemBaseTotalRamosConf.OrdenNo = itemBaseRamo.OrdenNo;
                    itemBaseTotalRamosConf.Indicador = "Conformidad";
                    itemBaseTotalRamosConf.Causa = "Conformes";
                    itemBaseTotalRamosConf.CausaRelacionada = "Ramos conformes";
                    itemBaseTotalRamosConf.TotalRamosCajas = itemBaseRamo.RamosConformes;
                    itemBaseTotalRamosConf.Tipo = itemBaseRamo.Tipo;
                    itemBaseTotalRamosConf.CodigoItem = "0";


                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseTotalRamosConf.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalRamosConf.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalRamosConf.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalRamosConf.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalRamosConf.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalRamosConf.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalRamosConf.Marca) &&
                    bramos.CodigoItem.Equals(itemBaseTotalRamosConf.CodigoItem) &&
                    bramos.TotalRamosCajas == itemBaseTotalRamosConf.TotalRamosCajas &&
                    bramos.Repeticion == itemBaseTotalRamosConf.Repeticion
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalRamosConf);
                    }

                    BaseTotalRamo itemBaseTotalCajas = new BaseTotalRamo();
                    List<Baseorden> baseOrdenTmp2 = baseOrdenes.Where(c => c.NumPed == itemBaseCaja.OrdenNo).ToList();
                    if (baseOrdenTmp2.Count == 1)
                    {

                        itemBaseTotalCajas.Marca = baseOrdenTmp2[0].Marca;
                    }
                    else
                    {

                        itemBaseTotalCajas.Marca = itemBaseCaja.Marca;
                    }
                    itemBaseTotalCajas.ClienteMacro = itemBaseCaja.ClienteMacro;
                    itemBaseTotalCajas.Cliente = itemBaseCaja.Cliente;
                    itemBaseTotalCajas.PostCosecha = itemBaseCaja.PostCosecha;
                    itemBaseTotalCajas.Semana = fecha[0];
                    itemBaseTotalCajas.Mes = fecha[1];
                    itemBaseTotalCajas.Fecha = fecha[2];
                    itemBaseTotalCajas.Producto = itemBaseCaja.Producto;
                    itemBaseTotalCajas.OrdenNo = itemBaseCaja.OrdenNo;
                    itemBaseTotalCajas.Indicador = "No conformidad cajas";
                    itemBaseTotalCajas.Causa = "No conformes cajas";
                    itemBaseTotalCajas.CausaRelacionada = "Cajas no conformes";
                    itemBaseTotalCajas.TotalRamosCajas = cajas;
                    itemBaseTotalCajas.CodigoItem = "IC";
                    itemBaseTotalCajas.Tipo = itemBaseRamo.Tipo;
                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseTotalCajas.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalCajas.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalCajas.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalCajas.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalCajas.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalCajas.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalCajas.Marca) &&
                    bramos.CodigoItem.Equals(itemBaseTotalCajas.CodigoItem) &&
                    bramos.Repeticion == itemBaseTotalCajas.Repeticion
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalCajas);
                    }

                    BaseTotalRamo itemBaseTotalCajasConf = new BaseTotalRamo();

                    if (baseOrdenTmp2.Count == 1)
                    {

                        itemBaseTotalCajasConf.Marca = baseOrdenTmp2[0].Marca;
                    }
                    else
                    {

                        itemBaseTotalCajasConf.Marca = itemBaseCaja.Marca;
                    }
                    itemBaseTotalCajasConf.ClienteMacro = itemBaseCaja.ClienteMacro;
                    itemBaseTotalCajasConf.Cliente = itemBaseCaja.Cliente;
                    itemBaseTotalCajasConf.PostCosecha = itemBaseCaja.PostCosecha;
                    itemBaseTotalCajasConf.Semana = fecha[0];
                    itemBaseTotalCajasConf.Mes = fecha[1];
                    itemBaseTotalCajasConf.Fecha = fecha[2];
                    itemBaseTotalCajasConf.Producto = itemBaseCaja.Producto;
                    itemBaseTotalCajasConf.OrdenNo = itemBaseCaja.OrdenNo;
                    itemBaseTotalCajasConf.Indicador = "Conformidad cajas";
                    itemBaseTotalCajasConf.Causa = "Conformes cajas";
                    itemBaseTotalCajasConf.CausaRelacionada = "Cajas conformes";
                    itemBaseTotalCajasConf.TotalRamosCajas = itemBaseCaja.CajasRevisadas - cajas;
                    itemBaseTotalCajasConf.Tipo = itemBaseRamo.Tipo;
                    itemBaseTotalCajasConf.CodigoItem = "0C";

                    if (reporte.BaseTotalRamos.Count(bramos =>
                    bramos.Fecha.Equals(itemBaseTotalCajasConf.Fecha) &&
                    bramos.Cliente.Equals(itemBaseTotalCajasConf.Cliente) &&
                    bramos.ClienteMacro.Equals(itemBaseTotalCajasConf.ClienteMacro) &&
                    bramos.OrdenNo.Equals(itemBaseTotalCajasConf.OrdenNo) &&
                    bramos.PostCosecha.Equals(itemBaseTotalCajasConf.PostCosecha) &&
                    bramos.Producto.Equals(itemBaseTotalCajasConf.Producto) &&
                    bramos.Marca.Equals(itemBaseTotalCajasConf.Marca) &&
                    bramos.CodigoItem.Equals(itemBaseTotalCajasConf.CodigoItem) &&
                    bramos.Causa.Equals(itemBaseTotalCajasConf.Causa) &&
                    bramos.Indicador.Equals(itemBaseTotalCajasConf.Indicador) &&
                    bramos.TotalRamosCajas.Equals(itemBaseTotalCajasConf.TotalRamosCajas)
                    ) > 0)
                    {

                    }
                    else
                    {
                        reporte.BaseTotalRamos.Add(itemBaseTotalCajasConf);
                    }

                    while (listFalEmpaque.Count > 0)
                    {
                        int falenciaId = listFalEmpaque[0].FalenciaEmpaqueId;
                        List<Models.Falenciacontrolempaque> tmpFalencia = new List<Falenciacontrolempaque>();
                        tmpFalencia = listFalEmpaque.Where(lfe => lfe.FalenciaEmpaqueId == falenciaId).ToList();
                        BaseTotalRamo itemProblema = new BaseTotalRamo();
                        if (baseOrdenTmp2.Count == 1)
                        {

                            itemProblema.Marca = baseOrdenTmp2[0].Marca;
                        }
                        else
                        {

                            itemProblema.Marca = itemBaseCaja.Marca;
                        }
                        itemProblema.ClienteMacro = itemBaseCaja.ClienteMacro;
                        itemProblema.Cliente = itemBaseCaja.Cliente;
                        itemProblema.PostCosecha = itemBaseCaja.PostCosecha;
                        itemProblema.Semana = fecha[0];
                        itemProblema.Mes = fecha[1];
                        itemProblema.Fecha = fecha[2];
                        itemProblema.ClienteMacro = itemBaseCaja.ClienteMacro;
                        itemProblema.Cliente = itemBaseCaja.Cliente;
                        itemProblema.PostCosecha = itemBaseCaja.PostCosecha;
                        itemProblema.Producto = itemBaseCaja.Producto;
                        itemProblema.OrdenNo = itemBaseCaja.OrdenNo;
                        itemProblema.Marca = itemBaseCaja.Marca;
                        itemProblema.Indicador = tmpFalencia[0].FalenciaEmpaque.CategoriaFalenciaEmpaqueNavigation.CategoriaFalenciaNombre;
                        itemProblema.Causa = tmpFalencia[0].FalenciaEmpaque.MacroFalencia.MacroFalenciaNombre;
                        itemProblema.CausaRelacionada = tmpFalencia[0].FalenciaEmpaque.FalenciaEmpaqueNombre;
                        itemProblema.Repeticion = tmpFalencia.Count;
                        itemProblema.CodigoItem = listFalEmpaque[0].FalenciaEmpaque.Codigo;
                        itemProblema.Tipo = itemBaseRamo.Tipo;
                        if (reporte.ProblemasRamoEmpaque.Count(bramos => bramos.Fecha.Equals(itemProblema.Fecha)
                        && bramos.Cliente.Equals(itemProblema.Cliente)
                        && bramos.ClienteMacro.Equals(itemProblema.ClienteMacro)
                        && bramos.OrdenNo.Equals(itemProblema.OrdenNo)
                        && bramos.PostCosecha.Equals(itemProblema.PostCosecha)
                        && bramos.Producto.Equals(itemProblema.Producto)
                        && bramos.Marca.Equals(itemProblema.Marca)
                        && bramos.CodigoItem.Equals(itemProblema.CodigoItem)
                        && bramos.Causa.Equals(itemProblema.Causa)
                        && bramos.Indicador.Equals(itemProblema.Indicador)
                        && bramos.Repeticion.Equals(itemProblema.Repeticion)) > 0)
                        {

                        }
                        else
                        {
                            reporte.ProblemasRamoEmpaque.Add(itemProblema);
                        }



                        listFalEmpaque.RemoveAll(r => r.FalenciaEmpaqueId == falenciaId);
                    }



                }

                List<Models.ProcesoHidratacion> listaHidratacion = _context.ProcesoHidratacion.Where(c => new DateTime(c.ProcesoHidratacionFecha.Value.Year, c.ProcesoHidratacionFecha.Value.Month, c.ProcesoHidratacionFecha.Value.Day, 0, 0, 0) >= fechaDesde && new DateTime(c.ProcesoHidratacionFecha.Value.Year, c.ProcesoHidratacionFecha.Value.Month, c.ProcesoHidratacionFecha.Value.Day, 0, 0, 0) <= fechaHasta).Include(h => h.Postcosecha).ToList();

                listaHidratacion.ForEach(c =>
                {
                    string[] fecha = transformarFecha(Convert.ToDateTime(c.ProcesoHidratacionFecha));
                    ChlEmpaque item = new ChlEmpaque();
                    item.Semana = fecha[0];
                    item.Mes = fecha[1];
                    item.Fecha = fecha[2];
                    item.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item.ItemControl = "Estado de Soluciones";
                    item.Cumple = c.ProcesoHidratacionEstadoSoluciones == 0 ? true : false;

                    ChlEmpaque item1 = new ChlEmpaque();
                    item1.Semana = fecha[0];
                    item1.Mes = fecha[1];
                    item1.Fecha = fecha[2];
                    item1.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item1.ItemControl = "Tiempo de Hidratación";
                    item1.Cumple = c.ProcesoHidratacionEstadoSoluciones == 0 ? true : false;

                    ChlEmpaque item2 = new ChlEmpaque();
                    item2.Semana = fecha[0];
                    item2.Mes = fecha[1];
                    item2.Fecha = fecha[2];
                    item2.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item2.ItemControl = "Cantidad Ramos Tinas";
                    item2.Cumple = c.ProcesoHidratacionCantidadRamos == 0 ? true : false;

                    ChlEmpaque item3 = new ChlEmpaque();
                    item3.Semana = fecha[0];
                    item3.Mes = fecha[1];
                    item3.Fecha = fecha[2];
                    item3.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item3.ItemControl = "Ph Solución";
                    item3.Cumple = c.ProcesoHidratacionPhSolucion >= 4 && c.ProcesoHidratacionPhSolucion <= 5 ? true : false;

                    ChlEmpaque item4 = new ChlEmpaque();
                    item4.Semana = fecha[0];
                    item4.Mes = fecha[1];
                    item4.Fecha = fecha[2];
                    item4.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item4.ItemControl = "Nivel Solución";
                    item4.Cumple = c.ProcesoHidratacionNivelSolucion >= 5 && c.ProcesoHidratacionNivelSolucion <= 10 ? true : false;

                    reporte.ChlHidratacion.Add(item);
                    reporte.ChlHidratacion.Add(item1);
                    reporte.ChlHidratacion.Add(item2);
                    reporte.ChlHidratacion.Add(item3);
                    reporte.ChlHidratacion.Add(item4);

                });

                List<Models.ProcesoEmpaque> listaProcesoEmpaque = _context.ProcesoEmpaque.Where(c => new DateTime(c.ProcesoEmpaqueFecha.Value.Year, c.ProcesoEmpaqueFecha.Value.Month, c.ProcesoEmpaqueFecha.Value.Day, 0, 0, 0) >= fechaDesde && new DateTime(c.ProcesoEmpaqueFecha.Value.Year, c.ProcesoEmpaqueFecha.Value.Month, c.ProcesoEmpaqueFecha.Value.Day, 0, 0, 0) <= fechaHasta).Include(h => h.Postcosecha).ToList();

                listaProcesoEmpaque.ForEach(c =>
                {
                    string[] fecha = transformarFecha(Convert.ToDateTime(c.ProcesoEmpaqueFecha));
                    ChlEmpaque item = new ChlEmpaque();
                    item.Semana = fecha[0];
                    item.Mes = fecha[1];
                    item.Fecha = fecha[2];
                    item.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item.ItemControl = "Alturas de pallets adecuado";
                    item.Cumple = c.ProcesoEmpaqueAltura == 0 ? true : false;

                    ChlEmpaque item1 = new ChlEmpaque();
                    item1.Semana = fecha[0];
                    item1.Mes = fecha[1];
                    item1.Fecha = fecha[2];
                    item1.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item1.ItemControl = "Cajas en buenas condiciones";
                    item1.Cumple = c.ProcesoEmpaqueCajas == 0 ? true : false;

                    ChlEmpaque item2 = new ChlEmpaque();
                    item2.Semana = fecha[0];
                    item2.Mes = fecha[1];
                    item2.Fecha = fecha[2];
                    item2.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item2.ItemControl = "Sujeción correcta";
                    item2.Cumple = c.ProcesoEmpaqueSujeccion == 0 ? true : false;

                    ChlEmpaque item3 = new ChlEmpaque();
                    item3.Semana = fecha[0];
                    item3.Mes = fecha[1];
                    item3.Fecha = fecha[2];
                    item3.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item3.ItemControl = "Movimientos y traslados correctos";
                    item3.Cumple = c.ProcesoEmpaqueMovimientos == 0 ? true : false;

                    ChlEmpaque item4 = new ChlEmpaque();
                    item4.Semana = fecha[0];
                    item4.Mes = fecha[1];
                    item4.Fecha = fecha[2];
                    item4.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item4.ItemControl = "Temperatura cuarto frío adecuada";
                    item4.Cumple = c.ProcesoEmpaqueTemperaturaCuartoFrio == 0 ? true : false;

                    ChlEmpaque item5 = new ChlEmpaque();
                    item5.Semana = fecha[0];
                    item5.Mes = fecha[1];
                    item5.Fecha = fecha[2];
                    item5.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item5.ItemControl = "Temperatura de cajas empacadas adecuada";
                    item5.Cumple = c.ProcesoEmpaqueTemperaturaCajas == 0 ? true : false;

                    ChlEmpaque item6 = new ChlEmpaque();
                    item6.Semana = fecha[0];
                    item6.Mes = fecha[1];
                    item6.Fecha = fecha[2];
                    item6.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item6.ItemControl = "Temperatura de camión adecuada";
                    item6.Cumple = c.ProcesoEmpaqueTemperaturaCamion == 0 ? true : false;

                    ChlEmpaque item7 = new ChlEmpaque();
                    item7.Semana = fecha[0];
                    item7.Mes = fecha[1];
                    item7.Fecha = fecha[2];
                    item7.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item7.ItemControl = "Apilamiento de cajas adecuada";
                    item7.Cumple = c.ProcesoEmpaqueApilamiento == 0 ? true : false;

                    reporte.ChlEmpaque.Add(item);
                    reporte.ChlEmpaque.Add(item1);
                    reporte.ChlEmpaque.Add(item2);
                    reporte.ChlEmpaque.Add(item3);
                    reporte.ChlEmpaque.Add(item4);
                    reporte.ChlEmpaque.Add(item5);
                    reporte.ChlEmpaque.Add(item6);
                    reporte.ChlEmpaque.Add(item7);

                });

                List<Models.Temperatura> listaTemperaturas = _context.Temperatura.Where(c => new DateTime(c.TemperaturaFecha.Value.Year, c.TemperaturaFecha.Value.Month, c.TemperaturaFecha.Value.Day, 0, 0, 0) >= fechaDesde && new DateTime(c.TemperaturaFecha.Value.Year, c.TemperaturaFecha.Value.Month, c.TemperaturaFecha.Value.Day, 0, 0, 0) <= fechaHasta).Include(h => h.Postcosecha).ToList();

                listaTemperaturas.ForEach(c =>
                {
                    string[] fecha = transformarFecha(Convert.ToDateTime(c.TemperaturaFecha));
                    ChlEmpaque item = new ChlEmpaque();
                    item.Semana = fecha[0];
                    item.Mes = fecha[1];
                    item.Fecha = fecha[2];
                    item.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item.ItemControl = "Temperatura de cajas";
                    item.Valor = Convert.ToDecimal(c.TemperaturaInterna);

                    ChlEmpaque item1 = new ChlEmpaque();
                    item1.Semana = fecha[0];
                    item1.Mes = fecha[1];
                    item1.Fecha = fecha[2];
                    item1.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item1.ItemControl = "Temperatura cuarto frío";
                    item1.Valor = Convert.ToDecimal(c.TemperaturaExterna);

                    reporte.Temperaturas.Add(item);
                    reporte.Temperaturas.Add(item1);

                });

                List<Models.Actividad> listaActividades = _context.Actividad.Where(c => new DateTime(c.ActividadFecha.Value.Year, c.ActividadFecha.Value.Month, c.ActividadFecha.Value.Day, 0, 0, 0) >= fechaDesde && new DateTime(c.ActividadFecha.Value.Year, c.ActividadFecha.Value.Month, c.ActividadFecha.Value.Day, 0, 0, 0) <= fechaHasta).Include(a => a.Postcosecha).Include(a => a.UsuarioControl).ToList();

                listaActividades.ForEach(c =>
                {
                    string[] fecha = transformarFecha(Convert.ToDateTime(c.ActividadFecha));
                    ActividadesQc item = new ActividadesQc();
                    item.Semana = fecha[0];
                    item.Mes = fecha[1];
                    item.Fecha = fecha[2];
                    DateTime desde = new DateTime(2020, 1, 1, Convert.ToInt32(c.ActividadHoraInicio.Split(':')[0]), Convert.ToInt32(c.ActividadHoraInicio.Split(':')[1]), 0);
                    DateTime hasta = new DateTime(2020, 1, 1, Convert.ToInt32(c.ActividadHoraFin.Split(':')[0]), Convert.ToInt32(c.ActividadHoraFin.Split(':')[1]), 0);
                    item.Tiempo = (decimal)(hasta - desde).TotalMinutes;
                    item.CodigoQc = c.UsuarioControl.UsuarioControlCodigo;
                    item.PostCosecha = c.Postcosecha.PostcosechaNombre;
                    item.Actividad = c.ActividadDetalle;
                    reporte.ActividadesQc.Add(item);
                });
            }
            



            return reporte;
        }
        private string[] transformarFecha(DateTime fecha)
        {
            string[] lista = new string[3];
            GregorianCalendar cal = new GregorianCalendar(GregorianCalendarTypes.Localized);
            cal.GetWeekOfYear(fecha, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);
            lista[0] = fecha.Year.ToString() + cal.GetWeekOfYear(fecha, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString();
            lista[1] = fecha.ToString("MMMM", new CultureInfo("es-Es")).ToUpper();
            lista[2] = fecha.ToString("dd-MMM", new CultureInfo("es-Es"));
            return lista;
        }
        [HttpPost("temperatura")]
        public dynamic PostTemperatura([FromBody] List<RegistroTemperatura> value)
        {
            List<Entidades.RegistroTemperatura> listaTemperaturas = new List<RegistroTemperatura>();
            listaTemperaturas = value;
            int empId = 0;
            try
            {
                empId = listaTemperaturas[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            
            try
            {
                for (int i = 0; i < listaTemperaturas.Count; i++)
                {
                    Models.Temperatura item = new Temperatura();
                    item.TemperaturaFecha = Convert.ToDateTime(listaTemperaturas[i].TemperaturaFecha);
                    item.TemperaturaInterna = listaTemperaturas[i].TemperaturaInterna;
                    item.TemperaturaExterna = listaTemperaturas[i].TemperaturaExterna;
                    item.UsuarioControlId = listaTemperaturas[i].UsuarioId;
                    item.PostcosechaId = listaTemperaturas[i].PostcosechaId;
                    _context.Temperatura.Add(item);
                    _context.SaveChanges();
                }
                return Ok(1);
            }
            catch (Exception e)
            {
                
                return BadRequest("temp" + e.Message.ToString() + e.Source.ToString());
            }
        }
        [HttpPost("hidratacion")]
        public dynamic PostHidratacion([FromBody] List<RegistroHidratacion> value)
        {
            List<Entidades.RegistroHidratacion> listaHidratacion = new List<RegistroHidratacion>();
            listaHidratacion = value;
            int empId = 0;
            try
            {
                empId = listaHidratacion[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                for (int i = 0; i < listaHidratacion.Count; i++)
                {
                    Models.ProcesoHidratacion item = new ProcesoHidratacion();
                    item.ProcesoHidratacionEstadoSoluciones = listaHidratacion[i].ProcesoHidratacionEstadoSoluciones;
                    item.ProcesoHidratacionFecha = Convert.ToDateTime(listaHidratacion[i].ProcesoHidratacionFecha);
                    item.ProcesoHidratacionCantidadRamos = listaHidratacion[i].ProcesoHidratacionCantidadRamos;
                    item.ProcesoHidratacionNivelSolucion = listaHidratacion[i].ProcesoHidratacionNivelSolucion;
                    item.ProcesoHidratacionTiempo = listaHidratacion[i].ProcesoHidratacionTiemposHidratacion;
                    item.UsuarioControlId = listaHidratacion[i].UsuarioId;
                    item.ProcesoHidratacionPhSolucion = listaHidratacion[i].ProcesoHidratacionPhSolucion;
                    item.PostcosechaId = listaHidratacion[i].PostcosechaId;
                    _context.ProcesoHidratacion.Add(item);
                    _context.SaveChanges();
                }
                return Ok(1);
            }
            catch (Exception e)
            {
                
                return BadRequest("phid" + e.Message.ToString() + e.Source.ToString());
            }
        }
        [HttpPost("actividad")]
        public dynamic PostActividad([FromBody] List<Actividade> value)
        {
            List<Entidades.Actividade> listaActividades = new List<Actividade>();
            listaActividades = value;
            int empId = 0;
            try
            {
                empId = listaActividades[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                for (int i = 0; i < listaActividades.Count; i++)
                {
                    Models.Actividad item = new Actividad();
                    item.ActividadDetalle = listaActividades[i].ActividadDetalle;
                    item.ActividadFecha = Convert.ToDateTime(listaActividades[i].ActividadFecha);
                    item.ActividadHoraInicio = listaActividades[i].ActividadHoraInicio;
                    item.ActividadHoraFin = listaActividades[i].ActividadHoraFin;
                    item.UsuarioControlId = listaActividades[i].UsuarioId;
                    item.PostcosechaId = listaActividades[i].PostcosechaId;
                    _context.Actividad.Add(item);
                    _context.SaveChangesAsync();
                }
                return Ok(1);
            }
            catch (Exception e)
            {
                
                return BadRequest("act" + e.Message.ToString() + e.Source.ToString());
            }
        }
        [HttpPost("pempaque")]
        public dynamic PostProcesoEmpaque([FromBody] List<Entidades.ProcesoEmpaque> value)
        {
            List<Entidades.ProcesoEmpaque> listaProcesoEmpaque = new List<Entidades.ProcesoEmpaque>();
            listaProcesoEmpaque = value;
            int empId = 0;
            try
            {
                empId = listaProcesoEmpaque[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                for (int i = 0; i < listaProcesoEmpaque.Count; i++)
                {
                    Models.ProcesoEmpaque item = new Models.ProcesoEmpaque();
                    item.ProcesoEmpaqueAltura = listaProcesoEmpaque[i].ProcesoEmpaqueAltura;
                    item.ProcesoEmpaqueFecha = Convert.ToDateTime(listaProcesoEmpaque[i].ProcesoEmpaqueFecha);
                    item.ProcesoEmpaqueCajas = listaProcesoEmpaque[i].ProcesoEmpaqueCajas;
                    item.ProcesoEmpaqueSujeccion = listaProcesoEmpaque[i].ProcesoEmpaqueSujeccion;
                    item.UsuarioControlId = listaProcesoEmpaque[i].UsuarioId;
                    item.ProcesoEmpaqueMovimientos = listaProcesoEmpaque[i].ProcesoEmpaqueMovimientos;
                    item.ProcesoEmpaqueTemperaturaCuartoFrio = listaProcesoEmpaque[i].ProcesoEmpaqueTemperaturaCuartoFrio;
                    item.ProcesoEmpaqueTemperaturaCajas = listaProcesoEmpaque[i].ProcesoEmpaqueTemperaturaCajas;
                    item.ProcesoEmpaqueTemperaturaCamion = listaProcesoEmpaque[i].ProcesoEmpaqueTemperaturaCamion;
                    item.ProcesoEmpaqueApilamiento = listaProcesoEmpaque[i].ProcesoEmpaqueApilamiento;
                    item.PostcosechaId = listaProcesoEmpaque[i].PostcosechaId;
                    _context.ProcesoEmpaque.Add(item);
                    _context.SaveChanges();
                }
                return Ok(1);
            }
            catch (Exception e)
            {
                
                return BadRequest("pemp" + e.Message.ToString() + e.Source.ToString());
            }
        }
        [HttpPost("empaque")]
        public dynamic PostEmpaque([FromBody] ReporteSincronizacion value)
        {
            List<Control> controlesGuardados = new List<Control>();

            List<Entidades.Firma> listaFirmas = new List<Entidades.Firma>();
            listaFirmas = value.Firmas;
            int empId = 0;
            
            try
            {
                for (int i = 0; i < listaFirmas.Count; i++)
                {
                    List<Models.Firma> firmaExiste = new List<Models.Firma>();
                    firmaExiste = _context.Firma.Where(c => c.FirmaNombre.CompareTo(listaFirmas[i].FirmaNombre) == 0).ToList();
                    if (firmaExiste.Count > 0)
                    {
                        listaFirmas[i].FirmaReal = firmaExiste[0].FirmaId;
                    }
                    else
                    {
                        Models.Firma item = new Models.Firma();
                        item.FirmaNombre = listaFirmas[i].FirmaNombre;
                        item.FirmaCorreo = listaFirmas[i].FirmaCorreo;
                        item.FirmaCodigo = listaFirmas[i].FirmaCodigo;
                        item.FirmaCargo = listaFirmas[i].FirmaCargo;
                        _context.Firma.Add(item);
                        _context.SaveChanges();
                        listaFirmas[i].FirmaReal = item.FirmaId;
                    }
                }
            }
            catch (Exception e)
            {
                return BadRequest("firam" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.DetallesFirma> listaDetalles = new List<DetallesFirma>();
            List<Entidades.DetallesFirma> listaDetallesReporte = new List<DetallesFirma>();
            listaDetalles = value.DetallesFirma;
            try
            {
                while (listaFirmas.Count > 0)
                {
                    int firmaId = listaFirmas[0].FirmaId;
                    List<Entidades.DetallesFirma> tmpDetalles = new List<DetallesFirma>();
                    tmpDetalles = listaDetalles.Where(d => d.FirmaId == firmaId).ToList();
                    for (int i = 0; i < tmpDetalles.Count; i++)
                    {
                        Models.DetalleFirma item = new DetalleFirma();
                        item.FirmaId = listaFirmas[0].FirmaReal;
                        item.DetalleFirmaCodigo = tmpDetalles[i].FirmaCodigo;
                        _context.DetalleFirma.Add(item);
                        _context.SaveChanges();
                        tmpDetalles[i].FirmaReal = item.DetalleFirmaId;
                    }
                    listaDetallesReporte.AddRange(tmpDetalles);
                    listaFirmas.RemoveAll(l => l.FirmaId == firmaId);
                }
            }
            catch (Exception e)
            {
                return BadRequest("detfirma" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.ListaEmpaque> listaEmpaque = new List<Entidades.ListaEmpaque>();
            listaEmpaque = value.ListaEmpaque;
            try
            {
                empId = listaEmpaque[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                while (listaEmpaque.Count > 0)
                {
                    int controlEmpaqueId = listaEmpaque[0].ControlEmpaqueId;
                    Models.Controlempaque item = new Controlempaque();
                    item.ClienteId = listaEmpaque[0].ClienteId;
                    item.ControlEmpaqueNumeroOrden = listaEmpaque[0].EmpaqueNumeroOrden;
                    item.ProductoId = listaEmpaque[0].ProductoId;
                    item.PostcosechaId = listaEmpaque[0].PostcosechaId;
                    item.Marca = listaEmpaque[0].EmpaqueMarca;
                    item.ControlEmpaqueFecha = Convert.ToDateTime(listaEmpaque[0].EmpaqueFecha);
                    item.ControlEmpaqueDespachar = listaEmpaque[0].EmpaqueDespachar;
                    item.ControlEmpaqueTotal = listaEmpaque[0].EmpaqueTotal;
                    item.ControlEmpaqueRamosCaja = listaEmpaque[0].EmpaqueRamos;
                    item.ControlEmpaqueRamosRevisar = listaEmpaque[0].EmpaqueRamosRevisar;
                    item.ControlEmpaqueTallos = listaEmpaque[0].EmpaqueTallos;
                    item.ControlEmpaqueDerogado = listaEmpaque[0].EmpaqueDerogado;
                    item.UsuarioControlId = listaEmpaque[0].UsuarioId;
                    item.ControlEmpaqueTiempo = listaEmpaque[0].EmpaqueTiempo;
                    item.DetalleFirmaId = listaDetallesReporte.Find(c => c.DetalleFirmaId == listaEmpaque[0].DetalleFirmaId).FirmaReal;
                    _context.Controlempaque.Add(item);
                    _context.SaveChanges();
                    for (int i = 0; i < listaEmpaque[0].Empaques.Count; i++)
                    {
                        Models.Empaque empaque = new Models.Empaque();
                        empaque.ControlEmpaqueId = item.ControlEmpaqueId;
                        _context.Empaque.Add(empaque);
                        _context.SaveChanges();
                        for (int j = 0; j < listaEmpaque[0].Empaques[i].Falencias.Count; j++)
                        {
                            Models.Falenciacontrolempaque falEmpaque = new Falenciacontrolempaque();
                            falEmpaque.EmpaqueId = empaque.EmpaqueId;
                            falEmpaque.FalenciaEmpaqueId = listaEmpaque[0].Empaques[i].Falencias[j].FalenciaEmpaqueId;
                            falEmpaque.FalenciaControlEmpaqueCantidad = listaEmpaque[0].Empaques[i].Falencias[j].Cantidad;
                            _context.Falenciacontrolempaque.Add(falEmpaque);
                            _context.SaveChanges();
                        }

                    }
                    Control control = new Control();
                    control.id = controlEmpaqueId;
                    controlesGuardados.Add(control);
                    listaEmpaque.RemoveAll(cEmpaque =>
                        cEmpaque.ClienteId == item.ClienteId &&
                        cEmpaque.ProductoId == item.ProductoId &&
                        cEmpaque.PostcosechaId == item.PostcosechaId &&
                        cEmpaque.EmpaqueNumeroOrden.Equals(item.ControlEmpaqueNumeroOrden) &&
                        cEmpaque.EmpaqueMarca.Equals(item.Marca) &&
                        cEmpaque.EmpaqueTotal == item.ControlEmpaqueTotal &&
                        cEmpaque.EmpaqueDespachar == item.ControlEmpaqueDespachar &&
                        cEmpaque.EmpaqueRamos == item.ControlEmpaqueRamosCaja &&
                        cEmpaque.EmpaqueRamosRevisar == item.ControlEmpaqueRamosRevisar
                    );


                }
            }
            catch (Exception e)
            {
                return BadRequest("emp" + e.Message.ToString() + e.InnerException.ToString());
            }


            return Ok(controlesGuardados);
        }
        [HttpPost("ramos")]
        public dynamic PostRamos([FromBody] ReporteSincronizacionRamos value)
        {
            List<Control> controlesGuardados = new List<Control>();
            List<Entidades.Firma> listaFirmas = new List<Entidades.Firma>();
            listaFirmas = value.Firmas;
            int empId = 0;
            try
            {
                for (int i = 0; i < listaFirmas.Count; i++)
                {
                    List<Models.Firma> firmaExiste = new List<Models.Firma>();
                    firmaExiste = _context.Firma.Where(c => c.FirmaNombre.CompareTo(listaFirmas[i].FirmaNombre) == 0).ToList();
                    if (firmaExiste.Count > 0)
                    {
                        listaFirmas[i].FirmaReal = firmaExiste[0].FirmaId;
                    }
                    else
                    {
                        Models.Firma item = new Models.Firma();
                        item.FirmaNombre = listaFirmas[i].FirmaNombre;
                        item.FirmaCorreo = listaFirmas[i].FirmaCorreo;
                        item.FirmaCodigo = listaFirmas[i].FirmaCodigo;
                        item.FirmaCargo = listaFirmas[i].FirmaCargo;
                        _context.Firma.Add(item);
                        _context.SaveChanges();
                        listaFirmas[i].FirmaReal = item.FirmaId;
                    }
                }
            }
            catch (Exception e)
            {
                return BadRequest("firam" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.DetallesFirma> listaDetalles = new List<DetallesFirma>();
            List<Entidades.DetallesFirma> listaDetallesReporte = new List<DetallesFirma>();
            listaDetalles = value.DetallesFirma;
            try
            {
                while (listaFirmas.Count > 0)
                {
                    int firmaId = listaFirmas[0].FirmaId;
                    List<Entidades.DetallesFirma> tmpDetalles = new List<DetallesFirma>();
                    tmpDetalles = listaDetalles.Where(d => d.FirmaId == firmaId).ToList();
                    for (int i = 0; i < tmpDetalles.Count; i++)
                    {
                        Models.DetalleFirma item = new DetalleFirma();
                        item.FirmaId = listaFirmas[0].FirmaReal;
                        item.DetalleFirmaCodigo = tmpDetalles[i].FirmaCodigo;
                        _context.DetalleFirma.Add(item);
                        _context.SaveChanges();
                        tmpDetalles[i].FirmaReal = item.DetalleFirmaId;
                    }
                    listaDetallesReporte.AddRange(tmpDetalles);
                    listaFirmas.RemoveAll(l => l.FirmaId == firmaId);
                }
            }
            catch (Exception e)
            {
                
                return BadRequest("detfirma" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.ListaRamo> listaRamo = new List<Entidades.ListaRamo>();
            listaRamo = value.ListaRamo;
            try
            {
                empId = listaRamo[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                while (listaRamo.Count > 0)
                {
                    int controlRamoId = listaRamo[0].ControlRamosId;
                    Models.Controlramo item = new Controlramo();
                    item.ClienteId = listaRamo[0].ClienteId;
                    item.ControlRamoNumeroOrden = listaRamo[0].RamosNumeroOrden;
                    item.ProductoId = listaRamo[0].ProductoId;
                    item.PostcosechaId = listaRamo[0].PostcosechaId;
                    item.Marca = listaRamo[0].RamosMarca;
                    item.ControlRamoDespachar = listaRamo[0].RamosDespachar;
                    item.ControlRamoTotal = listaRamo[0].RamosTotal;
                    item.ControlRamoElaborados = listaRamo[0].RamosElaborados;
                    item.ControlRamoTallos = listaRamo[0].RamosTallos;
                    item.ControlRamoDerogado = listaRamo[0].RamosDerogado;
                    item.UsuarioControlId = listaRamo[0].UsuarioId;
                    item.ControlRamoTiempo = listaRamo[0].RamosTiempo;
                    item.ControlRamoFecha = Convert.ToDateTime(listaRamo[0].RamosFecha);
                    item.DetalleFirmaId = listaDetallesReporte.Find(c => c.DetalleFirmaId == listaRamo[0].DetalleFirmaId).FirmaReal;

                    _context.Controlramo.Add(item);
                    _context.SaveChanges();
                    for (int i = 0; i < listaRamo[0].Ramos.Count; i++)
                    {
                        Models.Ramo ramo = new Models.Ramo();
                        ramo.ControlRamoId = item.ControlRamoId;
                        _context.Ramo.Add(ramo);
                        _context.SaveChanges();
                        for (int j = 0; j < listaRamo[0].Ramos[i].Falencias.Count; j++)
                        {
                            Models.Falenciascontrolramo falRamo = new Falenciascontrolramo();
                            falRamo.RamoId = ramo.RamoId;
                            falRamo.FalenciaRamoId = listaRamo[0].Ramos[i].Falencias[j].FalenciaRamoId;
                            falRamo.FalenciaControlRamoCantidad = listaRamo[0].Ramos[i].Falencias[j].Cantidad;
                            _context.Falenciascontrolramo.Add(falRamo);
                            _context.SaveChanges();
                        }

                    }
                    Control control = new Control();
                    control.id = controlRamoId;
                    controlesGuardados.Add(control);
                    listaRamo.RemoveAll(cEmpaque =>
                          cEmpaque.ClienteId == item.ClienteId &&
                          cEmpaque.ProductoId == item.ProductoId &&
                          cEmpaque.PostcosechaId == item.PostcosechaId &&
                          cEmpaque.RamosNumeroOrden.Equals(item.ControlRamoNumeroOrden) &&
                          cEmpaque.RamosMarca.Equals(item.Marca) &&
                          cEmpaque.RamosTotal == item.ControlRamoTotal &&
                          cEmpaque.RamosDespachar == item.ControlRamoDespachar &&
                          cEmpaque.RamosDespachar == item.ControlRamoDespachar &&
                          cEmpaque.RamosElaborados == item.ControlRamoElaborados &&
                          cEmpaque.RamosTallos == item.ControlRamoTallos);
                }
            }
            catch (Exception e)
            {
                return BadRequest("ramo" + e.Message.ToString() + e.InnerException.ToString());
            }
            return Ok(controlesGuardados);
        }
        [HttpPost("banda")]
        public dynamic PostBanda([FromBody] ReporteSincronizacionBanda value)
        {
            List<Entidades.Firma> listaFirmas = new List<Entidades.Firma>();
            listaFirmas = value.Firmas;
            int empId = 0;
            try
            {
                for (int i = 0; i < listaFirmas.Count; i++)
                {
                    List<Models.Firma> firmaExiste = new List<Models.Firma>();
                    firmaExiste = _context.Firma.Where(c => c.FirmaNombre.CompareTo(listaFirmas[i].FirmaNombre) == 0).ToList();
                    if (firmaExiste.Count > 0)
                    {
                        listaFirmas[i].FirmaReal = firmaExiste[0].FirmaId;
                    }
                    else
                    {
                        Models.Firma item = new Models.Firma();
                        item.FirmaNombre = listaFirmas[i].FirmaNombre;
                        item.FirmaCorreo = listaFirmas[i].FirmaCorreo;
                        item.FirmaCodigo = listaFirmas[i].FirmaCodigo;
                        item.FirmaCargo = listaFirmas[i].FirmaCargo;
                        _context.Firma.Add(item);
                        _context.SaveChanges();
                        listaFirmas[i].FirmaReal = item.FirmaId;
                    }
                }
            }
            catch (Exception e)
            {
                return BadRequest("firam" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.DetallesFirma> listaDetalles = new List<DetallesFirma>();
            List<Entidades.DetallesFirma> listaDetallesReporte = new List<DetallesFirma>();
            listaDetalles = value.DetallesFirma;
            try
            {
                while (listaFirmas.Count > 0)
                {
                    int firmaId = listaFirmas[0].FirmaId;
                    List<Entidades.DetallesFirma> tmpDetalles = new List<DetallesFirma>();
                    tmpDetalles = listaDetalles.Where(d => d.FirmaId == firmaId).ToList();
                    for (int i = 0; i < tmpDetalles.Count; i++)
                    {
                        Models.DetalleFirma item = new DetalleFirma();
                        item.FirmaId = listaFirmas[0].FirmaReal;
                        item.DetalleFirmaCodigo = tmpDetalles[i].FirmaCodigo;
                        _context.DetalleFirma.Add(item);
                        _context.SaveChanges();
                        tmpDetalles[i].FirmaReal = item.DetalleFirmaId;
                    }
                    listaDetallesReporte.AddRange(tmpDetalles);
                    listaFirmas.RemoveAll(l => l.FirmaId == firmaId);
                }
            }
            catch (Exception e)
            {

                return BadRequest("detfirma" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.FinBanda> listaBanda = new List<Entidades.FinBanda>();
            listaBanda = value.ListaBanda;
            try
            {
                empId = listaBanda[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                while (listaBanda.Count > 0)
                {
                    int id = listaBanda[0].ControlBandaId;
                    Controlbanda item = new Controlbanda();
                    item.UsuarioControlId = listaBanda[0].UsuarioId;
                    item.ControlBandaNumeroOrden = listaBanda[0].ControlNumeroOrden;
                    item.ControlBandaTotal = listaBanda[0].BandaRamos;
                    item.ControlBandaFecha = listaBanda[0].BandaFecha;
                    item.ControlBandaAprobado = listaBanda[0].BandaAprobado;
                    item.ControlBandaTallos = listaBanda[0].BandaTallos;
                    item.ControlBandaDerogado = listaBanda[0].BandaDerogado;
                    item.ControlBandaElaborados = listaBanda[0].BandaElaborado;
                    item.ControlBandaDespachar = listaBanda[0].BandaDespachado;
                    item.PostcosechaId = listaBanda[0].PostCosechaId;
                    item.ClienteId = listaBanda[0].ClienteId;
                    item.ProductoId = listaBanda[0].ProductoId;
                    item.Marca = listaBanda[0].Marca;
                    item.TipoControlId = listaBanda[0].TipoId;
                    item.DetalleFirmaId=listaDetallesReporte.Find(c => c.DetalleFirmaId == listaBanda[0].DetalleFirmaId).FirmaReal;
                    _context.Controlbanda.Add(item);
                    _context.SaveChanges();
                    for (int i = 0; i < listaBanda[0].BandaProblemas.Count; i++)
                    {
                        Problemabanda itemProblema = new Problemabanda();
                        itemProblema.ControlBandaId = item.ControlBandaId;
                        itemProblema.FalenciaRamoId = listaBanda[0].BandaProblemas[i].FalenciaRamosId;
                        itemProblema.RamosNoConformes = listaBanda[0].BandaProblemas[i].FalenciaBandaRamos;
                        _context.Problemabanda.Add(itemProblema);
                        _context.SaveChanges();
                    }
                    listaBanda.RemoveAll(b => b.ControlBandaId == id);
                }
            }
            catch (Exception e)
            {
                return BadRequest("banda" + e.Message.ToString() + e.InnerException.ToString());
            }
            return Ok();
        }
        [HttpPost("ecuador")]
        public dynamic PostEcuador([FromBody] ReporteSincronizacionEcuador value)
        {
            List<Entidades.Firma> listaFirmas = new List<Entidades.Firma>();
            listaFirmas = value.Firmas;
            int empId = 0;
            try
            {
                for (int i = 0; i < listaFirmas.Count; i++)
                {
                    List<Models.Firma> firmaExiste = new List<Models.Firma>();
                    firmaExiste = _context.Firma.Where(c => c.FirmaNombre.CompareTo(listaFirmas[i].FirmaNombre) == 0).ToList();
                    if (firmaExiste.Count > 0)
                    {
                        listaFirmas[i].FirmaReal = firmaExiste[0].FirmaId;
                    }
                    else
                    {
                        Models.Firma item = new Models.Firma();
                        item.FirmaNombre = listaFirmas[i].FirmaNombre;
                        item.FirmaCorreo = listaFirmas[i].FirmaCorreo;
                        item.FirmaCodigo = listaFirmas[i].FirmaCodigo;
                        item.FirmaCargo = listaFirmas[i].FirmaCargo;
                        _context.Firma.Add(item);
                        _context.SaveChanges();
                        listaFirmas[i].FirmaReal = item.FirmaId;
                    }
                }
            }
            catch (Exception e)
            {
                return BadRequest("firam" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.DetallesFirma> listaDetalles = new List<DetallesFirma>();
            List<Entidades.DetallesFirma> listaDetallesReporte = new List<DetallesFirma>();
            listaDetalles = value.DetallesFirma;
            try
            {
                while (listaFirmas.Count > 0)
                {
                    int firmaId = listaFirmas[0].FirmaId;
                    List<Entidades.DetallesFirma> tmpDetalles = new List<DetallesFirma>();
                    tmpDetalles = listaDetalles.Where(d => d.FirmaId == firmaId).ToList();
                    for (int i = 0; i < tmpDetalles.Count; i++)
                    {
                        Models.DetalleFirma item = new DetalleFirma();
                        item.FirmaId = listaFirmas[0].FirmaReal;
                        item.DetalleFirmaCodigo = tmpDetalles[i].FirmaCodigo;
                        _context.DetalleFirma.Add(item);
                        _context.SaveChanges();
                        tmpDetalles[i].FirmaReal = item.DetalleFirmaId;
                    }
                    listaDetallesReporte.AddRange(tmpDetalles);
                    listaFirmas.RemoveAll(l => l.FirmaId == firmaId);
                }
            }
            catch (Exception e)
            {

                return BadRequest("detfirma" + e.Message.ToString() + e.InnerException.ToString());
            }
            List<Entidades.AlertaSincroEcuador> listaBanda = new List<Entidades.AlertaSincroEcuador>();
            listaBanda = value.ListaEcuador;
            try
            {
                empId = listaBanda[0].UsuarioId;
            }
            catch (Exception)
            {
                empId = 0;
            }
            try
            {
                while (listaBanda.Count > 0)
                {
                    int id = listaBanda[0].ControlBandaId;
                    Controlecuador item = new Controlecuador();
                    item.UsuarioControlId = listaBanda[0].UsuarioId;
                    item.ControlEcuadorNumeroOrden = listaBanda[0].ControlNumeroOrden;
                    item.ControlEcuadorTotal = listaBanda[0].BandaRamos;
                    item.ControlEcuadorFecha = listaBanda[0].BandaFecha;
                    item.ControlEcuadorAprobado = listaBanda[0].BandaAprobado;
                    item.ControlEcuadorTallos = listaBanda[0].BandaTallos;
                    item.ControlEcuadorDerogado = listaBanda[0].BandaDerogado;
                    item.ControlEcuadorElaborados = listaBanda[0].BandaElaborado;
                    item.ControlEcuadorDespachar = listaBanda[0].BandaDespachado;
                    item.PostcosechaId = listaBanda[0].PostCosechaId;
                    item.ClienteId = listaBanda[0].ClienteId;
                    item.ProductoId = listaBanda[0].ProductoId;
                    item.Marca = listaBanda[0].Marca;
                    item.DetalleFirmaId = listaDetallesReporte.Find(c => c.DetalleFirmaId == listaBanda[0].DetalleFirmaId).FirmaReal;
                    _context.Controlecuador.Add(item);
                    _context.SaveChanges();
                    for (int i = 0; i < listaBanda[0].EcuadorProblemas.Count; i++)
                    {
                        Problemasecuador itemProblema = new Problemasecuador();
                        itemProblema.ControlEcuadorId = item.ControlEcuadorId;
                        itemProblema.FalenciaRamoId = listaBanda[0].EcuadorProblemas[i].FalenciaRamosId;
                        itemProblema.TipoControlId = listaBanda[0].EcuadorProblemas[i].TipoControlId;
                        itemProblema.ProblemasEcuadorRamos = listaBanda[0].EcuadorProblemas[i].FalenciaBandaRamos;
                        _context.Problemasecuador.Add(itemProblema);
                        _context.SaveChanges();
                    }
                    for (int i = 0; i < listaBanda[0].Alertas.Count; i++)
                    {
                        Alertasecuador itemAlerta = new Alertasecuador();
                        itemAlerta.ControlEcuadorId = item.ControlEcuadorId;
                        itemAlerta.ProductoId = listaBanda[0].Alertas[i].ProductoId;
                        itemAlerta.VariedadNombre = listaBanda[0].Alertas[i].VariedadNombre;
                        itemAlerta.FalenciaRamoId = listaBanda[0].Alertas[i].FalenciaRamosId;
                        itemAlerta.TallosMuestra = listaBanda[0].Alertas[i].TallosMuestra;
                        itemAlerta.TallosAfectados = listaBanda[0].Alertas[i].TallosAfectados;
                        _context.Alertasecuador.Add(itemAlerta);
                        _context.SaveChanges();
                    }
                    listaBanda.RemoveAll(b => b.ControlBandaId == id);
                }
            }
            catch (Exception e)
            {
                return BadRequest("ecuador" + e.Message.ToString() + e.InnerException.ToString());
            }
            return Ok();
        }


        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }
        [HttpPost("prueba/{value}")]
        public dynamic Prueba(int value)
        {
            Models.Controlramo ramo = new Controlramo();
            ramo.ClienteId = 0;
            try
            {
                _context.Controlramo.Add(ramo);
                _context.SaveChanges();
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
            
        }
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }

    }
}
