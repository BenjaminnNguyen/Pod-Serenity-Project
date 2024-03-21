package cucumber.models.api.Tax;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class FeesList {
    public List<ProductFeesAttribute> state_product_fees_attributes;

    public FeesList(List<ProductFeesAttribute> state_product_fees_attributes) {
        this.state_product_fees_attributes = state_product_fees_attributes;
    }
}
