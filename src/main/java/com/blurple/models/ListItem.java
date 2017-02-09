package com.blurple.models;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

import java.lang.String;
import java.util.Date;
import java.util.List;

/**
 * The @Entity tells Objectify about our entity.  We also register it in {@link OfyHelper}
 * Our primary key @Id is set automatically by the Google Datastore for us.
 *
 * We add a @Parent to tell the object about its ancestor. We are doing this to support many
 * guestbooks.  Objectify, unlike the AppEngine library requires that you specify the fields you
 * want to index using @Index.  Only indexing the fields you need can lead to substantial gains in
 * performance -- though if not indexing your data from the start will require indexing it later.
 *
 * NOTE - all the properties are PUBLIC so that we can keep the code simple.
 **/
@Entity
public class ListItem {
  @Parent Key<ToDoList> theList;
  @Id public Long id;

  @Index public String itemName;
  public Date startDate;
  public Date endDate;

  public ListItem() {
    
  }

  /**
   * A convenience constructor
   **/
  public ListItem(String list, String itemName) {
    this();
    if( list != null ) {
      theList = Key.create(ToDoList.class, list);  // Creating the Ancestor key
    } else {
      theList = Key.create(ToDoList.class, "default");
    }
    this.itemName = itemName;
  }

  /**
   * Takes all important fields
   **/
  public ListItem(String list, String itemName, Date startDate, Date endDate) {
    this(list, itemName);
    this.startDate = startDate;
    this.endDate = endDate;
  }

}