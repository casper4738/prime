function flyToPage(task) {
	document.forms[0].task.value = task;
	document.forms[0].submit();
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

function isDate(fDate, fMonth, fYear, tDate, tMonth, tYear) {
	if(fYear % 4 == 0) {
		if(fMonth == 2 && fDate >= 29) {
			alert("Date in February less than 29");
			return false;	
		}
	} else {
		if(fMonth == 2 && fDate >= 28) {
			alert("Date in February less than 28");
			return false;	
		}
	}
	
	if(tYear % 4 == 0) {
		if(tMonth == 2 && tDate >= 29) {
			alert("Date in February less than 29");
			return false;	
		}
	} else {
		if(tMonth == 2 && tDate >= 28) {
			alert("Date in February less than 28");
			return false;	
		}
	}
	return true;	
}