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
    public class ProblemasecommerceController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public ProblemasecommerceController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Problemasecommerce
        [HttpGet]
        public IEnumerable<Problemasecommerce> GetProblemasecommerce()
        {
            return _context.Problemasecommerce;
        }

        // GET: api/Problemasecommerce/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetProblemasecommerce([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var problemasecommerce = await _context.Problemasecommerce.FindAsync(id);

            if (problemasecommerce == null)
            {
                return NotFound();
            }

            return Ok(problemasecommerce);
        }

        // PUT: api/Problemasecommerce/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProblemasecommerce([FromRoute] int id, [FromBody] Problemasecommerce problemasecommerce)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != problemasecommerce.ProblemaEcommerceId)
            {
                return BadRequest();
            }

            _context.Entry(problemasecommerce).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProblemasecommerceExists(id))
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

        // POST: api/Problemasecommerce
        [HttpPost]
        public async Task<IActionResult> PostProblemasecommerce([FromBody] Problemasecommerce problemasecommerce)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Problemasecommerce.Add(problemasecommerce);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProblemasecommerce", new { id = problemasecommerce.ProblemaEcommerceId }, problemasecommerce);
        }

        // DELETE: api/Problemasecommerce/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProblemasecommerce([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var problemasecommerce = await _context.Problemasecommerce.FindAsync(id);
            if (problemasecommerce == null)
            {
                return NotFound();
            }

            _context.Problemasecommerce.Remove(problemasecommerce);
            await _context.SaveChangesAsync();

            return Ok(problemasecommerce);
        }

        private bool ProblemasecommerceExists(int id)
        {
            return _context.Problemasecommerce.Any(e => e.ProblemaEcommerceId == id);
        }
    }
}