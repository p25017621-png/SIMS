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
            overflow-x:auto;
            position:relative;
        }

        /* Animated Background */

        .bg-circle{
            position:absolute;
            border-radius:50%;
            background:rgba(123,92,255,0.12);
            animation:float 6s infinite ease-in-out;
            z-index:0;
        }

        .circle1{
            width:220px;
            height:220px;
            top:40px;
            left:50px;
        }

        .circle2{
            width:180px;
            height:180px;
            bottom:60px;
            right:100px;
            animation-delay:2s;
        }

        .circle3{
            width:120px;
            height:120px;
            top:280px;
            right:250px;
            animation-delay:4s;
        }

        @keyframes float{
            0%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(-20px);
            }

            100%{
                transform:translateY(0px);
            }
        }

        .container{
            display:flex;
            min-height:100vh;
            position:relative;
            z-index:1;
        }

        /* Sidebar */

        .sidebar{
            width:250px;
            background:rgba(255,255,255,0.4);
            backdrop-filter:blur(20px);
            padding:40px 25px;
            box-shadow:0 10px 25px rgba(128,0,255,0.08);
        }

        .logo{
            font-size:45px;
            font-weight:700;
            color:#7b5cff;
            margin-bottom:50px;
        }

        .menu a{
            display:block;
            padding:16px 20px;
            margin-bottom:15px;
            border-radius:16px;
            text-decoration:none;
            color:#555;
            font-size:17px;
            transition:0.3s;
        }

        .menu a:hover{
            background:linear-gradient(90deg,#7b5cff,#9b7bff);
            color:white;
        }

        .active{
            background:linear-gradient(90deg,#7b5cff,#9b7bff);
            color:white !important;
        }

        /* Main Content */

        .main{
            flex:1;
            padding:30px 40px;
        }

        .title{
            font-size:45px;
            font-weight:700;
            color:#111;
        }

        .subtitle{
            color:#999;
            margin-top:10px;
            margin-bottom:40px;
            font-size:18px;
        }

        .card{
            background:rgba(255,255,255,0.4);
            backdrop-filter:blur(18px);
            border-radius:30px;
            padding:35px;
            box-shadow:0 10px 35px rgba(128,0,255,0.12);
        }

        .top-section{
            display:flex;
            align-items:center;
            margin-bottom:30px;
        }

        .icon{
            width:85px;
            height:85px;
            background:linear-gradient(135deg,#7b5cff,#9b7bff);
            border-radius:25px;
            display:flex;
            justify-content:center;
            align-items:center;
            font-size:40px;
            color:white;
            margin-right:20px;
            box-shadow:0 8px 20px rgba(123,92,255,0.3);
        }

        .top-section h2{
            font-size:42px;
            color:#222;
        }

        .top-section p{
            color:#888;
            margin-top:8px;
            font-size:17px;
        }

        table{
            width:100%;
            border-collapse:collapse;
            overflow:hidden;
            border-radius:20px;
            background:white;
            box-shadow:0 8px 20px rgba(128,0,255,0.08);
        }

        th{
            background:linear-gradient(90deg,#7b5cff,#9b7bff);
            color:white;
            padding:18px;
            text-align:left;
            font-size:15px;
        }

        td{
            padding:18px;
            border-bottom:1px solid #eee;
            color:#555;
            font-size:15px;
        }

        tr:hover{
            background:#faf7ff;
            transition:0.3s;
        }

        .course{
            color:#6c4cff;
            font-weight:600;
        }

    </style>

</head>

<body>

    <!-- Background Animation -->

    <div class="bg-circle circle1"></div>
    <div class="bg-circle circle2"></div>
    <div class="bg-circle circle3"></div>

    <form id="form1" runat="server">

        <div class="container">

            <!-- Sidebar -->

            <div class="sidebar">

                <div class="logo">SIMS</div>

                <div class="menu">

                    <a href="LecturerDashboard.aspx">Dashboard</a>

                    <a href="ManageAttendance.aspx">Attendance</a>

                    <a href="ManageMarks.aspx">Marks</a>

                    <a class="active" href="ViewStudents.aspx">Students</a>

                    <a href="ManageProfile.aspx">Profile</a>

                </div>

            </div>

            <!-- Main Content -->

            <div class="main">

                <h1 class="title">Student List</h1>

                <p class="subtitle">
                    View all registered students
                </p>

                <div class="card">

                    <div class="top-section">

                        <div class="icon">🎓</div>

                        <div>

                            <h2>Students Information</h2>

                            <p>
                                Manage and monitor student records easily
                            </p>

                        </div>

                    </div>

                    <table>

                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Course</th>
                            <th>Coursework</th>
                            <th>Final Exam</th>
                        </tr>

                        <tr>
                            <td>ST001</td>
                            <td>John Tan</td>
                            <td>john@gmail.com</td>
                            <td class="course">Computer Science</td>
                            <td>25</td>
                            <td>60</td>
                        </tr>

                        <tr>
                            <td>ST002</td>
                            <td>Sarah Lim</td>
                            <td>sarah@gmail.com</td>
                            <td class="course">Software Engineering</td>
                            <td>28</td>
                            <td>55</td>
                        </tr>

                        <tr>
                            <td>ST003</td>
                            <td>Daniel Wong</td>
                            <td>daniel@gmail.com</td>
                            <td class="course">Information Technology</td>
                            <td>30</td>
                            <td>65</td>
                        </tr>

                    </table>

                </div>

            </div>

        </div>

    </form>

</body>
</html>