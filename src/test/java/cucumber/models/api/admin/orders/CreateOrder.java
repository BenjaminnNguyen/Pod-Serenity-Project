package cucumber.models.api.admin.orders;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CreateOrder {
    OrderAttributes order;

    public CreateOrder(OrderAttributes order) {
        this.order = order;
    }
}
