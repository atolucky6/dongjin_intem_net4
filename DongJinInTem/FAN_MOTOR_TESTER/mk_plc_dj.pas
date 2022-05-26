unit mk_plc_dj; //(dong_yang)armature_tester

interface
uses Windows;
//
procedure plc_ready;
procedure plc_Ready_off;
procedure plc_test_start;
procedure plc_test_reset;
procedure plc_power_test;
procedure plc_power_mode1;
procedure plc_power_mode1_off;
procedure plc_power_mode2;
procedure plc_power_mode2_off;
procedure plc_insul_test;
procedure plc_punct_test;
procedure plc_discharge_test;
procedure plc_power_test_end;
procedure plc_insul_test_end;
procedure plc_punct_test_end;
procedure plc_test_ng;
procedure plc_test_ok;
//
implementation

uses main;

procedure plc_Ready;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX60001' + #04);
  b := (#05 + '00WSS0106%MX60000' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_Ready_off;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX60001' + #04);
  b := (#05 + '00WSS0106%MX60000' + #04);
  sleep(50);
  mainf.Com1.WriteStr(b);
end;

procedure plc_test_ng;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX60101' + #04);
  b := (#05 + '00WSS0106%MX60100' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_test_ok;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX60201' + #04);
  b := (#05 + '00WSS0106%MX60200' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_test_reset;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX60301' + #04);
  b := (#05 + '00WSS0106%MX60300' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
  sleep(500);
  mainf.Com1.WriteStr(b);
end;

procedure plc_test_start;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX60401' + #04);
  b := (#05 + '00WSS0106%MX60400' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_power_test;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40101' + #04);
  b := (#05 + '00WSS0106%MX40100' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_power_mode1;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40601' + #04);
  b := (#05 + '00WSS0106%MX40600' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_power_mode1_off;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40601' + #04);
  b := (#05 + '00WSS0106%MX40600' + #04);
  sleep(50);
  mainf.Com1.WriteStr(b);
end;

procedure plc_power_mode2;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40501' + #04);
  b := (#05 + '00WSS0106%MX40500' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_power_mode2_off;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40501' + #04);
  b := (#05 + '00WSS0106%MX40500' + #04);
  sleep(50);
  mainf.Com1.WriteStr(b);
end;

procedure plc_insul_test;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40201' + #04);
  b := (#05 + '00WSS0106%MX40200' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_punct_test;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40301' + #04);
  b := (#05 + '00WSS0106%MX40300' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_discharge_test;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40401' + #04);
  b := (#05 + '00WSS0106%MX40400' + #04);
  sleep(50);
  mainf.Com1.WriteStr(a);
end;

procedure plc_power_test_end;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40101' + #04);
  b := (#05 + '00WSS0106%MX40100' + #04);
  sleep(50);
  mainf.Com1.WriteStr(b);
end;

procedure plc_insul_test_end;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40201' + #04);
  b := (#05 + '00WSS0106%MX40200' + #04);
  sleep(50);
  mainf.Com1.WriteStr(b);
end;

procedure plc_punct_test_end;
var
  a, b: string;
begin
  a := (#05 + '00WSS0106%MX40301' + #04);
  b := (#05 + '00WSS0106%MX40300' + #04);
  sleep(50);
  mainf.Com1.WriteStr(b);
end;
end.

