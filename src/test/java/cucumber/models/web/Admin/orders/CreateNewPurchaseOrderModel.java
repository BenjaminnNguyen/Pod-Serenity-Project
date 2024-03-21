package cucumber.models.web.Admin.orders;

import lombok.Data;

@Data
public class CreateNewPurchaseOrderModel {
    String driver;
    String fulfillmentDate;
    String fulfillmentState;
    String proofOfDelivery;
    String adminNote;
    String lpNote;
}
