using System;
using System.ServiceModel;

namespace ServiceForMedialogia_WithSimpleLogics
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class FibonacchiService : IFibonacchContract
    {
        long _result;
        string _history;
        readonly IFibonacchiCallback _callback = null;

        

        public FibonacchiService()
        {
            _result = 0;
            _history = "";
            _callback = OperationContext.Current.GetCallbackChannel<IFibonacchiCallback>();
           
        }

        public void Clear()
        {

            _result = 0;
            _history = "";
            _callback.CalculationHistory("History cleared" + Environment.NewLine);
        }


        public void Fibonacchi(int n)
        {
            _result = Fib(n);
            _history += "Calculated " + n + "th Fibonacchi number." + Environment.NewLine;
            _callback.CalculationHistory(_history);
            _callback.Equals(_result);
        }

        long Fib(int n)
        {
            int[] temp = { 0, 1, 1 };

            if (n < 1)
            {
                throw new ArgumentException();
            }
            if (n <= 3)
            {
                return temp[n - 1];
            }

            for (int i = 0; i < n - 3; i++)
            {
                temp[0] = temp[1];
                temp[1] = temp[2];
                temp[2] = temp[0] + temp[1];
            }
            return temp[2];
        }


    }

}
