unit khj_lib_dj;

interface

uses Windows, SysUtils, Forms, dbtables, bde;

function roundto(X: single; y: integer): string;
function rtestl(X: single; y: single): single;
function rtesth(X: single; y: single): single;
procedure Delay(ms: Integer);

implementation

uses main;

function roundto(X: single; y: integer): string;
var
  decimalpoint, int_x: integer;
  a, frac_x: single;
  g, h: string;
begin
  a := x;
  decimalpoint := y;
  int_x := trunc(int(x));
  frac_x := (frac(a + 0.00001));
  g := currtostr(frac_x);
  if g = '0' then g := '0.000';
  if g <> '0' then g := g + '0000';
  h := copy(g, 2, 1 + decimalpoint);
  result := inttostr(int_x) + h;
end;

procedure Delay(ms: Integer);
var
  h: THandle;
  rm: Integer;
begin
  h := GetCurrentThread;
  if GetCurrentThreadID = MainThreadID then begin
    rm := Integer(GetTickCount) + ms;
    while ms > 0 do begin
      if MsgWaitForMultipleObjects(1, h, False, ms, QS_PAINT or QS_TIMER)
        = WAIT_OBJECT_0 + 1 then Application.ProcessMessages;
      ms := rm - Integer(GetTickCount);
    end;
  end else begin
    WaitForSingleObject(H, ms);
  end;
end;

function rtestl(X: single; y: single): single;
var
  a, b: single;
begin
  a := x;
  b := y;
  result := a - (a * (y / 100));
end;

function rtesth(X: single; y: single): single;
var
  a, b: single;
begin
  a := x;
  b := y;
  result := a + (a * (y / 100));
end;

end.

 