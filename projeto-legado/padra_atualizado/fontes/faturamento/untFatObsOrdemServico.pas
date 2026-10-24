unit untFatObsOrdemServico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, MemoFocus, BitBtnLockedIncrem;

type
  TfrmFatObsOrdemServico = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    btnFechar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    memObserv: TMemoFocus;
    procedure btnSairClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strCodCli: String;
    strCodEmp: String;
    strNumOse: String;
    blnAceTot: Boolean;
  end;

var
  frmFatObsOrdemServico: TfrmFatObsOrdemServico;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatObsOrdemServico.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatObsOrdemServico.btnAlterarClick(Sender: TObject);
Var
  strSQL : String;
  qryGen : TUniQuery;
  strObs : String;
begin
  inherited;

  If copy(btnAlterar.Caption, 3,2) = 'F2' Then
  Begin
    btnAlterar.Caption := '[ F10 ] Salvar';
    memObserv.ReadOnly := False;
    pSetFocus(memObserv);
  End
  Else
  Begin

    Try

      strObs := memObserv.Text;

      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   EQUGER ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   EQU_OBSERV = :OBSERV ';
      strSQL := strSQL + ' WHERE EQU_CODEMP = :CODEMP ';
      strSQL := strSQL + ' AND EQU_NUMOSE = :NUMOSE ';
      strSQL := strSQL + ' AND EQU_CODCLI = :CODCLI ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('NUMOSE').AsString := strNumOse;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('OBSERV').AsString := strObs;
        ExecSQL;
      End;

      memObserv.Texto := strObs;
      memObserv.ReadOnly := True;

      btnAlterar.Caption := '[ F2 ] Alterar';

      fMensagem('AVISO!', 'Alteração efetuada com sucesso!', ['&O k']);
    Finally
      FreeAndNil(qryGen);
    End;

  End;

end;

procedure TfrmFatObsOrdemServico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : btnFechar.Click;
    VK_F2, VK_F10 : btnAlterar.Click;
  End;

end;

procedure TfrmFatObsOrdemServico.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(memObserv);
end;

end.
