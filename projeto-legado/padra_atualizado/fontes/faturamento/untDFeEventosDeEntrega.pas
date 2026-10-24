unit untDFeEventosDeEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, EditFocus, Vcl.Mask, MaskEditFocus, frxClass,
  frxExportCSVTestabilidade, Uni, untFuncoes, ComboBoxFocus;

type
  TfrmDFeEventosDeEntrega = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    FileOpenImagem: TFileOpenDialog;
    pnlConfirmacao: TPanel;
    lblDocRecebedor: TLabel;
    edtDocRecebedor: TEditFocus;
    lblNomRecebedor: TLabel;
    edtNomRecebedor: TEditFocus;
    pnlInsucesso: TPanel;
    Label3: TLabel;
    cboMotivo: TComboBoxFocus;
    Label1: TLabel;
    edtNroTentativas: TEditFocus;
    Label4: TLabel;
    edtJustificativa: TEditFocus;
    pnlCanhoto: TPanel;
    lblLatitude: TLabel;
    lblLongitude: TLabel;
    lblDtaCanhoto: TLabel;
    lblHashCanhoto: TLabel;
    edtLatitude: TEditFocus;
    edtLongitude: TEditFocus;
    mskDtaCanhoto: TMaskEditFocus;
    mskHraCanhoto: TMaskEditFocus;
    edtHashCanhoto: TEditFocus;
    btnAdicionarCanhoto: TBitBtnLocked;
    procedure btnAdicionarCanhotoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskHraCanhotoExit(Sender: TObject);
    procedure mskDtaCanhotoExit(Sender: TObject);
  private
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSerie_: String;
    FAcesso: String;
    FNFeDoCTe: String;
    FEventoMensagem: String;
    FEventoOK: Boolean;
    function fDataHora(const Adata: TDateTime): String;
    function fRetornaNFeDoCTe(const ACTeAcesso: String): String;
    procedure pEnviaEvento;
    function fConfimaEvento: Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    TipoEvento : TTipoEventoEntrega;
    property strAcesso : String Read FAcesso Write FAcesso;
    property strNumDoc : String Read FNumDoc Write FNumDoc;
    property strEspDoc : String Read FEspDoc Write FEspDoc;
    property strCodEmp : String Read FCodEmp Write FCodEmp;
    property strSerie_ : String Read FSerie_ Write FSerie_;
    { Public declarations }
  end;

var
  frmDFeEventosDeEntrega: TfrmDFeEventosDeEntrega;

implementation

{$R *.dfm}

uses untGravando, untFuncoesSimples, untLibNfe;

procedure TfrmDFeEventosDeEntrega.FormShow(Sender: TObject);
begin
  inherited;

  pnlInsucesso.Visible   := True;
  pnlConfirmacao.Visible := True;

  If TipoEvento in [NFeInsucessoEntrega, CTeInsucessoEntrega] Then
  Begin
    pnlConfirmacao.Visible := False;
    pSetFocus(cboMotivo);
  End;

  If TipoEvento in [NFeConfirmacaoEntrega, CTeConfirmacaoEntrega] Then
  Begin
    pnlInsucesso.Visible := False;
    pSetFocus(edtDocRecebedor);
  End;

  Self.Height := Self.Height - 36;
end;

function TfrmDFeEventosDeEntrega.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  LDtaCanhoto: TDateTime;
  LHraCanhoto: TDateTime;
begin
  Result := True;

  If TipoEvento in [NFeCancelamentoConfirmacaoEntrega, NFeCancelamentoInsucessoEntrega,
                    CTeCancelamentoConfirmacaoEntrega, CTeCancelamentoInsucessoEntrega] Then
    Exit;

  Try
    Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

    If Result Then
    Begin
      If (Sender = edtDocRecebedor) Or (not blnBuscaPorChave) Then
      Begin
        If fEmptyStr(edtDocRecebedor.Text) And pnlConfirmacao.Visible Then
        Begin
          pMensagemOk('Informe o documento do recebedor!');
          Result := False;
          Exit;
        End;
      End;

      If (Sender = edtNomRecebedor) Or (not blnBuscaPorChave) Then
      Begin
        If fEmptyStr(edtNomRecebedor.Text) And pnlConfirmacao.Visible Then
        Begin
          pMensagemOk('Informe o nome do recebedor!');
          Result := False;
          Exit;
        End;
      End;

      If (Sender = cboMotivo) Or (not blnBuscaPorChave) Then
      Begin
        If fEmptyStr(cboMotivo.Text) And pnlInsucesso.Visible Then
        Begin
          pMensagemOk('Informe o motivo do insucesso!');
          Result := False;
          Exit;
        End;
      End;

      If (Sender = mskDtaCanhoto) Or (not blnBuscaPorChave) Then
      Begin
        If not TryStrToDate(mskDtaCanhoto.Text, LDtaCanhoto) Then
        Begin
          pMensagemOk('Data do canhoto inválida!');
          Result := False;
          Exit;
        End;
      End;

      If (Sender = mskHraCanhoto) Or (not blnBuscaPorChave) Then
      Begin
        If not TryStrToTime(mskHraCanhoto.Text, LHraCanhoto) Then
        Begin
          pMensagemOk('Hora do canhoto inválida!');
          Result := False;
          Exit;
        End;
      End;

      If (not blnBuscaPorChave) And fEmptyStr(edtHashCanhoto.Text) Then
      Begin
        pMensagemOk('Informe a foto do canhoto!');
        Result := False;
        Exit;
      End;

      If (Sender = edtJustificativa) Or (not blnBuscaPorChave) Then
      Begin
        If not fEmptyStr(edtJustificativa.Text) And pnlInsucesso.Visible Then
        Begin
          If Length(edtJustificativa.Text) < 25 Then
          Begin
            pMensagemOk('O campo justificativa exige o preenchimento mínimo de 25 caracteres.');
            Result := False;
            Exit;
          End;
        End;
      End;

    End;

  Finally
    If Not Result Then
      pSetFocus(Sender);
  End;
end;

procedure TfrmDFeEventosDeEntrega.mskDtaCanhotoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(mskDtaCanhoto, True);
end;

procedure TfrmDFeEventosDeEntrega.mskHraCanhotoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(mskHraCanhoto, True);
end;

function TfrmDFeEventosDeEntrega.fDataHora(const Adata: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyyhhnnss', Adata);
end;

function TfrmDFeEventosDeEntrega.fRetornaNFeDoCTe(const ACTeAcesso: String): String;
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT FIS_ACESSO FROM MOVCTE');
    qryAux.SQL.Add('INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVCTE.CTE_SEQGER');
    qryAux.SQL.Add('INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVGER.GER_NUMDOC');
    qryAux.SQL.Add('                 AND CADFIS.FIS_ESPDOC = MOVGER.GER_ESPDOC');
    qryAux.SQL.Add('                 AND CADFIS.FIS_SERIE_ = MOVGER.GER_SERIE_');
    qryAux.SQL.Add('                 AND CADFIS.FIS_CODEMP = MOVGER.GER_CODEMP');
    qryAux.SQL.Add('                 AND CADFIS.FIS_FORCLI = MOVGER.GER_CODCLI');
    qryAux.SQL.Add('WHERE CTE_ACESSO = :ACESSO');
    qryAux.SQL.Add('UNION ALL ' + AnsiReplaceStr(qryAux.SQL.Text, 'MOVGER', 'NOTGER'));
    qryAux.ParamByName('ACESSO').AsString := ACTeAcesso;
    qryAux.Open;

    Result := qryAux.FieldByName('FIS_ACESSO').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmDFeEventosDeEntrega.btnAdicionarCanhotoClick(Sender: TObject);
var
  LResult: Boolean;
begin
  edtHashCanhoto.Clear;

  LResult := FileOpenImagem.Execute ;

  If LResult Then
    edtHashCanhoto.Text := fGerarHashEntrega(Self.strAcesso, FileOpenImagem.FileName);
end;

procedure TfrmDFeEventosDeEntrega.pEnviaEvento;
var
  LDocRecebedor: String;
  LNomRecebedor: String;
  LMotivo: String;
  LJustificativa: String;
  LLatitude: String;
  LLongitude: String;
  LHashCanhoto: String;
  LHashData: String;
begin
  If not (TipoEvento in [NFeCancelamentoConfirmacaoEntrega, NFeCancelamentoInsucessoEntrega,
                         CTeCancelamentoConfirmacaoEntrega, CTeCancelamentoInsucessoEntrega]) Then
  Begin
    LDocRecebedor  := edtDocRecebedor.text;
    LNomRecebedor  := edtNomRecebedor.text;
    LMotivo        := IntToStr((cboMotivo.ItemIndex + 1));
    LJustificativa := edtJustificativa.text;
    LLatitude      := edtLatitude.text;
    LLongitude     := edtLongitude.text;
    LHashCanhoto   := edtHashCanhoto.text;
    LHashData      := fDataHora(StrToDateTime(mskDtaCanhoto.Text) + StrToDateTime(mskHraCanhoto.Text));
  End;

  Case TipoEvento Of
                 NFeConfirmacaoEntrega: FEventoOK := fConfirmacaoDeEntregaNFe(Self.strNumDoc, Self.strEspDoc, Self.strCodEmp, Self.strSerie_, LDocRecebedor, LNomRecebedor, LLatitude, LLongitude, LHashCanhoto, LHashData, FEventoMensagem);
     NFeCancelamentoConfirmacaoEntrega: FEventoOK := fCancelamentoConfirmacaoDeEntregaNFe(Self.strNumDoc, Self.strEspDoc, Self.strCodEmp, Self.strSerie_, FEventoMensagem);
                   NFeInsucessoEntrega: FEventoOK := fInsucessoNaEntregaNFe(Self.strNumDoc, Self.strEspDoc, Self.strCodEmp, Self.strSerie_, LMotivo, LJustificativa, LHashCanhoto, LHashData, FEventoMensagem);
       NFeCancelamentoInsucessoEntrega: FEventoOK := fCancelamentoInsucessoNaEntregaNFe(Self.strNumDoc, Self.strEspDoc, Self.strCodEmp, Self.strSerie_, FEventoMensagem);
                 CTeConfirmacaoEntrega: FEventoOK := fConfirmacaoDeEntregaConhecimento(Self.strNumDoc, FNFeDoCTe, LDocRecebedor, LNomRecebedor, LHashCanhoto, LHashData, FEventoMensagem);
     CTeCancelamentoConfirmacaoEntrega: FEventoOK := fCancelamentoConfirmacaoDeEntregaConhecimento(Self.strNumDoc, FEventoMensagem);
                   CTeInsucessoEntrega: FEventoOK := fInsucessoNaEntregaConhecimento(Self.strNumDoc, FNFeDoCTe, LMotivo, LJustificativa, LHashCanhoto, LHashData, FEventoMensagem);
       CTeCancelamentoInsucessoEntrega: FEventoOK := fCancelamentoInsucessoNaEntregaConhecimento(Self.strNumDoc, FEventoMensagem);
  End;
end;

function TfrmDFeEventosDeEntrega.fConfimaEvento: Boolean;
begin
  TfrmGravando.fExecutarModalA(pEnviaEvento, 'Enviando evento . . .', '');

  Result := FEventoOK;

  fMensagem('', IIF(fEmptyStr(FEventoMensagem),'Ocorreu um erro no processamento do evento!', FEventoMensagem), ['&Ok']);
end;

procedure TfrmDFeEventosDeEntrega.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If not fValidaCampos(Self, False) Then
    Exit;

  If TipoEvento in [CTeConfirmacaoEntrega, CTeInsucessoEntrega] Then
  Begin
    FNFeDoCTe := fRetornaNFeDoCTe(Self.strAcesso) ;

    If fEmptyStr(FNFeDoCTe) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi possível encontrar a nota fiscal do CTe!', ['&Ok']);
      Exit;
    End;
  End;

  If fConfimaEvento Then
    btnSair.Click;
end;

end.
