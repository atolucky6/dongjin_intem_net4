unit datamodule;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB;

type
  Tdatamodulef = class(TDataModule)
    mmodel: TTable;
    ds_mmodel: TDataSource;
    test_table: TTable;
    new_table: TTable;
    last_table: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  datamodulef: Tdatamodulef;
  data_base_dir: string;

implementation

{$R *.DFM}

end.

