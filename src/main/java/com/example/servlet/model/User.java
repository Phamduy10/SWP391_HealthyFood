package com.example.servlet.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
    private int id;
    private String username;
    private String pass;
    private String name;
    private String email;
    private String phone;
    private String gender;
    private Date birthDate;
    private String role;
    private String status;
    private String image;
    private Timestamp create_at;

    public User() {}

    public User(int id, String username, String pass, String name, String email, String phone, String gender, Date birthDate, String role, String status, String image, Timestamp create_at) {
        this.id = id;
        this.username = username;
        this.pass = pass;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.birthDate = birthDate;
        this.role = role;
        this.status = status;
        this.image = image;
        this.create_at = create_at;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPass() { return pass; }
    public void setPass(String pass) { this.pass = pass; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public Timestamp getCreate_at() { return create_at; }
    public void setCreate_at(Timestamp create_at) { this.create_at = create_at; }
}