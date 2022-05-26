program fan_motor_tester;

uses
  Forms,
  main in 'main.pas' {MAINF},
  setup in 'setup.pas' {setupf},
  datamodule in 'datamodule.pas' {datamodulef: TDataModule},
  m_f in 'm_f.pas' {Form1},
  data_list in 'data_list.pas' {data_listf},
  model in 'model.pas' {modelf},
  khj_lib_dj in 'khj_lib_dj.pas',
  mk_plc_dj in 'mk_plc_dj.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tdatamodulef, datamodulef);
  Application.CreateForm(TMAINF, MAINF);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tsetupf, setupf);
  Application.CreateForm(Tdata_listf, data_listf);
  Application.CreateForm(Tmodelf, modelf);
  Application.Run;
end.
