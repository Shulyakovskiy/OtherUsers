using System;
using System.ServiceModel;
using System.ServiceModel.Description;

namespace ServiceForMedialogia_WithSimpleLogics
{
    public static class ServiceInfo
    {
        private static readonly Type ServiceType = typeof (FibonacchiService);

        public static void ShowServiceInfoImplementation()
        {

            try
            {
                var host = new ServiceHost(ServiceType);
                host.Open();
                ShowInfo(host);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

        }

        private static void ShowInfo(ServiceHost sh)
        {
            Console.WriteLine();
            Console.WriteLine("***Host info***");
            foreach (ServiceEndpoint se in sh.Description.Endpoints)
            {
                Console.WriteLine("Address: {0}", se.Address);
                Console.WriteLine("Binding: {0}", se.Binding.Name);
                Console.WriteLine("Contract: {0}", se.Contract.Name);
                Console.WriteLine();
            }

            Console.WriteLine("**********************");
            Console.WriteLine();
        }
    }
}