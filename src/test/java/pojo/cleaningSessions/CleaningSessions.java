package pojo.cleaningSessions;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class CleaningSessions {
    private List<Integer> roomSize;
    @JsonProperty(value = "coords")
    private List<Integer> coordinates;
    private List<List<Integer>> patches;
    private String instructions;
}
