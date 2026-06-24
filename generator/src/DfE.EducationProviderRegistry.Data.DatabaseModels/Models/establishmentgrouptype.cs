using System;
using System.Collections.Generic;

namespace DfE.EducationProviderRegistry.Data.DatabaseModels.Models;

public partial class Establishmentgrouptype
{
    public string Code { get; set; } = null!;

    public string Name { get; set; } = null!;

    public virtual ICollection<Establishmentgroup> Establishmentgroup { get; set; } = new List<Establishmentgroup>();
}
