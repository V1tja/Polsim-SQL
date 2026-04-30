CREATE TABLE USERS (
    ID UNIQUEIDENTIFIER PRIMARY KEY,
    EMAIL VARCHAR(255),
    PASSWORD_HASH VARCHAR(255),
    USERNAME NVARCHAR(100),
    SECURITY_STAMP UNIQUEIDENTIFIER,
    IS_EMAIL_VERIFIED BIT,
    ENABLED BIT,
    FAILED_LOGIN_ATT INT,
    LOCKED_UNTIL DATETIME,
    MFA_ENABLED BIT,
    MFA_SECRET NVARCHAR(255),
    GIVEN_NAME NVARCHAR(100),
    FAMILY_NAME NVARCHAR(100),
    NICKNAME NVARCHAR(100),
    PFP_URL VARCHAR(MAX),
    CREATED_AT DATETIME,
    UPDATED_AT DATETIME,
    LAST_LOGIN_AT DATETIME,
    LAST_PASSWORD_CHANGE DATETIME
);

CREATE TABLE ELEDEF_election (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(1000)
);

CREATE TABLE ELEDEF_election_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE ELEDEF_election_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (election_id) REFERENCES ELEDEF_election(id),
    FOREIGN KEY (status_type_id) REFERENCES ELEDEF_election_status_types(id)
);

CREATE TABLE ELEDEF_election_question_branches (
    id INT IDENTITY(1,1) PRIMARY KEY,
    branch NVARCHAR(50)
);

CREATE TABLE ELEDEF_election_question_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type NVARCHAR(50)
);

CREATE TABLE ELEDEF_election_question (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_id INT NOT NULL,
    branch_id INT NOT NULL,
    type_id INT NOT NULL,
    start_timestamp DATETIME,
    end_timestamp DATETIME,
    name NVARCHAR(1000),
    FOREIGN KEY (election_id) REFERENCES ELEDEF_election(id),
    FOREIGN KEY (branch_id) REFERENCES ELEDEF_election_question_branches(id),
    FOREIGN KEY (type_id) REFERENCES ELEDEF_election_question_types(id)
);

CREATE TABLE POLSUB_party (
    id int IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE POLSUB_party_name (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_id INT NOT NULL,
    name NVARCHAR(50) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (party_id) REFERENCES POLSUB_party(id)
);

CREATE TABLE POLSUB_party_abbreviation (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_id INT NOT NULL,
    abbreviation NVARCHAR(20) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (party_id) REFERENCES POLSUB_party(id)
);

CREATE TABLE POLSUB_party_users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_id INT NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    FOREIGN KEY (party_id) REFERENCES POLSUB_party(id),
    FOREIGN KEY (user_id) REFERENCES USERS(id)
);

CREATE TABLE POLSUB_party_users_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_party_users_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_users_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (party_users_id) REFERENCES POLSUB_party_users(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_party_users_status_types(id)
);

CREATE TABLE POLSUB_party_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_party_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (party_id) REFERENCES POLSUB_party(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_party_status_types(id)
);

CREATE TABLE POLSUB_coalition (
    id INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE POLSUB_coalition_name (
    id INT IDENTITY(1,1) PRIMARY KEY,
    coalition_id INT NOT NULL,
    name NVARCHAR(50) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (coalition_id) REFERENCES POLSUB_coalition(id)
);

CREATE TABLE POLSUB_coalition_abbreviation (
    id INT IDENTITY(1,1) PRIMARY KEY,
    coalition_id INT NOT NULL,
    abbreviation NVARCHAR(20) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (coalition_id) REFERENCES POLSUB_coalition(id)
);

CREATE TABLE POLSUB_coalition_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_coalition_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    coalition_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (coalition_id) REFERENCES POLSUB_coalition(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_coalition_status_types(id)
);

CREATE TABLE POLSUB_party_coalition (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_id INT NOT NULL,
    coalition_id INT NOT NULL,
    FOREIGN KEY (party_id) REFERENCES POLSUB_party(id),
    FOREIGN KEY (coalition_id) REFERENCES POLSUB_coalition(id),
    UNIQUE(party_id, coalition_id)
);

CREATE TABLE POLSUB_party_coalition_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_party_coalition_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    party_coalition_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (party_coalition_id) REFERENCES POLSUB_party_coalition(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_party_coalition_status_types(id)
);

CREATE TABLE POLSUB_subject (
    id INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE POLSUB_subject_name (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_id INT NOT NULL,
    name NVARCHAR(50) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES POLSUB_subject(id)
);

CREATE TABLE POLSUB_subject_abbreviation (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_id INT NOT NULL,
    abbreviation NVARCHAR(20) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES POLSUB_subject(id)
);

CREATE TABLE POLSUB_subject_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_subject_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES POLSUB_subject(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_subject_status_types(id)
);

CREATE TABLE POLSUB_subject_candidature (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (election_question_id) REFERENCES ELEDEF_election_question(id),
    FOREIGN KEY (subject_id) REFERENCES POLSUB_subject(id)
);

CREATE TABLE POLSUB_subject_candidature_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_subject_candidature_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_candidature_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_candidature_id) REFERENCES POLSUB_subject_candidature(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_subject_candidature_status_types(id)
);

CREATE TABLE POLSUB_subject_candidature_users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_candidature_id INT NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    preference_placement INT,
    FOREIGN KEY (subject_candidature_id) REFERENCES POLSUB_subject_candidature(id),
    FOREIGN KEY (user_id) REFERENCES USERS(ID),
    UNIQUE(subject_candidature_id, user_id)
);

CREATE TABLE POLSUB_subject_candidature_users_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_subject_candidature_users_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_candidature_users_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_candidature_users_id) REFERENCES POLSUB_subject_candidature_users(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_subject_candidature_users_status_types(id)
);

CREATE TABLE POLSUB_subject_party (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_id INT NOT NULL,
    party_id INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES POLSUB_subject(id),
    FOREIGN KEY (party_id) REFERENCES POLSUB_party(id),
    UNIQUE(subject_id, party_id)
);

CREATE TABLE POLSUB_subject_party_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_subject_party_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_party_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_party_id) REFERENCES POLSUB_subject_party(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_subject_party_status_types(id)
);

CREATE TABLE POLSUB_subject_coalition (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_id INT NOT NULL,
    coalition_id INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES POLSUB_subject(id),
    FOREIGN KEY (coalition_id) REFERENCES POLSUB_coalition(id),
    UNIQUE(subject_id, coalition_id)
);

CREATE TABLE POLSUB_subject_coalition_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL
);

CREATE TABLE POLSUB_subject_coalition_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    subject_coalition_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (subject_coalition_id) REFERENCES POLSUB_subject_coalition(id),
    FOREIGN KEY (status_type_id) REFERENCES POLSUB_subject_coalition_status_types(id)
);

CREATE TABLE ELEDEF_election_question_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type NVARCHAR(50)
);

CREATE TABLE ELEDEF_election_question_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_id INT,
    status_type_id INT,
    timestamp DATETIME,
    FOREIGN KEY (election_question_id) REFERENCES ELEDEF_election_question(id),
    FOREIGN KEY (status_type_id) REFERENCES ELEDEF_election_question_status_types(id)
);

CREATE TABLE POLREF_referendum (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(1000)
);

CREATE TABLE POLREF_referendum_article (
    id INT IDENTITY(1,1) PRIMARY KEY,
    referendum_id INT NOT NULL,
    article NVARCHAR(1000),
    FOREIGN KEY (referendum_id) REFERENCES POLREF_referendum(id)
);

CREATE TABLE POLREF_referendum_article_options (
    id INT IDENTITY(1,1) PRIMARY KEY,
    referendum_article_id INT NOT NULL,
    option_text NVARCHAR(1000),
    FOREIGN KEY (referendum_article_id) REFERENCES POLREF_referendum_article(id)
);

CREATE TABLE POLREF_referendum_mapping (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_id INT NOT NULL,
    referendum_id INT NOT NULL,
    FOREIGN KEY (election_question_id) REFERENCES ELEDEF_election_question(id),
    FOREIGN KEY (referendum_id) REFERENCES POLREF_referendum(id)
);

CREATE TABLE ELEVOT_election_question_vote (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_id INT NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    FOREIGN KEY (election_question_id) REFERENCES ELEDEF_election_question(id),
    FOREIGN KEY (user_id) REFERENCES USERS(ID),
    UNIQUE(election_question_id, user_id)
);

CREATE TABLE ELEVOT_election_question_vote_status_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type NVARCHAR(50)
);

CREATE TABLE ELEVOT_election_question_vote_status (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_vote_id INT NOT NULL,
    status_type_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (election_question_vote_id) REFERENCES ELEVOT_election_question_vote(id),
    FOREIGN KEY (status_type_id) REFERENCES ELEVOT_election_question_vote_status_types(id)
);

CREATE TABLE ELEVOT_election_question_vote_subject (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_vote_id INT NOT NULL,
    subject_candidature_id INT NOT NULL,
    FOREIGN KEY (election_question_vote_id) REFERENCES ELEVOT_election_question_vote(id),
    FOREIGN KEY (subject_candidature_id) REFERENCES POLSUB_subject_candidature(id),
    UNIQUE(election_question_vote_id)
);

CREATE TABLE ELEVOT_election_question_vote_subject_preference (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_vote_subject_id INT NOT NULL,
    subject_candidature_users_id INT NOT NULL,
    preference_placement INT,
    FOREIGN KEY (election_question_vote_subject_id) REFERENCES ELEVOT_election_question_vote_subject(id),
    FOREIGN KEY (subject_candidature_users_id) REFERENCES POLSUB_subject_candidature_users(id)
);

CREATE TABLE ELEVOT_election_question_vote_referendum (
    id INT IDENTITY(1,1) PRIMARY KEY,
    election_question_vote_id INT NOT NULL,
    referendum_article_options_id INT NOT NULL,
    FOREIGN KEY (election_question_vote_id) REFERENCES ELEVOT_election_question_vote(id),
    FOREIGN KEY (referendum_article_options_id) REFERENCES POLREF_referendum_article_options(id),
    UNIQUE(election_question_vote_id, referendum_article_options_id)
);
