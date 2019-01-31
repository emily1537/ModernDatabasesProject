using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Data;
using System.Data.Common;

namespace CallSP_Demo
{
    public class LakeShoreDBUtil
    {
        DatabaseProviderFactory factory;
        SqlDatabase sqlDB;

        public LakeShoreDBUtil()
        {
            factory = new DatabaseProviderFactory();
            sqlDB = (SqlDatabase)factory.CreateDefault();
        }

        public IEnumerable<FutureTour> GetFutureTours(DateTime dateLimit)
        {
            List<FutureTour> futureTours = new List<FutureTour>();

            using (DbCommand sprocCmd = sqlDB.GetStoredProcCommand("FutureTours"))
            {
                if (dateLimit > DateTime.Now)
                    sqlDB.AddInParameter(sprocCmd, "@FutureDate", DbType.DateTime, dateLimit);
                else
                    sqlDB.AddInParameter(sprocCmd, "@FutureDate", DbType.DateTime, DBNull.Value);

                using (IDataReader sprocReader = sqlDB.ExecuteReader(sprocCmd))
                {
                    while (sprocReader.Read())
                    {
                        FutureTour nextFutureTour = new FutureTour();
                        try
                        {
                            nextFutureTour.TourId = sprocReader.GetInt32(0);
                            nextFutureTour.Name = sprocReader.GetString(1);
                            nextFutureTour.Price = sprocReader.GetDecimal(2);
                            nextFutureTour.MealIncluded = sprocReader.GetBoolean(3);
                            nextFutureTour.TourStart = sprocReader.GetDateTime(4);
                            nextFutureTour.TourEnd = sprocReader.GetDateTime(5);
                            nextFutureTour.AverageRating = sprocReader.GetDouble(6);

                            futureTours.Add(nextFutureTour);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Exception " + ex.Message);
                        }
                    }
                }
            }
            return futureTours;
        }  // end GetFutureTours

    }
}
