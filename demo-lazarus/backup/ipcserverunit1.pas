unit ipcserverunit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, simpleipc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls,
  dynsimpleipcwrap;

type

  { TForm1 }

  TForm1 = class(TForm)
    ApplicationProperties1: TApplicationProperties;
    bCreateTestIpcServer: TButton;
    bRunIpc: TButton;
    bFreeIpcServer: TButton;
    bRunNonThreaded: TButton;
    Memo1: TMemo;
    procedure ApplicationProperties1Idle(Sender: TObject; var Done: Boolean);
    procedure bCreateTestIpcServerClick(Sender: TObject);
    procedure bFreeIpcServerClick(Sender: TObject);
    procedure bRunNonThreadedClick(Sender: TObject);
    procedure bRunIpcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure MemoStatusLn(s: string);
begin
  form1.memo1.Lines.add(s);
end;

procedure MemoStatusLn(s: string; i: integer);
begin
  form1.memo1.Lines.add(s + inttostr(i));
end;

procedure TForm1.bCreateTestIpcServerClick(Sender: TObject);
begin
  //sIpcCreateServerTest;
end;

// callback dll uses when there is a string message
procedure PrintMsg(p: pansichar); cdecl;
var s: string;
begin
  s:= string(p);
  form1.Memo1.lines.add('Msg recvd: '+ s);
end;

procedure TForm1.ApplicationProperties1Idle(Sender: TObject; var Done: Boolean);
begin
  // sIpcExecOnString(10,10,@PrintMsg);
  sIpcExecOnMsg(10,10,@PrintMsg,nil,nil,nil,nil);
end;

procedure TForm1.bFreeIpcServerClick(Sender: TObject);
var err: integer;
begin
  err := sIpcFreeServer;
  if err > 0 then MemoStatusLn('An error occured when freeing IPC server: ', err)
end;

procedure TForm1.bRunNonThreadedClick(Sender: TObject);
var err: integer;
begin
  // err := sIpcCreateServer('123', 0);
  err := sIpcCreateServer;
  if err > 0 then MemoStatusLn('An error occured when creating IPC server: ', err);
end;

procedure TForm1.bRunIpcClick(Sender: TObject);
var err: integer;
begin
  err := sIpcStartServer('123', OPT_NO_THREAD);
  if err > 0 then MemoStatusLn('An error occured when starting IPC server: ', err);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

