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
    public class CategoriasfalenciaramosController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public CategoriasfalenciaramosController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Categoriasfalenciaramos
        [HttpGet]
        public IEnumerable<Categoriafalenciaramo> GetCategoriafalenciaramo()
        {
            return _context.Categoriafalenciaramo;
        }

        // GET: api/Categoriasfalenciaramos/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoriafalenciaramo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var categoriafalenciaramo = await _context.Categoriafalenciaramo.FindAsync(id);

            if (categoriafalenciaramo == null)
            {
                return NotFound();
            }

            return Ok(categoriafalenciaramo);
        }

        // PUT: api/Categoriasfalenciaramos/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCategoriafalenciaramo([FromRoute] int id, [FromBody] Categoriafalenciaramo categoriafalenciaramo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != categoriafalenciaramo.CategoriaFalenciaRamoId)
            {
                return BadRequest();
            }

            _context.Entry(categoriafalenciaramo).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CategoriafalenciaramoExists(id))
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

        // POST: api/Categoriasfalenciaramos
        [HttpPost]
        public async Task<IActionResult> PostCategoriafalenciaramo([FromBody] Categoriafalenciaramo categoriafalenciaramo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Categoriafalenciaramo.Add(categoriafalenciaramo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCategoriafalenciaramo", new { id = categoriafalenciaramo.CategoriaFalenciaRamoId }, categoriafalenciaramo);
        }

        // DELETE: api/Categoriasfalenciaramos/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategoriafalenciaramo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var categoriafalenciaramo = await _context.Categoriafalenciaramo.FindAsync(id);
            if (categoriafalenciaramo == null)
            {
                return NotFound();
            }

            _context.Categoriafalenciaramo.Remove(categoriafalenciaramo);
            await _context.SaveChangesAsync();

            return Ok(categoriafalenciaramo);
        }

        private bool CategoriafalenciaramoExists(int id)
        {
            return _context.Categoriafalenciaramo.Any(e => e.CategoriaFalenciaRamoId == id);
        }
    }
}