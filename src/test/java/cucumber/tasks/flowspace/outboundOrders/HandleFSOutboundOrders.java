package cucumber.tasks.flowspace.outboundOrders;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.flowspace.FSOutboundOrdersPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

public class HandleFSOutboundOrders {

    public static Task search(Map<String, String> info) {
        return Task.where("Search outbound orders",
                // Open filter popup
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.FILTER_BUTTON),
                Click.on(FSOutboundOrdersPage.FILTER_BUTTON),
                // Fill info to filter
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.FILTER_POPUP),
                Check.whether(info.get("sku").isEmpty())
                        .otherwise(Enter.theValue(info.get("sku")).into(FSOutboundOrdersPage.TEXTBOX_FILTER_POPUP("SKU"))),
                // Apply filter
                Click.on(FSOutboundOrdersPage.FILTER_APPLY_BUTTON),
                CommonWaitUntil.isNotVisible(FSOutboundOrdersPage.FILTER_POPUP)
        );
    }

    public static Task goToDetail(String dropNumber) {
        return Task.where("Go to detail drop",
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.VIEW_IN_LIST(dropNumber)),
                Click.on(FSOutboundOrdersPage.VIEW_IN_LIST(dropNumber))
        );
    }

    public static Task changeRole(String role) {
        return Task.where("Change role to " + role,
                // Open dropdown
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.NAV_BAR),
                Click.on(FSOutboundOrdersPage.NAV_BAR),
                // Choose role
                CommonTask.chooseItemInDropdown1(FSOutboundOrdersPage.ROLE_SELECT, FSOutboundOrdersPage.ROLE_SELECT_OPTION(role)),
                CommonWaitUntil.isNotVisible(FSOutboundOrdersPage.ROLE_SELECT)
        );
    }

    public static Task picking() {
        return Task.where("Picking",
                // Begin picking
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.BEGIN_PICKING_BUTTON),
                Click.on(FSOutboundOrdersPage.BEGIN_PICKING_BUTTON),
                // Finish picking
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.FINISH_PICKING_BUTTON),
                Click.on(FSOutboundOrdersPage.FINISH_PICKING_BUTTON),
                // Confirm picking
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.FINISH_PICKING_BUTTON),
                Click.on(FSOutboundOrdersPage.FINISH_PICKING_BUTTON)
        );
    }

    public static Task pack(Map<String, String> info) {
        return Task.where("Pack",
                // Begin pack
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.PACK_BUTTON),
                Click.on(FSOutboundOrdersPage.PACK_BUTTON),
                // Fill info
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.LENGTH_TEXTBOX),
                Enter.theValue(info.get("length")).into(FSOutboundOrdersPage.LENGTH_TEXTBOX),
                Enter.theValue(info.get("width")).into(FSOutboundOrdersPage.WIDTH_TEXTBOX),
                Enter.theValue(info.get("height")).into(FSOutboundOrdersPage.HEIGHT_TEXTBOX),
                Enter.theValue(info.get("palletWeight")).into(FSOutboundOrdersPage.WEIGHT_TEXTBOX),
                Enter.theValue(info.get("numberPallet")).into(FSOutboundOrdersPage.NUMBER_PALLET_TEXTBOX),
                // Pack order
                Click.on(FSOutboundOrdersPage.PACK_ORDER_BUTTON),
                CommonWaitUntil.isNotVisible(FSOutboundOrdersPage.PACK_ORDER_BUTTON)
        );
    }

    public static Task ship(Map<String, String> info) {
        return Task.where("Picking",
                // Begin ship
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.SHIP_BUTTON),
                Click.on(FSOutboundOrdersPage.SHIP_BUTTON),
                // Finish picking
                CommonWaitUntil.isVisible(FSOutboundOrdersPage.SHIP_ORDER_BUTTON),
                Enter.theValue(info.get("billOfLading")).into(FSOutboundOrdersPage.BILL_OF_LADING_TEXTBOX),
                Click.on(FSOutboundOrdersPage.SHIP_ORDER_BUTTON)
        );
    }

}
