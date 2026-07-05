using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ManageMarks : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadCourses();
        }

        private void LoadCourses()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"SELECT courseID, courseName
                                   FROM Courses
                                   WHERE lecturerID = @lid";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlCourse.DataSource = dt;
                    ddlCourse.DataTextField = "courseName";
                    ddlCourse.DataValueField = "courseID";
                    ddlCourse.DataBind();
                    ddlCourse.Items.Insert(0,
                        new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));
                }
            }
            catch { }
        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCourse.SelectedValue)) return;
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"
                        SELECT
                            s.studentID,
                            u.name AS StudentName,
                            ISNULL(m.score, 0) AS Marks,
                            ISNULL(m.remarks, '') AS Remarks,
                            CASE
                                WHEN ISNULL(m.score,0) >= 80 THEN 'A'
                                WHEN ISNULL(m.score,0) >= 70 THEN 'B'
                                WHEN ISNULL(m.score,0) >= 60 THEN 'C'
                                WHEN ISNULL(m.score,0) >= 50 THEN 'D'
                                ELSE 'F'
                            END AS Grade
                        FROM Enrolments e
                        JOIN Students s ON e.studentID = s.studentID
                        JOIN Users u ON s.userID = u.userID
                        LEFT JOIN Marks m ON s.studentID = m.studentID
                            AND m.courseID = e.courseID
                        WHERE e.courseID = @cid
                        ORDER BY u.name";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@cid", ddlCourse.SelectedValue);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptMarks.DataSource = dt;
                    rptMarks.DataBind();
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Error: " + ex.Message + "');", true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg",
                "alert('Marks saved successfully!');", true);
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "msg",
                "alert('Marks published successfully!');", true);
        }

        public string GetGradeClass(string marks)
        {
            decimal m = 0;
            decimal.TryParse(marks, out m);
            if (m >= 80) return "grade-a";
            if (m >= 70) return "grade-b";
            if (m >= 60) return "grade-c";
            return "grade-f";
        }
    }
}