unit untReformaTributariaCreditoDebito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni, Shared.Functions.Types, untFuncFat, untFuncFatTypes, Faturamento.Classes.TFatVendaBase,
  QColorLabel, Vcl.Mask, MaskEditFocus;

type
  TfrmReformaTributariaCreditoDebito = class(TfrmPai)
    btnConfirmar: TBitBtnLocked;
    pnlConsulta: TPanel;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtCreDeb: TEditFocus;
    edtTipFin: TEditFocus;
    lblValor: TLabel;
    edtValor: TEditFocus;
    lblMensagem: TLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    edtMens03: TEditFocus;
    edtMens04: TEditFocus;
    edtMens05: TEditFocus;
    edtTipFinDescr: TEditFocus;
    clbCreditoDebito: TColorLabel;
    edtValCBS: TEditFocus;
    Label5: TLabel;
    edtValIBS: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    mskMesAno: TMaskEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtChaveAcesso: TEditFocus;
    btnCancelar: TBitBtnLocked;
    Label8: TLabel;
    edtBasCal: TEditFocus;
    Label9: TLabel;
    edtAlqCBS: TEditFocus;
    Label11: TLabel;
    edtAlqIBS: TEditFocus;
    Label10: TLabel;
    edtClaFis: TEditFocus;
    edtNatOpe: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTipFinKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtAlqCBSExit(Sender: TObject);
    procedure edtAlqIBSExit(Sender: TObject);
  private
    { Private declarations }
    FCreDeb: String;
    FTipFin: String;
    FCodCst: String;
    FClaTri: String;
    FDocRef: String;
    FMesAno: String;
    FCbsIbs: String;
    FSemaforoConfirma: Integer;
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;
    procedure pLimpaDados(blnCompleto: Boolean = True);
    procedure pHabilitaCampos;
    procedure pAcessoTela(blnHabilitado: Boolean);
    procedure pLimpaDocumentoReferenciado(strCreDeb: String; strTipFin: String);
    procedure pCarregaFinalidadeCreditoOuDebito(strCreDeb: String; strTipFin: String);
    procedure pCalculaIBS;
    procedure pCalculaCBS;
    function fClienteDentroDoEstado: Boolean;
    function fRetornaChaveAcesso(const strNumDoc, strEspDoc, strCodemp, strCodCli, strSerie_: String): String;
    function fValidaChaveAcesso(const strChvAce, strFinNfe, strTipFin: String): Boolean;
    function fGravaArquivos: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmReformaTributariaCreditoDebito: TfrmReformaTributariaCreditoDebito;

implementation

uses
  untFuncoes, untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema;

{$R *.dfm}

function TfrmReformaTributariaCreditoDebito.fRetornaChaveAcesso(const strNumDoc, strEspDoc, strCodemp, strCodCli, strSerie_: String): String;
Var
  qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT FIS_ACESSO FROM CADFIS ');
    qryAux.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND FIS_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND FIS_FORCLI = :CODCLI ');
    qryAux.SQL.Add('  AND FIS_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('  AND FIS_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('  AND IFNULL(FIS_ACESSO, "") <> "" ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie_;
    qryAux.ParamByName('TIP_FC').AsString := 'C';
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe um documento válido!', ['&Ok']);
      Exit;
    End;

    If not fValidaChaveAcesso(qryAux.FieldByName('FIS_ACESSO').AsString, edtCreDeb.Text, edtTipFin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A nota fiscal informada já foi referênciada na operação automática !', ['&Ok']);
      Exit;
    End;

    Result := qryAux.FieldByName('FIS_ACESSO').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmReformaTributariaCreditoDebito.fValidaChaveAcesso(const strChvAce, strFinNfe, strTipFin: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery(Self);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT FIS_ACESSO FROM CADFIS ');
    qryAux.SQL.Add('INNER JOIN NOTGER ON NOTGER.GER_NUMDOC = CADFIS.FIS_NUMDOC ');
    qryAux.SQL.Add('                 AND NOTGER.GER_ESPDOC = CADFIS.FIS_ESPDOC ');
    qryAux.SQL.Add('                 AND NOTGER.GER_CODEMP = CADFIS.FIS_CODEMP ');
    qryAux.SQL.Add('                 AND NOTGER.GER_CODCLI = CADFIS.FIS_FORCLI ');
    qryAux.SQL.Add('                 AND NOTGER.GER_TIP_FC = CADFIS.FIS_TIP_FC ');
    qryAux.SQL.Add('INNER JOIN NOTDET ON NOTDET.DET_SEQGER = NOTGER.AUTOINCREM ');
    qryAux.SQL.Add('INNER JOIN NOTTRI ON NOTTRI.DET_SEQGER = NOTDET.AUTOINCREM ');
    qryAux.SQL.Add('WHERE TRUE ');
    qryAux.SQL.Add('  AND DET_CHVREF = :CHVREF ');
    qryAux.SQL.Add('  AND FIS_FINNFE = :FINNFE ');
    qryAux.SQL.Add('  AND FIS_TIPFIN = :TIPFIN ');
    qryAux.ParamByName('CHVREF').AsString := strChvAce;
    qryAux.ParamByName('FINNFE').AsString := IIF(strFinNfe = 'C', '5', '6');
    qryAux.ParamByName('TIPFIN').AsString := strTipFin;
    qryAux.Open;

    Result := fEmptyStr(qryAux.FieldByName('FIS_ACESSO').AsString);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmReformaTributariaCreditoDebito.fValidaChaveAcesso]');
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmReformaTributariaCreditoDebito.pLimpaDocumentoReferenciado(strCreDeb: String; strTipFin: String);
begin
  If (FCreDeb = strCreDeb) And (FTipFin = strTipFin) Then
    Exit;

  edtNumDoc.Clear;
  edtSerie.Clear;
  edtChaveAcesso.Clear;
end;

procedure TfrmReformaTributariaCreditoDebito.pCarregaFinalidadeCreditoOuDebito(strCreDeb: String; strTipFin: String);
Var
  qryAux: TUniQuery;
begin
  FCreDeb := '';
  FTipFin := '';
  FCodCst := '';
  FClaTri := '';
  FDocRef := '';
  FMesAno := '';
  FCbsIbs := '';

  qryAux := fCriaQuery(Self);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CCD_CODCST, CCD_CLATRI, CCD_DOCREF, CCD_MESANO, CCD_CBSIBS FROM CCDREF ');
    qryAux.SQL.Add('WHERE CCD_CREDEB = :CREDEB ');
    qryAux.SQL.Add('  AND CCD_TIPFIN = :TIPFIN ');
    qryAux.ParamByName('CREDEB').AsString := strCreDeb;
    qryAux.ParamByName('TIPFIN').AsString := strTipFin;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    FCreDeb := strCreDeb;
    FTipFin := strTipFin;
    FCodCst := qryAux.FieldByName('CCD_CODCST').AsString;
    FClaTri := qryAux.FieldByName('CCD_CLATRI').AsString;
    FDocRef := qryAux.FieldByName('CCD_DOCREF').AsString;
    FMesAno := qryAux.FieldByName('CCD_MESANO').AsString;
    FCbsIbs := qryAux.FieldByName('CCD_CBSIBS').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmReformaTributariaCreditoDebito.pHabilitaCampos;
begin
  If not pnlDados.Enabled Then
    Exit;

  edtNumDoc.ReadOnly := True;
  edtSerie.ReadOnly  := True;
  mskMesAno.ReadOnly := True;

  edtBasCal.ReadOnly := True;
  edtAlqCBS.ReadOnly := True;
  edtAlqIBS.ReadOnly := True;
  edtValCBS.ReadOnly := True;
  edtValIBS.ReadOnly := True;

  edtNumDoc.TabStop := False;
  edtSerie.TabStop  := False;
  mskMesAno.TabStop := False;

  edtBasCal.TabStop := False;
  edtAlqCBS.TabStop := False;
  edtAlqIBS.TabStop := False;
  edtValCBS.TabStop := False;
  edtValIBS.TabStop := False;

  edtNumDoc.Color := $00FFDFB8;
  edtSerie.Color  := $00FFDFB8;
  mskMesAno.Color := $00FFDFB8;

  edtBasCal.Color := $00FFDFB8;
  edtAlqCBS.Color := $00FFDFB8;
  edtAlqIBS.Color := $00FFDFB8;
  edtValCBS.Color := $00FFDFB8;
  edtValIBS.Color := $00FFDFB8;

  edtNumDoc.FocusColor := $00FFDFB8;
  edtSerie.FocusColor  := $00FFDFB8;
  mskMesAno.FocusColor := $00FFDFB8;

  edtBasCal.FocusColor := $00FFDFB8;
  edtAlqCBS.FocusColor := $00FFDFB8;
  edtAlqIBS.FocusColor := $00FFDFB8;
  edtValCBS.FocusColor := $00FFDFB8;
  edtValIBS.FocusColor := $00FFDFB8;

  edtNumDoc.NormalColor := $00FFDFB8;
  edtSerie.NormalColor  := $00FFDFB8;
  mskMesAno.NormalColor := $00FFDFB8;

  edtBasCal.NormalColor := $00FFDFB8;
  edtAlqCBS.NormalColor := $00FFDFB8;
  edtAlqIBS.NormalColor := $00FFDFB8;
  edtValCBS.NormalColor := $00FFDFB8;
  edtValIBS.NormalColor := $00FFDFB8;

  If (FMesAno = 'S') Then
  Begin
    mskMesAno.ReadOnly    := False;
    mskMesAno.TabStop     := True;
    mskMesAno.Color       := clWindow;
    mskMesAno.FocusColor  := clInfoBk;
    mskMesAno.NormalColor := clWindow;
  End;

  If (FCbsIbs = 'S') Then
  Begin
    edtBasCal.ReadOnly    := False;
    edtAlqCBS.ReadOnly    := False;
    edtAlqIBS.ReadOnly    := False;
    edtValCBS.ReadOnly    := False;
    edtValIBS.ReadOnly    := False;

    edtBasCal.TabStop     := True;
    edtAlqCBS.TabStop     := True;
    edtAlqIBS.TabStop     := True;
    edtValCBS.TabStop     := True;
    edtValIBS.TabStop     := True;

    edtBasCal.Color       := clWindow;
    edtAlqCBS.Color       := clWindow;
    edtAlqIBS.Color       := clWindow;
    edtValCBS.Color       := clWindow;
    edtValIBS.Color       := clWindow;

    edtBasCal.FocusColor  := clInfoBk;
    edtAlqCBS.FocusColor  := clInfoBk;
    edtAlqIBS.FocusColor  := clInfoBk;
    edtValCBS.FocusColor  := clInfoBk;
    edtValIBS.FocusColor  := clInfoBk;

    edtBasCal.NormalColor := clWindow;
    edtAlqCBS.NormalColor := clWindow;
    edtAlqIBS.NormalColor := clWindow;
    edtValCBS.NormalColor := clWindow;
    edtValIBS.NormalColor := clWindow;
  End;

  If FDocRef = 'S' Then
  Begin
    edtNumDoc.ReadOnly    := False;
    edtNumDoc.TabStop     := True;
    edtNumDoc.Color       := clWindow;
    edtNumDoc.FocusColor  := clInfoBk;
    edtNumDoc.NormalColor := clWindow;

    edtSerie.ReadOnly    := False;
    edtSerie.TabStop     := True;
    edtSerie.Color       := clWindow;
    edtSerie.FocusColor  := clInfoBk;
    edtSerie.NormalColor := clWindow;
  End;
end;

procedure TfrmReformaTributariaCreditoDebito.pLimpaDados(blnCompleto: Boolean = True);
begin

  If blnCompleto Then
  Begin
    FCreDeb := '';
    FTipFin := '';
    FCodCst := '';
    FClaTri := '';
    FDocRef := '';
    FMesAno := '';
    FCbsIbs := '';

    edtCodCli.Clear;
    edtNomCli.Clear;
    edtNumDoc.Clear;
    edtSerie.Clear;
    edtChaveAcesso.Clear;

    edtCreDeb.Clear;
    edtTipFin.Clear;
    edtTipFinDescr.Clear;
    edtClaFis.Clear;
    edtNatOpe.Clear;
    edtMens01.Clear;
    edtMens02.Clear;
    edtMens03.Clear;
    edtMens04.Clear;
    edtMens05.Clear;
    mskMesAno.Clear;
    edtBasCal.Text := '0,00';
    edtAlqCBS.Text := '0,00';
    edtAlqIBS.Text := '0,00';
    edtValCBS.Text := '0,00';
    edtValIBS.Text := '0,00';
    edtValor.Text  := '0,00';

    pAcessoTela(False);
  End
  Else
  Begin
    FTipFin := '';
    FCodCst := '';
    FClaTri := '';
    FDocRef := '';
    FMesAno := '';
    FCbsIbs := '';

    edtNumDoc.Clear;
    edtSerie.Clear;
    edtChaveAcesso.Clear;

    edtTipFin.Clear;
    edtTipFinDescr.Clear;
    edtClaFis.Clear;
    edtNatOpe.Clear;
    mskMesAno.Clear;
    edtBasCal.Text := '0,00';
    edtAlqCBS.Text := '0,00';
    edtAlqIBS.Text := '0,00';
    edtValCBS.Text := '0,00';
    edtValIBS.Text := '0,00';
  End;
end;

function TfrmReformaTributariaCreditoDebito.fClienteDentroDoEstado: Boolean;
begin
  Result := (fRetUFEmpresa(VS_strCodEmp) = fRetEstadoCliente(edtCodCli.Text));
end;

function TfrmReformaTributariaCreditoDebito.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  strNatOpe: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
        edtNomCli.Clear;
        Result := False;
      End
      Else
      Begin
        pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
        edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do cliente inválido!' , ['&Ok']);
          Result := False;
        End
      End;

      pAcessoTela(Result) ;
    End;

    If (Sender = edtNumDoc) And (not edtNumDoc.ReadOnly) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O documento deve ser preenchido!' , ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtSerie) And (not edtSerie.ReadOnly) Then
    Begin
      If fEmptyStr(edtSerie.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A série deve ser preenchida!' , ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtCreDeb) Then
    Begin
      Result := (Pos(edtCreDeb.Text, 'CD') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo Crédito/Débito deve ser C ou D!',['&Ok']);

      If Result And blnBuscaPorChave Then
      Begin
        If (edtCreDeb.Text <> FCreDeb) Then
          pLimpaDados(False);

        If (edtCreDeb.Text = 'C') Then
          edtClaFis.Text := IIF(fClienteDentroDoEstado, '1', '2') + '949'
        Else
          edtClaFis.Text := IIF(fClienteDentroDoEstado, '5', '6') + '949';

        edtNatOpe.Text := fRetDesCla(edtClaFis.Text);
      End;
    End;

    If (Sender = edtTipFin) Then
    Begin
      If not fEmptyStr(edtCreDeb.Text) Then
      Begin
        If fEmptyStr(edtTipFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O tipo Crédito/Débito deve ser preenchido!' , ['&Ok']);
          edtTipFinDescr.Clear;
          Result := False;
        End
        Else
        Begin
          edtTipFinDescr.Text := IIF(edtCreDeb.Text = 'C', fRetDescricaoTipoCreditoReformaTributaria(edtTipFin.Text),
                                                           fRetDescricaoTipoDebitoReformaTributaria(edtTipFin.Text));

          If fEmptyStr(edtTipFinDescr.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Código do tipo Crédito/Débito inválido!' , ['&Ok']);
            Result := False;
          End;

          If Result Then
          Begin
            If (edtTipFin.Text <> FTipFin) And blnBuscaPorChave Then
              mskMesAno.Clear;

            pLimpaDocumentoReferenciado(edtCreDeb.Text, edtTipFin.Text);
            pCarregaFinalidadeCreditoOuDebito(edtCreDeb.Text, edtTipFin.Text);
          End;
        End;
      End;
    End;

    If (Sender = edtClaFis) Then
    Begin
      If fEmptyStr(edtClaFis.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A classificação fiscal deve ser preenchida!' , ['&Ok']);
        edtNatOpe.Clear;
        Result := False;
      End
      Else
      Begin

        strNatOpe := fRetDesCla(edtClaFis.Text);

        If fEmptyStr(strNatOpe) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação fiscal inválida!' , ['&Ok']);
          Result := False;
        End;

        If Result And blnBuscaPorChave Then
        Begin
          edtNatOpe.Text := strNatOpe;
        End;
      End;
    End
    Else

    If (Sender = edtNatOpe) Then
    Begin
      If (not fEmptyStr(edtClaFis.Text)) And fEmptyStr(edtNatOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A natureza da operação deve ser preenchida!' , ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = mskMesAno) And (not mskMesAno.ReadOnly)  Then
    Begin
      If fEmptyStr(fRetSomenteNumeros(mskMesAno.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Mês / Ano" deve ser preenchido!' , ['&Ok']);
        Result := False;
      End;
    End;

    pHabilitaCampos;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

procedure TfrmReformaTributariaCreditoDebito.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
end;

function TfrmReformaTributariaCreditoDebito.fGravaArquivos: Boolean;
var
  qryCli: TUniQuery;
begin
  Result := False;

  pCriarCdsVenda(Self);
  fatVenda := TFatVenda.CreateInstance('NC');

  qryCli := fCriaQuery(Self);

  Try
    Try
      qryCli.Close;
      qryCli.SQL.Clear;
      qryCli.SQL.Text := 'SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI';
      qryCli.ParamByName('CODCLI').AsString := edtCodCli.Text;
      qryCli.Open;

      fatVenda.strOpcDoc      := 'NC';
      fatVenda.strOpcDocTrue  := fatVenda.strOpcDoc;
      fatVenda.strNomeForm    := Self.Name;

      fatVenda.strEspDoc := 'NF';
      fatVenda.strTipFat := 'Nota Fiscal';
      fatVenda.strConPag := '01000';
      fatVenda.dtaDtaEnt := VS_Date;

      fatVenda.strCodCli := qryCli.FieldByName('CLI_CODCLI').AsString;
      fatVenda.strCliNom := qryCli.FieldByName('CLI_NOMCLI').AsString;
      fatVenda.strCliOri := qryCli.FieldByName('CLI_NOMCLI').AsString;
      fatVenda.strCliCgc := qryCli.FieldByName('CLI_C_G_C_').AsString;

      fatVenda.strCliNum := qryCli.FieldByName('CLI_ENDNUM').AsString;
      fatVenda.strCliCom := qryCli.FieldByName('CLI_ENDCOM').AsString;
      fatVenda.strCliEnd := qryCli.FieldByName('CLI_ENDERE').AsString + ', ' +
                            qryCli.FieldByName('CLI_ENDNUM').AsString + '  ' +
                            qryCli.FieldByName('CLI_ENDCOM').AsString;

      fatVenda.strCliBai := qryCli.FieldByName('CLI_BAIRRO').AsString;
      fatVenda.strCliCep := qryCli.FieldByName('CLI_C_E_P_').AsString;
      fatVenda.strCodCid := qryCli.FieldByName('CLI_CODCID').AsString;
      fatVenda.strCliTel := qryCli.FieldByName('CLI_FONE01').AsString;
      fatVenda.strCliEma := qryCli.FieldByName('CLI_EMAIL3').AsString;
      fatVenda.strCliEm2 := qryCli.FieldByName('CLI_EMAIL2').AsString;
      fatVenda.strCluFid := qryCli.FieldByName('CLI_CLUFID').AsString;
      fatVenda.strCliFid := qryCli.FieldByName('CLI_CLIFID').AsString;

      fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
      fatVenda.strCliEst := fRetNomCidade(fatVenda.strCodCid, 1);

      fatVenda.strCliAti := qryCli.FieldByName('CLI_CODATI').AsString;
      fatVenda.strCli_Rg := qryCli.FieldByName('CLI_NUMR_G').AsString;
      fatVenda.strObserv := qryCli.FieldByName('CLI_OBSERV').AsString;
      fatVenda.strCliDAc := qryCli.FieldByName('CLI_CODEAC').AsString;
      fatVenda.blnConstr := (fAtividadeConstrutora(qryCli.FieldByName('CLI_CODATI').AsString));

      fatVenda.objNfeComplemento.strDescricao := IIF(edtCreDeb.Text = 'C', 'RTC - Crédito - ' + fRetDescricaoTipoCreditoReformaTributaria(edtTipFin.Text),
                                                                           'RTC - Débito - '  + fRetDescricaoTipoDebitoReformaTributaria(edtTipFin.Text));

      fatVenda.strFinNfe := IIF(edtCreDeb.Text = 'C', '5','6');
      fatVenda.strFinTip := FTipFin;

      fatVenda.objNfeComplemento.strTipFin := FTipFin;
      fatVenda.objNfeComplemento.strCodCst := FCodCst;
      fatVenda.objNfeComplemento.strClaTri := FClaTri;

      fatVenda.objNfeComplemento.tncTipoNota := IIF(FCreDeb = 'C', tncReformaTributariaCredito, tncReformaTributariaDebito);

      If FDocRef = 'S' Then
      Begin
        fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso := Self.edtChaveAcesso.Text;
        fatVenda.objNfeComplemento.notaReferenciada.strNumDoc      := Self.edtNumDoc.Text;
        fatVenda.objNfeComplemento.notaReferenciada.strSerie       := Self.edtSerie.Text;
        fatVenda.objNfeComplemento.notaReferenciada.strEspDoc      := 'NF';
      End;

      fatVenda.pPreencheMatrizFechamento;
      fatVenda.pCalculaTotGer;

      fatVenda.strClaFis := edtClaFis.Text;
      fatVenda.strDesCla := edtNatOpe.Text;

      fatVenda.objNfeComplemento.strMenNc01 := edtMens01.Text;
      fatVenda.objNfeComplemento.strMenNc02 := edtMens02.Text;
      fatVenda.objNfeComplemento.strMenNc03 := edtMens03.Text;
      fatVenda.objNfeComplemento.strMenNc04 := edtMens04.Text;
      fatVenda.objNfeComplemento.strMenNc05 := edtMens05.Text;

      If (FMesAno = 'S') Then
        fatVenda.objNfeComplemento.strMesAno := IIF(fEmptyStr(fRetSomenteNumeros(mskMesAno.Text)),'',mskMesAno.Text);

      If (FCbsIbs = 'S') Then
      Begin
        fatVenda.objNfeComplemento.fltBasCal := fStrToFloat(edtBasCal.text);

        fatVenda.objNfeComplemento.fltAlqCBS := fStrToFloat(edtAlqCBS.text);
        fatVenda.objNfeComplemento.fltAlqIBS := fStrToFloat(edtAlqIBS.text);

        fatVenda.objNfeComplemento.fltValCBS := fStrToFloat(edtValCBS.text);
        fatVenda.objNfeComplemento.fltValIBS := fStrToFloat(edtValIBS.text);
      End;

      fatVenda.fltNotCom := fStrToFloat(edtValor.text);
      fatVenda.fltTotGer := fatVenda.fltNotCom;

      Result := fatVenda.fGravaArquivos;

    Except
      On E: Exception do
      Begin
        pMensagensErro(E.Message,'[TfrmReformaTributariaCreditoDebito.fGravaArquivos]');
      End;
    End;

  Finally
    FreeAndNil(qryCli);
    FreeAndNil(fatVenda);
  End;

end;

procedure TfrmReformaTributariaCreditoDebito.btnConfirmarClick(Sender: TObject);
var
  blnGravou:   Boolean;
  blnExecutou: Boolean;
begin
  blnGravou   := False;
  blnExecutou := False;

  If (InterlockedIncrement(FSemaforoConfirma) = 0) Then
  Begin
    If fVerificaCampos Then
    Begin
      If (fMensagem('ATENÇÃO!', 'Deseja confirmar a operação?', ['&Sim', '&Não']) = 1) Then
      Begin
        blnExecutou := True;
        blnGravou   := fGravaArquivos;
      End;
    End;
    InterlockedDecrement(FSemaforoConfirma);
  End
  Else
    InterlockedDecrement(FSemaforoConfirma);

  If blnGravou Then
    pLimpaDados
  Else If blnExecutou Then
    fMensagem('ATENÇÃO!', 'Não foi possível gerar o documento!', ['&Ok']);
end;

procedure TfrmReformaTributariaCreditoDebito.edtAlqCBSExit(Sender: TObject);
begin
  inherited;
  pCalculaCBS;
end;

procedure TfrmReformaTributariaCreditoDebito.edtAlqIBSExit(Sender: TObject);
begin
  inherited;
  pCalculaIBS;
end;

procedure TfrmReformaTributariaCreditoDebito.edtCodCliKeyPress(Sender: TObject; var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmReformaTributariaCreditoDebito.edtNumDocExit(Sender: TObject);
begin
  inherited;

  edtChaveAcesso.Clear;

  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  If fEmptyStr(edtNumDoc.Text) Then
    Exit;

  If fEmptyStr(edtSerie.Text) Then
    Exit;

  edtChaveAcesso.Text := fRetornaChaveAcesso(edtNumDoc.Text, 'NF', VS_strCodEmp, edtCodCli.Text, edtSerie.Text);
end;

procedure TfrmReformaTributariaCreditoDebito.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  qryGen : TUniQuery;
  arrSel : TConsultasArray;
begin
  inherited;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
    Key := #0;
    Exit;
  End;

  qryGen := fCriaQuery(Self);

  Try
    If fPesqLivroFiscal(Self, qryGen, Key, arrSel, True, conNotaComplementar, 'C', edtCodCli.Text, '', '', False, 0, 0, True, VS_strCodEmp) Then
    Begin
      edtNumDoc.Text      := qryGen.FieldByName('FIS_NUMDOC').AsString;
      edtSerie.Text       := qryGen.FieldByName('FIS_SERIE_').AsString;
      edtChaveAcesso.Text := qryGen.FieldByName('FIS_ACESSO').AsString;

      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmReformaTributariaCreditoDebito.edtTipFinKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
  blnOK: Boolean;
begin
  inherited;

  If edtTipFin.ReadOnly then
    Exit;

  If fEmptyStr(edtCreDeb.Text) Then
    Exit;

  If edtCreDeb.Text = 'C' Then
    blnOK := fPesqReformaTributariaTipoDeCredito(Self, edtTipFin, edtTipFinDescr, Nil, Key, arrSel)
  Else
    blnOK := fPesqReformaTributariaTipoDeDebito(Self, edtTipFin, edtTipFinDescr, Nil, Key, arrSel);

  If blnOK Then
  Begin
    If fValidaCampos(edtTipFin) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmReformaTributariaCreditoDebito.pAcessoTela(blnHabilitado: Boolean);
begin
  pnlDados.Enabled := blnHabilitado;

  edtNumDoc.Color  := $00FFDFB8;
  edtSerie.Color   := $00FFDFB8;
  edtCreDeb.Color  := $00FFDFB8;
  edtTipFin.Color  := $00FFDFB8;
  edtClaFis.Color  := $00FFDFB8;
  edtNatOpe.Color  := $00FFDFB8;
  edtMens01.Color  := $00FFDFB8;
  edtMens02.Color  := $00FFDFB8;
  edtMens03.Color  := $00FFDFB8;
  edtMens04.Color  := $00FFDFB8;
  edtMens05.Color  := $00FFDFB8;
  mskMesAno.Color  := $00FFDFB8;
  edtBasCal.Color  := $00FFDFB8;
  edtAlqCBS.Color  := $00FFDFB8;
  edtAlqIBS.Color  := $00FFDFB8;
  edtValCBS.Color  := $00FFDFB8;
  edtValIBS.Color  := $00FFDFB8;
  edtValor.Color   := $00FFDFB8;

  If blnHabilitado Then
  Begin
    edtNumDoc.Color  := clWindow;
    edtSerie.Color   := clWindow;
    edtCreDeb.Color  := clWindow;
    edtTipFin.Color  := clWindow;
    edtClaFis.Color  := clWindow;
    edtNatOpe.Color  := clWindow;
    edtMens01.Color  := clWindow;
    edtMens02.Color  := clWindow;
    edtMens03.Color  := clWindow;
    edtMens04.Color  := clWindow;
    edtMens05.Color  := clWindow;
    mskMesAno.Color  := clWindow;
    edtBasCal.Color  := clWindow;
    edtAlqCBS.Color  := clWindow;
    edtAlqIBS.Color  := clWindow;
    edtValCBS.Color  := clWindow;
    edtValIBS.Color  := clWindow;
    edtValor.Color   := clWindow;
  End;
end;

procedure TfrmReformaTributariaCreditoDebito.FormCreate(Sender: TObject);
begin
  inherited;
  FSemaforoConfirma := -1;
  qryCadCli := fCriaQuery;
  pAcessoTela(False);
end;

procedure TfrmReformaTributariaCreditoDebito.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCadCli);

  if Assigned(fatVenda) then
    FreeAndNil(fatVenda);

  inherited;
end;

procedure TfrmReformaTributariaCreditoDebito.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaDados;
  pSetFocus(edtCodCli);
end;

procedure TfrmReformaTributariaCreditoDebito.pCalculaIBS;
var
  fltBasIBS: Double;
  fltAlqIBS: Double;
  fltValIBS: Double;
begin
  fltBasIBS := fStrToFloat(edtBasCal.Text);
  fltAlqIBS := fStrToFloat(edtAlqIBS.Text);
  fltValIBS := (fltBasIBS * fltAlqIBS) / 100;

  edtValIBS.Text := FormatFloat('#,##0.00', fltValIBS);
end;

procedure TfrmReformaTributariaCreditoDebito.pCalculaCBS;
var
  fltBasCBS: Double;
  fltAlqCBS: Double;
  fltValCBS: Double;
begin
  fltBasCBS := fStrToFloat(edtBasCal.Text);
  fltAlqCBS := fStrToFloat(edtAlqCBS.Text);
  fltValCBS := (fltBasCBS * fltAlqCBS) / 100;

  edtValCBS.Text := FormatFloat('#,##0.00', fltValCBS);
end;

procedure TfrmReformaTributariaCreditoDebito.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3    : btnCancelar.Click;
    VK_F10   : btnConfirmar.Click;
    VK_ESCAPE: Begin
                 Key := VK_NONAME;
                 If fMensagem('', 'Deseja realmente sair?', ['&Sim', '&Não']) = 1 Then
                   btnSair.Click;
               End;
  End;
end;

end.
