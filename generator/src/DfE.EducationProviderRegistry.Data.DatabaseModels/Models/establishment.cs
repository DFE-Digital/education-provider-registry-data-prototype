using System;
using System.Collections.Generic;

namespace DfE.EducationProviderRegistry.Data.DatabaseModels.Models;

public partial class Establishment
{
    public int Urn { get; set; }

    public string Establishmentname { get; set; } = null!;

    public int Establishmenttypeid { get; set; }

    public int Educationphaseid { get; set; }

    public string? Schoolwebsite { get; set; }

    public string? Telephonenum { get; set; }

    public string? Street { get; set; }

    public string? Town { get; set; }

    public string? Postcode { get; set; }

    public int Establishmentstatusid { get; set; }

    public virtual Educationphase Educationphase { get; set; } = null!;

    public virtual Establishmentstatus Establishmentstatus { get; set; } = null!;

    public virtual Establishmenttype Establishmenttype { get; set; } = null!;

    public virtual ICollection<Establishmentgroup> Group { get; set; } = new List<Establishmentgroup>();
}
