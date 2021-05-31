CREATE SCHEMA game_app;
USE game_app;
CREATE TABLE Users
(
ID_Users int NOT NULL AUTO_INCREMENT,
Email VARCHAR(100) NOT NULL,
Passwords VARCHAR(100) NOT NULL,
Name_person VARCHAR(100) NOT NULL,
Gender BINARY NOT NULL,
PRIMARY KEY (ID_Users)
);
CREATE TABLE Message
(
ID_message int NOT NULL AUTO_INCREMENT,
User_ID int NOT NULL,
Chat_ID int NOT NULL,
Date_time datetime NOT NULL,
Text_chat text(1000) NOT NULL,
PRIMARY KEY (ID_message),
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users),
FOREIGN KEY (Chat_ID) REFERENCES Chat(ID_chat)
);
CREATE TABLE Chat
(
ID_chat int NOT NULL AUTO_INCREMENT,
Chat_name text(100) NOT NULL,
PRIMARY KEY (ID_chat)
);
CREATE TABLE Role_chat
(
ID_Role_chat int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Role_chat)
);
CREATE TABLE Plugin_chat
(
ID_Plugin_chat int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Plugin_chat)
);
CREATE TABLE Tool
(
ID_Tool int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Tool),
Commands text(100) NOT NULL,
Game_cube text(100) NOT NULL,
Scripts text(100) NOT NULL,
Plugin_ID int NOT NULL,
FOREIGN KEY (Plugin_ID) REFERENCES Plugin_chat(ID_Plugin_chat)
);
CREATE TABLE Role_message
(
ID_Role_message int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Role_message),
RChat_ID int NOT NULL,
Character_ID int NOT NULL,
Date_time datetime NOT NULL,
Text_chat text(1000) NOT NULL,
FOREIGN KEY (RChat_ID) REFERENCES Role_chat(ID_Role_chat),
FOREIGN KEY (Character_ID) REFERENCES Character_game(ID_Character_game)
);
CREATE TABLE Character_game
(
ID_Character_game int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Character_game),
RoleChat_ID int NOT NULL,
User_ID int NOT NULL,
Name_person VARCHAR(100) NOT NULL,
Initials VARCHAR(100) NOT NULL,
Life_status boolean NOT NULL,
Descriptions text(1000) NOT NULL,
FOREIGN KEY (RoleChat_ID) REFERENCES Role_chat(ID_Role_chat),
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users)
);
CREATE TABLE Fandom
(
ID_fandom int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_fandom),
Category VARCHAR(100) NOT NULL,
Name_person VARCHAR(100) NOT NULL
);
CREATE TABLE Role_game_event
(
ID_Role_game_event int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Role_game_event),
Date_time datetime NOT NULL,
Descriptions text(1000) NOT NULL
);
CREATE TABLE Forum
(
ID_Forum int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Forum),
Section VARCHAR(100) NOT NULL,
Name_person VARCHAR(100) NOT NULL,
Fandom_ID int NOT NULL,
CONSTRAINT fk_fk2 FOREIGN KEY (Fandom_ID) REFERENCES Fandom(ID_fandom)
);
CREATE TABLE Article
(
ID_Article int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Article),
Date_time datetime NOT NULL,
Title VARCHAR(100) NOT NULL,
Text_chat text(1000) NOT NULL,
Links VARCHAR(100) NOT NULL,
User_ID int NOT NULL,
Forum_ID int NOT NULL,
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users),
FOREIGN KEY (Forum_ID) REFERENCES Forum(ID_Forum)
);
CREATE TABLE Event_chat
(
ID_Event_chat int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (ID_Event_chat),
Fandom_ID binary NOT NULL,
User_ID int NOT NULL,
Date_time datetime NOT NULL,
Links VARCHAR(100) NOT NULL,
Text_chat text(1000) NOT NULL,
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users)
);
# Таблицы в связи многие ко многим
CREATE TABLE Using_plagins
(
RChat_ID int NOT NULL,
Plugin_ID int NOT NULL,
FOREIGN KEY (RChat_ID) REFERENCES Role_chat(ID_Role_chat),
FOREIGN KEY (Plugin_ID) REFERENCES Plugin_chat(ID_Plugin_chat)
);
CREATE TABLE Fandom_bassed_Chat
(
RChat_ID int NOT NULL,
Fandom_ID int NOT NULL,
FOREIGN KEY (RChat_ID) REFERENCES Role_chat(ID_Role_chat),
FOREIGN KEY (Fandom_ID) REFERENCES Fandom(ID_fandom)
);
CREATE TABLE Chat_members
(
Chat_ID int NOT NULL,
User_ID int NOT NULL,
FOREIGN KEY (Chat_ID) REFERENCES Chat(ID_chat),
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users)
);
CREATE TABLE Members_of_Event
(
User_ID int NOT NULL,
Event_ID int NOT NULL,
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users),
FOREIGN KEY (Event_ID) REFERENCES Event_chat(ID_Event_chat)
);
CREATE TABLE Members_of_Role_Game_Event
(
User_ID int NOT NULL,
Event_ID int NOT NULL,
FOREIGN KEY (User_ID) REFERENCES Users(ID_Users),
FOREIGN KEY (Event_ID) REFERENCES role_game_event(ID_Role_game_event)
);
# 10 дополнительных запросов на изменение таблиц
ALTER TABLE Users MODIFY Email VARCHAR(50) NOT NULL;
ALTER TABLE Forum ADD COLUMN Statistics VARCHAR(30) NOT NULL;
ALTER TABLE Message RENAME COLUMN Date_time TO Sending_time;
ALTER TABLE Tool ADD COLUMN Settings VARCHAR(70) NOT NULL;
ALTER TABLE Article RENAME COLUMN Title TO Heading;
ALTER TABLE Role_chat ADD COLUMN Exhibitor int NOT NULL;
ALTER TABLE Role_chat DROP COLUMN Exhibitor;
ALTER TABLE Users RENAME COLUMN Name_person TO Nickname;
ALTER TABLE Fandom MODIFY Category VARCHAR(50) NOT NULL;
ALTER TABLE Tool DROP COLUMN Settings;
# 10 запросов
INSERT INTO Users(Email) VALUES ('dogBaskervil.com');
INSERT INTO Message(Text_chat) VALUES ('Привет, ребята');
INSERT INTO Chat(Chat_name) VALUES ('Каратели дотки');
INSERT INTO Tool(Plugin_ID) VALUES (1);
INSERT INTO Role_message(Text_chat) VALUES ('Прометей погиб');
INSERT INTO Game_characters(Initials) VALUES (25418);
INSERT INTO Fandom(Category) VALUES (15);
INSERT INTO Role_game_event(Descriptions) VALUES ('Игровая мышка сломана, воспользуйтесь клавиатурой');
INSERT INTO Article(User_ID) VALUES (3);
INSERT INTO Event_in_chat(Text_chat) VALUES ('Продолжаем');
# 3 запроса на RENAME
RENAME TABLE Event_chat TO Event_in_chat;
RENAME TABLE Character_game TO Game_characters;
RENAME TABLE Plugin_chat TO Plagin;
# Удаление таблиц и БД
DROP TABLE plagin;
DROP TABLE chat;
DROP DATABASE game_app;

-- форум к фандому многие ко многим
ALTER TABLE Forum
DROP CONSTRAINT fk_fk2;
CREATE TABLE FandomToForum(
id_forum int NOT NULL,
id_fandom int NOT NULL,
FOREIGN KEY (id_forum) REFERENCES Forum(id_forum),
FOREIGN KEY (id_fandom) REFERENCES Fandom(id_fandom)
);
