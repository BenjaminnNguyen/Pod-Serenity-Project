package cucumber.models.api.Tax;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;

@Data
@NoArgsConstructor
public class AddFeesList {
    public ArrayList<AddProductFeesAtribute> state_product_fees_attributes;

    public AddFeesList(ArrayList<AddProductFeesAtribute> state_product_fees_attributes) {
        this.state_product_fees_attributes = state_product_fees_attributes;
    }
}
