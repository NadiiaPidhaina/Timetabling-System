-- Create Database
DROP DATABASE IF EXISTS UniversityTimetabling;
CREATE DATABASE UniversityTimetabling;
USE UniversityTimetabling;

-- Create Courses Table 
CREATE TABLE Courses (
    course_code VARCHAR(10) PRIMARY KEY,  
    course_name VARCHAR(100) NOT NULL,    
    department VARCHAR(100) NOT NULL   
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,  
    department_name VARCHAR(100) NOT NULL,        
    course_name VARCHAR(100) NOT NULL,            
    year INT NOT NULL,                           
    term INT NOT NULL, 
    subject_name VARCHAR(100) NOT NULL,          
    subject_code VARCHAR(20) NOT NULL             
);

-- Create Professors Table 
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY AUTO_INCREMENT,  
    name VARCHAR(100) NOT NULL,                   
    availability VARCHAR(100),                    
    subject VARCHAR(100)                          
);

-- Insert Data
INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Emily Carter', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Discover Project Management'),
('Prof. James Wilson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'International Business Environment'),
('Dr. Sarah Brown', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Academic and Professional Communication'),
('Prof. Michael Lee', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Business Analytics & Visualisation'),
('Dr. Laura Adams', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Economics for Responsible Business'),
('Prof. David Green', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Accounting and Finance for Business'),
('Dr. Olivia Hall', 'Monday 1pm-4pm, Wednesday 9am-12pm, Friday 11am-2pm', 'Managing Contemporary Organisations'),
('Prof. Daniel White', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Principles of Marketing in a Global Context'),
('Dr. Sophia Clark', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Business and Economic Environment'),
('Prof. Ethan Walker', 'Tuesday 8am-11am, Thursday 1pm-4pm, Friday 9am-12pm', 'Business Process and Planning'),
('Dr. Ava Young', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Leadership and Communication'),
('Prof. Noah King', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Marketing Principles and Sales Management'),
('Dr. Mia Scott', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Personal and Professional Development'),
('Prof. Liam Allen', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Introduction to Business Processes'),
('Dr. Chloe Wright', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Business Planning and Development'),
('Prof. Benjamin Harris', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Economics in Action'),
('Dr. Harper Lewis', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Introduction to Logistics and Transport'),
('Prof. Lucas Turner', 'Tuesday 9am-12pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Fundamentals of Entrepreneurship'),
('Dr. Amelia Parker', 'Monday 11am-2pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'The Impact Mindset'),
('Prof. Henry Collins', 'Thursday 8am-11am, Friday 1pm-4pm', 'Design Thinking & Innovation'),
('Dr. Evelyn Edwards', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Finance for Managers'),
('Prof. Alexander Bennett', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Data Analysis & Visualisation'),
('Dr. Charlotte Reed', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Global Issues'),
('Prof. Samuel Cook', 'Thursday 10am-1pm, Friday 2pm-5pm', 'International Business Functions'),
('Dr. Grace Morgan', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Fundamentals of International Business Analytics'),
('Prof. Jack Bell', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Introduction to Finance for Business');


INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Emily Carter', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Business Ethics'),
('Prof. James Wilson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Organisational Analysis and Performance'),
('Dr. Sarah Brown', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Technology & Innovation Management'),
('Prof. Michael Lee', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Management Skills'),
('Dr. Laura Adams', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Business Law'),
('Prof. David Green', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Sustainable Operations Management'),
('Dr. Olivia Hall', 'Monday 1pm-4pm, Wednesday 9am-12pm, Friday 11am-2pm', 'Managing Diversity & Inclusion'),
('Prof. Daniel White', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Financial Management'),
('Dr. Sophia Clark', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Team Dynamics'),
('Prof. Ethan Walker', 'Tuesday 8am-11am, Thursday 1pm-4pm, Friday 9am-12pm', 'Consumer Behaviour and Insights'),
('Dr. Ava Young', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Project Management'),
('Prof. Noah King', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Fundamentals of Entrepreneurship and Innovation'),
('Dr. Mia Scott', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Operations and Resource Management'),
('Prof. Liam Allen', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Corporate Financial Management'),
('Dr. Chloe Wright', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Creativity and Decision Making in Business'),
('Prof. Benjamin Harris', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Project Planning and Management'),
('Dr. Harper Lewis', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Management of Information Systems'),
('Prof. Lucas Turner', 'Tuesday 9am-12pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Operations Management'),
('Dr. Amelia Parker', 'Monday 11am-2pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Purchasing and Distribution'),
('Prof. Henry Collins', 'Thursday 8am-11am, Friday 1pm-4pm', 'Entrepreneurship in the Global Context'),
('Dr. Evelyn Edwards', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Cross-Cultural Leadership'),
('Prof. Alexander Bennett', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'The Art of Storytelling'),
('Dr. Charlotte Reed', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Startup Operations'),
('Prof. Samuel Cook', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Enterprise Consulting'),
('Dr. Grace Morgan', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'SDG Action Lab'),
('Prof. Jack Bell', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Cross-cultural Management'),
('Dr. Emily Carter', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Managing Global Business Networks'),
('Prof. James Wilson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Operating in Emerging Markets'),
('Dr. Sarah Brown', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Consultancy in Practice'),
('Prof. Michael Lee', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Intermediate Macroeconomics for Business'),
('Dr. Laura Adams', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Intermediate Microeconomics for Business'),
('Prof. David Green', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Business Statistics');


INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Emily Carter', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Business Strategy'),
('Prof. James Wilson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Art of Negotiation'),
('Dr. Sarah Brown', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Decision Making Skills'),
('Prof. Michael Lee', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Effective Leadership'),
('Dr. Laura Adams', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'International Business Management'),
('Prof. David Green', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Public Sector Management'),
('Dr. Olivia Hall', 'Monday 1pm-4pm, Wednesday 9am-12pm, Friday 11am-2pm', 'Small Business Management'),
('Prof. Daniel White', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Coaching and Mentorship'),
('Dr. Sophia Clark', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Entrepreneurship in Action'),
('Prof. Ethan Walker', 'Tuesday 8am-11am, Thursday 1pm-4pm, Friday 9am-12pm', 'Resilience and Risk Management'),
('Dr. Ava Young', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Dissertation'),
('Prof. Noah King', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Final Year Project: Consultancy Project'),
('Dr. Mia Scott', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Venture Creation'),
('Prof. Liam Allen', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Global Business'),
('Dr. Chloe Wright', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Managerial Strategy and Leadership Development'),
('Prof. Benjamin Harris', 'Thursday 9am-12pm, Friday 1pm-4pm', 'E-Business and International SCM'),
('Dr. Harper Lewis', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Small Business Development'),
('Prof. Lucas Turner', 'Tuesday 9am-12pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Managing Strategy'),
('Dr. Amelia Parker', 'Monday 11am-2pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Personal and Professional Practice 3 (SMS)'),
('Prof. Henry Collins', 'Thursday 8am-11am, Friday 1pm-4pm', 'International Logistics and Supply Chain Management'),
('Dr. Evelyn Edwards', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Sustainable Transport'),
('Prof. Alexander Bennett', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Perspectives on Entrepreneurship & Small Business Development'),
('Dr. Charlotte Reed', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Digital Marketing for Startups'),
('Prof. Samuel Cook', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Strategy'),
('Dr. Grace Morgan', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Responsible Innovation'),
('Prof. Jack Bell', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Negotiations'),
('Dr. Emily Carter', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Leadership in Organisations'),
('Prof. James Wilson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'International Management and Organisational Functions'),
('Dr. Sarah Brown', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Internationalisation, Technology & Governments'),
('Prof. Michael Lee', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Strategic Management and Innovation'),
('Dr. Laura Adams', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Big Data and Business Analytics');

-- Computer Science Degrees
INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Alice Smith', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Computer and Communication Systems'),
('Prof. Bob Johnson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Paradigms of Programming'),
('Dr. Carol Williams', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Algorithms and Data Structures'),
('Prof. David Brown', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Introduction to Compilers'),
('Dr. Eve Davis', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Principles of Software Engineering'),
('Prof. Frank Wilson', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Mathematics for Computer Science'),
('Dr. Grace Moore', 'Monday 1pm-4pm, Wednesday 9am-12pm, Friday 11am-2pm', 'Advanced Mathematics for Computer Science'),
('Prof. Henry Taylor', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Introduction to Business Processes'),
('Dr. Irene Clark', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Computer Systems and Internet Technologies'),
('Prof. Jack Harris', 'Tuesday 8am-11am, Thursday 1pm-4pm, Friday 9am-12pm', 'Object Oriented Programming'),
('Dr. Karen Lewis', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Programming Foundations'),
('Prof. Leo Walker', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Principles of Security'),
('Dr. Mia Hall', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Systems Development'),
('Prof. Nathan Allen', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Software Engineering'),
('Dr. Olivia Young', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Introduction to Data Science'),
('Prof. Paul King', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Mathematics for Computing'),
('Dr. Quinn Scott', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Vectors and Matrices'),
('Prof. Ryan Adams', 'Tuesday 9am-12pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Mathematical Coding'),
('Dr. Sophia Green', 'Monday 11am-2pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Calculus and Mathematical Analysis'),
('Prof. Thomas White', 'Thursday 8am-11am, Friday 1pm-4pm', 'Discrete Mathematics'),
('Dr. Uma Turner', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Our Mathematical World'),
('Prof. Victor Parker', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Analysis of Data'),
('Dr. Wendy Collins', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Probability and Randomness'),
('Prof. Xavier Reed', 'Thursday 10am-1pm, Friday 2pm-5pm', '3D Modelling'),
('Dr. Yara Morgan', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Accessible Interface Design'),
('Prof. Zachary Bell', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Physics and Mathematics for Games Development'),
('Dr. Alice Smith', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Version Control and Asset Management'),
('Prof. Bob Johnson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Games Design'),
('Dr. Carol Williams', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Object Oriented Programming for Games'),
('Prof. David Brown', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Programming for Games');


INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Alice Smith', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Advanced Programming'),
('Prof. Bob Johnson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Information Security'),
('Dr. Carol Williams', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Introduction to Artificial Intelligence'),
('Prof. David Brown', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Advanced Algorithms and Data Structures'),
('Dr. Eve Davis', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Computational Methods and Numerical Techniques'),
('Prof. Frank Wilson', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Operating Systems'),
('Dr. Grace Moore', 'Monday 1pm-4pm, Wednesday 9am-12pm, Friday 11am-2pm', 'Introduction to Computer Forensics'),
('Prof. Henry Taylor', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Computer Networks'),
('Dr. Irene Clark', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Statistical Techniques with R'),
('Prof. Jack Harris', 'Tuesday 8am-11am, Thursday 1pm-4pm, Friday 9am-12pm', 'Operational Research: Linear Programming'),
('Dr. Karen Lewis', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Games Technology'),
('Prof. Leo Walker', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Games Portfolio'),
('Dr. Mia Hall', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Professional Project Management'),
('Prof. Nathan Allen', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Agile Development with SCRUM'),
('Dr. Olivia Young', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Data and Web Analytics'),
('Prof. Paul King', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Information Analysis and Visualisation'),
('Dr. Quinn Scott', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Operations Management'),
('Prof. Ryan Adams', 'Tuesday 9am-12pm, Thursday 1pm-4pm, Friday 9am-12pm', 'User Interface Design'),
('Dr. Sophia Green', 'Monday 11am-2pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Web Programming 1'),
('Prof. Thomas White', 'Thursday 8am-11am, Friday 1pm-4pm', 'Web Programming 2'),
('Dr. Uma Turner', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Application Development'),
('Prof. Victor Parker', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Data Structures and Algorithms'),
('Dr. Wendy Collins', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Applications in AI and Data Science'),
('Prof. Xavier Reed', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Big Data Analysis and Visualisation'),
('Dr. Yara Morgan', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Linear Algebra and Differential Equations'),
('Prof. Zachary Bell', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Vector Calculus'),
('Dr. Alice Smith', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Statistical Data Analysis and Time Series'),
('Prof. Bob Johnson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Career Development'),
('Dr. Carol Williams', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Physical Computing'),
('Prof. David Brown', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Research Methods for Games');


INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Alice Smith', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Final Year Projects'),
('Prof. Bob Johnson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Machine Learning'),
('Dr. Carol Williams', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Human-Computer Interaction and Design'),
('Prof. David Brown', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Natural Computing'),
('Dr. Eve Davis', 'Monday 9am-12pm, Tuesday 1pm-4pm, Thursday 10am-1pm', 'Artificial Intelligence Applications'),
('Prof. Frank Wilson', 'Tuesday 10am-1pm, Wednesday 2pm-5pm, Friday 9am-12pm', 'Penetration Testing and Ethical Vulnerability Scanning'),
('Dr. Grace Moore', 'Monday 1pm-4pm, Wednesday 9am-12pm, Friday 11am-2pm', 'Computer Forensics 3'),
('Prof. Henry Taylor', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Network Security'),
('Dr. Irene Clark', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Coding and Cryptography'),
('Prof. Jack Harris', 'Tuesday 8am-11am, Thursday 1pm-4pm, Friday 9am-12pm', 'Information Visualisation and Big Data'),
('Dr. Karen Lewis', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Statistical Techniques and Time Series'),
('Prof. Leo Walker', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Responsible Artificial Intelligence'),
('Dr. Mia Hall', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'Optimisation Techniques'),
('Prof. Nathan Allen', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Advanced Optimisation Techniques'),
('Dr. Olivia Young', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Linear Models and Statistical Inference'),
('Prof. Paul King', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Research Methods and Mathematics Project'),
('Dr. Quinn Scott', 'Monday 10am-1pm, Tuesday 2pm-5pm, Wednesday 9am-12pm, Friday 10am-1pm', 'Mathematics Work Placement'),
('Prof. Ryan Adams', 'Tuesday 9am-12pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Financial Time Series'),
('Dr. Sophia Green', 'Monday 11am-2pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Graph Theory and Applications'),
('Prof. Thomas White', 'Thursday 8am-11am, Friday 1pm-4pm', 'Bayesian Methods and Their Applications'),
('Dr. Uma Turner', 'Monday 9am-12pm, Tuesday 1pm-4pm, Wednesday 10am-1pm, Friday 9am-12pm', 'JVM Programming Languages'),
('Prof. Victor Parker', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Shader Programming'),
('Dr. Wendy Collins', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Artificial Intelligence for Games'),
('Prof. Xavier Reed', 'Thursday 10am-1pm, Friday 2pm-5pm', 'Final Year Group Project'),
('Dr. Yara Morgan', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Final Year Individual Project'),
('Prof. Zachary Bell', 'Tuesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Rapid Prototyping'),
('Dr. Alice Smith', 'Monday 9am-12pm, Wednesday 1pm-4pm, Friday 10am-1pm', 'Extended Realities'),
('Prof. Bob Johnson', 'Tuesday 10am-1pm, Thursday 2pm-5pm, Friday 9am-12pm', 'Game Audio'),
('Dr. Carol Williams', 'Monday 8am-11am, Wednesday 1pm-4pm, Friday 10am-1pm', 'Character Animation and Control'),
('Prof. David Brown', 'Wednesday 11am-2pm, Thursday 1pm-4pm, Friday 9am-12pm', 'Visual Effects for Games');

INSERT INTO Professors (name, availability, subject) VALUES
('Dr. Henry Peterson', 'Monday 9am-12pm, Wednesday 1pm-4pm', 'Principles of Entrepreneurship'),
('Prof. Elizabeth Wong', 'Tuesday 10am-1pm, Thursday 2pm-5pm', 'Digital Business and Innovation'),
('Dr. Raymond Chen', 'Monday 1pm-4pm, Wednesday 9am-12pm', 'Personal Development and Emotional Intelligence'),
('Prof. Natasha Ivanova', 'Thursday 9am-12pm, Friday 1pm-4pm', 'Sustainable Business Transformation'),
('Dr. Vincent Moretti', 'Tuesday 9am-12pm, Friday 10am-1pm', 'Financial Decision Making'),
('Prof. Olivia Sanchez', 'Monday 10am-1pm, Wednesday 2pm-5pm', 'Purchasing and Supply Chain Management'),
('Dr. Gregory Powell', 'Tuesday 2pm-5pm, Thursday 9am-12pm', 'Global Business Development and Entrepreneurship'),
('Prof. Diana Rutherford', 'Wednesday 10am-1pm, Friday 2pm-5pm', 'Strategic Customer Management'),
('Dr. Marcus Boone', 'Monday 9am-12pm, Thursday 1pm-4pm', 'Sustainable Corporate Performance'),
('Prof. Eleanor Chang', 'Tuesday 1pm-4pm, Friday 9am-12pm', 'Strategic Management and Leadership'),
('Dr. Patrick O''Connor', 'Wednesday 9am-12pm, Friday 1pm-4pm', 'Work Based/Consultancy Project'),
('Prof. Simone Laurent', 'Monday 2pm-5pm, Thursday 10am-1pm', 'Data Analytics'),
('Dr. Kenneth Reeves', 'Tuesday 9am-12pm, Wednesday 1pm-4pm', 'Advanced Project Management');

INSERT INTO Professors (name, availability, subject) VALUES
('Prof. Derek Stone', 'Monday 10am-1pm, Wednesday 2pm-5pm', 'Introduction to Game Engines'),
('Dr. Anita Patel', 'Tuesday 9am-12pm, Thursday 1pm-4pm', '3D Animation Techniques'),
('Prof. Roland Meyer', 'Wednesday 11am-2pm, Friday 9am-12pm', 'Game Engine Rendering Techniques'),
('Dr. Carla Espinoza', 'Monday 1pm-4pm, Thursday 10am-1pm', 'Advanced Game Development');

INSERT INTO Professors (name, availability, subject) VALUES
('Prof. Leonard Foster', 'Tuesday 10am-1pm, Friday 2pm-5pm', 'Advanced Project Management'),
('Dr. Miriam Goldstein', 'Monday 9am-12pm, Wednesday 1pm-4pm', 'Final Year Project'),
('Prof. Victor Chen', 'Thursday 10am-1pm, Friday 9am-12pm', 'Business Creation Project'),
('Dr. Penelope Whitmore', 'Tuesday 2pm-5pm, Wednesday 9am-12pm', 'Thematic Independent Studies'),
('Prof. Dominic Ferrara', 'Monday 1pm-4pm, Thursday 2pm-5pm', 'E-Business'),
('Dr. Sylvia Nguyen', 'Wednesday 10am-1pm, Friday 1pm-4pm', 'International Human Resource Management (IHRM)');

INSERT INTO Professors (name, availability, subject) VALUES
('Prof. Ian MacAllister', 'Tuesday 9am-12pm, Thursday 2pm-5pm', 'Requirements Management'),
('Dr. Hannah Schroeder', 'Monday 10am-1pm, Wednesday 9am-12pm', 'Computing Education and Communication'),
('Prof. Theodore Banks', 'Thursday 1pm-4pm, Friday 10am-1pm', 'Software Engineering Management'),
('Dr. Rachel Lombardi', 'Tuesday 1pm-4pm, Wednesday 2pm-5pm', 'Information and Content Management'),
('Prof. Julian Mercer', 'Monday 9am-12pm, Friday 2pm-5pm', 'Network Technology'),
('Dr. Fiona O''Donnell', 'Wednesday 1pm-4pm, Thursday 9am-12pm', 'Information Retrieval'),
('Prof. Nathanial West', 'Tuesday 10am-1pm, Friday 9am-12pm', 'IT Security and Privacy Risk Management'),
('Dr. Evan Zhang', 'Monday 2pm-5pm, Wednesday 10am-1pm', 'Advanced Networks');

INSERT INTO Professors (name, availability, subject) VALUES
('Prof. Daniel Harrington', 'Monday 9am-11am, Tuesday 9am-12pm, Thursday 2pm-5pm, Friday 10am-12pm', 'Event Venue Management'),
('Dr. Catherine Bennett', 'Monday 10am-1pm, Tuesday 2pm-4pm, Wednesday 1pm-4pm, Thursday 9am-11am', 'Economics'),
('Prof. Richard Dawson', 'Monday 1pm-3pm, Wednesday 9am-12pm, Thursday 3pm-5pm, Friday 2pm-5pm', 'Business Environment and Economic Trends'),
('Dr. Olivia Sinclair', 'Tuesday 1pm-4pm, Wednesday 10am-12pm, Thursday 10am-1pm, Friday 1pm-3pm', 'Business Intelligence'),
('Prof. Maxwell Carter', 'Monday 2pm-5pm, Tuesday 9am-11am, Wednesday 10am-1pm, Friday 9am-11am', 'Understanding Finance'),
('Dr. Sophia Rodriguez', 'Monday 3pm-5pm, Tuesday 10am-1pm, Wednesday 2pm-4pm, Friday 9am-12pm', 'Marketing and Sales');

-- Additional professors for subjects with more than 60 students
INSERT INTO Professors (name, availability, subject) VALUES
('Prof. Robert Chen', 'Monday 9am-12pm, Wednesday 2pm-5pm', 'Discover Project Management'),
('Dr. Patricia Williams', 'Tuesday 10am-1pm, Thursday 3pm-6pm', 'Discover Project Management'),
('Prof. Jonathan Black', 'Monday 1pm-4pm, Friday 9am-12pm', 'International Business Environment'),
('Dr. Elizabeth Taylor', 'Wednesday 10am-1pm, Friday 2pm-5pm', 'International Business Environment'),
('Prof. Richard Evans', 'Tuesday 9am-12pm, Thursday 1pm-4pm', 'Academic and Professional Communication'),
('Dr. Susan Adams', 'Monday 2pm-5pm, Wednesday 9am-12pm', 'Academic and Professional Communication'),
('Prof. Alan Turing', 'Monday 10am-1pm, Wednesday 2pm-5pm', 'Computer and Communication Systems'),
('Dr. Grace Hopper', 'Tuesday 9am-12pm, Thursday 1pm-4pm', 'Computer and Communication Systems'),
('Prof. Donald Knuth', 'Monday 1pm-4pm, Friday 9am-12pm', 'Paradigms of Programming'),
('Dr. Barbara Liskov', 'Wednesday 10am-1pm, Friday 2pm-5pm', 'Paradigms of Programming'),
('Prof. Linus Torvalds', 'Tuesday 2pm-5pm, Thursday 9am-12pm', 'Algorithms and Data Structures'),
('Dr. Tim Berners-Lee', 'Monday 9am-12pm, Wednesday 1pm-4pm', 'Algorithms and Data Structures'),
('Prof. Margaret Hamilton', 'Monday 10am-1pm, Wednesday 3pm-6pm', 'Principles of Software Engineering'),
('Dr. John Backus', 'Tuesday 1pm-4pm, Thursday 10am-1pm', 'Principles of Software Engineering'),
('Prof. Edsger Dijkstra', 'Monday 2pm-5pm, Friday 9am-12pm', 'Mathematics for Computer Science'),
('Dr. Ada Lovelace', 'Wednesday 9am-12pm, Friday 1pm-4pm', 'Mathematics for Computer Science'),
('Prof. Claude Shannon', 'Tuesday 10am-1pm, Thursday 2pm-5pm', 'Advanced Mathematics for Computer Science'),
('Dr. Alan Kay', 'Monday 1pm-4pm, Wednesday 10am-1pm', 'Advanced Mathematics for Computer Science'),
('Prof. Michael Porter', 'Monday 9am-12pm, Wednesday 2pm-5pm', 'Business Studies, BA Hons'),
('Dr. Philip Kotler', 'Tuesday 10am-1pm, Thursday 3pm-6pm', 'Business Studies, BA Hons'),
('Prof. Clayton Christensen', 'Monday 1pm-4pm, Friday 9am-12pm', 'Business Studies, BA Hons'),
('Dr. Gary Hamel', 'Wednesday 10am-1pm, Friday 2pm-5pm', 'Business Studies, BA Hons'),
('Prof. Vint Cerf', 'Tuesday 9am-12pm, Thursday 1pm-4pm', 'Computing, BSc Hons'),
('Dr. Bob Kahn', 'Monday 2pm-5pm, Wednesday 9am-12pm', 'Computing, BSc Hons'),
('Prof. Andrew Tanenbaum', 'Tuesday 2pm-5pm, Thursday 9am-12pm', 'Computing, BSc Hons'),
('Dr. Bjarne Stroustrup', 'Monday 9am-12pm, Wednesday 1pm-4pm', 'Computing, BSc Hons'),
('Prof. Shigeru Miyamoto', 'Monday 10am-1pm, Wednesday 3pm-6pm', 'Games Development, BSc Hons'),
('Dr. Hideo Kojima', 'Tuesday 1pm-4pm, Thursday 10am-1pm', 'Games Development, BSc Hons'),
('Prof. Gabe Newell', 'Monday 2pm-5pm, Friday 9am-12pm', 'Games Development, BSc Hons'),
('Dr. Tim Sweeney', 'Wednesday 9am-12pm, Friday 1pm-4pm', 'Games Development, BSc Hons'),
('Prof. Jagdish Bhagwati', 'Tuesday 10am-1pm, Thursday 2pm-5pm', 'International Business, BA Hons'),
('Dr. Paul Krugman', 'Monday 1pm-4pm, Wednesday 10am-1pm', 'International Business, BA Hons'),
('Prof. Joseph Stiglitz', 'Monday 9am-12pm, Wednesday 2pm-5pm', 'International Business, BA Hons'),
('Dr. Dani Rodrik', 'Tuesday 10am-1pm, Thursday 3pm-6pm', 'International Business, BA Hons'),
('Prof. Frederick Brooks', 'Monday 1pm-4pm, Friday 9am-12pm', 'Software Engineering, BEng Hons'),
('Dr. Ivar Jacobson', 'Wednesday 10am-1pm, Friday 2pm-5pm', 'Software Engineering, BEng Hons'),
('Prof. Grady Booch', 'Tuesday 9am-12pm, Thursday 1pm-4pm', 'Software Engineering, BEng Hons'),
('Dr. James Martin', 'Monday 2pm-5pm, Wednesday 9am-12pm', 'Software Engineering, BEng Hons'),
('Prof. Nate Silver', 'Tuesday 2pm-5pm, Thursday 9am-12pm', 'Data Science, BSc Hons'),
('Dr. Hadley Wickham', 'Monday 9am-12pm, Wednesday 1pm-4pm', 'Data Science, BSc Hons'),
('Prof. Andrew Ng', 'Monday 10am-1pm, Wednesday 3pm-6pm', 'Data Science, BSc Hons'),
('Dr. Yann LeCun', 'Tuesday 1pm-4pm, Thursday 10am-1pm', 'Data Science, BSc Hons');

INSERT INTO Courses (course_code, course_name, department)
VALUES 
('BM001', 'Business Management (Extended), BA Hons', 'Business and Management'),
('BM002', 'Business Management and Leadership, BA Hons', 'Business and Management'),
('BM003', 'Business Management, BA Hons', 'Business and Management'),
('BM004', 'Business Studies, BA Hons', 'Business and Management'),
('BM005', 'Business Logistics and Supply Chain Management, BA Hons', 'Business and Management'),
('BM006', 'Business Management (Finance), BA Hons', 'Business and Management'),
('BM007', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 'Business and Management'),
('BM008', 'Entrepreneurship and Innovation, BA Hons', 'Business and Management'),
('BM009', 'International Business, BA Hons', 'Business and Management'),
('CS001', 'Business Computing, BSc Hons', 'Computer Science'),
('CS002', 'Computer Science (Artificial Intelligence), BSc Hons', 'Computer Science'),
('CS003', 'Computer Science (Cyber Security), BSc Hons', 'Computer Science'),
('CS004', 'Computer Science (Data Science), BSc Hons', 'Computer Science'),
('CS005', 'Computer Science (Games), BSc Hons', 'Computer Science'),
('CS006', 'Computer Science, BSc Hons', 'Computer Science'),
('CS007', 'Computing, BSc Hons', 'Computer Science'),
('CS008', 'Cyber Security and Digital Forensics, BSc Hons', 'Computer Science'),
('CS009', 'Data Science, BSc Hons', 'Computer Science'),
('CS010', 'Games Development, BSc Hons', 'Computer Science'),
('CS011', 'Mathematics and Computer Science, BSc Hons', 'Computer Science'),
('CS012', 'Software Engineering, BEng Hons', 'Computer Science');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Business Management (Extended), BA Hons', 1, 1, 'Discover Project Management', 'BM101'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 1, 'International Business Environment', 'BM102'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 1, 'Academic and Professional Communication', 'BM103'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 1, 'Business Analytics & Visualisation', 'BM104'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 2, 'Economics for Responsible Business', 'BM105'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 2, 'Accounting and Finance for Business', 'BM106'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 2, 'Managing Contemporary Organisations', 'BM107'),
('Business and Management', 'Business Management (Extended), BA Hons', 1, 2, 'Principles of Marketing in a Global Context', 'BM108'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 1, 'Business Ethics', 'BM201'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 1, 'Organisational Analysis and Performance', 'BM202'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 1, 'Technology & Innovation Management', 'BM203'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 1, 'Management Skills', 'BM204'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 2, 'Business Law', 'BM205'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 2, 'Sustainable Operations Management', 'BM206'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 2, 'Managing Diversity & Inclusion', 'BM207'),
('Business and Management', 'Business Management (Extended), BA Hons', 2, 2, 'Financial Management', 'BM208'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 1, 'Business Strategy', 'BM301'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 1, 'Art of Negotiation', 'BM302'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 1, 'Decision Making Skills', 'BM303'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 1, 'Effective Leadership', 'BM304'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 2, 'International Business Management', 'BM305'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 2, 'Public Sector Management', 'BM306'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 2, 'Dissertation', 'BM311'),
('Business and Management', 'Business Management (Extended), BA Hons', 3, 2, 'Final Year Project: Consultancy Project', 'BM312');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 1, 'Business and Economic Environment', 'BML101'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 1, 'Business Process and Planning', 'BML102'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 1, 'Leadership and Communication', 'BML103'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 1, 'Marketing Principles and Sales Management', 'BML104'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 2, 'Personal and Professional Development', 'BML105'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 2, 'Introduction to Business Processes', 'BML106'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 2, 'Business Planning and Development', 'BML107'),
('Business and Management', 'Business Management and Leadership, BA Hons', 1, 2, 'Economics in Action', 'BML108'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 1, 'Project Management', 'BML201'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 1, 'Fundamentals of Entrepreneurship and Innovation', 'BML202'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 1, 'Operations and Resource Management', 'BML203'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 1, 'Corporate Financial Management', 'BML204'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 2, 'Creativity and Decision Making in Business', 'BML205'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 2, 'Project Planning and Management', 'BML206'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 2, 'Management of Information Systems', 'BML207'),
('Business and Management', 'Business Management and Leadership, BA Hons', 2, 2, 'Operations Management', 'BML208'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 1, 'Global Business', 'BML301'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 1, 'Managerial Strategy and Leadership Development', 'BML302'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 1, 'E-Business and International SCM', 'BML303'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 1, 'Final Year Project', 'BML304'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 2, 'Small Business Development', 'BML305'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 2, 'Managing Strategy', 'BML306'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 2, 'Personal and Professional Practice 3 (SMS)', 'BML307'),
('Business and Management', 'Business Management and Leadership, BA Hons', 3, 2, 'International Logistics and Supply Chain Management', 'BML308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Business Management, BA Hons', 1, 1, 'Discover Project Management', 'BM101'),
('Business and Management', 'Business Management, BA Hons', 1, 1, 'International Business Environment', 'BM102'),
('Business and Management', 'Business Management, BA Hons', 1, 1, 'Academic and Professional Communication', 'BM103'),
('Business and Management', 'Business Management, BA Hons', 1, 1, 'Business Analytics & Visualisation', 'BM104'),
('Business and Management', 'Business Management, BA Hons', 1, 2, 'Economics for Responsible Business', 'BM105'),
('Business and Management', 'Business Management, BA Hons', 1, 2, 'Accounting and Finance for Business', 'BM106'),
('Business and Management', 'Business Management, BA Hons', 1, 2, 'Managing Contemporary Organisations', 'BM107'),
('Business and Management', 'Business Management, BA Hons', 1, 2, 'Principles of Marketing in a Global Context', 'BM108'),
('Business and Management', 'Business Management, BA Hons', 2, 1, 'Business Ethics', 'BM201'),
('Business and Management', 'Business Management, BA Hons', 2, 1, 'Organisational Analysis and Performance', 'BM202'),
('Business and Management', 'Business Management, BA Hons', 2, 1, 'Technology & Innovation Management', 'BM203'),
('Business and Management', 'Business Management, BA Hons', 2, 1, 'Management Skills', 'BM204'),
('Business and Management', 'Business Management, BA Hons', 2, 2, 'Business Law', 'BM205'),
('Business and Management', 'Business Management, BA Hons', 2, 2, 'Sustainable Operations Management', 'BM206'),
('Business and Management', 'Business Management, BA Hons', 2, 2, 'Managing Diversity & Inclusion', 'BM207'),
('Business and Management', 'Business Management, BA Hons', 2, 2, 'Financial Management', 'BM208'),
('Business and Management', 'Business Management, BA Hons', 3, 1, 'Business Strategy', 'BM301'),
('Business and Management', 'Business Management, BA Hons', 3, 1, 'Art of Negotiation', 'BM302'),
('Business and Management', 'Business Management, BA Hons', 3, 1, 'Decision Making Skills', 'BM303'),
('Business and Management', 'Business Management, BA Hons', 3, 1, 'Effective Leadership', 'BM304'),
('Business and Management', 'Business Management, BA Hons', 3, 2, 'International Business Management', 'BM305'),
('Business and Management', 'Business Management, BA Hons', 3, 2, 'Public Sector Management', 'BM306'),
('Business and Management', 'Business Management, BA Hons', 3, 2, 'Final Year Project: Consultancy Project', 'BM312'),
('Business and Management', 'Business Management, BA Hons', 3, 2, 'Venture Creation', 'BM313');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Business Studies, BA Hons', 1, 1, 'Personal and Professional Development', 'BS101'),
('Business and Management', 'Business Studies, BA Hons', 1, 1, 'Introduction to Business Processes', 'BS102'),
('Business and Management', 'Business Studies, BA Hons', 1, 1, 'Business Planning and Development', 'BS103'),
('Business and Management', 'Business Studies, BA Hons', 1, 1, 'Discover Project Management', 'BS104'),
('Business and Management', 'Business Studies, BA Hons', 1, 2, 'Economics in Action', 'BS105'),
('Business and Management', 'Business Studies, BA Hons', 1, 2, 'Introduction to Logistics and Transport', 'BS106'),
('Business and Management', 'Business Studies, BA Hons', 1, 2, 'Fundamentals of Entrepreneurship', 'BS107'),
('Business and Management', 'Business Studies, BA Hons', 1, 2, 'Innovation in Competitive Environments', 'BS108'),
('Business and Management', 'Business Studies, BA Hons', 2, 1, 'Creativity and Decision Making in Business', 'BS201'),
('Business and Management', 'Business Studies, BA Hons', 2, 1, 'Project Planning and Management', 'BS202'),
('Business and Management', 'Business Studies, BA Hons', 2, 1, 'Management of Information Systems', 'BS203'),
('Business and Management', 'Business Studies, BA Hons', 2, 1, 'Operations Management', 'BS204'),
('Business and Management', 'Business Studies, BA Hons', 2, 2, 'Purchasing and Distribution', 'BS205'),
('Business and Management', 'Business Studies, BA Hons', 2, 2, 'Advanced Project Management', 'BS206'),
('Business and Management', 'Business Studies, BA Hons', 2, 2, 'Managing Strategy', 'BS207'),
('Business and Management', 'Business Studies, BA Hons', 2, 2, 'Personal and Professional Practice 3 (SMS)', 'BS208'),
('Business and Management', 'Business Studies, BA Hons', 3, 1, 'International Logistics and Supply Chain Management', 'BS301'),
('Business and Management', 'Business Studies, BA Hons', 3, 1, 'Sustainable Transport', 'BS302'),
('Business and Management', 'Business Studies, BA Hons', 3, 1, 'Final Year Project: Consultancy Project', 'BS303'),
('Business and Management', 'Business Studies, BA Hons', 3, 1, 'Business Creation Project', 'BS304'),
('Business and Management', 'Business Studies, BA Hons', 3, 2, 'Thematic Independent Studies', 'BS305'),
('Business and Management', 'Business Studies, BA Hons', 3, 2, 'International Management and Organisational Functions', 'BS306'),
('Business and Management', 'Business Studies, BA Hons', 3, 2, 'International Logistics and Supply Chain Management', 'BS311'),
('Business and Management', 'Business Studies, BA Hons', 3, 2, 'Sustainable Transport', 'BS312');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 1, 'Personal and Professional Development', 'BL101'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 1, 'Introduction to Business Processes', 'BL102'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 1, 'Business Planning and Development', 'BL103'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 1, 'Discover Project Management', 'BL104'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 2, 'Introduction to Logistics and Transport', 'BL105'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 2, 'Fundamentals of Entrepreneurship', 'BL106'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 2, 'Innovation in Competitive Environments', 'BL107'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 1, 2, 'Project Planning and Management', 'BL108'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 1, 'Purchasing and Distribution', 'BL201'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 1, 'Operations Management', 'BL202'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 1, 'Advanced Project Management', 'BL203'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 1, 'Managing Strategy', 'BL204'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 2, 'Personal and Professional Practice 3 (SMS)', 'BL205'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 2, 'International Logistics and Supply Chain Management', 'BL206'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 2, 'Sustainable Transport', 'BL207'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 2, 2, 'Final Year Project: Consultancy Project', 'BL208'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 1, 'Business Creation Project', 'BL301'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 1, 'Thematic Independent Studies', 'BL302'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 1, 'International Management and Organisational Functions', 'BL303'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 1, 'E-Business', 'BL304'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 2, 'Event Venue Management', 'BL305'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 2, 'Corporate Financial Management', 'BL306'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 2, 'International Human Resource Management (IHRM)', 'BL307'),
('Business and Management', 'Business Logistics and Supply Chain Management, BA Hons', 3, 2, 'International Logistics and Supply Chain Management', 'BL308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Business Management (Finance), BA Hons', 1, 1, 'Discover Project Management', 'BMF101'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 1, 'International Business Environment', 'BMF102'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 1, 'Academic and Professional Communication', 'BMF103'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 1, 'Business Analytics & Visualisation', 'BMF104'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 2, 'Economics for Responsible Business', 'BMF105'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 2, 'Accounting and Finance for Business', 'BMF106'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 2, 'Managing Contemporary Organisations', 'BMF107'),
('Business and Management', 'Business Management (Finance), BA Hons', 1, 2, 'Principles of Marketing in a Global Context', 'BMF108'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 1, 'Business Ethics', 'BMF201'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 1, 'Organisational Analysis and Performance', 'BMF202'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 1, 'Technology & Innovation Management', 'BMF203'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 1, 'Management Skills', 'BMF204'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 2, 'Business Law', 'BMF205'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 2, 'Sustainable Operations Management', 'BMF206'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 2, 'Managing Diversity & Inclusion', 'BMF207'),
('Business and Management', 'Business Management (Finance), BA Hons', 2, 2, 'Financial Management', 'BMF208'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 1, 'Business Strategy', 'BMF301'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 1, 'Art of Negotiation', 'BMF302'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 1, 'Decision Making Skills', 'BMF303'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 1, 'Effective Leadership', 'BMF304'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 2, 'International Business Management', 'BMF305'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 2, 'Public Sector Management', 'BMF306'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 2, 'Final Year Project: Consultancy Project', 'BMF312'),
('Business and Management', 'Business Management (Finance), BA Hons', 3, 2, 'Venture Creation', 'BMF313');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 1, 'Business Environment and Economic Trends', 'CM101'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 1, 'Business Intelligence', 'CM102'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 1, 'Understanding Finance', 'CM103'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 1, 'Marketing and Sales', 'CM104'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 2, 'Principles of Entrepreneurship', 'CM105'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 2, 'Digital Business and Innovation', 'CM106'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 2, 'Personal Development and Emotional Intelligence', 'CM107'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 1, 2, 'Sustainable Business Transformation', 'CM108'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 1, 'Financial Decision Making', 'CM201'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 1, 'Purchasing and Supply Chain Management', 'CM202'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 1, 'Project Management', 'CM203'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 1, 'Global Business Development and Entrepreneurship', 'CM204'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 2, 'Strategic Customer Management', 'CM205'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 2, 'Sustainable Corporate Performance', 'CM206'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 2, 'Strategic Management and Leadership', 'CM207'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 2, 2, 'Work Based/Consultancy Project', 'CM208'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 1, 'Data Analytics', 'CM301'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 1, 'Advanced Project Management', 'CM302'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 1, 'Leadership in Organisations', 'CM303'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 1, 'International Management and Organisational Functions', 'CM304'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 2, 'Internationalisation, Technology & Governments', 'CM305'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 2, 'Strategic Management and Innovation', 'CM306'),
('Business and Management', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 3, 2, 'Big Data and Business Analytics', 'CM307');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 1, 'Fundamentals of Entrepreneurship', 'EI101'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 1, 'Economics', 'EI102'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 1, 'The Impact Mindset', 'EI103'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 1, 'Design Thinking & Innovation', 'EI104'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 2, 'Finance for Managers', 'EI105'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 2, 'Data Analysis & Visualisation', 'EI106'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 2, 'Global Issues', 'EI107'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 1, 2, 'Introduction to Finance for Business', 'EI108'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 1, 'Entrepreneurship in the Global Context', 'EI201'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 1, 'Cross-Cultural Leadership', 'EI202'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 1, 'The Art of Storytelling', 'EI203'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 1, 'Business Ethics', 'EI204'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 2, 'Technology & Innovation Management', 'EI205'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 2, 'Startup Operations', 'EI206'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 2, 'Enterprise Consulting', 'EI207'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 2, 2, 'SDG Action Lab', 'EI208'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 1, 'Perspectives on Entrepreneurship & Small Business Development', 'EI301'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 1, 'Digital Marketing for Startups', 'EI302'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 1, 'Strategy', 'EI303'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 1, 'Responsible Innovation', 'EI304'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 2, 'Negotiations', 'EI305'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 2, 'Entrepreneurship in Action', 'EI306'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 2, 'Venture Creation', 'EI307'),
('Business and Management', 'Entrepreneurship and Innovation, BA Hons', 3, 2, 'Final Year Project: Consultancy Project', 'EI308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Business and Management', 'International Business, BA Hons', 1, 1, 'Personal and Professional Development', 'IB101'),
('Business and Management', 'International Business, BA Hons', 1, 1, 'International Business Functions', 'IB102'),
('Business and Management', 'International Business, BA Hons', 1, 1, 'International Business Environment', 'IB103'),
('Business and Management', 'International Business, BA Hons', 1, 1, 'Fundamentals of International Business Analytics', 'IB104'),
('Business and Management', 'International Business, BA Hons', 1, 2, 'Economics in Action', 'IB105'),
('Business and Management', 'International Business, BA Hons', 1, 2, 'Introduction to Finance for Business', 'IB106'),
('Business and Management', 'International Business, BA Hons', 1, 2, 'Principles of Marketing in a Global Context', 'IB107'),
('Business and Management', 'International Business, BA Hons', 1, 2, 'Business and Economic Environment', 'IB108'),
('Business and Management', 'International Business, BA Hons', 2, 1, 'Cross-cultural Management', 'IB201'),
('Business and Management', 'International Business, BA Hons', 2, 1, 'Business Ethics', 'IB202'),
('Business and Management', 'International Business, BA Hons', 2, 1, 'Managing Global Business Networks', 'IB203'),
('Business and Management', 'International Business, BA Hons', 2, 1, 'Operating in Emerging Markets', 'IB204'),
('Business and Management', 'International Business, BA Hons', 2, 2, 'Consultancy in Practice', 'IB205'),
('Business and Management', 'International Business, BA Hons', 2, 2, 'Intermediate Macroeconomics for Business', 'IB206'),
('Business and Management', 'International Business, BA Hons', 2, 2, 'Intermediate Microeconomics for Business', 'IB207'),
('Business and Management', 'International Business, BA Hons', 2, 2, 'Business Statistics', 'IB208'),
('Business and Management', 'International Business, BA Hons', 3, 1, 'Final Year Project: Consultancy Project', 'IB301'),
('Business and Management', 'International Business, BA Hons', 3, 1, 'Leadership in Organisations', 'IB302'),
('Business and Management', 'International Business, BA Hons', 3, 1, 'International Management and Organisational Functions', 'IB303'),
('Business and Management', 'International Business, BA Hons', 3, 1, 'Internationalisation, Technology & Governments', 'IB304'),
('Business and Management', 'International Business, BA Hons', 3, 2, 'Strategic Management and Innovation', 'IB305'),
('Business and Management', 'International Business, BA Hons', 3, 2, 'Big Data and Business Analytics', 'IB306'),
('Business and Management', 'International Business, BA Hons', 3, 2, 'Global Business', 'IB307'),
('Business and Management', 'International Business, BA Hons', 3, 2, 'Public Sector Management', 'IB308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Business Computing, BSc Hons', 1, 1, 'Introduction to Business Processes', 'BC101'),
('Computer Science', 'Business Computing, BSc Hons', 1, 1, 'Computer Systems and Internet Technologies', 'BC102'),
('Computer Science', 'Business Computing, BSc Hons', 1, 1, 'Object Oriented Programming', 'BC103'),
('Computer Science', 'Business Computing, BSc Hons', 1, 1, 'Programming Foundations', 'BC104'),
('Computer Science', 'Business Computing, BSc Hons', 1, 2, 'Principles of Security', 'BC105'),
('Computer Science', 'Business Computing, BSc Hons', 1, 2, 'Systems Development', 'BC106'),
('Computer Science', 'Business Computing, BSc Hons', 1, 2, 'Software Engineering', 'BC107'),
('Computer Science', 'Business Computing, BSc Hons', 1, 2, 'Introduction to Data Science', 'BC108'),
('Computer Science', 'Business Computing, BSc Hons', 2, 1, 'Professional Project Management', 'BC201'),
('Computer Science', 'Business Computing, BSc Hons', 2, 1, 'Agile Development with SCRUM', 'BC202'),
('Computer Science', 'Business Computing, BSc Hons', 2, 1, 'Data and Web Analytics', 'BC203'),
('Computer Science', 'Business Computing, BSc Hons', 2, 1, 'Information Analysis and Visualisation', 'BC204'),
('Computer Science', 'Business Computing, BSc Hons', 2, 2, 'Operations Management', 'BC205'),
('Computer Science', 'Business Computing, BSc Hons', 2, 2, 'User Interface Design', 'BC206'),
('Computer Science', 'Business Computing, BSc Hons', 2, 2, 'Information Security', 'BC207'),
('Computer Science', 'Business Computing, BSc Hons', 2, 2, 'Web Programming 1', 'BC208'),
('Computer Science', 'Business Computing, BSc Hons', 3, 1, 'Application Development', 'BC301'),
('Computer Science', 'Business Computing, BSc Hons', 3, 1, 'Web Programming 2', 'BC302'),
('Computer Science', 'Business Computing, BSc Hons', 3, 1, 'Data Structures and Algorithms', 'BC303'),
('Computer Science', 'Business Computing, BSc Hons', 3, 1, 'Applications in AI and Data Science', 'BC304'),
('Computer Science', 'Business Computing, BSc Hons', 3, 2, 'Final Year Projects', 'BC305'),
('Computer Science', 'Business Computing, BSc Hons', 3, 2, 'Computing Education and Communication', 'BC306'),
('Computer Science', 'Business Computing, BSc Hons', 3, 2, 'Information and Content Management', 'BC307'),
('Computer Science', 'Business Computing, BSc Hons', 3, 2, 'Human-Computer Interaction and Design', 'BC308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 1, 'Computer and Communication Systems', 'CSAI101'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 1, 'Paradigms of Programming', 'CSAI102'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 1, 'Algorithms and Data Structures', 'CSAI103'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 1, 'Introduction to Compilers', 'CSAI104'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 2, 'Principles of Software Engineering', 'CSAI105'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 2, 'Mathematics for Computer Science', 'CSAI106'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 2, 'Advanced Mathematics for Computer Science', 'CSAI107'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 1, 2, 'Introduction to Artificial Intelligence', 'CSAI108'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 1, 'Advanced Programming', 'CSAI201'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 1, 'Operating Systems', 'CSAI202'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 1, 'Information Security', 'CSAI203'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 1, 'Statistical Techniques with R', 'CSAI204'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 2, 'Introduction to Artificial Intelligence', 'CSAI205'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 2, 'Advanced Algorithms and Data Structures', 'CSAI206'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 2, 'Computational Methods and Numerical Techniques', 'CSAI207'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 2, 2, 'Machine Learning', 'CSAI208'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 1, 'Human-Computer Interaction and Design', 'CSAI301'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 1, 'Final Year Projects', 'CSAI302'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 1, 'Natural Computing', 'CSAI303'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 1, 'Artificial Intelligence Applications', 'CSAI304'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 2, 'Machine Learning', 'CSAI305'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 2, 'Responsible Artificial Intelligence', 'CSAI306'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 2, 'Optimisation Techniques', 'CSAI307'),
('Computer Science', 'Computer Science (Artificial Intelligence), BSc Hons', 3, 2, 'Advanced Optimisation Techniques', 'CSAI308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 1, 'Computer and Communication Systems', 'CSCS101'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 1, 'Paradigms of Programming', 'CSCS102'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 1, 'Algorithms and Data Structures', 'CSCS103'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 1, 'Introduction to Compilers', 'CSCS104'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 2, 'Principles of Software Engineering', 'CSCS105'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 2, 'Mathematics for Computer Science', 'CSCS106'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 2, 'Advanced Mathematics for Computer Science', 'CSCS107'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 1, 2, 'Introduction to Computer Forensics', 'CSCS108'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 1, 'Advanced Programming', 'CSCS201'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 1, 'Computer Networks', 'CSCS202'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 1, 'Operating Systems', 'CSCS203'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 1, 'Information Security', 'CSCS204'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 2, 'Advanced Algorithms and Data Structures', 'CSCS205'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 2, 'Computational Methods and Numerical Techniques', 'CSCS206'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 2, 'Introduction to Computer Forensics', 'CSCS207'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 2, 2, 'Network Security', 'CSCS208'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 1, 'Penetration Testing and Ethical Vulnerability Scanning', 'CSCS301'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 1, 'Final Year Projects', 'CSCS302'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 1, 'Computer Forensics 3', 'CSCS303'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 1, 'Coding and Cryptography', 'CSCS304'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 2, 'Network Security', 'CSCS305'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 2, 'Advanced Networks', 'CSCS306'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 2, 'Information Visualisation and Big Data', 'CSCS307'),
('Computer Science', 'Computer Science (Cyber Security), BSc Hons', 3, 2, 'Artificial Intelligence Applications', 'CSCS308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 1, 'Vectors and Matrices', 'CSDS101'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 1, 'Mathematical Coding', 'CSDS102'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 1, 'Calculus and Mathematical Analysis', 'CSDS103'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 1, 'Discrete Mathematics', 'CSDS104'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 2, 'Our Mathematical World', 'CSDS105'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 2, 'Analysis of Data', 'CSDS106'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 2, 'Probability and Randomness', 'CSDS107'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 1, 2, 'Introduction to Data Science', 'CSDS108'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 1, 'Applications in AI and Data Science', 'CSDS201'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 1, 'Big Data Analysis and Visualisation', 'CSDS202'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 1, 'Linear Algebra and Differential Equations', 'CSDS203'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 1, 'Operational Research: Linear Programming', 'CSDS204'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 2, 'Vector Calculus', 'CSDS205'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 2, 'Statistical Data Analysis and Time Series', 'CSDS206'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 2, 'Machine Learning', 'CSDS207'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 2, 2, 'Responsible Artificial Intelligence', 'CSDS208'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 1, 'Optimisation Techniques', 'CSDS301'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 1, 'Advanced Optimisation Techniques', 'CSDS302'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 1, 'Linear Models and Statistical Inference', 'CSDS303'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 1, 'Research Methods and Mathematics Project', 'CSDS304'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 2, 'Mathematics Work Placement', 'CSDS305'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 2, 'Financial Time Series', 'CSDS306'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 2, 'Graph Theory and Applications', 'CSDS307'),
('Computer Science', 'Computer Science (Data Science), BSc Hons', 3, 2, 'Bayesian Methods and Their Applications', 'CSDS308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 1, '3D Modelling', 'CSG101'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 1, 'Accessible Interface Design', 'CSG102'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 1, 'Physics and Mathematics for Games Development', 'CSG103'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 1, 'Version Control and Asset Management', 'CSG104'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 2, 'Games Design', 'CSG105'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 2, 'Object Oriented Programming for Games', 'CSG106'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 2, 'Programming for Games', 'CSG107'),
('Computer Science', 'Computer Science (Games), BSc Hons', 1, 2, 'Introduction to Game Engines', 'CSG108'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 1, 'Games Technology', 'CSG201'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 1, 'Games Portfolio', 'CSG202'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 1, 'Advanced Algorithms and Data Structures', 'CSG203'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 1, 'Computational Methods and Numerical Techniques', 'CSG204'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 2, '3D Animation Techniques', 'CSG205'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 2, 'Game Engine Rendering Techniques', 'CSG206'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 2, 'Artificial Intelligence for Games', 'CSG207'),
('Computer Science', 'Computer Science (Games), BSc Hons', 2, 2, 'Shader Programming', 'CSG208'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 1, 'Final Year Group Project', 'CSG301'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 1, 'Final Year Individual Project', 'CSG302'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 1, 'Rapid Prototyping', 'CSG303'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 1, 'Extended Realities', 'CSG304'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 2, 'Game Audio', 'CSG305'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 2, 'Character Animation and Control', 'CSG306'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 2, 'Visual Effects for Games', 'CSG307'),
('Computer Science', 'Computer Science (Games), BSc Hons', 3, 2, 'Advanced Game Development', 'CSG308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Computer Science, BSc Hons', 1, 1, 'Computer and Communication Systems', 'CS101'),
('Computer Science', 'Computer Science, BSc Hons', 1, 1, 'Paradigms of Programming', 'CS102'),
('Computer Science', 'Computer Science, BSc Hons', 1, 1, 'Algorithms and Data Structures', 'CS103'),
('Computer Science', 'Computer Science, BSc Hons', 1, 1, 'Introduction to Compilers', 'CS104'),
('Computer Science', 'Computer Science, BSc Hons', 1, 2, 'Principles of Software Engineering', 'CS105'),
('Computer Science', 'Computer Science, BSc Hons', 1, 2, 'Mathematics for Computer Science', 'CS106'),
('Computer Science', 'Computer Science, BSc Hons', 1, 2, 'Advanced Mathematics for Computer Science', 'CS107'),
('Computer Science', 'Computer Science, BSc Hons', 1, 2, 'Introduction to Artificial Intelligence', 'CS108'),
('Computer Science', 'Computer Science, BSc Hons', 2, 1, 'Advanced Programming', 'CS201'),
('Computer Science', 'Computer Science, BSc Hons', 2, 1, 'Operating Systems', 'CS202'),
('Computer Science', 'Computer Science, BSc Hons', 2, 1, 'Information Security', 'CS203'),
('Computer Science', 'Computer Science, BSc Hons', 2, 1, 'Introduction to Artificial Intelligence', 'CS204'),
('Computer Science', 'Computer Science, BSc Hons', 2, 2, 'Advanced Algorithms and Data Structures', 'CS205'),
('Computer Science', 'Computer Science, BSc Hons', 2, 2, 'Computational Methods and Numerical Techniques', 'CS206'),
('Computer Science', 'Computer Science, BSc Hons', 2, 2, 'Introduction to Computer Forensics', 'CS207'),
('Computer Science', 'Computer Science, BSc Hons', 2, 2, 'Statistical Techniques with R', 'CS208'),
('Computer Science', 'Computer Science, BSc Hons', 3, 1, 'Human-Computer Interaction and Design', 'CS301'),
('Computer Science', 'Computer Science, BSc Hons', 3, 1, 'Final Year Projects', 'CS302'),
('Computer Science', 'Computer Science, BSc Hons', 3, 1, 'JVM Programming Languages', 'CS303'),
('Computer Science', 'Computer Science, BSc Hons', 3, 1, 'Penetration Testing and Ethical Vulnerability Scanning', 'CS304'),
('Computer Science', 'Computer Science, BSc Hons', 3, 2, 'Natural Computing', 'CS305'),
('Computer Science', 'Computer Science, BSc Hons', 3, 2, 'Computer Forensics 3', 'CS306'),
('Computer Science', 'Computer Science, BSc Hons', 3, 2, 'Information Visualisation and Big Data', 'CS307'),
('Computer Science', 'Computer Science, BSc Hons', 3, 2, 'Artificial Intelligence Applications', 'CS308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Computing, BSc Hons', 1, 1, 'Computer Systems and Internet Technologies', 'C101'),
('Computer Science', 'Computing, BSc Hons', 1, 1, 'Object Oriented Programming', 'C102'),
('Computer Science', 'Computing, BSc Hons', 1, 1, 'Programming Foundations', 'C103'),
('Computer Science', 'Computing, BSc Hons', 1, 1, 'Principles of Security', 'C104'),
('Computer Science', 'Computing, BSc Hons', 1, 2, 'Systems Development', 'C105'),
('Computer Science', 'Computing, BSc Hons', 1, 2, 'Software Engineering', 'C106'),
('Computer Science', 'Computing, BSc Hons', 1, 2, 'Introduction to Data Science', 'C107'),
('Computer Science', 'Computing, BSc Hons', 1, 2, 'Mathematics for Computing', 'C108'),
('Computer Science', 'Computing, BSc Hons', 2, 1, 'Application Development', 'C201'),
('Computer Science', 'Computing, BSc Hons', 2, 1, 'Professional Project Management', 'C202'),
('Computer Science', 'Computing, BSc Hons', 2, 1, 'User Interface Design', 'C203'),
('Computer Science', 'Computing, BSc Hons', 2, 1, 'Agile Development with SCRUM', 'C204'),
('Computer Science', 'Computing, BSc Hons', 2, 2, 'Web Programming 1', 'C205'),
('Computer Science', 'Computing, BSc Hons', 2, 2, 'Web Programming 2', 'C206'),
('Computer Science', 'Computing, BSc Hons', 2, 2, 'Information Security', 'C207'),
('Computer Science', 'Computing, BSc Hons', 2, 2, 'Data and Web Analytics', 'C208'),
('Computer Science', 'Computing, BSc Hons', 3, 1, 'Human-Computer Interaction and Design', 'C301'),
('Computer Science', 'Computing, BSc Hons', 3, 1, 'Final Year Projects', 'C302'),
('Computer Science', 'Computing, BSc Hons', 3, 1, 'Requirements Management', 'C303'),
('Computer Science', 'Computing, BSc Hons', 3, 1, 'Computing Education and Communication', 'C304'),
('Computer Science', 'Computing, BSc Hons', 3, 2, 'Information and Content Management', 'C305'),
('Computer Science', 'Computing, BSc Hons', 3, 2, 'Network Technology', 'C306'),
('Computer Science', 'Computing, BSc Hons', 3, 2, 'Information Retrieval', 'C307'),
('Computer Science', 'Computing, BSc Hons', 3, 2, 'IT Security and Privacy Risk Management', 'C308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 1, 'Computer and Communication Systems', 'CSDF101'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 1, 'Paradigms of Programming', 'CSDF102'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 1, 'Algorithms and Data Structures', 'CSDF103'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 1, 'Introduction to Compilers', 'CSDF104'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 2, 'Principles of Software Engineering', 'CSDF105'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 2, 'Mathematics for Computer Science', 'CSDF106'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 2, 'Advanced Mathematics for Computer Science', 'CSDF107'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 1, 2, 'Introduction to Computer Forensics', 'CSDF108'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 1, 'Advanced Programming', 'CSDF201'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 1, 'Computer Networks', 'CSDF202'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 1, 'Operating Systems', 'CSDF203'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 1, 'Information Security', 'CSDF204'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 2, 'Advanced Algorithms and Data Structures', 'CSDF205'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 2, 'Computational Methods and Numerical Techniques', 'CSDF206'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 2, 'Introduction to Computer Forensics', 'CSDF207'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 2, 2, 'Network Security', 'CSDF208'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 1, 'Penetration Testing and Ethical Vulnerability Scanning', 'CSDF301'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 1, 'Final Year Projects', 'CSDF302'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 1, 'Computer Forensics 3', 'CSDF303'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 1, 'Coding and Cryptography', 'CSDF304'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 2, 'Network Security', 'CSDF305'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 2, 'Advanced Networks', 'CSDF306'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 2, 'Information Visualisation and Big Data', 'CSDF307'),
('Computer Science', 'Cyber Security and Digital Forensics, BSc Hons', 3, 2, 'Artificial Intelligence Applications', 'CSDF308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Data Science, BSc Hons', 1, 1, 'Vectors and Matrices', 'DS101'),
('Computer Science', 'Data Science, BSc Hons', 1, 1, 'Mathematical Coding', 'DS102'),
('Computer Science', 'Data Science, BSc Hons', 1, 1, 'Calculus and Mathematical Analysis', 'DS103'),
('Computer Science', 'Data Science, BSc Hons', 1, 1, 'Discrete Mathematics', 'DS104'),
('Computer Science', 'Data Science, BSc Hons', 1, 2, 'Our Mathematical World', 'DS105'),
('Computer Science', 'Data Science, BSc Hons', 1, 2, 'Analysis of Data', 'DS106'),
('Computer Science', 'Data Science, BSc Hons', 1, 2, 'Probability and Randomness', 'DS107'),
('Computer Science', 'Data Science, BSc Hons', 1, 2, 'Introduction to Data Science', 'DS108'),
('Computer Science', 'Data Science, BSc Hons', 2, 1, 'Applications in AI and Data Science', 'DS201'),
('Computer Science', 'Data Science, BSc Hons', 2, 1, 'Big Data Analysis and Visualisation', 'DS202'),
('Computer Science', 'Data Science, BSc Hons', 2, 1, 'Linear Algebra and Differential Equations', 'DS203'),
('Computer Science', 'Data Science, BSc Hons', 2, 1, 'Operational Research: Linear Programming', 'DS204'),
('Computer Science', 'Data Science, BSc Hons', 2, 2, 'Vector Calculus', 'DS205'),
('Computer Science', 'Data Science, BSc Hons', 2, 2, 'Statistical Data Analysis and Time Series', 'DS206'),
('Computer Science', 'Data Science, BSc Hons', 2, 2, 'Machine Learning', 'DS207'),
('Computer Science', 'Data Science, BSc Hons', 2, 2, 'Responsible Artificial Intelligence', 'DS208'),
('Computer Science', 'Data Science, BSc Hons', 3, 1, 'Optimisation Techniques', 'DS301'),
('Computer Science', 'Data Science, BSc Hons', 3, 1, 'Advanced Optimisation Techniques', 'DS302'),
('Computer Science', 'Data Science, BSc Hons', 3, 1, 'Linear Models and Statistical Inference', 'DS303'),
('Computer Science', 'Data Science, BSc Hons', 3, 1, 'Research Methods and Mathematics Project', 'DS304'),
('Computer Science', 'Data Science, BSc Hons', 3, 2, 'Mathematics Work Placement', 'DS305'),
('Computer Science', 'Data Science, BSc Hons', 3, 2, 'Financial Time Series', 'DS306'),
('Computer Science', 'Data Science, BSc Hons', 3, 2, 'Graph Theory and Applications', 'DS307'),
('Computer Science', 'Data Science, BSc Hons', 3, 2, 'Bayesian Methods and Their Applications', 'DS308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Games Development, BSc Hons', 1, 1, '3D Modelling', 'GD101'),
('Computer Science', 'Games Development, BSc Hons', 1, 1, 'Accessible Interface Design', 'GD102'),
('Computer Science', 'Games Development, BSc Hons', 1, 1, 'Physics and Mathematics for Games Development', 'GD103'),
('Computer Science', 'Games Development, BSc Hons', 1, 1, 'Version Control and Asset Management', 'GD104'),
('Computer Science', 'Games Development, BSc Hons', 1, 2, 'Games Design', 'GD105'),
('Computer Science', 'Games Development, BSc Hons', 1, 2, 'Object Oriented Programming for Games', 'GD106'),
('Computer Science', 'Games Development, BSc Hons', 1, 2, 'Programming for Games', 'GD107'),
('Computer Science', 'Games Development, BSc Hons', 1, 2, 'Introduction to Game Engines', 'GD108'),
('Computer Science', 'Games Development, BSc Hons', 2, 1, 'Games Technology', 'GD201'),
('Computer Science', 'Games Development, BSc Hons', 2, 1, 'Games Portfolio', 'GD202'),
('Computer Science', 'Games Development, BSc Hons', 2, 1, 'Advanced Algorithms and Data Structures', 'GD203'),
('Computer Science', 'Games Development, BSc Hons', 2, 1, 'Computational Methods and Numerical Techniques', 'GD204'),
('Computer Science', 'Games Development, BSc Hons', 2, 2, '3D Animation Techniques', 'GD205'),
('Computer Science', 'Games Development, BSc Hons', 2, 2, 'Game Engine Rendering Techniques', 'GD206'),
('Computer Science', 'Games Development, BSc Hons', 2, 2, 'Artificial Intelligence for Games', 'GD207'),
('Computer Science', 'Games Development, BSc Hons', 2, 2, 'Shader Programming', 'GD208'),
('Computer Science', 'Games Development, BSc Hons', 3, 1, 'Final Year Group Project', 'GD301'),
('Computer Science', 'Games Development, BSc Hons', 3, 1, 'Final Year Individual Project', 'GD302'),
('Computer Science', 'Games Development, BSc Hons', 3, 1, 'Rapid Prototyping', 'GD303'),
('Computer Science', 'Games Development, BSc Hons', 3, 1, 'Extended Realities', 'GD304'),
('Computer Science', 'Games Development, BSc Hons', 3, 2, 'Game Audio', 'GD305'),
('Computer Science', 'Games Development, BSc Hons', 3, 2, 'Character Animation and Control', 'GD306'),
('Computer Science', 'Games Development, BSc Hons', 3, 2, 'Visual Effects for Games', 'GD307'),
('Computer Science', 'Games Development, BSc Hons', 3, 2, 'Advanced Game Development', 'GD308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 1, 'Paradigms of Programming', 'MCS101'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 1, 'Algorithms and Data Structures', 'MCS102'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 1, 'Vectors and Matrices', 'MCS103'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 1, 'Calculus and Mathematical Analysis', 'MCS104'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 2, 'Analysis of Data', 'MCS105'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 2, 'Probability and Randomness', 'MCS106'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 2, 'Introduction to Artificial Intelligence', 'MCS107'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 1, 2, 'Mathematics for Computer Science', 'MCS108'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 1, 'Advanced Programming', 'MCS201'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 1, 'Information Security', 'MCS202'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 1, 'Introduction to Artificial Intelligence', 'MCS203'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 1, 'Advanced Algorithms and Data Structures', 'MCS204'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 2, 'Linear Algebra and Differential Equations', 'MCS205'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 2, 'Operational Research: Linear Programming', 'MCS206'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 2, 'Vector Calculus', 'MCS207'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 2, 2, 'Statistical Data Analysis and Time Series', 'MCS208'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 1, 'Machine Learning', 'MCS301'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 1, 'Artificial Intelligence Applications', 'MCS302'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 1, 'Coding and Cryptography', 'MCS303'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 1, 'Research Methods and Mathematics Project', 'MCS304'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 2, 'Mathematics Work Placement', 'MCS305'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 2, 'Natural Computing', 'MCS306'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 2, 'JVM Programming Languages', 'MCS307'),
('Computer Science', 'Mathematics and Computer Science, BSc Hons', 3, 2, 'Information Visualisation and Big Data', 'MCS308');

INSERT INTO Departments (department_name, course_name, year, term, subject_name, subject_code) VALUES
('Computer Science', 'Software Engineering, BEng Hons', 1, 1, 'Computer and Communication Systems', 'SE101'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 1, 'Paradigms of Programming', 'SE102'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 1, 'Algorithms and Data Structures', 'SE103'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 1, 'Introduction to Compilers', 'SE104'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 2, 'Principles of Software Engineering', 'SE105'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 2, 'Mathematics for Computer Science', 'SE106'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 2, 'Advanced Mathematics for Computer Science', 'SE107'),
('Computer Science', 'Software Engineering, BEng Hons', 1, 2, 'Introduction to Artificial Intelligence', 'SE108'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 1, 'Advanced Programming', 'SE201'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 1, 'Operating Systems', 'SE202'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 1, 'Information Security', 'SE203'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 1, 'Introduction to Artificial Intelligence', 'SE204'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 2, 'Advanced Algorithms and Data Structures', 'SE205'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 2, 'Computational Methods and Numerical Techniques', 'SE206'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 2, 'Introduction to Computer Forensics', 'SE207'),
('Computer Science', 'Software Engineering, BEng Hons', 2, 2, 'Statistical Techniques with R', 'SE208'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 1, 'Human-Computer Interaction and Design', 'SE301'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 1, 'Final Year Projects', 'SE302'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 1, 'Software Engineering Management', 'SE303'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 1, 'Penetration Testing and Ethical Vulnerability Scanning', 'SE304'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 2, 'Natural Computing', 'SE305'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 2, 'Computer Forensics 3', 'SE306'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 2, 'JVM Programming Languages', 'SE307'),
('Computer Science', 'Software Engineering, BEng Hons', 3, 2, 'Information Visualisation and Big Data', 'SE308');


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    course_code VARCHAR(10),
    course_name VARCHAR(255),
    department VARCHAR(50),
    year INT
);

-- Insert all student records with auto-incremented student_id
INSERT INTO students (student_id, course_code, course_name, department, year)
WITH RECURSIVE 
-- Generate numbers from 1 to 300 
numbers (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 300
),
-- Combine all courses and their student counts
all_courses AS (
    SELECT 'BM001' AS course_code, 'Business Management (Extended), BA Hons' AS course_name, 'Business and Management' AS department, 1 AS year, 98 AS num_students UNION ALL
    SELECT 'BM002', 'Business Management and Leadership, BA Hons', 'Business and Management', 1, 60 UNION ALL
    SELECT 'BM003', 'Business Management, BA Hons', 'Business and Management', 1, 82 UNION ALL
    SELECT 'BM004', 'Business Studies, BA Hons', 'Business and Management', 1, 134 UNION ALL
    SELECT 'BM005', 'Business Logistics and Supply Chain Management, BA Hons', 'Business and Management', 1, 45 UNION ALL
    SELECT 'BM006', 'Business Management (Finance), BA Hons', 'Business and Management', 1, 73 UNION ALL
    SELECT 'BM007', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 'Business and Management', 1, 81 UNION ALL
    SELECT 'BM008', 'Entrepreneurship and Innovation, BA Hons', 'Business and Management', 1, 70 UNION ALL
    SELECT 'BM009', 'International Business, BA Hons', 'Business and Management', 1, 112 UNION ALL
    -- Year 2
    SELECT 'BM001', 'Business Management (Extended), BA Hons', 'Business and Management', 2, 90 UNION ALL
    SELECT 'BM002', 'Business Management and Leadership, BA Hons', 'Business and Management', 2, 55 UNION ALL
    SELECT 'BM003', 'Business Management, BA Hons', 'Business and Management', 2, 162 UNION ALL
    SELECT 'BM004', 'Business Studies, BA Hons', 'Business and Management', 2, 125 UNION ALL
    SELECT 'BM005', 'Business Logistics and Supply Chain Management, BA Hons', 'Business and Management', 2, 44 UNION ALL
    SELECT 'BM006', 'Business Management (Finance), BA Hons', 'Business and Management', 2, 68 UNION ALL
    SELECT 'BM007', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 'Business and Management', 2, 113 UNION ALL
    SELECT 'BM008', 'Entrepreneurship and Innovation, BA Hons', 'Business and Management', 2, 57 UNION ALL
    SELECT 'BM009', 'International Business, BA Hons', 'Business and Management', 2, 78 UNION ALL
    -- Year 3
    SELECT 'BM001', 'Business Management (Extended), BA Hons', 'Business and Management', 3, 87 UNION ALL
    SELECT 'BM002', 'Business Management and Leadership, BA Hons', 'Business and Management', 3, 93 UNION ALL
    SELECT 'BM003', 'Business Management, BA Hons', 'Business and Management', 3, 78 UNION ALL
    SELECT 'BM004', 'Business Studies, BA Hons', 'Business and Management', 3, 63 UNION ALL
    SELECT 'BM005', 'Business Logistics and Supply Chain Management, BA Hons', 'Business and Management', 3, 55 UNION ALL
    SELECT 'BM006', 'Business Management (Finance), BA Hons', 'Business and Management', 3, 65 UNION ALL
    SELECT 'BM007', 'Chartered Manager Degree Apprenticeship - Business Administration, BSc Hons', 'Business and Management', 3, 78 UNION ALL
    SELECT 'BM008', 'Entrepreneurship and Innovation, BA Hons', 'Business and Management', 3, 59 UNION ALL
    SELECT 'BM009', 'International Business, BA Hons', 'Business and Management', 3, 93 UNION ALL
    -- Computer Science Courses
    -- Year 1
    SELECT 'CS001', 'Business Computing, BSc Hons', 'Computer Science', 1, 74 UNION ALL
    SELECT 'CS002', 'Computer Science (Artificial Intelligence), BSc Hons', 'Computer Science', 1, 119 UNION ALL
    SELECT 'CS003', 'Computer Science (Cyber Security), BSc Hons', 'Computer Science', 1, 82 UNION ALL
    SELECT 'CS004', 'Computer Science (Data Science), BSc Hons', 'Computer Science', 1, 64 UNION ALL
    SELECT 'CS005', 'Computer Science (Games), BSc Hons', 'Computer Science', 1, 90 UNION ALL
    SELECT 'CS006', 'Computer Science, BSc Hons', 'Computer Science', 1, 60 UNION ALL
    SELECT 'CS007', 'Computing, BSc Hons', 'Computer Science', 1, 141 UNION ALL
    SELECT 'CS008', 'Cyber Security and Digital Forensics, BSc Hons', 'Computer Science', 1, 89 UNION ALL
    SELECT 'CS009', 'Data Science, BSc Hons', 'Computer Science', 1, 74 UNION ALL
    SELECT 'CS010', 'Games Development, BSc Hons', 'Computer Science', 1, 56 UNION ALL
    SELECT 'CS011', 'Mathematics and Computer Science, BSc Hons', 'Computer Science', 1, 82 UNION ALL
    SELECT 'CS012', 'Software Engineering, BEng Hons', 'Computer Science', 1, 58 UNION ALL
    -- Year 2
    SELECT 'CS001', 'Business Computing, BSc Hons', 'Computer Science', 2, 60 UNION ALL
    SELECT 'CS002', 'Computer Science (Artificial Intelligence), BSc Hons', 'Computer Science', 2, 90 UNION ALL
    SELECT 'CS003', 'Computer Science (Cyber Security), BSc Hons', 'Computer Science', 2, 64 UNION ALL
    SELECT 'CS004', 'Computer Science (Data Science), BSc Hons', 'Computer Science', 2, 67 UNION ALL
    SELECT 'CS005', 'Computer Science (Games), BSc Hons', 'Computer Science', 2, 83 UNION ALL
    SELECT 'CS006', 'Computer Science, BSc Hons', 'Computer Science', 2, 44 UNION ALL
    SELECT 'CS007', 'Computing, BSc Hons', 'Computer Science', 2, 132 UNION ALL
    SELECT 'CS008', 'Cyber Security and Digital Forensics, BSc Hons', 'Computer Science', 2, 72 UNION ALL
    SELECT 'CS009', 'Data Science, BSc Hons', 'Computer Science', 2, 50 UNION ALL
    SELECT 'CS010', 'Games Development, BSc Hons', 'Computer Science', 2, 155 UNION ALL
    SELECT 'CS011', 'Mathematics and Computer Science, BSc Hons', 'Computer Science', 2, 62 UNION ALL
    SELECT 'CS012', 'Software Engineering, BEng Hons', 'Computer Science', 2, 125 UNION ALL
    -- Year 3
    SELECT 'CS001', 'Business Computing, BSc Hons', 'Computer Science', 3, 54 UNION ALL
    SELECT 'CS002', 'Computer Science (Artificial Intelligence), BSc Hons', 'Computer Science', 3, 46 UNION ALL
    SELECT 'CS003', 'Computer Science (Cyber Security), BSc Hons', 'Computer Science', 3, 52 UNION ALL
    SELECT 'CS004', 'Computer Science (Data Science), BSc Hons', 'Computer Science', 3, 55 UNION ALL
    SELECT 'CS005', 'Computer Science (Games), BSc Hons', 'Computer Science', 3, 67 UNION ALL
    SELECT 'CS006', 'Computer Science, BSc Hons', 'Computer Science', 3, 45 UNION ALL
    SELECT 'CS007', 'Computing, BSc Hons', 'Computer Science', 3, 61 UNION ALL
    SELECT 'CS008', 'Cyber Security and Digital Forensics, BSc Hons', 'Computer Science', 3, 43 UNION ALL
    SELECT 'CS009', 'Data Science, BSc Hons', 'Computer Science', 3, 40 UNION ALL
    SELECT 'CS010', 'Games Development, BSc Hons', 'Computer Science', 3, 53 UNION ALL
    SELECT 'CS011', 'Mathematics and Computer Science, BSc Hons', 'Computer Science', 3, 55 UNION ALL
    SELECT 'CS012', 'Software Engineering, BEng Hons', 'Computer Science', 3, 60
)
SELECT 
    55554 + ROW_NUMBER() OVER (ORDER BY department, course_code, year, n) AS student_id,
    course_code,
    course_name,
    department,
    year
FROM all_courses
JOIN numbers ON numbers.n <= all_courses.num_students;

CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50),
    building_name VARCHAR(100),
    room_name VARCHAR(100),
    room_type VARCHAR(50),
    capacity INT
);

-- Cities 
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityNorth', NULL, NULL, NULL, 0),  
('CityEast',  NULL, NULL, NULL, 0);  

-- Buildings in CityNorth
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityNorth', 'Johnson Hall',   NULL, NULL, 0),
('CityNorth', 'Adams Hall',     NULL, NULL, 0),
('CityNorth', 'Greenwood Bldg', NULL, NULL, 0);

-- Buildings in CityEast
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityEast', 'Taylor Complex', NULL, NULL, 0),
('CityEast', 'Wilson Building', NULL, NULL, 0);

-- Rooms in Johnson Hall (CityNorth) 
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityNorth', 'Johnson Hall', 'Classroom JH-101', 'Classroom', 40),
('CityNorth', 'Johnson Hall', 'Classroom JH-102', 'Classroom', 45),
('CityNorth', 'Johnson Hall', 'Classroom JH-103', 'Classroom', 35),
('CityNorth', 'Johnson Hall', 'Classroom JH-104', 'Classroom', 30),
('CityNorth', 'Johnson Hall', 'Classroom JH-105', 'Classroom', 25),
('CityNorth', 'Johnson Hall', 'Classroom JH-106', 'Classroom', 30),  
('CityNorth', 'Johnson Hall', 'Classroom JH-107', 'Classroom', 35), 
('CityNorth', 'Johnson Hall', 'Classroom JH-108', 'Classroom', 35),
('CityNorth', 'Johnson Hall', 'Classroom JH-109', 'Classroom', 35),
('CityNorth', 'Johnson Hall', 'Lecture Theatre JH-LT1', 'LectureTheatre', 200),
('CityNorth', 'Johnson Hall', 'Lecture Theatre JH-LT3', 'LectureTheatre', 150),
('CityNorth', 'Johnson Hall', 'Lecture Theatre JH-LT4', 'LectureTheatre', 200),
('CityNorth', 'Johnson Hall', 'Lecture Theatre JH-LT2', 'LectureTheatre', 280);

-- Rooms in Adams Hall (CityNorth) 
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityNorth', 'Adams Hall', 'Classroom AH-201', 'Classroom', 45),
('CityNorth', 'Adams Hall', 'Classroom AH-202', 'Classroom', 45),
('CityNorth', 'Adams Hall', 'Classroom AH-203', 'Classroom', 50),
('CityNorth', 'Adams Hall', 'Classroom AH-204', 'Classroom', 40),
('CityNorth', 'Adams Hall', 'Classroom AH-205', 'Classroom', 35),  
('CityNorth', 'Adams Hall', 'Classroom AH-206', 'Classroom', 30),
('CityNorth', 'Adams Hall', 'Classroom AH-207', 'Classroom', 30),
('CityNorth', 'Adams Hall', 'Classroom AH-208', 'Classroom', 30),
('CityNorth', 'Adams Hall', 'Classroom AH-209', 'Classroom', 30),  
('CityNorth', 'Adams Hall', 'Lecture Theatre AH-LT1', 'LectureTheatre', 150),
('CityNorth', 'Adams Hall', 'Lecture Theatre AH-LT2', 'LectureTheatre', 150),
('CityNorth', 'Adams Hall', 'Lecture Theatre AH-LT3', 'LectureTheatre', 150);

-- Rooms in Greenwood Bldg (CityNorth) 
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityNorth', 'Greenwood Bldg', 'Classroom GB-301', 'Classroom', 35),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-302', 'Classroom', 35),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-303', 'Classroom', 40),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-304', 'Classroom', 30),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-305', 'Classroom', 50),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-306', 'Classroom', 25),  
('CityNorth', 'Greenwood Bldg', 'Classroom GB-307', 'Classroom', 30),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-308', 'Classroom', 30),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-309', 'Classroom', 30),
('CityNorth', 'Greenwood Bldg', 'Classroom GB-310', 'Classroom', 30),  
('CityNorth', 'Greenwood Bldg', 'Lecture Theatre GB-LT1', 'LectureTheatre', 160),
('CityNorth', 'Greenwood Bldg', 'Lecture Theatre GB-LT2', 'LectureTheatre', 160),
('CityNorth', 'Greenwood Bldg', 'Lecture Theatre GB-LT3', 'LectureTheatre', 160);

-- Rooms in Taylor Complex (CityEast)
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityEast', 'Taylor Complex', 'Classroom TC-401', 'Classroom', 50),
('CityEast', 'Taylor Complex', 'Classroom TC-402', 'Classroom', 45),
('CityEast', 'Taylor Complex', 'Classroom TC-403', 'Classroom', 35),
('CityEast', 'Taylor Complex', 'Classroom TC-404', 'Classroom', 40),
('CityEast', 'Taylor Complex', 'Classroom TC-405', 'Classroom', 30),  
('CityEast', 'Taylor Complex', 'Classroom TC-406', 'Classroom', 25),  
('CityEast', 'Taylor Complex', 'Classroom TC-407', 'Classroom', 30),
('CityEast', 'Taylor Complex', 'Classroom TC-408', 'Classroom', 30),
('CityEast', 'Taylor Complex', 'Classroom TC-409', 'Classroom', 30),
('CityEast', 'Taylor Complex', 'Lecture Theatre TC-LT1', 'LectureTheatre', 250),
('CityEast', 'Taylor Complex', 'Lecture Theatre TC-LT2', 'LectureTheatre', 170),
('CityEast', 'Taylor Complex', 'Lecture Theatre TC-LT3', 'LectureTheatre', 170);

-- Rooms in Wilson Building (CityEast) 
INSERT INTO Locations (city_name, building_name, room_name, room_type, capacity)
VALUES
('CityEast', 'Wilson Building', 'Classroom WB-501', 'Classroom', 25),
('CityEast', 'Wilson Building', 'Classroom WB-502', 'Classroom', 30),
('CityEast', 'Wilson Building', 'Classroom WB-503', 'Classroom', 35),
('CityEast', 'Wilson Building', 'Classroom WB-504', 'Classroom', 45),
('CityEast', 'Wilson Building', 'Classroom WB-505', 'Classroom', 50),
('CityEast', 'Wilson Building', 'Classroom WB-506', 'Classroom', 40),  
('CityEast', 'Wilson Building', 'Classroom WB-507', 'Classroom', 35), 
('CityEast', 'Wilson Building', 'Classroom WB-508', 'Classroom', 35),
('CityEast', 'Wilson Building', 'Classroom WB-509', 'Classroom', 35),
('CityEast', 'Wilson Building', 'Classroom WB-510', 'Classroom', 35),
('CityEast', 'Wilson Building', 'Lecture Theatre WB-LT1', 'LectureTheatre', 250),
('CityEast', 'Wilson Building', 'Lecture Theatre WB-LT2', 'LectureTheatre', 200),
('CityEast', 'Wilson Building', 'Lecture Theatre WB-LT3', 'LectureTheatre', 200);

DROP TABLE IF EXISTS TravelTimes;

CREATE TABLE TravelTimes (
    travel_id INT AUTO_INCREMENT PRIMARY KEY,
    origin_id INT NOT NULL,
    origin_name VARCHAR(100) NOT NULL,
    origin_type ENUM('City', 'Building') NOT NULL,
    destination_id INT NOT NULL,
    destination_name VARCHAR(100) NOT NULL,
    destination_type ENUM('City', 'Building') NOT NULL,
    travel_time_minutes INT NOT NULL,
    CONSTRAINT fk_origin FOREIGN KEY (origin_id) REFERENCES Locations(location_id),
    CONSTRAINT fk_destination FOREIGN KEY (destination_id) REFERENCES Locations(location_id)
);

-- Insert city-to-city travel times 
INSERT INTO TravelTimes (origin_id, origin_name, origin_type, destination_id, destination_name, destination_type, travel_time_minutes)
SELECT 
    c1.location_id, c1.city_name, 'City',
    c2.location_id, c2.city_name, 'City',
    60
FROM Locations c1, Locations c2
WHERE c1.city_name IN ('CityNorth', 'CityEast') AND c1.building_name IS NULL
AND c2.city_name IN ('CityNorth', 'CityEast') AND c2.building_name IS NULL
AND c1.city_name != c2.city_name;

-- 2. Insert city-to-its-buildings travel times
-- Using average of building-to-building times (12-13 minutes)
INSERT INTO TravelTimes (origin_id, origin_name, origin_type, destination_id, destination_name, destination_type, travel_time_minutes)
SELECT 
    city.location_id, city.city_name, 'City',
    building.location_id, building.building_name, 'Building',
    12
FROM Locations city
JOIN Locations building ON building.city_name = city.city_name
WHERE city.building_name IS NULL
AND building.building_name IS NOT NULL AND building.room_name IS NULL;

-- 3. Insert buildings-to-parent-city travel times
INSERT INTO TravelTimes (origin_id, origin_name, origin_type, destination_id, destination_name, destination_type, travel_time_minutes)
SELECT 
    building.location_id, building.building_name, 'Building',
    city.location_id, city.city_name, 'City',
    12
FROM Locations building
JOIN Locations city ON building.city_name = city.city_name
WHERE city.building_name IS NULL
AND building.building_name IS NOT NULL AND building.room_name IS NULL;

-- 4. Insert intra-city building-to-building travel times (10-15 minutes)
-- CityNorth buildings
INSERT INTO TravelTimes (origin_id, origin_name, origin_type, destination_id, destination_name, destination_type, travel_time_minutes)
SELECT 
    b1.location_id, b1.building_name, 'Building',
    b2.location_id, b2.building_name, 'Building',
    CASE 
        WHEN (b1.building_name = 'Johnson Hall' AND b2.building_name = 'Adams Hall') OR
             (b1.building_name = 'Adams Hall' AND b2.building_name = 'Johnson Hall') THEN 15
        WHEN (b1.building_name = 'Johnson Hall' AND b2.building_name = 'Greenwood Bldg') OR
             (b1.building_name = 'Greenwood Bldg' AND b2.building_name = 'Johnson Hall') THEN 10
        WHEN (b1.building_name = 'Adams Hall' AND b2.building_name = 'Greenwood Bldg') OR
             (b1.building_name = 'Greenwood Bldg' AND b2.building_name = 'Adams Hall') THEN 12
    END
FROM Locations b1
JOIN Locations b2 ON b1.city_name = b2.city_name
WHERE b1.city_name = 'CityNorth' 
AND b1.building_name IS NOT NULL AND b1.room_name IS NULL
AND b2.building_name IS NOT NULL AND b2.room_name IS NULL
AND b1.building_name != b2.building_name;

-- CityEast buildings
INSERT INTO TravelTimes (origin_id, origin_name, origin_type, destination_id, destination_name, destination_type, travel_time_minutes)
SELECT 
    b1.location_id, b1.building_name, 'Building',
    b2.location_id, b2.building_name, 'Building',
    CASE 
        WHEN (b1.building_name = 'Taylor Complex' AND b2.building_name = 'Wilson Building') OR
             (b1.building_name = 'Wilson Building' AND b2.building_name = 'Taylor Complex') THEN 15
        ELSE 10 
    END
FROM Locations b1
JOIN Locations b2 ON b1.city_name = b2.city_name
WHERE b1.city_name = 'CityEast' 
AND b1.building_name IS NOT NULL AND b1.room_name IS NULL
AND b2.building_name IS NOT NULL AND b2.room_name IS NULL
AND b1.building_name != b2.building_name;

-- 5. Insert direct inter-city building-to-building travel times 
-- Johnson Hall (CityNorth) to Taylor Complex (CityEast) 
INSERT INTO TravelTimes (origin_id, origin_name, origin_type, destination_id, destination_name, destination_type, travel_time_minutes)
SELECT 
    b1.location_id, b1.building_name, 'Building',
    b2.location_id, b2.building_name, 'Building',
    CASE
        WHEN (b1.building_name = 'Johnson Hall' AND b2.building_name = 'Taylor Complex') OR
             (b1.building_name = 'Taylor Complex' AND b2.building_name = 'Johnson Hall') THEN 65
        WHEN (b1.building_name = 'Adams Hall' AND b2.building_name = 'Wilson Building') OR
             (b1.building_name = 'Wilson Building' AND b2.building_name = 'Adams Hall') THEN 70
        ELSE 60 -- Default for other inter-city building combinations
    END
FROM Locations b1
JOIN Locations b2 ON b1.city_name != b2.city_name
WHERE b1.building_name IS NOT NULL AND b1.room_name IS NULL
AND b2.building_name IS NOT NULL AND b2.room_name IS NULL;

-- View all travel times ordered by origin then destination
SELECT * FROM TravelTimes 
ORDER BY 
    CASE origin_type WHEN 'City' THEN 0 ELSE 1 END,
    origin_name,
    CASE destination_type WHEN 'City' THEN 0 ELSE 1 END,
    destination_name;
    
CREATE TABLE SubjectStudentCount AS
SELECT 
    d.department_name AS department,
    d.subject_code,
    d.subject_name,
    d.year,
    d.term,
    COUNT(*) AS total_students
FROM Departments d
JOIN Students s 
  ON s.course_name = d.course_name 
 AND s.year = d.year
GROUP BY 
    d.department_name, 
    d.subject_code, 
    d.subject_name, 
    d.year, 
    d.term;

SELECT * FROM SubjectStudentCount;



