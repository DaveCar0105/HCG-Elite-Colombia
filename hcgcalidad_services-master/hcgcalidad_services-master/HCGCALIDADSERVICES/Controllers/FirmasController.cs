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
    public class FirmasController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public FirmasController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Firmas
        [HttpGet]
        public IEnumerable<Firma> GetFirma()
        {
            return _context.Firma;
        }

        // GET: api/Firmas/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetFirma([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var firma = await _context.Firma.FindAsync(id);

            if (firma == null)
            {
                return NotFound();
            }

            return Ok(firma);
        }

        // PUT: api/Firmas/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFirma([FromRoute] int id, [FromBody] Firma firma)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != firma.FirmaId)
            {
                return BadRequest();
            }

            _context.Entry(firma).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FirmaExists(id))
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

        // POST: api/Firmas
        [HttpPost]
        public async Task<IActionResult> PostFirma([FromBody] Firma firma)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Firma.Add(firma);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetFirma", new { id = firma.FirmaId }, firma);
        }

        // DELETE: api/Firmas/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFirma([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var firma = await _context.Firma.FindAsync(id);
            if (firma == null)
            {
                return NotFound();
            }

            _context.Firma.Remove(firma);
            await _context.SaveChangesAsync();

            return Ok(firma);
        }

        private bool FirmaExists(int id)
        {
            return _context.Firma.Any(e => e.FirmaId == id);
        }
    }
}