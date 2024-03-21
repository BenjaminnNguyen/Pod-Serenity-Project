package steps.api.admin.orders;

import io.cucumber.java.en.*;
import cucumber.models.api.admin.orders.CreateOrder;
import cucumber.models.api.admin.orders.LineItemsAttributes;
import cucumber.models.web.Admin.Products.sku.CompanyAttribuites;
import cucumber.models.web.Admin.Products.sku.CompanyConfigAttributes;
import cucumber.models.web.Admin.Products.sku.StoreConfigAttributes;
import cucumber.models.web.Admin.Products.sku.VariantStoreAttribute;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.order.OrdersAdminAPI;
import cucumber.tasks.api.admin.products.ProductAdminAPI;
import cucumber.tasks.api.admin.products.SkusAdminAPI;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class OrderAPIStepDefinitions {
    CommonRequest commonRequest = new CommonRequest();
    OrdersAdminAPI ordersAdminAPI = new OrdersAdminAPI();
    ProductAdminAPI productAdminAPI = new ProductAdminAPI();
    SkusAdminAPI skusAdminAPI = new SkusAdminAPI();

    @And("Search order by sku {string} by api")
    public void search_order_by_skuname(String skuID) {
        if (skuID.equals("")) {
            skuID = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        Response response = ordersAdminAPI.callSearchOrderBySkuID(skuID);
        ordersAdminAPI.getIdOrder(response);
    }

    @And("Admin delete order of sku {string} by api")
    public void delete_order_by_skuname(String skuName) {
        List<String> test = new ArrayList<>();
        List<String> idOrders = Serenity.sessionVariableCalled("ID Order API");
        if (idOrders.size() != 0) {
            for (String idOrder : idOrders) {
                // Xóa trạng thái fulfill nếu có của order
                List<String> ids = ordersAdminAPI.getLineItemsIdFromOrder(idOrder);
                Response response3 = ordersAdminAPI.fulfilledLineItemsIdFromOrder(idOrder, ids, false);
                // xóa purchase order nếu có
                Response response4 = ordersAdminAPI.callDetailOrder(idOrder);
                List<String> idPOs = ordersAdminAPI.getIdPurchaseOrder(response4);
                if (idPOs.size() > 0) {
                    for (String idPO : idPOs) {
                        // xoa proof neu co
                        HashMap proof = ordersAdminAPI.getProofOfPurchaseOrder(response4, idPO);
                        if (proof == null) {
                            ordersAdminAPI.callChangePO(idPO);
                        } else {
                            ordersAdminAPI.callChangePOwithProofToUnconfirm(idPO, proof);
                        }
                        Response response5 = ordersAdminAPI.callDeletePO(idPO);
                        JsonPath jsonPath = response5.jsonPath();
                        String message = jsonPath.get("message");
                        Ensure.that(message).equals("Purchase order deleted");
                    }

                }
                // set deliverable thành deliverable not set
                ordersAdminAPI.setDeliveryNotSetInLineItem(idOrder, ids);

                Response response = ordersAdminAPI.callDeleteOrderByID(idOrder);
                JsonPath jsonPath = response.jsonPath();
                String message = jsonPath.get("message");
                Ensure.that(message).equals("Order deleted");
            }
        }
    }

    @And("Admin delete order by sku of product {string} by api")
    public void delete_order_by_product(String productName) {
        Response response = productAdminAPI.searchProduct(productName);
        // get ID của product
        List<String> listID = productAdminAPI.getIdProduct(response);

        for (String id : listID) {
            Response response1 = productAdminAPI.callProductDetail(id);
            // get ID của SKU
            List<String> listSKUID = productAdminAPI.getAllSkuId(response1);
            for (String skuID : listSKUID) {
                // Search order theo ID của SKU
                Response response2 = ordersAdminAPI.callSearchOrderBySkuID(skuID);
                // lấy ID của order sau khi search
                List<String> listIdOrder = ordersAdminAPI.getIdOrder(response2);
                // Check từng id order trong list
                if (listIdOrder.size() != 0) {
                    for (String idOrder : listIdOrder) {
                        // Xóa trạng thái fulfill nếu có của order
                        List<String> ids = ordersAdminAPI.getLineItemsIdFromOrder(idOrder);
                        Response response3 = ordersAdminAPI.fulfilledLineItemsIdFromOrder(idOrder, ids, false);
                        // xóa purchase order nếu có
                        Response response4 = ordersAdminAPI.callDetailOrder(idOrder);
                        List<String> idPOs = ordersAdminAPI.getIdPurchaseOrder(response4);
                        if (idPOs.size() > 0) {
                            for (String idPO : idPOs) {
                                // xoa proof neu co
                                HashMap proof = ordersAdminAPI.getProofOfPurchaseOrder(response4, idPO);
                                if (proof == null) {
                                    ordersAdminAPI.callChangePO(idPO);
                                } else {
                                    ordersAdminAPI.callChangePOwithProofToUnconfirm(idPO, proof);
                                }
                                Response response5 = ordersAdminAPI.callDeletePO(idPO);
                                JsonPath jsonPath = response5.jsonPath();
                                String message = jsonPath.get("message");
                                Ensure.that(message).equals("Purchase order deleted");
                            }
                        }
                        ordersAdminAPI.setDeliveryNotSetInLineItem(idOrder, ids);
                        Response response5 = ordersAdminAPI.callDeleteOrderByID(idOrder);
                        JsonPath jsonPath = response5.jsonPath();
                        String message = jsonPath.get("message");
                        Ensure.that(message).equals("Order deleted");
                    }
                    // Delete order
//                    delete_order_by_skuname("");
                }
            }
        }
    }

    @And("Admin update line item in order by api")
    public void fulfillLineItem(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String orderID = null;
        if (infos.get(0).get("order_id").equals("")) {
            orderID = Serenity.sessionVariableCalled("ID Order");
        }
        if (infos.get(0).get("order_id").equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order API").toString();
        }
        if (infos.get(0).get("order_id").equals("create by admin")) {
            orderID = Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString();
        }
        if (infos.get(0).get("order_id").equals("create by buyer")) {
            orderID = Serenity.sessionVariableCalled("order_id").toString();
        }

        Response responseLineItem = ordersAdminAPI.callLineItemOfOrder(orderID);

        List<HashMap<String, Object>> list = new ArrayList<>();

        for (Map<String, String> item : infos) {
            // nếu sku là tạo random
            String sku = item.get("skuName");
            String skuID = item.get("skuId");
            if (item.get("skuName").equals("random")) {
                sku = Serenity.sessionVariableCalled("SKU inventory");
                skuID = Serenity.sessionVariableCalled("ID SKU Admin").toString();
            }
            if (item.get("skuId").contains("api")) {
                skuID = Serenity.sessionVariableCalled("itemCode" + item.get("skuName")).toString();
            }

            String temp = ordersAdminAPI.getLineItemIdOfSKUFromOrder(responseLineItem, sku, skuID);
            HashMap<String, Object> map = new HashMap<>();
            map.put("id", Integer.valueOf(temp));
            map.put("state", Boolean.parseBoolean(item.get("fulfilled")));
            // thêm ngày fulfill nếu cần thiết
            if (item.containsKey("fulfillmentDate")) {
                map.putIfAbsent("fulfillmentDate", CommonHandle.setDate2(item.get("fulfillmentDate"), "yyyy-MM-dd"));
            }
            list.add(map);
        }

        Map<String, Object> body = ordersAdminAPI.setOrderObject(list);
        Response response = ordersAdminAPI.fulfilledLineItemsIdFromOrder(orderID, body);
    }

    @And("Admin {string} all line item in order {string} by api")
    public void fulfillLineItem(String status, String order) {
        Boolean check = status.equals("fulfilled");
        List<String> listOrder = new ArrayList<>();
        switch (order) {
            case "search":
                listOrder = Serenity.sessionVariableCalled("ID Order API");
                break;
            case "create by api":
                order = Serenity.sessionVariableCalled("order_id").toString();
                listOrder.add(order);
                break;
            default:
                listOrder.add(order);
                break;
        }
        for (String item : listOrder) {
            List<String> ids = ordersAdminAPI.getLineItemsIdFromOrder(item);
            Response response = ordersAdminAPI.fulfilledLineItemsIdFromOrder(item, ids, check);
            System.out.println(response.prettyPrint());
        }
    }

    @And("Admin update fulfilled line item {int} to {string} in order {int} by api")
    public void fulfillLineItem(Integer lineItem, String fulfill, Integer order) {
        Response response = ordersAdminAPI.updateFulfilledLineItemsIdFromOrder(order, lineItem, Boolean.parseBoolean(fulfill));
        System.out.println(response.prettyPrint());
    }

    @And("Admin update quantity {int} of line item {int} in order {string} by api")
    public void updateQuantity(Integer quantity, Integer lineId, String orderId) {
        if (orderId.isEmpty()) orderId = Serenity.sessionVariableCalled("order_id").toString();
        if (orderId.equals("create by api")) orderId = Serenity.sessionVariableCalled("ID Order API").toString();
        Response response = ordersAdminAPI.updateQuantity(orderId, lineId, quantity);
        System.out.println(response.asString());
    }

    @And("Admin get line item of order id {string}")
    public void admin_get_line_item_of_order_id(String orderID) {
        if (orderID.equals("")) {
            List<String> idOrders = Serenity.sessionVariableCalled("ID Order API");
            orderID = idOrders.get(0);
        }

        List<String> ids = ordersAdminAPI.getLineItemsIdFromOrder(orderID);
        Serenity.setSessionVariable("List ID Line Item").to(ids);
    }

    @And("Admin search order by API")
    public void admin_search_order_by_API(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);

        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[product_variant_ids][]", info.get(0).get("skuID"));
        if (!info.get(0).get("fulfillment_state").equals("")) {
            map.putIfAbsent("q[fulfillment_state]", info.get(0).get("fulfillment_state"));
        }
        map.putIfAbsent("q[buyer_payment_state]", info.get(0).get("buyer_payment_state"));

        Response response = ordersAdminAPI.callSearchOrder(map);
        ordersAdminAPI.getIdOrder(response);
    }

    /*
    Dùng cho case cần tạo nhiều sku cho order
     */
    @And("Admin create line items attributes by API")
    public void admin_create_line_item_attributes_by_api(DataTable dt) {
        List<Map<String, String>> listItems = dt.asMaps(String.class, String.class);
        List<LineItemsAttributes> itemsAttributes = new ArrayList<>();

        for (Map<String, String> item : listItems) {
            String variants_region_id = item.get("variants_region_id");
            String variants_id = item.get("product_variant_id");
//            Thêm region id để lấy variants_region_id
            if (item.get("variants_region_id").contains("create by api")) {
                variants_region_id = Serenity.sessionVariableCalled("ID Region SKU Admin" + variants_region_id.split("api")[1]);
            }
            if (item.get("product_variant_id").contains("create by api")) {
                variants_id = Serenity.sessionVariableCalled("ID SKU Admin");
            }
            if (item.containsKey("skuName") && item.get("product_variant_id").contains("create by api")) {
                variants_id = Serenity.sessionVariableCalled("itemCode" + item.get("skuName"));
                variants_region_id = Serenity.sessionVariableCalled("ID Region SKU Admin" + item.get("skuName") + item.get("variants_region_id").split("api")[1]);
            }
            LineItemsAttributes itemAttributes = new LineItemsAttributes(variants_region_id, variants_id, item.get("quantity"), Boolean.parseBoolean(item.get("fulfilled")), item.get("fulfillment_date"));
            itemsAttributes.add(itemAttributes);
        }
        Serenity.setSessionVariable("List items order API").to(itemsAttributes);
    }

    /*
    Dùng cho case cần tạo 1 sku cho order
     */
    @And("Admin create line items attributes by API1")
    public void admin_create_line_item_attributes_by_api1(DataTable dt) {
        List<Map<String, String>> listItems = dt.asMaps(String.class, String.class);
        List<LineItemsAttributes> itemsAttributes = new ArrayList<>();
        for (Map<String, String> item : listItems) {
            String variants_region_id = item.get("variants_region_id");
            String variants_id = item.get("product_variant_id");
//            Thêm region id để lấy variants_region_id
            if (variants_region_id.contains("create by api")) {
                variants_region_id = Serenity.sessionVariableCalled("ID Region SKU Admin" + variants_region_id.split("api")[1]);
            }
            if (variants_id.contains("create by api")) {
                variants_id = Serenity.sessionVariableCalled("ID SKU Admin");
            }
            LineItemsAttributes itemAttributes = new LineItemsAttributes(variants_region_id, variants_id, item.get("quantity"), Boolean.parseBoolean(item.get("fulfilled")), item.get("fulfillment_date"));
            itemsAttributes.add(itemAttributes);
        }
        Serenity.setSessionVariable("List items order API").to(itemsAttributes);
    }

    @And("Admin clear line items attributes by API")
    public void admin_clear_line_item_attributes_by_api() {
        if (Serenity.hasASessionVariableCalled("List items order API")) {
            Serenity.clearSessionVariable("List items order API");
        }
    }

    @And("Admin clear id sub invoice attributes by API")
    public void admin_clear_sub_invoice_attributes_by_api() {
        if (Serenity.hasASessionVariableCalled("Id Sub-invoice LP")) {
            Serenity.clearSessionVariable("Id Sub-invoice LP");
        }
    }

    @And("Admin create order by API")
    public void admin_create_order_by_api(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        CreateOrder createOrder = ordersAdminAPI.setCreateOrderModel(infos.get(0));
        Response response = ordersAdminAPI.callCreateOrder(createOrder);
        ordersAdminAPI.getNumberOrderCreated(response);
        ordersAdminAPI.getIdOrderCreated(response);
    }

    @And("Admin save order number by index {string}")
    public void admin_save_order_number_by_index(String index) {
        // save order Number
        String number = Serenity.sessionVariableCalled("Number Order API").toString();
        Serenity.setSessionVariable("Number Order API" + index).to(number);
        // save order ID
        String id = Serenity.sessionVariableCalled("ID Order API").toString();
        Serenity.setSessionVariable("ID Order API" + index).to(id);
    }

    @And("Admin save sub-invoice of order {string} with index {string}")
    public void admin_save_sub_invoice_by_index(String order, String index, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        // get subinvoice từ order detail
        order = Serenity.sessionVariableCalled("ID Order API" + index);

        Response response = ordersAdminAPI.callDetailOrder(order);
        ordersAdminAPI.getSubInvoice(response, order, infos.get(0));
    }

    @And("Admin set Invoice by API")
    public void admin_set_invoice_by_api(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        //get Order ID
        String orderID = null;

        if (infos.get(0).get("order_id").equals("create by api buyer")) {
            orderID = Serenity.sessionVariableCalled("order_id").toString();
        }
        if (infos.get(0).get("order_id").equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order API").toString();
        }
        if (infos.get(0).get("order_id").equals("create by buyer")) {
            orderID = Serenity.sessionVariableCalled("ID Order Buyer").toString();
        }

        // get id of line item want to set invoice by skuName or skuID
        Response responseLineItem = ordersAdminAPI.callLineItemOfOrder(orderID);
        List<String> ids = new ArrayList<>();
        for (Map<String, String> info : infos) {
            // lấy skuID của từng line item trong order
            String skuId = info.get("skuId");
            if (info.get("skuId").contains("create by api")) {
                skuId = Serenity.sessionVariableCalled("itemCode" + info.get("skuName"));
            }

            String temp = ordersAdminAPI.getLineItemIdOfSKUFromOrder(responseLineItem, info.get("skuName"), skuId);
            ids.add(temp);
        }
        // Tạo model để tạo sub invoice
        Map<String, Object> sub_invoice = new HashMap<>();
        sub_invoice.putIfAbsent("eta_date", infos.get(0).get("eta_date"));
        sub_invoice.putIfAbsent("line_item_ids", ids);
        sub_invoice.putIfAbsent("payment_state", infos.get(0).get("payment_state"));
        sub_invoice.putIfAbsent("surfix", infos.get(0).get("surfix"));
        // có hiện sos ở subinvoice hay không
        if (infos.get(0).containsKey("display_surcharge")) {
            sub_invoice.putIfAbsent("display_surcharge", true);
        }


        Map<String, Object> order = new HashMap<>();
        order.putIfAbsent("order_id", orderID);
        order.putIfAbsent("sub_invoice", sub_invoice);
        // send request create sub invoice
        Response response = ordersAdminAPI.callCreateSubInvoice(order);
        ordersAdminAPI.getSubInvoiceId(response);
    }

    @And("Admin choose store's config attributes")
    public void config_store_attributes(StoreConfigAttributes storeConfigAttributes) {
        Serenity.setSessionVariable("Store's config attributes").to(storeConfigAttributes);
    }

    @And("Admin choose stores attributes to {word}")
    public void stores_attributes(String mode, DataTable dt) {
        List<Map<String, String>> data = dt.asMaps(String.class, String.class);
        int id = Integer.parseInt(data.get(0).get("id"));
        int region_id = Integer.parseInt(data.get(0).get("region_id"));
        int store_id = Integer.parseInt(data.get(0).get("store_id"));
        int product_variant_id = Integer.parseInt(data.get(0).get("product_variant_id"));
        int case_price_cents = Integer.parseInt(data.get(0).get("case_price_cents"));
        int msrp_cents = Integer.parseInt(data.get(0).get("msrp_cents"));
        String availability = data.get(0).get("availability");
        String state = data.get(0).get("state");
        String inventory_receiving_date = null;
        if (data.get(0).containsKey("inventory_receiving_date")) {
            inventory_receiving_date = CommonHandle.setDate2(data.get(0).get("inventory_receiving_date"), "yyyy-MM-dd");
        }
        StoreConfigAttributes storeConfigAttributes = Serenity.sessionVariableCalled("Store's config attributes");
        String newStart = null;
        // set start date và end date
        storeConfigAttributes.setStart_date(CommonHandle.setDate2(storeConfigAttributes.getStart_date(), "yyyy-MM-dd"));
        storeConfigAttributes.setEnd_date(CommonHandle.setDate2(storeConfigAttributes.getEnd_date(), "yyyy-MM-dd"));

        VariantStoreAttribute variantStoreAttributes = new VariantStoreAttribute(id, region_id, store_id, product_variant_id, case_price_cents, msrp_cents, availability, state, inventory_receiving_date, storeConfigAttributes);
        Serenity.setSessionVariable("Variant ID").to(product_variant_id);
        Serenity.setSessionVariable("Stores attributes").to(variantStoreAttributes);
    }

    @And("Admin {word} selected stores specific")
    public void active_stores_specific(String state) {
        skusAdminAPI.stateStoresSpecific();
    }

    @And("Admin choose company's config attributes")
    public void config_company_attributes(CompanyConfigAttributes companyConfigAttributes) {
        Serenity.setSessionVariable("Company's config attributes").to(companyConfigAttributes);
    }

    @And("Admin choose company attributes to {word}")
    public void company_attributes(String mode, DataTable dt) {
        List<Map<String, String>> data = dt.asMaps(String.class, String.class);
        int id = Integer.parseInt(data.get(0).get("id"));
        int region_id = Integer.parseInt(data.get(0).get("region_id"));
        int buyer_company_id = Integer.parseInt(data.get(0).get("buyer_company_id"));
        int product_variant_id = Integer.parseInt(data.get(0).get("product_variant_id"));
        int case_price_cents = Integer.parseInt(data.get(0).get("case_price_cents"));
        int msrp_cents = Integer.parseInt(data.get(0).get("msrp_cents"));
        String availability = data.get(0).get("availability");
        String state = data.get(0).get("state");
        String inventory_receiving_date = null;
        if (data.get(0).containsKey("inventory_receiving_date")) {
            inventory_receiving_date = CommonHandle.setDate2(data.get(0).get("inventory_receiving_date"), "yyyy-MM-dd");
        }

        CompanyConfigAttributes companyConfigAttributes = Serenity.sessionVariableCalled("Company's config attributes");
        String newStart = null;
        if (mode.equals("active")) {
            int random = new Random().nextInt(100) + 1;
            newStart = LocalDate.now().plusDays(-random).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } else {
            state = "inactive";
//            newStart = LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            newStart = companyConfigAttributes.getStart_date();
        }
        companyConfigAttributes.setStart_date(newStart);

        CompanyAttribuites companyAttribuites = new CompanyAttribuites(id, region_id, buyer_company_id, product_variant_id, case_price_cents, msrp_cents, availability, state, inventory_receiving_date, companyConfigAttributes);
        Serenity.setSessionVariable("Variant ID").to(companyAttribuites.getProduct_variant_id());
        Serenity.setSessionVariable("Company attributes").to(companyAttribuites);
    }

    @And("Admin {word} selected company specific")
    public void active_company_specific(String state) {
        skusAdminAPI.activeCompanySpecific();
    }

    @And("Admin edit general info of order {string} detail by api")
    public void search_order_by_skuname(String orderID, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        if (orderID.equals("")) {
            orderID = Serenity.sessionVariableCalled("ID Order API").toString();
        }

        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("small_order_surcharge_cents", infos.get(0).get("sos"));
        map.putIfAbsent("logistics_surcharge_cents", infos.get(0).get("ls"));
        map.putIfAbsent("customer_po", infos.get(0).get("customer_po"));
        Map<String, Object> order = new HashMap<>();
        order.putIfAbsent("order", map);

        Response response = ordersAdminAPI.callEditGeneralDetailOrder(orderID, order);
    }

    @And("Admin edit display surcharges in orderID by api")
    public void admin_edit_display_surcharge_in_order_by_api(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String orderID = null;
        if (infos.get(0).get("order").contains("create by api")) {
            if (infos.get(0).containsKey("index")) {
                orderID = Serenity.sessionVariableCalled("ID Order API" + infos.get(0).get("index"));
            } else {
                orderID = Serenity.sessionVariableCalled("ID Order API");
            }

        }
        Response response = ordersAdminAPI.callDetailOrder(orderID);
        List<String> ids = ordersAdminAPI.getSubInvoiceIdFromOrderDetail(response);
        for (String id : ids) {
            ordersAdminAPI.callEditDisplaySurcharge(id, infos.get(0).get("value").equals("true"));
        }
    }

    @And("Admin get sub-invoice of order {string} by api")
    public void admin_get_subInvoice(String orderID) {
        if (orderID.equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order API");
        }
        Response response = ordersAdminAPI.callDetailOrder(orderID);
        List<String> ids = ordersAdminAPI.getSubInvoiceIdFromOrderDetail(response);
    }

    @And("Admin create purchase order of sub-invoice {string} suffix {string} by API")
    public void admin_create_purchase_order_by_api(String subInvoice, String suffix, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        Map<String, Object> infoObj = new HashMap<>(infos.get(0));
        infoObj.replace("logistics_company_id", infoObj.get("logistics_company_id").toString().contains("api") ? Serenity.sessionVariableCalled("LP Company id api") : infoObj.get("logistics_company_id"));

        if (subInvoice.equals("create by api")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order API").toString();
        }
        if (subInvoice.equals("create by buyer")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order Buyer").toString();
        }
        if (subInvoice.contains("index")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order API" + subInvoice.substring(6)).toString();
        }


        Response response = ordersAdminAPI.callDetailOrder(subInvoice);
        List<String> ids = ordersAdminAPI.getSubInvoiceIdFromOrderDetail(response);
        List<String> numbers = Serenity.sessionVariableCalled("Sub-invoice numbers api");
        String idSubInvoice = "";
        int i = 0;
        for (int j = 0; j < numbers.size(); j++) {
            if (numbers.get(j).endsWith(suffix))
                idSubInvoice = ids.get(j);
        }
        ordersAdminAPI.getIdPurchaseOrder2(ordersAdminAPI.callCreatePO(idSubInvoice, infoObj));

    }

    @And("Admin update purchase order of sub-invoice {string} suffix {string} by API")
    public void admin_update_purchase_order_by_api(String subInvoice, String suffix, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        Map<String, Object> infoObj = new HashMap<>(infos.get(0));
        infoObj.replace("logistics_company_id", infoObj.get("logistics_company_id").toString().contains("api") ? Serenity.sessionVariableCalled("LP Company id api") : infoObj.get("logistics_company_id"));

        if (subInvoice.equals("create by api")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order API").toString();
        }
        if (subInvoice.equals("create by buyer")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order Buyer").toString();
        }
        if (subInvoice.contains("index")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order API" + subInvoice.substring(6)).toString();
        }


        Response response = ordersAdminAPI.callDetailOrder(subInvoice);
        List<String> ids = ordersAdminAPI.getSubInvoiceIdFromOrderDetail(response);

        List<String> numbers = Serenity.sessionVariableCalled("Sub-invoice numbers api");
        List<String> SubIvIDs = Serenity.sessionVariableCalled("List Sub-invoice ID api");
        String idSubInvoice = "";
        String idPO = "";
        for (int j = 0; j < numbers.size(); j++) {
            if (numbers.get(j).endsWith(suffix))
                idSubInvoice = ids.get(j);
        }
        String poID = ordersAdminAPI.getPOIdFromOrderDetail(response, idSubInvoice);
        ordersAdminAPI.updatePO(poID, idSubInvoice, infoObj);

    }

    @And("Admin delete line item of order {string}")
    public void admin_delete_line_item_of_order(String orderID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        if (orderID.equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order API").toString();
            System.out.println("ID of Order " + orderID);
        }
        // get id of line item want to set invoice by skuName or skuID
        Response responseLineItem = ordersAdminAPI.callLineItemOfOrder(orderID);
        List<HashMap> lineItems = ordersAdminAPI.getLineItemsOfOrder(responseLineItem);
        // thêm thuộc tính delete cho line item tương ứng
        HashMap body = ordersAdminAPI.setLineItemToDelete(lineItems, infos);
        // gửi request delete line item
        Response responseDelete = ordersAdminAPI.callDeleteLineItemOfOrder(orderID, body);
    }

    @And("Admin get number order from ID order {string} by api")
    public void get_number_order_from_ID(String idOrder) {
        if (idOrder.isEmpty()) {
            idOrder = Serenity.sessionVariableCalled("Id Order").toString();
        }
        Response response = ordersAdminAPI.callDetailOrder(idOrder);
        ordersAdminAPI.getNumberOrderCreated(response);
    }

}
