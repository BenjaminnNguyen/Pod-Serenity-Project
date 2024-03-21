package cucumber.models.api.admin;

import io.cucumber.java.sl.In;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TagTargetModel {

    Integer id;
    List<TagsInfoModel> tags_info;

}
