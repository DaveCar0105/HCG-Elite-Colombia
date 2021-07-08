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
    public class CategoriafalenciaempaquesController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public CategoriafalenciaempaquesController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Categoriafalenciaempaques
        [HttpGet]
        public IEnumerable<Categoriafalenciaempaque> GetCategoriafalenciaempaque()
        {
            return _context.Categoriafalenciaempaque;
        }

        // GET: api/Categoriafalenciaempaques/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoriafalenciaempaque([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var categoriafalenciaempaque = await _context.Categoriafalenciaempaque.FindAsync(id);

            if (categoriafalenciaempaque == null)
            {
                return NotFound();
            }

            return Ok(categoriafalenciaempaque);
        }

        // PUT: api/Categoriafalenciaempaques/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCategoriafalenciaempaque([FromRoute] int id, [FromBody] Categoriafalenciaempaque categoriafalenciaempaque)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != categoriafalenciaempaque.CategoriaFalenciaEmpaque1)
            {
                return BadRequest();
            }

            _context.Entry(categoriafalenciaempaque).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CategoriafalenciaempaqueExists(id))
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

        // POST: api/Categoriafalenciaempaques
        [HttpPost]
        public async Task<IActionResult> PostCategoriafalenciaempaque([FromBody] Categoriafalenciaempaque categoriafalenciaempaque)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Categoriafalenciaempaque.Add(categoriafalenciaempaque);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCategoriafalenciaempaque", new { id = categoriafalenciaempaque.CategoriaFalenciaEmpaque1 }, categoriafalenciaempaque);
        }

        // DELETE: api/Categoriafalenciaempaques/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategoriafalenciaempaque([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var categoriafalenciaempaque = await _context.Categoriafalenciaempaque.FindAsync(id);
            if (categoriafalenciaempaque == null)
            {
                return NotFound();
            }

            _context.Categoriafalenciaempaque.Remove(categoriafalenciaempaque);
            await _context.SaveChangesAsync();

            return Ok(categoriafalenciaempaque);
        }

        private bool CategoriafalenciaempaqueExists(int id)
        {
            return _context.Categoriafalenciaempaque.Any(e => e.CategoriaFalenciaEmpaque1 == id);
        }
    }
}