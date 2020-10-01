using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonthlyPremiumInsurance.ViewModels
{
    public class ClientPremiumViewModel
    {
        public int ClientPremiumId { get; set; }
        public string Name { get; set; }
        public int  Age { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string DateOfBirthStr { get; set; }
        public string Occupation { get; set; }
        public decimal DeathSumInsured { get; set; }
        public string Rating { get; set; }
        public decimal Factor { get; set; }
        public decimal MonthlyPremium { get; set; }
        public int OccupationId { get; set; }
    }
}