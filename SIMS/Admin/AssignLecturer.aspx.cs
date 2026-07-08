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
    public partial class AssignLecturer : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLecturers();
                LoadCourses();
                LoadAssignments();
            }
        }

        private void LoadLecturers()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"SELECT l.lecturerID, u.name 
                                 FROM Lecturers l
                                 JOIN Users u ON l.userID = u.userID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlLecturer.DataSource = dt;
                ddlLecturer.DataTextField = "name";
                ddlLecturer.DataValueField = "lecturerID";
                ddlLecturer.DataBind();
            }
        }

        private void LoadCourses()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT courseID, courseName FROM Courses";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                cblCourses.DataSource = dt;
                cblCourses.DataTextField = "courseName";
                cblCourses.DataValueField = "courseID";
                cblCourses.DataBind();
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                try
                {
                    foreach (System.Web.UI.WebControls.ListItem item in cblCourses.Items)
                    {
                        if (item.Selected)
                        {
                            string query = @"INSERT INTO LecturerCourseAssignments
                                             (lecturerID, courseID, semester)
                                             VALUES (@lecturerID, @courseID, @semester)";

                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@lecturerID", ddlLecturer.SelectedValue);
                            cmd.Parameters.AddWithValue("@courseID", item.Value);
                            cmd.Parameters.AddWithValue("@semester", ddlSemester.SelectedValue);

                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblMessage.Text = "Assigned successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    LoadAssignments();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
            }
        }

        private void LoadAssignments()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"SELECT a.assignmentID, u.name AS lecturerName, 
                        c.courseName, a.semester
                 FROM LecturerCourseAssignments a
                 JOIN Lecturers l ON a.lecturerID = l.lecturerID
                 JOIN Users u ON l.userID = u.userID
                 JOIN Courses c ON a.courseID = c.courseID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAssign.DataSource = dt;
                gvAssign.DataBind();
            }
        }
        //row editing oonly semester editable
        protected void gvAssign_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAssign.EditIndex = e.NewEditIndex;
            LoadAssignments();
        }

        protected void gvAssign_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAssign.EditIndex = -1;
            LoadAssignments();
        }
        protected void gvAssign_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvAssign.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvAssign.Rows[e.RowIndex];

            string semester = ((TextBox)row.Cells[3].Controls[0]).Text;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                try
                {
                    string query = "UPDATE LecturerCourseAssignments SET semester=@sem WHERE assignmentID=@id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@sem", Convert.ToInt32(semester));
                    cmd.Parameters.AddWithValue("@id", id);

                    cmd.ExecuteNonQuery();

                    gvAssign.EditIndex = -1;
                    LoadAssignments();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
            }
        }
        //delete
        protected void gvAssign_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvAssign.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                try
                {
                    string query = "DELETE FROM LecturerCourseAssignments WHERE assignmentID=@id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", id);

                    cmd.ExecuteNonQuery();

                    LoadAssignments();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
            }
        }
        // Confirmation for delete and update action
        protected void gvAssign_RowDataBound(object sender, GridViewRowEventArgs e)
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
                            btn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this assignment?');");
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
    }
}
