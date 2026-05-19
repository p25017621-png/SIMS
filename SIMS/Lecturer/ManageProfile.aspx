<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dashboard.Master" AutoEventWireup="true" CodeBehind="ManageProfile.aspx.cs" Inherits="SIMS.Lecturer.ManageProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="glass-card" style="padding:30px; border-radius:20px;">

        <h2>Manage Profile</h2>

        <hr />

        <br />

        <asp:Label ID="lblName" runat="server" Text="Lecturer Name"></asp:Label>

        <br /><br />

        <asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox>

        <br /><br />

        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>

        <br /><br />

        <asp:TextBox ID="txtEmail" runat="server" Width="300px"></asp:TextBox>

        <br /><br />

        <asp:Button ID="btnUpdate"
            runat="server"
            Text="Update Profile"
            CssClass="btn btn-warning"
            Width="200px" />

    </div>

</asp:Content>