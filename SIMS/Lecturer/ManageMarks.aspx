<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageMarks.aspx.cs" Inherits="SIMS.Lecturer.ManageMarks" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Manage Marks – SIMS</title>
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
.filter-card{background:var(--white);border-radius:var(--radius);padding:22px 24px;box-shadow:var(--card-shadow);border:1px solid var(--border);margin-bottom:24px;display:flex;gap:16px;align-items:flex-end;flex-wrap:wrap;}
.filter-group{display:flex;flex-direction:column;gap:6px;}
.filter-group label{font-size:12px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
.filter-group select,.filter-group input{padding:10px 14px;border:1.5px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;color:var(--text);background:var(--bg);outline:none;min-width:160px;}
.filter-group select:focus{border-color:var(--purple);background:#fff;}
.dash-btn{padding:10px 22px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(108,78,242,.35);transition:transform .2s;}
.dash-btn:hover{transform:scale(1.04);}
.btn-publish{padding:10px 22px;background:linear-gradient(135deg,#10b981,#34d399);color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(16,185,129,.35);}
.table-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;}
.table-header{padding:20px 24px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid var(--border);}
.table-header h3{font-size:15px;font-weight:700;}
.btn-row{display:flex;gap:10px;}
table{width:100%;border-collapse:collapse;}
thead tr{background:var(--bg);}
th{padding:13px 20px;text-align:left;font-size:12px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
td{padding:10px 20px;font-size:14px;border-top:1px solid var(--border);}
tr:hover td{background:#faf9ff;}
.mark-input{width:70px;padding:7px 10px;border:1.5px solid var(--border);border-radius:8px;font-family:'DM Sans',sans-serif;font-size:14px;text-align:center;color:var(--text);background:var(--bg);}
.mark-input:focus{outline:none;border-color:var(--purple);background:#fff;}
.grade{font-weight:700;font-size:13px;}
.grade-a{color:#059669;} .grade-b{color:#0ea5e9;} .grade-c{color:#d97706;} .grade-f{color:#dc2626;}
.badge{display:inline-block;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-published{background:#d1fae5;color:#059669;}
.badge-draft{background:#fef3c7;color:#d97706;}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
.hero{animation:fadeUp .5s ease both;} .filter-card{animation:fadeUp .5s .1s ease both;} .table-card{animation:fadeUp .5s .2s ease both;}
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
  <a href="ManageMarks.aspx" class="nav-item active"><i class="fa-solid fa-chart-column"></i> Marks</a>
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
    <div><h1>Manage Marks</h1><p>Enter, update and publish student grades</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>
  <div class="hero">
    <div class="hero-text">
      <h2>Assessment Marks 📊</h2>
      <p>Enter, update and publish marks for your students.</p>
    </div>
    <div class="hero-graphic"><i class="fa-solid fa-chart-column"></i></div>
  </div>
  <div class="filter-card">
    <div class="filter-group">
      <label>Course</label>
      <asp:DropDownList ID="ddlCourse" runat="server">
        <asp:ListItem Text="Web Programming (WEB3013)" Value="WEB3013"/>
        <asp:ListItem Text="Database Systems (DBS2023)" Value="DBS2023"/>
        <asp:ListItem Text="Software Engineering (SWE3033)" Value="SWE3033"/>
      </asp:DropDownList>
    </div>
    <div class="filter-group">
      <label>Assessment</label>
      <asp:DropDownList ID="ddlAssessment" runat="server">
        <asp:ListItem Text="Assignment 1" Value="A1"/>
        <asp:ListItem Text="Assignment 2" Value="A2"/>
        <asp:ListItem Text="Midterm Exam" Value="MID"/>
        <asp:ListItem Text="Final Exam" Value="FINAL"/>
      </asp:DropDownList>
    </div>
    <asp:Button ID="btnLoad" runat="server" Text="Load Marks" CssClass="dash-btn" OnClick="btnLoad_Click" />
  </div>
  <div class="table-card">
    <div class="table-header">
      <h3>Student Marks</h3>
      <div class="btn-row">
        <asp:Button ID="btnSave" runat="server" Text="💾 Save Marks" CssClass="dash-btn" OnClick="btnSave_Click" />
        <asp:Button ID="btnPublish" runat="server" Text="✅ Publish" CssClass="btn-publish" OnClick="btnPublish_Click" />
      </div>
    </div>
    <table>
      <thead>
        <tr>
          <th>No.</th>
          <th>Student ID</th>
          <th>Student Name</th>
          <th>Marks (/ 100)</th>
          <th>Grade</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td><td>S001</td><td>Ahmad Bin Ali</td>
          <td><input type="number" class="mark-input" value="85" min="0" max="100" onchange="updateGrade(this)"/></td>
          <td><span class="grade grade-a">A</span></td>
          <td><span class="badge badge-published">Published</span></td>
        </tr>
        <tr>
          <td>2</td><td>S002</td><td>Siti Binti Hassan</td>
          <td><input type="number" class="mark-input" value="72" min="0" max="100" onchange="updateGrade(this)"/></td>
          <td><span class="grade grade-b">B</span></td>
          <td><span class="badge badge-draft">Draft</span></td>
        </tr>
        <tr>
          <td>3</td><td>S003</td><td>Raj Kumar</td>
          <td><input type="number" class="mark-input" value="91" min="0" max="100" onchange="updateGrade(this)"/></td>
          <td><span class="grade grade-a">A</span></td>
          <td><span class="badge badge-published">Published</span></td>
        </tr>
        <tr>
          <td>4</td><td>S004</td><td>Lim Wei Ming</td>
          <td><input type="number" class="mark-input" value="55" min="0" max="100" onchange="updateGrade(this)"/></td>
          <td><span class="grade grade-c">C</span></td>
          <td><span class="badge badge-draft">Draft</span></td>
        </tr>
      </tbody>
    </table>
  </div>
</main>
</form>
<script>
function updateGrade(input) {
  var val = parseInt(input.value);
  var row = input.closest('tr');
  var gradeEl = row.querySelector('.grade');
  var g = val >= 80 ? 'A' : val >= 70 ? 'B' : val >= 60 ? 'C' : val >= 50 ? 'D' : 'F';
  var cls = val >= 80 ? 'grade-a' : val >= 70 ? 'grade-b' : val >= 60 ? 'grade-c' : 'grade-f';
  gradeEl.textContent = g;
  gradeEl.className = 'grade ' + cls;
}
</script>
</body>
</html>