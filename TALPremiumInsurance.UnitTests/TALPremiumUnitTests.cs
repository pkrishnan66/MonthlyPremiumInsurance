using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TALPremiumInsurance.BusinessLogic;
using TALPremiumInsurance.Repository;
using Xunit;

namespace TALPremiumInsurance.UnitTests
{
    public class TALPremiumUnitTests
    {
        [Theory]
        [InlineData("12/09/1978" ,42)]
        [InlineData("11/10/1983", 36)]
        [InlineData("11/10/1988", 31)]
        [InlineData("12/09/1988", 32)]
        [InlineData("30/09/1988", 32)]
        [InlineData("31/10/1999", 20)]
        [InlineData("29/02/1984", 36)]
        public void CalculateClientAgeByDateOfBirth(string dateOfBirth, int ageExpected)
        {
            Mock<ICalculationRepository> mockCalcRepository = new Mock<ICalculationRepository>();
            var CalculationBusinessLogic = new CalculationBusinessLogic(mockCalcRepository.Object); 
            DateTime date = Convert.ToDateTime(dateOfBirth);
           int ageActual = CalculationBusinessLogic.CalculateClientAgeByDateOfBirth(date);
            Assert.Equal(ageExpected, ageActual);
        }
    }
}
