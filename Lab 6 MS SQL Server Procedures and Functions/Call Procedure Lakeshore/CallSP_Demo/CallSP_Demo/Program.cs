using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CallSP_Demo
{
    class Program
    {
        static void Main(string[] args)
        {
            LakeShoreDBUtil lakeShoreDBUtil = new LakeShoreDBUtil();
            IEnumerable<FutureTour> futureTours = lakeShoreDBUtil.GetFutureTours(DateTime.Now);  //.AddMonths(2)

            foreach (FutureTour fTour in futureTours)
            {
                Console.WriteLine("Tour Name: {0} rating: {1} departs {2}", fTour.Name,
                    fTour.AverageRating, fTour.TourStart);
            }
            Console.ReadLine();
        }
    }
}
