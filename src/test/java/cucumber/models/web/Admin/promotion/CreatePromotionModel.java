package cucumber.models.web.Admin.promotion;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreatePromotionModel {
    
    PromotionModel promotion;
    Integer id;
    boolean overlap_check;
}

