
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class Announcements : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAnnouncements();
            }
        }

        // Load existing announcements
        private void LoadAnnouncements()
        {
            // Real DB:
            // string lecturerID = Session["LecturerID"]?.ToString();
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = @"SELECT AnnouncementID, Title, Message, Target, Type,
            //                    PostedDate FROM Announcements
            //                    WHERE LecturerID = @lid
            //                    ORDER BY PostedDate DESC";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@lid", lecturerID);
            //     SqlDataAdapter da = new SqlDataAdapter(cmd);
            //     DataTable dt = new DataTable();
            //     da.Fill(dt);
            //     // Bind to Repeater
            // }
        }

        // Post new announcement
        protected void btnPost_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTitle.Text) ||
                string.IsNullOrWhiteSpace(txtMessage.Text))
            {
                lblMessage.Text = "⚠️ Please fill in title and message.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                // Real DB:
                // using (SqlConnection con = new SqlConnection(connStr))
                // {
                //     con.Open();
                //     string sql = @"INSERT INTO Announcements
                //                    (LecturerID, Title, Message, Target, Type, PostedDate)
                //                    VALUES (@lid, @title, @msg, @target, @type, GETDATE())";
                //     SqlCommand cmd = new SqlCommand(sql, con);
                //     cmd.Parameters.AddWithValue("@lid",    Session["LecturerID"]);
                //     cmd.Parameters.AddWithValue("@title",  txtTitle.Text.Trim());
                //     cmd.Parameters.AddWithValue("@msg",    txtMessage.Text.Trim());
                //     cmd.Parameters.AddWithValue("@target", ddlTarget.SelectedValue);
                //     cmd.Parameters.AddWithValue("@type",   ddlType.SelectedValue);
                //     cmd.ExecuteNonQuery();
                // }

                lblMessage.Text = "✅ Announcement posted successfully!";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(5, 150, 105);

                // Clear form
                txtTitle.Text = "";
                txtMessage.Text = "";
                ddlTarget.SelectedIndex = 0;
                ddlType.SelectedIndex = 0;

                LoadAnnouncements();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // Clear the form
        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtTitle.Text = "";
            txtMessage.Text = "";
            ddlTarget.SelectedIndex = 0;
            ddlType.SelectedIndex = 0;
            lblMessage.Text = "";
        }
    }
}