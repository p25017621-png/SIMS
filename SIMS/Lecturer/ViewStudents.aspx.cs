
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ViewStudents : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudentProgress();
            }
        }

        private void LoadStudentProgress()
        {
            // Real DB:
            // string lecturerID = Session["LecturerID"]?.ToString();
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = @"
            //         SELECT
            //             s.StudentID,
            //             s.Name,
            //             c.CourseName AS Course,
            //             CAST(SUM(CASE WHEN a.Status='P' OR a.Status='L' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.AttendanceID) AS INT) AS AttendancePct,
            //             CAST(AVG(CAST(m.Marks AS FLOAT)) AS INT) AS AvgMarks,
            //             CASE
            //                 WHEN AVG(CAST(m.Marks AS FLOAT)) >= 70
            //                  AND SUM(CASE WHEN a.Status='P' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.AttendanceID) >= 75
            //                 THEN 'Good'
            //                 WHEN AVG(CAST(m.Marks AS FLOAT)) >= 50
            //                 THEN 'Average'
            //                 ELSE 'Poor'
            //             END AS ProgressStatus
            //         FROM Students s
            //         JOIN Enrollments e  ON s.StudentID = e.StudentID
            //         JOIN Courses c      ON e.CourseID  = c.CourseID
            //         LEFT JOIN Attendance a ON s.StudentID = a.StudentID AND a.CourseID = c.CourseID
            //         LEFT JOIN Marks m      ON s.StudentID = m.StudentID AND m.CourseID = c.CourseID
            //         WHERE c.LecturerID = @lid
            //         GROUP BY s.StudentID, s.Name, c.CourseName
            //         ORDER BY ProgressStatus DESC";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@lid", lecturerID);
            //     SqlDataAdapter da = new SqlDataAdapter(cmd);
            //     DataTable dt = new DataTable();
            //     da.Fill(dt);
            //     // Bind dt to your GridView/Repeater
            // }
        }
    }
}
