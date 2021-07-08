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
    public class TipoControlesController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public TipoControlesController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/TipoControles
        [HttpGet]
        public IEnumerable<TipoControl> GetTipoControl()
        {
            return _context.TipoControl;
        }

        // GET: api/TipoControles/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetTipoControl([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var tipoControl = await _context.TipoControl.FindAsync(id);

            if (tipoControl == null)
            {
                return NotFound();
            }

            return Ok(tipoControl);
        }

        // PUT: api/TipoControles/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTipoControl([FromRoute] int id, [FromBody] TipoControl tipoControl)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tipoControl.TipoControlId)
            {
                return BadRequest();
            }

            _context.Entry(tipoControl).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TipoControlExists(id))
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

        // POST: api/TipoControles
        [HttpPost]
        public async Task<IActionResult> PostTipoControl([FromBody] TipoControl tipoControl)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.TipoControl.Add(tipoControl);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetTipoControl", new { id = tipoControl.TipoControlId }, tipoControl);
        }

        // DELETE: api/TipoControles/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTipoControl([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var tipoControl = await _context.TipoControl.FindAsync(id);
            if (tipoControl == null)
            {
                return NotFound();
            }

            _context.TipoControl.Remove(tipoControl);
            await _context.SaveChangesAsync();

            return Ok(tipoControl);
        }

        private bool TipoControlExists(int id)
        {
            return _context.TipoControl.Any(e => e.TipoControlId == id);
        }
    }
}