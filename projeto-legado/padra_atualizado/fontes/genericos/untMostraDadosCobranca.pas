unit untMostraDadosCobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls,
  Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, DBEditFocus, QColorLabel, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Uni;

type
  TfrmMostraDadosCobranca = class(TfrmPaiConfirma)
    Panel1: TPanel;
    grbConsulta: TGroupBox;
    ColorLabel17: TColorLabel;
    Label150: TLabel;
    pnlConsulta: TPanel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    dbeDtaCon: TDBEditFocus;
    dbeQrdPro: TDBEditFocus;
    dbeCheDev: TDBEditFocus;
    dbeObsCon: TDBMemoFocus;
    btnAbrirPastaCredito: TBitBtnLocked;
    dbeCodCon: TDBEditFocus;
    dtsDadCob: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAbrirPastaCreditoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryDadCob: TUniQuery;
    FAlterar: Boolean;
    procedure pCarregaDados;
    procedure AtivarAlterar;
  public
    strCodCli: String;
    blnPermiteEditarArquivosDeConsultaDeCredito : Boolean;
    property Alterar: Boolean read FAlterar write FAlterar;
    procedure Gravar;
  end;

var
  frmMostraDadosCobranca: TfrmMostraDadosCobranca;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravaArquivoPasta;

procedure TfrmMostraDadosCobranca.btnAbrirPastaCreditoClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
    frmGravaArquivoPasta.strCaminhoPasta := fPastaConsultaCreditos(strCodCli);
    frmGravaArquivoPasta.blnConsulta     := (Not blnPermiteEditarArquivosDeConsultaDeCredito);
    frmGravaArquivoPasta.Caption         := 'Pasta ( Consulta de Créditos )';
    frmGravaArquivoPasta.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravaArquivoPasta);

end;

procedure TfrmMostraDadosCobranca.FormCreate(Sender: TObject);
begin
  inherited;
  qryDadCob := fCriaQuery(Self);
  FAlterar := False;
  blnPermiteEditarArquivosDeConsultaDeCredito := False;
end;

procedure TfrmMostraDadosCobranca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryDadCob);
end;

procedure TfrmMostraDadosCobranca.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaDados;
end;

procedure TfrmMostraDadosCobranca.Gravar;
begin
  if not FAlterar then
    Exit;

  qryDadCob.Post;
end;

procedure TfrmMostraDadosCobranca.pCarregaDados;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  CLI_CODCLI,          ';
    strSQL := strSQL + '  CLI_CODCON,          ';
    strSQL := strSQL + '  CLI_DTACON,          ';
    strSQL := strSQL + '  CLI_QTDPRO,          ';
    strSQL := strSQL + '  CLI_CHEDEV,          ';
    strSQL := strSQL + '  CLI_OBSCON           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADCLI               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qryDadCob Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      dtsDadCob.DataSet := qryDadCob;
    End;

    if FAlterar then
      AtivarAlterar

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmMostraDadosCobranca.pCarregaDados]');
  End;

end;

procedure TfrmMostraDadosCobranca.AtivarAlterar;
begin
  if not fVerificaAcessoSistema('ALTCCR', strLoginUsuarioLogado) then
    Exit;

  qryDadCob.Edit;

  dbeCodCon.ReadOnly := False;
  dbeDtaCon.ReadOnly := False;
  dbeQrdPro.ReadOnly := False;
  dbeCheDev.ReadOnly := False;
  dbeObsCon.ReadOnly := False;

  qryDadCob.FieldByName('CLI_DTACON').EditMask := '99/99/9999';
  btnConfirma.Visible := True;
end;

end.
