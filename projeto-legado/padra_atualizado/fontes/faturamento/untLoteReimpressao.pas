unit untLoteReimpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmLoteReimpressao = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtNumLot: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fLoteSeparacaoRomaneioExiste(strNumLot : String):Boolean;
  public
    { Public declarations }
  end;


implementation

uses  untfuncoesSimples, untFuncoesGenerica, untConsultas;

{$R *.dfm}

{ TfrmLoteReimpressao }

procedure TfrmLoteReimpressao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmLoteReimpressao.edtNumLotKeyPress(Sender: TObject; var Key: Char);
var
  qryConsulta: TUniQuery;
  arrSel   : TConsultasArray;
begin
  inherited;

  qryConsulta := fCriaQuery(Self);

  try
    If fPesqRomaneioLoteSeparacao(Self, edtNumLot, qryConsulta, Key, arrSel, True ) Then
    Begin
      If (fValidaCampos(edtNumLot, True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function TfrmLoteReimpressao.fLoteSeparacaoRomaneioExiste(
  strNumLot: String): Boolean;
var
  qryDados : TUniQuery;
begin
  qryDados := fCriaQuery(Self);

  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT RLG_NUMLOT');
    qryDados.SQL.Add('FROM ROMLGE');
    qryDados.SQL.Add('WHERE RLG_NUMLOT = :NUMLOT');
    qryDados.SQL.Add('AND RLG_CODEMP = :CODEMP');
    qryDados.ParamByName('NUMLOT').AsString := strNumLot;
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.Open;

    Result := Not qryDados.IsEmpty;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmLoteReimpressao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumLot);
end;

function TfrmLoteReimpressao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumLot) Then
  Begin
    if fEmptyStr(edtNumLot.Text) then
    begin
      fMensagem('Atenção!', 'Informe o lote para a reimpressão!', ['&Ok']);
      Result := False;
    end
    else if (Not fLoteSeparacaoRomaneioExiste(edtNumLot.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'Esse lote de separação para romaneio não está cadastrado!', ['&Ok']);
      Result := False;
    end;
  End;
end;

end.
