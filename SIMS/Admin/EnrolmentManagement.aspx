<%@ Page Language="C#"
MasterPageFile="~/Shared/Dashboard.Master"
AutoEventWireup="true"
CodeBehind="EnrolmentManagement.aspx.cs"
Inherits="SIMS.Admin.EnrolmentManagement" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="MainContent"
runat="server">

    <h2>Enrol Student to Course</h2>

    <div style="display:flex; gap:20px; margin-bottom:20px;">

    <div>
        <b>Student</b><br /><br />
        <asp:DropDownList ID="ddlStudent"
            runat="server"
            AppendDataBoundItems="true"
            CssClass="form-control">
            <asp:ListItem Text="-- Select Student --" Value="" />
        </asp:DropDownList>
    </div>

    <div>
        <b>Programme</b><br /><br />
        <asp:DropDownList ID="ddlProgramme"
            runat="server"
            AppendDataBoundItems="true"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlProgramme_SelectedIndexChanged"
            CssClass="form-control">
            <asp:ListItem Text="-- Select Programme --" Value="" />
        </asp:DropDownList>
    </div>

</div>

<div style="display:flex; gap:20px; margin-bottom:20px;">

    <div>
        <b>Course</b><br /><br />
        <asp:DropDownList ID="ddlCourse"
            runat="server"
            AppendDataBoundItems="true"
            CssClass="form-control">
            <asp:ListItem Text="-- Select Course --" Value="" />
        </asp:DropDownList>
    </div>

    <div>
        <b>Semester</b><br /><br />
        <asp:DropDownList ID="ddlSemester"
            runat="server"
            CssClass="form-control">

            <asp:ListItem Text="-- Select Semester --" Value="" />
            <asp:ListItem Text="1" Value="1" />
            <asp:ListItem Text="2" Value="2" />
            <asp:ListItem Text="3" Value="3" />
            <asp:ListItem Text="4" Value="4" />
            <asp:ListItem Text="5" Value="5" />
            <asp:ListItem Text="6" Value="6" />
            <asp:ListItem Text="7" Value="7" />

        </asp:DropDownList>
    </div>

</div>

    <asp:Button
    ID="btnEnrol"
    runat="server"
    Text="Enrol Student"
    CssClass="primary-btn"
    OnClick="btnEnrol_Click" />

&nbsp;&nbsp;

<asp:Button
    ID="btnClear"
    runat="server"
    Text="Clear"
    CssClass="primary-btn"
    OnClick="btnClear_Click" />
    <br /><br />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

    <br /><br />

    <!-- GRID -->
    <asp:GridView ID="gvEnrolment"
    runat="server"
    CssClass="student-grid"
    Width="100%"
    GridLines="None"
    AutoGenerateColumns="false"
    DataKeyNames="enrolmentID"
    OnRowDeleting="gvEnrolment_RowDeleting">

        <Columns>
            <asp:BoundField DataField="studentName" HeaderText="Student" />
            <asp:BoundField DataField="programmeName" HeaderText="Programme" />
            <asp:BoundField DataField="courseName" HeaderText="Course" />
            <asp:BoundField DataField="semester" HeaderText="Semester" />
            <asp:BoundField DataField="enrolDate" HeaderText="Date" />

            <asp:CommandField
               HeaderText="Action"
               ShowDeleteButton="true" />

        </Columns>

    </asp:GridView>

</asp:Content>