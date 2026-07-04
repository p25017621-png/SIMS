using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Session Protection
            if (Session["role"] == null || Session["role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadDashboardCounts();
            }
        }

        private void LoadDashboardCounts()
        {
            string connStr =
                ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmdStudents =
                    new SqlCommand("SELECT COUNT(*) FROM Students", conn);

                lblStudents.Text =
                    cmdStudents.ExecuteScalar().ToString();

                SqlCommand cmdLecturers =
                    new SqlCommand("SELECT COUNT(*) FROM Lecturers", conn);

                lblLecturers.Text =
                    cmdLecturers.ExecuteScalar().ToString();

                SqlCommand cmdCourses =
                    new SqlCommand("SELECT COUNT(*) FROM Courses", conn);

                lblCourses.Text =
                    cmdCourses.ExecuteScalar().ToString();

                SqlCommand cmdProgrammes =
                    new SqlCommand("SELECT COUNT(*) FROM Programmes", conn);

                lblProgrammes.Text =
                    cmdProgrammes.ExecuteScalar().ToString();
            }
        }

        protected void Calendar1_DayRender(
            object sender,
            DayRenderEventArgs e)
        {
            DateTime date = e.Day.Date;

            // Semester Registration
            if (date == new DateTime(2026, 6, 14))
            {
                e.Cell.BackColor = Color.FromArgb(99, 102, 241);
                e.Cell.ForeColor = Color.White;
                e.Cell.ToolTip = "Semester Registration";
            }

            // Midterm Exam
            if (date == new DateTime(2026, 7, 15))
            {
                e.Cell.BackColor = Color.Orange;
                e.Cell.ForeColor = Color.White;
                e.Cell.ToolTip = "Midterm Examination";
            }

            // Project Submission
            if (date == new DateTime(2026, 8, 20))
            {
                e.Cell.BackColor = Color.MediumPurple;
                e.Cell.ForeColor = Color.White;
                e.Cell.ToolTip = "Project Submission";
            }

            // Final Exam
            if (date == new DateTime(2026, 9, 10))
            {
                e.Cell.BackColor = Color.Red;
                e.Cell.ForeColor = Color.White;
                e.Cell.ToolTip = "Final Examination";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Login.aspx");
        }
    }
}
