using HCGCALIDADSERVICES.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProcesoMaritimoAlstroemeriaController : Controller
    {
        private readonly BDD_HCG_CONTROLContext _context;
        public ProcesoMaritimoAlstroemeriaController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/ProcesoMaritimoAlstroemeria
        [HttpGet]
        public IEnumerable<ProcesoMaritimoAlstroemeria> GetAllProcesoMaritimoAlstroemeria()
        {
            return _context.ProcesoMaritimoAlstroemeria;
        }

        // GET: api/ProcesoMaritimoAlstroemeria/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetProcesoMaritimoAlstroemeria([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var procesoMaritimo = await _context.ProcesoMaritimoAlstroemeria.FindAsync(id);

            if (procesoMaritimo == null)
            {
                return NotFound();
            }

            return Ok(procesoMaritimo);
        }

        // POST: api/ProcesoMaritimoAlstroemeria
        [HttpPost]
        public async Task<IActionResult> PostProcesoMaritimoAlstroemeria([FromBody] ProcesoMaritimoAlstroemeria procesoMaritimo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.ProcesoMaritimoAlstroemeria.Add(procesoMaritimo);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProcesoMaritimoAlstroemeria", new { id = procesoMaritimo.ProcesoMaritimoAlstroemeriaId }, procesoMaritimo);
        }
    }
}
