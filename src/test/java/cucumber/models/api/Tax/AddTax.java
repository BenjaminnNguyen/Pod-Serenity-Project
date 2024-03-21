package cucumber.models.api.Tax;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AddTax {
    AddFeesList product;

    public AddTax(AddFeesList product) {
        this.product = product;
    }
}
