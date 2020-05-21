<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Candidates Dashboard</title>
<link rel="stylesheet" href="bootstrap.min.css">
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
	function getDropDownsData() {
		$.getJSON('/skills', skillsData);
		$.getJSON('/locations', locationsData);
	}

	function skillsData(data) {
		$.each(data, function(index, d) {
			$("#skillsDD").append(
					"<option value = "+ d.id + ">" + d.name + "</option>");
		});
	}

	function locationsData(data) {
		$.each(data, function(index, d) {
			$("#locationsDD").append(
					"<option value = "+ d.id + ">" + d.name + "</option>");
		});
	}

	function getCandidatesData() {
		$.getJSON('/candidates', candidatesData);
	}

	function candidatesData(data) {
		var tbody = "<tbody>";

		$.each(data, function(index, d) {
			tbody = tbody + "<tr>";
			tbody = tbody + "<td><a href = '#' onclick = getCandidateInfo("
					+ d.id + ");>" + d.id + "</a></td>";
			tbody = tbody + "<td><a href = '#' onclick = getCandidateInfo("
					+ d.id + ");>" + d.name + "</a></td>";
			tbody = tbody + "<td><a href = '#' onclick = getCandidateInfo("
					+ d.id + ");>" + d.email + "</a></td>";
			tbody = tbody + "</tr>";
		});

		tbody = tbody + "</tbody>";

		$("#candidates").append(tbody);
	}

	function getCandidateInfo(id) {
		$.getJSON("/candidates/" + id, singleCandidate);
	}

	function singleCandidate(data) {
		$("#candidateInfo").html("");
		var cData;
		cData = "Id: " + data.id + "<br />";
		cData = cData + "Name: " + data.name + "<br />";
		cData = cData + "Email: " + data.email + "<br />";
		cData = cData + "Location: " + data.locationId + "<br />";
		cData = cData + "Skills: " + data.skillId;

		$("#candidateInfo").append(cData);
	}
</script>
</head>
<body onload="getDropDownsData(); getCandidatesData();">
	<div class="container">
		<div class="row">
			<div class="col-sm-10">
				Skill: <select id="skillsDD">
					<option value="0">-- select --</option>
				</select> Location: <select id="locationsDD">
					<option value="0">-- select --</option>
				</select>
				<button>Search Candidates</button>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-sm-6">
				<table id="candidates" border="1" width="100%">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
							<th>Email</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="col-sm-6" id="candidateInfo"></div>
		</div>
	</div>

</body>
</html>