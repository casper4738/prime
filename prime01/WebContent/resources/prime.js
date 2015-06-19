function flyToPage(task) {
	document.forms[0].task.value = task;
	document.forms[0].submit();
}

function flyToEditDelete(task, value) {
	document.forms[0].task.value = task;
	document.forms[0].tmpId.value = value;
	if(task == "delete"){
		if(confirm("Do you really want to delete this data?"))
			document.forms[0].submit();
	}
	else{
		document.forms[0].submit();
	}
}

function flyToForward(task, value) {
	document.forms[0].task.value = task;
	document.forms[0].message.value = value;
	document.forms[0].submit();
}

function page(page) {
	if(page == -1) {
		document.forms[0].goToPage.value = document.getElementById('page').value;
	} else {
		document.forms[0].goToPage.value = page;			
	}
	document.forms[0].submit();
}

function change(value) {
	document.forms[0].showInPage.value = value;
	document.forms[0].submit();
}

function validate() {
	return validateForm(document.forms[0]);
}


function onSelectManager(value) {
	document.forms[0].submit();
}

function isNumeric(n) {
	try {
		return !isNaN(n);
	}catch(Exception) {
		return false;		
	}
}