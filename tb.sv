module tb;

apb_if intf();

apb_slave dut(intf);

mailbox mbx;
mailbox mon2sb;

generator gen;
apb_driver drv;
apb_monitor mon;
scoreboard sb;

apb_transaction tr;


initial

begin

intf.pclk=0;

forever #5 intf.pclk=~intf.pclk;

end



task reset_dut();

$display(
"\n[TB] AUTO RESET DUE TO ASSERTION FAIL\n"
);

intf.presetn<=0;

repeat(2)

@(posedge intf.pclk);

intf.presetn<=1;

endtask



initial

begin

mbx=new();

mon2sb=new();

gen=new(mbx);

drv=new(intf);

mon=new(intf,mon2sb);

sb=new(mon2sb);


intf.presetn=0;

repeat(2)

@(posedge intf.pclk);

intf.presetn=1;


fork

gen.run();


begin

repeat(10)

begin

mbx.get(tr);

drv.drive(tr);

#1;

if(dut.chk.assert_fail)

begin

reset_dut();

dut.chk.assert_fail=0;

end

end

end


mon.run();

sb.run();

join_none


#500;

$finish;

end

endmodule
