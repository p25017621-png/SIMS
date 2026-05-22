using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SIMS.Lecturer
{
    public partial class ManageProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
        @"Data Source=(LocalDB)\MSSQLLocalDB;
        Initial Catalog=SIMS_DB;
        Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLecturers();
            }
        }

        void LoadLecturers()
        {
            con.Open();

            SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM LecturerProfile",
            con);

            DataTable dt = new DataTable();

            da.Fill(dt);

            GridView1.DataSource = dt;

            GridView1.DataBind();

            con.Close();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "INSERT INTO LecturerProfile VALUES(@name,@email,@phone,@department)",
            con);

            cmd.Parameters.AddWithValue("@name", txtName.Text);

            cmd.Parameters.AddWithValue("@email", txtEmail.Text);

            cmd.Parameters.AddWithValue("@phone", txtPhone.Text);

            cmd.Parameters.AddWithValue("@department", txtDepartment.Text);

            cmd.ExecuteNonQuery();

            con.Close();

            LoadLecturers();

            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtDepartment.Text = "";
        }
    }
}