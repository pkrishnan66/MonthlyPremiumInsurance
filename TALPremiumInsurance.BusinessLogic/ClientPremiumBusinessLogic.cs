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

        public void CreateClientPremium(ClientPremium clientPremium)
        {
            _clientPremiumRepository.CreateClientPremium(clientPremium);
        }

        public List<ClientPremium> GetAllClients()
        {
            return _clientPremiumRepository.GetAllClients();
        }
        
    }
}
