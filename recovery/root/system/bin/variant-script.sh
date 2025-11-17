#!/system/bin/sh

variant="$(getprop ro.boot.prjname)"
echo "$variant"

if command -v resetprop >/dev/null 2>&1; then
    _setprop_cmd="resetprop"
else
    _setprop_cmd="setprop"
fi

sp() {
    "$_setprop_cmd" "$1" "$2"
}

set_oneplus_common() {
    local usb_name="$1"
    local product_name="$2"
    local device_code="$3"
    local region="$4"
    local spr_value="$5"

    echo "$usb_name" > /config/usb_gadget/g1/strings/0x409/product

    sp ro.product.brand "OnePlus"
    sp ro.product.manufacturer "OnePlus"
    sp vendor.display.enable_spr "$spr_value"
    sp ro.product.name "$product_name"
    sp ro.product.device "$device_code"
    sp ro.product.system.device "$product_name"
    sp ro.product.vendor.device "$device_code"
    sp ro.product.odm.device "$device_code"
    sp ro.product.product.device "$device_code"
    sp ro.product.system_ext.device "$device_code"
    sp ro.product.product.model "$product_name"
    sp ro.product.model "$product_name"
    sp ro.product.system.model "$product_name"
    sp ro.product.system_ext.model "$product_name"
    sp ro.product.vendor.model "$product_name"
    sp ro.product.odm.model "$product_name"
    sp ro.boot.hardware.revision "$region"
}

case "$variant" in
    "23851")
        # OnePlus ACE 5 (giulia)
        set_oneplus_common "Oneplus ACE 5" "PKG110" "OP5D2BL1" "CN" "0"
        ;;

    "23868")
        # OnePlus 13R (giulia) - CPH2645
        set_oneplus_common "Oneplus 13 R" "CPH2645" "OP5D3BL1" "GL" "0"
        ;;

    "23869")
        # OnePlus 13R (giulia) - CPH2647
        set_oneplus_common "Oneplus 13 R" "CPH2647" "OP5D3BL1" "NA" "0"
        ;;

    "23867")
        # OnePlus 13R (giulia) - CPH2691
        set_oneplus_common "Oneplus 13 R" "CPH2691" "OP5D3BL1" "IN" "0"
        ;;

    *)
        # Unknown variant
        echo "Unknown variant: $variant" >&2
        ;;
esac

exit 0
