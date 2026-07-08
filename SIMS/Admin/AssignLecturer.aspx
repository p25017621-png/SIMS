<%@ Page Language="C#" AutoEventWireup="true"
MasterPageFile="~/Shared/Dashboard.Master"
CodeBehind="AssignLecturer.aspx.cs"
Inherits="SIMS.Admin.AssignLecturer" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="MainContent"
runat="server">

<div class="glass-card"
style="padding:30px; border-radius:24px;">

    <h2>Assign Lecturer Management</h2>

    <br />

    <div style="display:flex; gap:20px; margin-bottom:25px;">

    <!-- Lecturer -->
    <asp:DropDownList ID="ddlLecturer"
    runat="server"
    CssClass="form-control">
</asp:DropDownList>

    <!-- Semester -->
   <asp:DropDownList ID="ddlSemester"
    runat="server"
    CssClass="form-control">

        <asp:ListItem Text="Semester 1" Value="1" />
        <asp:ListItem Text="Semester 2" Value="2" />
        <asp:ListItem Text="Semester 3" Value="3" />
        <asp:ListItem Text="Semester 4" Value="4" />
        <asp:ListItem Text="Semester 5" Value="5" />
        <asp:ListItem Text="Semester 6" Value="6" />
        <asp:ListItem Text="Semester 7" Value="7" />

    </asp:DropDownList>

</div>

    <!-- Courses -->
    <div class="glass-card"
style="padding:20px; margin-top:20px;">

    <h3>Available Courses</h3>

    <asp:CheckBoxList ID="cblCourses"
        runat="server"
        RepeatDirection="Vertical"
        CssClass="course-list">
    </asp:CheckBoxList>

</div>
    

    <br /><br />

    <asp:Button ID="btnAssign"
    runat="server"
    Text="Assign"
    CssClass="primary-btn"
    OnClick="btnAssign_Click" />

    <br /><br />

    <asp:Label ID="lblMessage"
    runat="server"
    CssClass="success-msg">
</asp:Label>

    <br /><br />

    <asp:GridView ID="gvAssign"
runat="server"
CssClass="student-grid"
Width="100%"
AutoGenerateColumns="false"
DataKeyNames="assignmentID"
GridLines="None"
OnRowEditing="gvAssign_RowEditing"
OnRowCancelingEdit="gvAssign_RowCancelingEdit"
OnRowUpdating="gvAssign_RowUpdating"
OnRowDeleting="gvAssign_RowDeleting"
OnRowDataBound="gvAssign_RowDataBound">


       <Columns>

    <asp:BoundField
        DataField="assignmentID"
        HeaderText="ID"
        ReadOnly="true" />

    <asp:BoundField
        DataField="lecturerName"
        HeaderText="Lecturer"
        ReadOnly="true" />

    <asp:BoundField
        DataField="courseName"
        HeaderText="Course"
        ReadOnly="true" />

    <asp:BoundField
        DataField="semester"
        HeaderText="Semester" />

    <asp:CommandField
        ShowEditButton="true"
        ShowDeleteButton="true" />

</Columns>
    </asp:GridView>

</div>

</asp:Content>