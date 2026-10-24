unit DominioSistemas.View.ProcessarDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untLibDominioSistemasPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Uni, Vcl.CheckLst,
  Vcl.Mask, MaskEditFocus, DominioSistemas.Core.DocumentoInterface,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DominioSistemas.DTO.DomPro,
  Generics.Collections, DominioSistemas.Core.ApiClientInterface, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxProgressBar, EditFocus, untTypesSistema;

type
  TfrmDominioSistemasProcessarDocumentos = class(TfrmPaiDominioSistemasConfirma)
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    cklListaTipos: TCheckListBox;
    gbInfo: TGroupBox;
    lblContabilidade: TLabel;
    lblCliente: TLabel;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnConsulta: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultaClick(Sender: TObject);
  private
    { Private declarations }
    FarrEmp: TConsultasArray;
    function fIntegrarDocumentos(AProgresso: TcxProgressBar): Boolean ;
    procedure pConsultaDadosLicenca ;
    procedure pCarregaTiposNaTela ;
    function fTemTipoMarcado: boolean;
    function fRetornaTiposSelecionados: TTipoDocumentosDominio;
    procedure pConsultaStatusProcessamento(const AApi: IApiClient;
                                           const AListProc: TObjectList<TDOMPRO>;
                                           const AProgresso: TcxProgressBar;
                                           const ATipo: TTipoDocumentoDominio;
                                           const ACodEmp: String) ;
    procedure pPersisteIntegracao(const AListProc: TObjectList<TDOMPRO>) ;
    procedure pSetaTextoProgresso(AProgresso: TcxProgressBar; ATexto: String);
    procedure pAjustaArrayEmpresas ;
    function fVerificaIntegrationKeyEmps: Boolean ;
    function fEmpresasComMesmaChaveIntegracao(AControleIntegrationKey: TDictionary<String, String>): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  DominioSistemas.DocumentoProcessor,
  DominioSistemas.Infra.Repository,
  DominioSistemas.Infra.APIClient,
  DominioSistemas.Core.Exception, DominioSistemas.Core.ConsultaInterface,
  DominioSistemas.View.ConsultarDocumentos, untDominioSistemasFuncoes,
  untLibDominioSistemasFuncoes ;

{$R *.dfm}

procedure TfrmDominioSistemasProcessarDocumentos.btnConfirmaClick(
  Sender: TObject);
begin

  If Not fVerificaCampos Then
    Exit;

  pAjustaArrayEmpresas ;

  if not fVerificaIntegrationKeyEmps then
    Exit ;

  if not fTemTipoMarcado then
  begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um tipo para geração!', ['&OK']);
    Exit;
  end;

  TLibDominioSistemasFuncoes.ExecutaAguarde(fIntegrarDocumentos, 'Aguarde... Integrando registros.') ;

end;

procedure TfrmDominioSistemasProcessarDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_FuncoesExternas.fIRetEmpresaLogada;
  edtNomEmp.Text := VS_FuncoesExternas.fIRetNomeEmpresa;
  lblContabilidade.Caption := '' ;
  lblCliente.Caption := '' ;
  pCarregaTiposNaTela ;
end;

procedure TfrmDominioSistemasProcessarDocumentos.FormShow(Sender: TObject);
begin
  inherited;
  pConsultaDadosLicenca ;
end;

function TfrmDominioSistemasProcessarDocumentos.fRetornaTiposSelecionados: TTipoDocumentosDominio;
var
  LintCnt: Integer ;
begin
  Result := [] ;
  for LintCnt := 0 to Pred(cklListaTipos.Items.Count) do
    if cklListaTipos.Checked[LintCnt] then
      Result := Result + [TTipoDocumentoDominio(LintCnt)]
end;

function TfrmDominioSistemasProcessarDocumentos.fTemTipoMarcado: boolean;
var
  LCnt : Integer;
begin
  Result := False;
  for LCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[LCnt] then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TfrmDominioSistemasProcessarDocumentos.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin

    if (Sender = mskDtaIni) Then
    begin
      If Trim(VS_FuncoesExternas.fITiraCaracEspeciais(mskDtaIni.Text)).IsEmpty Then
      Begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      else if not VS_FuncoesExternas.fIDataValida(StrToDate(mskDtaIni.Text)) then
      begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Data Inicial inválida!', ['&O k']);
        Result := False;
      end;
    end

    else If (Sender = mskDtaFin) Then
    begin
      If Trim(VS_FuncoesExternas.fITiraCaracEspeciais(mskDtaFin.Text)).IsEmpty Then
      Begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not VS_FuncoesExternas.fIValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End
      else if not VS_FuncoesExternas.fIDataValida(StrToDate(mskDtaFin.Text)) then
      begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Data final inválida!', ['&O k']);
        Result := False;
      end;
    end

    Else If (Sender = edtCodEmp) Then
    Begin
      if edtCodEmp.Text <> '000' then
      begin
        If (Not Trim(edtCodEmp.Text).IsEmpty) Then
        Begin
          SetLength(FarrEmp, 0);
          edtNomEmp.Text := VS_FuncoesExternas.fICampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
          If (Trim(edtNomEmp.Text).IsEmpty) Then
          Begin
            VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            SetLength(FarrEmp, 0);
            Result := False;
          End;
        End
        Else
        begin
          SetLength(FarrEmp, 0);
          edtNomEmp.Clear;
        end ;
      end ;
    End ;

  end ;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmDominioSistemasProcessarDocumentos.fVerificaIntegrationKeyEmps: Boolean;
var
  LintCnt: Integer ;
  LIntegrationKey: String ;
  LControleIntegrationKey: TDictionary<String, String> ;
  LMsgIntegrationKey: String ;
  LIntegracaoHabilitada: Boolean ;
begin
  Result := False ;
  LControleIntegrationKey := TDictionary<String, String>.Create ;
  try

    for LintCnt := Low(FarrEmp) to High(FarrEmp) do
    begin
      LIntegracaoHabilitada := TMySQLRepository.fGetIntegracaoDominioHabilitada(FarrEmp[LintCnt].strCodigo) ;
      if not LIntegracaoHabilitada then
      begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', Format('Empresa %s com CFG_DOMHAB desligada!' , [FarrEmp[LintCnt].strCodigo]), ['&OK']);
        exit ;
      end ;

      LIntegrationKey := fRetornaXIntegrationKey(FarrEmp[LintCnt].strCodigo) ;
      if Trim(LIntegrationKey).IsEmpty then
      begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', Format('Empresa %s com CFG_DOMXIK não configurada!' , [FarrEmp[LintCnt].strCodigo]), ['&OK']);
        exit ;
      end ;
      LControleIntegrationKey.Add(FarrEmp[LintCnt].strCodigo, LIntegrationKey);
    end ;

    LMsgIntegrationKey := fEmpresasComMesmaChaveIntegracao(LControleIntegrationKey) ;
    if not Trim(LMsgIntegrationKey).IsEmpty then
    begin
      VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'CFG com valor duplicado entre empresas!' + #13#10 + LMsgIntegrationKey, ['&OK']);
      exit ;
    end ;

  finally
    FreeAndNil(LControleIntegrationKey) ;
  end ;
  Result := True ;
end;

procedure TfrmDominioSistemasProcessarDocumentos.pAjustaArrayEmpresas;
var
  LreqEmpresa: TConsultas ;
begin
  if (Length(FarrEmp) > 0) and (not Trim(FarrEmp[0].strCodigo).IsEmpty) then
    Exit ;

  SetLength(FarrEmp, 1);
  FillChar(LreqEmpresa, SizeOf(LreqEmpresa), #0);
  LreqEmpresa.strCodigo := edtCodEmp.Text ;
  FarrEmp[0] := LreqEmpresa ;
end;

procedure TfrmDominioSistemasProcessarDocumentos.pCarregaTiposNaTela;
var
  LCnt: TTipoDocumentoDominio ;
begin
  cklListaTipos.Items.Clear;
  for LCnt := Low(TTipoDocumentoDominio) to High(TTipoDocumentoDominio) do
    cklListaTipos.Items.Add(DESCRICAO_TIPO_DOCUMENTO[LCnt])
end;

procedure TfrmDominioSistemasProcessarDocumentos.pConsultaDadosLicenca;
var
  LToken: String ;
  LxIntregration: String ;
  LApi: IApiClient ;
  LInfoAtivacao: TInfoAtivacao ;
begin
  LToken := fRetornaAccessToken(VS_FuncoesExternas.fIRetEmpresaLogada) ;
  LxIntregration := fRetornaXIntegrationKey(VS_FuncoesExternas.fIRetEmpresaLogada) ;

  LApi := TAPIClient.Create(LToken, LxIntregration) ;
  try
    LInfoAtivacao := fConsultarAtivacaoCliente(LApi) ;
    lblContabilidade.Caption := Format('%s - %s', [LInfoAtivacao.accountantOfficeNationalIdentity, LInfoAtivacao.accountantOfficeName]) ;
    lblCliente.Caption := Format('%s - %s', [LInfoAtivacao.clientNationalIdentity, LInfoAtivacao.clientName]) ;
  Except
    on E: Exception do
    begin
      lblContabilidade.Caption := '' ;
      lblCliente.Caption := '' ;
    end ;
  end ;

end;

procedure TfrmDominioSistemasProcessarDocumentos.pConsultaStatusProcessamento(
                                          const AApi: IApiClient;
                                          const AListProc: TObjectList<TDOMPRO>;
                                          const AProgresso: TcxProgressBar;
                                          const ATipo: TTipoDocumentoDominio;
                                          const ACodEmp: String);
var
  LItemDomPro: TDOMPRO ;
  LStatusProcessamento: String ;
  LPosAtual: Integer ;
begin
  pSetaTextoProgresso(AProgresso, 'Consultando Status: ' + DESCRICAO_TIPO_DOCUMENTO[ATipo]  + #13#10 + 'Empresa: ' + ACodEmp );

  LPosAtual := 1 ;
  AProgresso.Properties.Max := AListProc.Count ;
  AProgresso.Position := 0 ;
  Application.ProcessMessages ;

  for LItemDomPro in AListProc do
  begin
    if not Trim(LItemDomPro.Protoc).IsEmpty then
    begin
      try
        LStatusProcessamento := fConsultarProtocoloDocumento(AApi, LItemDomPro.Protoc) ;
        LItemDomPro.Status := LStatusProcessamento ;
      except
        on ED: ExceptionDominio do
          LItemDomPro.Status := '998 - ' + ED.Message ;
        on E: Exception do
          LItemDomPro.Status := '999 - ' + E.Message ;
      end ;
    end ;

    AProgresso.Position := LPosAtual ;
    inc(LPosAtual) ;
    Application.ProcessMessages ;
  end ;
end;

procedure TfrmDominioSistemasProcessarDocumentos.btnConsultaClick(
  Sender: TObject);
var
  frmDominioSistemasConsultarDocumentos: TfrmDominioSistemasConsultarDocumentos;
begin
  frmDominioSistemasConsultarDocumentos := TfrmDominioSistemasConsultarDocumentos.Create(Self);
  Try
    frmDominioSistemasConsultarDocumentos.Showmodal;
  Finally
    VS_FuncoesExternas.pIFreeAndNil(frmDominioSistemasConsultarDocumentos);
  End;
end;

procedure TfrmDominioSistemasProcessarDocumentos.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, FarrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDominioSistemasProcessarDocumentos.fEmpresasComMesmaChaveIntegracao(
  AControleIntegrationKey: TDictionary<String, String>): string;
var
  Key, Empresa, ChaveIntegracao: string;
  EmpresasPorChave: TDictionary<String, TStringList>;
  EmpresasComChave: TStringList;
begin
  Result := '';

  EmpresasPorChave := TDictionary<String, TStringList>.Create;
  try
    for Key in AControleIntegrationKey.Keys do
    begin
      ChaveIntegracao := AControleIntegrationKey[Key];
      if not EmpresasPorChave.ContainsKey(ChaveIntegracao) then
        EmpresasPorChave.Add(ChaveIntegracao, TStringList.Create);

      EmpresasPorChave[ChaveIntegracao].Add(Key);
    end;

    for ChaveIntegracao in EmpresasPorChave.Keys do
    begin
      EmpresasComChave := EmpresasPorChave[ChaveIntegracao];

      if EmpresasComChave.Count > 1 then
      begin
        Result := Result + 'CFG_DOMXIK: ' + ChaveIntegracao + ' - Empresas: ';

        for Empresa in EmpresasComChave do
          Result := Result + Empresa + ', ';

        SetLength(Result, Length(Result) - 2);
        Result := Result + sLineBreak;
      end;
    end;
  finally
    for ChaveIntegracao in EmpresasPorChave.Keys do
      EmpresasPorChave[ChaveIntegracao].Free;
    EmpresasPorChave.Free;
  end;
end;

function TfrmDominioSistemasProcessarDocumentos.fIntegrarDocumentos(AProgresso: TcxProgressBar): Boolean;
var
  LToken: String ;
  LxIntregration: String ;
  LConsultaDocumentos: TDataSet ;
  LRetorno: String ;
  LApi: IApiClient ;
  LIntegrationKeyApp: String ;
  LParamDoc: TParamDocumento ;
  LTiposSelecionados: TTipoDocumentosDominio ;
  LTipo: TTipoDocumentoDominio ;
  LDtoList: TObjectList<TDOMPRO>;
  LDtoDomPro: TDOMPRO ;
  LPosAtual: Integer ;
  LintCnt: Integer ;
  LstrMensagemChaveInvalida: String;
begin
  inherited;
  Result := False ;

  LTiposSelecionados := fRetornaTiposSelecionados ;
  try
    for LintCnt := Low(FarrEmp) to High(FarrEmp) do
    begin
      LToken := fRetornaAccessToken(FarrEmp[LintCnt].strCodigo) ;
      LxIntregration := fRetornaXIntegrationKey(FarrEmp[LintCnt].strCodigo) ;

      LApi := TAPIClient.Create(LToken, LxIntregration) ;

      LIntegrationKeyApp := fGerarIntegrationKeyApp(LApi);
      if SameText(LIntegrationKeyApp, EmptyStr) then
      begin
        LstrMensagemChaveInvalida := Concat('A chave CFG_DOMXIK informada para a empresa:',
          FarrEmp[LintCnt].strCodigo, ' é inválida!');

        VS_FuncoesExternas.pIMensagemOk(LstrMensagemChaveInvalida);
        Continue;
      end;

      LApi.pSetIntegrationKeyApp(LIntegrationKeyApp);

      for LTipo in LTiposSelecionados do
      begin
        pSetaTextoProgresso(AProgresso, 'Integrando: ' + DESCRICAO_TIPO_DOCUMENTO[LTipo] + #13#10 + 'Empresa: ' + FarrEmp[LintCnt].strCodigo );

        LConsultaDocumentos := fListarDocumentos(LTipo, FarrEmp[LintCnt].strCodigo, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), '') ;
        LDtoList := TObjectList<TDOMPRO>.Create(True);
        try
          LPosAtual := 1 ;
          AProgresso.Properties.Max := LConsultaDocumentos.RecordCount ;
          AProgresso.Position := 0 ;
          Application.ProcessMessages ;

          LConsultaDocumentos.First ;
          while not LConsultaDocumentos.Eof do
          begin
            LDtoDomPro := TDOMPRO.Create ;
            try
              LDtoDomPro.CodEmp := LConsultaDocumentos.FieldByName('FIS_CODEMP').AsString ;
              LDtoDomPro.TipCon := ABREV_TIPO_DOCUMENTO[LTipo] ;
              LDtoDomPro.Acesso := LConsultaDocumentos.FieldByName('FIS_ACESSO').AsString ;
              LDtoDomPro.TipFC := LConsultaDocumentos.FieldByName('FIS_TIP_FC').AsString ;
              LDtoDomPro.CodOpe := VS_FuncoesExternas.fIRetOperadorLogado ;
              LDtoDomPro.DtProc := Date() ;
              LDtoDomPro.HrProc := Time() ;
              LDtoDomPro.DtaEnt := LConsultaDocumentos.FieldByName('FIS_DTAENT').AsDateTime ;
              LDtoDomPro.StatNf := LConsultaDocumentos.FieldByName('FIS_STATUS').AsString ;

              FillChar(LParamDoc, SizeOf(TParamDocumento), #0);
              LParamDoc.NumDoc := LConsultaDocumentos.FieldByName('FIS_NUMDOC').AsString ;
              LParamDoc.EspDoc := LConsultaDocumentos.FieldByName('FIS_ESPDOC').AsString ;
              LParamDoc.CodEmp := LConsultaDocumentos.FieldByName('FIS_CODEMP').AsString ;
              LParamDoc.Serie_ := LConsultaDocumentos.FieldByName('FIS_SERIE_').AsString ;
              LParamDoc.Tip_Fc := LConsultaDocumentos.FieldByName('FIS_TIP_FC').AsString ;
              LParamDoc.ForCli := LConsultaDocumentos.FieldByName('FIS_FORCLI').AsString ;
              LParamDoc.Acesso := LConsultaDocumentos.FieldByName('FIS_ACESSO').AsString ;
              LParamDoc.OriDoc := LConsultaDocumentos.FieldByName('FIS_ORIDOC').AsString ;
              LParamDoc.Status := LConsultaDocumentos.FieldByName('FIS_STATUS').AsString ;

              LRetorno := fProcessarDocumento(LTipo, LApi, LParamDoc) ;

              LDtoDomPro.Protoc := LRetorno ;
              LDtoList.Add(LDtoDomPro) ;

            except
              on EXml: ExceptionXmlNaoEncontrado do
              begin
                LDtoDomPro.Status := EXml.Message ;
                LDtoList.Add(LDtoDomPro) ;
              end ;
              on EChaveAcesso: ExceptionDocumentoSemChaveAcesso do
              begin
                LDtoDomPro.Acesso := EChaveAcesso.Message ;
                LDtoDomPro.Status := format('Documento sem Chave Acesso [%s]', [EChaveAcesso.Message]) ;
                LDtoList.Add(LDtoDomPro) ;
              end ;
              on ED: ExceptionDominio do
              begin
                LDtoDomPro.Status := ED.Message ;
                LDtoList.Add(LDtoDomPro) ;
              end ;
              on E: Exception do
              begin
                VS_FuncoesExternas.pIMensagensErro('Erro Interno: ' + E.Message, '') ;
                break ;
              end ;
            end ;

            AProgresso.Position := LPosAtual ;
            inc(LPosAtual) ;
            Application.ProcessMessages ;

            LConsultaDocumentos.Next ;
          end ;

          pConsultaStatusProcessamento(LApi, LDtoList, AProgresso, LTipo, FarrEmp[LintCnt].strCodigo) ;

          pSetaTextoProgresso(AProgresso, 'Gravando Status Processamento: ' + DESCRICAO_TIPO_DOCUMENTO[LTipo] + #13#10 + 'Empresa: ' + FarrEmp[LintCnt].strCodigo );
          AProgresso.Position := 0 ;
          Application.ProcessMessages ;
          pPersisteIntegracao(LDtoList) ;

          Result := True ;
        finally
          FreeAndNil(LConsultaDocumentos) ;
          FreeAndNil(LDtoList) ;
        end ;

      end ;

    end ;

    VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Integração Concluída com Sucesso!', ['&OK']);

  except
    on ESNE: ExceptionSelectNaoEncontrado do
      VS_FuncoesExternas.pIMensagemOk('Problemas ao recuperar select: ' + ESNE.Message);
    on ED: ExceptionDominio do
      VS_FuncoesExternas.pIMensagemOk('Problemas ao integrar documentos API: ' + ED.Message);
    on E: Exception do
      VS_FuncoesExternas.pIMensagensErro('Problemas ao integrar documentos: ' + E.Message, '');
  end ;
end;

procedure TfrmDominioSistemasProcessarDocumentos.pPersisteIntegracao(
  const AListProc: TObjectList<TDOMPRO>);
var
  LGravacaoEmLote: TDOMPRORepository ;
  LQry: TUniQuery ;
begin
  LQry := VS_FuncoesExternas.fICriaQuery() ;
  try
    LGravacaoEmLote := TDOMPRORepository.Create(Nil,
                                                LQry.Connection.Database,
                                                LQry.Connection.Username,
                                                LQry.Connection.Password,
                                                IntToStr(LQry.Connection.Port),
                                                LQry.Connection.Server);

    LGravacaoEmLote.fGravarEmBlocoNoBanco(AListProc) ;
  finally
    FreeAndNil(LQry) ;
    FreeAndNil(LGravacaoEmLote) ;
  end ;
end;

procedure TfrmDominioSistemasProcessarDocumentos.pSetaTextoProgresso(
  AProgresso: TcxProgressBar; ATexto: String);
var
  LComp: TComponent ;
  LParent: TCustomForm ;
begin
  if not Assigned(AProgresso) then
    Exit ;

  LParent := GetParentForm(AProgresso) ;

  if not Assigned(LParent) then
    Exit ;

  LComp := LParent.FindComponent('lblGravando') ;
  If LComp <> Nil Then
  Begin
    TLabel(LComp).Caption := ATexto;
    Application.ProcessMessages;
  End;
end;

end.
