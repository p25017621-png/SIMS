using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ViewCourses : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
                LoadStudents();
            }
        }

        private void LoadCourses()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"
                        SELECT
                            c.courseCode,
                            c.courseName,
                            c.credits AS CreditHours,
                            'Semester 1' AS Semester,
                            COUNT(e.studentID) AS StudentCount
                        FROM Courses c
                        LEFT JOIN Enrolments e ON c.courseID = e.courseID
                        WHERE c.lecturerID = @lid
                        GROUP BY c.courseID, c.courseCode,
                                 c.courseName, c.credits";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptCourses.DataSource = dt;
                    rptCourses.DataBind();
                }
            }
            catch { }
        }

        private void LoadStudents()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"
                        SELECT
                            u.name AS Name,
                            c.courseName AS Course,
                            'CS' AS Program,
                            'Active' AS Status,
                            'badge-active' AS StatusClass
                        FROM Enrolments e
                        JOIN Students s ON e.studentID = s.studentID
                        JOIN Users u ON s.userID = u.userID
                        JOIN Courses c ON e.courseID = c.courseID
                        WHERE c.lecturerID = @lid
                        ORDER BY c.courseName, u.name";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptStudents.DataSource = dt;
                    rptStudents.DataBind();
                }
            }
            catch { }
        }
    }
}