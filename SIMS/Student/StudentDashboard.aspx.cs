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
        private readonly string connString = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

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
                if (Session["studentID"] == null) Session["studentID"] = 1; // Add this line!

                LoadStudentAndProfileID();
                LoadStudentProfile();
                RefreshDashboardLayout();
            }
        }

        // Consolidated workflow routine to prevent state tracking mismatch across components
        private void RefreshDashboardLayout()
        {
            LoadEnrolledCourses();
            LoadAvailableCourses();
            LoadAttendanceSummary();
            LoadAcademicMarksAndCalculateMetrics(); // Runs dual binding & safe metric evaluations
            LoadAnnouncements();
        }

        private void LoadStudentAndProfileID()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT studentID FROM Students WHERE userID = @userID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", Session["userID"]);

                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        Session["studentID"] = result;
                    }
                }
            }
        }

        private void LoadStudentProfile()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Safely pulls the latest enrollment track/term via subqueries to prevent duplicate row aggregation issues
                string query = @"
                    SELECT u.name, u.email, s.studentID, s.phone, s.address,
                           (SELECT TOP 1 e.semester FROM Enrolments e WHERE e.studentID = s.studentID ORDER BY e.enrolDate DESC) as semester,
                           (SELECT TOP 1 p.programmeName FROM Enrolments e 
                            INNER JOIN Programmes p ON e.programmeID = p.programmeID 
                            WHERE e.studentID = s.studentID ORDER BY e.enrolDate DESC) as programmeName
                    FROM Users u 
                    JOIN Students s ON u.userID = s.userID 
                    WHERE u.userID = @userID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", Session["userID"]);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblStudentName.Text = reader["name"].ToString();
                            lblStudentID.Text = reader["studentID"].ToString();
                            lblEmail.Text = reader["email"].ToString();
                            lblPhone.Text = reader["phone"] != DBNull.Value ? reader["phone"].ToString() : "N/A";
                            lblAddress.Text = reader["address"] != DBNull.Value ? reader["address"].ToString() : "N/A";

                            string trackName = reader["programmeName"] != DBNull.Value ? reader["programmeName"].ToString() : "";
                            string semValue = reader["semester"] != DBNull.Value ? reader["semester"].ToString() : "";

                            lblTrack.Text = !string.IsNullOrEmpty(trackName) ? trackName : "General Track";
                            lblTerm.Text = !string.IsNullOrEmpty(semValue) ? "Semester " + semValue : "Semester 1";
                        }
                    }
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

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvEnrolledCourses.DataSource = dt;
                        gvEnrolledCourses.DataBind();

                        litCourseCount.Text = dt.Rows.Count.ToString();
                    }
                }
            }
        }

        private void LoadAvailableCourses()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT courseID, courseName FROM Courses 
                                 WHERE courseID NOT IN (SELECT courseID FROM Enrolments WHERE studentID = @studentID)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                    conn.Open();
                    DataTable dt = new DataTable();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }

                    ddlAvailableCourses.DataSource = dt;
                    ddlAvailableCourses.DataTextField = "courseName";
                    ddlAvailableCourses.DataValueField = "courseID";
                    ddlAvailableCourses.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        ddlAvailableCourses.Items.Add(new ListItem("No available courses left to register", ""));
                        btnRegisterCourse.Enabled = false;
                        btnRegisterCourse.Style["background-color"] = "#cbd5e1";
                        btnRegisterCourse.Style["cursor"] = "not-allowed";
                    }
                    else
                    {
                        btnRegisterCourse.Enabled = true;
                        btnRegisterCourse.Style["background-color"] = "#3498db";
                        btnRegisterCourse.Style["cursor"] = "pointer";
                    }
                }
            }
        }

        protected void btnRegisterCourse_Click(object sender, EventArgs e)
        {
            // 1. Validasi pilihan course dan semester
            if (string.IsNullOrEmpty(ddlAvailableCourses.SelectedValue)) return;

            if (string.IsNullOrEmpty(ddlSemester.SelectedValue))
            {
                ShowAlert("Please select a semester before registering.", "red");
                return;
            }

            int courseID = Convert.ToInt32(ddlAvailableCourses.SelectedValue);
            int studentID = Convert.ToInt32(Session["studentID"]);
            string selectedSemester = ddlSemester.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // 2. Semakan keselamatan: Elakkan duplicate enrolment untuk subjek yang sama pada semester yang sama
                string checkQuery = "SELECT COUNT(1) FROM Enrolments WHERE studentID = @studentID AND courseID = @courseID AND semester = @semester";

                conn.Open();
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@studentID", studentID);
                    checkCmd.Parameters.AddWithValue("@courseID", courseID);
                    checkCmd.Parameters.AddWithValue("@semester", selectedSemester);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        ShowAlert("You are already enrolled in this course for this semester.", "red");
                        return;
                    }
                }

                // 3. Insert data baru berserta nilai semester terkini
                string insertQuery = "INSERT INTO Enrolments (studentID, courseID, semester, enrolDate) VALUES (@studentID, @courseID, @semester, GETDATE())";
                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@studentID", studentID);
                    insertCmd.Parameters.AddWithValue("@courseID", courseID);
                    insertCmd.Parameters.AddWithValue("@semester", selectedSemester);

                    insertCmd.ExecuteNonQuery();
                }

                ShowAlert("Enrolled in course successfully!", "green");

                // Reset dropdown semester ke default
                ddlSemester.SelectedIndex = 0;

                RefreshDashboardLayout();
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
                    using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@studentID", studentID);
                        cmd.Parameters.AddWithValue("@courseID", courseID);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    ShowAlert("Course dropped successfully.", "orange");
                    RefreshDashboardLayout();
                }
            }
        }

        private void LoadAttendanceSummary()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
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

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvAttendance.DataSource = dt;
                        gvAttendance.DataBind();

                        if (dt.Rows.Count > 0)
                        {
                            double cumulativeAttendancePercent = 0;
                            foreach (DataRow row in dt.Rows)
                            {
                                cumulativeAttendancePercent += Convert.ToDouble(row["AttendancePercentage"]);
                            }
                            double averageAttendanceOverall = cumulativeAttendancePercent / dt.Rows.Count;
                            litAttendanceRate.Text = averageAttendanceOverall.ToString("F0") + "%";
                        }
                        else
                        {
                            litAttendanceRate.Text = "100%";
                        }
                    }
                }
            }
        }

        private void LoadAcademicMarksAndCalculateMetrics()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT c.courseName, c.credits, m.score, m.remarks 
                                 FROM Marks m JOIN Courses c ON m.courseID = c.courseID 
                                 WHERE m.studentID = @studentID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", Session["studentID"]);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvMarks.DataSource = dt;
                        gvMarks.DataBind();

                        decimal aggregatedWeightedPoints = 0;
                        int consolidatedCreditDenominator = 0;

                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["score"] != DBNull.Value)
                            {
                                double rawScore = Convert.ToDouble(row["score"]);
                                int courseCredits = row["credits"] != DBNull.Value ? Convert.ToInt32(row["credits"]) : 3;
                                decimal stepScaleGradePoint = 0.00m;

                                if (rawScore >= 80) stepScaleGradePoint = 4.00m;
                                else if (rawScore >= 75) stepScaleGradePoint = 3.67m;
                                else if (rawScore >= 70) stepScaleGradePoint = 3.33m;
                                else if (rawScore >= 65) stepScaleGradePoint = 3.00m;
                                else if (rawScore >= 60) stepScaleGradePoint = 2.67m;
                                else if (rawScore >= 55) stepScaleGradePoint = 2.33m;
                                else if (rawScore >= 50) stepScaleGradePoint = 2.00m;
                                else stepScaleGradePoint = 0.00m;

                                aggregatedWeightedPoints += (stepScaleGradePoint * courseCredits);
                                consolidatedCreditDenominator += courseCredits;
                            }
                        }

                        decimal dynamicCalculatedCGPA = consolidatedCreditDenominator > 0
                            ? (aggregatedWeightedPoints / consolidatedCreditDenominator)
                            : 0.00m;

                        litCGPA.Text = dynamicCalculatedCGPA.ToString("0.00");
                    }
                }
            }
        }

        protected void gvMarks_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblBadge = (Label)e.Row.FindControl("lblRemarksBadge");
                if (lblBadge != null)
                {
                    string remarkText = lblBadge.Text.Trim().ToUpper();

                    lblBadge.Style["display"] = "inline-block";
                    lblBadge.Style["padding"] = "6px 12px";
                    lblBadge.Style["border-radius"] = "9999px";
                    lblBadge.Style["font-size"] = "11px";
                    lblBadge.Style["font-weight"] = "700";
                    lblBadge.Style["text-transform"] = "uppercase";
                    lblBadge.Style["letter-spacing"] = "0.05em";
                    lblBadge.Style["text-align"] = "center";

                    if (remarkText == "FAIL" || remarkText == "RETAKE")
                    {
                        lblBadge.Style["background-color"] = "#fee2e2";
                        lblBadge.Style["color"] = "#991b1b";
                    }
                    else if (remarkText == "PASS" || remarkText == "GOOD")
                    {
                        lblBadge.Style["background-color"] = "#dcfce7";
                        lblBadge.Style["color"] = "#166534";
                    }
                    else
                    {
                        lblBadge.Style["background-color"] = "#f3e8ff";
                        lblBadge.Style["color"] = "#6b21a8";
                    }
                }
            }
        }

        private void LoadAnnouncements()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT TOP 3 title, message, datePosted FROM Announcements ORDER BY datePosted DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptAnnouncements.DataSource = dt;
                        rptAnnouncements.DataBind();
                    }
                }
            }
        }

        private void ShowAlert(string text, string colorTheme)
        {
            lblStatusMessage.Visible = true;
            lblStatusMessage.Text = text;
            if (colorTheme == "green")
            {
                lblStatusMessage.Style["background-color"] = "#d4edda";
                lblStatusMessage.Style["color"] = "#155724";
            }
            else if (colorTheme == "orange")
            {
                lblStatusMessage.Style["background-color"] = "#fff3cd";
                lblStatusMessage.Style["color"] = "#856404";
            }
            else
            {
                lblStatusMessage.Style["background-color"] = "#f8d7da";
                lblStatusMessage.Style["color"] = "#721c24";
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