using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMS.Lecturer
{
    public partial class Announcements : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadAnnouncements();
        }

        private void LoadAnnouncements()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string sql = @"SELECT announcementID, title, message, datePosted, lecturerID,
                                   CASE 
                                       WHEN lecturerID IS NULL THEN 'Admin' 
                                       ELSE 'Lecturer' 
                                   END AS PostedBy
                                   FROM Announcements
                                   ORDER BY datePosted DESC";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptAnnouncements.DataSource = dt;
                        rptAnnouncements.DataBind();
                        lblCount.Text = dt.Rows.Count.ToString();
                        pnlEmpty.Visible = false;
                    }
                    else
                    {
                        rptAnnouncements.DataSource = null;
                        rptAnnouncements.DataBind();
                        lblCount.Text = "0";
                        pnlEmpty.Visible = true;
                    }
                }
            }
            catch { }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            pnlSuccess.Visible = false;
            pnlError.Visible = false;

            if (string.IsNullOrWhiteSpace(txtTitle.Text) || string.IsNullOrWhiteSpace(txtMessage.Text))
            {
                pnlError.Visible = true;
                lblError.Text = "Please fill in both Title and Message!";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"INSERT INTO Announcements
                                   (lecturerID, title, message, datePosted)
                                   VALUES (@lid, @title, @msg, CAST(GETDATE() AS DATE))";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@msg", txtMessage.Text.Trim());
                    cmd.ExecuteNonQuery();
                }

                pnlSuccess.Visible = true;
                txtTitle.Text = "";
                txtMessage.Text = "";
                LoadAnnouncements();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void rptAnnouncements_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteAnn")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        con.Open();
                        string sql = "DELETE FROM Announcements WHERE announcementID = @id";
                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@id", Convert.ToInt32(e.CommandArgument));
                        cmd.ExecuteNonQuery();
                    }
                    LoadAnnouncements();
                }
                catch (Exception ex)
                {
                    pnlError.Visible = true;
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtTitle.Text = "";
            txtMessage.Text = "";
            pnlSuccess.Visible = false;
            pnlError.Visible = false;
        }
    }
}