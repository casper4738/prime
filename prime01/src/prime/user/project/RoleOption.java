package prime.user.project;
 
public class RoleOption {

	private Integer roleId;
	private String roleName;
	private Integer projectMemberId;
	private Integer projectMemberStatus;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(Integer projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

	public Integer getProjectMemberStatus() {
		return projectMemberStatus;
	}

	public void setProjectMemberStatus(Integer projectMemberStatus) {
		this.projectMemberStatus = projectMemberStatus;
	}

}
