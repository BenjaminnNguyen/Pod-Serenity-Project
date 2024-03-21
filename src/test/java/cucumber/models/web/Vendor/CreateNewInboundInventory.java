package cucumber.models.web.Vendor;

import lombok.Data;

import java.util.ArrayList;

@Data
public class CreateNewInboundInventory {
    public String region_name;
    public String delivery_method;
    public String estimated_date_arrival;
    public String eta;
    public int num_of_pallet;
    public int num_of_sellable_retail_case;
    public int num_of_master_carton;
    public int num_of_retail_per_master_carton;
    public String other_detail;
    public String freight_carrier;
    public String tracking_number;
    public String reference_number;
    public String estimated_week_shipment;
    public String zip_code;
    public String file_bol;
    public String note;
    public String transportation_coordinator_contact_name;
    public String transportation_coordinator_contact_phone;

}
