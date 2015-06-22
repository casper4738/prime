function flyToPage(task) {
	var tmpForm = document.forms[0];
	tmpForm.task.value = task;
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function searchAll(task) {
	alert(task);
	var tmpForm = document.forms[0];
	tmpForm.columnSearch.value = "ALL";
	tmpForm.task.value = task;
	menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
}

function flyToEditDelete(task, value, confirmMessage) {
	var tmpForm = document.forms[0]; 
	
	if(confirmMessage != null){
		if(!confirm(confirmMessage))	
			return;
	}
	tmpForm.task.value = task;
	tmpForm.tmpId.value = value;
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function flyToForward(task, value) {
	var tmpForm = document.forms[0];
	
	tmpForm.task.value = task;
	tmpForm.message.value = value;
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function page(page) {
	var tmpForm = document.forms[0]; 
 
	if(page == -1) {
		tmpForm.goToPage.value = document.getElementById('page').value;
	} else {
		tmpForm.goToPage.value = page;			
	}
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function change(value) {
	document.forms[0].showInPage.value = value;
	menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
}

function validate() {
	return validateForm(document.forms[0]);
}

function isNumeric(n) {
	try {
		return !isNaN(n);
	}catch(Exception) {
		return false;		
	}
}

function menuLoadHandler(targettedMenu, targettedData){
	//##0. Show Loading [Hard Code the HTML Tag until Found Better Solution]
	$('#content-main').html("<div class=\"info-modal\">" +
				            "<div class=\"modal\">" +
				              "<div class=\"modal-dialog\">" +
				                "<div class=\"modal-content\">" +
				                  "<div class=\"modal-header\">" +
				                    "<h4 class=\"modal-title\" align=\"center\">Content Loading</h4>" +
				                  "</div>" +
				                  "<div class=\"modal-body\" align=\"center\">" +
				                    "<div class=\"overlay\">" +
					                  "<i class=\"fa fa-refresh fa-spin\"></i>" +
					                "</div>" +
				                  "</div>" +
				                  "<div class=\"modal-footer\">" +
				                  "</div>" +
				                "</div>" +
				              "</div>" +
				            "</div>" +
				          "</div>");
	
	//##1.Start AJAX-Load
	$('#content-main').load(targettedMenu, targettedData, function( response, status, xhr ) {
		//---.Show Some Respect For Error Status
		if(status == "error"){
			$('#content-main').html("<div class=\"box box-default\">" +
		                				"<div class=\"box-header with-border\">" +
		               	  				"<h1 align=\"center\"><b>Fail to fetch content</b></h1>" + 
	    			                  		"<div class=\"callout callout-danger\" align=\"center\">" + 
	    			                    		"<h4>Something wrong happened at here</h4>" + 
	    			                    		"<p>Please contact the developer for further assistance !!</p>" + 
	    			                  		"</div>" + 
	    			                	"</div>" + 
	    			              	  "</div>");
		}
	});
	
	//##2.Return False to just to disable ahref Event if Exists
	return false;
}

function modalLoadHandler(targettedData){
	//##0. Show Loading [Hard Code the HTML Tag until Found Better Solution]
    $('#content-modal-body').removeData('bs.modal')
	$('#content-modal-body').html("<div class=\"info-modal\">" +
						            "<div class=\"modal\">" +
						              "<div class=\"modal-dialog\">" +
						                "<div class=\"modal-content\">" +
						                  "<div class=\"modal-header\">" +
						                    "<h4 class=\"modal-title\" align=\"center\">Content Loading</h4>" +
						                  "</div>" +
						                  "<div class=\"modal-body\" align=\"center\">" +
						                    "<div class=\"overlay\">" +
							                  "<i class=\"fa fa-refresh fa-spin\"></i>" +
							                "</div>" +
						                  "</div>" +
						                  "<div class=\"modal-footer\">" +
						                  "</div>" +
						                "</div>" +
						              "</div>" +
						            "</div>" +
						          "</div>");
	
	
	//##1.Load Specified Data For The Modal
	$('#content-modal-body').load("Modal.do", targettedData, function( response, status, xhr ) {
								//---.Show Some Respect For Error Status
								if(status == "error"){
									$('#content-modal-body').html("<div class=\"box box-default\">" +
								                				"<div class=\"box-header with-border\">" +
								               	  				"<h1 align=\"center\"><b>Fail to fetch content</b></h1>" + 
							    			                  		"<div class=\"callout callout-danger\" align=\"center\">" + 
							    			                    		"<h4>Something wrong happened at here</h4>" + 
							    			                    		"<p>Please contact the developer for further assistance !!</p>" + 
							    			                  		"</div>" + 
							    			                	"</div>" + 
							    			              	  "</div>");
								}
	});
	//##1.Show The Modal
	$('#content-modal').modal({ show:true, backdrop: false });
}