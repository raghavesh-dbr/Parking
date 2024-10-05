To store your SQL script in a file and run it after installing pgAdmin, you can follow these steps:

### Step 1: Create a SQL Script File
1. **Open a text editor**: Use any text editor like Notepad, VSCode, or any IDE that supports text files.
  
2. **Write your SQL script**: Copy all your `CREATE TABLE` and `INSERT` statements into the text editor.

3. **Save the file**: Save the file with a `.sql` extension, for example, `setup_parking_app.sql`.

### Step 2: Run the SQL Script in pgAdmin
1. **Open pgAdmin**: Launch the pgAdmin application.

2. **Connect to your PostgreSQL server**: Click on the server in the left pane and log in with your credentials if prompted.

3. **Open the Query Tool**:
   - Right-click on the database where you want to execute the script.
   - Select **Query Tool** from the context menu.

4. **Load your SQL file**:
   - In the Query Tool, go to **File** > **Open**.
   - Browse to the location of your `.sql` file and select it.

5. **Execute the script**:
   - Click the **Execute/Refresh** button (or press `F5`).
   - The script will run, and you should see results in the output pane below.

### Step 3: Verify the Changes
- After running the script, you can verify the changes by browsing the tables in your database or running `SELECT` queries to see if the tables and data have been created as expected.

### Additional Notes
- Ensure that your PostgreSQL server is running and that you have the necessary permissions to create tables and insert data.
- If you encounter any errors during execution, pgAdmin will provide error messages that can help you troubleshoot.

By following these steps, you can effectively store and run your SQL script in pgAdmin! If you have any more questions or need further assistance, feel free to ask!
