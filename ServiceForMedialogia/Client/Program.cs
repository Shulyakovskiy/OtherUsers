using System;
using System.ServiceModel;
using System.Threading;
using Client.FibService;

namespace Client
{
    internal class Program
    {
        private static void Main()
        {
            var ic = new InstanceContext(new CallbackHandler());

            using (var fibClient = new FibonacchContractClient(ic))
            {

                Console.Title = "Числа Фибоначчи";

                Console.Write("Инструкция:\n с - для очистки истории:\n q- закрытие сервиса и программы\n Enter -для ввода нового числа\n");
                Console.Write(Environment.NewLine);
                Console.WriteLine("==============================");
                Console.WriteLine("Введите номер числа Фибоначчи!");


                while (true)
                {

                    try
                    {
                        int number = Convert.ToInt32(Console.ReadLine());
                        fibClient.Fibonacchi(number);
                    }
                    catch (Exception exc)
                    {
                        Console.WriteLine(exc.Message);
                        Console.ReadLine();
                        return;
                    }
                    Console.WriteLine();

                    char chKey = Console.ReadKey().KeyChar;

                    switch (chKey)
                    {
                        case 'n':
                            return;

                        case 'c':
                            fibClient.Clear();
                            Console.Write(Environment.NewLine);
                            Console.WriteLine("==============================");
                            Console.WriteLine("Введите номер числа Фибоначчи!");
                            break;
                        case 'q':
                            Console.WriteLine(Environment.NewLine);
                            Console.WriteLine("До свидания");
                            Thread.Sleep(2000);
                            Environment.Exit(0);
                            break;
                        default:
                            Console.Write(Environment.NewLine);
                            Console.WriteLine("==============================");
                            Console.WriteLine("Введите номер числа Фибоначчи!");
                            break;
                    }


                }
            }
        }
    }
}