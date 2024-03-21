package cucumber.models.api.Tax;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AddProductFeesAtribute {

    public String state_fee_name_id;
    public String fee_price_cents;

    public AddProductFeesAtribute(String state_fee_name_id, String fee_price_cents) {
        this.state_fee_name_id = state_fee_name_id;
        this.fee_price_cents = fee_price_cents;
    }
}
