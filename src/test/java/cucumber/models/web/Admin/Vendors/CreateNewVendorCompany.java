package cucumber.models.web.Admin.Vendors;

import lombok.Data;

@Data
public class CreateNewVendorCompany {
    String name;
    String email;
    String website;
    String ein;
    String contactNumber;
    String companySize;
    String street;
    String city;
    String Stage;
    String zip;
    Boolean ach;
    Boolean prepayment;
    Boolean showAllTaps;
    Boolean hideBrands;
    String manageBy;
    String LaunchBy;
    String ReferredBy;
    String tags;
    String regionalLimitType;

}
