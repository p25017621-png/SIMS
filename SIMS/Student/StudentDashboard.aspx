<%@ Page Title="Student Dashboard"
    Language="C#"
    MasterPageFile="~/Shared/Dashboard.Master"
    AutoEventWireup="true"
    CodeBehind="StudentDashboard.aspx.cs"
    Inherits="SIMS.Student.StudentDashboard" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="glass-card" style="padding:30px; border-radius:24px;">

    <h2>Student Dashboard</h2>

    <br />

    <div style="display:flex; gap:20px; flex-wrap:wrap;">

    <div class="glass-card" style="padding:20px; width:250px;">
        <h3>Total Enrolments</h3>
        <asp:Label ID="lblEnrolments" runat="server" Font-Size="24px"></asp:Label>
    </div>

    <div class="glass-card" style="padding:20px; width:250px;">
        <h3>Total Semester</h3>
        <asp:Label ID="lblSemester" runat="server" Font-Size="24px"></asp:Label>
    </div>

    <div class="glass-card" style="padding:20px; width:250px;">
        <h3>Total Programme</h3>
        <asp:Label ID="lblProgramme" runat="server" Font-Size="24px"></asp:Label>
    </div>

</div>

<br /><br />

<h3>Recent Student Enrolments</h3>

<asp:GridView ID="gvStudentSummary"
    runat="server"
    AutoGenerateColumns="true"
    CssClass="styled-grid"
    Width="100%">
</asp:GridView>

    </div>

</div>

</asp:Content>