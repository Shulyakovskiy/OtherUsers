using System.ServiceModel;

namespace ServiceForMedialogia_WithSimpleLogics
{
    [ServiceContract(Namespace = "http://www.mlg.ru/24/14", SessionMode = SessionMode.Required,
                 CallbackContract = typeof(IFibonacchiCallback))]
    public interface IFibonacchContract
    {
        [OperationContract(IsOneWay = true)]
        void Clear();
        [OperationContract(IsOneWay = true)]
        void Fibonacchi(int n);

    }
}
