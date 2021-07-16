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
    public class CirculoCalidadController : Controller
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public CirculoCalidadController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/CirculoCalidad
        [HttpGet]
        public IEnumerable<CirculoCalidad> GetAllCirculoCalidad()
        {
            return _context.CirculoCalidad;
        }

        // GET: api/CirculoCalidad/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCirculoCalidad([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var circuloCalidad = await _context.CirculoCalidad.FindAsync(id);

            if (circuloCalidad == null)
            {
                return NotFound();
            }

            return Ok(circuloCalidad);
        }

        // POST: api/Usuarios
        [HttpPost]
        public async Task<IActionResult> PostCirculoCalidad([FromBody] CirculoCalidad circuloCalidad)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.CirculoCalidad.Add(circuloCalidad);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCirculoCalidad", new { id = circuloCalidad.CirculoCalidadId }, circuloCalidad);
        }
    }
}
