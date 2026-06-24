using System;
using System.Collections.Generic;

namespace DfE.EducationProviderRegistry.Data.DatabaseModels.Models;

public partial class Establishmentgroup
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string TypeCode { get; set; } = null!;

    public virtual Establishmentgrouptype TypeCodeNavigation { get; set; } = null!;

    public virtual ICollection<Establishment> Urn { get; set; } = new List<Establishment>();
}
