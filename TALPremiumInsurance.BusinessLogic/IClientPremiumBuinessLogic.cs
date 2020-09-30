using System;
using System.Collections.Generic;
using System.Text;
using TALPremiumInsurance.Repository;

namespace TALPremiumInsurance.BusinessLogic
{
    public interface IClientPremiumBusinessLogic
    {
        List<ClientPremium> GetAllClients();
        string InsertClient();        
    }
}
