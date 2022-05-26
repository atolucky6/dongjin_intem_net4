unit data_list;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Grids, DBGrids, Db,
  DBTables, ComCtrls, AlignEdit, Mask; // RbDrawCore, RbPanel, GradBtn,

type
  Tdata_listf = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    datalist_gride: TDBGrid;
    test_model_box: TDBLookupComboBox;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    total_no_: TAlignEdit;
    ok_no: TAlignEdit;
    ng_no: TAlignEdit;
    datalist_exit: TButton;
    Label6: TLabel;
    datalist_post: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure datalist_exitClick(Sender: TObject);
    procedure datalist_postClick(Sender: TObject);
    procedure test_model_boxCloseUp(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure datalist_grideDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  data_listf: Tdata_listf;

implementation
uses main, datamodule, m_f;

{$R *.DFM}

procedure Tdata_listf.datalist_exitClick(Sender: TObject);
begin
  close;
  total_no_.Text := '0';
  ok_no.Text := '0';
  ng_no.Text := '0';
  combobox1.Text := '';
  table1.Active := false;
  table1.Close;
  ready_go;
  mainf.Show;
end;

procedure Tdata_listf.datalist_postClick(Sender: TObject);
var
  a, b, c: string;
  i, x, y, z: integer;
begin
  x := 0;
  y := 0;
  z := 0;
  datasource1.Enabled := false;
  total_no_.Text := '0';
  ok_no.Text := '0';
  ng_no.Text := '0';
  try
    if (edit1.text <> '') and (edit2.Text <> '') then
    begin
      table1.Active := false;
      table1.DatabaseName := 'C:\FAN_MOTOR_TESTER\TEST_DATA\' + edit2.Text;
      table1.TableName := edit1.text;
      table1.Active := true;
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

procedure Tdata_listf.test_model_boxCloseUp(Sender: TObject);
var
  sr: TSearchRec;
  i: integer;
  s, drf: string;
begin
  i := 0;
  combobox1.items.Clear;
  drf := 'C:\FAN_MOTOR_TESTER\TEST_DATA\' + test_model_box.text + '\*.*';
  if FindFirst(drf, faAnyFile, sr) = 0 then
  begin
    with combobox1 do
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
    combobox1.Enabled := true;
    edit2.Text := test_model_box.Text;
//  combobox1.Itemindex:=1;
  end;
  if i <= 1 then
  begin
    combobox1.items.Clear;
    combobox1.Enabled := false;
//  combobox1.Itemindex:=1;
  end;
end;

procedure Tdata_listf.ComboBox1Click(Sender: TObject);
begin
  if edit1.text <> '' then datalist_post.Enabled := true;
  if edit1.text = '' then datalist_post.Enabled := false;
end;

procedure Tdata_listf.datalist_grideDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  gt_r, gt_rl, gt_rh: array[0..12] of single;
  gS1AREA, gS1PHASE, gS2AREA, gS2PHASE, gS3AREA, gS3PHASE, gS4AREA, gS4PHASE: single;
  gS1CORONA, gS2CORONA, gS3CORONA, gs4corona: single;
  gT_S1AREA, gT_S2AREA, gT_S3AREA, gt_s4area, gT_S1PHASE, gT_S2PHASE, gt_s3phase, gt_s4phase: single;
  gT_S1CORONA, gT_S2CORONA, gT_S3CORONA, gt_s4corona: single;
begin
{  if table1.FieldByName('RESULT').Asstring = 'NG' then
  begin
    datalist_gride.Canvas.Font.Color := clred;
    if DataCol = 20 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    gt_r1 := (table1.FieldByName('R1').Asfloat);
    if (gr1L > gt_r1) or (gt_r1 > gr1h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 1 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r2 := (table1.FieldByName('R2').Asfloat);
    if (gr2L > gt_r2) or (gt_r2 > gr2h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 2 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r3 := (table1.FieldByName('R3').Asfloat);
    if (gr3L > gt_r3) or (gt_r3 > gr3h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 3 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r4 := (table1.FieldByName('R4').Asfloat);
    if (gr4L > gt_r4) or (gt_r4 > gr4h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 4 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r5 := (table1.FieldByName('R5').Asfloat);
    if (gr5L > gt_r5) or (gt_r5 > gr5h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 5 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r6 := (table1.FieldByName('R6').Asfloat);
    if (gr6L > gt_r6) or (gt_r6 > gr6h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 6 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r7 := (table1.FieldByName('R7').Asfloat);
    if (gr7L > gt_r7) or (gt_r7 > gr7h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 7 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r8 := (table1.FieldByName('R8').Asfloat);
    if (gr8L > gt_r8) or (gt_r8 > gr8h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 8 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r9 := (table1.FieldByName('R9').Asfloat);
    if (gr9L > gt_r9) or (gt_r9 > gr9h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 9 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r10 := (table1.FieldByName('R10').Asfloat);
    if (gr10L > gt_r10) or (gt_r10 > gr10h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 10 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r11 := (table1.FieldByName('R11').Asfloat);
    if (gr11L > gt_r11) or (gt_r11 > gr11h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 11 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_r12 := (table1.FieldByName('R12').Asfloat);
    if (gr12L > gt_r12) or (gt_r12 > gr12h) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 12 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gs1area := datamodulef.mmodel.FieldByName('s1area').asfloat;
    gt_s1area := table1.FieldByName('s1area').asfloat;
    if (gt_s1area > gs1area) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 13 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gs2area := datamodulef.mmodel.FieldByName('s2area').asfloat;
    gt_s2area := table1.FieldByName('s2area').asfloat;
    if (gt_s1phase > gs1phase) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 5 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s1corona > gs1corona) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 6 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s2area > gs2area) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 7 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s2phase > gs2phase) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 8 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s1corona > gs1corona) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 9 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s3area > gs3area) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 10 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s3phase > gs3phase) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 11 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (gt_s3corona > gs3corona) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 12 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    if (grotate <> gt_rotate) then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 13 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
    gt_punct := table1.FieldByName('punct').Asstring;
    if (gt_punct = 'NG') then
    begin
      datalist_gride.Canvas.Font.Color := clred;
      if DataCol = 14 then datalist_gride.DefaultDrawColumnCell(Rect, datacol, Column, State);
    end;
  end;}
end;

procedure Tdata_listf.ComboBox1Change(Sender: TObject);
begin
  edit1.Text := combobox1.Text;
end;

end.

