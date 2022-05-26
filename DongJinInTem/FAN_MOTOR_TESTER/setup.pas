unit setup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, HgHGrid, HgGrid, StdCtrls, AlignEdit, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart, math, db, FileCtrl;

type
  Tsetupf = class(TForm)
    Label1: TLabel;
    model_edit_text: TEdit;
    Label11: TLabel;
    Timer4: TTimer;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    PW_VOLT_EDIT: TAlignEdit;
    RPM_HI_EDIT: TAlignEdit;
    AMP_HI_EDIT: TAlignEdit;
    AMP_LO_EDIT: TAlignEdit;
    RPM_LO_EDIT: TAlignEdit;
    power_time_EDIT: TAlignEdit;
    ch1: TCheckBox;
    GroupBox4: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label40: TLabel;
    PUNCT_VOLT_edit: TAlignEdit;
    PUNCT_HI_edit: TAlignEdit;
    insul_LO_edit: TAlignEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    model_load_btn: TLabel;
    model_input_btn: TLabel;
    model_save_btn: TLabel;
    model_exit: TLabel;
    ch3: TCheckBox;
    ch2: TCheckBox;
    Timer3: TTimer;
    Label4: TLabel;
    p_i_time_edit: TAlignEdit;
    Label2: TLabel;
    brake_set_edit: TAlignEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    AMP_HI_EDIT2: TAlignEdit;
    RPM_HI_EDIT2: TAlignEdit;
    AMP_LO_EDIT2: TAlignEdit;
    RPM_LO_EDIT2: TAlignEdit;
    r_test_ch: TCheckBox;
    Label19: TLabel;
    power_time_EDIT2: TAlignEdit;
    Label20: TLabel;
    brake_set_edit2: TAlignEdit;
    Label8: TLabel;
    cw_ch: TRadioButton;
    ccw_ch: TRadioButton;
    procedure setup_exitClick(Sender: TObject);
    procedure model_input_btnClick(Sender: TObject);
    procedure model_edit_btnClick(Sender: TObject);
    procedure model_save_btnClick(Sender: TObject);
    procedure model_load_btnClick(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure AMP_HI_EDITEnter(Sender: TObject);
    procedure AMP_HI_EDITClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  setupf: Tsetupf;
  inputstring, judge_, test_skip, rotate_mode: string;
  NEW_MODE, edit_mode: integer;

implementation
//
uses main, datamodule, m_f, model, khj_lib_dj, mk_plc_dj;
//
{$R *.DFM}

procedure Tsetupf.setup_exitClick(Sender: TObject);
begin
  model_input_btn.Color := clsilver;
  model_save_btn.show;
  model_input_btn.Show;
  edit_mode := 0;
  close;
  ready_go;
  mainf.Show;
end;

procedure Tsetupf.model_input_btnClick(Sender: TObject);
begin
  new_mode := 1;
  edit_mode := 0;
  model_input_btn.Color := clLIME;
end;

procedure Tsetupf.model_edit_btnClick(Sender: TObject);
begin
  new_mode := 0;
  edit_mode := 1;
end;

procedure Tsetupf.model_save_btnClick(Sender: TObject);
var
  i: integer;
begin
  model_input_btn.Color := clsilver;
  test_skip := '';
  rotate_mode := '';
  r_mode := 0;
  model_ := model_edit_text.Text;
  for i := 1 to 3 do
  begin
    if (Findcomponent('ch' + Inttostr(i)) as Tcheckbox).Checked = true then test_skip := test_skip + '1';
    if (Findcomponent('ch' + Inttostr(i)) as Tcheckbox).Checked = false then test_skip := test_skip + '0';
  end;
  if cw_ch.checked then rotate_mode := 'CW';
  if ccw_ch.checked then rotate_mode := 'CCW';
  if r_test_ch.checked then r_mode := 1;
  try
    if new_mode = 0 then
    begin
      if (edit_mode = 1) and (model_edit_text.text <> '') then
      begin
        with datamodulef.Mmodel do
        begin
          edit;
          FieldByName('R_MODE').asINTEGER := r_mode;
          FieldByName('AMP_HI').asFLOAT := STRTOcurr(AMP_HI_edit.text);
          FieldByName('AMP_LO').asFLOAT := STRTOcurr(AMP_LO_edit.text);
          FieldByName('RPM_HI').asINTEGER := STRTOINTDEF(RPM_HI_edit.text, 0);
          FieldByName('RPM_LO').asINTEGER := STRTOINTDEF(RPM_LO_edit.text, 0);
          FieldByName('AMP_HI2').asFLOAT := STRTOcurr(AMP_HI_edit2.text);
          FieldByName('AMP_LO2').asFLOAT := STRTOcurr(AMP_LO_edit2.text);
          FieldByName('RPM_HI2').asINTEGER := STRTOINTDEF(RPM_HI_edit2.text, 0);
          FieldByName('RPM_LO2').asINTEGER := STRTOINTDEF(RPM_LO_edit2.text, 0);
          FieldByName('ROTATION').asstring := rotate_mode;
          FieldByName('P_VOLT').asFLOAT := STRTOcurr(PUNCT_VOLT_edit.text);
          FieldByName('P_AMP_HI').asFLOAT := STRTOcurr(PUNCT_HI_edit.text);
          FieldByName('INSUL_LO').asINTEGER := STRTOINT(INSUL_lo_edit.text);
          FieldByName('PW_VOLT').asFLOAT := STRTOcurr(PW_VOLT_edit.text);
          FieldByName('PW_TIME').asFLOAT := STRTOcurr(POWER_TIME_EDIT.text);
          FieldByName('PW_TIME2').asFLOAT := STRTOcurr(POWER_TIME_EDIT2.text);
          FieldByName('BRAKE').asINTEGER := STRTOINTDEF(brake_set_edit.text, 0);
          FieldByName('BRAKE2').asINTEGER := STRTOINTDEF(brake_set_edit2.text, 0);
          FieldByName('INSUL_TIME').asFLOAT := STRTOcurr(P_i_TIME_EDIT.text);
          FieldByName('PUNCT_TIME').asFLOAT := STRTOcurr(P_i_TIME_EDIT.text);
          FieldByName('TEST_SKIP').asstring := test_skip;
          POST;
        end;
        mainf.m_f_time.Enabled := true;
        form1.Panel1.Caption := '- S A V E -';
      end;
    end;
  except
    showmessage('저장실패!!');
  end;
  edit_mode := 0;
  if new_mode = 1 then timer4.enabled := true;
end;

procedure Tsetupf.model_load_btnClick(Sender: TObject);
var
  i: integer;
begin
  modelf.Show;
  new_mode := 0;
  edit_mode := 0;
  model_input_btn.Color := clsilver;
end;

procedure Tsetupf.Timer3Timer(Sender: TObject);
var
i:integer;
begin
  timer3.Enabled := false;
  with datamodulef.mmodel do
  begin
    model_ := FieldByName('MODEL').asstring;
    r_mode := FieldByName('R_MODE').asINTEGER;
    AMP_HI_edit.text := roundto(FieldByName('AMP_HI').asFLOAT, 2);
    AMP_LO_edit.text := roundto(FieldByName('AMP_LO').asFLOAT, 2);
    RPM_HI_edit.text := inttostr(FieldByName('RPM_HI').asINTEGER);
    RPM_LO_edit.text := inttostr(FieldByName('RPM_LO').asINTEGER);
    AMP_HI_edit2.text := roundto(FieldByName('AMP_HI2').asFLOAT, 2);
    AMP_LO_edit2.text := roundto(FieldByName('AMP_LO2').asFLOAT, 2);
    RPM_HI_edit2.text := inttostr(FieldByName('RPM_HI2').asINTEGER);
    RPM_LO_edit2.text := inttostr(FieldByName('RPM_LO2').asINTEGER);
    rotate_mode := FieldByName('ROTATION').asstring;
    PUNCT_VOLT_edit.text := roundto(FieldByName('P_VOLT').asFLOAT, 2);
    PUNCT_HI_edit.text := roundto(FieldByName('P_AMP_HI').asFLOAT, 1);
    INSUL_lo_edit.text := inttostr(FieldByName('INSUL_LO').asINTEGER);
    PW_VOLT_edit.text := roundto(FieldByName('PW_VOLT').asFLOAT, 2);
    POWER_TIME_EDIT.text := roundto(FieldByName('PW_TIME').asFLOAT, 1);
    POWER_TIME_EDIT2.text := roundto(FieldByName('PW_TIME2').asFLOAT, 1);
    brake_set_edit.text := inttostr(FieldByName('BRAKE').asINTEGER);
    brake_set_edit2.text := inttostr(FieldByName('BRAKE2').asINTEGER);
    P_i_TIME_EDIT.text := roundto(FieldByName('INSUL_TIME').asFLOAT, 1);
    test_skip := FieldByName('TEST_SKIP').asstring;
  end;
  if rotate_mode = 'CW' then cw_ch.Checked := true;
  if rotate_mode = 'CCW' then ccw_ch.Checked := true;
  if r_mode = 1 then r_test_ch.Checked := true;
  if r_mode = 0 then r_test_ch.Checked := false;
  model_edit_text.Text := model_;
  for i := 1 to 3 do
  begin
    if copy(test_skip, i, 1) = '1' then (Findcomponent('ch' + Inttostr(i)) as Tcheckbox).Checked := true;
    if copy(test_skip, i, 1) = '0' then (Findcomponent('ch' + Inttostr(i)) as Tcheckbox).Checked := false;
  end;
  new_mode := 0;
  if model_load = 1 then
  begin
    mainf.Show;
  end;
end;

procedure Tsetupf.Timer4Timer(Sender: TObject);
var
  test_folder: string;
  inputmodel_: integer;
begin
  timer4.Enabled := false;
  inputmodel_ := 0;
  model_ := model_edit_text.text;
  test_folder := 'C:\fan_motor_tester\test_data\' + model_;
  try
    if (model_edit_text.text <> '') then
    begin
      if datamodulef.mmodel.Locate('MODEL', model_edit_text.text, []) then
      begin
        showmessage('이미 등록된 모델 입니다');
        inputmodel_ := 1;
      end;
      if inputmodel_ = 0 then
      begin
      //model input*******************************************************
        with datamodulef.Mmodel do
        begin
          if not active then OPEN;
          Append;
          FieldByName('MODEL').asstring := model_;
          FieldByName('R_MODE').asINTEGER := r_mode;
          FieldByName('AMP_HI').asFLOAT := STRTOcurr(AMP_HI_edit.text);
          FieldByName('AMP_LO').asFLOAT := STRTOcurr(AMP_LO_edit.text);
          FieldByName('RPM_HI').asINTEGER := STRTOINTDEF(RPM_HI_edit.text, 0);
          FieldByName('RPM_LO').asINTEGER := STRTOINTDEF(RPM_LO_edit.text, 0);
          FieldByName('AMP_HI2').asFLOAT := STRTOcurr(AMP_HI_edit2.text);
          FieldByName('AMP_LO2').asFLOAT := STRTOcurr(AMP_LO_edit2.text);
          FieldByName('RPM_HI2').asINTEGER := STRTOINTDEF(RPM_HI_edit2.text, 0);
          FieldByName('RPM_LO2').asINTEGER := STRTOINTDEF(RPM_LO_edit2.text, 0);
          FieldByName('ROTATION').asstring := rotate_mode;
          FieldByName('P_VOLT').asFLOAT := STRTOcurr(PUNCT_VOLT_edit.text);
          FieldByName('P_AMP_HI').asFLOAT := STRTOcurr(PUNCT_HI_edit.text);
          FieldByName('INSUL_LO').asINTEGER := STRTOINT(INSUL_lo_edit.text);
          FieldByName('PW_VOLT').asFLOAT := STRTOcurr(PW_VOLT_edit.text);
          FieldByName('PW_TIME').asFLOAT := STRTOcurr(POWER_TIME_EDIT.text);
          FieldByName('PW_TIME2').asFLOAT := STRTOcurr(POWER_TIME_EDIT2.text);
          FieldByName('BRAKE').asINTEGER := STRTOINTDEF(brake_set_edit.text, 0);
          FieldByName('BRAKE2').asINTEGER := STRTOINTDEF(brake_set_edit2.text, 0);
          FieldByName('INSUL_TIME').asFLOAT := STRTOcurr(P_i_TIME_EDIT.text);
          FieldByName('PUNCT_TIME').asFLOAT := STRTOcurr(P_i_TIME_EDIT.text);
          FieldByName('TEST_SKIP').asstring := test_skip;
          POST;
        end;
        if not DirectoryExists(test_folder) then
          if not CreateDir(test_folder) then
            raise Exception.Create('Cannot create' + '' + test_folder);
        sleep(10);
        mainf.m_f_time.Enabled := true;
        form1.Panel1.Caption := '- S A V E -';
      end;
    end;
  except
    showmessage('저장실패!!');
  end;
end;

procedure Tsetupf.AMP_HI_EDITEnter(Sender: TObject);
begin
  if new_mode = 0 then edit_mode := 1;
end;

procedure Tsetupf.AMP_HI_EDITClick(Sender: TObject);
begin
  if new_mode = 0 then edit_mode := 1;
end;

end.

