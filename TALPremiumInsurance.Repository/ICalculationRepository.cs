using System;
using System.Collections.Generic;
using System.Text;

namespace TALPremiumInsurance.Repository
{
    public interface ICalculationRepository
    {
        decimal CalculateClientMonthlyPremium(decimal deathSumInsured, int age, int occupationId);
    }
}
