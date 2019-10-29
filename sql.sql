
CREATE TABLE organization (
      orgID varchar(20) PRIMARY KEY,
      description  varchar(100),
      website varchar(100)

);
CREATE TABLE users (
      rcsID varchar(20) PRIMARY KEY,
      age   INTEGER,
      role  varchar(20),
      orgID varchar(20),
      FOREIGN KEY(orgID) REFERENCES organization(orgID)

);

CREATE TABLE events (
      eventID varchar(20) PRIMARY KEY,
      orgID varchar(20),
      description  varchar(100),
      place   varchar(100),
      occupancy INTEGER,
      eventlength INTEGER,
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
