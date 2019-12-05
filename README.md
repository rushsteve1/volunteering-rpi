# Volunteering @ RPI

A volunteering job portal for Rensselaer Polytechnic Students.

Created as a project for the ITWS-2110 Web Systems course by
group 6 AKA the Enigma Corporation.

## Development

1. Clone the repository
2. Download [composer](https://getcomposer.org/doc/00-intro.md)
3. Inside the project root, install all dependencies with `composer install`
4. Ensure PHP Curl is install with `sudo apt-get install php-curl`
5. Ensure PHP XML is install with `sudo apt-get install php-xml`
6. Ensure PHP mysqli is install with `sudo apt-get install php-mysqli`
7. Create an SQL database titled `volunteering-rpi`
8. Run the SQL in `sql/volunteering-rpi.sql` to populate the database
9. Enter Database servername, username, and password in `/src/queries.php` lines 4-7
10. Switch to the `./src/` directory
11. Run the frontend with `php -S localhost:8000`
12. Navigate to [http://localhost:8000](http://localhost:8000)