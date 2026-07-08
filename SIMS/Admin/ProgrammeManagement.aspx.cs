using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class ProgrammeManagement : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPrograms();
            }
        }

        private void LoadPrograms()
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
                "SELECT * FROM Programmes";

            SqlDataAdapter da =
                new SqlDataAdapter(query, con);

            DataTable dt =
                new DataTable();

            da.Fill(dt);

            gvPrograms.DataSource = dt;
            gvPrograms.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)


        {
            if (txtProgramName.Text.Trim() == "" ||
                txtProgramCode.Text.Trim() == "")
            {
                lblMessage.Text =
                    "Please fill in all fields.";

                return;
            }

           

        SqlConnection con =
                new SqlConnection(connectionString);

            string query =
                "INSERT INTO Programmes(programmeName, programmeCode) " +
                "VALUES(@programmeName, @programmeCode)";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@programmeName",
                txtProgramName.Text);

            cmd.Parameters.AddWithValue("@programmeCode",
                txtProgramCode.Text);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            lblMessage.Text = "Program Added Successfully!";

            LoadPrograms();
        }
        // Confirmation for delete and update action
        protected void gvPrograms_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Check if the row is a data row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Loop through the controls in the last cell (where Edit/Delete/Update/Cancel buttons usually live)
                foreach (Control control in e.Row.Cells[e.Row.Cells.Count - 1].Controls)
                {
                    if (control is LinkButton)
                    {
                        LinkButton btn = (LinkButton)control;

                        // Add confirmation to Delete button
                        if (btn.CommandName == "Delete")
                        {
                            btn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this programme?');");
                        }

                        // Add confirmation to Update button (Save button)
                        else if (btn.CommandName == "Update")
                        {
                            btn.Attributes.Add("onclick", "return confirm('Are you sure you want to save these updates?');");
                        }
                    }
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtProgramName.Text = "";
            txtProgramCode.Text = "";
            lblMessage.Text = "";
        }
        protected void gvPrograms_RowDeleting(
    object sender,
    GridViewDeleteEventArgs e)
        {
            int programmeID =
                Convert.ToInt32(
                    gvPrograms.DataKeys[e.RowIndex].Value);

            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
"DELETE FROM Courses WHERE programmeID=@programmeID;" +
"DELETE FROM Programmes WHERE programmeID=@programmeID;";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue(
                "@programmeID",
                programmeID);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            lblMessage.Text =
                "Program Deleted Successfully!";

            LoadPrograms();
        }
        

        protected void gvPrograms_RowEditing(
            object sender,
            GridViewEditEventArgs e)
        {
            gvPrograms.EditIndex = e.NewEditIndex;

            LoadPrograms();
        }

        protected void gvPrograms_RowCancelingEdit(
            object sender,
            GridViewCancelEditEventArgs e)
        {
            gvPrograms.EditIndex = -1;

            LoadPrograms();
        }

        protected void gvPrograms_RowUpdating(
            object sender,
            GridViewUpdateEventArgs e)
        {
            int programmeID =
                Convert.ToInt32(
                    gvPrograms.DataKeys[e.RowIndex].Value);

            string programmeName =
                ((TextBox)gvPrograms.Rows[e.RowIndex]
                .Cells[1].Controls[0]).Text;

            string programmeCode =
                ((TextBox)gvPrograms.Rows[e.RowIndex]
                .Cells[2].Controls[0]).Text;

            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
                "UPDATE Programmes " +
                "SET programmeName=@programmeName, " +
                "programmeCode=@programmeCode " +
                "WHERE programmeID=@programmeID";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue(
                "@programmeName",
                programmeName);

            cmd.Parameters.AddWithValue(
                "@programmeCode",
                programmeCode);

            cmd.Parameters.AddWithValue(
                "@programmeID",
                programmeID);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            gvPrograms.EditIndex = -1;

            lblMessage.Text =
                "Program Updated Successfully!";

            LoadPrograms();
        }
    }


}