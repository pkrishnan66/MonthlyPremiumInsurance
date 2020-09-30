using System;
using System.Collections.Generic;
using System.Text;

namespace TALPremiumInsurance.BusinessLogic
{
    public interface ICalculationBusinessLogic
    {
        int CalculateClientAgeByDateOfBirth(DateTime dateOfBirth);
        decimal CalculateClientMonthlyPremium(decimal deathSumInsured, int age, int occupationId);
    }
}
