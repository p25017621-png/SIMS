using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    string sql = @"SELECT c.courseID, c.courseName
                                   FROM Courses c
                                   JOIN LecturerCourseAssignments lca ON c.courseID = lca.courseID
                                   WHERE lca.lecturerID = @lid";
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
            LoadMarks();
        }

        private void LoadMarks()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"
                        SELECT
                            s.studentID AS StudentID,
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
            catch { }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCourse.SelectedValue))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Please select a course first!');", true);
                return;
            }
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    foreach (RepeaterItem item in rptMarks.Items)
                    {
                        if (item.ItemType == ListItemType.Item ||
                            item.ItemType == ListItemType.AlternatingItem)
                        {
                            HiddenField hfStudentID = (HiddenField)item.FindControl("hfStudentID");
                            TextBox txtScore = (TextBox)item.FindControl("txtScore");
                            TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");

                            int studentID = Convert.ToInt32(hfStudentID.Value);
                            decimal score = 0;
                            decimal.TryParse(txtScore.Text, out score);
                            string remarks = txtRemarks.Text.Trim();

                            string sql = @"
                                IF EXISTS (SELECT 1 FROM Marks
                                           WHERE studentID=@sid AND courseID=@cid)
                                    UPDATE Marks SET score=@score, remarks=@remarks
                                    WHERE studentID=@sid AND courseID=@cid
                                ELSE
                                    INSERT INTO Marks (studentID,courseID,score,remarks)
                                    VALUES (@sid,@cid,@score,@remarks)";
                            SqlCommand cmd = new SqlCommand(sql, con);
                            cmd.Parameters.AddWithValue("@sid", studentID);
                            cmd.Parameters.AddWithValue("@cid", ddlCourse.SelectedValue);
                            cmd.Parameters.AddWithValue("@score", score);
                            cmd.Parameters.AddWithValue("@remarks", remarks);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                LoadMarks();
                ClientScript.RegisterStartupScript(this.GetType(), "msg",
                    "alert('Marks saved successfully!');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Error: " + ex.Message + "');", true);
            }
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            btnSave_Click(sender, e);
            ClientScript.RegisterStartupScript(this.GetType(), "pub",
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