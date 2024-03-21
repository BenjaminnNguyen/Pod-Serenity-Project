package cucumber.models.api.admin.orders;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CreateGhostOrder {
    GhostOrderAttributes ghost_order;

    public CreateGhostOrder(GhostOrderAttributes order) {
        this.ghost_order = order;
    }
}
