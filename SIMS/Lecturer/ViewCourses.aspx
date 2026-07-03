<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCourses.aspx.cs" Inherits="SIMS.Lecturer.ViewCourses" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<title>View Courses – SIMS</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<style>
:root{--purple:#6c4ef2;--purple-mid:#7c5cf5;--purple-light:#a78bfa;--purple-pale:#ede9fe;--sidebar-bg:#5b3ee8;--sidebar-dark:#4a30cc;--white:#ffffff;--bg:#f4f5fb;--text:#1e1b3a;--muted:#7b7898;--border:#e8e5f5;--card-shadow:0 4px 24px rgba(108,78,242,.10);--radius:16px;}
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text);display:flex;min-height:100vh;}
.sidebar{width:230px;min-height:100vh;background:linear-gradient(175deg,var(--sidebar-bg) 0%,var(--sidebar-dark) 100%);display:flex;flex-direction:column;padding:28px 18px;position:fixed;top:0;left:0;bottom:0;z-index:100;}
.sidebar-logo{display:flex;align-items:center;gap:12px;margin-bottom:36px;}
.logo-icon{width:42px;height:42px;background:rgba(255,255,255,.18);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;color:#fff;}
.logo-text h2{color:#fff;font-size:18px;font-weight:700;line-height:1;}
.logo-text p{color:rgba(255,255,255,.6);font-size:11px;margin-top:2px;}
.nav-label{font-size:10px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:rgba(255,255,255,.45);padding:0 10px;margin:18px 0 8px;}
.nav-item{display:flex;align-items:center;gap:12px;padding:11px 14px;border-radius:12px;color:rgba(255,255,255,.75);font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;margin-bottom:3px;transition:background .2s,color .2s;}
.nav-item i{width:18px;text-align:center;}
.nav-item:hover,.nav-item.active{background:rgba(255,255,255,.18);color:#fff;}
.sidebar-footer{margin-top:auto;background:rgba(255,255,255,.12);border-radius:14px;padding:14px;display:flex;align-items:center;gap:12px;}
.avatar-circle{width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,.25);color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.sidebar-footer .user-info h4{color:#fff;font-size:13px;font-weight:600;}
.sidebar-footer .user-info p{color:rgba(255,255,255,.6);font-size:11px;}
.main{margin-left:230px;flex:1;padding:32px 36px;}
.topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:28px;}
.topbar h1{font-size:26px;font-weight:700;}
.topbar p{font-size:13px;color:var(--muted);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:14px;}
.icon-btn{width:40px;height:40px;background:var(--white);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;justify-content:center;cursor:pointer;color:var(--muted);font-size:15px;}
.top-avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;}
.hero{background:linear-gradient(130deg,#6c4ef2 0%,#8b6cf9 55%,#a78bfa 100%);border-radius:22px;padding:36px 40px;position:relative;overflow:hidden;color:#fff;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 12px 40px rgba(108,78,242,.30);}
.hero::before{content:'';position:absolute;width:320px;height:320px;border-radius:50%;background:rgba(255,255,255,.07);top:-100px;right:-60px;}
.hero-text h2{font-size:28px;font-weight:700;margin-bottom:8px;}
.hero-text p{font-size:14px;color:rgba(255,255,255,.8);}
.hero-graphic{width:90px;height:90px;background:rgba(255,255,255,.12);border-radius:18px;display:flex;align-items:center;justify-content:center;font-size:38px;position:relative;z-index:1;flex-shrink:0;}
.section-title{font-size:17px;font-weight:700;margin-bottom:18px;}
.courses-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-bottom:32px;}
.course-card{background:var(--white);border-radius:var(--radius);padding:24px;box-shadow:var(--card-shadow);border:1px solid var(--border);transition:transform .25s;}
.course-card:hover{transform:translateY(-5px);}
.course-badge{display:inline-block;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:600;margin-bottom:14px;background:var(--purple-pale);color:var(--purple);}
.course-card h3{font-size:16px;font-weight:700;margin-bottom:4px;}
.course-card .code{font-size:12px;color:var(--muted);margin-bottom:14px;}
.course-meta{display:flex;justify-content:space-between;padding-top:14px;border-top:1px solid var(--border);}
.course-meta span{font-size:12px;color:var(--muted);display:flex;align-items:center;gap:5px;}
.course-meta span i{color:var(--purple);}
.table-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;}
.table-header{padding:20px 24px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid var(--border);}
.table-header h3{font-size:15px;font-weight:700;}
.search-box{display:flex;align-items:center;gap:10px;background:var(--bg);border:1.5px solid var(--border);border-radius:10px;padding:8px 14px;}
.search-box input{border:none;background:transparent;font-family:'DM Sans',sans-serif;font-size:13px;color:var(--text);outline:none;width:180px;}
.search-box i{color:var(--muted);font-size:13px;}
table{width:100%;border-collapse:collapse;}
thead tr{background:var(--bg);}
th{padding:13px 20px;text-align:left;font-size:12px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
td{padding:14px 20px;font-size:14px;border-top:1px solid var(--border);}
tr:hover td{background:#faf9ff;}
.badge{display:inline-block;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-active{background:#d1fae5;color:#059669;}
.badge-inactive{background:#fee2e2;color:#dc2626;}
</style>
</head>
<body>
<form id="form1" runat="server">
<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon"><i class="fa-solid fa-graduation-cap"></i></div>
    <div class="logo-text"><h2>SIMS</h2><p>Lecturer Panel</p></div>
  </div>
  <span class="nav-label">Main</span>
  <a href="LecturerDashboard.aspx" class="nav-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
  <a href="ManageAttendance.aspx" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Attendance</a>
  <a href="ManageMarks.aspx" class="nav-item"><i class="fa-solid fa-chart-column"></i> Marks</a>
  <a href="ViewStudents.aspx" class="nav-item"><i class="fa-solid fa-user-graduate"></i> Students</a>
  <a href="ViewCourses.aspx" class="nav-item active"><i class="fa-solid fa-book"></i> Courses</a>
  <a href="Announcements.aspx" class="nav-item"><i class="fa-solid fa-bullhorn"></i> Announcements</a>
  <span class="nav-label">Account</span>
  <a href="ManageProfile.aspx" class="nav-item"><i class="fa-solid fa-user-pen"></i> Profile</a>
  <div class="sidebar-footer">
    <div class="avatar-circle">L</div>
    <div class="user-info"><h4>Lecturer</h4><p>Welcome Back!</p></div>
  </div>
</aside>
<main class="main">
  <div class="topbar">
    <div><h1>Assigned Courses</h1><p>View your courses and registered students</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>
  <div class="hero">
    <div class="hero-text"><h2>Your Courses 📚</h2><p>View all assigned courses and student registrations.</p></div>
    <div class="hero-graphic"><i class="fa-solid fa-book"></i></div>
  </div>
  <div class="section-title">Assigned Courses</div>
  <div class="courses-grid">
    <asp:Repeater ID="rptCourses" runat="server">
      <ItemTemplate>
        <div class="course-card">
          <div class="course-badge">Semester <%# Eval("Semester") %></div>
          <h3><%# Eval("courseName") %></h3>
          <div class="code"><%# Eval("courseCode") %> · <%# Eval("CreditHours") %> Credit Hours</div>
          <div class="course-meta">
            <span><i class="fa-solid fa-users"></i> <%# Eval("StudentCount") %> Students</span>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
  <div class="section-title">Registered Students</div>
  <div class="table-card">
    <div class="table-header">
      <h3>Student List</h3>
      <div class="search-box">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" id="searchInput" placeholder="Search student..." onkeyup="searchTable()"/>
      </div>
    </div>
    <table id="studentTable">
      <thead>
        <tr><th>Name</th><th>Course</th><th>Program</th><th>Status</th></tr>
      </thead>
      <tbody>
        <asp:Repeater ID="rptStudents" runat="server">
          <ItemTemplate>
            <tr>
              <td><%# Eval("Name") %></td>
              <td><%# Eval("Course") %></td>
              <td><%# Eval("Program") %></td>
              <td><span class="badge <%# Eval("StatusClass") %>"><%# Eval("Status") %></span></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </tbody>
    </table>
  </div>
</main>
</form>
<script>
function searchTable(){
  var val=document.getElementById('searchInput').value.toLowerCase();
  document.querySelectorAll('#studentTable tbody tr').forEach(function(r){
    r.style.display=r.innerText.toLowerCase().includes(val)?'':'none';
  });
}
</script>
</body>
</html>