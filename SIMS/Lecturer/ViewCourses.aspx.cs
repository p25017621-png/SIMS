
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        private void LoadStudents()
        {
            // Real DB:
            // string lecturerID = Session["LecturerID"]?.ToString();
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = @"SELECT s.StudentID, s.Name,
            //                    c.CourseName AS Course, s.Program,
            //                    CASE WHEN s.IsActive=1 THEN 'Active' ELSE 'Inactive' END AS Status,
            //                    CASE WHEN s.IsActive=1 THEN 'badge-active' ELSE 'badge-inactive' END AS StatusClass
            //                    FROM Enrollments e
            //                    JOIN Students s ON e.StudentID = s.StudentID
            //                    JOIN Courses  c ON e.CourseID  = c.CourseID
            //                    WHERE c.LecturerID = @lid
            //                    ORDER BY c.CourseName, s.Name";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@lid", lecturerID);
            //     SqlDataAdapter da = new SqlDataAdapter(cmd);
            //     DataTable dt = new DataTable();
            //     da.Fill(dt);
            //     rptStudents.DataSource = dt;
            //     rptStudents.DataBind();
            // }
        }
    }
}
