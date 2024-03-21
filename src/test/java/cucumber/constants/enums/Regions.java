package cucumber.constants.enums;


public enum Regions {
    CHI("Chicagoland Express"),
    NY("New York Express"),
    LA("South California Express"),
    SF("North California Express"),
    TX("Texas Express"),
    DAL("Dallas Express"),
    MA("Mid Atlantic Express"),
    //    PDM("Pod Direct Midwest"),
//    PDN("Pod Direct Northeast"),
//    PDS("Pod Direct Southeast"),
//    PDSWR("Pod Direct Southwest & Rockies"),
    PDW("Pod Direct West"),
    PDC("Pod Direct Central"),
    PDE("Pod Direct East");
    public String region;

    // getter method
    public String getRegion() {
        return this.region;
    }

    // enum constructor - cannot be public or protected
    Regions(String region) {
        this.region = region;
    }
}
