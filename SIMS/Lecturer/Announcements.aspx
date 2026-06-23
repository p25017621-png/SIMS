cat > /mnt/user-data/outputs/Announcements.aspx << 'EOF'
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="SIMS.Lecturer.Announcements" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Announcements – SIMS</title>
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
.nav-item i{width:18px;text-align:center;font-size:15px;}
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
.layout{display:grid;grid-template-columns:1fr 380px;gap:24px;}
.form-card{background:var(--white);border-radius:var(--radius);padding:28px;box-shadow:var(--card-shadow);border:1px solid var(--border);height:fit-content;}
.form-card h3{font-size:16px;font-weight:700;margin-bottom:20px;padding-bottom:14px;border-bottom:1px solid var(--border);}
.form-group{display:flex;flex-direction:column;gap:6px;margin-bottom:16px;}
.form-group label{font-size:13px;font-weight:600;color:var(--text);}
.form-group input,.form-group select,.form-group textarea{padding:11px 14px;border:1.5px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;color:var(--text);background:var(--bg);transition:border .2s;outline:none;}
.form-group input:focus,.form-group select:focus,.form-group textarea:focus{border-color:var(--purple);background:#fff;}
.form-group textarea{resize:vertical;min-height:120px;}
.btn-row{display:flex;gap:12px;margin-top:8px;}
.dash-btn{padding:11px 26px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(108,78,242,.35);transition:transform .2s;}
.dash-btn:hover{transform:scale(1.04);}
.btn-outline{padding:11px 26px;background:transparent;color:var(--purple);border:1.5px solid var(--purple);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;cursor:pointer;}
.btn-outline:hover{background:var(--purple-pale);}
.list-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;}
.list-header{padding:18px 20px;border-bottom:1px solid var(--border);}
.list-header h3{font-size:15px;font-weight:700;}
.ann-item{padding:16px 20px;border-bottom:1px solid var(--border);transition:background .2s;}
.ann-item:hover{background:#faf9ff;}
.ann-item:last-child{border-bottom:none;}
.ann-top{display:flex;align-items:flex-start;justify-content:space-between;gap:10px;margin-bottom:6px;}
.ann-title{font-size:14px;font-weight:600;color:var(--text);}
.ann-meta{font-size:11px;color:var(--muted);margin-bottom:6px;}
.ann-body{font-size:13px;color:var(--muted);line-height:1.5;}
.badge{display:inline-block;padding:2px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-all{background:var(--purple-pale);color:var(--purple);}
.badge-course{background:#e0f2fe;color:#0ea5e9;}
.ann-actions{display:flex;gap:8px;margin-top:8px;}
.btn-del{background:#fee2e2;color:#dc2626;border:none;padding:5px 12px;border-radius:8px;font-size:12px;font-weight:600;cursor:pointer;}
.btn-edit{background:var(--purple-pale);color:var(--purple);border:none;padding:5px 12px;border-radius:8px;font-size:12px;font-weight:600;cursor:pointer;}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
.hero{animation:fadeUp .5s ease both;}.layout{animation:fadeUp .5s .1s ease both;}
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
  <span class="nav-label">Account</span>
  <a href="ManageProfile.aspx" class="nav-item"><i class="fa-solid fa-user-pen"></i> Profile</a>
  <div class="sidebar-footer">
    <div class="avatar-circle">L</div>
    <div class="user-info"><h4>Lecturer</h4><p>Welcome Back!</p></div>
    <i class="fa-solid fa-chevron-right" style="margin-left:auto;color:rgba(255,255,255,.5);font-size:12px;"></i>
  </div>
</aside>
<main class="main">
  <div class="topbar">
    <div><h1>Announcements</h1><p>Post and manage announcements for your students</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>
  <div class="hero">
    <div class="hero-text">
      <h2>Announcements 📢</h2>
      <p>Post important updates and course materials to students.</p>
    </div>
    <div class="hero-graphic"><i class="fa-solid fa-bullhorn"></i></div>
  </div>
  <div class="layout">
    <!-- Post Form -->
    <div class="form-card">
      <h3>📝 Post New Announcement</h3>
      <div class="form-group">
        <label>Title</label>
        <asp:TextBox ID="txtTitle" runat="server" placeholder="Announcement title..." style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;outline:none;"/>
      </div>
      <div class="form-group">
        <label>Target Audience</label>
        <asp:DropDownList ID="ddlTarget" runat="server" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;outline:none;">
          <asp:ListItem Text="All Students" Value="ALL"/>
          <asp:ListItem Text="Web Programming (WEB3013)" Value="WEB3013"/>
          <asp:ListItem Text="Database Systems (DBS2023)" Value="DBS2023"/>
          <asp:ListItem Text="Software Engineering (SWE3033)" Value="SWE3033"/>
        </asp:DropDownList>
      </div>
      <div class="form-group">
        <label>Type</label>
        <asp:DropDownList ID="ddlType" runat="server" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;outline:none;">
          <asp:ListItem Text="General Announcement" Value="general"/>
          <asp:ListItem Text="Assignment" Value="assignment"/>
          <asp:ListItem Text="Course Material" Value="material"/>
          <asp:ListItem Text="Exam Notice" Value="exam"/>
        </asp:DropDownList>
      </div>
      <div class="form-group">
        <label>Message</label>
        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" placeholder="Write your announcement here..." style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;min-height:120px;resize:vertical;outline:none;"/>
      </div>
      <div class="btn-row">
        <asp:Button ID="btnPost" runat="server" Text="📢 Post Announcement" CssClass="dash-btn" OnClick="btnPost_Click"/>
        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-outline" OnClick="btnClear_Click"/>
      </div>
      <asp:Label ID="lblMessage" runat="server" style="display:block;margin-top:12px;font-size:13px;color:#059669;font-weight:600;"/>
    </div>
    <!-- Announcements List -->
    <div class="list-card">
      <div class="list-header"><h3>📋 Recent Announcements</h3></div>
      <div class="ann-item">
        <div class="ann-top">
          <div class="ann-title">Midterm Exam Schedule</div>
          <span class="badge badge-all">All</span>
        </div>
        <div class="ann-meta"><i class="fa-regular fa-clock"></i> 2 hours ago · Exam Notice</div>
        <div class="ann-body">Midterm exam will be held on 15 June 2026 at 9:00 AM in Hall A.</div>
        <div class="ann-actions">
          <button type="button" class="btn-edit"><i class="fa-solid fa-pen"></i> Edit</button>
          <button type="button" class="btn-del"><i class="fa-solid fa-trash"></i> Delete</button>
        </div>
      </div>
      <div class="ann-item">
        <div class="ann-top">
          <div class="ann-title">Assignment 2 Submission</div>
          <span class="badge badge-course">WEB3013</span>
        </div>
        <div class="ann-meta"><i class="fa-regular fa-clock"></i> Yesterday · Assignment</div>
        <div class="ann-body">Please submit Assignment 2 via the student portal before 11:59 PM on 10 June.</div>
        <div class="ann-actions">
          <button type="button" class="btn-edit"><i class="fa-solid fa-pen"></i> Edit</button>
          <button type="button" class="btn-del"><i class="fa-solid fa-trash"></i> Delete</button>
        </div>
      </div>
      <div class="ann-item">
        <div class="ann-top">
          <div class="ann-title">Class Rescheduled</div>
          <span class="badge badge-course">DBS2023</span>
        </div>
        <div class="ann-meta"><i class="fa-regular fa-clock"></i> 3 days ago · General</div>
        <div class="ann-body">This week's Database Systems class is moved to Thursday 2PM, same room.</div>
        <div class="ann-actions">
          <button type="button" class="btn-edit"><i class="fa-solid fa-pen"></i> Edit</button>
          <button type="button" class="btn-del"><i class="fa-solid fa-trash"></i> Delete</button>
        </div>
      </div>
    </div>
  </div>
</main>
</form>
</body>
</html>
EOF