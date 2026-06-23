<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="LecturerDashboard.aspx.cs"
Inherits="SIMS.Lecturer.LecturerDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Lecturer Dashboard – SIMS</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<style>
  :root {
    --purple:       #6c4ef2;
    --purple-mid:   #7c5cf5;
    --purple-light: #a78bfa;
    --purple-pale:  #ede9fe;
    --sidebar-bg:   #5b3ee8;
    --sidebar-dark: #4a30cc;
    --white:        #ffffff;
    --bg:           #f4f5fb;
    --text:         #1e1b3a;
    --muted:        #7b7898;
    --border:       #e8e5f5;
    --card-shadow:  0 4px 24px rgba(108,78,242,.10);
    --radius:       16px;
  }
  *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
  body {
    font-family:'DM Sans', sans-serif;
    background: var(--bg);
    color: var(--text);
    display: flex;
    min-height: 100vh;
  }
  .sidebar {
    width: 230px;
    min-height: 100vh;
    background: linear-gradient(175deg, var(--sidebar-bg) 0%, var(--sidebar-dark) 100%);
    display: flex;
    flex-direction: column;
    padding: 28px 18px;
    position: fixed;
    top: 0; left: 0; bottom: 0;
    z-index: 100;
  }
  .sidebar-logo {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 36px;
  }
  .sidebar-logo .logo-icon {
    width: 42px; height: 42px;
    background: rgba(255,255,255,.18);
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 20px; color: #fff;
  }
  .sidebar-logo .logo-text h2 { color:#fff; font-size:18px; font-weight:700; line-height:1; }
  .sidebar-logo .logo-text p  { color:rgba(255,255,255,.6); font-size:11px; margin-top:2px; }
  .nav-label {
    font-size:10px; font-weight:600; letter-spacing:.1em;
    text-transform:uppercase; color:rgba(255,255,255,.45);
    padding:0 10px; margin:18px 0 8px;
  }
  .nav-item {
    display:flex; align-items:center; gap:12px;
    padding:11px 14px; border-radius:12px;
    color:rgba(255,255,255,.75); font-size:14px; font-weight:500;
    cursor:pointer; text-decoration:none; margin-bottom:3px;
    transition: background .2s, color .2s;
  }
  .nav-item i { width:18px; text-align:center; font-size:15px; }
  .nav-item:hover, .nav-item.active { background:rgba(255,255,255,.18); color:#fff; }
  .sidebar-footer {
    margin-top:auto; background:rgba(255,255,255,.12);
    border-radius:14px; padding:14px;
    display:flex; align-items:center; gap:12px;
  }
  .avatar-circle {
    width:38px; height:38px; border-radius:50%;
    background:rgba(255,255,255,.25); color:#fff;
    font-weight:700; font-size:16px;
    display:flex; align-items:center; justify-content:center; flex-shrink:0;
  }
  .sidebar-footer .user-info h4 { color:#fff; font-size:13px; font-weight:600; }
  .sidebar-footer .user-info p  { color:rgba(255,255,255,.6); font-size:11px; }
  .sidebar-footer .chevron { margin-left:auto; color:rgba(255,255,255,.5); font-size:12px; }
  .main { margin-left:230px; flex:1; padding:32px 36px; }
  .topbar { display:flex; align-items:center; justify-content:space-between; margin-bottom:28px; }
  .topbar h1 { font-size:26px; font-weight:700; }
  .topbar p  { font-size:13px; color:var(--muted); margin-top:2px; }
  .topbar-right { display:flex; align-items:center; gap:14px; }
  .icon-btn {
    width:40px; height:40px; background:var(--white);
    border:1px solid var(--border); border-radius:12px;
    display:flex; align-items:center; justify-content:center;
    cursor:pointer; color:var(--muted); font-size:15px;
  }
  .top-avatar {
    width:40px; height:40px; border-radius:50%;
    background:linear-gradient(135deg,var(--purple),var(--purple-light));
    color:#fff; font-weight:700; font-size:16px;
    display:flex; align-items:center; justify-content:center;
  }
  .hero {
    background:linear-gradient(130deg,#6c4ef2 0%,#8b6cf9 55%,#a78bfa 100%);
    border-radius:22px; padding:36px 40px;
    position:relative; overflow:hidden; color:#fff;
    margin-bottom:28px; display:flex;
    align-items:center; justify-content:space-between;
    box-shadow:0 12px 40px rgba(108,78,242,.30);
  }
  .hero::before {
    content:''; position:absolute;
    width:320px; height:320px; border-radius:50%;
    background:rgba(255,255,255,.07); top:-100px; right:-60px;
  }
  .hero::after {
    content:''; position:absolute;
    width:200px; height:200px; border-radius:50%;
    background:rgba(255,255,255,.07); bottom:-80px; right:120px;
  }
  .hero-text h2 { font-size:28px; font-weight:700; margin-bottom:8px; }
  .hero-text p  { font-size:14px; color:rgba(255,255,255,.8); }
  .hero-graphic {
    width:110px; height:90px; background:rgba(255,255,255,.12);
    border-radius:18px; display:flex; align-items:center;
    justify-content:center; font-size:42px;
    position:relative; z-index:1; flex-shrink:0;
  }
  .stats {
    display:grid; grid-template-columns:repeat(3,1fr);
    gap:20px; margin-bottom:32px;
  }
  .stat-card {
    background:var(--white); border-radius:var(--radius);
    padding:22px 24px; box-shadow:var(--card-shadow);
    display:flex; align-items:center; gap:18px;
    border-left:4px solid transparent;
    transition:transform .25s, box-shadow .25s;
  }
  .stat-card:nth-child(1){ border-color:#6c4ef2; }
  .stat-card:nth-child(2){ border-color:#38bdf8; }
  .stat-card:nth-child(3){ border-color:#34d399; }
  .stat-card:hover { transform:translateY(-4px); box-shadow:0 10px 32px rgba(108,78,242,.15); }
  .stat-icon {
    width:52px; height:52px; border-radius:14px;
    display:flex; align-items:center; justify-content:center;
    font-size:20px; flex-shrink:0;
  }
  .stat-card:nth-child(1) .stat-icon { background:#ede9fe; color:#6c4ef2; }
  .stat-card:nth-child(2) .stat-icon { background:#e0f2fe; color:#0ea5e9; }
  .stat-card:nth-child(3) .stat-icon { background:#d1fae5; color:#10b981; }
  .stat-info h2    { font-size:30px; font-weight:700; line-height:1; }
  .stat-info .label{ font-size:13px; color:var(--muted); margin-top:3px; font-weight:500; }
  .stat-info .sub  { font-size:11px; color:var(--muted); margin-top:2px; }
  .section-title   { font-size:17px; font-weight:700; margin-bottom:18px; }
  .grid {
    display:grid; grid-template-columns:repeat(3,1fr); gap:20px;
  }
  .card {
    background:var(--white); border-radius:var(--radius);
    padding:26px 24px 22px; box-shadow:var(--card-shadow);
    display:flex; flex-direction:column;
    border:1px solid var(--border);
    transition:transform .25s, box-shadow .25s;
  }
  .card:hover { transform:translateY(-5px); box-shadow:0 12px 36px rgba(108,78,242,.15); }
  .card-header {
    display:flex; align-items:flex-start;
    justify-content:space-between; margin-bottom:14px;
  }
  .card-icon {
    width:50px; height:50px; background:var(--purple-pale);
    border-radius:14px; display:flex; align-items:center;
    justify-content:center; font-size:20px; color:var(--purple);
    transition:background .25s, color .25s;
  }
  .card:hover .card-icon {
    background:linear-gradient(135deg,var(--purple),var(--purple-light));
    color:#fff;
  }
  .card-arrow { color:var(--muted); font-size:13px; }
  .card h3 { font-size:16px; font-weight:700; margin-bottom:6px; }
  .card p  { font-size:13px; color:var(--muted); line-height:1.6; flex:1; margin-bottom:18px; }
  .dash-btn {
    display:inline-block; padding:10px 22px;
    background:linear-gradient(135deg,var(--purple),var(--purple-mid));
    color:#fff; border:none; border-radius:10px;
    font-family:'DM Sans',sans-serif; font-size:13px; font-weight:600;
    cursor:pointer; align-self:flex-start;
    box-shadow:0 4px 14px rgba(108,78,242,.35);
    transition:transform .2s, box-shadow .2s;
  }
  .dash-btn:hover { transform:scale(1.04); box-shadow:0 6px 20px rgba(108,78,242,.45); }
  @keyframes fadeUp {
    from { opacity:0; transform:translateY(20px); }
    to   { opacity:1; transform:translateY(0); }
  }
  .hero  { animation:fadeUp .5s ease both; }
  .stats { animation:fadeUp .55s .1s ease both; }
  .grid  { animation:fadeUp .55s .2s ease both; }
</style>
</head>
<body>

<form id="form1" runat="server">

<!-- SIDEBAR -->
<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon"><i class="fa-solid fa-graduation-cap"></i></div>
    <div class="logo-text">
      <h2>SIMS</h2>
      <p>Lecturer Panel</p>
    </div>
  </div>
  <span class="nav-label">Main</span>
  <a href="LecturerDashboard.aspx" class="nav-item active">
    <i class="fa-solid fa-gauge-high"></i> Dashboard
  </a>
  <a href="ManageAttendance.aspx" class="nav-item">
    <i class="fa-solid fa-calendar-check"></i> Attendance
  </a>
  <a href="ManageMarks.aspx" class="nav-item">
    <i class="fa-solid fa-chart-column"></i> Marks
  </a>
  <a href="ViewStudents.aspx" class="nav-item">
    <i class="fa-solid fa-user-graduate"></i> Students
  </a>
  <span class="nav-label">Account</span>
  <a href="ManageProfile.aspx" class="nav-item">
    <i class="fa-solid fa-user-pen"></i> Profile
  </a>
  <div class="sidebar-footer">
    <div class="avatar-circle">L</div>
    <div class="user-info">
      <h4>Lecturer</h4>
      <p>Welcome Back!</p>
    </div>
    <i class="fa-solid fa-chevron-right chevron"></i>
  </div>
</aside>

<!-- MAIN -->
<main class="main">

  <div class="topbar">
    <div>
      <h1>Dashboard</h1>
      <p>Welcome back to SIMS</p>
    </div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="icon-btn"><i class="fa-solid fa-magnifying-glass"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-text">
      <h2>Welcome Back, Lecturer! 👋</h2>
      <p>Manage attendance, marks, students and profile easily.</p>
    </div>
    <div class="hero-graphic">
      <i class="fa-solid fa-chart-pie"></i>
    </div>
  </div>

  <div class="stats">
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
      <div class="stat-info">
        <h2>25</h2>
        <div class="label">Total Students</div>
        <div class="sub">Active students in your courses</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
      <div class="stat-info">
        <h2>120</h2>
        <div class="label">Attendance Records</div>
        <div class="sub">Total attendance entries</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-clipboard-list"></i></div>
      <div class="stat-info">
        <h2>85</h2>
        <div class="label">Marks Records</div>
        <div class="sub">Total marks entries</div>
      </div>
    </div>
  </div>

  <div class="section-title">Quick Access</div>
  <div class="grid">

    <div class="card">
      <div class="card-header">
        <div class="card-icon"><i class="fa-solid fa-calendar-check"></i></div>
        <i class="fa-solid fa-chevron-right card-arrow"></i>
      </div>
      <h3>Attendance</h3>
      <p>Manage and track student attendance records.</p>
      <asp:Button ID="btnAttendance" runat="server" Text="Open Attendance"
          CssClass="dash-btn" OnClick="btnAttendance_Click" />
    </div>

    <div class="card">
      <div class="card-header">
        <div class="card-icon"><i class="fa-solid fa-chart-column"></i></div>
        <i class="fa-solid fa-chevron-right card-arrow"></i>
      </div>
      <h3>Marks</h3>
      <p>Update and manage student marks and grades.</p>
      <asp:Button ID="btnMarks" runat="server" Text="Open Marks"
          CssClass="dash-btn" OnClick="btnMarks_Click" />
    </div>

    <div class="card">
      <div class="card-header">
        <div class="card-icon"><i class="fa-solid fa-user-graduate"></i></div>
        <i class="fa-solid fa-chevron-right card-arrow"></i>
      </div>
      <h3>Students</h3>
      <p>View and manage student information easily.</p>
      <asp:Button ID="btnStudents" runat="server" Text="View Students"
          CssClass="dash-btn" OnClick="btnStudents_Click" />
    </div>

    <div class="card">
      <div class="card-header">
        <div class="card-icon"><i class="fa-solid fa-user-pen"></i></div>
        <i class="fa-solid fa-chevron-right card-arrow"></i>
      </div>
      <h3>Profile</h3>
      <p>Update your profile and account settings.</p>
      <asp:Button ID="btnProfile" runat="server" Text="Manage Profile"
          CssClass="dash-btn" OnClick="btnProfile_Click" />
    </div>

    <div class="card">
      <div class="card-header">
        <div class="card-icon"><i class="fa-solid fa-book"></i></div>
        <i class="fa-solid fa-chevron-right card-arrow"></i>
      </div>
      <h3>Assigned Courses</h3>
      <p>View assigned courses and registered students.</p>
      <asp:Button ID="btnCourses" runat="server" Text="View Courses"
          CssClass="dash-btn" OnClick="btnCourses_Click" />
    </div>

    <div class="card">
      <div class="card-header">
        <div class="card-icon"><i class="fa-solid fa-bullhorn"></i></div>
        <i class="fa-solid fa-chevron-right card-arrow"></i>
      </div>
      <h3>Announcements</h3>
      <p>Post announcements and important updates.</p>
      <asp:Button ID="btnAnnouncement" runat="server" Text="View Announcements"
          CssClass="dash-btn" OnClick="btnAnnouncement_Click" />
    </div>

  </div>
</main>

</form>
</body>
</html>