module apb_checker(apb_if intf);

bit assert_fail=0;


property PENABLE_AFTER_PSEL;

@(posedge intf.pclk)

disable iff(!intf.presetn)

$rose(intf.psel)

|=> intf.penable;

endproperty



property PSEL_ACCESS;

@(posedge intf.pclk)

disable iff(!intf.presetn)

intf.penable
|-> (intf.psel && $stable(intf.paddr));

endproperty

property TRANS_END;

@(posedge intf.pclk)

disable iff(!intf.presetn)

$fell(intf.psel)

|-> !intf.penable;

endproperty





A1: assert property(PENABLE_AFTER_PSEL)

begin
$display("[ASSERT PASS] PENABLE_AFTER_PSEL");
end

else

begin

assert_fail=1;

$display("[ASSERT FAIL] PENABLE_AFTER_PSEL");

end



A2: assert property(PSEL_ACCESS)

begin
$display("[ASSERT PASS] PSEL_ACCESS");
end

else

begin

assert_fail=1;

$display("[ASSERT FAIL] PSEL_ACCESS");

end

A3: assert property(TRANS_END)

$display("[ASSERT PASS] TRANS_END");

else
$display("[ASSERT FAIL] TRANS_END");
endmodule
