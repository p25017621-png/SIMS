<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dashboard.Master"
    AutoEventWireup="true"
    CodeBehind="LecturerDashboard.aspx.cs"
    Inherits="SIMS.Lecturer.LecturerDashboard" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

  <div class="glass-card" style="padding:30px; border-radius:24px;">

    <h2>Lecturer Dashboard</h2>

    <p>Welcome Lecturer</p>

    <hr />

    <div style="margin-top:20px;">

        <asp:Button ID="btnAttendance" runat="server"
            Text="Manage Attendance"
            CssClass="btn btn-primary"
            Width="200px" />

        <br /><br />

        <asp:Button ID="btnMarks" runat="server"
            Text="Manage Marks"
            CssClass="btn btn-success"
            Width="200px" />

        <br /><br />

        <asp:Button ID="btnStudents" runat="server"
            Text="View Students"
            CssClass="btn btn-info"
            Width="200px" />

        <br /><br />

        <asp:Button ID="btnProfile" runat="server"
            Text="Manage Profile"
            CssClass="btn btn-warning"
            Width="200px" />

    </div>

</div>

</asp:Content>