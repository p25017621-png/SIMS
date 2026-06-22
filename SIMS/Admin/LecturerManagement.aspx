<%@ Page Language="C#" AutoEventWireup="True"
    MasterPageFile="~/Shared/Dashboard.Master"
    CodeBehind="LecturerManagement.aspx.cs"
    Inherits="SIMS.Admin.LecturerManagement" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="MainContent"
runat="server">

<div class="glass-card"
style="padding:30px; border-radius:24px;">

<h2>Lecturer Management</h2>

<br />

<asp:TextBox ID="txtName"
runat="server"
Placeholder="Name"></asp:TextBox>

<asp:TextBox ID="txtEmail"
runat="server"
Placeholder="Email"></asp:TextBox>

<asp:TextBox ID="txtPassword"
runat="server"
Placeholder="Password"
TextMode="Password"></asp:TextBox>

<asp:TextBox ID="txtDepartment"
runat="server"
Placeholder="Department"></asp:TextBox>

<asp:TextBox ID="txtQualification"
runat="server"
Placeholder="Qualification"></asp:TextBox>

<asp:TextBox ID="txtPhone"
runat="server"
Placeholder="Phone"></asp:TextBox>

<br /><br />

<asp:Button ID="btnAdd"
runat="server"
Text="Add Lecturer"
    CssClass="primary-btn"
OnClick="btnAdd_Click" />

    &nbsp;&nbsp;

<asp:Button ID="btnClear"
    runat="server"
    Text="Clear"
    CssClass="primary-btn"
    OnClick="btnClear_Click" />

<br /><br />

<asp:Label ID="lblMessage"
runat="server"
ForeColor="Green"></asp:Label>

<br /><br />

<asp:GridView ID="gvLecturers"
runat="server"
CssClass="student-grid"
Width="100%"
GridLines="None"
AutoGenerateColumns="false"
DataKeyNames="lecturerID"
OnRowEditing="gvLecturers_RowEditing"
OnRowCancelingEdit="gvLecturers_RowCancelingEdit"
OnRowUpdating="gvLecturers_RowUpdating"
OnRowDeleting="gvLecturers_RowDeleting">

<Columns>

<asp:BoundField DataField="lecturerID"
HeaderText="ID"
ReadOnly="true" />

<asp:BoundField DataField="name"
HeaderText="Name" />

<asp:BoundField DataField="email"
HeaderText="Email" />

<asp:BoundField DataField="department"
HeaderText="Department" />

<asp:BoundField DataField="qualification"
HeaderText="Qualification" />

<asp:BoundField DataField="phone"
HeaderText="Phone" />

<asp:CommandField
ShowEditButton="true"
ShowDeleteButton="true" />

</Columns>

</asp:GridView>

</div>

</asp:Content>