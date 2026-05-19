<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Dashboard.Master" AutoEventWireup="true" CodeBehind="ViewStudents.aspx.cs" Inherits="SIMS.Lecturer.ViewStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="glass-card" style="padding:30px; border-radius:20px;">

        <h2>View Students</h2>

        <hr />

        <br />

        <table class="table table-bordered">

            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Course</th>
            </tr>

            <tr>
                <td>ST001</td>
                <td>John</td>
                <td>Computer Science</td>
            </tr>

            <tr>
                <td>ST002</td>
                <td>Sarah</td>
                <td>Information Technology</td>
            </tr>

        </table>

    </div>

</asp:Content>