package pojo.CleaningSessions;

import lombok.Data;

@Data
public class CleaningSessionErrorResponse {
    private String timestamp;
    private String path;
    private int status;
    private String error;
    private String message;
}
