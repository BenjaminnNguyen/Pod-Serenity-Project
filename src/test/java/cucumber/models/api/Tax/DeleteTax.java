package cucumber.models.api.Tax;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeleteTax {
    FeesList product;

    public DeleteTax(FeesList product) {
        this.product = product;
    }
}
