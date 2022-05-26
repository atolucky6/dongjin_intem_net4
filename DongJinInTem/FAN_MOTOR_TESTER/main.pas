unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, HgHGrid, HgGrid, StdCtrls, AlignEdit, ExtCtrls, CPort, DBTables, bde;

type
  TMAINF = class(TForm)
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    setup_btn: TLabel;
    data_btn: TLabel;
    exit_btn: TLabel;
    Label3: TLabel;
    model_btn: TLabel;
    punct_result_label: TLabel;
    Label47: TLabel;
    MODEL_LABEL: TLabel;
    total_result_label: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label35: TLabel;
    total_count_label: TLabel;
    ok_count_label: TLabel;
    ng_count_label: TLabel;
    Label30: TLabel;
    auto_btn: TLabel;
    Label32: TLabel;
    manual_btn: TLabel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    power_result: TLabel;
    Label42: TLabel;
    Label92: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label22: TLabel;
    pwsg: THyperGrid;
    Label26: TLabel;
    Label27: TLabel;
    Label4: TLabel;
    power_test_btn: TLabel;
    Label6: TLabel;
    insulation_test_btn: TLabel;
    insulation_result: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    puncture_result: TLabel;
    Label23: TLabel;
    puncture_test_btn: TLabel;
    m_f_time: TTimer;
    com1: TComPort;
    com2: TComPort;
    sp_reset: TTimer;
    sp_start: TTimer;
    power_meas_timer: TTimer;
    insul_meas_timer: TTimer;
    punct_meas_timer: TTimer;
    step_timer1: TTimer;
    step_timer2: TTimer;
    step_timer3: TTimer;
    step_timer4: TTimer;
    power_auto_time: TTimer;
    clear_time: TTimer;
    daytime: TTimer;
    Label8: TLabel;
    Label10: TLabel;
    power_auto_time2: TTimer;
    com4: TComPort;
    procedure exit_btnClick(Sender: TObject);
    procedure m_f_timeTimer(Sender: TObject);
    procedure setup_btnClick(Sender: TObject);
    procedure model_btnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure manual_btnClick(Sender: TObject);
    procedure auto_btnClick(Sender: TObject);
    procedure power_test_btnClick(Sender: TObject);
    procedure com1RxChar(Sender: TObject; Count: Integer);
    procedure sp_startTimer(Sender: TObject);
    procedure sp_resetTimer(Sender: TObject);
    procedure power_meas_timerTimer(Sender: TObject);
    procedure insulation_test_btnClick(Sender: TObject);
    procedure insul_meas_timerTimer(Sender: TObject);
    procedure puncture_test_btnClick(Sender: TObject);
    procedure punct_meas_timerTimer(Sender: TObject);
    procedure step_timer1Timer(Sender: TObject);
    procedure step_timer2Timer(Sender: TObject);
    procedure step_timer3Timer(Sender: TObject);
    procedure step_timer4Timer(Sender: TObject);
    procedure power_auto_timeTimer(Sender: TObject);
    procedure start_labelClick(Sender: TObject);
    procedure clear_timeTimer(Sender: TObject);
    procedure reset_labelClick(Sender: TObject);
    procedure daytimeTimer(Sender: TObject);
    procedure data_btnClick(Sender: TObject);
    procedure power_auto_time2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MAINF: TMAINF;
  model_load, test_mode, manual_test, total_test_result: integer;
  model_, rotate_mode, test_skip, datename, main_pass_word: string;
  power_AMP_HI, power_AMP_LO, PUNCT_VOLT, PUNCT_amp_hi, Power_volt, POWER_TIME, P_i_TIME: single;
  power_RPM_HI, power_RPM_LO, INSUL_lo, brake_set, r_mode: integer;
//
  power_AMP_HI2, power_AMP_LO2, POWER_TIME2: single;
  power_RPM_HI2, power_RPM_LO2, brake_set2: integer;
//
  test_by_pass: array[0..5] of integer;
//
  test_no, ok_no, ng_no, start_x: integer;
  power_meas_rotate, TEST_RESULT_TEXT, p_i_meas, insul_result, punct_result: string;
  power_meas_rpm, power_meas_rpm2, insulation_meas_resist, power_time_set, power_time_set2, punct_time_set: integer;
  power_meas_amp, power_meas_amp2: single;
  power_amp_result, power_rpm_result, power_rotate_result: integer;
//
procedure CopyTable(T: TTable; DestTblName: string; Overwrite: Boolean);
procedure ready_go;
procedure test_save;
//
implementation
//
uses setup, datamodule, m_f, khj_lib_dj, mk_plc_dj, model, data_list;
//
{$R *.DFM}
//

procedure CopyTable(T: TTable; DestTblName: string; Overwrite: Boolean);
var
  DBType: DBINAME;
  WasOpen: Boolean;
  NumCopied: Word;
begin
  WasOpen := T.Active;
  if not WasOpen then
    T.Open;
  Check(DbiGetProp(hDBIObj(T.Handle), drvDRIVERTYPE, @DBType,
    sizeof(DBINAME), NumCopied));
  Check(DbiCopyTable(T.DBHandle, Overwrite, pChar(T.TableName), DBType,
    pChar(DestTblName)));
  T.Active := WasOpen;
end;

procedure ready_go;
var
  i: integer;
begin
  start_x := 0;
  r_mode := 0;
  p_i_meas := '';
  with mainf do
  begin
    power_result.Caption := '';
    power_result.Color := clwhite;
    puncture_result.Caption := '';
    puncture_result.Color := clwhite;
    insulation_result.Caption := '';
    insulation_result.Color := clwhite;
  end;

  for i := 0 to 2 do
  begin
    mainf.pwsg.Cells[0, i] := '';
    mainf.pwsg.Cells[1, i] := '';
    mainf.pwsg.Cells[2, i] := '';
  end;

  with datamodulef.mmodel do
  begin
    model_ := FieldByName('MODEL').asstring;
    r_mode := FieldByName('R_MODE').asinteger;
    power_AMP_HI := FieldByName('AMP_HI').asFLOAT;
    power_AMP_LO := FieldByName('AMP_LO').asFLOAT;
    power_RPM_HI := FieldByName('RPM_HI').asINTEGER;
    power_RPM_LO := FieldByName('RPM_LO').asINTEGER;
    power_AMP_HI2 := FieldByName('AMP_HI2').asFLOAT;
    power_AMP_LO2 := FieldByName('AMP_LO2').asFLOAT;
    power_RPM_HI2 := FieldByName('RPM_HI2').asINTEGER;
    power_RPM_LO2 := FieldByName('RPM_LO2').asINTEGER;
    rotate_mode := FieldByName('ROTATION').asstring;
    PUNCT_VOLT := FieldByName('P_VOLT').asFLOAT;
    PUNCT_amp_hi := FieldByName('P_AMP_HI').asFLOAT;
    INSUL_lo := FieldByName('INSUL_LO').asINTEGER;
    Power_volt := FieldByName('PW_VOLT').asFLOAT;
    POWER_TIME := FieldByName('PW_TIME').asFLOAT;
    brake_set := FieldByName('BRAKE').asINTEGER;
    POWER_TIME2 := FieldByName('PW_TIME2').asFLOAT;
    brake_set2 := FieldByName('BRAKE2').asINTEGER;
    P_i_TIME := FieldByName('INSUL_TIME').asFLOAT;
    test_skip := FieldByName('TEST_SKIP').asstring;
  end;
  mainf.label19.Caption := 'AC (' + roundto(PUNCT_VOLT, 2) + ' kVrms) ' + #13 + #10 + #13 + #10 + roundto(PUNCT_amp_hi, 1) + ' mA ↓'; ;
//    mainf.punct_curr_test_label.Caption := 'Current ' + roundto(p_amp, 1) + ' mA ↓';
  mainf.label17.Caption := 'DC ( 500 Vdc ) ' + #13 + #10 + #13 + #10 + inttostr(insul_lo) + '   MΩ  ↑';
  power_time_set := trunc(power_time * 1000);
  if power_time_set = 0 then power_time_set := 1000;
  power_time_set2 := trunc(power_time2 * 1000);
  if power_time_set2 = 0 then power_time_set2 := 1000;
  punct_time_set := trunc(p_i_time * 1000);
  mainf.power_auto_time.Interval := power_time_set;
  mainf.power_auto_time2.Interval := power_time_set2;
  mainf.insul_meas_timer.Interval := punct_time_set;
  mainf.punct_meas_timer.Interval := punct_time_set;
  mainf.model_label.Caption := model_;
  mainf.pwsg.Cells[0, 0] := roundto(power_AMP_HI, 2);
  mainf.pwsg.Cells[0, 1] := inttostr(power_RPM_HI);
  mainf.pwsg.Cells[2, 0] := roundto(power_AMP_LO, 2);
  mainf.pwsg.Cells[2, 1] := inttostr(power_RPM_LO);
  mainf.pwsg.Cells[2, 4] := '';
  mainf.pwsg.Cells[0, 2] := roundto(power_AMP_HI2, 2);
  mainf.pwsg.Cells[0, 3] := inttostr(power_RPM_HI2);
  mainf.pwsg.Cells[2, 2] := roundto(power_AMP_LO2, 2);
  mainf.pwsg.Cells[2, 3] := inttostr(power_RPM_LO2);
  if r_mode = 0 then
  begin
    mainf.pwsg.Cells[0, 2] := '---';
    mainf.pwsg.Cells[0, 3] := '---';
    mainf.pwsg.Cells[2, 2] := '---';
    mainf.pwsg.Cells[2, 3] := '---';
    mainf.pwsg.Cells[2, 4] := '';
  end;
  mainf.pwsg.Cells[0, 4] := rotate_mode;
  i := 0;
  for i := 0 to 5 do
  begin
    if copy(test_skip, i, 1) = '1' then test_by_pass[i] := 1;
    if copy(test_skip, i, 1) = '0' then test_by_pass[i] := 0;
  end;
  test_mode := 1;
  plc_ready;
  mainf.daytime.Enabled := true;
end;

procedure test_save;
begin
  test_no := test_no + 1;
  with datamodulef.test_table do
  begin
    append;
    fieldByName('TEST_NO').asinteger := test_no + 1;
    fieldByName('TIME').asstring := FormatDateTime('DD-HH:mm', now);
    fieldByName('POWER_AMP1').asfloat := power_meas_amp;
    fieldByName('POWER_RPM1').asfloat := power_meas_rpm;
    fieldByName('ROTATION').asstring := power_meas_rotate;
    fieldByName('INSULATION').asstring := insul_result;
    fieldByName('PUNCT').asstring := punct_result;
    fieldByName('RESULT').asstring := TEST_RESULT_TEXT;
    if r_mode = 1 then
    begin
      fieldByName('POWER_AMP2').asfloat := power_meas_amp2;
      fieldByName('POWER_RPM2').asfloat := power_meas_rpm2;
    end;
    post;
  end;
  if TEST_RESULT_TEXT = 'OK' then
  begin
    ok_no := ok_no + 1;
    mainf.ok_count_label.Caption := inttostr(ok_no);
  end;
  if TEST_RESULT_TEXT = 'NG' then
  begin
    ng_no := ng_no + 1;
    mainf.ng_count_label.Caption := inttostr(ng_no);
  end;
  mainf.model_btn.Enabled := true;
  mainf.auto_btn.Enabled := true;
  mainf.manual_btn.Enabled := true;
  mainf.setup_btn.Enabled := true;
  mainf.data_btn.Enabled := true;
  mainf.exit_btn.Enabled := true;
  mainf.total_count_label.Caption := inttostr(test_no);
end;

procedure TMAINF.FormCreate(Sender: TObject);
begin
  start_x := 0;
  com1.Connected := true;
  com2.Connected := true;
//  com4.connected := true;
  model_load := 0;
  test_no := 0;
  test_mode := 0;
//
  with datamodulef do
  begin
    last_table.Open;
    last_table.Last;
    model_ := last_table.FieldByName('MODEL').asstring;
    main_pass_word := last_table.FieldByName('NO').asstring;
    last_table.close;
    mmodel.OPEN;
    mmodel.Locate('MODEL', MODEL_, []);
  end;
  ready_go;
end;

procedure TMAINF.exit_btnClick(Sender: TObject);
begin
  plc_Ready_off;
  datamodulef.mmodel.Close;
  com1.Close;
  com2.Close;
//  com4.Close;
  datamodulef.last_table.open;
  datamodulef.last_table.Append;
  datamodulef.last_table.fieldByName('MODEL').asstring := MODEL_;
  datamodulef.last_table.FieldByName('NO').asstring := main_pass_word;
  datamodulef.last_table.Post;
  datamodulef.last_table.Close;
  close;
end;

procedure TMAINF.m_f_timeTimer(Sender: TObject);
begin
  m_f_time.Enabled := false;
  beep;
  form1.Show;
  form1.Timer1.Enabled := true;
end;

procedure TMAINF.setup_btnClick(Sender: TObject);
var
  i, k: integer;
  a, pass_word: string;
begin
  k := 0;
  pass_word := '****';
  pass_word := InputBox('               PASSWORD', 'PASSWORD?', pass_word);
  if main_pass_word = pass_word then
  begin
    k := 1;
    plc_Ready_off;
    datamodulef.mmodel.open;
    datamodulef.mmodel.Locate('MODEL', MODEL_, []);
    setupf.Timer3.Enabled := true;
    mainf.Hide;
    setupf.show;
    clear_time.Enabled := true;
  end;
  if k = 0 then
  begin
    beep;
    showmessage(' PASSWORD !!');
  end;
end;

procedure TMAINF.model_btnClick(Sender: TObject);
begin
  model_load := 1;
  datamodulef.mmodel.open;
  modelf.showmodal;
  clear_time.Enabled := true;
end;

procedure TMAINF.manual_btnClick(Sender: TObject);
begin
  test_mode := 2;
  manual_test := 2;
  clear_time.Enabled := true;
end;

procedure TMAINF.auto_btnClick(Sender: TObject);
begin
  test_mode := 1;
  clear_time.Enabled := true;
end;

procedure TMAINF.power_test_btnClick(Sender: TObject);
var
  send_volt, send_brake: string;
begin
  if test_mode = 2 then
  begin
    if manual_test = 1 then
    begin
      com2.WriteStr('RS' + #13);
      power_test_btn.Caption := 'TEST';
      sleep(500);
      plc_power_test_end;
      manual_test := 0;
    end;
  end;
  if test_mode = 2 then
  begin
    if manual_test = 2 then
    begin
      manual_test := 1;
      send_volt := FORMAT('%.4d', [TRUNC(power_volt * 100)]);
      send_brake := FORMAT('%.4d', [brake_set]);
      plc_power_test;
      plc_power_mode1;
      com2.WriteStr('ST' + '0400' + '0000' + #13);
      sleep(1000);
      com2.WriteStr('ST' + send_volt + send_brake + #13);
      power_test_btn.Caption := 'STOP';
      power_meas_timer.Enabled := true;
    end;
  end;
  if manual_test = 0 then manual_test := 2;
end;

procedure Tmainf.com1RxChar(Sender: TObject; Count: Integer);
var
  Y, Z, b: string;
  a: integer;
begin
  Com1.Readstr(Y, 50);
  Z := Copy(Y, (Pos('%', Y) + 1), 1);
  if Z = 'C' then
  begin
    start_x := 0;
    manual_test := 0;
    sp_start.Enabled := false;
    sp_reset.Enabled := true;
  end;
//
  if Z = 'P' then
  begin
    if start_x = 0 then
    begin
      start_x := 1;
      sp_reset.Enabled := false;
      sp_start.Enabled := true;
    end;
  end;

  if Z = 'M' then
  begin
    power_meas_rotate := 'CW';
  end;

  if Z = 'D' then
  begin
    power_meas_rotate := 'CCW';
  end;

  if Z = 'L' then
  begin
    p_i_meas := 'OK';
  end;

  if Z = 'K' then
  begin
    p_i_meas := 'NG';
  end;
end;

procedure TMAINF.sp_startTimer(Sender: TObject);
begin
  sp_start.Enabled := false;
  clear_time.Enabled := true;
  if test_mode = 1 then
  begin
    total_test_result := 0;
    if test_by_pass[1] = 1 then
    begin
      step_timer1.enabled := true;
    end;
    if test_by_pass[1] = 0 then
    begin
      step_timer2.enabled := true;
    end;
  end;
end;

procedure TMAINF.sp_resetTimer(Sender: TObject);
begin
  sp_reset.Enabled := false;
  start_x := 0;
  manual_test := 0;
  com2.WriteStr('RS' + #13);
  plc_test_reset;
  power_amp_result := 0;
  power_rpm_result := 0;
  power_rotate_result := 0;
//  start_label.Visible := true;
end;

procedure TMAINF.power_meas_timerTimer(Sender: TObject);
var
  a, read_amp, read_rpm, read_rotate, read_volt: string;
  test_result: integer;
begin
  power_meas_timer.Enabled := false;
  power_amp_result := 0;
  power_rpm_result := 0;
  power_rotate_result := 0;
  test_result := 0;
  if manual_test = 1 then
  begin
    com2.WriteStr('ME' + #13);
    sleep(100);
    com2.ReadStr(a, 22);
    read_volt := copy(a, 1, 4);
    read_amp := copy(a, 7, 2) + copy(a, 9, 2);
    read_rpm := copy(a, 13, 4);
    power_meas_amp := strtocurr(read_amp) / 100;
    power_meas_rpm := strtointdef(read_rpm, 0);
    read_amp := roundto(power_meas_amp, 2);
    if (power_amp_hi < power_meas_amp) or (power_amp_lo > power_meas_amp) then
    begin
      power_amp_result := 1;
    end;
    if (power_rpm_hi < power_meas_rpm) or (power_rpm_lo > power_meas_rpm) then
    begin
      power_rpm_result := 1;
    end;
    if rotate_mode <> power_meas_rotate then
    begin
      power_rotate_result := 1;
    end;
    pwsg.Cells[1, 0] := read_amp;
    pwsg.Cells[1, 1] := read_rpm;
    pwsg.Cells[1, 4] := power_meas_rotate;
    if power_amp_result = 1 then
    begin
      test_result := 1;
    end;
    if power_rpm_result = 1 then
    begin
      test_result := 1;
    end;
    if power_rotate_result = 1 then
    begin
      test_result := 1;
    end;
    if test_result = 1 then
    begin
      power_result.Caption := 'NG';
      power_result.Color := clred;
      total_test_result := 1;
    end;
    if test_result = 0 then
    begin
      power_result.Caption := 'OK';
      power_result.Color := cllime;
    end;
    if manual_test = 1 then power_meas_timer.Enabled := true;
  end;
end;

procedure TMAINF.insulation_test_btnClick(Sender: TObject);
begin
  if test_mode = 2 then
  begin
    p_i_meas := '';
    insulation_result.Caption := '';
    insulation_result.Color := clwhite;
    insulation_test_btn.Caption := 'TEST';
    plc_insul_test;
    insul_meas_timer.Enabled := true;
  end;
end;

procedure TMAINF.insul_meas_timerTimer(Sender: TObject);
begin
  insul_meas_timer.Enabled := false;
  plc_insul_test_end;
  insul_result := '';
  if p_i_meas = 'NG' then
  begin
    insulation_result.Caption := 'NG';
    insulation_result.Color := clred;
    insul_result := 'NG';
    total_test_result := 1;
  end;
  if p_i_meas = 'OK' then
  begin
    insulation_result.Caption := 'OK';
    insulation_result.Color := cllime;
    insul_result := 'OK';
  end;
  if p_i_meas = '' then
  begin
    p_i_meas := 'ERR';
    insulation_result.Caption := 'ERR';
    insulation_result.Color := clred;
    insul_result := 'ERR';
    total_test_result := 1;
  end;
  sleep(100);
  if test_mode = 1 then
  begin
    if start_x = 1 then step_timer3.Enabled := true;
  end;
end;

procedure TMAINF.puncture_test_btnClick(Sender: TObject);
begin
  if test_mode = 2 then
  begin
    p_i_meas := '';
    puncture_result.Caption := '';
    puncture_result.Color := clwhite;
    puncture_test_btn.Caption := 'TEST';
    plc_punct_test;
    punct_meas_timer.Enabled := true;
  end;
end;

procedure TMAINF.punct_meas_timerTimer(Sender: TObject);
begin
  punct_meas_timer.Enabled := false;
  plc_punct_test_end;
  punct_result := '';
  if p_i_meas = 'NG' then
  begin
    puncture_result.Caption := 'NG';
    puncture_result.Color := clred;
    punct_result := 'NG';
    total_test_result := 1;
  end;
  if p_i_meas = 'OK' then
  begin
    puncture_result.Caption := 'OK';
    puncture_result.Color := cllime;
    punct_result := 'OK';
  end;
  if p_i_meas = '' then
  begin
    p_i_meas := 'ERR';
    puncture_result.Caption := 'ERR';
    puncture_result.Color := clred;
    punct_result := 'ERR';
    total_test_result := 1;
  end;
  if test_mode = 1 then
  begin
    if start_x = 1 then step_timer4.Enabled := true;
  end;
end;

procedure TMAINF.step_timer1Timer(Sender: TObject);
var
  send_volt, send_brake: string;
begin
  step_timer1.Enabled := false;
  send_volt := FORMAT('%.4d', [TRUNC(power_volt * 100)]);
  send_brake := FORMAT('%.4d', [brake_set]);
  plc_power_mode1;
  sleep(500);
  plc_power_test;
  com2.WriteStr('ST' + '0400' + '0000' + #13);
  sleep(1000);
  if (start_x = 1) then
  begin
    send_brake := FORMAT('%.4d', [brake_set]);
    com2.WriteStr('ST' + send_volt + send_brake + #13);
    if start_x = 1 then power_auto_time.enabled := true;
  end;
end;

procedure TMAINF.step_timer2Timer(Sender: TObject);
begin
  step_timer2.Enabled := false;
  if test_mode = 1 then
  begin
    if test_by_pass[2] = 1 then
    begin
      p_i_meas := '';
      insulation_result.Caption := '';
      insulation_result.Color := clwhite;
      plc_insul_test;
      if start_x = 1 then insul_meas_timer.Enabled := true;
    end;
    if test_by_pass[2] = 0 then
    begin
      step_timer3.enabled := true;
    end;
  end;
end;

procedure TMAINF.step_timer3Timer(Sender: TObject);
begin
  step_timer3.Enabled := false;
  if test_mode = 1 then
  begin
    if test_by_pass[3] = 1 then
    begin
      p_i_meas := '';
      puncture_result.Caption := '';
      puncture_result.Color := clwhite;
      puncture_test_btn.Caption := 'TEST';
      plc_punct_test;
      if start_x = 1 then punct_meas_timer.Enabled := true;
    end;
    if test_by_pass[3] = 0 then
    begin
      step_timer4.enabled := true;
    end;
  end;
end;

procedure TMAINF.step_timer4Timer(Sender: TObject);
begin
  step_timer4.Enabled := false;
  if total_test_result = 1 then
  begin
    TEST_RESULT_TEXT := 'NG';
    total_result_label.Caption := 'NG';
    total_result_label.Color := clred;
    plc_test_ng;
    sleep(500);
  end;
  if total_test_result = 0 then
  begin
    TEST_RESULT_TEXT := 'OK';
    total_result_label.Caption := 'OK';
    total_result_label.Color := cllime;
    plc_test_ok;
//    com4.WriteStr('START');
  end;
  test_save;
  sp_reset.Enabled := true;
end;

procedure TMAINF.power_auto_timeTimer(Sender: TObject);
var
  a, read_amp, read_rpm, read_rotate, read_volt: string;
  test_result: integer;
  send_volt, send_brake: string;
begin
  power_auto_time.Enabled := false;
  power_amp_result := 0;
  power_rpm_result := 0;
  power_rotate_result := 0;
  test_result := 0;
  com2.WriteStr('ME' + #13);
  sleep(100);
  com2.ReadStr(a, 22);
  read_volt := copy(a, 1, 4);
  read_amp := copy(a, 7, 2) + copy(a, 9, 2);
  read_rpm := copy(a, 13, 4);
  if r_mode = 0 then com2.WriteStr('RS' + #13);
  if r_mode = 0 then plc_power_test_end;
  sleep(100);
  power_meas_amp := strtocurr(read_amp) / 100;
  power_meas_rpm := strtointdef(read_rpm, 0);
  read_amp := roundto(power_meas_amp, 2);
  if (power_amp_hi < power_meas_amp) or (power_amp_lo > power_meas_amp) then
  begin
    power_amp_result := 1;
  end;
  if (power_rpm_hi < power_meas_rpm) or (power_rpm_lo > power_meas_rpm) then
  begin
    power_rpm_result := 1;
  end;
  if rotate_mode <> power_meas_rotate then
  begin
    power_rotate_result := 1;
  end;
  pwsg.Cells[1, 0] := read_amp;
  pwsg.Cells[1, 1] := read_rpm;
  pwsg.Cells[1, 4] := power_meas_rotate;
  if power_amp_result = 1 then
  begin
    test_result := 1;
  end;
  if power_rpm_result = 1 then
  begin
    test_result := 1;
  end;
  if power_rotate_result = 1 then
  begin
    test_result := 1;
  end;
  if r_mode = 0 then
  begin
    if test_result = 1 then
    begin
      power_result.Caption := 'NG';
      power_result.Color := clred;
      total_test_result := 1;
    end;

    if test_result = 0 then
    begin
      power_result.Caption := 'OK';
      power_result.Color := cllime;
    end;
  end;

  if (start_x = 1) and (r_mode = 0) then step_timer2.Enabled := true;
  if (start_x = 1) and (r_mode = 1) then
  begin
    send_volt := FORMAT('%.4d', [TRUNC(power_volt * 100)]);
    send_brake := FORMAT('%.4d', [brake_set2]);
    plc_power_mode2;
    com2.WriteStr('ST' + send_volt + send_brake + #13);
    if start_x = 1 then power_auto_time2.enabled := true;
  end;
end;


procedure TMAINF.power_auto_time2Timer(Sender: TObject);
var
  a, read_amp, read_rpm, read_rotate, read_volt: string;
  test_result: integer;
begin
  power_auto_time2.Enabled := false;
  test_result := 0;
  com2.WriteStr('ME' + #13);
  sleep(100);
  com2.ReadStr(a, 22);
  read_volt := copy(a, 1, 4);
  read_amp := copy(a, 7, 2) + copy(a, 9, 2);
  read_rpm := copy(a, 13, 4);
  com2.WriteStr('RS' + #13);
  plc_power_test_end;
  sleep(100);
  power_meas_amp2 := strtocurr(read_amp) / 100;
  power_meas_rpm2 := strtointdef(read_rpm, 0);
  read_amp := roundto(power_meas_amp2, 2);
  if (power_amp_hi2 < power_meas_amp2) or (power_amp_lo2 > power_meas_amp2) then
  begin
    power_amp_result := 1;
  end;
  if (power_rpm_hi2 < power_meas_rpm2) or (power_rpm_lo2 > power_meas_rpm2) then
  begin
    power_rpm_result := 1;
  end;
  if rotate_mode <> power_meas_rotate then
  begin
    power_rotate_result := 1;
  end;
  pwsg.Cells[1, 2] := read_amp;
  pwsg.Cells[1, 3] := read_rpm;
  pwsg.Cells[1, 4] := power_meas_rotate;
  if power_amp_result = 1 then
  begin
    test_result := 1;
  end;
  if power_rpm_result = 1 then
  begin
    test_result := 1;
  end;
  if power_rotate_result = 1 then
  begin
    test_result := 1;
  end;
  if (test_result = 1) or (total_test_result = 1) then
  begin
    power_result.Caption := 'NG';
    power_result.Color := clred;
    total_test_result := 1;
  end;
  if (test_result = 0) and (total_test_result = 0) then
  begin
    power_result.Caption := 'OK';
    power_result.Color := cllime;
  end;
  if (start_x = 1) then step_timer2.Enabled := true;
end;

procedure TMAINF.start_labelClick(Sender: TObject);
begin
  if test_mode = 1 then
  begin
    start_x := 1;
    sp_start.Enabled := true;
    clear_time.Enabled := true;
//    start_label.Visible := false;
  end;
end;

procedure TMAINF.clear_timeTimer(Sender: TObject);
var
  i: integer;
begin
  clear_time.Enabled := false;
  power_result.Caption := '';
  power_result.Color := clwhite;
  puncture_result.Caption := '';
  puncture_result.Color := clwhite;
  insulation_result.Caption := '';
  insulation_result.Color := clwhite;
  total_result_label.Caption := '';
  total_result_label.Color := clwhite;
  if start_x = 1 then
  begin
    total_result_label.Caption := 'TEST';
  end;
  for i := 0 to 4 do
  begin
    mainf.pwsg.Cells[1, i] := '';
  end;
end;

procedure TMAINF.reset_labelClick(Sender: TObject);
begin
  sp_reset.Enabled := true;
end;

procedure TMAINF.daytimeTimer(Sender: TObject);
var
  I, J, X, Y: integer;
  test_folder, a: string;
  TableList: TStringList;
begin
  daytime.Enabled := false;
  Y := 0;
  datename := formatdatetime('yyyy-mm-dd', now);
  TableList := TStringList.CrEATE;
  try
    test_folder := 'C:\FAN_MOTOR_TESTER\TEST_DATA\' + model_;
    Session.GetTableNames(test_folder, '*.DBF', False, False, TableList);
    for i := 0 to TableList.Count - 1 do
    begin
      if TableList.Strings[i] = DATeNAME then Y := 1;
    end;
  finally
    TableList.Free;
  end;
  if Y = 0 then
  begin
    datamodulef.test_table.Active := false;
    datamodulef.new_table.Active := true;
    datename := formatdatetime('yyyy-mm-dd', now);
    copytable(datamodulef.new_table, test_folder + '\' + datename, true);
    datamodulef.new_table.Active := false;
  end;
  with datamodulef.test_table do
  begin
    active := false;
    DatabaseName := '';
    TableName := '';
    DatabaseName := test_folder;
    TableName := datename + '.dbf';
    Active := true;
  end;
  datamodulef.test_table.first;
  x := datamodulef.test_table.RecordCount;
  test_no := x;
  total_count_label.Caption := inttostr(test_no);
  mainf.m_f_time.Enabled := true;
  form1.Panel1.Caption := '- READY -';
  datamodulef.test_table.first;
  x := 0;
  y := 0;
  for i := 0 to datamodulef.test_table.RecordCount - 1 do
  begin
    a := datamodulef.test_table.FieldByName('RESULT').asstring;
    a := uppercase(a);
    if a = 'OK' then x := x + 1;
    if a = 'NG' then y := y + 1;
    datamodulef.test_table.Next;
  end;
  ok_no := x;
  ng_no := y;
  ok_count_label.Caption := inttostr(ok_no);
  ng_count_label.Caption := inttostr(ng_no);
end;

procedure TMAINF.data_btnClick(Sender: TObject);
var
  a, b, c: string;
  i, x, y, z: integer;
  sr: TSearchRec;
  s, drf: string;
begin
  model_label.Caption := '';
  clear_time.Enabled := true;
  datamodulef.mmodel.Active := true;
  data_listf.Show;
  datamodulef.test_table.close;
//
  x := 0;
  y := 0;
  z := 0;
  with DATA_LISTF do
  begin
    datasource1.Enabled := false;
    total_no_.Text := '0';
    ok_no.Text := '0';
    ng_no.Text := '0';
    try
      if model_ <> '' then
      begin
        table1.Active := false;
        table1.DatabaseName := 'C:\FAN_MOTOR_TESTER\TEST_DATA\' + model_;
        table1.TableName := datename;
        table1.Active := true;
        edit2.Text := model_;
        edit1.Text := datename;
        table1.First;
        for i := 0 to table1.RecordCount - 1 do
        begin
          a := table1.FieldByName('RESULT').asstring;
          a := uppercase(a);
          if a = 'OK' then x := x + 1;
          if a = 'NG' then y := y + 1;
          table1.Next;
        end;
        datasource1.Enabled := true;
        total_no_.Text := inttostr(table1.RecordCount);
        ok_no.Text := inttostr(x);
        ng_no.Text := inttostr(y);
      end;
    except
      table1.Active := false;
      showmessage('측정 데이타 파일이 없읍니다');
      total_no_.Text := '0';
      ok_no.Text := '0';
      ng_no.Text := '0';
    end;
  end;
  i := 0;
  data_listf.combobox1.items.Clear;
  drf := 'C:\FAN_MOTOR_TESTER\TEST_DATA\' + model_ + '\*.*';
  if FindFirst(drf, faAnyFile, sr) = 0 then
  begin
    with data_listf.combobox1 do
    begin
      if (sr.Attr and faAnyFile) = sr.Attr then
      begin
//        s := sr.Name;
//        items.Add(copy(s,1,10));
      end;
      while FindNext(sr) = 0 do
      begin
        if (sr.Attr and faAnyFile) = sr.Attr then
        begin
          s := sr.Name;
          if i > 0 then items.Add(copy(s, 1, 10));
          i := i + 1;
        end;
      end;
      FindClose(sr);
    end;
  end;
  if i > 1 then
  begin
    data_listf.combobox1.Enabled := true;
//    edit2.Text:=data_listf.test_model_box.Text;
//  combobox1.Itemindex:=1;
  end;
  if i <= 1 then
  begin
    data_listf.combobox1.items.Clear;
    data_listf.combobox1.Enabled := false;
//  combobox1.Itemindex:=1;
  end;

end;

initialization
  begin
    CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0,
      1024, 'fan_motor_tester');
    if GetLastError = ERROR_ALREADY_EXISTS then
      halt;
  end;

end.

