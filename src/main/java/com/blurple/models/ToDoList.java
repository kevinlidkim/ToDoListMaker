package com.blurple.models;

import com.blurple.models.ListItem;

import java.util.*;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;


/**
 * The @Entity tells Objectify about our entity.  We also register it in
 * OfyHelper.java -- very important.
 *
 * This is never actually created, but gives a hint to Objectify about our Ancestor key.
 */
@Entity
public class ToDoList {
  @Id public Long id;

  public String name;
  public boolean isPublic;
  public String owner;

  public List<ListItem> list;

  public ToDoList() {
    list = new ArrayList<ListItem>();
  }

  public ToDoList(String name, boolean isPublic, String owner) {
    this.name = name;
    this.isPublic = isPublic;
    this.owner = owner;
    list = new ArrayList<ListItem>();

  }

  public void addItem(ListItem li) {
    list.add(li);
  }

  public void removeItem(ListItem li) {
    list.remove(li);
  }

  public String getOwner() {
    return owner;
  }

  public boolean isPublic() {
    return isPublic;
  }

  public Long getId() {
    return id;
  }

  public List<ListItem> getList() {
    return list;
  }

  // public ToDoList(String name, boolean isPublic) {
  //   this.name = name;
  //   this.isPublic = isPublic;
  // }

}
