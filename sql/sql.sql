CREATE TABLE organization (
      orgID varchar(20) PRIMARY KEY,
      orgName varchar(100),
      description  varchar(100),
      website varchar(100),
      adminID varchar(20),
      FOREIGN KEY(adminID) REFERENCES users(rcsID)
);

CREATE TABLE users (
      rcsID varchar(20) PRIMARY KEY,
      fullname varchar(100),
      about  varchar(100),
);

CREATE TABLE userorganization (
      orgID varchar(20),
      rcsID  varchar(20),
      PRIMARY KEY (rcsID, orgID),
      FOREIGN KEY(orgID) REFERENCES events(orgID),
      FOREIGN KEY(rcsid) REFERENCES users(rcsID)
);

CREATE TABLE events (
      eventID Integer(20) PRIMARY KEY AUTO_INCREMENT,
      eventname varchar(100),
      orgID varchar(20),
      description  varchar(100),
      location   varchar(100),
      occupancy INTEGER,
      eventduration INTEGER,
      eventdate datetime,
      FOREIGN KEY(orgID) REFERENCES organization(orgID)
);

CREATE TABLE userevent (
      eventID varchar(20),
      rcsID  varchar(20),
      PRIMARY KEY (rcsID, eventID),
      FOREIGN KEY(eventID) REFERENCES events(eventID),
      FOREIGN KEY(rcsid) REFERENCES users(rcsID)
);
