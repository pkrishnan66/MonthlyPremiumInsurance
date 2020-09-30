using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonthlyPremiumInsurance.ViewModels
{
    public class CalculateMonthlyPremiumViewModel
    {
        public int OccupationId { get; set; }
        public decimal DeathSumInsured { get; set; }
        public int Age { get; set; }
    }
}