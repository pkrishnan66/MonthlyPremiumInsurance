using System;
using TALPremiumInsurance.Repository;
using System.Linq;
using System.Collections.Generic;

namespace TALPremiumInsurance.Repository
{
    public class ClientPremiumRepository : IClientPremiumRepository
    {
        public List<ClientPremium> GetAllClients()
        {
            TALPremiumInsuranceDbContext db = new TALPremiumInsuranceDbContext();
            var clients = db.ClientPremiums.Where(c =>c.IsActive == true).ToList();            
            return clients;
        }
    }
}
