package pojo.CleaningSessions;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class CleaningSessionResponse {
    @JsonProperty("coords")
    private List<Integer> coordinates;
    private int patches;
}
