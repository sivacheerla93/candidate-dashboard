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

	function getCandidatesData(sid, lid) {
		$.getJSON('/candidates/' + sid + "/" + lid, candidatesData);
	}

	function candidatesData(data) {
		if (data.length == 0) {
			$("#candidatesTBody").html("");
		} else {
			$("#candidatesTBody").html("");
			var tbody;
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
			$("#candidatesTBody").html(tbody);
			buildPagination();
		}
	}

	function getCandidateInfo(id) {
		$.getJSON("/candidates/" + id, singleCandidate);
	}

	function singleCandidate(data) {
		var skillName = '';
		var locationName = '';
		$.getJSON("/locations/" + data.locationId, function(result) {
			locationName = result.name;
			$.getJSON("/skills/" + data.skillId, function(result) {
				skillName = result.name;

				$("#candidateInfo").html("");
				var cData;
				cData = "Id: " + data.id + "<br />";
				cData = cData + "Name: " + data.name + "<br />";
				cData = cData + "Email: " + data.email + "<br />";
				cData = cData + "Location: " + locationName + "<br />";
				cData = cData + "Skills: " + skillName;

				$("#candidateInfo").append(cData);
			});
		});
	}

	function doFilter() {
		var selectedSkill = $("#skillsDD").val();
		var selectedLocation = $("#locationsDD").val();

		if (selectedSkill == "0" && selectedLocation == "0") {
			alert("No filter has been selected!");
			return;
		} else {
			getCandidatesData(selectedSkill, selectedLocation);
		}
	}

	function buildPagination() {
		var table = '#candidates';
		$('.pagination').html('');
		var trnum = 0;
		var maxRows = 5;
		var totalRows = $(table + ' tbody tr').length;

		$(table + ' tr:gt(0)').each(function() {
			trnum++
			if (trnum > maxRows) {
				$(this).hide()
			}
			if (trnum <= maxRows) {
				$(this).show()
			}
		})

		if (totalRows > maxRows) {
			var pagenum = Math.ceil(totalRows / maxRows)
			for (var i = 1; i <= pagenum;) {
				$('.pagination')
						.append(
								'<li data-page="'+i+'">\<span>'
										+ i++
										+ '<span class="sr-only">(current)</span></span>\</li>')
						.show()
			}
			$('.pagination li:first-child').addClass('active')
			$('.pagination li')
					.on(
							'click',
							function() {
								var pageNum = $(this).attr('data-page')
								var trIndex = 0;
								$('.pagination li').removeClass('active')
								$(this).addClass('active')
								$(table + ' tr:gt(0)')
										.each(
												function() {
													trIndex++
													if (trIndex > (maxRows * pageNum)
															|| trIndex <= ((maxRows * pageNum) - maxRows)) {
														$(this).hide()
													} else {
														$(this).show()
													}
												})
							})

		}
	}
</script>
</head>
<body onload="getDropDownsData(); getCandidatesData('0', '0');">
	<div class="container">
		<div class="row">
			<div class="col-sm-10">
				Skill: <select id="skillsDD">
					<option value="0">-- select --</option>
				</select> Location: <select id="locationsDD">
					<option value="0">-- select --</option>
				</select>
				<button onclick="doFilter();">Search Candidates</button>
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
					<tbody id="candidatesTBody">

					</tbody>
				</table>

				<div class="pagination-container">
					<nav>
					<ul class="pagination"></ul>
					</nav>
				</div>

			</div>
			<div class="col-sm-6" id="candidateInfo"></div>
		</div>
	</div>

</body>

</html>