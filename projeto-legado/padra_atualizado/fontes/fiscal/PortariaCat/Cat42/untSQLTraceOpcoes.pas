unit untSQLTraceOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, untTSQLTrace, BitBtnLockedIncrem,
  untITSQLTrace;

type
  TfrmSQLTraceOpcoes = class(TForm)
    pnlFundo: TPanel;
    ckCabecalho: TCheckBox;
    rbSimples: TRadioButton;
    rbCompleto: TRadioButton;
    rbPerformance: TRadioButton;
    ckCallStack: TCheckBox;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    class procedure pSQLTraceOpcoes(Out TipoTrace: TTipoTrace; Out blnCabecalho, blnCallStack: Boolean);
  end;

var
  frmSQLTraceOpcoes: TfrmSQLTraceOpcoes;

implementation

uses untFuncoes;

{$R *.dfm}

{ TfrmSQLTraceOpcoes }

procedure TfrmSQLTraceOpcoes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_Return Then
    SelectNext(ActiveControl, True, True);
end;

class procedure TfrmSQLTraceOpcoes.pSQLTraceOpcoes(out TipoTrace: TTipoTrace; out blnCabecalho, blnCallStack: Boolean);
begin
  pCriarFormularios(TfrmSQLTraceOpcoes, frmSQLTraceOpcoes);

  Try
    frmSQLTraceOpcoes.ShowModal;

    If frmSQLTraceOpcoes.rbSimples.Checked Then
      TipoTrace := ttSimples

    Else If frmSQLTraceOpcoes.rbCompleto.Checked Then
      TipoTrace := ttCompleto

    Else
      TipoTrace := ttPerformance;

    blnCabecalho := frmSQLTraceOpcoes.ckCabecalho.Checked;
    blnCallStack := frmSQLTraceOpcoes.ckCallStack.Checked;
  Finally
    pFreeAndNil(frmSQLTraceOpcoes);
  End;
end;

end.
