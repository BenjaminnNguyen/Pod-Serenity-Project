package cucumber.models.api.admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TagsInfoModel {
    Integer id;
    Integer tag_id;
    String expiry_date;
    String tag_name;
    Boolean _destroy;

    public TagsInfoModel(Integer id, Integer tag_id, String tag_name, String expiry_date) {
        this.id = id;
        this.tag_id = tag_id;
        this.expiry_date = expiry_date;
        this.tag_name = tag_name;
        this._destroy = true;
    }
}
