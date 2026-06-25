<%@ Page Language="C#" AutoEventWireup="true"
MasterPageFile="~/Shared/Dashboard.Master"
CodeBehind="ProgrammeManagement.aspx.cs"
Inherits="SIMS.Admin.ProgrammeManagement" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="MainContent"
runat="server">

<div class="glass-card" style="padding:30px;">

    <h2>Programme Management</h2>

    <br />

    <asp:TextBox ID="txtProgramName"
        runat="server"
        Placeholder="Program Name">
    </asp:TextBox>

    <asp:TextBox ID="txtProgramCode"
        runat="server"
        Placeholder="Program Code">
    </asp:TextBox>

    <br /><br />
<asp:Button ID="btnAddProgram"
runat="server"
Text="Add Program"
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
        runat="server">
    </asp:Label>

    <br /><br />

    <asp:GridView ID="gvPrograms"
    runat="server"
    CssClass="student-grid"
    AutoGenerateColumns="False"
    DataKeyNames="programmeID"
    OnRowEditing="gvPrograms_RowEditing"
    OnRowUpdating="gvPrograms_RowUpdating"
    OnRowCancelingEdit="gvPrograms_RowCancelingEdit"
    OnRowDeleting="gvPrograms_RowDeleting">

    <Columns>

        <asp:BoundField
            DataField="programmeID"
            HeaderText="ID"
            ReadOnly="True" />

        <asp:BoundField
            DataField="programmeName"
            HeaderText="Program Name" />

        <asp:BoundField
            DataField="programmeCode"
            HeaderText="Program Code" />

        <asp:CommandField
            ShowEditButton="True"
            ShowDeleteButton="True" />

    </Columns>

</asp:GridView>

</div>

</asp:Content>