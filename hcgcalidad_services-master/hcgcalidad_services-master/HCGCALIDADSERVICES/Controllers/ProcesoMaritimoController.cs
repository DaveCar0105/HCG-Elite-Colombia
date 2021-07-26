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
    public class ProcesoMaritimoController : Controller
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public ProcesoMaritimoController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/ProcesoMaritimo
        [HttpGet]
        public IEnumerable<ProcesoMaritimo> GetAllProcesoMaritimo()
        {
            return _context.ProcesoMaritimo;
        }

        // GET: api/ProcesoMaritimo/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetProcesoMaritimo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var procesoMaritimo = await _context.ProcesoMaritimo.FindAsync(id);

            if (procesoMaritimo == null)
            {
                return NotFound();
            }

            return Ok(procesoMaritimo);
        }

        // POST: api/ProcesoMaritimo
        [HttpPost]
        public async Task<IActionResult> PostProcesoMaritimo([FromBody] ProcesoMaritimo procesoMaritimo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.ProcesoMaritimo.Add(procesoMaritimo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProcesoMaritimo", new { id = procesoMaritimo.ProcesoMaritimoId }, procesoMaritimo);
        }
    }
}
