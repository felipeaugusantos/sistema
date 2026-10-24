unit untBloquearTela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  untConstantes, StrUtils, untTypesSistema, Vcl.WinXCtrls;

type
  TfrmBloquearTela = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    intPrimeira: Integer;

    pExecutarOperacao: procedure of object;
  public
    { Public declarations }
    blnConfirma: Boolean;

    class function fExecutarOperacao(const prcGen: TGenericProcedure): boolean; static;
  end;

implementation

{$R *.dfm}

procedure TfrmBloquearTela.FormCreate(Sender: TObject);
begin
  blnFecharForm := False;
  blnConfirma   := False;
  intPrimeira   := -1;

  pExecutarOperacao := Nil;
end;

class function TfrmBloquearTela.fExecutarOperacao(const prcGen: TGenericProcedure): Boolean;
  Var
    frmBloquearTela: TfrmBloquearTela;
begin
  Try
    frmBloquearTela := TfrmBloquearTela.Create(nil);
    frmBloquearTela.pExecutarOperacao := prcGen;
    frmBloquearTela.ShowModal;
    Result := frmBloquearTela.blnConfirma;
  Finally
    If Assigned(frmBloquearTela) Then
      FreeAndNil(frmBloquearTela);
  End;
end;

procedure TfrmBloquearTela.FormActivate(Sender: TObject);
begin

  If InterlockedIncrement(intPrimeira) > 0 Then
    Exit;

  Try
    Try
      Application.ProcessMessages;

      If Assigned(pExecutarOperacao) Then
        pExecutarOperacao;

      blnConfirma := True;
    Except
      On E: ExceptionAutCom Do
      Begin
        blnConfirma := False;
        Raise ExceptionAutCom.Create(E.Message);
      End;

      On E: Exception Do
      Begin
        blnConfirma := False;
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    blnFecharForm := True;
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  End;

end;

procedure TfrmBloquearTela.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If Not blnFecharForm Then
    Action := caNone;

end;

end.
