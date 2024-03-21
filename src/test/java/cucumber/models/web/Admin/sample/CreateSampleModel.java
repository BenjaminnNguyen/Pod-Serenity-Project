package cucumber.models.web.Admin.sample;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateSampleModel {
    AddressAttributes address_attributes;
    String buyer_id;
    List<String>buyer_ids;
    String comment;
    String fulfillment_date;
    String fulfillment_state;
    String head_buyer_id;
    List<String>product_ids;
    List <ItemAttributesSample> sample_request_items_attributes;
    String store_id;
    String vendor_company_id;

    public CreateSampleModel(AddressAttributes address_attributes, String fulfillment_state, List<String> product_ids, List<ItemAttributesSample> sample_request_items_attributes, String vendor_company_id) {
        this.address_attributes = address_attributes;
        this.fulfillment_state = fulfillment_state;
        this.product_ids = product_ids;
        this.sample_request_items_attributes = sample_request_items_attributes;
        this.vendor_company_id = vendor_company_id;
    }

    public CreateSampleModel(AddressAttributes address_attributes, String comment, String fulfillment_date, String fulfillment_state, String head_buyer_id, List<String> product_ids, List<ItemAttributesSample> sample_request_items_attributes, String store_id, String vendor_company_id) {
        this.address_attributes = address_attributes;
        this.comment = comment;
        this.fulfillment_date = fulfillment_date;
        this.fulfillment_state = fulfillment_state;
        this.head_buyer_id = head_buyer_id;
        this.product_ids = product_ids;
        this.sample_request_items_attributes = sample_request_items_attributes;
        this.store_id = store_id;
        this.vendor_company_id = vendor_company_id;
    }
}
