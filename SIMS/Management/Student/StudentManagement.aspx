<%@ Page Language="C#" AutoEventWireup="True"
    MasterPageFile="~/Shared/Dashboard.Master"
    CodeBehind="StudentManagement.aspx.cs"
    Inherits="SIMS.Management.Student.StudentManagement" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="glass-card student-management-card">

        <h2 class="section-title">
            Student Management
        </h2>

      
<!-- INPUT SECTION -->

<div class="form-grid">

    <asp:TextBox ID="txtName"
        runat="server"
        CssClass="form-input"
        Placeholder="Student Name">
    </asp:TextBox>

    <asp:TextBox ID="txtEmail"
        runat="server"
        CssClass="form-input"
        Placeholder="Student Email">
    </asp:TextBox>

    <asp:TextBox ID="txtPassword"
        runat="server"
        CssClass="form-input"
        Placeholder="Password"
        TextMode="Password">
    </asp:TextBox>

    <asp:TextBox ID="txtPhone"
        runat="server"
        CssClass="form-input"
        Placeholder="Phone Number">
    </asp:TextBox>

    <!-- GENDER -->

    <asp:DropDownList ID="ddlGender"
        runat="server"
        CssClass="form-input">

        <asp:ListItem Text="Select Gender" Value="" />

        <asp:ListItem Text="Male" Value="Male" />

        <asp:ListItem Text="Female" Value="Female" />

    </asp:DropDownList>

    <!-- DATE OF BIRTH -->

    <asp:TextBox ID="txtAddress"
    runat="server"
    CssClass="form-input"
    Placeholder="Address">
</asp:TextBox>

    <asp:TextBox ID="txtDOB"
        runat="server"
        CssClass="form-input"
        TextMode="Date">
    </asp:TextBox>

</div>


        <br />

        <!-- BUTTON -->

        <asp:Button ID="btnAdd"
            runat="server"
            Text="Add Student"
            CssClass="primary-btn"
            OnClick="btnAdd_Click" />

        <asp:Button ID="btnClear"
    runat="server"
    Text="Clear"
    CssClass="primary-btn"
    OnClick="btnClear_Click" />

        <br /><br />

        <!-- MESSAGE -->

        <asp:Label ID="lblMessage"
            runat="server"
            CssClass="success-message">
        </asp:Label>

        <br /><br />

        <!-- TABLE -->

        <div class="table-container">

            <asp:GridView ID="gvStudents"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="styled-grid"
                Width="100%"
                GridLines="None"
                DataKeyNames="userID"
                OnRowEditing="gvStudents_RowEditing"
                OnRowCancelingEdit="gvStudents_RowCancelingEdit"
                OnRowUpdating="gvStudents_RowUpdating"
                OnRowDeleting="gvStudents_RowDeleting">

                <Columns>

                    <asp:BoundField
                        DataField="name"
                        HeaderText="Name" />

                    <asp:BoundField
                        DataField="email"
                        HeaderText="Email" />

                    <asp:BoundField
                        DataField="phone"
                        HeaderText="Phone" />

                    <asp:BoundField DataField="gender"
                    HeaderText="Gender" />

                   <asp:BoundField DataField="dateOfBirth"
                    HeaderText="Date Of Birth"
                   DataFormatString="{0:dd/MM/yyyy}" />

                   <asp:BoundField DataField="address"
                    HeaderText="Address" />

                     <asp:CommandField
                      ShowEditButton="True"
                      ShowDeleteButton="True" />


                </Columns>

            </asp:GridView>

        </div>

    </div>

</asp:Content>
