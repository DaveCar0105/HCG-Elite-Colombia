﻿using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace HCGCALIDADSERVICES.Models
{
    public partial class BDD_HCG_CONTROLContext : DbContext
    {
        public BDD_HCG_CONTROLContext()
        {
        }

        public BDD_HCG_CONTROLContext(DbContextOptions<BDD_HCG_CONTROLContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Actividad> Actividad { get; set; }
        public virtual DbSet<Alertasecuador> Alertasecuador { get; set; }
        public virtual DbSet<Baseorden> Baseorden { get; set; }
        public virtual DbSet<Categoriafalenciaempaque> Categoriafalenciaempaque { get; set; }
        public virtual DbSet<Categoriafalenciaramo> Categoriafalenciaramo { get; set; }
        public virtual DbSet<Checkecommerce> Checkecommerce { get; set; }
        public virtual DbSet<Cliente> Cliente { get; set; }
        public virtual DbSet<Controlalistamiento> Controlalistamiento { get; set; }
        public virtual DbSet<Controlbanda> Controlbanda { get; set; }
        public virtual DbSet<Controlboncheo> Controlboncheo { get; set; }
        public virtual DbSet<Controlecommerce> Controlecommerce { get; set; }
        public virtual DbSet<Controlecuador> Controlecuador { get; set; }
        public virtual DbSet<Controlempaque> Controlempaque { get; set; }
        public virtual DbSet<Controlramo> Controlramo { get; set; }
        public virtual DbSet<DetalleFirma> DetalleFirma { get; set; }
        public virtual DbSet<Empaque> Empaque { get; set; }
        public virtual DbSet<Errores> Errores { get; set; }
        public virtual DbSet<Falenciacontrolempaque> Falenciacontrolempaque { get; set; }
        public virtual DbSet<Falenciaempaque> Falenciaempaque { get; set; }
        public virtual DbSet<Falenciaramo> Falenciaramo { get; set; }
        public virtual DbSet<Falenciascontrolramo> Falenciascontrolramo { get; set; }
        public virtual DbSet<Firma> Firma { get; set; }
        public virtual DbSet<Macrofalencia> Macrofalencia { get; set; }
        public virtual DbSet<Postcosecha> Postcosecha { get; set; }
        public virtual DbSet<Problemaalistamiento> Problemaalistamiento { get; set; }
        public virtual DbSet<Problemabanda> Problemabanda { get; set; }
        public virtual DbSet<Problemaboncheo> Problemaboncheo { get; set; }
        public virtual DbSet<Problemasecommerce> Problemasecommerce { get; set; }
        public virtual DbSet<Problemasecuador> Problemasecuador { get; set; }
        public virtual DbSet<ProcesoEmpaque> ProcesoEmpaque { get; set; }
        public virtual DbSet<ProcesoHidratacion> ProcesoHidratacion { get; set; }
        public virtual DbSet<Producto> Producto { get; set; }
        public virtual DbSet<Ramo> Ramo { get; set; }
        public virtual DbSet<Temperatura> Temperatura { get; set; }
        public virtual DbSet<TipoControl> TipoControl { get; set; }
        public virtual DbSet<TipoActividad> TipActividad { get; set; }
        public virtual DbSet<TipoCliente> TipCliente { get; set; }
        public virtual DbSet<Usuariocontrol> Usuariocontrol { get; set; }
        public virtual DbSet<CirculoCalidad> CirculoCalidad { get; set; }
        public virtual DbSet<CirculoCalidadProducto> CirculoCalidadProducto { get; set; }
        public virtual DbSet<CirculoCalidadCliente> CirculoCalidadCliente { get; set; }
        public virtual DbSet<CirculoCalidadFalencia> CirculoCalidadFalencia { get; set; }
        public virtual DbSet<CirculoCalidadVariedad> CirculoCalidadVariedad { get; set; }
        public virtual DbSet<CirculoCalidadNumeroMesa> CirculoCalidadNumeroMesa { get; set; }
        public virtual DbSet<CirculoCalidadLinea> CirculoCalidadLinea { get; set; }
        public virtual DbSet<ProcesoMaritimo> ProcesoMaritimo { get; set; }
        public virtual DbSet<ProcesoMaritimoAlstroemeria> ProcesoMaritimoAlstroemeria { get; set; }
        public virtual DbSet<DestinoMaritimo> DestinoMaritimo { get; set; }

        public virtual DbSet<Banda> Banda { get; set; }

        // Unable to generate entity type for table 'dbo.NUMERO_ORDEN'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.FECHA'. Please see the warning messages.

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {}
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Actividad>(entity =>
            {
                entity.ToTable("ACTIVIDAD");

                entity.Property(e => e.ActividadId).HasColumnName("ACTIVIDAD_ID");

                entity.Property(e => e.ActividadDetalle)
                    .HasColumnName("ACTIVIDAD_DETALLE")
                    .IsUnicode(false);

                entity.Property(e => e.ActividadFecha)
                    .HasColumnName("ACTIVIDAD_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ActividadHoraFin)
                    .HasColumnName("ACTIVIDAD_HORA_FIN")
                    .IsUnicode(false);

                entity.Property(e => e.ActividadHoraInicio)
                    .HasColumnName("ACTIVIDAD_HORA_INICIO")
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.Property(e => e.TipoActividadId).HasColumnName("TIPO_ACTIVIDAD_ID");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Actividad)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__ACTIVIDAD__POSTC__0697FACD");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Actividad)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__ACTIVIDAD__USUAR__76619304");

                entity.HasOne(d => d.TipoActividad)
                    .WithMany(p => p.Actividad)
                    .HasForeignKey(d => d.TipoActividadId)
                    .HasConstraintName("FK__ACTIVIDAD__TIPAC__0697FACD");
            });

            modelBuilder.Entity<TipoActividad>(entity =>
            {
                entity.ToTable("TIPO_ACTIVIDAD");

                entity.Property(e => e.TipoActividadId).HasColumnName("TIPO_ACTIVIDAD_ID");

                entity.Property(e => e.TipoActividadDescripcion)
                    .HasColumnName("TIPO_ACTIVIDAD_DESCRIPCION")
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Alertasecuador>(entity =>
            {
                entity.HasKey(e => e.AlertaEcuadorId);

                entity.ToTable("ALERTASECUADOR");

                entity.Property(e => e.AlertaEcuadorId).HasColumnName("ALERTA_ECUADOR_ID");

                entity.Property(e => e.ControlEcuadorId).HasColumnName("CONTROL_ECUADOR_ID");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.TallosAfectados).HasColumnName("TALLOS_AFECTADOS");

                entity.Property(e => e.TallosMuestra).HasColumnName("TALLOS_MUESTRA");

                entity.Property(e => e.VariedadNombre)
                    .HasColumnName("VARIEDAD_NOMBRE")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.HasOne(d => d.ControlEcuador)
                    .WithMany(p => p.Alertasecuador)
                    .HasForeignKey(d => d.ControlEcuadorId)
                    .HasConstraintName("FK__ALERTASEC__CONTR__22FF2F51");

                entity.HasOne(d => d.FalenciaRamo)
                    .WithMany(p => p.Alertasecuador)
                    .HasForeignKey(d => d.FalenciaRamoId)
                    .HasConstraintName("FK__ALERTASEC__FALEN__45544755");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Alertasecuador)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK__ALERTASEC__PRODU__23F3538A");
            });

            modelBuilder.Entity<Baseorden>(entity =>
            {
                entity.HasKey(e => e.BaseOrden1);

                entity.ToTable("BASEORDEN");

                entity.Property(e => e.BaseOrden1).HasColumnName("baseOrden");

                entity.Property(e => e.Marca)
                    .HasColumnName("marca")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.NomBodega)
                    .HasColumnName("nomBodega")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.NomShip)
                    .HasColumnName("nomShip")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.NomShop)
                    .HasColumnName("nomShop")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.NumPed)
                    .HasColumnName("numPed")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.PO)
                    .HasColumnName("pO")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Postcosecha)
                    .HasColumnName("postcosecha")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Prioridad)
                    .HasColumnName("prioridad")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.TipoDes)
                    .HasColumnName("tipoDes")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Total)
                    .HasColumnName("total")
                    .HasMaxLength(150)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Categoriafalenciaempaque>(entity =>
            {
                entity.HasKey(e => e.CategoriaFalenciaEmpaque1)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CATEGORIAFALENCIAEMPAQUE");

                entity.Property(e => e.CategoriaFalenciaEmpaque1).HasColumnName("CATEGORIA_FALENCIA_EMPAQUE");

                entity.Property(e => e.CategoriaFalenciaNombre)
                    .HasColumnName("CATEGORIA_FALENCIA_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.CategoriaFalenciaTipo).HasColumnName("CATEGORIA_FALENCIA_TIPO");
            });

            modelBuilder.Entity<Categoriafalenciaramo>(entity =>
            {
                entity.HasKey(e => e.CategoriaFalenciaRamoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CATEGORIAFALENCIARAMO");

                entity.Property(e => e.CategoriaFalenciaRamoId).HasColumnName("CATEGORIA_FALENCIA_RAMO_ID");

                entity.Property(e => e.CategoriaFalenciaRamoNombre)
                    .HasColumnName("CATEGORIA_FALENCIA_RAMO_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Checkecommerce>(entity =>
            {
                entity.ToTable("CHECKECOMMERCE");

                entity.Property(e => e.CheckEcommerceId).HasColumnName("CHECK_ECOMMERCE_ID");

                entity.Property(e => e.CheckEcommerceValor).HasColumnName("CHECK_ECOMMERCE_VALOR");

                entity.Property(e => e.ControlEcommerceId).HasColumnName("CONTROL_ECOMMERCE_ID");

                entity.Property(e => e.ProblemaEcommerceId).HasColumnName("PROBLEMA_ECOMMERCE_ID");

                entity.HasOne(d => d.ControlEcommerce)
                    .WithMany(p => p.Checkecommerce)
                    .HasForeignKey(d => d.ControlEcommerceId)
                    .HasConstraintName("FK__CHECKECOM__CONTR__084B3915");

                entity.HasOne(d => d.ProblemaEcommerce)
                    .WithMany(p => p.Checkecommerce)
                    .HasForeignKey(d => d.ProblemaEcommerceId)
                    .HasConstraintName("FK__CHECKECOM__PROBL__093F5D4E");
            });

            modelBuilder.Entity<Cliente>(entity =>
            {
                entity.HasKey(e => e.ClienteId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CLIENTE");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ClienteNombre)
                    .HasColumnName("CLIENTE_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.ClienteNombreMacro)
                    .HasColumnName("CLIENTE_NOMBRE_MACRO")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Elite).HasColumnName("ELITE");

                entity.Property(e => e.TipoClienteId).HasColumnName("TIPO_CLIENTE_ID");

                entity.HasOne(d => d.TipoCliente)
                    .WithMany(p => p.Cliente)
                    .HasForeignKey(d => d.TipoClienteId)
                    .HasConstraintName("FK__CLIENTE__TIPCL__0697FACD");
            });

            modelBuilder.Entity<TipoCliente>(entity =>
            {
                entity.ToTable("TIPO_CLIENTE");

                entity.Property(e => e.TipoClienteId).HasColumnName("TIPO_CLIENTE_ID");

                entity.Property(e => e.TipoClienteNombre)
                    .HasColumnName("TIPO_CLIENTE_NOMBRE")
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Controlalistamiento>(entity =>
            {
                entity.ToTable("CONTROLALISTAMIENTO");

                entity.Property(e => e.ControlAlistamientoId).HasColumnName("CONTROL_ALISTAMIENTO_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ControlAlistamientoAprobado).HasColumnName("CONTROL_ALISTAMIENTO_APROBADO");

                entity.Property(e => e.ControlAlistamientoFecha)
                    .HasColumnName("CONTROL_ALISTAMIENTO_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlAlistamientoTotal).HasColumnName("CONTROL_ALISTAMIENTO_TOTAL");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.TipoControlId).HasColumnName("TIPO_CONTROL_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Controlalistamiento)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK__CONTROLAL__CLIEN__7167D3BD");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlalistamiento)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLAL__DETAL__351DDF8C");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlalistamiento)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLAL__POSTC__725BF7F6");

                entity.HasOne(d => d.TipoControl)
                    .WithMany(p => p.Controlalistamiento)
                    .HasForeignKey(d => d.TipoControlId)
                    .HasConstraintName("FK__CONTROLAL__TIPO___3335971A");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlalistamiento)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__CONTROLAL__USUAR__73501C2F");
            });

            modelBuilder.Entity<Controlbanda>(entity =>
            {
                entity.ToTable("CONTROLBANDA");

                entity.Property(e => e.ControlBandaId).HasColumnName("CONTROL_BANDA_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ClienteMacro)
                    .HasColumnName("CLIENTE_MACRO")
                    .HasMaxLength(200);

                entity.Property(e => e.ControlBandaAprobado).HasColumnName("CONTROL_BANDA_APROBADO");

                entity.Property(e => e.ControlBandaDerogado)
                    .HasColumnName("CONTROL_BANDA_DEROGADO")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.ControlBandaDespachar).HasColumnName("CONTROL_BANDA_DESPACHAR");

                entity.Property(e => e.ControlBandaElaborados).HasColumnName("CONTROL_BANDA_ELABORADOS");

                entity.Property(e => e.ControlBandaFecha)
                    .HasColumnName("CONTROL_BANDA_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlBandaNumeroOrden)
                    .HasColumnName("CONTROL_BANDA_NUMERO_ORDEN")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ControlBandaTallos).HasColumnName("CONTROL_BANDA_TALLOS");

                entity.Property(e => e.ControlBandaTiempo).HasColumnName("CONTROL_BANDA_TIEMPO");

                entity.Property(e => e.ControlBandaTotal).HasColumnName("CONTROL_BANDA_TOTAL");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.Marca)
                    .HasColumnName("MARCA")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.TipoControlId).HasColumnName("TIPO_CONTROL_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Controlbanda)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK__CONTROLBA__CLIEN__67DE6983");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlbanda)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLBA__DETAL__3429BB53");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlbanda)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLBA__POSTC__69C6B1F5");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Controlbanda)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK__CONTROLBA__PRODU__68D28DBC");

                entity.HasOne(d => d.TipoControl)
                    .WithMany(p => p.Controlbanda)
                    .HasForeignKey(d => d.TipoControlId)
                    .HasConstraintName("FK__CONTROLBA__TIPO___324172E1");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlbanda)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__CONTROLBA__USUAR__6ABAD62E");
            });

            modelBuilder.Entity<Controlboncheo>(entity =>
            {
                entity.ToTable("CONTROLBONCHEO");

                entity.Property(e => e.ControlBoncheoId).HasColumnName("CONTROL_BONCHEO_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ControlBoncheoAprobado).HasColumnName("CONTROL_BONCHEO_APROBADO");

                entity.Property(e => e.ControlBoncheoFecha)
                    .HasColumnName("CONTROL_BONCHEO_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlBoncheoMesa).HasColumnName("CONTROL_BONCHEO_MESA");

                entity.Property(e => e.ControlBoncheoTiempo).HasColumnName("CONTROL_BONCHEO_TIEMPO");

                entity.Property(e => e.ControlBoncheoTotal).HasColumnName("CONTROL_BONCHEO_TOTAL");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Controlboncheo)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK__CONTROLBO__CLIEN__79FD19BE");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlboncheo)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLBO__DETAL__361203C5");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlboncheo)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLBO__POSTC__7BE56230");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Controlboncheo)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK__CONTROLBO__PRODU__7AF13DF7");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlboncheo)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__CONTROLBO__USUAR__7CD98669");
            });

            modelBuilder.Entity<Controlecommerce>(entity =>
            {
                entity.ToTable("CONTROLECOMMERCE");

                entity.Property(e => e.ControlEcommerceId).HasColumnName("CONTROL_ECOMMERCE_ID");

                entity.Property(e => e.ControlEcommerceFecha)
                    .HasColumnName("CONTROL_ECOMMERCE_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlEcommerceTurno).HasColumnName("CONTROL_ECOMMERCE_TURNO");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlecommerce)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLEC__DETAL__370627FE");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlecommerce)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLEC__POSTC__056ECC6A");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlecommerce)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__CONTROLEC__USUAR__1F2E9E6D");
            });

            modelBuilder.Entity<Controlecuador>(entity =>
            {
                entity.ToTable("CONTROLECUADOR");

                entity.Property(e => e.ControlEcuadorId).HasColumnName("CONTROL_ECUADOR_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ControlEcuadorAprobado).HasColumnName("CONTROL_ECUADOR_APROBADO");

                entity.Property(e => e.ControlEcuadorDerogado)
                    .HasColumnName("CONTROL_ECUADOR_DEROGADO")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.ControlEcuadorDespachar).HasColumnName("CONTROL_ECUADOR_DESPACHAR");

                entity.Property(e => e.ControlEcuadorElaborados).HasColumnName("CONTROL_ECUADOR_ELABORADOS");

                entity.Property(e => e.ControlEcuadorFecha)
                    .HasColumnName("CONTROL_ECUADOR_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlEcuadorNumeroOrden)
                    .HasColumnName("CONTROL_ECUADOR_NUMERO_ORDEN")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ControlEcuadorTallos).HasColumnName("CONTROL_ECUADOR_TALLOS");

                entity.Property(e => e.ControlEcuadorTiempo).HasColumnName("CONTROL_ECUADOR_TIEMPO");

                entity.Property(e => e.ControlEcuadorTotal).HasColumnName("CONTROL_ECUADOR_TOTAL");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.Marca)
                    .HasColumnName("MARCA")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Controlecuador)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK__CONTROLEC__CLIEN__0C1BC9F9");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlecuador)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLEC__DETAL__37FA4C37");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlecuador)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLEC__POSTC__0E04126B");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Controlecuador)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK__CONTROLEC__PRODU__0D0FEE32");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlecuador)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__CONTROLEC__USUAR__0EF836A4");
            });

            modelBuilder.Entity<Controlempaque>(entity =>
            {
                entity.HasKey(e => e.ControlEmpaqueId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CONTROLEMPAQUE");

                entity.HasIndex(e => e.DetalleFirmaId)
                    .HasName("RELATIONSHIP_10_FK");

                entity.HasIndex(e => e.ProductoId)
                    .HasName("RELATIONSHIP_20_FK");

                entity.HasIndex(e => e.UsuarioControlId)
                    .HasName("RELATIONSHIP_8_FK");

                entity.Property(e => e.ControlEmpaqueId).HasColumnName("CONTROL_EMPAQUE_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ClienteMacro)
                    .HasColumnName("CLIENTE_MACRO")
                    .HasMaxLength(200);

                entity.Property(e => e.ControlEmpaqueAprobado).HasColumnName("CONTROL_EMPAQUE_APROBADO");

                entity.Property(e => e.ControlEmpaqueDerogado)
                    .HasColumnName("CONTROL_EMPAQUE_DEROGADO")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.ControlEmpaqueDespachar).HasColumnName("CONTROL_EMPAQUE_DESPACHAR");

                entity.Property(e => e.ControlEmpaqueFecha)
                    .HasColumnName("CONTROL_EMPAQUE_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlEmpaqueNumeroOrden)
                    .HasColumnName("CONTROL_EMPAQUE_NUMERO_ORDEN")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ControlEmpaqueRamosCaja).HasColumnName("CONTROL_EMPAQUE_RAMOS_CAJA");

                entity.Property(e => e.ControlEmpaqueRamosRevisar).HasColumnName("CONTROL_EMPAQUE_RAMOS_REVISAR");

                entity.Property(e => e.ControlEmpaqueTallos).HasColumnName("CONTROL_EMPAQUE_TALLOS");

                entity.Property(e => e.ControlEmpaqueTiempo).HasColumnName("CONTROL_EMPAQUE_TIEMPO");

                entity.Property(e => e.ControlEmpaqueTotal).HasColumnName("CONTROL_EMPAQUE_TOTAL");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.Marca)
                    .HasColumnName("MARCA")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Controlempaque)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK__CONTROLEM__CLIEN__719CDDE7");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlempaque)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLEM__DETAL__7C1A6C5A");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlempaque)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLEM__POSTC__6DCC4D03");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Controlempaque)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK_CONTROLE_RELATIONS_PRODUCTO");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlempaque)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK_CONTROLE_RELATIONS_USUARIOC");
            });

            modelBuilder.Entity<Controlramo>(entity =>
            {
                entity.HasKey(e => e.ControlRamoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CONTROLRAMO");

                entity.HasIndex(e => e.DetalleFirmaId)
                    .HasName("RELATIONSHIP_9_FK");

                entity.HasIndex(e => e.ProductoId)
                    .HasName("RELATIONSHIP_19_FK");

                entity.HasIndex(e => e.UsuarioControlId)
                    .HasName("RELATIONSHIP_7_FK");

                entity.Property(e => e.ControlRamoId).HasColumnName("CONTROL_RAMO_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.Property(e => e.ClienteMacro)
                    .HasColumnName("CLIENTE_MACRO")
                    .HasMaxLength(200);

                entity.Property(e => e.ControlRamoAprobado).HasColumnName("CONTROL_RAMO_APROBADO");

                entity.Property(e => e.ControlRamoDerogado)
                    .HasColumnName("CONTROL_RAMO_DEROGADO")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.ControlRamoDespachar).HasColumnName("CONTROL_RAMO_DESPACHAR");

                entity.Property(e => e.ControlRamoElaborados).HasColumnName("CONTROL_RAMO_ELABORADOS");

                entity.Property(e => e.ControlRamoFecha)
                    .HasColumnName("CONTROL_RAMO_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ControlRamoNumeroOrden)
                    .HasColumnName("CONTROL_RAMO_NUMERO_ORDEN")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ControlRamoTallos).HasColumnName("CONTROL_RAMO_TALLOS");

                entity.Property(e => e.ControlRamoTiempo).HasColumnName("CONTROL_RAMO_TIEMPO");

                entity.Property(e => e.ControlRamoTotal).HasColumnName("CONTROL_RAMO_TOTAL");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.Marca)
                    .HasColumnName("MARCA")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Controlramo)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK__CONTROLRA__CLIEN__06CD04F7");

                entity.HasOne(d => d.DetalleFirma)
                    .WithMany(p => p.Controlramo)
                    .HasForeignKey(d => d.DetalleFirmaId)
                    .HasConstraintName("FK__CONTROLRA__DETAL__7D0E9093");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Controlramo)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__CONTROLRA__POSTC__17036CC0");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Controlramo)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK_CONTROLR_RELATIONS_PRODUCTO");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Controlramo)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK_CONTROLR_RELATIONS_USUARIOC");
            });

            modelBuilder.Entity<DetalleFirma>(entity =>
            {
                entity.ToTable("DETALLE_FIRMA");

                entity.Property(e => e.DetalleFirmaId).HasColumnName("DETALLE_FIRMA_ID");

                entity.Property(e => e.DetalleFirmaCodigo)
                    .HasColumnName("DETALLE_FIRMA_CODIGO")
                    .IsUnicode(false);

                entity.Property(e => e.FirmaId).HasColumnName("FIRMA_ID");

                entity.HasOne(d => d.Firma)
                    .WithMany(p => p.DetalleFirma)
                    .HasForeignKey(d => d.FirmaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__DETALLE_F__FIRMA__7B264821");
            });

            modelBuilder.Entity<Empaque>(entity =>
            {
                entity.ToTable("EMPAQUE");

                entity.Property(e => e.EmpaqueId).HasColumnName("EMPAQUE_ID");

                entity.Property(e => e.NumeroMesa)
                    .HasColumnName("NUMERO_MESA")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Variedad)
                    .HasColumnName("VARIEDAD")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Linea)
                    .HasColumnName("LINEA")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.ControlEmpaqueId).HasColumnName("CONTROL_EMPAQUE_ID");

                entity.HasOne(d => d.ControlEmpaque)
                    .WithMany(p => p.Empaque)
                    .HasForeignKey(d => d.ControlEmpaqueId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__EMPAQUE__CONTROL__3493CFA7");
            });

            modelBuilder.Entity<Errores>(entity =>
            {
                entity.ToTable("ERRORES");

                entity.Property(e => e.ErroresId).HasColumnName("ERRORES_ID");

                entity.Property(e => e.EmpleadoId).HasColumnName("EMPLEADO_ID");

                entity.Property(e => e.ErroresCadena)
                    .HasColumnName("ERRORES_CADENA")
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Falenciacontrolempaque>(entity =>
            {
                entity.HasKey(e => e.FalenciaControlEmpaqueId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("FALENCIACONTROLEMPAQUE");

                entity.Property(e => e.FalenciaControlEmpaqueId).HasColumnName("FALENCIA_CONTROL_EMPAQUE_ID");

                entity.Property(e => e.EmpaqueId).HasColumnName("EMPAQUE_ID");

                entity.Property(e => e.FalenciaControlEmpaqueCantidad).HasColumnName("FALENCIA_CONTROL_EMPAQUE_CANTIDAD");

                entity.Property(e => e.FalenciaEmpaqueId).HasColumnName("FALENCIA_EMPAQUE_ID");

                entity.HasOne(d => d.Empaque)
                    .WithMany(p => p.Falenciacontrolempaque)
                    .HasForeignKey(d => d.EmpaqueId)
                    .HasConstraintName("FK__FALENCIAC__EMPAQ__2CBDA3B5");

                entity.HasOne(d => d.FalenciaEmpaque)
                    .WithMany(p => p.Falenciacontrolempaque)
                    .HasForeignKey(d => d.FalenciaEmpaqueId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__FALENCIAC__FALEN__3D2915A8");
            });

            modelBuilder.Entity<Falenciaempaque>(entity =>
            {
                entity.HasKey(e => e.FalenciaEmpaqueId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("FALENCIAEMPAQUE");

                entity.HasIndex(e => e.CategoriaFalenciaEmpaque)
                    .HasName("RELATIONSHIP_4_FK");

                entity.HasIndex(e => e.MacroFalenciaId)
                    .HasName("RELATIONSHIP_18_FK");

                entity.Property(e => e.FalenciaEmpaqueId).HasColumnName("FALENCIA_EMPAQUE_ID");

                entity.Property(e => e.CategoriaFalenciaEmpaque).HasColumnName("CATEGORIA_FALENCIA_EMPAQUE");

                entity.Property(e => e.Codigo)
                    .HasColumnName("CODIGO")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Elite).HasColumnName("ELITE");

                entity.Property(e => e.FalenciaEmpaqueNombre)
                    .HasColumnName("FALENCIA_EMPAQUE_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.MacroFalenciaId).HasColumnName("MACRO_FALENCIA_ID");

                entity.HasOne(d => d.CategoriaFalenciaEmpaqueNavigation)
                    .WithMany(p => p.Falenciaempaque)
                    .HasForeignKey(d => d.CategoriaFalenciaEmpaque)
                    .HasConstraintName("FK_FALENCIA_RELATIONS_CATEGORI_1");

                entity.HasOne(d => d.MacroFalencia)
                    .WithMany(p => p.Falenciaempaque)
                    .HasForeignKey(d => d.MacroFalenciaId)
                    .HasConstraintName("FK_FALENCIA_RELATIONS_MACROFAL_1");
            });

            modelBuilder.Entity<Falenciaramo>(entity =>
            {
                entity.HasKey(e => e.FalenciaRamoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("FALENCIARAMO");

                entity.HasIndex(e => e.CategoriaFalenciaRamoId)
                    .HasName("RELATIONSHIP_1_FK");

                entity.HasIndex(e => e.MacroFalenciaId)
                    .HasName("RELATIONSHIP_17_FK");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.CategoriaFalenciaRamoId).HasColumnName("CATEGORIA_FALENCIA_RAMO_ID");

                entity.Property(e => e.Codigo)
                    .HasColumnName("CODIGO")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Elite).HasColumnName("ELITE");

                entity.Property(e => e.FalenciaRamoNombre)
                    .HasColumnName("FALENCIA_RAMO_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.MacroFalenciaId).HasColumnName("MACRO_FALENCIA_ID");

                entity.HasOne(d => d.CategoriaFalenciaRamo)
                    .WithMany(p => p.Falenciaramo)
                    .HasForeignKey(d => d.CategoriaFalenciaRamoId)
                    .HasConstraintName("FK_FALENCIA_RELATIONS_CATEGORI_10");

                entity.HasOne(d => d.MacroFalencia)
                    .WithMany(p => p.Falenciaramo)
                    .HasForeignKey(d => d.MacroFalenciaId)
                    .HasConstraintName("FK_FALENCIA_RELATIONS_MACROFAL_10");
            });

            modelBuilder.Entity<Falenciascontrolramo>(entity =>
            {
                entity.HasKey(e => e.FalenciasControlRamoId);

                entity.ToTable("FALENCIASCONTROLRAMO");

                entity.Property(e => e.FalenciasControlRamoId).HasColumnName("FALENCIA_CONTROL_RAMO_ID");

                entity.Property(e => e.FalenciaControlRamoCantidad).HasColumnName("FALENCIA_CONTROL_RAMO_CANTIDAD");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.RamoId).HasColumnName("RAMO_ID");

                entity.HasOne(d => d.FalenciaRamo)
                    .WithMany(p => p.Falenciascontrolramo)
                    .HasForeignKey(d => d.FalenciaRamoId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__FALENCIAS__FALEN__40F9A68C");

                entity.HasOne(d => d.Ramo)
                    .WithMany(p => p.Falenciascontrolramo)
                    .HasForeignKey(d => d.RamoId)
                    .HasConstraintName("FK__FALENCIAS__RAMO___40058253");
            });

            modelBuilder.Entity<Firma>(entity =>
            {
                entity.ToTable("FIRMA");

                entity.Property(e => e.FirmaId).HasColumnName("FIRMA_ID");

                entity.Property(e => e.FirmaCargo)
                    .HasColumnName("FIRMA_CARGO")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.FirmaCodigo)
                    .HasColumnName("FIRMA_CODIGO")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.FirmaCorreo)
                    .HasColumnName("FIRMA_CORREO")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.FirmaNombre)
                    .HasColumnName("FIRMA_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Repetido).HasColumnName("REPETIDO");
            });

            modelBuilder.Entity<Macrofalencia>(entity =>
            {
                entity.HasKey(e => e.MacroFalenciaId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("MACROFALENCIA");

                entity.Property(e => e.MacroFalenciaId).HasColumnName("MACRO_FALENCIA_ID");

                entity.Property(e => e.MacroFalenciaNombre)
                    .HasColumnName("MACRO_FALENCIA_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Postcosecha>(entity =>
            {
                entity.ToTable("POSTCOSECHA");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.Codigo)
                    .HasColumnName("CODIGO")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Elite).HasColumnName("ELITE");

                entity.Property(e => e.PostcosechaApodo)
                    .HasColumnName("POSTCOSECHA_APODO")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaNombre)
                    .IsRequired()
                    .HasColumnName("POSTCOSECHA_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Problemaalistamiento>(entity =>
            {
                entity.ToTable("PROBLEMAALISTAMIENTO");

                entity.Property(e => e.ProblemaAlistamientoId).HasColumnName("PROBLEMA_ALISTAMIENTO_ID");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.TallosAfectados).HasColumnName("TALLOS_AFECTADOS");

                entity.Property(e => e.TallosMuestra).HasColumnName("TALLOS_MUESTRA");

                entity.Property(e => e.VariedadNombre)
                    .HasColumnName("VARIEDAD_NOMBRE")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.HasOne(d => d.FalenciaRamo)
                    .WithMany(p => p.Problemaalistamiento)
                    .HasForeignKey(d => d.FalenciaRamoId)
                    .HasConstraintName("FK__PROBLEMAA__FALEN__7720AD13");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.Problemaalistamiento)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK__PROBLEMAA__PRODU__762C88DA");
            });

            modelBuilder.Entity<Problemabanda>(entity =>
            {
                entity.ToTable("PROBLEMABANDA");

                entity.Property(e => e.ProblemaBandaId).HasColumnName("PROBLEMA_BANDA_ID");

                entity.Property(e => e.BandaId).HasColumnName("BANDA_ID");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.RamosNoConformes).HasColumnName("RAMOS_NO_CONFORMES");

                entity.HasOne(d => d.Banda)
                    .WithMany(p => p.Falenciascontrolbanda)
                    .HasForeignKey(d => d.BandaId)
                    .HasConstraintName("FK_PROBLEMABANDA_RELATIONS_BANDA");

                entity.HasOne(d => d.FalenciaRamo)
                    .WithMany(p => p.Problemabanda)
                    .HasForeignKey(d => d.FalenciaRamoId)
                    .HasConstraintName("FK__PROBLEMAB__FALEN__6E8B6712");
            });

            modelBuilder.Entity<Banda>(entity =>
            {
                entity.HasKey(e => e.BandaId);

                entity.ToTable("BANDA");

                entity.Property(e => e.BandaId).HasColumnName("BANDA_ID");

                entity.Property(e => e.NumeroMesa)
                    .HasColumnName("NUMERO_MESA")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Variedad)
                    .HasColumnName("VARIEDAD")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Linea)
                    .HasColumnName("LINEA")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.ControlBandaId).HasColumnName("CONTROL_BANDA_ID");

                entity.HasOne(d => d.ControlBanda)
                    .WithMany(p => p.Banda)
                    .HasForeignKey(d => d.ControlBandaId)
                    .HasConstraintName("FK_BANDA_RELATIONS_CONROL_BANDA");
            });

            modelBuilder.Entity<Problemaboncheo>(entity =>
            {
                entity.ToTable("PROBLEMABONCHEO");

                entity.Property(e => e.ProblemaBoncheoId).HasColumnName("PROBLEMA_BONCHEO_ID");

                entity.Property(e => e.ControlBoncheoId).HasColumnName("CONTROL_BONCHEO_ID");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.RamosNoConformes).HasColumnName("RAMOS_NO_CONFORMES");

                entity.HasOne(d => d.ControlBoncheo)
                    .WithMany(p => p.Problemaboncheo)
                    .HasForeignKey(d => d.ControlBoncheoId)
                    .HasConstraintName("FK__PROBLEMAB__CONTR__7FB5F314");

                entity.HasOne(d => d.FalenciaRamo)
                    .WithMany(p => p.Problemaboncheo)
                    .HasForeignKey(d => d.FalenciaRamoId)
                    .HasConstraintName("FK__PROBLEMAB__FALEN__00AA174D");
            });

            modelBuilder.Entity<Problemasecommerce>(entity =>
            {
                entity.HasKey(e => e.ProblemaEcommerceId);

                entity.ToTable("PROBLEMASECOMMERCE");

                entity.Property(e => e.ProblemaEcommerceId).HasColumnName("PROBLEMA_ECOMMERCE_ID");

                entity.Property(e => e.ProblemaEcommerceNombre)
                    .HasColumnName("PROBLEMA_ECOMMERCE_NOMBRE")
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.ProblemaEcommerceNumero).HasColumnName("PROBLEMA_ECOMMERCE_NUMERO");

                entity.Property(e => e.ProblemaEcommerceTipo).HasColumnName("PROBLEMA_ECOMMERCE_TIPO");
            });

            modelBuilder.Entity<Problemasecuador>(entity =>
            {
                entity.ToTable("PROBLEMASECUADOR");

                entity.Property(e => e.ProblemasEcuadorId).HasColumnName("PROBLEMAS_ECUADOR_ID");

                entity.Property(e => e.ControlEcuadorId).HasColumnName("CONTROL_ECUADOR_ID");

                entity.Property(e => e.FalenciaRamoId).HasColumnName("FALENCIA_RAMO_ID");

                entity.Property(e => e.ProblemasEcuadorRamos).HasColumnName("PROBLEMAS_ECUADOR_RAMOS");

                entity.Property(e => e.TipoControlId).HasColumnName("TIPO_CONTROL_ID");

                entity.HasOne(d => d.ControlEcuador)
                    .WithMany(p => p.Problemasecuador)
                    .HasForeignKey(d => d.ControlEcuadorId)
                    .HasConstraintName("FK__PROBLEMAS__CONTR__13BCEBC1");

                entity.HasOne(d => d.FalenciaRamo)
                    .WithMany(p => p.Problemasecuador)
                    .HasForeignKey(d => d.FalenciaRamoId)
                    .HasConstraintName("FK__PROBLEMAS__FALEN__1699586C");

                entity.HasOne(d => d.TipoControl)
                    .WithMany(p => p.Problemasecuador)
                    .HasForeignKey(d => d.TipoControlId)
                    .HasConstraintName("FK__PROBLEMAS__TIPO___14B10FFA");
            });

            modelBuilder.Entity<ProcesoEmpaque>(entity =>
            {
                entity.ToTable("PROCESO_EMPAQUE");

                entity.Property(e => e.ProcesoEmpaqueId).HasColumnName("PROCESO_EMPAQUE_ID");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProcesoEmpaqueAltura).HasColumnName("PROCESO_EMPAQUE_ALTURA");

                entity.Property(e => e.ProcesoEmpaqueApilamiento).HasColumnName("PROCESO_EMPAQUE_APILAMIENTO");

                entity.Property(e => e.ProcesoEmpaqueCajas).HasColumnName("PROCESO_EMPAQUE_CAJAS");

                entity.Property(e => e.ProcesoEmpaqueFecha)
                    .HasColumnName("PROCESO_EMPAQUE_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ProcesoEmpaqueMovimientos).HasColumnName("PROCESO_EMPAQUE_MOVIMIENTOS");

                entity.Property(e => e.ProcesoEmpaqueSujeccion).HasColumnName("PROCESO_EMPAQUE_SUJECCION");

                entity.Property(e => e.ProcesoEmpaqueTemperaturaCajas).HasColumnName("PROCESO_EMPAQUE_TEMPERATURA_CAJAS");

                entity.Property(e => e.ProcesoEmpaqueTemperaturaCamion).HasColumnName("PROCESO_EMPAQUE_TEMPERATURA_CAMION");

                entity.Property(e => e.ProcesoEmpaqueTemperaturaCuartoFrio).HasColumnName("PROCESO_EMPAQUE_TEMPERATURA_CUARTO_FRIO");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.ProcesoEmpaque)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__PROCESO_E__POSTC__0880433F");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.ProcesoEmpaque)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__PROCESO_E__USUAR__662B2B3B");
            });

            modelBuilder.Entity<ProcesoHidratacion>(entity =>
            {
                entity.ToTable("PROCESO_HIDRATACION");

                entity.Property(e => e.ProcesoHidratacionId).HasColumnName("PROCESO_HIDRATACION_ID");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.ProcesoHidratacionCantidadRamos).HasColumnName("PROCESO_HIDRATACION_CANTIDAD_RAMOS");

                entity.Property(e => e.ProcesoHidratacionEstadoSoluciones).HasColumnName("PROCESO_HIDRATACION_ESTADO_SOLUCIONES");

                entity.Property(e => e.ProcesoHidratacionFecha)
                    .HasColumnName("PROCESO_HIDRATACION_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ProcesoHidratacionNivelSolucion).HasColumnName("PROCESO_HIDRATACION_NIVEL_SOLUCION");

                entity.Property(e => e.ProcesoHidratacionPhSolucion).HasColumnName("PROCESO_HIDRATACION_PH_SOLUCION");

                entity.Property(e => e.ProcesoHidratacionTiempo).HasColumnName("PROCESO_HIDRATACION_TIEMPO");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.ProcesoHidratacion)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__PROCESO_H__POSTC__078C1F06");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.ProcesoHidratacion)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK__PROCESO_H__USUAR__634EBE90");
            });

            modelBuilder.Entity<Producto>(entity =>
            {
                entity.HasKey(e => e.ProductoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PRODUCTO");

                entity.Property(e => e.ProductoId).HasColumnName("PRODUCTO_ID");

                entity.Property(e => e.Elite).HasColumnName("ELITE");

                entity.Property(e => e.ProductoNombre)
                    .HasColumnName("PRODUCTO_NOMBRE")
                    .HasMaxLength(150)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Ramo>(entity =>
            {
                entity.ToTable("RAMO");

                entity.Property(e => e.RamoId).HasColumnName("RAMO_ID");

                entity.Property(e => e.NumeroMesa)
                    .HasColumnName("NUMERO_MESA")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Variedad)
                    .HasColumnName("VARIEDAD")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Linea)
                    .HasColumnName("LINEA")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.ControlRamoId).HasColumnName("CONTROL_RAMO_ID");

                entity.HasOne(d => d.ControlRamo)
                    .WithMany(p => p.Ramo)
                    .HasForeignKey(d => d.ControlRamoId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__RAMO__CONTROL_RA__37703C52");
            });

            modelBuilder.Entity<Temperatura>(entity =>
            {
                entity.HasKey(e => e.TemperaturaId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("TEMPERATURA");

                entity.HasIndex(e => e.UsuarioControlId)
                    .HasName("RELATIONSHIP_11_FK");

                entity.Property(e => e.TemperaturaId).HasColumnName("TEMPERATURA_ID");

                entity.Property(e => e.PostcosechaId).HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.TemperaturaExterna).HasColumnName("TEMPERATURA_EXTERNA");

                entity.Property(e => e.TemperaturaFecha)
                    .HasColumnName("TEMPERATURA_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.TemperaturaInterna).HasColumnName("TEMPERATURA_INTERNA");

                entity.Property(e => e.TemperaturaInterna2).HasColumnName("TEMPERATURA_INTERNA2");

                entity.Property(e => e.TemperaturaInterna3).HasColumnName("TEMPERATURA_INTERNA3");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.Property(e => e.ClienteId).HasColumnName("CLIENTE_ID");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.Temperatura)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK__TEMPERATU__POSTC__09746778");

                entity.HasOne(d => d.UsuarioControl)
                    .WithMany(p => p.Temperatura)
                    .HasForeignKey(d => d.UsuarioControlId)
                    .HasConstraintName("FK_TEMPERAT_RELATIONS_USUARIOC_1");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Temperatura)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK_TEMPERAT_RELATIONS_CLIENTE_1");
            });

            modelBuilder.Entity<TipoControl>(entity =>
            {
                entity.HasKey(e => e.TipoControlId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("TIPO_CONTROL");

                entity.Property(e => e.TipoControlId).HasColumnName("TIPO_CONTROL_ID");

                entity.Property(e => e.ClaseControl).HasColumnName("CLASE_CONTROL");

                entity.Property(e => e.TipoControlNombre)
                    .HasColumnName("TIPO_CONTROL_NOMBRE")
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Usuariocontrol>(entity =>
            {
                entity.HasKey(e => e.UsuarioControlId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("USUARIOCONTROL");

                entity.Property(e => e.UsuarioControlId).HasColumnName("USUARIO_CONTROL_ID");

                entity.Property(e => e.Pais).HasColumnName("PAIS");

                entity.Property(e => e.UsuarioControlCodigo)
                    .HasColumnName("USUARIO_CONTROL_CODIGO")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.UsuarioControlContrasenia)
                    .HasColumnName("USUARIO_CONTROL_CONTRASENIA")
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.UsuarioControlNombre)
                    .HasColumnName("USUARIO_CONTROL_NOMBRE")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.UsuarioControlUsuario)
                    .HasColumnName("USUARIO_CONTROL_USUARIO")
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });


            modelBuilder.Entity<CirculoCalidad>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD");

                entity.Property(e => e.CirculoCalidadId).HasColumnName("CIRCULO_CALIDAD_ID");

                entity.Property(e => e.CirculoCalidadRevisados)
                    .HasColumnName("CIRCULO_CALIDAD_RAMOS_REVISADOS");

                entity.Property(e => e.CirculoCalidadRechazados)
                    .HasColumnName("CIRCULO_CALIDAD_RAMOS_RECHAZADOS");

                entity.Property(e => e.CirculoCalidadNumeroReunion)
                    .HasColumnName("CIRCULO_CALIDAD_NUMERO_REUNION");

                entity.Property(e => e.CirculoCalidadPorcentajeNoConforme)
                    .HasColumnName("CIRCULO_CALIDAD_PORCENTAJE_NO_CONFORME");

                entity.Property(e => e.CirculoCalidadComentario)
                    .HasColumnName("CIRCULO_CALIDAD_COMENTARIOS")
                    .IsUnicode(false);

                entity.Property(e => e.CirculoCalidadSupervisor)
                    .HasColumnName("CIRCULO_CALIDAD_SUPERVISOR1")
                    .IsUnicode(false);

                entity.Property(e => e.CirculoCalidadSupervisor2)
                    .HasColumnName("CIRCULO_CALIDAD_SUPERVISOR2")
                    .IsUnicode(false);

                entity.Property(e => e.CirculoCalidadEvaluacionSupervisor)
                    .HasColumnName("CIRCULO_CALIDAD_EVALUACION_SUPERVISOR1")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.CirculoCalidadEvaluacionSupervisor2)
                    .HasColumnName("CIRCULO_CALIDAD_EVALUACION_SUPERVISOR2")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId)
                    .HasColumnName("POSTCOSECHA_ID");

                entity.Property(e => e.CirculoCalidadFecha)
                    .HasColumnName("CIRCULO_CALIDAD_FECHA")
                    .HasColumnType("datetime");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.CirculoCalidad)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_RELATIONS_POSTCOSECHA");
            });
            
            modelBuilder.Entity<CirculoCalidadNumeroMesa>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadNumeroMesaId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD_NUMERO_MESA");

                entity.Property(e => e.CirculoCalidadNumeroMesaId)
                .HasColumnName("CIRCULO_CALIDAD_NUMERO_MESA_ID");

                entity.Property(e => e.CirculoCalidadNumeroMesaNombre)
                    .HasColumnName("CIRCULO_CALIDAD_NUMERO_MESA_NOMBRE")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Revisados)
                    .HasColumnName("REVISADOS");

                entity.Property(e => e.Rechazados)
                    .HasColumnName("RECHAZADOS");

                entity.Property(e => e.Porcentaje)
                    .HasColumnName("PORCENTAJE");

                entity.Property(e => e.CirculoCalidadId)
                    .HasColumnName("CIRCULO_CALIDAD_ID");

                entity.HasOne(d => d.CirculoCalidad)
                    .WithMany(p => p.CirculoCalidadNumeroMesa)
                    .HasForeignKey(d => d.CirculoCalidadId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_NUMMESA_RELATIONS_CIRCULO_CALIDAD");
            });

            modelBuilder.Entity<CirculoCalidadLinea>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadLineaId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD_LINEA");

                entity.Property(e => e.CirculoCalidadLineaId)
                .HasColumnName("CIRCULO_CALIDAD_LINEA_ID");

                entity.Property(e => e.CirculoCalidadLineaNombre)
                    .HasColumnName("CIRCULO_CALIDAD_LINEA_NOMBRE")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Revisados)
                    .HasColumnName("REVISADOS");

                entity.Property(e => e.Rechazados)
                    .HasColumnName("RECHAZADOS");

                entity.Property(e => e.Porcentaje)
                    .HasColumnName("PORCENTAJE");

                entity.Property(e => e.CirculoCalidadId)
                    .HasColumnName("CIRCULO_CALIDAD_ID");

                entity.HasOne(d => d.CirculoCalidad)
                    .WithMany(p => p.CirculoCalidadLinea)
                    .HasForeignKey(d => d.CirculoCalidadId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_LINEA_RELATIONS_CIRCULO_CALIDAD");
            });

            modelBuilder.Entity<CirculoCalidadVariedad>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadVariedadId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD_VARIEDAD");

                entity.Property(e => e.CirculoCalidadVariedadId)
                .HasColumnName("CIRCULO_CALIDAD_VARIEDAD_ID");

                entity.Property(e => e.CirculoCalidadVariedadNombre)
                    .HasColumnName("CIRCULO_CALIDAD_VARIEDAD_NOMBRE")
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.Revisados)
                    .HasColumnName("REVISADOS");

                entity.Property(e => e.Rechazados)
                    .HasColumnName("RECHAZADOS");

                entity.Property(e => e.Porcentaje)
                    .HasColumnName("PORCENTAJE");

                entity.Property(e => e.CirculoCalidadId)
                    .HasColumnName("CIRCULO_CALIDAD_ID");

                entity.HasOne(d => d.CirculoCalidad)
                    .WithMany(p => p.CirculoCalidadVariedad)
                    .HasForeignKey(d => d.CirculoCalidadId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_VARIEDAD_RELATIONS_CIRCULO_CALIDAD");
            });

            modelBuilder.Entity<CirculoCalidadFalencia>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadFalenciaId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD_FALENCIA");

                entity.Property(e => e.CirculoCalidadFalenciaId)
                .HasColumnName("CIRCULO_CALIDAD_FALENCIA_ID");

                entity.Property(e => e.Revisados)
                    .HasColumnName("REVISADOS");

                entity.Property(e => e.Rechazados)
                    .HasColumnName("RECHAZADOS");

                entity.Property(e => e.Porcentaje)
                    .HasColumnName("PORCENTAJE");

                entity.Property(e => e.CirculoCalidadId)
                    .HasColumnName("CIRCULO_CALIDAD_ID");

                entity.Property(e => e.FalenciaramosId)
                    .HasColumnName("FALENCIA_RAMO_ID");

                entity.HasOne(d => d.CirculoCalidad)
                    .WithMany(p => p.CirculoCalidadFalencia)
                    .HasForeignKey(d => d.CirculoCalidadId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_FALENCIA_RELATIONS_CIRCULO_CALIDAD");

                entity.HasOne(d => d.Falenciaramo)
                    .WithMany(p => p.CirculoCalidadFalencia)
                    .HasForeignKey(d => d.FalenciaramosId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_FALENCIA_RELATIONS_FALENCIA_RAMO");
            });

            modelBuilder.Entity<CirculoCalidadProducto>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadProductoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD_PRODUCTO");

                entity.Property(e => e.CirculoCalidadProductoId)
                .HasColumnName("CIRCULO_CALIDAD_PRODUCTO_ID");

                entity.Property(e => e.Revisados)
                    .HasColumnName("REVISADOS");

                entity.Property(e => e.Rechazados)
                    .HasColumnName("RECHAZADOS");

                entity.Property(e => e.Porcentaje)
                    .HasColumnName("PORCENTAJE");

                entity.Property(e => e.CirculoCalidadId)
                    .HasColumnName("CIRCULO_CALIDAD_ID");

                entity.Property(e => e.ProductoId)
                    .HasColumnName("PRODUCTO_ID");

                entity.HasOne(d => d.CirculoCalidad)
                    .WithMany(p => p.CirculoCalidadProducto)
                    .HasForeignKey(d => d.CirculoCalidadId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_PRODUCTO_RELATIONS_CIRCULO_CALIDAD");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.CirculocalidadProducto)
                    .HasForeignKey(d => d.ProductoId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_PRODUCTO_RELATIONS_PRODUCTO");
            });

            modelBuilder.Entity<CirculoCalidadCliente>(entity =>
            {
                entity.HasKey(e => e.CirculoCalidadClienteId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CIRCULO_CALIDAD_CLIENTE");

                entity.Property(e => e.CirculoCalidadClienteId)
                .HasColumnName("CIRCULO_CALIDAD_CLIENTE_ID");

                entity.Property(e => e.Revisados)
                    .HasColumnName("REVISADOS");

                entity.Property(e => e.Rechazados)
                    .HasColumnName("RECHAZADOS");

                entity.Property(e => e.Porcentaje)
                    .HasColumnName("PORCENTAJE");

                entity.Property(e => e.CirculoCalidadId)
                    .HasColumnName("CIRCULO_CALIDAD_ID");

                entity.Property(e => e.ClienteId)
                    .HasColumnName("CLIENTE_ID");

                entity.HasOne(d => d.CirculoCalidad)
                    .WithMany(p => p.CirculoCalidadCliente)
                    .HasForeignKey(d => d.CirculoCalidadId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_CLIENTE_RELATIONS_CIRCULO_CALIDAD");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.CirculoCalidadCliente)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK_CIRCULO_CALIDAD_CLIENTE_RELATIONS_CLIENTE");
            });
        
            modelBuilder.Entity<ProcesoMaritimo>(entity =>
            {
                entity.HasKey(e => e.ProcesoMaritimoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PROCESO_MARITIMO");

                entity.Property(e => e.ProcesoMaritimoId).HasColumnName("PROCESO_MARITIMO_ID");

                entity.Property(e => e.ProcesoMaritimoUsuarioControlId)
                    .HasColumnName("USUARIO_CONTROL_ID")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoObservacionesEmpaque)
                    .HasColumnName("PROCESO_MARITIMO_OBSERVACIONES_EMPAQUE")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoObservacionesHidratacion)
                    .HasColumnName("PROCESO_MARITIMO_OBSERVACIONES_HIDRATACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoObservacionesLlenadoContenedor)
                    .HasColumnName("PROCESO_MARITIMO_OBSERVACIONES_LLENA_CONTENEDOR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoObservacionesPalletizado)
                    .HasColumnName("PROCESO_MARITIMO_OBSERVACIONES_PALLETIZADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoObservacionesRequerimientosCriticos)
                    .HasColumnName("PROCESO_MARITIMO_OBSERVACIONES_REQUERIMEINTO_CRITICO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoObservacionesTransferencias)
                    .HasColumnName("PROCESO_MARITIMO_OBSERVACIONES_TRANSFERENCIAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoNumeroGuia)
                    .HasColumnName("PROCESO_MARITIMO_NUMERO_GUIA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoDestinoId)
                    .HasColumnName("DESTINO_MARITIMO_ID")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoRealizadoPor)
                    .HasColumnName("PROCESO_MARITIMO_REALIZADO_POR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAcompanamiento)
                    .HasColumnName("PROCESO_MARITIMO_ACOMPANAMIENTO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoNombreHidratante)
                    .HasColumnName("PROCESO_MARITIMO_NOMBRE_HIDRATANTE")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoPhSoluciones)
                    .HasColumnName("PROCESO_MARITIMO_PH_SOLUCION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoNivelSolucionTinas)
                    .HasColumnName("ROCESO_MARITIMO_NIVEL_SOLUCION_TINAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoSolucionHidratacionSinVegetal)
                    .HasColumnName("PROCESO_MARITIMO_SOLUCION_HIDRATACION_SIN_VEGETAL")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTemperaturaCuartoFrio)
                    .HasColumnName("PROCESO_MARITIMO_TEMPERATURA_CUARTO_FRIO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTemperaturaSolucionesHidratacion)
                    .HasColumnName("PROCESO_MARITIMO_TEMPERATURA_SOLUCIONES_HIDRATACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoEmpaqueAmbienteTemperatura)
                    .HasColumnName("PROCESO_MARITIMO_EMPAQUE_AMBIENTE_TEMPERATURA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoFlorEmpacada)
                    .HasColumnName("PROCESO_MARITIMOFLOR_EMPACADA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTransportCareEmpaque)
                    .HasColumnName("PROCESO_MARITIMO_TRASNPORTE_CARE_EMPAQUE")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoCajasVisualDeformes)
                    .HasColumnName("PROCESO_MARITIMO_CAJAS_VISUAL_FORMAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoEtiquetasCajasUbicadas)
                    .HasColumnName("PROCESO_MARITIMO_ETIQUETAS_CAJAS_UBICADAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTemperaturaCubiculoCamion)
                    .HasColumnName("PROCESO_MARITIMO_TEMPERATURA_CUBICULOS_CAMION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTemperaturaCajasTransferencia)
                    .HasColumnName("PROCESO_MARITIMO_TEMPERATURA_CAJAS_TRASNFERENCIA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAparenciaCajasTransferencia)
                    .HasColumnName("PROCESO_MARITIMO_APARENCIA_CAJAS_TRANSFARENCIA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoEstibasDebidamenteSelladas)
                    .HasColumnName("PROCESO_MARITIMO_ESTIBAS_DEBIDAMENTE_SELLADAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoPalletsEsquinerosCorrectamenteAjustados)
                    .HasColumnName("PROCESO_MARITIMO_PALLET_ESQUINEROS_CORRECTAMENTE_AJUSTADOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoPalletsAlturaContenedor)
                    .HasColumnName("PROCESO_MARITIMO_PALLET_ALTURA_CONTENEDOR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTemperaturaPalletContenedor)
                    .HasColumnName("PROCESO_MARITIMO_TEMPERATURA_PALLET_CONTENEDOR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoPalletIdentificadoNumero)
                    .HasColumnName("PROCESO_MARITIMO_PALLET_IDENTIFICADO_NUMERO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoTomaRegistroTemperaturas)
                    .HasColumnName("PROCESO_MARITIMO_TOMA_REGISTRI0_TEMPERATURA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoGenset)
                    .HasColumnName("PROCESO_MARITIMO_GENSET")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoContenedorEdadFabricacion)
                    .HasColumnName("PROCESO_MARITIMO_CONTENEDOR_EDAD_FABRICACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoContenedorCumplimientoSeteo)
                    .HasColumnName("PROCESO_MARITIMO_CONTENEDOR_CUMPLIMIENTO_SETEO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoContenedorPreEnfriado)
                    .HasColumnName("PROCESO_MARITIMO_CONTENEDOR_PREENFRIADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoContenedorlavadoDesinfectado)
                    .HasColumnName("PROCESO_MARITIMO_CIONTENEDOR_LAVADO_DESINFECTADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoCarguePreviamenteHumedecidos)
                    .HasColumnName("PROCESO_MARITIMO_CAGUE_PREVIAMENTE_HUMEDECIDOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoLlegandoCierreSellado)
                    .HasColumnName("PROCESO_MARITIMO_LLEGANDO_CIERRE_SELLADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoEstibasSelloICA)
                    .HasColumnName("PROCESO_MARITIMO_ESTIBAS_SELLO_TCA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoPalletsTensionZunchos)
                    .HasColumnName("PROCESO_MARITIMO_PALLET_TENSION_ZUNCHOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoPalletIdentificadoEtiqueta)
                    .HasColumnName("PROCESO_MARITIMO_PALLET_IDENTIFICADOR_ETIQUETA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoComponentePalletDestinosEtiquetas)
                    .HasColumnName("PROCESO_MARITIMO_COMPONENTE_PALLET_DESTINOS_ETIQUETAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoCamionSelloSeguridadContenedor)
                    .HasColumnName("PROCESO_MARITIMO_CAMION_SELLO_SEGURIDAD_CONTENEDOR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoVerificacionEncendidoTermografo)
                    .HasColumnName("PROCESO_MARITIMO_VERIFICACION_ENCENDIDO_TERMOGRAFO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoFotografiaPalletsEmpresaContenor)
                    .HasColumnName("PROCESO_MARITIMO_FOTOGRAFIA_PALLETS_EMPRESA_CONTENEDOR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoFecha)
                    .HasColumnName("PROCESO_MARITIMO_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ClienteId)
                    .HasColumnName("CLIENTE_ID")
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId)
                    .HasColumnName("POSTCOSECHA_ID")
                    .IsUnicode(false);

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.ProcesoMaritimo)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK_MARITIMO_RELATIONS_CLIENTE");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.ProcesoMaritimo)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK_MARITIMO_RELATIONS_POSTCOSECHA");

                entity.HasOne(d => d.Usuariocontrol)
                    .WithMany(p => p.ProcesoMaritimo)
                    .HasForeignKey(d => d.ProcesoMaritimoUsuarioControlId)
                    .HasConstraintName("FK_MARITIMO_RELATIONS_USUARIOCONTROLLER");

                entity.HasOne(d => d.DestinoMaritimo)
                    .WithMany(p => p.ProcesoMaritimo)
                    .HasForeignKey(d => d.ProcesoMaritimoDestinoId)
                    .HasConstraintName("FK_MARITIMO_RELATIONS_DESTINO");
            });

            modelBuilder.Entity<DestinoMaritimo>(entity =>
            {
                entity.HasKey(e => e.DestinoMaritimoId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("DESTINO_MARITIMO");

                entity.Property(e => e.DestinoMaritimoId).HasColumnName("DESTINO_MARITIMO_ID");

                entity.Property(e => e.DestinoMaritimoNombre)
                    .HasColumnName("DestinoMaritimoNombre")
                    .IsUnicode(false);
            });

            modelBuilder.Entity<ProcesoMaritimoAlstroemeria>(entity =>
            {
                entity.HasKey(e => e.ProcesoMaritimoAlstroemeriaId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PROCESO_MARITIMO_ALSTRO");

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaId)
                .HasColumnName("PROCESO_MARITIMO_ALSTRO_ID");

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaUsuarioControlId)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_USUARIO_CONTROL_ID")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaNumeroGuia)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_NUMERO_GUIA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaDestinoId)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_DESTINO_MARITIMO_ID")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaRealizadoPor)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_REALIZADO_POR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaAcompanamiento)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_ACOMPANAMIENTO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_RECEPCION_TEMPERATURA_HUMEDAD")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaRecepcionLavaDesinfecta)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_RECEPCION_LAVA_DESINFECTADA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_RECEPCION_SISTEMA_IDENTIFICACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionLongitudTallos)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_LONGITUD_TALLOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_CAPACITACION_PERSONAL")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_CAPUCHON_BIORENTADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_CAPUCHON_FLOWER_FOOD")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionLibreMaltrato)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_LIBRE_MALTRATO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionTallosCumplePeso)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_TALLOS_CUMPLE_PESO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionDespachosMaritimos)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_DESPACHOS_MARITIMOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionAseguramientoRamo)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_ASEGURAMIENTO_RAMO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTratamientoBaldesTinas)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRATAMIENTO_BALDES_TINAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTratamientoSolucionHidratacion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRATAMIENTO_SOLUCION_HIDRATACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTratamientoNivelSolucion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRATAMIENTO_NIVEL_SOLUCION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTratamientoCambioSolucion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRATMIENTO_CAMBIO_SOLUCION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTratamientoTiempoSala)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRATAMIENTO_TIEMPO_SALA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaHidratacionNumeroRamos)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_HIDRATACION_NUMERO_RAMOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaHidratacionRamosHidratados)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_HIDRATACION_RAMOS_HIDRATADOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_HIDRATACION_TEMPERATURA_CUARTO_FRIO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaHidratacionLimpioOrdenado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_HIDRATACION_LIMPIO_ORDENADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_EMPACADORES_CAPACITACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueEdadFlor)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_EDAD_FLOR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueEscurridoRamos)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_ESCURRIDO_RAMOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_TEMPERATURA_RAMOS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_CAJAS_REQUERIMIENTO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_CAJA_DESPACHO_MARITIMO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueCajasDeformidad)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_CAJAS_DEFORMIDAD")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_ETIQUETAS_CAJAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_PRODUCTO_EMPAQUE_CARGUE")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueTemperaturaHR)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_TEMPERATURA_HR")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_AUDITORIA_PRODUCTO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueEmpacoHB)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_EMPACO_HB")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteTemperauraCajas)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_TEMPERATURA_CAJAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteTemperaturaPromedio)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_TEMPERATURA_PROMEDIO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteCamionTransporta)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_CAMION_TRANSPORTA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteTemperaturaCamion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_TEMPERATURA_CAMION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteBuenaConexion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_BUENA_CONEXION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteThermoking)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_THERMOKING")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteCajasApiladas)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_CAJAS_APILADAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteAcopioPreenfriado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_ACOPIO_PREENFRIADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstromeriaTransporteTemperaturaFurgon)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_TEMPERATURA_FURGON")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaPalletizadoEstibasLimpias)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_PALLETIZADO_ESTIBAS_LIMPIAS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_PALLETIZADO_PALLETS_ESQUINEROS")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaPalletizadoPalletsAltura)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_PALLETIZADO_PALLETS_ALTURA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_PALLETIZADO_TEMPERATURA_DISTRIBUIDO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaPalletizadoPalletIdentificado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_PALLETIZADO_PALLET_IDENTIFICADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorGenset)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_GENSET")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorFechaFabricacion)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_FECHA_FABRICACION")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorContenedorSeteo)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_CONTENEDOR_SETEO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorContenedorPreenfriado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_CONTENEDOR_PREENFRIADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorContenedorLavado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_CONTENEDOR_LAVADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorSachetsEthiblock)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_SACHETS_ETHIBLOCK")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorCierreSellado)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_CIERRE_SELLADO")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorControlTemperatura)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_CONTROL_TEMPERATURA")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaContenedorObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CONTENEDOR_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaPalletizadoObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_PALLETIZADO_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTransporteObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRANSPORTE_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaEmpaqueObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_EMPAQUE_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaHidratacionObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_HIDRATACION_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaTratamientoObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_TRATAMIENTO_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstroemeriaClasificacionObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_CLASIFICACION_OBSERVACIONES")
                    .IsUnicode(false);

                entity.Property(e => e.ProcesoMaritimoAlstromeriaRecepcionObservaciones)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_RECEPCION_OBSERVACIONES")
                    .IsUnicode(false);


                entity.Property(e => e.ProcesoMaritimoAlstroemeriaFecha)
                    .HasColumnName("PROCESO_MARITIMO_ALSTRO_FECHA")
                    .HasColumnType("datetime");

                entity.Property(e => e.ClienteId)
                    .HasColumnName("CLIENTE_ID")
                    .IsUnicode(false);

                entity.Property(e => e.PostcosechaId)
                    .HasColumnName("POSTCOSECHA_ID")
                    .IsUnicode(false);

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.ProcesoMaritimoAlstroemeria)
                    .HasForeignKey(d => d.ClienteId)
                    .HasConstraintName("FK_MARITIMO_ALSTRO_RELATIONS_CLIENTE");

                entity.HasOne(d => d.Postcosecha)
                    .WithMany(p => p.ProcesoMaritimoAlstroemeria)
                    .HasForeignKey(d => d.PostcosechaId)
                    .HasConstraintName("FK_MARITIMO_ALSTRO_RELATIONS_POSTCOSECHA");

                entity.HasOne(d => d.Usuariocontrol)
                    .WithMany(p => p.ProcesoMaritimoAlstroemeria)
                    .HasForeignKey(d => d.ProcesoMaritimoAlstroemeriaUsuarioControlId)
                    .HasConstraintName("FK_MARITIMO_ALSTRO_RELATIONS_USUARIOCONTROLLER");

                entity.HasOne(d => d.DestinoMaritimo)
                    .WithMany(p => p.ProcesoMaritimoAlstroemeria)
                    .HasForeignKey(d => d.ProcesoMaritimoAlstroemeriaDestinoId)
                    .HasConstraintName("FK_MARITIMO_ALSTRO_RELATIONS_DESTINO");
            });
        }
    }
}
