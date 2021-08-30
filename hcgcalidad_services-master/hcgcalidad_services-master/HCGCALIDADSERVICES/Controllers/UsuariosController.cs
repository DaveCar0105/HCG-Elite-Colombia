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
    public class UsuariosController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;

        public UsuariosController(BDD_HCG_CONTROLContext context)
        {
            _context = context;
        }

        // GET: api/Usuarios
        [HttpGet]
        public IEnumerable<Usuariocontrol> GetUsuariocontrol()
        {
            return _context.Usuariocontrol;
        }

        // GET: api/Usuarios/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUsuariocontrol([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var usuariocontrol = await _context.Usuariocontrol.FindAsync(id);

            if (usuariocontrol == null)
            {
                return NotFound();
            }

            return Ok(usuariocontrol);
        }
        [HttpGet("{user}/{password}")]
        public int GetUsuariocontrol([FromRoute] string user, string password)
        {
            var usuariocontrol = _context.Usuariocontrol.ToList().Find(u=>u.UsuarioControlUsuario == user && u.UsuarioControlContrasenia == password);

            return usuariocontrol!=null? usuariocontrol.UsuarioControlId : 0;
        }
        // PUT: api/Usuarios/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsuariocontrol([FromRoute] int id, [FromBody] Usuariocontrol usuariocontrol)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != usuariocontrol.UsuarioControlId)
            {
                return BadRequest();
            }

            _context.Entry(usuariocontrol).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UsuariocontrolExists(id))
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

        // POST: api/Usuarios
        [HttpPost]
        public async Task<IActionResult> PostUsuariocontrol([FromBody] Usuariocontrol usuariocontrol)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Usuariocontrol.Add(usuariocontrol);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUsuariocontrol", new { id = usuariocontrol.UsuarioControlId }, usuariocontrol);
        }

        // DELETE: api/Usuarios/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsuariocontrol([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var usuariocontrol = await _context.Usuariocontrol.FindAsync(id);
            if (usuariocontrol == null)
            {
                return NotFound();
            }

            _context.Usuariocontrol.Remove(usuariocontrol);
            await _context.SaveChangesAsync();

            return Ok(usuariocontrol);
        }

        private bool UsuariocontrolExists(int id)
        {
            return _context.Usuariocontrol.Any(e => e.UsuarioControlId == id);
        }
    }
}