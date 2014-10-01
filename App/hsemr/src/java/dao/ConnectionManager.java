package dao;

import java.sql.*;
import java.util.Properties;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * A class that manages connections to the database. It also has a utility
 * method that close connections, statements and resultsets
 */
public class ConnectionManager {

  private static final String PROPS_FILENAME = "/connection.properties"; 
  private static String dbUser;
  private static String dbPassword;
  private static String dbURL;

  static {
    // grab environment variable
    String host = System.getenv("OPENSHIFT_MYSQL_DB_HOST");

    if (host != null) {
      // this is production environment
      // obtainString database connection properties from environment variables
      String port = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
      String dbName = "hsemr"; //System.getenv("OPENSHIFT_APP_NAME");
      dbUser = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
      dbPassword = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
      
      dbURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;

    } else {
        try {
          // Retrieve properties from connection.properties via the CLASSPATH
          // WEB-INF/classes is on the CLASSPATH
          InputStream is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
          Properties props = new Properties();
          props.load(is);

          // load database connection details
           host = props.getProperty("db.host").trim();
            String port = props.getProperty("db.port").trim();
            String dbName = props.getProperty("db.name").trim();
            dbUser = props.getProperty("db.user").trim();
            dbPassword = props.getProperty("db.password").trim();
        
            
            dbURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
        } catch (Exception ex) {
          // unable to load properties file
          String message = "Unable to load '" + PROPS_FILENAME + "'.";

          System.out.println(message);
          Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
          throw new RuntimeException(message, ex);
        }
    }

    try {
      Class.forName("com.mysql.jdbc.Driver").newInstance();
    } catch (Exception ex) {
      // unable to load properties file
      String message = "Unable to find JDBC driver for MySQL.";

      System.out.println(message);
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
      throw new RuntimeException(message, ex);
    }
  }

  /**
   * Gets a connection to the database
   *
   * @return the connection
   * @throws SQLException if an error occurs when connecting
   */
  public static Connection getConnection() throws SQLException {
    String message = "dbURL: " + dbURL
            + "  , dbUser: " + dbUser
            + "  , dbPassword: " + dbPassword;
    Logger.getLogger(ConnectionManager.class.getName()).log(Level.INFO, message);

    return DriverManager.getConnection(dbURL, dbUser, dbPassword);

  }

  /**
   * close the given connection, statement and resultset
   *
   * @param conn the connection object to be closed
   * @param stmt the statement object to be closed
   * @param rs the resultset object to be closed
   */
  public static void close(Connection conn, Statement stmt, ResultSet rs) {
    try {
      if (rs != null) {
        rs.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, 
              "Unable to close ResultSet", ex);
    }
    try {
      if (stmt != null) {
        stmt.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, 
              "Unable to close Statement", ex);
    }
    try {
      if (conn != null) {
        conn.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, 
              "Unable to close Connection", ex);
    }
  }
  
  /**
   * close the given connection, statement
   *
   * @param conn the connection object to be closed
   * @param stmt the statement object to be closed
   */
  public static void close(Connection conn, Statement stmt) {
    try {
      if (stmt != null) {
        stmt.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close Statement", ex);
    }
    try {
      if (conn != null) {
        conn.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close Connection", ex);
    }
  }
}
//public class ConnectionManager {
//    private static String JDBC_DRIVER = "jdbc.driver";
//    private static String JDBC_URL = "jdbc.url";
//    private static String JDBC_USER = "jdbc.user";
//    private static String JDBC_PASSWORD = "jdbc.password";
//    private static Properties props = new Properties();
//
//    static {
//        try {
//            // a way to retrieve the data in
//            // connection.properties found
//            // in WEB-INF/classes
//            InputStream is = ConnectionManager.class.getResourceAsStream("/connection.properties");
//            props.load(is);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        try {
//            Class.forName(props.getProperty(JDBC_DRIVER)).newInstance();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    /**
//     * Gets a connection to the database using getConnection() method 
//     * with parameters jdbc url,user id and password internally
//     *
//     * @return the connection
//     * @throws SQLException if an error occurs when connecting
//     */
//    public static Connection getConnection() throws SQLException {
//        return DriverManager.getConnection(props.getProperty(JDBC_URL),
//                props.getProperty(JDBC_USER),
//                props.getProperty(JDBC_PASSWORD));
//    }
//
//    /**
//     * close the given connection, statement and resultset
//     *
//     * @param conn the connection object to be closed
//     * @param stmt the statement object to be closed
//     * @param rs   the resultset object to be closed
//     */
//    public static void close(Connection conn, PreparedStatement stmt, ResultSet rs) {
//        try {
//            if (rs != null) {
//                rs.close();
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        
//        try {
//            if (stmt != null) {
//                stmt.close();
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        
//        try {
//            if (conn != null) {
//                conn.close();
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        
//    }
//}