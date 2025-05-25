/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Blogs {
    private int bID;
    private int authorID;
    private String authorName;
    private int bmiId;
    private String title;
    private String imageUlr;
    private String content;
    private String status;
    private Timestamp create_at;
    private Timestamp update_at;

    public Blogs() {
    }

    public Blogs(int bID, int authorID, String authorName, int bmiId, String title, String imageUlr, String content, String status, Timestamp create_at, Timestamp update_at) {
        this.bID = bID;
        this.authorID = authorID;
        this.authorName = authorName;
        this.bmiId = bmiId;
        this.title = title;
        this.imageUlr = imageUlr;
        this.content = content;
        this.status = status;
        this.create_at = create_at;
        this.update_at = update_at;
    }

    public int getbID() {
        return bID;
    }

    public void setbID(int bID) {
        this.bID = bID;
    }

    public int getAuthorID() {
        return authorID;
    }

    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public int getBmiId() {
        return bmiId;
    }

    public void setBmiId(int bmiId) {
        this.bmiId = bmiId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUlr() {
        return imageUlr;
    }

    public void setImageUlr(String imageUlr) {
        this.imageUlr = imageUlr;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Timestamp create_at) {
        this.create_at = create_at;
    }

    public Timestamp getUpdate_at() {
        return update_at;
    }

    public void setUpdate_at(Timestamp update_at) {
        this.update_at = update_at;
    }

    @Override
    public String toString() {
        return "Blogs{" + "bID=" + bID + ", authorID=" + authorID + ", authorName=" + authorName + ", bmiId=" + bmiId + ", title=" + title + ", imageUlr=" + imageUlr + ", content=" + content + ", status=" + status + ", create_at=" + create_at + ", update_at=" + update_at + '}';
    }

   
    
}
