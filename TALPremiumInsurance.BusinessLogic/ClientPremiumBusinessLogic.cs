using System;
using System.Collections.Generic;
using System.Text;
using TALPremiumInsurance.Repository;

namespace TALPremiumInsurance.BusinessLogic
{
    public class ClientPremiumBusinessLogic : IClientPremiumBusinessLogic
    {
        private IClientPremiumRepository _clientPremiumRepository;
        public ClientPremiumBusinessLogic(IClientPremiumRepository clientPremiumRepository)
        {
            _clientPremiumRepository = clientPremiumRepository;
        }
        public List<ClientPremium> GetAllClients()
        {
            return _clientPremiumRepository.GetAllClients();
        }

        public string InsertClient()
        {
            return "Insert";
        }
    }
}
