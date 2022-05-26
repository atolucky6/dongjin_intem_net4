unit model;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids;

type
  Tmodelf = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    model_find_edit: TEdit;
    find_btn: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure find_btnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  modelf: Tmodelf;

implementation
//
uses main, setup, datamodule;
{$R *.DFM}

procedure Tmodelf.Button2Click(Sender: TObject);
begin
  close;
  if model_load = 0 then
  begin setupf.show;
    setupf.Timer3.Enabled := true;
  end;
  if model_load = 1 then ready_go;
     model_load := 0;    
end;

procedure Tmodelf.Button1Click(Sender: TObject);
var
  master_model_text: string;
begin
  if MessageDlg('          A Model Delete...?                 ', mtInformation, [mbYes, mbNo], 0) = mryes then
  begin
    master_model_text := datamodulef.mmodel.fieldbyname('MODEL').asstring;
    datamodulef.mmodel.Delete;
  end;
end;

procedure Tmodelf.find_btnClick(Sender: TObject);
begin
  if not datamodulef.mmodel.Locate('MODEL', model_find_edit.text, []) then showmessage('¸ðµ¨ÀÌ ¾øÀ¾´Ï´Ù!!');
end;

end.

