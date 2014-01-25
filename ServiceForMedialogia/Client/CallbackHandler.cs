using System;
using Client.FibService;

namespace Client
{
        class CallbackHandler : IFibonacchContractCallback
        {
            public void Equals(long result)
            {
                Console.WriteLine("The result is:" + result + Environment.NewLine);
            }

            public void CalculationHistory(string history)
            {
                Console.WriteLine(history);
            }
        }

}