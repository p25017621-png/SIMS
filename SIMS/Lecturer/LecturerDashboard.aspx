<%@ Page Title="Lecturer Dashboard"
    Language="C#"
    MasterPageFile="~/Shared/Dashboard.Master"
    AutoEventWireup="true"
    CodeBehind="LecturerDashboard.aspx.cs"
    Inherits="SIMS.Lecturer.LecturerDashboard" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

<div class="glass-card" style="padding:30px; border-radius:24px;">

    <h2>Lecturer Dashboard</h2>

    <br />

    <div style="display:flex; gap:20px; flex-wrap:wrap;">

        <div class="glass-card" style="padding:20px; width:250px;">
            <h3>Total Lecturers</h3>
            <asp:Label ID="lblLecturers" runat="server" Font-Size="24px"></asp:Label>
        </div>

        <div class="glass-card" style="padding:20px; width:250px;">
            <h3>Total Courses</h3>
            <asp:Label ID="lblCourses" runat="server" Font-Size="24px"></asp:Label>
        </div>

        <div class="glass-card" style="padding:20px; width:250px;">
            <h3>Total Assignments</h3>
            <asp:Label ID="lblAssignments" runat="server" Font-Size="24px"></asp:Label>
        </div>

    </div>

</div>

<br /><br />

<h3>Recent Course Assignments</h3>

<asp:GridView ID="gvAssignments"
    runat="server"
    CssClass="student-grid"
    Width="100%"
    AutoGenerateColumns="true">
</asp:GridView>

</asp:Content>