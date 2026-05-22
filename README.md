# Gener Portfolio Website

This is a static portfolio website for deployment on Firebase Hosting and Render.

## Firebase Hosting

1. Install Firebase CLI:
   - `npm install -g firebase-tools`
2. Login:
   - `firebase login`
3. Initialize hosting if you want to create a new Firebase project locally:
   - `firebase init hosting`
   - Choose `Use an existing project` or create a new one.
   - Set the public directory to `.` (current folder).
   - Answer `No` when asked to configure as a single-page app unless you want all URLs to point to `index.html`.
4. Deploy:
   - `firebase deploy`

## Render

1. Push this repository to GitHub.
2. In Render, create a new Static Site.
3. Connect the GitHub repository.
4. Use `main` as the branch.
5. Set the publish directory to `.`.
6. Leave the build command empty.
7. Deploy.

## Notes

- Keep all website files together in this folder.
- Add `finaljosh.png` (or your profile image) in the same directory if needed.
- If you don’t have Git or Firebase CLI installed here, you can still deploy from your own machine after installing them.
