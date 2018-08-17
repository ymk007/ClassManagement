package com.hx.pojo;

import java.util.Date;

public class Curriculum {
    private Short id;

    private Short userId;

    private String grade;

    private Date startDate;

    private Date endDate;

    private String site;

    private String content;

    private Integer corrected;

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public Short getUserId() {
        return userId;
    }

    public void setUserId(Short userId) {
        this.userId = userId;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site == null ? null : site.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getCorrected() {
        return corrected;
    }

    public void setCorrected(Integer corrected) {
        this.corrected = corrected;
    }

    
	public Curriculum() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Curriculum(Short id, Short userId, String grade, Date startDate, Date endDate, String site, String content,
			Integer corrected) {
		super();
		this.id = id;
		this.userId = userId;
		this.grade = grade;
		this.startDate = startDate;
		this.endDate = endDate;
		this.site = site;
		this.content = content;
		this.corrected = corrected;
	}

	@Override
	public String toString() {
		return "Curriculum [id=" + id + ", userId=" + userId + ", grade=" + grade + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", site=" + site + ", content=" + content + ", corrected=" + corrected + "]";
	}
    
    
}