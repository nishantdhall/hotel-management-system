CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomType VARCHAR(10) CHECK (RoomType IN ('single', 'double', 'triple')),
    PricePerNight DECIMAL(10, 2) NOT NULL,
    AvailabilityStatus BIT NOT NULL
);


INSERT INTO Rooms (RoomID, RoomType, PricePerNight, AvailabilityStatus) VALUES
(1, 'single', 7500.00, 1),
(2, 'double', 12000.00, 1),
(3, 'triple', 15000.00, 0),
(4, 'single', 8000.00, 1),
(5, 'double', 11000.00, 1),
(6, 'triple', 16000.00, 1),
(7, 'single', 7000.00, 0),
(8, 'double', 13000.00, 1),
(9, 'triple', 14000.00, 1),
(10, 'single', 8500.00, 1),
(11, 'double', 12500.00, 0),
(12, 'triple', 15500.00, 1),
(13, 'single', 9000.00, 1),
(14, 'double', 11500.00, 1),
(15, 'triple', 16500.00, 0),
(16, 'single', 9500.00, 1),
(17, 'double', 13500.00, 1),
(18, 'triple', 14500.00, 1),
(19, 'single', 10000.00, 0),
(20, 'double', 14000.00, 1);