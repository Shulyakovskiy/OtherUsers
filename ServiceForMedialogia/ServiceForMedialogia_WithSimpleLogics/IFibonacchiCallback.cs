using System.ServiceModel;

namespace ServiceForMedialogia_WithSimpleLogics
{
    public interface IFibonacchiCallback
    {
             [OperationContract(IsOneWay=true)]
             void Equals(long result);
             [OperationContract(IsOneWay = true)]
             void CalculationHistory(string eqn);

        }

    }
