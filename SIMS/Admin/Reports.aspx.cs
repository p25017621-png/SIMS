using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SIMS.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        string connStr =
        ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnStudentReport_Click(object sender, EventArgs e)
        {
            lblReportTitle.Text = "Student Report";
            LoadReport("SELECT * FROM Students");
        
        }

        protected void btnLecturerReport_Click(object sender, EventArgs e)
        {
            lblReportTitle.Text = "Lecturer Report";
            LoadReport("SELECT * FROM Lecturers");
        
        }

        protected void btnCourseReport_Click(object sender, EventArgs e)
        {
            lblReportTitle.Text = "Course Report";
            LoadReport("SELECT * FROM Courses");
        
        }

        protected void btnProgrammeReport_Click(object sender, EventArgs e)
        {
            lblReportTitle.Text = "Programme Report";
            LoadReport("SELECT * FROM Programmes");
        }

        protected void btnAssignmentReport_Click(object sender, EventArgs e)
        {
            lblReportTitle.Text = "Assignment Report";

            LoadReport(@"
    SELECT
        U.name AS Lecturer,
        C.courseName AS Course,
        A.semester AS Semester
    FROM LecturerCourseAssignments A
    INNER JOIN Lecturers L
        ON A.lecturerID = L.lecturerID
    INNER JOIN Users U
        ON L.userID = U.userID
    INNER JOIN Courses C
        ON A.courseID = C.courseID
    ");
        }
        private void LoadReport(string query)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter da =
                new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvReport.DataSource = dt;
                gvReport.DataBind();
            }
        }
    }
}