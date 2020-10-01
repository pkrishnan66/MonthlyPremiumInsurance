using MonthlyPremiumInsurance.ViewModels;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TALPremiumInsurance.BusinessLogic;
using TALPremiumInsurance.Repository;

namespace MonthlyPremiumInsurance.Controllers
{
    public class ClientController : Controller
    {
        // GET: Client
        private readonly IClientPremiumBusinessLogic _clientBusinessLogic;
        private readonly ICalculationBusinessLogic _calculationBusinessLogic;
        public ClientController(IClientPremiumBusinessLogic clientBusinessLogic, ICalculationBusinessLogic calculationBusinessLogic)
        {
            this._clientBusinessLogic = clientBusinessLogic;
            this._calculationBusinessLogic = calculationBusinessLogic;
        }
        public ClientController()
        {

        }

        public ActionResult Create()
        {
            return View();
        }
        public ActionResult ClientPremiumList()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetClientPremiumList()
        {
            var clientPremiums = _clientBusinessLogic.GetAllClients();
            var clientPremiumViewModelList = new List<ClientPremiumViewModel>();
            if (clientPremiums.Count() > 0)
                foreach (var clientPremium in clientPremiums)
                {
                    var clientPremiumViewModel = new ClientPremiumViewModel
                    {
                        ClientPremiumId = clientPremium.ClientPremiumId,
                        Name = clientPremium.Name,
                        Age = clientPremium.Age,
                        DateOfBirth = clientPremium.DateOfBirth,
                        Occupation = clientPremium.Occupation.Occupation1,
                        DeathSumInsured = clientPremium.DeathSumInsured,
                        Rating = clientPremium.Occupation.OccupationRating.Rating,
                        MonthlyPremium = clientPremium.MonthlyPremium,
                        Factor = clientPremium.Occupation.OccupationRating.Factor
                    };
                    clientPremiumViewModelList.Add(clientPremiumViewModel);

                }
            //DateTime dateOfBirth = Convert.ToDateTime("1983/09/12");
            //int y = _calculationBusinessLogic.CalculateClientAgeByDateOfBirth(dateOfBirth);
            return Json(clientPremiumViewModelList, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetClientAge(DateTime dateOfBirth)
        {
            var age = _calculationBusinessLogic.CalculateClientAgeByDateOfBirth(dateOfBirth);
            return Json(age, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetMonthlyPremiumForClient(string calculatePremiumObject)
        {
            var parsedObj = JsonConvert.DeserializeObject<CalculateMonthlyPremiumViewModel>(calculatePremiumObject);
           
            var monthlyPremium = _calculationBusinessLogic.CalculateClientMonthlyPremium(parsedObj.DeathSumInsured, parsedObj.Age, parsedObj.OccupationId);
            return Json(monthlyPremium, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult CreatePremiumForClient(ClientPremiumViewModel clientPremium)
        {
            //var parsedObj = JsonConvert.DeserializeObject<ClientPremiumViewModel>(createPremiumJson);
            var clientPremiumData = new ClientPremium
            {
                Name = clientPremium.Name,
                Age = clientPremium.Age,
                DateOfBirth = Convert.ToDateTime(clientPremium.DateOfBirthStr),
                OccupationId = clientPremium.OccupationId,
                DeathSumInsured = clientPremium.DeathSumInsured,
                MonthlyPremium = clientPremium.MonthlyPremium,
                IsActive = true
            };
            _clientBusinessLogic.CreateClientPremium(clientPremiumData);
            return Json(null, JsonRequestBehavior.AllowGet);
        }
    }
}