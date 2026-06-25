<%@ Page Language="C#"
MasterPageFile="~/Shared/Dashboard.Master"
AutoEventWireup="true"
CodeBehind="Reports.aspx.cs"
Inherits="SIMS.Admin.Reports" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="MainContent"
runat="server">

<div class="glass-card" style="padding:30px;">

<h2 class="section-title">
Reports Management
</h2>

    <asp:Label ID="lblReportTitle"
runat="server"
Font-Size="22px"
Font-Bold="true">
</asp:Label>

<br /><br />

<div class="form-grid">

<asp:Button ID="btnStudentReport"
runat="server"
Text="Student Report"
CssClass="primary-btn"
OnClick="btnStudentReport_Click" />

<asp:Button ID="btnLecturerReport"
runat="server"
Text="Lecturer Report"
CssClass="primary-btn"
OnClick="btnLecturerReport_Click" />

<asp:Button ID="btnCourseReport"
runat="server"
Text="Course Report"
CssClass="primary-btn"
OnClick="btnCourseReport_Click" />

<asp:Button ID="btnProgrammeReport"
runat="server"
Text="Programme Report"
CssClass="primary-btn"
OnClick="btnProgrammeReport_Click" />

<asp:Button ID="btnAssignmentReport"
runat="server"
Text="Assignment Report"
CssClass="primary-btn"
OnClick="btnAssignmentReport_Click" />

</div>

<br /><br />

<asp:GridView ID="gvReport"
runat="server"
CssClass="student-grid"
Width="100%">
</asp:GridView>

</div>

</asp:Content>