package prime.user.project;

public class RoleOption {

	private Integer roleId;
	private String roleName;
	private String projectMemberId;
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

	public String getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(String projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

	public Integer getProjectMemberStatus() {
		return projectMemberStatus;
	}

	public void setProjectMemberStatus(Integer projectMemberStatus) {
		this.projectMemberStatus = projectMemberStatus;
	}

}
