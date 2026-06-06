using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SIMS.Student
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        // Connection string targeting local SQL instance & your schema database
        private string connString = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Enforcement Layer
            if (Session["role"] == null || Session["role"].ToString() != "Student")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Fallback testing harness if Login session data isn't set up yet
                if (Session["userID"] == null) Session["userID"] = 4;

                LoadStudentAndProfileID();
                LoadStudentProfile();
                LoadEnrolledCourses();
                LoadAvailableCourses();
                LoadAttendanceSummary();
                LoadAcademicMarks();
                LoadAnnouncements();
            }
        }

        // Extracts the explicit profile studentID linked with the master login userID
        private void LoadStudentAndProfileID()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT studentID FROM Students WHERE userID = @userID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userID", Session["userID"]);

                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    Session["studentID"] = result;
                }
            }
        }

        private void LoadStudentProfile()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT u.name, u.email, s.studentID, s.phone, s.address 
                                 FROM Users u JOIN Students s ON u.userID = s.userID WHERE u.userID = @userID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userID", Session["userID"]);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblStudentName.Text = reader["name"].ToString();
                    lblStudentID.Text = reader["studentID"].ToString();
                    lblEmail.Text = reader["email"].ToString();
                    lblPhone.Text = reader["phone"] != DBNull.Value ? reader["phone"].ToString() : "N/A";
                    lblAddress.Text = reader["address"] != DBNull.Value ? reader["address"].ToString() : "N/A";
                }
            }
        }

        private void LoadEnrolledCourses()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT c.courseID, c.courseName, c.description, c.credits 
                                 FROM Enrolments e JOIN Courses c ON e.courseID = c.courseID 
                                 WHERE e.studentID = @studentID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvEnrolledCourses.DataSource = dt;
                gvEnrolledCourses.DataBind();
            }
        }

        private void LoadAvailableCourses()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT courseID, courseName FROM Courses 
                                 WHERE courseID NOT IN (SELECT courseID FROM Enrolments WHERE studentID = @studentID)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                conn.Open();
                ddlAvailableCourses.DataSource = cmd.ExecuteReader();
                ddlAvailableCourses.DataTextField = "courseName";
                ddlAvailableCourses.DataValueField = "courseID";
                ddlAvailableCourses.DataBind();

                if (ddlAvailableCourses.Items.Count == 0)
                {
                    ddlAvailableCourses.Items.Add(new ListItem("No available courses left to register", ""));
                }
            }
        }

        protected void btnRegisterCourse_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlAvailableCourses.SelectedValue)) return;

            int courseID = Convert.ToInt32(ddlAvailableCourses.SelectedValue);
            int studentID = Convert.ToInt32(Session["studentID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Intermediate Requirement: Automated Course Enrolment Validation Check
                string checkQuery = "SELECT COUNT(1) FROM Enrolments WHERE studentID = @studentID AND courseID = @courseID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@studentID", studentID);
                checkCmd.Parameters.AddWithValue("@courseID", courseID);

                conn.Open();
                int existingCount = (int)checkCmd.ExecuteScalar();

                if (existingCount > 0)
                {
                    ShowAlert("You are already enrolled in this course.", "red");
                    return;
                }

                string insertQuery = "INSERT INTO Enrolments (studentID, courseID, enrolDate) VALUES (@studentID, @courseID, GETDATE())";
                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@studentID", studentID);
                insertCmd.Parameters.AddWithValue("@courseID", courseID);

                insertCmd.ExecuteNonQuery();
                ShowAlert("Enrolled in course successfully!", "green");

                // Refresh UI Panels
                LoadEnrolledCourses();
                LoadAvailableCourses();
                LoadAttendanceSummary();
                LoadAcademicMarks();
            }
        }

        protected void gvEnrolledCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DropCourse")
            {
                int courseID = Convert.ToInt32(e.CommandArgument);
                int studentID = Convert.ToInt32(Session["studentID"]);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string deleteQuery = "DELETE FROM Enrolments WHERE studentID = @studentID AND courseID = @courseID";
                    SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    cmd.Parameters.AddWithValue("@courseID", courseID);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    ShowAlert("Course dropped successfully.", "orange");

                    LoadEnrolledCourses();
                    LoadAvailableCourses();
                    LoadAttendanceSummary();
                    LoadAcademicMarks();
                }
            }
        }

        private void LoadAttendanceSummary()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Intermediate Requirement: Automated Attendance Percentage Calculation Engine
                string query = @"SELECT c.courseName,
                                 COUNT(a.attendanceID) as TotalClasses,
                                 SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) as PresentDays,
                                 CASE WHEN COUNT(a.attendanceID) > 0 
                                      THEN (CAST(SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(a.attendanceID)) * 100 
                                      ELSE 100.0 END as AttendancePercentage
                                 FROM Enrolments e
                                 JOIN Courses c ON e.courseID = c.courseID
                                 LEFT JOIN Attendance a ON e.studentID = a.studentID AND e.courseID = a.courseID
                                 WHERE e.studentID = @studentID
                                 GROUP BY c.courseName, c.courseID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAttendance.DataSource = dt;
                gvAttendance.DataBind();
            }
        }

        private void LoadAcademicMarks()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT c.courseName, m.score, m.remarks 
                                 FROM Marks m JOIN Courses c ON m.courseID = c.courseID 
                                 WHERE m.studentID = @studentID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMarks.DataSource = dt;
                gvMarks.DataBind();
            }
        }

        private void LoadAnnouncements()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT TOP 3 title, message, datePosted FROM Announcements ORDER BY datePosted DESC";
                SqlCommand cmd = new SqlCommand(query, conn);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptAnnouncements.DataSource = dt;
                rptAnnouncements.DataBind();
            }
        }

        private void ShowAlert(string text, string colorTheme)
        {
            lblStatusMessage.Visible = true;
            lblStatusMessage.Text = text;
            if (colorTheme == "green") { lblStatusMessage.Style["background-color"] = "#d4edda"; lblStatusMessage.Style["color"] = "#155724"; }
            else if (colorTheme == "orange") { lblStatusMessage.Style["background-color"] = "#fff3cd"; lblStatusMessage.Style["color"] = "#856404"; }
            else { lblStatusMessage.Style["background-color"] = "#f8d7da"; lblStatusMessage.Style["color"] = "#721c24"; }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}