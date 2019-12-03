INSERT INTO users(rcsID, fullName, about)
VALUES(
    "lazare2",
    "Evan Lazaro",
    "I enjoy volunteering!"
);

INSERT INTO organizations(
    orgName,
    description,
    website,
    adminID
)
VALUES(
    "CircleK International",
    "An RPI Volunteer Organiztaion",
    "https://union.rpi.edu/clubs/service/216-circle-k-international",
    "lazare2"
);

INSERT INTO userorganization(orgID, rcsID)
VALUES(1, "lazare2");

INSERT INTO events(
    eventname,
    orgID,
    description,
    location,
    occupancy,
    eventDuration,
    eventDate
)
VALUES(
    "CircleK Annual Food drive",
    1,
    "Come help us bring food to a food kitchen!",
    "Troy, New York",
    30,
    2,
    "2019-11-25T10:22:00"
);

INSERT INTO userevent(eventID, rcsID)
VALUES(1, "lazare2");
