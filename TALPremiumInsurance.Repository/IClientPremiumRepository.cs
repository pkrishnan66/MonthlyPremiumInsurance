using System;
using System.Collections.Generic;
using System.Text;

namespace TALPremiumInsurance.Repository
{
    public interface IClientPremiumRepository 
    {
        List<ClientPremium> GetAllClients();

    }
}
