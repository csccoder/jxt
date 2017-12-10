package cn.jxt.bean;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.Table;
import javax.persistence.Transient;
@Table(name = "guardian")
public class Guardian extends User{
    private String name;
    private String relation;
    private String phone;
    private String company;
    private String address;
    @Transient
    private Student Student;
    @JsonIgnore
    private Integer childId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Student getStudent() {
        return Student;
    }

    public void setStudent(Student student) {
        Student = student;
    }

    public Integer getChildId() {
        return childId;
    }

    public void setChildId(Integer childId) {
        this.childId = childId;
    }
}
