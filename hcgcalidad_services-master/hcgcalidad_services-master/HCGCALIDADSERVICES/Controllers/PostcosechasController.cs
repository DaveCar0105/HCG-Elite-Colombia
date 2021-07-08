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
    public class PostcosechasController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public PostcosechasController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Postcosechas
        [HttpGet]
        public IEnumerable<Postcosecha> GetPostcosecha()
        {
            return _context.Postcosecha;
        }

        // GET: api/Postcosechas/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetPostcosecha([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var postcosecha = await _context.Postcosecha.FindAsync(id);

            if (postcosecha == null)
            {
                return NotFound();
            }

            return Ok(postcosecha);
        }

        // PUT: api/Postcosechas/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPostcosecha([FromRoute] int id, [FromBody] Postcosecha postcosecha)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != postcosecha.PostcosechaId)
            {
                return BadRequest();
            }

            _context.Entry(postcosecha).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PostcosechaExists(id))
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

        // POST: api/Postcosechas
        [HttpPost]
        public async Task<IActionResult> PostPostcosecha([FromBody] Postcosecha postcosecha)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Postcosecha.Add(postcosecha);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (PostcosechaExists(postcosecha.PostcosechaId))
                {
                    return new StatusCodeResult(StatusCodes.Status409Conflict);
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetPostcosecha", new { id = postcosecha.PostcosechaId }, postcosecha);
        }

        // DELETE: api/Postcosechas/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePostcosecha([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var postcosecha = await _context.Postcosecha.FindAsync(id);
            if (postcosecha == null)
            {
                return NotFound();
            }

            _context.Postcosecha.Remove(postcosecha);
            await _context.SaveChangesAsync();

            return Ok(postcosecha);
        }

        private bool PostcosechaExists(int id)
        {
            return _context.Postcosecha.Any(e => e.PostcosechaId == id);
        }
    }
}