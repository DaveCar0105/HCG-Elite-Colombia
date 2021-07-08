using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using HCGCALIDADSERVICES.Models;
using ExcelDataReader;
using HCGCALIDADSERVICES.Entidades;
using Microsoft.AspNetCore.Hosting;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
namespace HCGCALIDADSERVICES.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaseordenesController : ControllerBase
    {
        private readonly BDD_HCG_CONTROLContext _context;
        private IHostingEnvironment _hostingEnvironment;
        public BaseordenesController(BDD_HCG_CONTROLContext context, IHostingEnvironment hostingEnvironment)
        {
            _context = context;
            _hostingEnvironment = hostingEnvironment;
        }

        // GET: api/Baseordenes
        [HttpGet]
        public IEnumerable<Baseorden> GetBaseorden()
        {
            return _context.Baseorden;
        }

        // GET: api/Baseordenes/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetBaseorden([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var baseorden = await _context.Baseorden.FindAsync(id);

            if (baseorden == null)
            {
                return NotFound();
            }

            return Ok(baseorden);
        }

        // PUT: api/Baseordenes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBaseorden([FromRoute] int id, [FromBody] Baseorden baseorden)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != baseorden.BaseOrden1)
            {
                return BadRequest();
            }

            _context.Entry(baseorden).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BaseordenExists(id))
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

        // POST: api/Baseordenes
        [HttpPost]
        public async Task<List<BaseOrdenes>> Index()
        {
            List<BaseOrdenes> lista = new List<BaseOrdenes>();
            IFormFile file = Request.Form.Files[0];
            string folderName = "Upload";
            string webRootPath = _hostingEnvironment.WebRootPath;
            string newPath = Path.Combine(webRootPath, folderName);
            if (!Directory.Exists(newPath))
            {
                Directory.CreateDirectory(newPath);
            }
            List<Baseorden> listaSave = new List<Baseorden>();
            if (file.Length > 0)
            {
                string sFileExtension = Path.GetExtension(file.FileName).ToLower();
                ISheet sheet;
                string fullPath = Path.Combine(newPath, file.FileName);
                using (var stream = new FileStream(fullPath, FileMode.Create))
                {
                    file.CopyTo(stream);
                    stream.Position = 0;
                    if (sFileExtension == ".xls")
                    {
                        HSSFWorkbook hssfwb = new HSSFWorkbook(stream); //This will read the Excel 97-2000 formats  
                        sheet = hssfwb.GetSheetAt(0); //get first sheet from workbook  
                    }
                    else
                    {
                        XSSFWorkbook hssfwb = new XSSFWorkbook(stream); //This will read 2007 Excel format  
                        sheet = hssfwb.GetSheetAt(0); //get first sheet from workbook   
                    }
                    IRow headerRow = sheet.GetRow(0); //Get Header Row
                    int cellCount = headerRow.LastCellNum;
                    for (int j = 0; j < cellCount; j++)
                    {
                        NPOI.SS.UserModel.ICell cell = headerRow.GetCell(j);
                        if (cell == null || string.IsNullOrWhiteSpace(cell.ToString())) continue;
                    }
                    for (int i = (sheet.FirstRowNum + 1); i <= sheet.LastRowNum; i++) //Read Excel File
                    {
                        IRow row = sheet.GetRow(i);
                        if (row == null) continue;
                        if (row.Cells.All(d => d.CellType == CellType.Blank)) continue;

                        BaseOrdenes item = new BaseOrdenes
                        {
                            prioridades = row.GetCell(0).ToString(),
                            nomBodega = row.GetCell(1).ToString(),
                            postcosecha = row.GetCell(2).ToString(),
                            nomShip = row.GetCell(3).ToString(),
                            nomShop = row.GetCell(4).ToString(),
                            marca = row.GetCell(5).ToString(),
                            numPed = row.GetCell(6).ToString(),
                            pO = row.GetCell(7).ToString(),
                            tipoDes = row.GetCell(8).ToString(),
                            total = row.GetCell(9).ToString()
                        };
                        Baseorden itemsave = new Baseorden
                        {
                            Prioridad = row.GetCell(0).ToString(),
                            NomBodega = row.GetCell(1).ToString(),
                            Postcosecha = row.GetCell(2).ToString(),
                            NomShip = row.GetCell(3).ToString(),
                            NomShop = row.GetCell(4).ToString(),
                            Marca = row.GetCell(5).ToString(),
                            NumPed = row.GetCell(6).ToString(),
                            PO = row.GetCell(7).ToString(),
                            TipoDes = row.GetCell(8).ToString(),
                            Total = row.GetCell(9).ToString()
                        };

                        listaSave.Add(itemsave);
                        lista.Add(item);
                    }
                    _context.Baseorden.AddRange(listaSave);
                    await _context.SaveChangesAsync();
                }
            }
            return lista;
        }

        // DELETE: api/Baseordenes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBaseorden([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var baseorden = await _context.Baseorden.FindAsync(id);
            if (baseorden == null)
            {
                return NotFound();
            }

            _context.Baseorden.Remove(baseorden);
            await _context.SaveChangesAsync();

            return Ok(baseorden);
        }

        private bool BaseordenExists(int id)
        {
            return _context.Baseorden.Any(e => e.BaseOrden1 == id);
        }
    }
}