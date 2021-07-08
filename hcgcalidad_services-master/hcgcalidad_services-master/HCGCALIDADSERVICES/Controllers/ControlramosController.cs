using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using HCGCALIDADSERVICES.Models;
using HCGCALIDADSERVICES.Entidades;

namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ControlramosController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public ControlramosController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Controlramos
        [HttpGet]
        public IEnumerable<Controlramo> GetControlramo()
        {
            return _context.Controlramo;
        }

        // GET: api/Controlramos/5
        [HttpGet("{anio}")]
        public IActionResult GetControlramo([FromRoute] int anio)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            List<Controlramo> controlramo = _context.Controlramo.ToList().Where(c=>c.ControlRamoFecha.Value.Year == anio).ToList();
                            
            if (controlramo == null)
            {
                return NotFound();
            }

            return Ok(controlramo);
        }

        // PUT: api/Controlramos/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutControlramo([FromRoute] int id, [FromBody] Controlramo controlramo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != controlramo.ControlRamoId)
            {
                return BadRequest();
            }

            _context.Entry(controlramo).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ControlramoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Controlramos
        [HttpPost]
        public async Task<IActionResult> PostControlramo([FromBody] Controlramo controlramo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Controlramo.Add(controlramo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetControlramo", new { id = controlramo.ControlRamoId }, controlramo);
        }/*
        [HttpPost("Sinc")]
        public IActionResult PostControles([FromBody] List<ReporteSincronizar> listaControles)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            List<ReporteSincronizar> lista = new List<ReporteSincronizar>();
            while (lista.Count > 0)
            {
                Firma firma = new Firma();
                ReporteSincronizar firmaEnt = lista.Find(c => c.FirmaCadena.ToString().Length > 10);
                firma.FirmaCadena = firmaEnt.FirmaCadena;
                firma.FirmaNombre = firmaEnt.FirmaNombre;
                firma.FirmaCargo = firmaEnt.FirmaCargo;

                int firmaId = _context.Firma.Add(firma).Entity.FirmaId;

                List<ReporteSincronizar> listaFirma = new List<ReporteSincronizar>();
                listaFirma = lista.Where(lf => lf.FirmaId == firmaEnt.FirmaId).ToList();
                while (listaFirma.Count > 0)
                {
                    string[] fecha = listaFirma[0].Fecha.Split("/");
                    if (listaFirma[0].Tipo)
                    {
                        Controlramo controlRamo = new Controlramo();
                        int reporteId = (int) listaFirma[0].ReporteId;
                        controlRamo.FirmaId = firmaId;
                        controlRamo.Marca = listaFirma[0].Marca;
                        controlRamo.PostcosechaId = (int?)listaFirma[0].PostCosechaId;
                        controlRamo.ClienteId = (int?)listaFirma[0].ClienteId;
                        controlRamo.ProductoId = (int)listaFirma[0].ProductoId;
                        controlRamo.ControlRamoTallos = (int)listaFirma[0].TallosPorRamo;
                        controlRamo.ControlRamoDespachar = (int)listaFirma[0].RamosDespachados;
                        controlRamo.ControlRamoElaborados = (int)listaFirma[0].RamosElaborados;
                        controlRamo.ControlRamoTotal = (int)listaFirma[0].RamosRevisados;
                        controlRamo.ControlRamoFecha = new DateTime(Convert.ToInt32(fecha[0]), Convert.ToInt32(fecha[1]), Convert.ToInt32(fecha[2]));
                        controlRamo.ControlRamoTiempo = (int)listaFirma[0].Duracion;

                        int reporteIdReal = _context.Controlramo.Add(controlRamo).Entity.ControlRamoId;
                        List<ReporteSincronizar> listaReporteRamos = new List<ReporteSincronizar>();
                        listaReporteRamos = listaFirma.Where(lrr => lrr.ReporteId == reporteId).ToList();
                        while (listaReporteRamos.Count > 0)
                        {
                            Falenciascontrolramo falcontramo = new Falenciascontrolramo();
                            falcontramo.ControlRamoId = reporteIdReal;
                            falcontramo.FalenciaRamoId = (int?)listaReporteRamos[0].FalenciaId;
                            falcontramo.FalenciaControlRamoCantidad = (int?)listaReporteRamos[0].FalenciaCantidad;
                            falcontramo.FalenciaControlRamoPorcentaje = (Convert.ToInt32(listaReporteRamos[0].FalenciaCantidad) / controlRamo.ControlRamoTotal) * 100;
                            _context.Falenciascontrolramo.Add(falcontramo);
                            listaReporteRamos.RemoveAll(r => r.Tipo == true && r.ReporteId == reporteId && r.FalenciaId == falcontramo.FalenciaRamoId);

                        }
                        listaFirma.RemoveAll(r => r.ReporteId == reporteId && r.Tipo == true);

                    }
                    else
                    {
                        int reporteId = (int)listaFirma[0].ReporteId;
                        Controlempaque controlEmpaque = new Controlempaque();
                        controlEmpaque.FirmaId = firmaId;
                        controlEmpaque.Marca = listaFirma[0].Marca;
                        controlEmpaque.PostcosechaId = (int?)listaFirma[0].PostCosechaId;
                        controlEmpaque.ClienteId = (int?)listaFirma[0].ClienteId;
                        controlEmpaque.ProductoId = (int)listaFirma[0].ProductoId;
                        controlEmpaque.ControlEmpaqueTallos = (int)listaFirma[0].TallosPorRamo;
                        controlEmpaque.ControlEmpaqueDespachar = (int)listaFirma[0].CajasDespachar;
                        controlEmpaque.ControlEmpaqueRamosCaja = (int)listaFirma[0].RamosCaja;
                        controlEmpaque.ControlEmpaqueTotal = (int)listaFirma[0].CajasRevisar;
                        controlEmpaque.ControlEmpaqueFecha = new DateTime(Convert.ToInt32(fecha[0]), Convert.ToInt32(fecha[1]), Convert.ToInt32(fecha[2]));
                        controlEmpaque.ControlEmpaqueTiempo = (int)listaFirma[0].Duracion;

                        int reporteIdReal = _context.Controlempaque.Add(controlEmpaque).Entity.ControlEmpaqueId;
                        List<ReporteSincronizar> listaReporteEmpaque = new List<ReporteSincronizar>();
                        listaReporteEmpaque = listaFirma.Where(lrr => lrr.ReporteId == reporteId).ToList();
                        while (listaReporteEmpaque.Count > 0)
                        {
                            Falenciacontrolempaque falcontempaque = new Falenciacontrolempaque();
                            falcontempaque.ControlEmpaqueId = reporteIdReal;
                            falcontempaque.FalenciaEmpaqueId = (int?)listaReporteEmpaque[0].FalenciaId;
                            falcontempaque.FalenciaControlEmpaqueCantidad = (int?)listaReporteEmpaque[0].FalenciaCantidad;
                            falcontempaque.FalenciaControlEmpaquePorsentaje = (Convert.ToInt32(listaReporteEmpaque[0].FalenciaCantidad) / controlEmpaque.ControlEmpaqueRamosRevisar) * 100;
                            _context.Falenciacontrolempaque.Add(falcontempaque);
                            listaReporteEmpaque.RemoveAll(r => r.Tipo == false && r.ReporteId == reporteId && r.FalenciaId == falcontramo.FalenciaRamoId);
                        }
                        listaFirma.RemoveAll(r => r.ReporteId == reporteId && r.Tipo == false);


                    }
                }

            }


            return Ok();
        }
        */

        // DELETE: api/Controlramos/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteControlramo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var controlramo = await _context.Controlramo.FindAsync(id);
            if (controlramo == null)
            {
                return NotFound();
            }

            _context.Controlramo.Remove(controlramo);
            await _context.SaveChangesAsync();

            return Ok(controlramo);
        }

        private bool ControlramoExists(int id)
        {
            return _context.Controlramo.Any(e => e.ControlRamoId == id);
        }
    }
}