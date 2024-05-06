# firebase_crud

A mobile application for notes and task management using Firebase and Flutter, designed to fulfill a project requirement for the Mobile Application Programming D class.

- **Name:** Kurnia Cahya Febryanto
- **NRP:** 5025201073
- **Class:** Pemrograman Perangkat Bergerak D

## Introduction
This application is designed to help users efficiently manage notes and tasks. It leverages the power of Firebase for backend storage and Flutter for frontend development, ensuring a seamless and efficient user experience.

## Features
- **Notes Management:** Add, edit, and delete notes. Each note contains a title, description, and a timestamp.
- **Task Management:** Add, edit, and delete tasks. Each task contains a name, completion status, and a timestamp. Completed tasks are displayed with a strikethrough.
- **Dashboard:** Displays the three most recent notes and tasks on the home page for quick access.
- **Persistent Storage:** All data is saved and retrieved from Firebase.

## How to Clone and Run the Project

1. **Clone the Repository:** Use the following command to clone the repository to your local machine:
```bash
git clone https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD.git
```

2. **Navigate to the Project Directory:** 
```bash
cd firebase-crud
```

3. **Install Dependencies:** Ensure you have Flutter installed. Then run:
```bash
flutter pub get
```

4. **Configure Firebase:** Follow Firebase's instructions to connect the project to your Firebase project.

5. **Run the Application:**
```bash
flutter run
```

## Screenshots

- **Figure 1:** Dashboard page </br>
<img src="https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD/assets/70510279/37b8335c-c364-4d5c-8e3d-560fd883b4d3" width="400"/>

- **Figure 2:** Notes Management page </br>
<img src="https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD/assets/70510279/e7c3f78d-10db-4503-9681-d8720f335695" width="400"/>

- **Figure 3:** Tasks Management page </br>
<img src="https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD/assets/70510279/9fc15c6d-16aa-43e5-91c8-c6a5d14b293c" width="400"/>

- **Figure 4:** Add Note</br>
<img src="https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD/assets/70510279/da15752a-f383-435b-92d2-4aa48a5ad9ee" width="400"/>

- **Figure 5:** Add Task</br>
<img src="https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD/assets/70510279/bea3cd7d-cfc7-4b16-80f3-588f5bd7943e" width="400"/>


- **Figure 6:** Dashboard page after data is added </br>
<img src="https://github.com/kurniacf/PBB_Task-6_Firebase_CRUD/assets/70510279/1968e2a0-30a2-41c2-8a87-bd4b27667754" width="400"/>


## References
The initial architecture of this Notepad application was inspired by a tutorial from Mitch Koko on YouTube. Significant modifications and improvements were made by Kurnia Cahya Febryanto (@kurniacf).

Check out the original tutorial here:
[ Flutter x Firebase CRUD Masterclass • Create / Read / Update / Delete - Mitch Koko](https://www.youtube.com/watch?v=iQOvD0y-xnw)