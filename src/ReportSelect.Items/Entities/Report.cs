using System;
using System.Collections.Generic;

namespace ReportSelect.Items.Entities
{
    public class Report
    {
        public Guid Id { get; set; }

        public string Name { get; set; }

        public IList<Query> Queries { get; set; }
    }
}
