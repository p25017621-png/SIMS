using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDashboardStats();
                BindAnnouncements();
            }
        }

        private void BindDashboardStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT COUNT(*) FROM Students;
                    SELECT COUNT(*) FROM Lecturers;
                    SELECT COUNT(*) FROM Courses;
                    SELECT COUNT(*) FROM Programmes;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read()) lblStudents.Text = reader[0].ToString();
                            if (reader.NextResult() && reader.Read()) lblLecturers.Text = reader[0].ToString();
                            if (reader.NextResult() && reader.Read()) lblCourses.Text = reader[0].ToString();
                            if (reader.NextResult() && reader.Read()) lblProgrammes.Text = reader[0].ToString();
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = "⚠️ Error loading metrics: " + ex.Message;
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        // ==========================================
        // ANNOUNCEMENTS LOGIC (UPDATED WITH CASE WHEN)
        // ==========================================
        private void BindAnnouncements()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT announcementID, title, message, datePosted, lecturerID,
                                 CASE 
                                     WHEN lecturerID IS NULL THEN 'Admin' 
                                     ELSE 'Lecturer' 
                                 END AS PostedBy
                                 FROM Announcements 
                                 ORDER BY datePosted DESC";

                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAnnouncements.DataSource = dt;
                    gvAnnouncements.DataBind();
                }
            }
        }

        protected void btnPostAnnouncement_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNewTitle.Text) || string.IsNullOrWhiteSpace(txtNewMessage.Text))
            {
                lblMsg.Text = "⚠️ Please fill in both fields!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Admins leave lecturerID as NULL automatically
                string query = "INSERT INTO Announcements (title, message, datePosted) VALUES (@title, @message, @date)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@title", txtNewTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@message", txtNewMessage.Text.Trim());
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            txtNewTitle.Text = "";
            txtNewMessage.Text = "";

            lblMsg.Text = "🚀 Announcement posted successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;

            BindAnnouncements();
        }

        protected void gvAnnouncements_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAnnouncements.EditIndex = e.NewEditIndex;
            BindAnnouncements();
        }

        protected void gvAnnouncements_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAnnouncements.EditIndex = -1;
            BindAnnouncements();
        }

        protected void gvAnnouncements_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int annID = Convert.ToInt32(gvAnnouncements.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvAnnouncements.Rows[e.RowIndex];

            TextBox txtTitle = (TextBox)row.FindControl("txtTitle");
            TextBox txtMessage = (TextBox)row.FindControl("txtMessage");

            if (txtTitle != null && txtMessage != null)
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "UPDATE Announcements SET title = @title, message = @message WHERE announcementID = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@message", txtMessage.Text.Trim());
                        cmd.Parameters.AddWithValue("@id", annID);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                lblMsg.Text = "✅ Updated successfully!";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                gvAnnouncements.EditIndex = -1;
                BindAnnouncements();
            }
        }

        protected void gvAnnouncements_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int annID = Convert.ToInt32(gvAnnouncements.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Announcements WHERE announcementID = @id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", annID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            lblMsg.Text = "🗑️ Announcement removed!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            BindAnnouncements();
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            // Keeps front-end rendering cleanly
        }
    }
}