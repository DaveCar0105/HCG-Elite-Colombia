using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using HCGCALIDADSERVICES.Models;

namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FalenciasramosController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public FalenciasramosController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Falenciasramos
        [HttpGet]
        public IEnumerable<Falenciaramo> GetFalenciaramo()
        {
            return _context.Falenciaramo;
        }

        // GET: api/Falenciasramos/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetFalenciaramo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var falenciaramo = await _context.Falenciaramo.FindAsync(id);

            if (falenciaramo == null)
            {
                return NotFound();
            }

            return Ok(falenciaramo);
        }

        // PUT: api/Falenciasramos/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFalenciaramo([FromRoute] int id, [FromBody] Falenciaramo falenciaramo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != falenciaramo.FalenciaRamoId)
            {
                return BadRequest();
            }

            _context.Entry(falenciaramo).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FalenciaramoExists(id))
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

        // POST: api/Falenciasramos
        [HttpPost]
        public async Task<IActionResult> PostFalenciaramo([FromBody] Falenciaramo falenciaramo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Falenciaramo.Add(falenciaramo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetFalenciaramo", new { id = falenciaramo.FalenciaRamoId }, falenciaramo);
        }

        // DELETE: api/Falenciasramos/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFalenciaramo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var falenciaramo = await _context.Falenciaramo.FindAsync(id);
            if (falenciaramo == null)
            {
                return NotFound();
            }

            _context.Falenciaramo.Remove(falenciaramo);
            await _context.SaveChangesAsync();

            return Ok(falenciaramo);
        }

        private bool FalenciaramoExists(int id)
        {
            return _context.Falenciaramo.Any(e => e.FalenciaRamoId == id);
        }
    }
}