using HCGCALIDADSERVICES.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DestinoMaritimoController : Controller
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public DestinoMaritimoController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/DestinoMaritimo
        [HttpGet]
        public IEnumerable<DestinoMaritimo> GetAllDestinoMaritimo()
        {
            return _context.DestinoMaritimo;
        }

        // GET: api/DestinoMaritimo/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetDestinoMaritimo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var destinoMaritimo = await _context.DestinoMaritimo.FindAsync(id);

            if (destinoMaritimo == null)
            {
                return NotFound();
            }

            return Ok(destinoMaritimo);
        }

        // POST: api/DestinoMaritimo
        [HttpPost]
        public async Task<IActionResult> PostDestinoMaritimo([FromBody] DestinoMaritimo destinoMaritimo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.DestinoMaritimo.Add(destinoMaritimo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDestinoMaritimo", new { id = destinoMaritimo.DestinoMaritimoId }, destinoMaritimo);
        }
    }
}
