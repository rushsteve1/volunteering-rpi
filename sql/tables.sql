CREATE TABLE users (
    rcsID VARCHAR(20) PRIMARY KEY,
    fullName VARCHAR(100),
    about VARCHAR(500)
);

CREATE TABLE organizations (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    orgName VARCHAR(100),
    description VARCHAR(500),
    website VARCHAR(100),
    adminID VARCHAR(20),
    FOREIGN KEY(adminID) REFERENCES users(rcsID)
);

CREATE TABLE events (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    eventName VARCHAR(100),
    orgID INTEGER,
    description VARCHAR(500),
    location VARCHAR(100),
    occupancy INTEGER,
    eventDuration INTEGER,
    eventDate DATETIME,
    FOREIGN KEY(orgID) REFERENCES organizations(id)
);

CREATE TABLE userorganization (
    orgID INTEGER,
    rcsID VARCHAR(20),
    PRIMARY KEY (orgID, rcsID),
    FOREIGN KEY(orgID) REFERENCES organizations(id),
    FOREIGN KEY(rcsID) REFERENCES users(rcsID)
);

CREATE TABLE userevent (
    eventID INTEGER,
    rcsID VARCHAR(20),
    PRIMARY KEY (eventID, rcsID),
    FOREIGN KEY(eventID) REFERENCES events(id),
    FOREIGN KEY(rcsID) REFERENCES users(rcsID)
);
