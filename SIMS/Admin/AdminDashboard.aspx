<%@ Page Title="Admin Dashboard"
    MasterPageFile="~/Shared/Dashboard.Master"
    CodeBehind="AdminDashboard.aspx.cs"
    Inherits="SIMS.Admin.AdminDashboard" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="dashboard-cards">

        <div class="glass-card stat-card">
            <h3>👨‍🎓 Total Students</h3>
           <p>
    <asp:Label ID="lblStudents"
        runat="server"
        Text="0">
    </asp:Label>
</p>
        </div>

        <div class="glass-card stat-card">
   <h3>👨‍🏫 Total Lecturers</h3>

    <p>
        <asp:Label ID="lblLecturers"
            runat="server"
            Text="0">
        </asp:Label>
    </p>
</div>

     <div class="glass-card stat-card">
    <h3>📚 Total Courses</h3>

    <p>
        <asp:Label ID="lblCourses"
            runat="server"
            Text="0">
        </asp:Label>
    </p>
</div>

<div class="glass-card stat-card">
    <h3>🎓 Total Programmes</h3>

    <p>
        <asp:Label ID="lblProgrammes"
            runat="server"
            Text="0">
        </asp:Label>
    </p>
</div>

    </div>

    <br />

    <div class="glass-card"
        style="padding:30px; border-radius:24px;">

        <h2>Quick Actions</h2>

        <br />

        <div style="display:flex; gap:20px; flex-wrap:wrap;">

            <a href="/Management/Student/StudentManagement.aspx"
               class="primary-btn"
               style="text-decoration:none;">
                👨‍🎓 Add Student
            </a>

            <a href="/Admin/LecturerManagement.aspx"
               class="primary-btn"
               style="text-decoration:none;">
               👨‍🏫 Add Lecturer
            </a>

            <a href="/Admin/CourseManagement.aspx"
               class="primary-btn"
               style="text-decoration:none;">
                📚 Add Course
            </a>

        </div>

    </div>

    <br />

    <div class="glass-card"
        style="padding:30px; border-radius:24px;">

        <div style="display:flex; gap:20px; margin-top:30px; align-items:flex-start;">

            <div class="glass-card"
     style="flex:1; padding:30px;">

    <h2 style="margin-bottom:20px;">
        Upcoming Events
    </h2>

    <ul style="line-height:2;">
        <li>📅 Semester Registration - 14 Jun 2026</li>
        <li>📅 Midterm Examination - 15 Jul 2026</li>
        <li>📅 Project Submission - 20 Aug 2026</li>
        <li>📅 Final Examination - 10 Sep 2026</li>
    </ul>

</div>

    <!-- Latest Announcements -->

    <div class="glass-card"
         style="flex:1; padding:30px;">

        <h2 style="margin-bottom:20px;">
            Latest Announcements
        </h2>

        <ul style="line-height:2;">
            <li>Semester Registration Open</li>
            <li>Midterm Examination Schedule Released</li>
            <li>Course Registration Deadline Updated</li>
            <li>Attendance Monitoring Active</li>
        </ul>

    </div>

    <!-- Academic Calendar -->

       

<div class="glass-card"
     style="flex:1; padding:30px;">

    <h2 style="margin-bottom:20px;">
        Academic Calendar
    </h2>

     <p style="
    color:#64748b;
    margin-bottom:15px;">
        View important academic dates and examination schedules.
    </p>

    <asp:Calendar ID="Calendar1"
        runat="server"
        OnDayRender="Calendar1_DayRender">


        <TodayDayStyle
            BackColor="#10b981"
            ForeColor="White" />

    </asp:Calendar>

    <!-- Calendar Legend -->

    <div style="margin-top:15px; display:flex; gap:15px; flex-wrap:wrap;">

        <span>
            <span style="
                display:inline-block;
                width:15px;
                height:15px;
                background:#10b981;
                border-radius:50%;
                margin-right:5px;">
            </span>
            Today
        </span>

        <span>
            <span style="
                display:inline-block;
                width:15px;
                height:15px;
                background:#6366f1;
                border-radius:50%;
                margin-right:5px;">
            </span>
            Registration
        </span>

        <span>
            <span style="
                display:inline-block;
                width:15px;
                height:15px;
                background:orange;
                border-radius:50%;
                margin-right:5px;">
            </span>
            Midterm Exam
        </span>

        <span>
            <span style="
                display:inline-block;
                width:15px;
                height:15px;
                background:mediumpurple;
                border-radius:50%;
                margin-right:5px;">
            </span>
            Project Submission
        </span>

        <span>
            <span style="
                display:inline-block;
                width:15px;
                height:15px;
                background:red;
                border-radius:50%;
                margin-right:5px;">
            </span>
            Final Exam
        </span>

    </div>

</div>

    </div>

</div>
        </ul>

    </div>

</asp:Content>