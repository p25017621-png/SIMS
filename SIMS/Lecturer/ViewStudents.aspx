<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudents.aspx.cs" Inherits="SIMS.Lecturer.ViewStudents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Students</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins',sans-serif;
        }

        body{
            background:linear-gradient(135deg,#f7f3ff,#efe7ff);
            min-height:100vh;
            overflow-x:hidden;
        }

        .container{
            display:flex;
            min-height:100vh;
        }

        /* SIDEBAR */

        .sidebar{
            width:240px;
            background:white;
            padding:35px 20px;
            box-shadow:0 0 20px rgba(0,0,0,0.05);
        }

        .logo{
            font-size:48px;
            font-weight:700;
            color:#6C63FF;
            margin-bottom:50px;
        }

        .menu{
            display:flex;
            flex-direction:column;
            gap:15px;
        }

        .menu a{
            text-decoration:none;
            padding:15px;
            border-radius:14px;
            color:#555;
            transition:0.3s;
        }

        .menu a:hover{
            background:#eee9ff;
            color:#6C63FF;
        }

        .active{
            background:linear-gradient(135deg,#6C63FF,#8E7BFF);
            color:white !important;
        }

        /* MAIN */

        .main{
            flex:1;
            padding:40px;
        }

        .title{
            font-size:50px;
            font-weight:700;
            color:#222;
        }

        .subtitle{
            color:#888;
            margin-top:10px;
            margin-bottom:40px;
        }

        /* CARD */

        .card{
            background:white;
            border-radius:25px;
            padding:30px;
            box-shadow:0 10px 30px rgba(0,0,0,0.05);
        }

        .card-top{
            display:flex;
            align-items:center;
            margin-bottom:30px;
        }

        .icon{
            width:80px;
            height:80px;
            background:linear-gradient(135deg,#6C63FF,#8E7BFF);
            border-radius:20px;
            display:flex;
            justify-content:center;
            align-items:center;
            color:white;
            font-size:35px;
            margin-right:20px;
        }

        .card-top h2{
            font-size:35px;
            color:#222;
        }

        .card-top p{
            color:#888;
            margin-top:5px;
        }

        /* TABLE */

        table{
            width:100%;
            border-collapse:collapse;
            overflow:hidden;
            border-radius:18px;
        }

        th{
            background:linear-gradient(135deg,#6C63FF,#8E7BFF);
            color:white;
            padding:18px;
            text-align:left;
        }

        td{
            padding:18px;
            border-bottom:1px solid #eee;
            color:#555;
        }

        tr:hover{
            background:#faf8ff;
        }

        .course{
            color:#6C63FF;
            font-weight:600;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <!-- SIDEBAR -->

    <div class="sidebar">

        <div class="logo">
            SIMS
        </div>

        <div class="menu">

            <a href="LecturerDashboard.aspx">
                Dashboard
            </a>

            <a href="ManageAttendance.aspx">
                Attendance
            </a>

            <a href="ManageMarks.aspx">
                Marks
            </a>

            <a href="ViewStudents.aspx" class="active">
                Students
            </a>

            <a href="ManageProfile.aspx">
                Profile
            </a>

        </div>

    </div>

    <!-- MAIN -->

    <div class="main">

        <div class="title">
            Student List
        </div>

        <div class="subtitle">
            View all registered students
        </div>

        <div class="card">

            <div class="card-top">

                <div class="icon">
                    🎓
                </div>

                <div>

                    <h2>Students Information</h2>

                    <p>
                        Manage and monitor student records easily
                    </p>

                </div>

            </div>

            <!-- TABLE -->

            <table>

                <tr>

                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>

                </tr>

                <asp:Repeater ID="rptStudents" runat="server">

                    <ItemTemplate>

                        <tr>

                            <td><%# Eval("StudentID") %></td>

                            <td><%# Eval("StudentName") %></td>

                            <td><%# Eval("Email") %></td>

                            <td class="course">
                                <%# Eval("Course") %>
                            </td>

                        </tr>

                    </ItemTemplate>

                </asp:Repeater>

            </table>

        </div>

    </div>

</div>

</form>

</body>
</html>