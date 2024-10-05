DROP TABLE ParkingSpots;
DROP TABLE Bookings;
DROP TABLE SpotAvailability;
DROP TABLE Users;

CREATE TABLE Users (
    UserID VARCHAR(7) PRIMARY KEY , --parth07
    UserName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Ratings FLOAT DEFAULT 0,
    ProfilePicture VARCHAR(255) DEFAULT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE VehicleType AS ENUM ('FOUR_WHEELER', 'TWO_WHEELER');

CREATE TABLE ParkingSpots (
    SpotID VARCHAR(10) PRIMARY KEY, --parth07_01 can be handle by backend
    HostID VARCHAR(7) NOT NULL, -- Reference to the host in Users table
    Location JSONB NOT NULL, -- JSON to capture address, lat, lon
    PricePerHour NUMERIC(10, 2) NOT NULL,
    AvailabilityStatus VARCHAR(20) DEFAULT 'Available', -- Available, Unavailable
    Area VARCHAR(10) NOT NULL, -- In sq.ft
	VehicleType VehicleType[] NOT NULL,--2 or 4 wheeler
    Ratings FLOAT DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	SpotImages VARCHAR(255) DEFAULT NULL,
	Description VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (HostID) REFERENCES Users(UserID) -- HostID references Users table
);

CREATE TABLE SpotAvailability (
    AvailabilityID SERIAL PRIMARY KEY,
    SpotID VARCHAR(10) NOT NULL, -- Reference to the ParkingSpots table
    DayOfWeek VARCHAR(10) NOT NULL, -- Day of the week (Monday, Tuesday, etc.)
    AvailableFrom TIME NOT NULL, -- Start time of availability
    AvailableTo TIME NOT NULL, -- End time of availability
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SpotID) REFERENCES ParkingSpots(SpotID) -- SpotID references ParkingSpots table
);

CREATE TABLE Bookings (
    BookingID SERIAL PRIMARY KEY,
    SpotID VARCHAR(10) NOT NULL, -- Reference to the ParkingSpots table
    RenterID VARCHAR(7) NOT NULL, -- Reference to the user who is booking
    BookingStartTime TIMESTAMP NOT NULL,
    BookingEndTime TIMESTAMP NOT NULL,
    TotalPrice NUMERIC(10, 2) NOT NULL,
    PaymentStatus VARCHAR(20) DEFAULT 'Pending', -- Pending, Paid, Failed
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SpotID) REFERENCES ParkingSpots(SpotID), -- SpotID references ParkingSpots table
    FOREIGN KEY (RenterID) REFERENCES Users(UserID) -- RenterID references Users table
);

INSERT INTO Users (UserID, UserName, Email, PhoneNumber, PasswordHash, Ratings, ProfilePicture, created_at)
VALUES
('parth07', 'Parth Sharma', 'parth07@example.com', '1234567890', 'hashed_password_1', 4.5, 'profile_pic_url_1', CURRENT_TIMESTAMP),
('johnd01', 'John Doe', 'john_doe@example.com', '0987654321', 'hashed_password_2', 4.7, 'profile_pic_url_2', CURRENT_TIMESTAMP),
('janes02', 'Jane Smith', 'jane_smith@example.com', '1122334455', 'hashed_password_3', 4.8, 'profile_pic_url_3', CURRENT_TIMESTAMP);

-- SELECT * FROM Users;

INSERT INTO ParkingSpots (SpotID, HostID, Location, PricePerHour, AvailabilityStatus, Area, VehicleType, Ratings, CreatedAt, SpotImages, Description)
VALUES
('parth07_01', 'parth07', '{"address": "123 Main St", "latitude": 40.7128, "longitude": -74.0060}', 10.00, 'Available', '150', ARRAY['FOUR_WHEELER']::VehicleType[], 4.5, CURRENT_TIMESTAMP, 'image_url_1', 'Spacious parking spot near downtown.'),
('johnd01_01', 'johnd01', '{"address": "456 Elm St", "latitude": 40.7128, "longitude": -74.0060}', 8.00, 'Available', '100', ARRAY['TWO_WHEELER']::VehicleType[], 4.2, CURRENT_TIMESTAMP, 'image_url_2', 'Ideal for bikes with easy access.'),
('janes02_01', 'janes02', '{"address": "789 Pine St", "latitude": 40.7128, "longitude": -74.0060}', 12.00, 'Unavailable', '200', ARRAY['FOUR_WHEELER', 'TWO_WHEELER']::VehicleType[], 4.8, CURRENT_TIMESTAMP, 'image_url_3', 'Parking spot with covered area.');

-- SELECT * FROM ParkingSpots;

INSERT INTO SpotAvailability (SpotID, DayOfWeek, AvailableFrom, AvailableTo, CreatedAt)
VALUES
('parth07_01', 'Monday', '08:00:00', '20:00:00', CURRENT_TIMESTAMP),
('parth07_01', 'Tuesday', '08:00:00', '20:00:00', CURRENT_TIMESTAMP),
('parth07_01', 'Wednesday', '08:00:00', '20:00:00', CURRENT_TIMESTAMP),
('johnd01_01', 'Thursday', '10:00:00', '18:00:00', CURRENT_TIMESTAMP),
('johnd01_01', 'Friday', '10:00:00', '18:00:00', CURRENT_TIMESTAMP),
('janes02_01', 'Saturday', '09:00:00', '22:00:00', CURRENT_TIMESTAMP);

-- SELECT * FROM SpotAvailability;

INSERT INTO Bookings (SpotID, RenterID, BookingStartTime, BookingEndTime, TotalPrice, PaymentStatus, CreatedAt)
VALUES
('parth07_01', 'johnd01', '2024-10-01 12:00:00', '2024-10-01 14:00:00', 20.00, 'Paid', CURRENT_TIMESTAMP),
('johnd01_01', 'janes02', '2024-10-02 10:00:00', '2024-10-02 11:00:00', 8.00, 'Paid', CURRENT_TIMESTAMP),
('janes02_01', 'parth07', '2024-10-03 09:00:00', '2024-10-03 10:00:00', 12.00, 'Pending', CURRENT_TIMESTAMP);

-- SELECT * FROM Bookings;
