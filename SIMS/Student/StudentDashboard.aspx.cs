using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace SIMS.Student
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudentStatistics();
                LoadStudentSummary();
            }
        }

        private void LoadStudentStatistics()
        {
            string cs =
                ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                string query = @"
                 SELECT
                 COUNT(*) AS TotalEnrolments,
                 COUNT(DISTINCT semester) AS TotalSemesters
                 FROM Enrolments";

                SqlCommand cmd =
                    new SqlCommand(query, conn);

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblEnrolments.Text =
                        dr["TotalEnrolments"].ToString();

                    lblSemester.Text =
                        dr["TotalSemesters"].ToString();
                }

                dr.Close();

                SqlCommand programmeCmd =
                new SqlCommand(
                "SELECT COUNT(DISTINCT programmeID) FROM Enrolments",
                 conn);

                lblProgramme.Text =
                programmeCmd.ExecuteScalar().ToString();
            }
        }

        private void LoadStudentSummary()
        {
            string cs =
                ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"
                SELECT
                    s.studentID,
                    u.name,
                    p.programmeName,
                    e.semester
                FROM Students s
                INNER JOIN Users u
                    ON s.userID = u.userID
                INNER JOIN Enrolments e
                    ON s.studentID = e.studentID
                INNER JOIN Programmes p
                    ON e.programmeID = p.programmeID";

                SqlDataAdapter da =
                    new SqlDataAdapter(query, conn);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                gvStudentSummary.DataSource = dt;
                gvStudentSummary.DataBind();
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