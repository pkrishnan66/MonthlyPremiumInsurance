using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;

namespace TALPremiumInsurance.Repository
{
    public class CalculationRepository : ICalculationRepository
    {
        public decimal CalculateClientMonthlyPremium(decimal deathSumInsured, int age , int occupationId)
        {
            TALPremiumInsuranceDbContext db = new TALPremiumInsuranceDbContext();
            int occupationRatingId = db.Occupations.Find(occupationId).OccupationRatingId;
            var factor = db.OccupationRatings.Find(occupationRatingId).Factor;
            var monthlyPremiumAmount = Math.Round(((deathSumInsured * factor * age) / 1000) * 12,2);           
            return monthlyPremiumAmount;
        }
    }
}
