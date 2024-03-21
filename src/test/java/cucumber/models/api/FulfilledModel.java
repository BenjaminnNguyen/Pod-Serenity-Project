package cucumber.models.api;

import lombok.Data;

import java.util.List;

@Data
public class FulfilledModel {

    public Order order;

    @Data
    public static class Order{
        public List<LineItemsAttribute> line_items_attributes;
    }

    @Data
    public static class LineItemsAttribute{
        public String id;
        public String fulfilled;
    }

}
