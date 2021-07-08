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
    public class FalenciaempaquesController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public FalenciaempaquesController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Falenciaempaques
        [HttpGet]
        public IEnumerable<Falenciaempaque> GetFalenciaempaque()
        {
            List<Falenciaempaque> falencias = new List<Falenciaempaque>();
            _context.Falenciaempaque.ToList().ForEach(k=>
            {
                Falenciaempaque falItem = new Falenciaempaque();
                falItem.FalenciaEmpaqueId = k.FalenciaEmpaqueId;
                falItem.CategoriaFalenciaEmpaque = k.CategoriaFalenciaEmpaque;
                falItem.Elite = k.Elite;
                
                if(falItem.CategoriaFalenciaEmpaque == 11)
                {
                    falItem.FalenciaEmpaqueNombre = "C: "+k.FalenciaEmpaqueNombre;
                }
                else
                {
                    falItem.FalenciaEmpaqueNombre = "R: " + k.FalenciaEmpaqueNombre;
                }
                falencias.Add(falItem);
            });
            return falencias;
        }

        // GET: api/Falenciaempaques/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetFalenciaempaque([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var falenciaempaque = await _context.Falenciaempaque.FindAsync(id);

            if (falenciaempaque == null)
            {
                return NotFound();
            }

            return Ok(falenciaempaque);
        }

        // PUT: api/Falenciaempaques/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFalenciaempaque([FromRoute] int id, [FromBody] Falenciaempaque falenciaempaque)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != falenciaempaque.FalenciaEmpaqueId)
            {
                return BadRequest();
            }

            _context.Entry(falenciaempaque).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FalenciaempaqueExists(id))
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

        // POST: api/Falenciaempaques
        [HttpPost]
        public async Task<IActionResult> PostFalenciaempaque([FromBody] Falenciaempaque falenciaempaque)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Falenciaempaque.Add(falenciaempaque);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetFalenciaempaque", new { id = falenciaempaque.FalenciaEmpaqueId }, falenciaempaque);
        }

        // DELETE: api/Falenciaempaques/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFalenciaempaque([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var falenciaempaque = await _context.Falenciaempaque.FindAsync(id);
            if (falenciaempaque == null)
            {
                return NotFound();
            }

            _context.Falenciaempaque.Remove(falenciaempaque);
            await _context.SaveChangesAsync();

            return Ok(falenciaempaque);
        }

        private bool FalenciaempaqueExists(int id)
        {
            return _context.Falenciaempaque.Any(e => e.FalenciaEmpaqueId == id);
        }
    }
}