using System;
using System.Collections.Generic;

namespace DfE.EducationProviderRegistry.Data.DatabaseModels.Models;

public partial class Establishmentstatus
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Establishment> Establishment { get; set; } = new List<Establishment>();
}
