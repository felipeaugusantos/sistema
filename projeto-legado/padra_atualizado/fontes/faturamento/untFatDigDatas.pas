unit untFatDigDatas;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untFatRemessaDevolucaoClasse;

type
  TTipoTela   = (ttDefault, ttDevolucaoRapida);
  TTipoCodigo = (ttChaveDeAcesso, ttQRCode);

type
  TfrmFatDigDatas = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlNumDoc: TPanel;
    Label3: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    pnlDatas: TPanel;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    lblMsgOF: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    pnlDevCom: TPanel;
    chkDevCom: TCheckBox;
    pnlPigBas: TPanel;
    chkPigBas: TCheckBox;
    pnlConsumidor: TPanel;
    Label4: TLabel;
    edtCodCliCon: TEditFocus;
    edtNomCliCon: TEditFocus;
    Label5: TLabel;
    edtNumCoo: TEditFocus;
    edtCodEmp: TEditFocus;
    lblInformacao: TLabel;
    lblCodEmpresa: TLabel;
    pnlCodigosViaLeitor: TPanel;
    lblChaAce: TLabel;
    lblQRCode: TLabel;
    edtChaAce: TEditFocus;
    edtQrCode: TEditFocus;
    pnlRemessaDevolucao: TPanel;
    Label1: TLabel;
    edtRemessaDevolucao: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliConKeyPress(Sender: TObject; var Key: Char);
    procedure chkDevComClick(Sender: TObject);
    procedure edtChaAceKeyPress(Sender: TObject; var Key: Char);
    procedure edtQrCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtRemessaDevolucaoExit(Sender: TObject);
    procedure edtRemessaDevolucaoKeyPress(Sender: TObject; var Key: Char);
  private
    blnDVOULJ : Boolean;
    blnDEVAUT : Boolean;
    blnSOMLOJ : Boolean;
    blnDVPDOL : Boolean;
    FTipoTela : TTipoTela;
    blnLayoutDevolucaoCfgDvouljlAtiva : Boolean;
    blnDevRetiradaCfgDVPDOLAtiva : Boolean;
    blnObrigarInformarDocumento: Boolean;
    blnValidouRemessa: Boolean;
    function fDocumentoExiste(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fEnabledCodEmp: Boolean;

    function fEhDevAutDeOutraLojaMasNaoObrigatorioInformarDocumento : Boolean;
    function fEhObrigatorioInformarNumeroDoDocumentoDevOutraLoja    : Boolean;
    function fEhLayoutDevolucaoOutrasLojas: Boolean;
    function fDocumentoInformadoLeitor: Boolean;

    procedure pBloqueiaFiltros;
    procedure pBloqueiaCaixasVazias;
    procedure pLiberaTodasAsCaixas;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnFatVenda: Boolean;
    blnMosChkDev: Boolean;
    strCodCli: String;
    strOpcDoc: String;
    blnOpcDoc: Boolean;
    blnNumDoc: Boolean;

    blnLeitor_DevRap : Boolean;
    strNumDoc_DevRap : String;
    strEspDoc_DevRap : String;
    strEmpDoc_DevRap : String;
    strCliDoc_DevRap : String;

    property TipoTela : TTipoTela read FTipoTela write FTipoTela;
    function fEhDevolucaoRapida : Boolean;

    function fLocalizarDocumento(strDocumento : String; TipoCodigo : TTipoCodigo) : Boolean;

  end;

var
  frmFatDigDatas: TfrmFatDigDatas;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema, untFatVendas,
  untConstantes;

{$R *.dfm}

procedure TfrmFatDigDatas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatDigDatas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (pnlCodigosViaLeitor.Visible) And (fEhDevolucaoRapida) And (strCodCli.IsEmpty) Then
      strCodCli := fRetornarClienteDocumento(edtNumDoc.Text, edtEspDoc.Text, IIF(fEmptyStr(edtCodEmp.Text), VS_strCodEmp, edtCodEmp.Text));

    If (Sender <> edtRemessaDevolucao) And (blnValidouRemessa) Then
      Exit;

    If (Sender = edtRemessaDevolucao) And (pnlRemessaDevolucao.Visible) And (Not fEmptyStr(edtRemessaDevolucao.Text)) Then
    Begin
      If TRemessaDevolucao.fValidaRemessa(edtRemessaDevolucao.Text, 'OF') Then
      Begin
        frmFatVendas.strNumRemessa := edtRemessaDevolucao.Text;
        blnValidouRemessa := True;
        btnConfirmaDados.Click;
        Exit;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Remessa Nº '+edtRemessaDevolucao.Text+' Não encontrada.', ['&OK']);
        Result := False;
        edtRemessaDevolucao.Clear;
      End;
    End
    Else

    {Chave de Acesso}
    If (Sender = edtChaAce) And (pnlCodigosViaLeitor.Visible) And (fEhDevolucaoRapida) Then
    Begin
      Try
        If fLocalizarDocumento(edtChaAce.Text, ttChaveDeAcesso) Then
          btnConfirmaDados.Click;
      Except
        fMensagem('ATENÇÃO!', 'Houve um problema na leitura da chave de acesso. Por favor, tente novamente!', ['&OK']);
        pSetFocus(edtChaAce);
        Result := False;
      End;
    End

    Else

    {QRCode}
    If (Sender = edtQrCode) And (pnlCodigosViaLeitor.Visible) And (fEhDevolucaoRapida) Then
    Begin
      Try
        If fLocalizarDocumento(edtQrCode.Text, ttQRCode) Then
          btnConfirmaDados.Click;
      Except
        fMensagem('ATENÇÃO!', 'Houve um problema na leitura do Qr Code. Por favor, tente novamente!', ['&OK']);
        pSetFocus(edtQrCode);
        Result := False;
      End;
    End

    Else

    If ((Sender = edtNumDoc) Or (Sender = edtNumCoo)) and pnlNumDoc.Visible Then
    Begin

      if fEhObrigatorioInformarNumeroDoDocumentoDevOutraLoja then
      begin
        If (fEmptyStr(edtNumDoc.Text) and fEmptyStr(edtNumCoo.Text) and edtCodEmp.Visible ) And
           (Not fDocumentoInformadoLeitor) Then
        Begin
          If (VS_strCodEmp <> edtCodEmp.text) Then
          begin
            fMensagem('ATENÇÃO!', 'Informe o número do documento!', ['&OK']);
            Result := False;
          end;
        End
      end;

      if blnObrigarInformarDocumento and (not blnBuscaPorChave) and fEmptyStr(edtNumDoc.Text) and fEmptyStr(edtNumCoo.Text)  Then
      begin
        fMensagem('ATENÇÃO!', 'Informe o número do documento ou o número do COO!', ['&OK']);
        Result := False;
      end;

      mskDtaIni.Enabled  := fEmptyStr(edtNumDoc.Text) Or fEmptyStr(edtNumCoo.Text);

      if (not fEmptyStr(edtNumDoc.Text) and fCfgSis('DOCDEV', varBoolean)) then
      begin
        mskDtaIni.Enabled  := False;
      end;

      If Not mskDtaIni.Enabled Then
        mskDtaIni.Clear;

      mskDtaFin.Enabled  := fEmptyStr(edtNumDoc.Text) Or fEmptyStr(edtNumCoo.Text);

      if (not fEmptyStr(edtNumDoc.Text) and fCfgSis('DOCDEV', varBoolean)) then
      begin
        mskDtaFin.Enabled  := False;
      end;

      If Not mskDtaFin.Enabled Then
        mskDtaFin.Clear;

      edtEspDoc.Enabled := Not fEmptyStr(edtNumDoc.Text);

      edtCodEmp.Enabled := fEnabledCodEmp;

      If Not edtEspDoc.Enabled Then
      Begin
        edtEspDoc.Clear;

        if (Not fEhLayoutDevolucaoOutrasLojas) then
          edtCodEmp.Clear;
      End;

    End

    Else If (Sender = edtEspDoc) and pnlNumDoc.Visible Then
    Begin

      If edtEspDoc.Enabled Then
      Begin

        If fEmptyStr(edtEspDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe a espécie do documento!', ['&OK']);
          Result := False;
        End

        Else If (Not fEnabledCodEmp) And (Not fDocumentoExiste(edtNumDoc.Text, edtEspDoc.Text,
                                                               VS_strCodEmp, strCodCli)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Documento não encontrado!', ['&OK']);
          Result := False;
        End;

        edtCodEmp.Enabled := fEnabledCodEmp;

        If fEmptyStr(edtCodEmp.Text) Then
          edtCodEmp.Text := VS_strCodEmp;

      End;

    End

    Else If (Sender = edtCodEmp) and pnlNumDoc.Visible Then
    Begin
      If edtCodEmp.Enabled And edtCodEmp.Visible Then
      Begin
        If fEmptyStr(edtCodEmp.Text) Then
        Begin
          If (Not fDocumentoInformadoLeitor) Then
          Begin
            fMensagem('ATENÇÃO!', 'Informe a empresa do documento!', ['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          If (fEmptyStr(fRetNomeEmpresaSelec(edtCodEmp.Text))) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&OK']);
            Result := False;
          End
          Else if (Not fEhLayoutDevolucaoOutrasLojas) And
                  (Not fEhDevAutDeOutraLojaMasNaoObrigatorioInformarDocumento) then
          begin
            If (Not fDocumentoExiste(edtNumDoc.Text, edtEspDoc.Text,
                                          edtCodEmp.Text, strCodCli)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Documento não encontrado!', ['&OK']);
              Result := False;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = mskDtaIni) And (mskDtaIni.Enabled) And (blnOpcDoc) Then
    Begin

      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
         ( blnOpcDoc Or (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) ) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
              (    fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
              (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCliCon) And blnFatVenda Then
    Begin

      If Not fEmptyStr(edtCodCliCon.Text) Then
      Begin
        edtNomCliCon.Text := fRetDadosClienteConsumidor(edtCodCliCon.Text,'NOMCON');

        If fEmptyStr(edtNomCliCon.Text) Then
        Begin
          fMensagem('','Nenhum consumidor encontrado com este código!',['&OK']);
          Result := False;
        End
        Else If fRetUFCliente(strCodCli) <> fRetNomCidade(fRetDadosClienteConsumidor(edtCodCliCon.Text, 'CODCID'), 1) Then
        Begin
          fMensagem('','Estado do cliente consumidor deve ser ' + fRetUFCliente(strCodCli),['&OK']);
          Result := False;
        End;

      End
      Else
        edtNomCliCon.Clear;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


procedure TfrmFatDigDatas.pBloqueiaCaixasVazias;
var
  iContador : Integer;
  blnEh_Empresa_Documento_Especie : Boolean;
begin

  blnEh_Empresa_Documento_Especie := False;

  {Digitou empresa, documento ou espécie?}
  For iContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Components[iContador] is TEditFocus) Then
    Begin
      If (TEditFocus(Components[iContador]).Name = edtCodEmp.Name) Or
         (TEditFocus(Components[iContador]).Name = edtNumDoc.Name) Or
         (TEditFocus(Components[iContador]).Name = edtEspDoc.Name) Then
      Begin
        If Not fEmptyStr(TEditFocus(Components[iContador]).Text) Then
        Begin
          blnEh_Empresa_Documento_Especie := True;
          Break;
        End;
      End;
    End;
  End;

  For iContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Components[iContador] is TEditFocus) Then
    Begin

      {Se digitou empresa, documento ou espécie, não bloqueia esses campos!}
      If (blnEh_Empresa_Documento_Especie) Then
      Begin

        If (TEditFocus(Components[iContador]).Name <> edtCodEmp.Name) And
           (TEditFocus(Components[iContador]).Name <> edtNumDoc.Name) And
           (TEditFocus(Components[iContador]).Name <> edtEspDoc.Name) Then
        Begin
          TEditFocus(Components[iContador]).Enabled := Not fEmptyStr(TEditFocus(Components[iContador]).Text);
        End;

      End
      Else
      Begin
        TEditFocus(Components[iContador]).Enabled := Not fEmptyStr(TEditFocus(Components[iContador]).Text);
      End;

    End;
  End;

end;

procedure TfrmFatDigDatas.pBloqueiaFiltros;
var
  iContador : Integer;
  blnVlrDig : Boolean;
begin

  If Not fEhDevolucaoRapida Then
    Exit;

  blnVlrDig := False;

  For iContador := 0 To Self.ComponentCount -1 Do
    If (Components[iContador] is TEditFocus) Then
      If Not fEmptyStr(TEditFocus(Components[iContador]).Text) Then
        blnVlrDig := True;

  If (blnVlrDig) Then
    pBloqueiaCaixasVazias
  Else
    pLiberaTodasAsCaixas;

end;

procedure TfrmFatDigDatas.pLiberaTodasAsCaixas;
var
  iContador : Integer;
begin
  For iContador := 0 To Self.ComponentCount -1 Do
    If (Components[iContador] is TEditFocus) Then
      TEditFocus(Components[iContador]).Enabled := True;
end;


procedure TfrmFatDigDatas.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma           := False;
  blnMosChkDev          := False;
  blnNumDoc             := False;
  blnDVOULJ             := (MatchStr(fCfgSis('DVOULJ', varString), ['S','B']));
  blnDEVAUT             := (fCfgSis('DEVAUT', varBoolean));
  blnSOMLOJ             := (fCfgSis('SOMLOJ', varBoolean));
  lblInformacao.Visible := (fCfgSis('DOCDEV', varBoolean));
  blnDVPDOL             := (fCfgSis('DVPDOL', varBoolean));
  TipoTela              := ttDefault;

  blnLeitor_DevRap := False;
  strNumDoc_DevRap := '';
  strEspDoc_DevRap := '';
  strEmpDoc_DevRap := '';
  strCliDoc_DevRap := '';
  blnValidouRemessa := False;
end;

procedure TfrmFatDigDatas.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  pBloqueiaFiltros;
end;

procedure TfrmFatDigDatas.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatDigDatas.chkDevComClick(Sender: TObject);
begin
  inherited;
  if edtNumDoc.text <> '' Then
  begin
    if ((fCfgSis('ESTFLJ') = 2) And (fCfgSis('USATMQ') = 'S')   And (frmFatVendas.fVerificarTintaBaixaEntFut(edtNumDoc.text, edtEspDoc.text, VS_strCodEmp))
       And (Pos(frmFatVendas.fRetornarClaFisDevolucao(edtNumDoc.text, edtEspDoc.text, VS_strCodEmp), '5922_6922_'+CLAFIS_ENTFUT_VEN) > 0)) Then
    begin
      pnlPigBas.Visible          := false;
      frmFatVendas.blnCliPigBas  := true;
    end
    else
      pnlPigBas.Visible := chkDevCom.Checked;
  end
  else
    pnlPigBas.Visible := chkDevCom.Checked;

  If (Not pnlPigBas.Visible) Then
    chkPigBas.Checked := False;
end;

procedure TfrmFatDigDatas.FormShow(Sender: TObject);
begin
  edtNumCoo.MaxLength := 9;
  edtNumCoo.TamCampo  := edtNumCoo.MaxLength;
  edtNumCoo.CompZeros := False;

  If SameText(strOpcDoc, 'OF') Then
    edtNumDoc.TamCampo  := fTamNumDoc
  Else
    edtNumDoc.TamCampo  := fTamDocCadRec;

  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  If blnOpcDoc Then
  Begin
    mskDtaIni.Text := DateToStr(VS_Date);
    mskDtaFin.Text := DateToStr(VS_Date);
  End;

  inherited;

  blnLayoutDevolucaoCfgDvouljlAtiva := blnDVOULJ And SameText(strOpcDoc, 'DV');
  blnDevRetiradaCfgDVPDOLAtiva := blnDVPDOL And SameText(strOpcDoc, 'PR');

  lblCodEmpresa.Visible := fEhLayoutDevolucaoOutrasLojas;
  edtCodEmp.Visible     := lblCodEmpresa.Visible;

  edtCodEmp.Enabled := true;

  if (Not fEhLayoutDevolucaoOutrasLojas) then
  begin
    edtCodEmp.left     := 273;
    edtCodEmp.Enabled  := false;
    edtNumDoc.TabOrder := 0;
    edtEspDoc.TabOrder := 1;
    edtCodEmp.TabOrder := 2;
  end;

  If blnFatVenda Then
  Begin
    edtCodCliCon.Enabled  := True;
    pnlConsumidor.Visible := True;
  End
  Else
  Begin
    pnlConsumidor.Visible := False;
    pnlNumDoc.Visible     := False;
    edtCodCliCon.Enabled  := False;
    Self.Height := Self.Height - pnlConsumidor.Height;
  End;

  chkDevCom.Visible := (blnMosChkDev);
  pnlDevCom.Visible := (blnMosChkDev);

  edtCodEmp.Visible     := strOpcDoc.Contains('DV') or blnDevRetiradaCfgDVPDOLAtiva;

  If Not pnlDevCom.Visible Then
    Self.Height := Self.Height - pnlDevCom.Height;

  pnlNumDoc.Visible := blnNumDoc;

  If Not pnlNumDoc.Visible Then
    Self.Height := Self.Height - pnlNumDoc.Height;

  If (strOpcDoc = 'EF') Then
  Begin
    edtCodEmp.Visible     := True;
    pnlConsumidor.Visible := False;
    chkPigBas.Visible     := False;
    lblMsgOF.Visible      := False;
    pnlDatas.Visible      := False;
    Self.Height           := Self.Height - pnlConsumidor.Height;
    Self.Caption          := 'Digite o número do documento';
  End;

  pnlCodigosViaLeitor.Visible := False;

  If (fEhDevolucaoRapida) Then
  Begin

    pnlCodigosViaLeitor.Visible := True;
    pnlDatas.Visible            := False;
    chkDevCom.Checked := True;
    chkDevCom.Enabled := False;
    edtChaAce.MaxLength := 50;
    edtChaAce.TamCampo  := 50;
    pSetFocus(edtChaAce);

    lblQRCode.Visible := fCfgSis('USNFCE', varBoolean);
    edtQrCode.Visible := fCfgSis('USNFCE', varBoolean);

  End;

  pnlRemessaDevolucao.Visible := ((fCfgSis('UTIRRD', varBoolean)) And (Pos(strOpcDoc, 'OF_') > 0));

  blnObrigarInformarDocumento := (strOpcDoc = 'DV') and (fCfgSis('DVOBVN', varBoolean) or fCfgSis('DVTBCR', varBoolean));
  if blnObrigarInformarDocumento then
  begin
    mskDtaIni.Visible := False;
    lblDtaIni.Visible := False;
    mskDtaFin.Visible := False;
    lblDtaFin.Visible := False;
  end;

end;

procedure TfrmFatDigDatas.edtChaAceKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) Then
    fValidaCampos(edtChaAce, True);
end;

procedure TfrmFatDigDatas.edtCodCliConKeyPress(Sender: TObject;
  var Key: Char);

  Var
    chrKey: Char;
    arrConsumidores: TConsultasArray;
    qryConsum : TUniQuery;

begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE CONSUMIDORES *}
  {******************************AC*}
  try
    qryConsum := fCriaQuery(Nil);

    chrKey := Key;

    If fPesqConsumidores(Self, Nil, Nil, Nil, TMaskEditFocus(edtCodCliCon), qryConsum, chrKey, arrConsumidores, strCodCli) Then
    Begin
      If Not fValidaCampos(edtCodCliCon, True) Then
        pSetFocus(edtCodCliCon);
    End;
    
  finally
    FreeAndNil(qryConsum);
  end;
End;

procedure TfrmFatDigDatas.edtQrCodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) Then
    fValidaCampos(edtQrCode, True);
end;

procedure TfrmFatDigDatas.edtRemessaDevolucaoExit(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtRemessaDevolucao.Text) then
    edtRemessaDevolucao.Text := fStrZero(edtRemessaDevolucao.Text, edtRemessaDevolucao.TamCampo);

  if fValidaCampos(edtRemessaDevolucao) then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatDigDatas.edtRemessaDevolucaoKeyPress(Sender: TObject;
  var Key: Char);
var
  qryConGen: TUniQuery;
  arrSel   : TConsultasArray;
begin
  inherited;

  qryConGen := fCriaQuery(Self);

  Try
    If fPesqRemessaDevolucao(Self, edtRemessaDevolucao, qryConGen, Key, arrSel, toOutrasSaidas) Then
    Begin
      if fValidaCampos(edtRemessaDevolucao) then
        SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryConGen);
  End;
end;

function TfrmFatDigDatas.fDocumentoExiste(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
  Var
    strSQL: String;
    strAux: String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' ( ';

    strAux := '';
    strAux := strAux + ' SELECT ';
    strAux := strAux + '   GER_NUMDOC ';
    strAux := strAux + ' FROM ';
    strAux := strAux + '   MOVGER ';
    strAux := strAux + ' WHERE ';
    If Pos(strOpcDoc,'OF_EF_') > 0 Then
      strAux := strAux + '   GER_CODFOR = :CODCLI AND '
    Else
      strAux := strAux + '   GER_CODCLI = :CODCLI AND ';
    strAux := strAux + '   GER_NUMDOC = :NUMDOC AND ';
    strAux := strAux + '   GER_ESPDOC = :ESPDOC AND ';
    strAux := strAux + '   GER_CODEMP = :CODEMP ';

    strAux := strAux + ' UNION ALL ' + AnsiReplaceStr(strAux,'MOVGER','NOTGER');

    strSQL := strSQL + strAux + ' ) A ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function TfrmFatDigDatas.fDocumentoInformadoLeitor: Boolean;
begin
  Result := False;

  If pnlCodigosViaLeitor.Visible And
     (Not(fEmptyStr(edtChaAce.Text)) Or
      Not(fEmptyStr(edtQrCode.Text))) Then
    Result := True;
end;

function TfrmFatDigDatas.fEhDevAutDeOutraLojaMasNaoObrigatorioInformarDocumento: Boolean;
begin

  Result := False;

  If Not blnDVOULJ Then
    Exit;

  If Not blnDEVAUT Then
    Exit;

  If Not blnSOMLOJ Then
    Exit;

  If Not (VS_strCodEmp <> edtCodEmp.Text) Then
    Exit;

  If Not SameText(strOpcDoc, 'DV') Then
    Exit;

  Result := True;

end;

function TfrmFatDigDatas.fEhDevolucaoRapida: Boolean;
begin
  Result := (TipoTela = ttDevolucaoRapida);
end;

function TfrmFatDigDatas.fEhLayoutDevolucaoOutrasLojas: Boolean;
begin
  Result := True;

  if (blnLayoutDevolucaoCfgDvouljlAtiva) then
    Exit;

  if (blnDevRetiradaCfgDVPDOLAtiva) then
    Exit;

  Result := False;
end;

function TfrmFatDigDatas.fEhObrigatorioInformarNumeroDoDocumentoDevOutraLoja: Boolean;
begin

  Result := False;

  If fEhDevAutDeOutraLojaMasNaoObrigatorioInformarDocumento Then
    Exit;

  If (Not fEhLayoutDevolucaoOutrasLojas) Then
    Exit;

  Result := True;

end;

function TfrmFatDigDatas.fEnabledCodEmp: Boolean;
begin
  if strOpcDoc = 'EF' then
    Result := (edtCodEmp.Visible) And (blnDVOULJ) And (edtEspDoc.Enabled) And (Not fEmptyStr(edtEspDoc.Text))
  else if (strOpcDoc = 'PR') then
    Result := (blnDVPDOL)
  else
    Result := (blnDVOULJ);
end;

function TfrmFatDigDatas.fLocalizarDocumento(strDocumento: String; TipoCodigo: TTipoCodigo): Boolean;
var
  qryLocDoc : TUniQuery;
const
  SQL_CHAACE = 'SELECT                     ' +
               '  FIS_NUMDOC AS NUMDOC,    ' +
               '  FIS_ESPDOC AS ESPDOC,    ' +
               '  FIS_CODEMP AS CODEMP,    ' +
               '  FIS_FORCLI AS CODCLI     ' +
               'FROM                       ' +
               '  CADFIS                   ' +
               'WHERE                      ' +
               '  FIS_ACESSO = :ACESSO AND ' +
               '  FIS_TIP_FC = "C"     AND ' +
               '  FIS_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL :DIADEV DAY) ';

  SQL_QRCODE = 'SELECT                                                       ' +
               '  G.GER_NUMDOC AS NUMDOC,                                    ' +
               '  G.GER_ESPDOC AS ESPDOC,                                    ' +
               '  G.GER_CODEMP AS CODEMP,                                    ' +
               '  G.GER_CODCLI AS CODCLI                                     ' +
               'FROM                                                         ' +
               '  MOVOBS M                                                   ' +
               '  INNER JOIN MOVGER G ON (G.AUTOINCREM = M.MOV_SEQGER)       ' +
               'WHERE                                                        ' +
               '  MD5(MOV_QRCODE) = MD5(:QRCODE) AND                         ' +
               '  GER_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL :DIADEV DAY) ' +

               'UNION ALL                                                    ' +

               'SELECT                                                       ' +
               '  G.GER_NUMDOC AS NUMDOC,                                    ' +
               '  G.GER_ESPDOC AS ESPDOC,                                    ' +
               '  G.GER_CODEMP AS CODEMP,                                    ' +
               '  G.GER_CODCLI AS CODCLI                                     ' +
               'FROM                                                         ' +
               '  NOTOBS M                                                   ' +
               '  INNER JOIN NOTGER G ON (G.AUTOINCREM = M.MOV_SEQGER)       ' +
               'WHERE                                                        ' +
               '  MD5(MOV_QRCODE) = MD5(:QRCODE) AND                         ' +
               '  GER_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL :DIADEV DAY) ';

begin

  Result := False;

  If (strDocumento.IsEmpty) Then
    Exit;

  qryLocDoc := fCriaQuery(Self);

  Try

    qryLocDoc.Close;
    qryLocDoc.SQL.Clear;

    If (TipoCodigo = ttChaveDeAcesso) then
    Begin
      qryLocDoc.SQL.Add(SQL_CHAACE);
      qryLocDoc.ParamByName('ACESSO').AsString := strDocumento;
      qryLocDoc.ParamByName('DIADEV').AsString := IntToStr(fCfgSis('DIADEV', varInteger));
    End

    Else

    If (TipoCodigo = ttQRCode) then
    Begin
      qryLocDoc.SQL.Add(SQL_QRCODE);
      qryLocDoc.ParamByName('QRCODE').AsString := strDocumento;
      qryLocDoc.ParamByName('DIADEV').AsString := IntToStr(fCfgSis('DIADEV', varInteger));
    End;

    qryLocDoc.Open;

    If (qryLocDoc.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO!', 'Documento não encontrado ou fora do prazo permitido para Devolução.' + #13 +
                            'Prazo configurado: ' + fCfgSis('DIADEV', varString), ['&Ok']);
      edtChaAce.Clear;
      edtQrCode.Clear;
      pSetFocus(edtNumDoc);
    End

    Else

    Begin

      blnLeitor_DevRap := True;
      strNumDoc_DevRap := qryLocDoc.FieldByName('NUMDOC').AsString;
      strEspDoc_DevRap := qryLocDoc.FieldByName('ESPDOC').AsString;
      strEmpDoc_DevRap := qryLocDoc.FieldByName('CODEMP').AsString;
      strCliDoc_DevRap := qryLocDoc.FieldByName('CODCLI').AsString;

      Result := True;

    End;

  Finally
    FreeAndNil(qryLocDoc);
  End;

end;

End.