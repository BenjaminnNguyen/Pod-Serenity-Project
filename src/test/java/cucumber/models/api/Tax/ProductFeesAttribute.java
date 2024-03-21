package cucumber.models.api.Tax;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProductFeesAttribute {
    public String id;
    public String product_id;
    public boolean _destroy;

    public ProductFeesAttribute(String id, String product_id, boolean _destroy) {
        this.id = id;
        this.product_id = product_id;
        this._destroy = _destroy;
    }

}
