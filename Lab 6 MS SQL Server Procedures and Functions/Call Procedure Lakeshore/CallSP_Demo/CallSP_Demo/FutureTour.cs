using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CallSP_Demo
{
    public class FutureTour
    {
        public int TourId { get; set; }
        public String Name { get; set; }
        public decimal Price { get; set; }
        public bool MealIncluded { get; set; }
        public DateTime TourStart { get; set; }
        public DateTime TourEnd { get; set; }
        public double AverageRating { get; set; }
    }
}
