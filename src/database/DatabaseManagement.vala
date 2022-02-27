public class Registry.DatabaseManagement {
    public static Sqlite.Database open_database (string name = "registry.sqlite3") throws Error {
        Sqlite.Database db;
        
        int ec = Sqlite.Database.open (name, out db);
        if (ec != Sqlite.OK) {
            throw new Error ("Can't open database: %d: %s\n".printf (db.errcode (), db.errmsg ()));
        }
        
        return db;
    }
    
    public static int void_query (Sqlite.Database db, string query) throws Error {
        string errmsg;
        int ec = db.exec (query, null, out errmsg);
        
        if (ec != Sqlite.OK) {
            throw new Error ("Error: %s\n".printf (errmsg));
        }
        
        return ec;
    }
    
    public static Array<Array<string>> select (Sqlite.Statement stmt) {
        Array<Array<string>> result = new Array<Array<string>> ();
        int cols = stmt.column_count ();
        
        while (stmt.step () == Sqlite.ROW) {
            for (int i = 0; i < cols; i++) {
                Array<string> row = new Array<string> ();
                string val = stmt.column_text (i) ?? "<empty>";
                row.append_val (val);
                result.append_val (row);
            }
        }
        
        return result;
    }
    
    public static int add_classroom (Classroom cr) throws Error {
        string query = "INSERT INTO Classroom (name, grade, level) VALUES ('%s', '%d', '%d');".printf (cr.name, cr.grade, cr.level);
        Sqlite.Database db = open_database ();
        return void_query (db, query);
    }
    
    public static int add_student (Student st) throws Error {
        string query = "INSERT INTO Student (firstname, lastname, gender, age, classroom_id) VALUES ('%s', '%s', '%s', %d, %d);".printf (st.firstname, st.lastname, st.gender, st.age, st.classroom_id);
        Sqlite.Database db = open_database ();
        return void_query (db, query);
    }
    
    public static Array<Student> get_students () throws Error {
        Sqlite.Statement stmt;
        
        const string query = "SELECT * FROM Student;";
        Sqlite.Database db = open_database ();
        int ec = db.prepare_v2 (query, query.length, out stmt);
        if (ec != Sqlite.OK) {
            throw new Error ("Error: %d: %s\n".printf (db.errcode (), db.errmsg ()));
        }
        
        Array<Array<string>> result = select (stmt);
        Array<Student> students = new Array<Student> ();
        
        for (int i = 0; i < result.length; i++) {
            Student st = new Student();
            Array<string> curr = result.index(i);
            st.id = curr.index (0);
            st.firstname = curr.index (1);
        }
    }
}
