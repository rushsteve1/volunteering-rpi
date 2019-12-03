<?php

// TODO replace these with a config file or similar
$servername = "localhost";
$username = "";
$password = "";
$dbname = "volunteering-rpi";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection to database failed failed: " . $conn->connect_error);
}

/* === Prepared Statements === */
/*
 * These are the raw prepared statements that are going to be used
 * by the functions below.
 * These are not intended to be used directly, but are exposed in case it is necessary.
 */
$_select_users = $conn->prepare("SELECT * FROM users;");

$_insert_user = $conn->prerare("INSERT INTO users (rcsID, fullname, about) VALUES (?, ?, ?);");

$_select_user_by_rcsid = $conn->prepare("SELECT * FROM users WHERE rcsid=?");

$_select_events = $conn->prepare("SELECT * FROM events ORDER BY eventdate DESC;");

$_insert_event = $conn->prepare("INSERT INTO events (eventname, orgID, description, location, occupancy, eventDuration, eventDate) VALUES (?, ?, ?, ?, ?, ?, ?);");

$_select_events_by_org = $conn->prepare("SELECT * FROM events WHERE orgID=? ORDER BY eventdata DESC;");

$_select_orgs = $conn->prepare("SELECT * FROM organizations;");

$_insert_org = $conn->prepare("INSERT INTO organizations (orgName, description, website, adminID) VALUES (?, ?, ?, ?);");

$_select_org_users = conn->prepare("SELECT users.* FROM userorganizations uo WHERE uo.orgID=? INNER JOIN users ON users.rcsID=uo.rcsID;");

$_select_user_orgs = conn->prepare("SELECT organizations.* FROM userorganizations uo WHERE uo.rcsID=? INNER JOIN organizations ON organizations.id=uo.orgID;");

$_insert_userorg("INSERT INTO userorganization (orgID, rcsID) VALUEs (?, ?);");

$_select_event_users = conn->prepare("SELECT users.* FROM userevents ue WHERE ue.eventID=? INNER JOIN users ON ue.rcsID=user.rcsID;");

$_select_event_users = conn->prepare("SELECT events.* FROM userevents ue WHERE ue.rcsID=? INNER JOIN events ON ue.eventID=events..event;");

$_insert_userevent("INSERT INTO userevent (eventID, rcsID) VALUES (?, ?);");

/* === Wrapper Functions === */
/*
 * These functions provider simpler type-checked
 * interfaces to the above SQL queries.
 */

function select_users() {
    $_select_users->reset();
    $_select_users->execute();
    return $_select_users->get_result()->fetch_all();
}

function insert_user(string rcsID, string fullname, string about): bool {
    $_insert_user->reset();
    $_insert_user->bind_param("sss", rcsID, fullname, about);
    return $_insert_user->execute();
}

function select_user_by_rcsid(string rcsID) {
    $_select_user_by_rcsid->reset();
    $_select_user_by_rcsid->bind_param("s", rcsID);
    $_select_users->execute();
    return $_select_users->get_result()->fetch_assoc();
}

function select_events() {
    $_select_events->reset();
    $_select_events->execute();
    return $_select_events()->get_result()->fetch_all();
}

function insert_event(string name, int orgID, string description, string location, int occupancy, int duration, string dateTime): bool {
    $_insert_event->reset();
    $_insert_event->bind_param("sissiis", name, orgId, description, location, occupancy, duration, datetime);
    return $_insert_event->execute();
}

function select_events_by_org(int orgID) {
    $_select_events_by_org->reset();
    $_select_events_by_org->bind_param("i", orgID);
    $_select_events_by_org->execute();
    return $_select_events_by_org->get_result()->fetch_all();
}

function select_orgs() {
    $_select_orgs->reset();
    $_select_orgs->execute();
    return $_select_orgs->get_result()->fetch_all();
}

function insert_org(string name, string description, string website, string adminID) {
    $_insert_org->reset();
    $_insert_userorg->reset();

    $_insert_org->bind_param("ssss", name, description, website, adminID);
    $a = $_insert_org->execute();

    // Create a relation to the admin user
    if ($a) {
        $_insert_userorg->bind_param("ii", $conn->insert_id);
        return $a && $_insert_userorg->execute();
    } else {
        return false;
    }
}

function select_org_users(int orgID) {
    $_select_org_users->reset();
    $_select_org_users->bind_param("i", orgID);
    $_select_org_users->execute();
    return $select_org_users->get_result()->fetch_all();
}

function select_user_orgs(string rcsID ) {
    $_select_user_orgs->reset();
    $_select_user_orgs->bind_param("s", rcsID);
    $_select_user_orgs->execute();
    return $select_user_orgs->get_result()->fetch_all();
}

function select_event_users(int eventID) {
    $_select_event_users->reset();
    $_select_event_users->bind_param("i", eventID);
    $_select_event_users->execute();
    return $select_event_users->get_result()->fetch_all();
}

function select_user_events(string rcsID) {
    $_select_user_events->reset();
    $_select_user_events->bind_param("s", rcsID);
    $_select_user_events->execute();
    return $select_user_events->get_result()->fetch_all();
}

function add_user_to_event(int eventID, string rcsID): bool {
    $_insert_userevent->reset();
    $_insert_userevent->bind_param("is", eventID, rcsID);
    return $_insert_userevent->execute();
}

?>
