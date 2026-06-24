using System;
using System.Collections.Generic;
using DfE.EducationProviderRegistry.Data.DatabaseModels.Models;
using Microsoft.EntityFrameworkCore;

namespace DfE.EducationProviderRegistry.Data.DatabaseModels.Context;

public partial class EducationProviderRegistryDbContext : DbContext
{
    public EducationProviderRegistryDbContext(DbContextOptions<EducationProviderRegistryDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Educationphase> Educationphase { get; set; }

    public virtual DbSet<Establishment> Establishment { get; set; }

    public virtual DbSet<Establishmentgroup> Establishmentgroup { get; set; }

    public virtual DbSet<Establishmentgrouptype> Establishmentgrouptype { get; set; }

    public virtual DbSet<Establishmentstatus> Establishmentstatus { get; set; }

    public virtual DbSet<Establishmenttype> Establishmenttype { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Educationphase>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("educationphase_pkey");

            entity.ToTable("educationphase");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(200)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Establishment>(entity =>
        {
            entity.HasKey(e => e.Urn).HasName("establishment_pkey");

            entity.ToTable("establishment");

            entity.Property(e => e.Urn)
                .ValueGeneratedNever()
                .HasColumnName("urn");
            entity.Property(e => e.Educationphaseid).HasColumnName("educationphaseid");
            entity.Property(e => e.Establishmentname)
                .HasMaxLength(255)
                .HasColumnName("establishmentname");
            entity.Property(e => e.Establishmentstatusid).HasColumnName("establishmentstatusid");
            entity.Property(e => e.Establishmenttypeid).HasColumnName("establishmenttypeid");
            entity.Property(e => e.Postcode)
                .HasMaxLength(20)
                .HasColumnName("postcode");
            entity.Property(e => e.Schoolwebsite)
                .HasMaxLength(255)
                .HasColumnName("schoolwebsite");
            entity.Property(e => e.Street)
                .HasMaxLength(255)
                .HasColumnName("street");
            entity.Property(e => e.Telephonenum)
                .HasMaxLength(50)
                .HasColumnName("telephonenum");
            entity.Property(e => e.Town)
                .HasMaxLength(255)
                .HasColumnName("town");

            entity.HasOne(d => d.Educationphase).WithMany(p => p.Establishment)
                .HasForeignKey(d => d.Educationphaseid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("establishment_educationphaseid_fkey");

            entity.HasOne(d => d.Establishmentstatus).WithMany(p => p.Establishment)
                .HasForeignKey(d => d.Establishmentstatusid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("establishment_establishmentstatusid_fkey");

            entity.HasOne(d => d.Establishmenttype).WithMany(p => p.Establishment)
                .HasForeignKey(d => d.Establishmenttypeid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("establishment_establishmenttypeid_fkey");
        });

        modelBuilder.Entity<Establishmentgroup>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("establishmentgroup_pkey");

            entity.ToTable("establishmentgroup");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.Name).HasColumnName("name");
            entity.Property(e => e.TypeCode)
                .HasMaxLength(10)
                .HasColumnName("type_code");

            entity.HasOne(d => d.TypeCodeNavigation).WithMany(p => p.Establishmentgroup)
                .HasForeignKey(d => d.TypeCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("establishmentgroup_type_code_fkey");

            entity.HasMany(d => d.Urn).WithMany(p => p.Group)
                .UsingEntity<Dictionary<string, object>>(
                    "Grouplink",
                    r => r.HasOne<Establishment>().WithMany()
                        .HasForeignKey("Urn")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("grouplink_urn_fkey"),
                    l => l.HasOne<Establishmentgroup>().WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("grouplink_group_id_fkey"),
                    j =>
                    {
                        j.HasKey("GroupId", "Urn").HasName("grouplink_pkey");
                        j.ToTable("grouplink");
                        j.IndexerProperty<int>("GroupId").HasColumnName("group_id");
                        j.IndexerProperty<int>("Urn").HasColumnName("urn");
                    });
        });

        modelBuilder.Entity<Establishmentgrouptype>(entity =>
        {
            entity.HasKey(e => e.Code).HasName("establishmentgrouptype_pkey");

            entity.ToTable("establishmentgrouptype");

            entity.Property(e => e.Code)
                .HasMaxLength(10)
                .HasColumnName("code");
            entity.Property(e => e.Name).HasColumnName("name");
        });

        modelBuilder.Entity<Establishmentstatus>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("establishmentstatus_pkey");

            entity.ToTable("establishmentstatus");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(200)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Establishmenttype>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("establishmenttype_pkey");

            entity.ToTable("establishmenttype");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(200)
                .HasColumnName("name");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
