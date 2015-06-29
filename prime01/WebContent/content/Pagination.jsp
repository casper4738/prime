<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<ul class="pagination">
	<li><html:link styleClass="paging" href="#" onclick="page(${pageFirst})">First</html:link></li>
	<li><html:link styleClass="paging" href="#" onclick="page(${pagePrev})"><<</html:link></li>
	
	<logic:iterate id="p" name="listPage">
		<logic:equal name="p" value="${pageNow}">
			<li class="active"><bean:write name="p" /></li>
		</logic:equal>
		<logic:notEqual name="p" value="${pageNow}">
			<li><html:link styleClass="paging" href="#" onclick="page(${p})">
				<bean:write name="p" />
			</html:link></li>
		</logic:notEqual>
	</logic:iterate>
	<li><html:link styleClass="paging" href="#" onclick="page(${pageNext})" >>></html:link> </li>
	<li><html:link styleClass="paging" href="#" onclick="page(${pageLast})" >Last</html:link></li>
	
	<li class="paginate-3">
		<html:text name="${param.formName}" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
		<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
	</li>
</ul>
			
<div class="paginate-2">
	Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
</div>