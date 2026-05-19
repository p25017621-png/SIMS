<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dashboard.Master" AutoEventWireup="true" CodeBehind="ManageAttendance.aspx.cs" Inherits="SIMS.Lecturer.ManageAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="glass-card" style="padding:30px; border-radius:20px;">

        <h2>Manage Attendance</h2>

        <hr />

        <br />

        <asp:Label ID="lblStudent" runat="server" Text="Student Name"></asp:Label>

        <br /><br />

        <asp:TextBox ID="txtStudent" runat="server" Width="300px"></asp:TextBox>

        <br /><br />

        <asp:Label ID="lblStatus" runat="server" Text="Attendance Status"></asp:Label>

        <br /><br />

        <asp:DropDownList ID="ddlStatus" runat="server" Width="300px">
            <asp:ListItem>Present</asp:ListItem>
            <asp:ListItem>Absent</asp:ListItem>
        </asp:DropDownList>

        <br /><br />

        <asp:Button ID="btnSave" runat="server"
            Text="Save Attendance"
            CssClass="btn btn-primary"
            Width="200px" />

    </div>

</asp:Content>