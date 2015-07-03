//validator
function isNull(value) {
	if (value == null || value == "") {
		return true;
	}
	return false;
}

function checkSpecialChars(var1, err_var1) {
	var specialChars = "/*!@#$%^&*()\"{}_[]|\\?/<>,.";
	for (var i = 0; i < var1.val().length; i++) {
 	    if (specialChars.indexOf(var1.val().charAt(i)) != -1) { 
 	    	err_var1.html("Characters are not allowed");
 			return true; 
 		}
 	}
	return false; 
}

function getDateToday() {
	d = new Date();
	return d.today();
}

Date.prototype.today = function() {
   var yyyy = this.getFullYear().toString();
   var mm = (this.getMonth()+1).toString();
   var dd  = this.getDate().toString();
   return yyyy +"-"+(mm[1]?mm:"0"+mm[0]) +"-"+ (dd[1]?dd:"0"+dd[0]); 
};


function checkNull(var1, err_var1, title) {
	err_var1.html("");				
	if( isNull(var1.val()) ) {
		err_var1.html(title+" must be filled out");
		return true;
	}
	return false;
}

function checkForDate(var1, var2, err_var1, err_var2, title1, title2) {
	if (new Date(var1.val()) < new Date(getDateToday())){
		err_var1.html(title1+" must not least than today");			
    } else if ( new Date(var1.val()) > new Date(var2.val()) ) {
    	err_var2.html(title1+" must not least than "+title2);			
    }
}


//end of validator
		
function flyToBack(task) {
	var tmpForm = document.forms[0];
	tmpForm.task.value = task;
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function flyToPage(task) {
	var tmpForm = document.forms[0];
	tmpForm.task.value = task;
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function dosubmit() {
	var tmpForm = document.forms[0];
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
}

function searchBy(task, isShow) {
	var tmpForm = document.forms[0];
	tmpForm.isShowAll.value = isShow;
	tmpForm.task.value = task;
	menuLoadHandler(tmpForm.action, serialize(tmpForm));
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

//****Modal Variable
var PAGE_LOAD_ERROR = "<div class=\"box box-default\">" +
						"<div class=\"box-header with-border\">" +
							"<h1 align=\"center\"><b>Fail to fetch content</b></h1>" + 
							"<div class=\"callout callout-danger\" align=\"center\">" + 
								"<h4>Something wrong happened at here</h4>" + 
								"<p>Please contact the developer for further assistance !!</p>" + 
							"</div>" + 
						"</div>" + 
					"</div>";
var PAGE_LOADING  = "<div class=\"info-modal\">" +
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
					  "</div>";
var modalTargettedObject;

function menuLoadHandler(targettedMenu, targettedData){
	//---.History Handler
	window.history.pushState({data : targettedData, menu : targettedMenu}, "", "");
	
	//##0. Show Loading [Hard Code the HTML Tag until Found Better Solution]
	$('#content-main').html(PAGE_LOADING);
	
	//##1.Start AJAX-Load
	$('#content-main').load(targettedMenu, targettedData, function( response, status, xhr ) {
		//---.Show Some Respect For Error Status
		if(status == "error"){
			$('#content-main').html(PAGE_LOAD_ERROR);
		} else {
			$('#content-main').css("z-index", -1);
		}
	});
	
	//##2.Return False to just to disable ahref Event if Exists
	return false;
}

function modalLoadHandler(targettedData, targettedObject){
	//##0. Show Loading [Hard Code the HTML Tag until Found Better Solution]
    $('#content-modal-body').removeData('bs.modal');
	$('#content-modal-body').html(PAGE_LOADING);
	
	//##1.Load Specified Data For The Modal
	$('#content-modal-body').load("Modal.do", targettedData, function( response, status, xhr ) { //Hardcoded No Other Way :(
								//---.Show Some Respect For Error Status
								if(status == "error"){
									$('#content-modal-body').html(PAGE_LOAD_ERROR);
								}
	});

	//##1.Register Targetted Object For Value Receiver
	if(targettedObject != null){
		modalTargettedObject = targettedObject;
	}
	
	//##2.Show The Modal
	$('#content-modal').modal({ show:true, backdrop: false });
}

function modalSubmitRefreshPageWithoutReturn(retValue, retForm, refreshedValue, refreshedForm){
	//##1.Show Loading Screen Inside Modal
	$('#content-modal-body').html(PAGE_LOADING);
	
	//##2.Do Submit Here With Ajax
	$.ajax({ 
      type	  : "POST",
      url	  : retForm,  
      data	  : retValue,
      success : function(){
    		//##1.Hide Modal
    	    $("[data-dismiss=modal]").trigger({ type: "click" });
    	    
    	    //##2.Reload Menu
    	    if(refreshedForm != null){
        	    menuLoadHandler(refreshedForm, refreshedValue);
    	    }
      },
      
      error: function(){
			$('#content-modal-body').html(PAGE_LOAD_ERROR);
      }
   });
}

function modalSubmitReturnValue(retValue,retForm){
	//##0.Set Return Value to Targetted Object
	if(modalTargettedObject != null){
		modalTargettedObject.val(retValue);
		if(retForm=='employeeHead'){
			var res = retValue.split(',');
			document.getElementById('headName').value=res[1];
			document.forms[0].managerId.value=res[0].replace('[','');
			document.getElementById('divisionName').value=res[4];
		
			var temp = document.getElementById('divisionName').value;
			temp = temp.trim();
			if(temp == "null"){
				document.getElementById('isDivision').style.display="none";
				document.getElementById('chooseDivision').style.display="inline";
				document.getElementById('divisionId').selectedIndex="0";
			}else{
				document.getElementById('isDivision').style.display="inline";
				document.getElementById('chooseDivision').style.display="none";
			}
		} else if(retForm=='employeeResign'){
			var res = retValue.split(',');
			document.getElementById('substituteHead').value=res[1];
			document.forms[0].substituteHeadId.value=res[0].replace('[','');
		} else if(retForm=='employeeUser'){
			var res = retValue.split(',');
			document.getElementById('employeeName').value=res[0].replace('[','') + " -" + res[1];
			document.forms[0].employeeId.value=res[0].replace('[','');
		} else if(retForm=='project'){
			var res = retValue.split(',');
			document.getElementById('employeeName').value=res[1];
			document.forms[0].employeeId.value=res[0].replace('[','');
		}
	}
	
	//##1.Hide Modal
    $("[data-dismiss=modal]").trigger({ type: "click" });
}


/**
 * Send Notification Handler
 * Notif Type  = Type of Notif, Hardcoded via Constants, Balanced via DB [Will think other way better]
 * Notif Param = Parameter , Consists of Array List that will inserted to the template [a, b, c]
 */
function sendNotification(receiverId, notifType, notifParam){	
	//##1.Do Sending Email with Asynchronous Process
	alert(notifParam);
	$.ajax({ 
      type	  : "POST",
      url	  : "Notification.do", //Hardcoded No Other Way :(  
      data	  : "task=sendNotification&notifReceiverID=" + receiverId + "&notifType=" + notifType + "&notifParam=" + notifParam,
      success : function(msg){
    	  alert("Notification Sent !");
      },
      
      error: function(){
    	  alert("Something Wrong is Happening when Sending Notification !");
      }
   });
}
