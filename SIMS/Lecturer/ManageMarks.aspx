<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dashboard.Master" AutoEventWireup="true" CodeBehind="ManageMarks.aspx.cs" Inherits="SIMS.Lecturer.ManageMarks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="glass-card" style="padding:30px; border-radius:20px;">

        <h2>Manage Marks</h2>

        <hr />

        <br />

        <asp:Label ID="lblStudent" runat="server" Text="Student Name"></asp:Label>

        <br /><br />

        <asp:TextBox ID="txtStudent" runat="server" Width="300px"></asp:TextBox>

        <br /><br />

        <asp:Label ID="lblMarks" runat="server" Text="Marks"></asp:Label>

        <br /><br />

        <asp:TextBox ID="txtMarks" runat="server" Width="300px"></asp:TextBox>

        <br /><br />

        <asp:Button ID="btnSaveMarks"
            runat="server"
            Text="Save Marks"
            CssClass="btn btn-success"
            Width="200px" />

    </div>

</asp:Content>