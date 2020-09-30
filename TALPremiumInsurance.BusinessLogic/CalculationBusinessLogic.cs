using System;
using TALPremiumInsurance.Repository;

namespace TALPremiumInsurance.BusinessLogic
{
    public class CalculationBusinessLogic : ICalculationBusinessLogic
    {
        private ICalculationRepository _calculationRepository;
        private const int leapYearDay = 59;
        public CalculationBusinessLogic(ICalculationRepository calculationRepository)
        {
            _calculationRepository = calculationRepository;
        }
        public int CalculateClientAgeByDateOfBirth(DateTime dateOfBirth)
        {            
            int currentAge = 0;
            //If dateofBirth and current date are both leap years or not leap years
            if ((DateTime.IsLeapYear(DateTime.Now.Year) && DateTime.IsLeapYear(dateOfBirth.Year))
                || (!DateTime.IsLeapYear(DateTime.Now.Year) && !DateTime.IsLeapYear(dateOfBirth.Year)))
            {
                currentAge = FetchCurrentAgeExcludingLeapDay(dateOfBirth);
            }
            //If current year is a leap year && date of birth is not a leap year
            if((DateTime.IsLeapYear(DateTime.Now.Year) && !DateTime.IsLeapYear(dateOfBirth.Year)
                || (!DateTime.IsLeapYear(DateTime.Now.Year) && DateTime.IsLeapYear(dateOfBirth.Year))))
            {
                if (DateTime.Now.DayOfYear <= leapYearDay)
                {
                    currentAge = FetchCurrentAgeExcludingLeapDay(dateOfBirth);
                }
                else
                {
                    currentAge = FetchCurrentAgeIncludingLeapDay(dateOfBirth);
                }
            }
            return currentAge;
        }

        private int FetchCurrentAgeExcludingLeapDay(DateTime dateOfBirth)
        {
            if (DateTime.Now.DayOfYear < dateOfBirth.DayOfYear)
            {
               return DateTime.Now.Year - dateOfBirth.Year - 1;
            }
            else
            {
                return DateTime.Now.Year - dateOfBirth.Year;
            }
        }

        private int FetchCurrentAgeIncludingLeapDay(DateTime dateOfBirth)
        {
            if(DateTime.Now.DayOfYear >= dateOfBirth.DayOfYear)
            {
                return DateTime.Now.Year - dateOfBirth.Year;
            }
            else
            {
                return DateTime.Now.Year - dateOfBirth.Year - 1;
            }
        }

        public decimal CalculateClientMonthlyPremium(decimal deathSumInsured, int age, int occupationId)
        {
            return _calculationRepository.CalculateClientMonthlyPremium(deathSumInsured, age, occupationId);
        }
    }
}
