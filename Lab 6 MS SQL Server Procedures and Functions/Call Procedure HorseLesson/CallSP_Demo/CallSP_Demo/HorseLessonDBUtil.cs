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
    public class HorseLessonDBUtil
    {
        DatabaseProviderFactory factory;
        SqlDatabase sqlDB;

        public HorseLessonDBUtil()
        {
            factory = new DatabaseProviderFactory();
            sqlDB = (SqlDatabase)factory.CreateDefault();
        }

        public IEnumerable<LessonInfo> GetLessonInfo(int lessonId)
        {
            List<LessonInfo> lessonInfo = new List<LessonInfo>();

            using (DbCommand sprocCmd = sqlDB.GetStoredProcCommand("LessonInfo"))
            {
                sqlDB.AddInParameter(sprocCmd, "@LessonID", DbType.Int32, lessonId);

                using (IDataReader sprocReader = sqlDB.ExecuteReader(sprocCmd))
                {
                    while (sprocReader.Read())
                    {
                        LessonInfo nextLessonInfo = new LessonInfo();
                        try
                        {
                            nextLessonInfo.LessonID = sprocReader.GetInt32(0);
                            nextLessonInfo.Name = sprocReader.GetString(1);
                            nextLessonInfo.StartTime = sprocReader.GetDateTime(2);
                            nextLessonInfo.NumStudentsLesson = sprocReader.GetInt32(3);

                            lessonInfo.Add(nextLessonInfo);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Exception " + ex.Message);
                        }
                    }
                }
            }
            return lessonInfo;
        }  

    }
}
