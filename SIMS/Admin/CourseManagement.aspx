<%@ Page Language="C#" AutoEventWireup="True"
    MasterPageFile="~/Shared/Dashboard.Master"
    CodeBehind="CourseManagement.aspx.cs"
    Inherits="SIMS.Admin.CourseManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="glass-card" style="padding:30px; border-radius:24px;">

        <h2>Course Management</h2>
        <br />

        <!-- INPUTS -->
        <asp:TextBox ID="txtCourseName" runat="server" Placeholder="Course Name"></asp:TextBox>

        <%-- Removed txtCourseCode input from here to keep UI clean --%>

        <asp:TextBox ID="txtCredits" runat="server" Placeholder="Credits"></asp:TextBox>

        <!-- Programme Dropdown -->
        <asp:DropDownList ID="ddlProgramme" runat="server" AppendDataBoundItems="true">
            <asp:ListItem Text="-- Select a Program --" Value="" />
        </asp:DropDownList>

        <br /><br />

        <!-- BUTTONS -->
        <asp:Button ID="btnAdd" runat="server" Text="Add Course" CssClass="primary-btn" OnClick="btnAdd_Click" />
        &nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="primary-btn" OnClick="btnClear_Click" />

        <br /><br />

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>

        <!-- TABLE -->
        <div class="table-container">
            <asp:GridView ID="gvCourses"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="styled-grid"
                Width="100%"
                GridLines="None"
                DataKeyNames="courseID"
                OnRowDeleting="gvCourses_RowDeleting"
                OnRowEditing="gvCourses_RowEditing"
                OnRowUpdating="gvCourses_RowUpdating"
                OnRowCancelingEdit="gvCourses_RowCancelingEdit">

                <Columns>
                    <asp:BoundField DataField="courseID" HeaderText="ID" ReadOnly="true" />
                    
                    <asp:BoundField DataField="courseName" HeaderText="Course Name" />

                    <%-- Removed the courseCode BoundField from here to prevent the SQL data-binding crash --%>

                    <asp:BoundField DataField="credits" HeaderText="Credits" />

                    <asp:BoundField DataField="programmeName" HeaderText="Programme" ReadOnly="true" />

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>