using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class EnrolmentManagement : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
                LoadProgrammes();
                LoadEnrolments();

                // Disable course dropdown initially
                ddlCourse.Enabled = false;
            }
        }

        private void LoadStudents()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"SELECT s.studentID, u.name 
                                 FROM Students s
                                 JOIN Users u ON s.userID = u.userID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlStudent.DataSource = dt;
                ddlStudent.DataTextField = "name";
                ddlStudent.DataValueField = "studentID";
                ddlStudent.DataBind();
            }
        }

        private void LoadProgrammes()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT programmeID, programmeName FROM Programmes";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlProgramme.DataSource = dt;
                ddlProgramme.DataTextField = "programmeName";
                ddlProgramme.DataValueField = "programmeID";
                ddlProgramme.DataBind();
            }
        }

        private void LoadCoursesByProgramme(int programmeID)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT courseID, courseName FROM Courses WHERE programmeID=@pid";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@pid", programmeID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCourse.Items.Clear();
                ddlCourse.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));

                ddlCourse.DataSource = dt;
                ddlCourse.DataTextField = "courseName";
                ddlCourse.DataValueField = "courseID";
                ddlCourse.DataBind();

                ddlCourse.Enabled = true;
            }
        }

        protected void ddlProgramme_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProgramme.SelectedValue != "")
            {
                LoadCoursesByProgramme(Convert.ToInt32(ddlProgramme.SelectedValue));
            }
            else
            {
                ddlCourse.Items.Clear();
                ddlCourse.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));
                ddlCourse.Enabled = false;
            }
        }

        private void LoadEnrolments()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"SELECT e.enrolmentID, u.name AS studentName, 
                                        p.programmeName, c.courseName, e.semester, e.enrolDate
                                 FROM Enrolments e
                                 JOIN Students s ON e.studentID = s.studentID
                                 JOIN Users u ON s.userID = u.userID
                                 JOIN Courses c ON e.courseID = c.courseID
                                 JOIN Programmes p ON e.programmeID = p.programmeID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvEnrolment.DataSource = dt;
                gvEnrolment.DataBind();
            }
        }

        protected void btnEnrol_Click(object sender, EventArgs e)
        {
            if (ddlStudent.SelectedValue == "" || ddlProgramme.SelectedValue == "" ||
                ddlCourse.SelectedValue == "" || ddlSemester.SelectedValue == "")
            {
                lblMessage.Text = "Please select all fields!";
                return;
            }

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                string query = @"INSERT INTO Enrolments(studentID, courseID, programmeID, semester)
                                 VALUES(@sid,@cid,@pid,@sem)";

                string checkQuery = @"SELECT COUNT(*)
                      FROM Enrolments
                      WHERE studentID=@sid
                      AND courseID=@cid
                      AND semester=@sem";

                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);

                checkCmd.Parameters.AddWithValue("@sid", ddlStudent.SelectedValue);
                checkCmd.Parameters.AddWithValue("@cid", ddlCourse.SelectedValue);
                checkCmd.Parameters.AddWithValue("@sem", ddlSemester.SelectedValue);

                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    lblMessage.Text = "Student already enrolled!";
                    return;
                }

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@sid", ddlStudent.SelectedValue);
                cmd.Parameters.AddWithValue("@cid", ddlCourse.SelectedValue);
                cmd.Parameters.AddWithValue("@pid", ddlProgramme.SelectedValue);
                cmd.Parameters.AddWithValue("@sem", ddlSemester.SelectedValue);

                cmd.ExecuteNonQuery();

                lblMessage.Text = "Enrolment successful!";
                LoadEnrolments();
            }
        }

        protected void gvEnrolment_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvEnrolment.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                string query = "DELETE FROM Enrolments WHERE enrolmentID=@id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();

                LoadEnrolments();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStudent.SelectedIndex = 0;
            ddlProgramme.SelectedIndex = 0;
            ddlCourse.Items.Clear();
            ddlCourse.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));
            ddlCourse.Enabled = false;
            ddlSemester.SelectedIndex = 0;
            lblMessage.Text = "";
        }
    }
}