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
            HorseLessonDBUtil HorseLessonDBUtil = new HorseLessonDBUtil();

            Console.WriteLine("Please enter the lesson ID of the lesson you would like to see: ");
            IEnumerable<LessonInfo> lessonInfo = HorseLessonDBUtil.GetLessonInfo(Convert.ToInt32(Console.ReadLine())); 

            foreach (LessonInfo lInfo in lessonInfo)
            {
                Console.WriteLine("Lesson ID: {0} Lesson Name: {1} Start Time: {2} Number of Students: {3}"
                    , lInfo.LessonID, lInfo.Name, lInfo.StartTime, lInfo.NumStudentsLesson);
            }
            Console.ReadLine();
        }
    }
}
