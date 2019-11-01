INSERT INTO organization (orgID, orgName, description, website, adminID)
VALUES ("CircleK", "CircleK International", "An RPI Volunteer Organiztaion",
        "https://union.rpi.edu/clubs/service/216-circle-k-international", "lazare2");

INSERT INTO users (rcsID, fullname, about)
VALUES ("lazare2", "Evan Lazaro", "I enjoy volunteering!");

INSERT INTO userorganization (orgID, rcsID)
VALUES ("CircleK", "lazare2");

INSERT INTO events (eventname, orgID, description, location, occupancy, eventduration, eventdate)
VALUES ("CircleK Annual Food drive","CircleK", "Come help us bring food to a food kitchen!",
        "Troy, New York", 30, 2, 2019-11-25);

INSERT INTO userevent (eventID, rcsID)
VALUES (1, "lazare2");
