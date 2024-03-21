package cucumber.models.api.admin.sampleRequest;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SampleRequestAttributes {

    String fulfillment_state;
    String fulfillment_date;
    String carrier;
    String tracking_number;

    String cancelled_reason;

    public SampleRequestAttributes(String fulfillment_state, String fulfillment_date, String carrier, String tracking_number) {
        this.fulfillment_state = fulfillment_state;
        this.fulfillment_date = fulfillment_date;
        this.carrier = carrier;
        this.tracking_number = tracking_number;
    }
}
