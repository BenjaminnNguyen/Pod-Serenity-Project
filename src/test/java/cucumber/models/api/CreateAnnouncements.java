package cucumber.models.api;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateAnnouncements {
    /**
     * Model dùng để tạo Announcementes
     */
    String name;
    String title;
    String body;
    String recipient_type;
    String start_delivering_date;
    String stop_delivering_date;
    String link;
    String link_title;
    List<Integer> region_ids;


}
