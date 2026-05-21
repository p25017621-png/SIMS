<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="LecturerDashboard.aspx.cs"
Inherits="SIMS.Lecturer.LecturerDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Lecturer Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
    rel="stylesheet"/>

    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#f5f7ff;
}

/* MAIN */

.container{
    padding:30px;
}

/* TOP */

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.topbar h1{
    font-size:40px;
    color:#222;
}

.topbar p{
    color:#777;
    margin-top:5px;
}

.profile{
    width:50px;
    height:50px;
    border-radius:50%;
    background:#6c63ff;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    font-weight:600;
}

/* HERO */

.hero{
    background:linear-gradient(135deg,#6c63ff,#8b7dff);
    padding:30px;
    border-radius:25px;
    color:white;
    margin-bottom:25px;
}

.hero h2{
    font-size:34px;
    margin-bottom:10px;
}

/* GRID */

.grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
}

/* CARD */

.card{
    background:white;
    padding:25px;
    border-radius:20px;
    box-shadow:0 8px 20px rgba(0,0,0,0.05);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

/* ICON */

.icon{

    width:55px;
    height:55px;

    border-radius:15px;

    background:rgba(108,99,255,0.12);

    border:2px solid rgba(108,99,255,0.18);

    display:flex;
    justify-content:center;
    align-items:center;

    color:#6c63ff;

    font-size:22px;

    margin-bottom:15px;

    transition:0.3s;
}

.card:hover .icon{

    background:linear-gradient(135deg,#6c63ff,#8b7dff);

    color:white;
}

/* TEXT */

.card h3{
    font-size:24px;
    margin-bottom:10px;
}

.card p{
    color:#777;
    margin-bottom:20px;
    line-height:1.6;
}

/* BUTTON */

.dashboard-btn{

    border:none;

    padding:12px 24px;

    border-radius:10px;

    background:linear-gradient(135deg,#6c63ff,#8b7dff);

    color:white;

    font-weight:600;

    cursor:pointer;

    transition:0.3s;
}

.dashboard-btn:hover{
    transform:scale(1.05);
}

</style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <!-- TOP -->

    <div class="topbar">

        <div>

            <h1>Dashboard</h1>

            <p>Welcome back to SIMS</p>

        </div>

        <div class="profile">
            R
        </div>

    </div>

    <!-- HERO -->

    <div class="hero">

        <h2>Welcome Back, Lecturer!</h2>

        <p>
            Manage attendance, marks, students and profile easily.
        </p>

    </div>

    <!-- GRID -->

    <div class="grid">

        <!-- ATTENDANCE -->

        <div class="card">

            <div class="icon">
                <i class="fa-solid fa-calendar-check"></i>
            </div>

            <h3>Attendance</h3>

            <p>
                Manage student attendance records efficiently.
            </p>

            <asp:Button
                ID="btnAttendance"
                runat="server"
                Text="Open Attendance"
                CssClass="dashboard-btn"
                OnClick="btnAttendance_Click" />

        </div>

        <!-- MARKS -->

        <div class="card">

            <div class="icon">
                <i class="fa-solid fa-chart-column"></i>
            </div>

            <h3>Marks</h3>

            <p>
                Update student marks and academic grades.
            </p>

            <asp:Button
                ID="btnMarks"
                runat="server"
                Text="Open Marks"
                CssClass="dashboard-btn"
                OnClick="btnMarks_Click" />

        </div>

        <!-- STUDENTS -->

        <div class="card">

            <div class="icon">
                <i class="fa-solid fa-user-graduate"></i>
            </div>

            <h3>Students</h3>

            <p>
                View and manage student information easily.
            </p>

            <asp:Button
                ID="btnStudents"
                runat="server"
                Text="View Students"
                CssClass="dashboard-btn"
                OnClick="btnStudents_Click" />

        </div>

        <!-- PROFILE -->

        <div class="card">

            <div class="icon">
                <i class="fa-solid fa-user-pen"></i>
            </div>

            <h3>Profile</h3>

            <p>
                Update lecturer profile and account settings.
            </p>

            <asp:Button
                ID="btnProfile"
                runat="server"
                Text="Manage Profile"
                CssClass="dashboard-btn"
                OnClick="btnProfile_Click" />

        </div>

    </div>

</div>

</form>

</body>

</html>