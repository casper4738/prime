package prime.admin.position;

public class PositionBean {

	private Integer positionId;
	private String positionName;
	private Integer positionStatus = 0;

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public Integer getPositionStatus() {
		return positionStatus;
	}

	public void setPositionStatus(Integer positionStatus) {
		this.positionStatus = positionStatus;
	}

}