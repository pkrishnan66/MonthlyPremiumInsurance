using System.Web.Mvc;
using TALPremiumInsurance.BusinessLogic;
using TALPremiumInsurance.Repository;
using Unity;
using Unity.Mvc5;

namespace MonthlyPremiumInsurance
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();
            container.RegisterType<IClientPremiumBusinessLogic, ClientPremiumBusinessLogic>();
            container.RegisterType<ICalculationBusinessLogic, CalculationBusinessLogic>();
            container.RegisterType<IClientPremiumRepository, ClientPremiumRepository>();
            container.RegisterType<ICalculationRepository, CalculationRepository>();
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}