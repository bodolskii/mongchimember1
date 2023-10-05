package dao;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;
@Log4j2
class ConnectionUtilTest {

    @Test
    void getConnection() throws SQLException {
        Connection connection = ConnectionUtil.INSTANCE.getConnection();
        log.info(connection);
    }
}