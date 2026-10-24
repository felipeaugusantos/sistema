unit untRelComissaoVendedorManualCTR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, StrUtils, AppEvnts,
  UniDataSetProvider, DB, UniClientDataSet, untRelValorRecebido, ComboBoxFocus, Math,
  BitBtnLockedIncrem, untFuncoesSimples, Datasnap.Provider,
  frxExportCSVTestabilidade, Datasnap.DBClient, untFramePlanoDeContasMaskEdit;

type
  TfrmRelComissaoVendedorManualCTR = class(TfrmPaiRelatorio)
    frxComVenCTR_M: TfrxReport;
    frxCabecalho: TfrxUserDataSet;
    frxComVenCTR_J: TfrxReport;
    rdgTipRel: TRadioGroup;
    frxComVenSintCTR_M: TfrxReport;
    frxComVenSintCTR_J: TfrxReport;
    rdgTpVendRep: TRadioGroup;
    rdgPerCom: TRadioGroup;
    rdgComRes: TRadioGroup;
    frxComVenCTRP_J: TfrxReport;
    frxComVenCTRP_M: TfrxReport;
    grbRecibo: TGroupBox;
    Label5: TLabel;
    edtHisRec: TEditFocus;
    Label6: TLabel;
    mskDtaRec: TMaskEditFocus;
    Label7: TLabel;
    edtQtdVia: TEditFocus;
    frxUser: TfrxUserDataSet;
    chkConJur: TCheckBox;
    cdsRelatorio: TUniClientDataSet;
    dspRelatorio: TUniDataSetProvider;
    chkResumo: TCheckBox;
    frxResumo: TfrxDBDataset;
    rdgStatus: TRadioGroup;
    chkQueGer: TCheckBox;
    pnlServico: TPanel;
    rdgServicos: TRadioGroup;
    rdgPosCom: TRadioGroup;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblVendedor: TLabel;
    shpVen: TShape;
    lblOpcVen: TLabel;
    lblDepartamento: TLabel;
    lbl1: TLabel;
    shpGer: TShape;
    lbl2: TLabel;
    lbl3: TLabel;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    rdgRelEmp: TRadioGroup;
    cbxVenRep: TComboBoxFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    edtCodGerente: TEditFocus;
    edtDesGerente: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtCliExc: TEditFocus;
    edtDesExc: TEditFocus;
    mskDtaCor: TMaskEditFocus;
    pnlGerCom: TPanel;
    gpbGravaComi: TGroupBox;
    chkGraCom: TCheckBox;
    mskDtaVen: TMaskEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure frxCabecalhoGetValue(const VarName: String;
      var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rdgTipRelClick(Sender: TObject);
    procedure frxUserGetValue(const VarName: String; var Value: Variant);
    procedure frxUserFirst(Sender: TObject);
    procedure frxUserNext(Sender: TObject);
    procedure frxUserCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxUserPrior(Sender: TObject);
    function frxComVenCTR_MUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure mskDtaFinExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodGerenteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCliExcExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliExcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure chkGraComClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    frxRel: TfrxReport;
    strValRec: String;
    intQtdVia: Integer;

    qryVendedor   : TUniQuery;
    qryRelatorio  : TUniQuery;
    qryResumo     : TUniQuery;
    relRecebido   : TValorRecebido;

    blnLiberado: Boolean;
    blnLiberGer: Boolean;
    strCodVen  : String;
    strCodGer  : String;
    strCodDep  : String;
    strCodCli  : String;
    strCliExc  : String;
    strTipVen  : String;

    strPerComAna: String;
    strValComAna: String;

    strPerComVenAna: String;
    strValComVenAna: String;

    strPerComTotAna: String;
    strValComTotAna: String;

    strPerComVenSin: String;
    strValComVenSin: String;

    strPerComGer: String;
    strValComGer: String;

    strPerCo2VenSin: String;
    strPerCo2TotSin: String;

    strPerComTotSin: String;
    strValComTotSin: String;

    arrEmp     : TConsultasArray;
    arrOperador: TConsultasArray;
    arrGerente : TConsultasArray;
    arrDepart  : TConsultasArray;
    arrCliente : TConsultasArray;
    arrCliExc  : TConsultasArray;

    strEmp     : String;

    fltPmCmCr: Double;

    cdsResumoMod : TUniClientDataSet;

    function fGetSQLTotalAberto: String;
    function fGetSqlMovDet: String;
    function fGetSQLSintetico(strSQLAnalitico: String): String;
    function fGetSqlSinteticoMovDet(strAnalitico: String): String;

    procedure pVerdeVermelho(edtCodVen: TEditFocus; shaVen: TShape; blnLibera:Boolean);
    Procedure pSetaPeriodoRecibo;

    procedure pAjustaPercentualDeComissao;

    Procedure pSetaOperadorSintetico;
    Procedure pSetaOperadorAnalitico;

    Procedure pSetaPadraoSintetico;
    Procedure pSetaPadraoAnalitico;

    procedure pMontaResumoModalidades(qryAnalitico: TUniQuery);
    function fConcatConsultasArray(arrCons: TConsultasArray): String;

    procedure pSetaParametros(qryRel: TUniQuery; blnClaFis: boolean);

    procedure pGravaComissao(strSQL: String);
    procedure pCriaClientResumo;

    function  fGetSQL(strTabela: String; intNotSer: Integer; relRecebido: TValorRecebido): String;

  public
    { Public declarations }
    strEmpresa,
    strVendedor,
    strPeriodo: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

const
  VEN_TODOS           = 0;
  VEN_INTERNO         = 1;
  VEN_EXTERNO_LOJA    = 2;
  VEN_EXTERNO_DISTRIB = 3;
  
  TIPREL_ANALITICO = 0;
  TIPREL_SINTETICO = 1;

  POSCOM_TODAS = 0;
  POSCOM_PENDENTES = 1;
  POSCOM_BAIXADAS = 2;

implementation

uses untConsultas, untValorPorExtenso, untFuncoesConsulta,
     untCfgRel, untConstantes, untTGravaComissaoVen;

{$R *.dfm}

var
  arrVenRep: Array[0..4] Of String[20] = ('VENDEDOR', 'PARTICIPANTE 1', 'PROJETISTA 1', 'PARTICIPANTE 2', 'PROJETISTA 2');
  arrModalidade: Array[0..4] Of String[20] = ('DINHEIRO', 'CHEQUE','CARTAO', 'ORDEM', 'FINANCEIRO');

procedure TfrmRelComissaoVendedorManualCTR.edtCliExcExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCliExc.Text) Then
    edtDesExc.Text := 'NENHUM'
  Else
    pEdtCodSelectExit(edtCliExc, edtDesExc, arrCliExc, Nil, fRetNomCliente, 'do cliente a excluir');
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCliExcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCliExc, edtDesExc, Nil, Key, arrCliExc, False) Then
  Begin
    If fValidaCampos(edtCliExc, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCliente, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepart, fRetDescDepartamento, Nil, 'do departamento');
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodGerenteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if blnLiberGer then
    if fPesqOperador(Self, edtCodGerente, edtDesGerente, Nil, Key, arrGerente, False, False, True) then
      If fValidaCampos(edtCodGerente, True) Then
        SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelComissaoVendedorManualCTR.pVerdeVermelho(edtCodVen: TEditFocus; shaVen: TShape; blnLibera:Boolean);
Begin
  If (Not blnLibera) Then
  Begin
    edtCodVen.MaxLength := 10;
    edtCodVen.TamCampo  := 10;
    edtCodVen.CompZeros := False;
    edtCodVen.PasswordChar := '*';
    edtCodVen.TipoTexto := ttAlfanumerico;
    shaVen.Brush.Color  := clRed;
  End
  Else
  Begin
    shaVen.Brush.Color  := clGreen;
  End;
End;

function TfrmRelComissaoVendedorManualCTR.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intContador : Integer;
    intIndex : Integer;
begin

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
      If (Sender = mskDtaFin) Then
        Sender := mskDtaIni;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End
  Else If (Sender = edtCodVendedor) Then
  Begin

    If blnLiberado Then
    Begin
      If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin
        If edtCodVendedor.Text <> '000' Then
        Begin
          strCodVen           := edtCodVendedor.Text;
          edtDesVendedor.Text := fRetNomVendRep(strCodVen);

          If fEmptyStr(edtDesVendedor.Text) Then
          Begin
            Result := False;
            fMensagem('',IIF(fCfgSis('VENMET') = '1', 'Vendedor', 'Representante') + ' não encontrado.', ['&O K']);
          End;
        End
        Else If Not fEmptyStr(edtCodVendedor.Text) Then
        Begin
          strCodVen := '';
          For intContador := 0 To High(arrOperador) Do
          Begin
            If fEmptyStr(strCodVen) Then
              strCodVen := arrOperador[intContador].strCodigo
            Else
              strCodVen := strCodVen + '_' + arrOperador[intContador].strCodigo;
          End;
        End;

      End
      Else
      Begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      End;
    End
    Else
    Begin

      If (fEmptyStr(edtCodVendedor.Text)) Then
      Begin
        fMensagem('', 'O ' + IIF(fCfgSis('VENMET') = '1', 'Vendedor', 'Representante') + ' deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(fRetCodVendedor(edtCodVendedor.Text)) Then
        Begin
          fMensagem('', 'Nenhum operador encontrado com esta senha!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          blnLiberado := True;
          shpVen.Brush.Color := clGreen;
          edtCodVendedor.Text := fRetCodVendedor(edtCodVendedor.Text);
          edtDesVendedor.Text := fRetNomVendRep(edtCodVendedor.Text);
          edtCodVendedor.Enabled := False;
        End;

      End;

    End;

  End
  Else If (Sender = edtCodGerente) Then
  Begin

    If blnLiberGer Then
    Begin
      If Not fEmptyStr(edtCodGerente.Text) Then
      Begin
        If edtCodGerente.Text <> '000' Then
        Begin
          arrGerente         := Nil;        
          strCodGer          := edtCodGerente.Text;
          edtDesGerente.Text := fRetNomVendRep(strCodGer);

          If fEmptyStr(edtDesGerente.Text) Then
          Begin
            Result := False;
            fMensagem('','Gerente não encontrado.', ['&O K']);
          End;
        End
        Else If Not fEmptyStr(edtCodGerente.Text) Then
        Begin
          strCodGer := '';
          For intContador := 0 To High(arrGerente) Do
          Begin
            If fEmptyStr(strCodGer) Then
              strCodGer := arrGerente[intContador].strCodigo
            Else
              strCodGer := strCodGer + '_' + arrGerente[intContador].strCodigo;
          End;
        End;

      End
      Else
      Begin
        edtDesGerente.Text := 'TODOS';
        strCodGer := '';
      End;

    End
    Else
    Begin

      If (fEmptyStr(edtCodGerente.Text)) Then
      Begin
        fMensagem('', 'O gerente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(fRetCodVendedor(edtCodGerente.Text)) Then
        Begin
          fMensagem('', 'Nenhum gerente encontrado com esta senha!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          blnLiberGer := True;
          shpGer.Brush.Color := clGreen;
          edtCodGerente.Text := fRetCodVendedor(edtCodGerente.Text);
          edtDesGerente.Text := fRetNomVendRep(edtCodGerente.Text);
          edtCodGerente.Enabled := False;
        End;
      End;

    End;

  End

  Else If (Sender = edtCodDep) Then
  Begin

    If (fEmptyStr(edtCodDep.Text)) Then
      edtDesDep.Text := 'TODOS'
    Else
    Begin
      strCodDep := edtCodDep.Text;
      pDesmarcaLista(edtCodDep, arrDepart);
    end;
  End

  Else If (Sender = edtCodCli) Then
  Begin
    strCodCli := '';
    
    If (fEmptyStr(edtCodCli.Text)) Then
      edtDesCli.Text := 'TODOS'
    Else
    Begin
      pDesmarcaLista(edtCodCli, arrCliente);
      strCodCli := edtCodCli.Text;
    End;
  End

  Else If (Sender = edtCliExc) Then
  Begin
    strCliExc := '';
    
    If (fEmptyStr(edtCliExc.Text)) Then
      edtDesExc.Text := 'NENHUM'
    Else
    Begin
      pDesmarcaLista(edtCliExc, arrCliExc);
      strCliExc := edtCliExc.Text;
    End;
  End

  Else If (Sender = edtCodEmp) Then
  Begin

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin

      If (edtCodEmp.Text <> '000') Then
      Begin
        SetLength(arrEmp, 0);
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End
      Else If Length(arrEmp) > 0 Then
      Begin
        For intIndex := Low(arrEmp) To High(arrEmp) Do
        Begin
          If Pos(arrEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmp[intIndex].strCodigo + '!', ['&O k']);
            Result := False;
            Break;
          End;
        End;
      End
      Else
      Begin
        SetLength(arrEmp, 0);
        fMensagem('', 'Empresa Inválida', ['&OK']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtHisRec) And grbRecibo.Enabled Then
  Begin

    If fEmptyStr(edtHisRec.Text) Then
    Begin
      fMensagem('', 'O campo Histórico deve ser preenchido!', ['&O k']);
      Result := False;
    End;

  End

  Else If (Sender = mskDtaRec) And grbRecibo.Enabled Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaRec.Text)) Then
    Begin
      fMensagem('', 'O campo Data do Recibo deve ser preenchido!', ['&O k']);
      Result := False;
    End

  End

  Else If (Sender = edtQtdVia) And grbRecibo.Enabled Then
  Begin

    If StrToIntDef(edtQtdVia.Text, 0) <= 0 Then
    Begin
      fMensagem('', 'A quantidade de vias deve ser maior que zero!', ['&O k']);
      Result := False;
    End

  End

  Else If (Sender = mskDtaCor) Then
  Begin

    If fEmptyDate(mskDtaCor.Text) Then
    Begin
      pMensagemOk('"Data de corte para relatório de comissão" não preenchido em' + Chr(13) +
                  'Configuração do Sistema -> Contas a Receber.'   );
      Result := False;
    End;

  End

  Else If (Sender = fraPlanoDeContas.MskCodCta) Then
  Begin
    If (fraPlanoDeContas.MskCodCta.Enabled) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas deve ser preenchido!', ['&O k']);
        Result := False;
      End
      
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não encontrado!', ['&O k']);
          Result := False;
        End;

      End;
    End;
  End

  Else If (Sender = mskDtaVen) Then
  Begin
    If (mskDtaVen.Enabled) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Data de vencimento deve ser preenchida!', ['&O k']);
      End

      Else If StrToDateDef(mskDtaVen.Text, 0) = 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Digite uma data válida!', ['&O k']);
      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelComissaoVendedorManualCTR.edtCodVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if (blnLiberado) then
    if fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryVendedor, Key, arrOperador, False, False, False) then
      If fValidaCampos(edtCodVendedor, True) Then
        SelectNext(ActiveControl, True, True);
end;

Function TfrmRelComissaoVendedorManualCTR.fGetSQLSintetico(strSQLAnalitico: String): String;
Begin
  Result :=          ' SELECT SQL_NO_CACHE                       ';
  Result := Result + '  CTR_CODVEN,                              ';
  Result := Result + '   OPE_NOMOPE,                             ';
  Result := Result + '   IFNULL(OPE_PERCOM,0) AS OPE_PERCOM,     ';
  Result := Result + '   IFNULL(OPE_PERCO2,0) AS OPE_PERCO2,     ';
  Result := Result + '   OPE_INTEXT,                             ';
  Result := Result + '   0 AS CTR_VALFAT,                        ';
  Result := Result + '   VENDEDOR,                               ';
  Result := Result + '   0               AS CTR_ABERTO,          ';
  Result := Result + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  Result := Result + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  Result := Result + '   SUM(CTR_JURVIS) AS CTR_JURVIS,          ';
  Result := Result + '   SUM(CTR_JURPRA) AS CTR_JURPRA,          ';
  Result := Result + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  Result := Result + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  Result := Result + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  Result := Result + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';
  Result := Result + '   SUM(VLCOM_OPEAVI)   AS VLCOM_OPEAVI,    ';
  Result := Result + '   SUM(VLCOM_OPEAPR)   AS VLCOM_OPEAPR,    ';
  Result := Result + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO,  ';
  Result := Result + '   SUM(CTR_AVISTA) AS CTR_AVISTA,          ';
  Result := Result + '   SUM(CTR_APRAZO) AS CTR_APRAZO           ';
  Result := Result + ' FROM  (' + strSQLAnalitico + ') AS TABELA ';
  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    Result := Result + ' WHERE OPE_INTEXT = :INTEXT ';
  Result := Result + ' GROUP BY CTR_CODVEN ';
End;

Function TfrmRelComissaoVendedorManualCTR.fGetSqlTotalAberto: String;
  Var
    strSQL,
    strSum: String;
Begin
  strSQL := '';
  {***************************************************}
  {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
  {************************************************AC*}
  strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto('CADREC', rdgServicos.ItemIndex);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComConfirmacaoAberto('CADREC', 'CTRCNF', rdgServicos.ItemIndex);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO DIRETO                       *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDiretoAberto('CADREC', 'DUPAGR', rdgServicos.ItemIndex);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacaoAberto('CADREC',  'DUPAGR',  'CTRCNF', rdgServicos.ItemIndex);

  strSum := '';
  strSum := strSum + ' SELECT SQL_NO_CACHE              ';
  strSum := strSum + '   CTR_CODVEN,                    ';
  strSum := strSum + '   OPE_NOMOPE,                    ';
  strSum := strSum + '   OPE_PERCOM,                    ';
  strSum := strSum + '   OPE_PERCO2,                    ';
  strSum := strSum + '   OPE_INTEXT,                    ';
  strSum := strSum + '   0 AS CTR_VALFAT,               ';
  strSum := strSum + '   VENDEDOR,                      ';
  strSum := strSum + '   SUM(CTR_ABERTO) AS CTR_ABERTO, ';
  strSum := strSum + '   0 AS CTR_VALORI,               ';
  strSum := strSum + '   0 AS CTR_VALJUR,               ';
  strSum := strSum + '   0 AS CTR_JURVIS,               ';
  strSum := strSum + '   0 AS CTR_JURPRA,               ';
  strSum := strSum + '   0 AS CTR_VALDES,               ';
  strSum := strSum + '   0 AS CTR_VALREC,               ';
  strSum := strSum + '   0 AS CTR_RECCOM,               ';
  strSum := strSum + '   0 AS CTR_RECIPI,               ';
  strSum := strSum + '   0 AS VLCOM_OPEAVI,             ';
  strSum := strSum + '   0 AS VLCOM_OPEAPR,             ';
  strSum := strSum + '   0 AS VALOR_COMISSAO,           ';
  strSum := strSum + '   0 AS CTR_AVISTA,               ';
  strSum := strSum + '   0 AS CTR_APRAZO                ';
  strSum := strSum + ' FROM (' + strSQL + ') AS TABABE ';

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    strSum := strSum + ' WHERE OPE_INTEXT = :INTEXT ';

  strSum := strSum + ' GROUP BY CTR_CODVEN ';

  Result := strSum;
End;

Procedure TfrmRelComissaoVendedorManualCTR.pSetaOperadorSintetico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[frxRelatorio."OPE_PERCOM"]');

  TfrxMemoView(frxRel.FindObject('rllPerCo2Ven')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Ven')).Memo.Add('[frxRelatorio."OPE_PERCO2"]');

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add('[((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100) + ((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100)]');

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Clear;
  If relRecebido.blnConJur Then
  Begin
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100)) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]');
    TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100)) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]');
  End
  Else
  Begin
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100) - <frxRelatorio."CTR_JURVIS">) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]');
    TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100)) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]');
  End;

  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Memo.Clear;
  If relRecebido.blnConJur Then
  Begin
    TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_APRAZO">) <> 0, (SUM(((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100)) / SUM(<frxRelatorio."CTR_APRAZO">) ) * 100, 0)]');
    TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_APRAZO">) <> 0, (SUM(((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100)) / SUM(<frxRelatorio."CTR_APRAZO">) ) * 100, 0)]');
  End
  Else
  Begin
    TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_APRAZO">) <> 0, (SUM(((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100) - <frxRelatorio."CTR_JURPRA">) / SUM(<frxRelatorio."CTR_APRAZO">) ) * 100, 0)]');
    TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_APRAZO">) <> 0, (SUM(((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100) - <frxRelatorio."CTR_JURPRA">) / SUM(<frxRelatorio."CTR_APRAZO">) ) * 100, 0)]');
  End;

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100) + ((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100))]');

  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Add('[SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."OPE_PERCOM">)/100) + ((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."OPE_PERCO2">)/100))]');

  {**********************************************}
  {* COMISSÃO E VALORES RELACIONADOS AO GERENTE *}
  {*******************************************MM*}  
  if (chkQueGer.Checked) then
  Begin
    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Clear;
    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Add('[((SUM(<frxRelatorio."CTR_AVISTA">) * <frxRelatorio."PERGER">)/100) + ((SUM(<frxRelatorio."CTR_APRAZO">) * <frxRelatorio."PERGER">)/100)]');

    TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Clear;
    If relRecebido.blnConJur Then
      TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."PERGER">)/100)) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]')
    Else
      TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."PERGER">)/100) - <frxRelatorio."CTR_JURVIS">) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]');
  End;
End;

Procedure TfrmRelComissaoVendedorManualCTR.pSetaOperadorAnalitico;

    function fVistaPrazo: String;
    begin
      Result := 'IIF(<frxRelatorio."CTR_FORMAPG"> = ' + #39 + 'A' + #39 + ', <frxRelatorio."OPE_PERCOM">, <frxRelatorio."OPE_PERCO2">)';
    end;

    function fFrxCom: String;
    begin
      If relRecebido.blnConJur Then
        Result := '(' + fVistaPrazo + ' * <frxRelatorio."CTR_VALREC">) / 100'
      Else
        Result := '(' + fVistaPrazo + ' * (<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">))/ 100'
    end;

Begin
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Add('['+ fVistaPrazo +']');

  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Add('[' + fFrxCom + ']');

  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;

  If relRecebido.blnConJur Then
    TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC">) * 100]')
  Else
    TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add('[SUM(' + fFrxCom + ')]');

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  If relRecebido.blnConJur Then
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC">) * 100]')
  Else
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[SUM(' + fFrxCom + ')]');
End;

Procedure TfrmRelComissaoVendedorManualCTR.pSetaPadraoSintetico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tit')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Ven')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Visible := False;

  {**********************************************}
  {* COMISSÃO E VALORES RELACIONADOS AO GERENTE *}
  {*******************************************MM*}
  if (chkQueGer.Checked) then
  Begin
    TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Clear;
    TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Add(strPerComGer);

    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Clear;
    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Add(strValComGer);
  End;

  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add(strPerComVenSin);

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add(strValComVenSin);

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add(strPerComTotSin);

  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Add(strPerComTotSin);

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add(strValComTotSin);

  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Add(strValComTotSin);
End;

procedure TfrmRelComissaoVendedorManualCTR.pSetaParametros(qryRel: TUniQuery; blnClaFis: boolean);
begin
  With qryRel Do
  Begin
    If (Params.FindParam('DTAINI') <> Nil) Then
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);

    If (Params.FindParam('DTAFIM') <> Nil) Then
      ParamByName('DTAFIM').AsDateTime := StrToDate(mskDtaFin.Text);

    ParamByName('DTACOR').AsDateTime := StrToDate(mskDtaCor.Text);

    If Not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text,arrEmp,strEmp,'CODEMP',qryRel);

    pSetaParam(edtCodVendedor.Text,arrOperador,strCodVen,'CODVEN', qryRel);

    pSetaParam(edtCodGerente.Text,arrGerente,strCodGer,'CODGER', qryRel);

    pSetaParam(edtCodDep.Text, arrDepart, strCodDep, 'CODDEP', qryRel);

    pSetaParam(edtCodCli.Text, arrCliente, strCodCli, 'CODCLI', qryRel);

    pSetaParam(edtCliExc.Text, arrCliExc, strCliExc, 'CLIEXC', qryRel);

    If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
      ParamByName('INTEXT').AsString := strTipVen;

    If (rdgTipRel.ItemIndex = 1) And (blnClaFis) Then
    Begin
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
    End;
  End;
end;

Procedure TfrmRelComissaoVendedorManualCTR.pSetaPadraoAnalitico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Add(strPerComAna);

  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Add(strValComAna);

  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add(strPerComVenAna);

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add(strValComVenAna);

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add(strPerComTotAna);

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add(strValComTotAna);
End;

procedure TfrmRelComissaoVendedorManualCTR.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strDesTip: String;
    strSQLAna: String;
begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  relRecebido.blnConJur := chkConJur.Checked;
  relRecebido.strCodVen := strCodVen;
  relRecebido.strCodGer := strCodGer;
  relRecebido.strCodDep := strCodDep;
  relRecebido.blnUltPar := (fCfgSis('COMCTR', varString) = '2');
  relRecebido.intPosCom := rdgPosCom.ItemIndex;

  If fEmptyStr(edtCodEmp.Text) Then
    relRecebido.strCodEmp := ''
  Else If Length(arrEmp) > 0 Then
    relRecebido.strCodEmp := fConcatConsultasArray(arrEmp)
  Else
    relRecebido.strCodEmp := edtCodEmp.Text;

  relRecebido.strCodCli := strCodCli;
  relRecebido.strCliExc := strCliExc;
  relRecebido.relRelEmp := IIF(rdgRelEmp.ItemIndex = 0, reMovimentacao, reVendedor);

  Case rdgStatus.ItemIndex Of
    0: relRecebido.strStaVen := 'A';
    1: relRecebido.strStaVen := 'I';
    2: relRecebido.strStaVen := EmptyStr;
  End;

  Case cbxVenRep.ItemIndex Of
    0: relRecebido.opcVenRep := opVendedor;
    1: relRecebido.opcVenRep := opParticipante1;
    2: relRecebido.opcVenRep := opProjetista1;
    3: relRecebido.opcVenRep := opParticipante2;
    4: relRecebido.opcVenRep := opProjetista2;
  End;

  {*******************************************************}
  {**CONTROLA O FILTRO TIPO DE VENDEDOR OU REPRESENTANTE**}
  {**SE FOR 1 É INTERNO, 2 É EXTERNO                    **}
  {*****************************************************PZ}
  Case rdgTpVendRep.ItemIndex Of
    VEN_TODOS           : strDesTip := 'TODOS';
    VEN_INTERNO         : Begin strTipVen := 'I'; strDesTip := 'INTERNO'                 End;
    VEN_EXTERNO_LOJA    : Begin strTipVen := 'E'; strDesTip := 'REPRES. EXTERNO LOJA'    End;
    VEN_EXTERNO_DISTRIB : Begin strTipVen := 'D'; strDesTip := 'REPRES. EXTERNO DISTRIB' End;
  End;

  relRecebido.strTipVenRep := strTipVen;

  If fEmptyStr(strCodVen) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a senha para o Vendedor / Representante!', ['&Ok']);
  End;

  If blnImprime Then
  Begin

    {*******************************************}
    {* CABEÇALHO                               *}
    {****************************************AC*}
    If (Not fEmptyStr(edtCodEmp.Text)) Then
      strEmpresa := fStrTitulo(edtCodEmp.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA')
    Else
      strEmpresa := 'EMPRESA: ' + strEmpAcessoUsuarioLogado;

    If (Not fEmptyStr(strCodVen)) Then
      strVendedor := String(arrVenRep[cbxVenRep.ItemIndex]) + ': ' + strCodVen + ' - ' + edtDesVendedor.Text
    Else
      strVendedor := String(arrVenRep[cbxVenRep.ItemIndex]) + ': TODOS';

    strPeriodo := 'PERIODO DE: ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text));

    relRecebido.strDtaIni := mskDtaIni.Text;
    relRecebido.strDtaFim := mskDtaFin.Text;

    Try

      strSQL := '';
      {***********************************************************************}
      {* IRÁ PEGAR SOMENTE OS DOCUMENTOS DA CADREC - AUTORIZADO PELO RONALDO *}
      {* ALTERAÇÃO PARA O CLIENTE MONTE ALEGRE.                              *}
      {********************************************************************PZ*}
      strSQL := strSQL + fGetSql('CADREC', rdgServicos.ItemIndex, relRecebido);
      strSQL := strSQL + ' ORDER BY  ';
      strSQL := strSQL + '   CTR_CODVEN, ';

      If (relRecebido.blnUltPar) Then
      Begin
        strSQL := strSQL + '   CTR_NUMDUP, ';
        strSQL := strSQL + '   CTR_DTAREC  ';
      End
      Else
      Begin
        strSQL := strSQL + '   CTR_DTAREC, ';
        strSQL := strSQL + '   CTR_NUMDUP  ';
      end;

      strSQLAna := strSQL;

      If rdgTipRel.ItemIndex = 1 Then
        strSQL := fGetSqlSinteticoMovDet(strSQL);

      With qryRelatorio Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        pSetaParametros(qryRelatorio, True);
        Open;

        cdsResumoMod.EmptyDataSet;
        frxResumo.DataSet := cdsResumoMod;
        If (chkResumo.Checked) Then
        Begin
          If rdgTipRel.ItemIndex = 0 Then
            pMontaResumoModalidades(qryRelatorio)
          Else
          Begin
            qryResumo := fCriaQuery;
            qryResumo.Close;
            qryResumo.SQL.Clear;
            qryResumo.SQL.Add(strSQLAna);
            pSetaParametros(qryResumo, False);
            qryResumo.Open;
            pMontaResumoModalidades(qryResumo);
            FreeAndNil(qryResumo);
          End;
          frxResumo.Open;
        End;

        If Not IsEmpty Then
        Begin
          frxRelatorio.DataSet := qryRelatorio;

          pAjustaPercentualDeComissao;

          If rdgTipRel.ItemIndex in [0, 2] Then
          Begin

            If strTipImp = 'M' Then
            Begin
              If rdgComRes.ItemIndex = 0 Then
                frxRel := frxComVenCTRP_M
              Else
                frxRel := frxComVenCTR_M
            End
            Else
            Begin
              If rdgComRes.ItemIndex = 0 Then
                frxRel := frxComVenCTRP_J
              Else
                frxRel := frxComVenCTR_J;
            End;

            frxRel.AddFunction('Procedure pSetaTotalVendedor(strTotVen: String)');

            TfrxGroupHeader(frxRel.FindObject('GHComissao')).StartNewPage     := rdgTipRel.ItemIndex = 2;
            TfrxGroupHeader(frxRel.FindObject('GHComissao')).ResetPageNumbers := rdgTipRel.ItemIndex = 2;
            TfrxChild(frxRel.FindObject('CRecibo')).Visible                   := rdgTipRel.ItemIndex = 2;
            TfrxReportSummary(frxRel.FindObject('RSComissao')).Visible        := rdgTipRel.ItemIndex <> 2;
            TfrxPageFooter(frxRel.FindObject('PFComissao')).Visible           := rdgTipRel.ItemIndex <> 2;

            If rdgPerCom.ItemIndex = 1 Then
              pSetaOperadorAnalitico
            Else
              pSetaPadraoAnalitico;

          End
          Else
          Begin
            If strTipImp = 'M' Then
              frxRel := frxComVenSintCTR_M
            Else
              frxRel := frxComVenSintCTR_J;

            If rdgPerCom.ItemIndex = 1 Then
              pSetaOperadorSintetico
            Else
              pSetaPadraoSintetico;

            TfrxGroupHeader(frxRel.FindObject('rlbQuebra')).Condition := IIF(chkQueGer.Checked, 'frxRelatorio."CODGER"', 'frxRelatorio."VENDEDOR"');
            TfrxGroupHeader(frxRel.FindObject('rlbQuebra')).Visible   := chkQueGer.Checked;
            TfrxGroupFooter(frxRel.FindObject('rlbGrupo' )).Visible   := chkQueGer.Checked;
            TfrxMemoView(frxRel.FindObject('rllPerComGer')).Visible   := chkQueGer.Checked;
          End;

          TfrxChild(frxRel.FindObject('CResumo')).Visible := chkResumo.Checked;

          frxRel.PrintOptions.ShowDialog          := fEmptyStr(frxRel.PrintOptions.Printer);;
          frxRel.Script.Variables['VENDEDOR']     := arrVenRep[cbxVenRep.ItemIndex];
          frxRel.Script.Variables['TIPO']         :=  'TIPO DE ' + String(arrVenRep[cbxVenRep.ItemIndex]) + ': ' + strDesTip;
          frxRel.Script.Variables['CONJUR']       := relRecebido.blnConJur;
          frxrel.Script.Variables['STATUS']       := 'STATUS: ' + IIF(rdgStatus.ItemIndex = 0,'ATIVO',IIF(rdgStatus.ItemIndex = 1,'INATIVO','TODOS'));
          frxRel.Script.Variables['DEPARTAMENTO'] := IIF(fEmptyStr(strCodDep), 'DEPARTAMENTO: TODOS', 'DEPARTAMENTO: ' + strCodDep + ' - ' + edtDesDep.Text);
          frxRel.Script.Variables['GERENTE']      := fStrTitulo(edtCodGerente.Text,edtDesGerente,arrGerente,strCodGer,'GERENTE');
          frxRel.Script.Variables['CLIENTE']      := IIF(fEmptyStr(strCodCli), 'CLIENTE: TODOS', fStrTitulo(edtCodCli.Text, edtCodCli, arrCliente, strCodCli, 'CLIENTE'));
          frxRel.Script.Variables['CLIENTEEXC']   := IIF(fEmptyStr(strCliExc), 'CLIENTE EXCLUIR: NENHUM', fStrTitulo(edtCliExc.Text, edtCliExc, arrCliExc, strCliExc, 'CLIENTE EXCLUIR'));

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frxRel)
          Else
          Begin
            If frxRel.PrepareReport Then
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
          End;

          If chkGraCom.Checked Then
          Begin
            If fMensagem('', 'Deseja gravar a comissão?', ['&Sim','&Não']) = 1 Then
              pGravaComissao(strSQLAna);
          End;

        End
        Else
          fMensagem('Informação', 'Não há dados para gerar o relatório!', ['&Ok']);

      End;

    Finally
    End;

    pSetFocus(mskDtaIni);
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
end;

procedure TfrmRelComissaoVendedorManualCTR.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelComissaoVendedorManualCTR.frxCabecalhoGetValue(
  const VarName: String; var Value: Variant);
begin
  inherited;

  If SameText('EMPRESA',VarName) Then
    Value := strEmpresa

  Else If SameText('VENDEDOR',VarName) Then
    Value := strVendedor

  Else If SameText('PERIODO',VarName) Then
    Value := strPeriodo

end;

procedure TfrmRelComissaoVendedorManualCTR.FormShow(Sender: TObject);
  Var
    dtaCorte : TDate;
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  blnLiberado := fVerificaAcessoSistema('RFATCV');
  blnLiberGer := fVerificaAcessoSistema('RFATCG');

  strCodVen := '';
  pVerdeVermelho(edtCodVendedor, shpVen, blnLiberado);
  pVerdeVermelho(edtCodGerente, shpGer, blnLiberGer);  

  mskDtaRec.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;

  shpMultSel.Visible := True;

  dtaCorte := fCfgSis('DTCOCR', varDate);

  If dtaCorte = 0 Then
    mskDtaCor.Clear
  Else
    mskDtaCor.Text := FormatDateTime('dd/mm/yyyy', dtaCorte);

  {  VERIFICA SE GERA COMISSÃO A CADA VENDA OU NÃO, CASO NÃO, pnlMeio fica visível }
  if (fCfgSis('GCCVEN') = 'S') then
    pnlGerCom.Visible := False;

  if (Not pnlGerCom.Visible  ) then
    Self.ClientHeight := Self.ClientHeight - pnlGerCom.Height;

end;

function TfrmRelComissaoVendedorManualCTR.fConcatConsultasArray(
  arrCons: TConsultasArray): String;
  Var
    intCnt : Integer;
begin
  If Length(arrCons) > 0 Then
  Begin
    Result := '';
    For intCnt := Low(arrCons) to High(arrCons) Do
      Result := Result + arrCons[intCnt].strCodigo + '_';
  End
  Else
    Result := '';
end;

function TfrmRelComissaoVendedorManualCTR.fGetSQL(strTabela: String; intNotSer: Integer; relRecebido: TValorRecebido): String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                         ';
  strSQL := strSQL + '   "DIRETA" AS MODALIDADE,                   ';
  strSQL := strSQL + '   ' + relRecebido.fGetVenDig('REC.') + ' AS CTR_CODVEN, ';
  strSQL := strSQL + '   V.OPE_NOMOPE,                               ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCOM, 0) AS OPE_PERCOM,      ';
  strSQL := strSQL + '   IFNULL(V.OPE_PERCO2, 0) AS OPE_PERCO2,      ';
  strSQL := strSQL + '   V.OPE_INTEXT,                               ';
  strSQL := strSQL + '   REC.CTR_ESPDOC,                           ';
  strSQL := strSQL + '   CONCAT(' + relRecebido.fGetVenDig('REC.') + '," - ",V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   REC.CTR_DTACAD,                           ';
  strSQL := strSQL + '   REC.CTR_DTAREC,                           ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP) AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CONCAT(REC.CTR_CODCLI,"-",CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_SEQBAI = 0, REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0) + IFNULL(REC.CTR_VALDES,0), REC.CTR_VALORI)) AS CTR_VALORI, ';
  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALJUR,0)) AS CTR_VALJUR, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, IFNULL(REC.CTR_VALJUR,0), 0)) AS CTR_JURVIS, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC, 0, IFNULL(REC.CTR_VALJUR,0))) AS CTR_JURPRA, ';

  strSQL := strSQL + '   SUM(IFNULL(REC.CTR_VALDES,0)) AS CTR_VALDES, ';
  strSQL := strSQL + '   SUM(REC.CTR_VALREC) AS CTR_VALREC,           ';

  If relRecebido.blnConJur Then
    strSQL := strSQL + '   SUM(REC.CTR_VALREC) AS CTR_RECCOM, '
  Else
    strSQL := strSQL + '   SUM(REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) AS CTR_RECCOM, ';

  strSQL := strSQL + '   SUM(REC.CTR_VALREC - IFNULL(REC.CTR_VALIPI,0) - IFNULL(REC.CTR_VALRET,0) - IFNULL(REC.CTR_VALCBS,0) - IFNULL(REC.CTR_VALIBS,0) - IFNULL(REC.CTR_VAL_IS,0) - IFNULL(REC.CTR_VALACE,0) - IFNULL(REC.CTR_VALFRE,0)) AS CTR_RECIPI, ';

  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.CTR_VALREC,0)) AS CTR_AVISTA, ';
  strSQL := strSQL + '   SUM(IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.CTR_VALREC)) AS CTR_APRAZO, ';
  strSQL := strSQL + '   IF(REC.CTR_DTACAD = REC.CTR_DTAREC,"A","P") AS CTR_FORMAPG,              ';

  If relRecebido.opcVenRep in [opSupGeral, opSupRegional] Then
  Begin
    If relRecebido.blnConJur Then
    Begin
      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,V.OPE_PERCOM,0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,V.OPE_PERCO2))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (V.OPE_PERCOM / 100)) AS VALOR_COMISSAO, ';
    End;
  End Else
  Begin
    If relRecebido.blnConJur Then
    Begin
      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + relRecebido.fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM(REC.CTR_VALREC * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + relRecebido.fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM(REC.CTR_VALREC * REC.' + relRecebido.fGetFatCom + ') AS VALOR_COMISSAO, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,REC.' + relRecebido.fGetFatCom + ',0))) AS VLCOM_OPEAVI, ';
      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * (IF(REC.CTR_DTACAD = REC.CTR_DTAREC,0,REC.' + relRecebido.fGetFatCom + '))) AS VLCOM_OPEAPR, ';

      strSQL := strSQL + '   SUM((REC.CTR_VALREC - IFNULL(REC.CTR_VALJUR,0)) * REC.' + relRecebido.fGetFatCom + ') AS VALOR_COMISSAO, ';
    End;
  End;

  strSQL := strSQL + '   "" AS DOCUME,           ';

  strSQL := strSQL + '   REC.CTR_DTACAD AS DATA, ';
  strSQL := strSQL + '   REC.CTR_CODCLI,         ';
  strSQL := strSQL + '   REC.CTR_CODEMP,         ';

  {************************************}
  {* CAMPOS PARA                      *}
  {* RESUMO POR MODALIDADE            *}
  {********************************MM**}
  strSQL := strSQL + '   SUM(REC.CTR_DINHEI) AS DINHEI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQAVI) AS CHQAVI,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CHQPRE) AS CHQPRE,  ';
  strSQL := strSQL + '   SUM(REC.CTR_CARTAO) AS CARTAO,  ';
  strSQL := strSQL + '   SUM(REC.CTR_ORDPAG) AS ORDPAG,  ';
  strSQL := strSQL + '   SUM(REC.CTR_VALFIN) AS VALFIN,  ';

  strSQL := strSQL + '   "' + strtabela + '" TABCTR ';

  strSQL := strSQL + '   FROM ' + strTabela + ' REC ';

  strSQL := strSQL + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = ' + relRecebido.fGetVenDig('REC.');

  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = REC.CTR_CODCLI ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + relRecebido.fRetFiltroCliente;

  strSQL := strSQL + '    REC.CTR_DTACAD >= :DTACOR AND ';
  strSQL := strSQL + '    REC.CTR_ESPDOC <> "CC"        ';

  Case intNotSer of
    0 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC = "NS" ';// Somente Notas de Serviço
    1 :  strSQL := strSQL + '  AND  REC.CTR_ESPDOC <> "NS" ';// Exeto Notas de Serviço
  End;

  {*********************************************************************}
  {* VERIFICA SE FILTRA POR DATA DE RECEBIMENTO DA ULTIMA PARCELA PAGA *}
  {******************************************************************PZ*}
  strSQL := strSQL + '  AND (' + relRecebido.fRetFiltroData(strTabela) + ') ';

  If (Not fEmptyStr(relRecebido.strCodEmp)) Then
  Begin
    If relRecebido.relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP, :CODEMP) > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP, :CODEMP) > 0 ';
  End
  Else
  Begin
    If relRecebido.relRelEmp = reVendedor Then
      strSQL := strSQL + '  AND LOCATE(V.OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(REC.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If (Not fEmptyStr(strCodVen)) Then
    strSQL := strSQL + '  AND LOCATE(' + relRecebido.fGetVenDig('REC.') + ', :CODVEN) > 0 ';

  If (Not fEmptyStr(strCodGer)) Then
    strSQL := strSQL + '  AND (LOCATE(V.OPE_CODGER,:CODGER) > 0) '+
                       '  AND (IFNULL(V.OPE_CODGER,"") <> "")    ';

  If (Not fEmptyStr(strCodDep)) Then
    strSQL := strSQL + '  AND V.OPE_CODDEP = :CODDEP ';

  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CODCLI) > 0 ';

  If (Not fEmptyStr(strCliExc)) Then
    strSQL := strSQL + '  AND LOCATE(CLI_CODCLI, :CLIEXC) <= 0';

  If (Not fEmptyStr(relRecebido.strStaVen)) Then
    strSQL := strSQL + '  AND V.OPE_STATUS = "' +relRecebido.strStaVen+ '" ';

  If (Not fEmptyStr(relRecebido.strTipVenRep)) Then
    strSQL := strSQL + '  AND V.OPE_INTEXT = :INTEXT ';

  Case relRecebido.intPosCom Of
    POSCOM_PENDENTES : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NULL ';
    POSCOM_BAIXADAS  : strSQL := strSQL + '  AND REC.CTR_CTPCOM IS NOT NULL ';
  End;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   CONCAT(' + relRecebido.fGetVenDig('REC.') + '," - ",V.OPE_NOMOPE),                             ';
  strSQL := strSQL + '   CONCAT(REC.CTR_NUMDUP,"-",REC.CTR_PARCEL,"-",REC.CTR_ESPDOC,"-",REC.CTR_CODEMP), ';
  strSQL := strSQL + '   DOCUME,                                                                          ';
  strSQL := strSQL + '   REC.CTR_DTAREC                                                                   ';

  Result := strSQL;
end;

Function TfrmRelComissaoVendedorManualCTR.fGetSqlMovDet: String;

  function fGetSql(strTabela: String): String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   ' + relRecebido.fGetVenDigDet + ', ';
    strSQL := strSQL + '   SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTITE ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   ' + strTabela + ' ';

    If cbxVenRep.ItemIndex in [2, 3, 4] Then  // SUPEVISOR GERAL/REGIONAL OU VENDCADCLI
      strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';

    strSQL := strSQL + ' INNER JOIN CADOPE ON OPE_CODOPE = ' + relRecebido.fGetVenDigDet;

    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '   DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '   DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '   DET_DTAENT BETWEEN :DTAINI AND :DTAFIM   AND ';
    strSQL := strSQL + '   DET_ESPDOC NOT IN ("")                   AND ';

    Case rdgServicos.ItemIndex of
      0 :  strSQL := strSQL + '  DET_ESPDOC = "NS" AND ';// Somente Notas de Serviço
      1 :  strSQL := strSQL + '  DET_ESPDOC <> "NS" AND ';// Exeto Notas de Serviço
    End;    

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';
    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If rdgRelEmp.ItemIndex = 1 Then
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp,  'OPE_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp,  'DET_CODEMP', 'CODEMP');
    End
    Else
    Begin
      If rdgRelEmp.ItemIndex = 1 Then
        strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
      Else
        strSQL := strSQL + '    AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    If (Not fEmptyStr(edtCodVendedor.Text)) Then
    Begin
      Case cbxVenRep.ItemIndex Of
        0: strSQL := strSQL + fStrLocate(edtCodVendedor,  arrOperador,  'DET_CODVEN', 'CODVEN');
        1: strSQL := strSQL + fStrLocate(edtCodVendedor,  arrOperador,  'DET_CODREP', 'CODVEN');
        2: strSQL := strSQL + fStrLocate(edtCodVendedor,  arrOperador,  'CLI_SUPGER', 'CODVEN');
        3: strSQL := strSQL + fStrLocate(edtCodVendedor,  arrOperador,  'CLI_SUPREG', 'CODVEN');
        4: strSQL := strSQL + fStrLocate(edtCodVendedor,  arrOperador,  'CLI_CODVEN', 'CODVEN');
        5: strSQL := strSQL + fStrLocate(edtCodVendedor,  arrOperador,  'DET_CODDIG', 'CODVEN');
      End;
    End;

    If (Not fEmptyStr(edtCodGerente.Text)) Then
    Begin
      strSQL := strSQL + '  AND (LOCATE(OPE_CODGER,:CODGER) > 0) '+
                         '  AND (IFNULL(OPE_CODGER,"") <> "")    ';
    End;

    If (Not fEmptyStr(relRecebido.strStaVen)) Then
      strSQL := strSQL + '  AND OPE_STATUS = "' +relRecebido.strStaVen+ '" ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  ' + relRecebido.fGetVenDigDet;

    Result := strSQL;
  End;

Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE         ';
  Result := Result + '   ' + relRecebido.fGetVenDigDet + ' AS CTR_CODVEN,  ';
  Result := Result + '   OPE_NOMOPE,                           ';
  Result := Result + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,  ';
  Result := Result + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,  ';
  Result := Result + '   OPE_INTEXT,                           ';
  Result := Result + '   SUM(TOTITE) AS CTR_VALFAT,';
  Result := Result + '   CONCAT(' + relRecebido.fGetVenDigDet + '," - ",OPE_NOMOPE) AS VENDEDOR, ';
  Result := Result + '   0 AS CTR_ABERTO,          ';
  Result := Result + '   0 AS CTR_VALORI,          ';
  Result := Result + '   0 AS CTR_VALJUR,          ';
  Result := Result + '   0 AS CTR_JURVIS,          ';
  Result := Result + '   0 AS CTR_JURPRA,          ';
  Result := Result + '   0 AS CTR_VALDES,          ';
  Result := Result + '   0 AS CTR_VALREC,          ';
  Result := Result + '   0 AS CTR_RECCOM,          ';
  Result := Result + '   0 AS CTR_RECIPI,          ';
  Result := Result + '   0 AS VLCOM_OPEAVI,        ';
  Result := Result + '   0 AS VLCOM_OPEAPR,        ';
  Result := Result + '   0 AS VALOR_COMISSAO,      ';
  Result := Result + '   0 AS CTR_AVISTA,          ';
  Result := Result + '   0 AS CTR_APRAZO           ';
  Result := Result + ' FROM ( ';
  Result := Result + fGetSql('MOVDET');
  Result := Result + ') AS TABDET ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = ' + relRecebido.fGetVenDigDet;

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    Result := Result + ' WHERE OPE_INTEXT = :INTEXT ';

  Result := Result + ' GROUP BY ';
  Result := Result + relRecebido.fGetVenDigDet;
End;

Function TfrmRelComissaoVendedorManualCTR.fGetSqlSinteticoMovDet(strAnalitico: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                       ';

  if (chkQueGer.Checked) then
  Begin
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,               ';
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,               ';
    strSQL := strSQL + '   G.OPE_COMCFA AS PERGER,               ';
  End;

  strSQL := strSQL + '   CTR_CODVEN,                             ';
  strSQL := strSQL + '   T.OPE_NOMOPE,                           ';
  strSQL := strSQL + '   T.OPE_PERCOM,                           ';
  strSQL := strSQL + '   T.OPE_PERCO2,                           ';
  strSQL := strSQL + '   T.OPE_INTEXT,                           ';
  strSQL := strSQL + '   SUM(CTR_VALFAT) AS CTR_VALFAT,          ';
  strSQL := strSQL + '   VENDEDOR,                               ';
  strSQL := strSQL + '   SUM(CTR_ABERTO) AS CTR_ABERTO,          ';
  strSQL := strSQL + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  strSQL := strSQL + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  strSQL := strSQL + '   SUM(CTR_JURVIS) AS CTR_JURVIS,          ';
  strSQL := strSQL + '   SUM(CTR_JURPRA) AS CTR_JURPRA,          ';
  strSQL := strSQL + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  strSQL := strSQL + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  strSQL := strSQL + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  strSQL := strSQL + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';

  If rdgPerCom.ItemIndex = 0 Then
    strSQL := strSQL + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO, '
  Else
    strSQL := strSQL + '   SUM(VLCOM_OPEAVI+VLCOM_OPEAPR) AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   SUM(VLCOM_OPEAVI) AS VLCOM_OPEAVI,  ';
  strSQL := strSQL + '   SUM(VLCOM_OPEAPR) AS VLCOM_OPEAPR,  ';
  strSQL := strSQL + '   SUM(CTR_AVISTA)   AS CTR_AVISTA,    ';
  strSQL := strSQL + '   SUM(CTR_APRAZO)   AS CTR_APRAZO     ';

  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + fGetSQLSintetico(strAnalitico) + ' UNION ALL ' +
                     fGetSqlMovDet + ' UNION ALL ' +
                     fGetSQLTotalAberto;

  strSQL := strSQL + ' ) AS T ';

  if (chkQueGer.Checked) then
  Begin
    strSQL := strSQL + ' LEFT  JOIN CADOPE G ON G.OPE_CODOPE = (SELECT OPE_CODGER FROM CADOPE WHERE OPE_CODOPE = T.CTR_CODVEN) ';
  End;

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    Result := Result + ' WHERE OPE_INTEXT = :INTEXT ';

  if (chkQueGer.Checked) then
  Begin
    strSQL := strSQL + ' GROUP BY CTR_CODVEN, NOMGER ';
    strSQL := strSQL + ' ORDER BY NOMGER, T.OPE_NOMOPE ';
  End
  Else
  Begin
    strSQL := strSQL + ' GROUP BY CTR_CODVEN ';
    strSQL := strSQL + ' ORDER BY OPE_NOMOPE ';
  End;

  If chkGraCom.Checked Then
    strSQL := 'SELECT * FROM ('+ strSQL +') TAB WHERE ROUND(VALOR_COMISSAO, 2) <> 0';

  Result := strSQL;
End;

procedure TfrmRelComissaoVendedorManualCTR.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelComissaoVendedorManualCTR.FormCreate(Sender: TObject);
begin
  inherited;
  qryRelatorio   := fCriaQuery;
  qryVendedor    := fCriaQuery;
  relRecebido    := TValorRecebido.Create;

  strPerComAna    := TfrxMemoView(frxComVenCTR_J.FindObject('rllPerComAna')).Memo.Text;
  strValComAna    := TfrxMemoView(frxComVenCTR_J.FindObject('rllValComAna')).Memo.Text;
  strPerComVenAna := TfrxMemoView(frxComVenCTR_J.FindObject('rllPerComVen')).Memo.Text;
  strValComVenAna := TfrxMemoView(frxComVenCTR_J.FindObject('rllValComVen')).Memo.Text;
  strPerComTotAna := TfrxMemoView(frxComVenCTR_J.FindObject('rllPerComTot')).Memo.Text;
  strValComTotAna := TfrxMemoView(frxComVenCTR_J.FindObject('rllValComTot')).Memo.Text;

  strPerComGer    := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllPerComGer')).Memo.Text;
  strValComGer    := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllValComGer')).Memo.Text;
  strPerComVenSin := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllPerComVen')).Memo.Text;
  strPerCo2VenSin := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllPerCo2Ven')).Memo.Text;
  strValComVenSin := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllValComVen')).Memo.Text;
  strPerComTotSin := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllPerComTot')).Memo.Text;
  strPerCo2TotSin := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllPerCo2Tot')).Memo.Text;
  strValComTotSin := TfrxMemoView(frxComVenSintCTR_J.FindObject('rllValComTot')).Memo.Text;

  fltPmCmCr := fCfgSis('PMCMCR', varDouble);  

  pCriaClientResumo;

  pnlServico.Visible := fCfgSis('USASER', varBoolean);

  if not pnlServico.Visible Then
    Self.Height := Self.Height - pnlServico.Height;
end;

procedure TfrmRelComissaoVendedorManualCTR.FormDestroy(Sender: TObject);
begin
  inherited;
  qryVendedor.Close;
  qryRelatorio.Close;
  cdsResumoMod.Close;

  FreeAndNil(qryVendedor);
  FreeAndNil(qryRelatorio);
  FreeAndNil(relRecebido);
  FreeAndNil(cdsResumoMod);
end;

procedure TfrmRelComissaoVendedorManualCTR.chkGraComClick(Sender: TObject);
begin
  inherited;

  fraPlanoDeContas.MskCodCta.Enabled := chkGraCom.Checked;
  mskDtaVen.Enabled := chkGraCom.Checked;

  // Se for gravar comissão, exibe apenas no vídeo, e sintético
  edtDestino.Enabled := Not chkGraCom.Checked;
  rdgTipRel.Enabled := Not chkGraCom.Checked;
  rdgPosCom.Enabled := Not chkGraCom.Checked;
  If chkGraCom.Checked Then
  Begin
    edtDestino.Text := 'V';
    rdgTipRel.ItemIndex := TIPREL_SINTETICO;
    rdgPosCom.ItemIndex := POSCOM_PENDENTES;
  End
  Else
  Begin
    fraPlanoDeContas.MskCodCta.Clear;
    fraPlanoDeContas.edtDesCta.Clear;
    mskDtaVen.Clear;
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.rdgTipRelClick(Sender: TObject);
begin
  inherited;

  rdgComRes.Enabled := rdgTipRel.ItemIndex <> 1;

  If Not rdgComRes.Enabled Then
    rdgComRes.ItemIndex := 1;

  grbRecibo.Enabled := rdgTipRel.ItemIndex = 2;

  //chkResumo.Checked := Not (rdgTipRel.ItemIndex = 2);
  chkResumo.Enabled := Not (rdgTipRel.ItemIndex = 2);

  chkQueGer.Enabled := (rdgTipRel.ItemIndex = 1);
  chkQueGer.Checked := IIF(rdgTipRel.ItemIndex = 1,chkQueGer.Checked,False);

  pSetaPeriodoRecibo;
end;

procedure TfrmRelComissaoVendedorManualCTR.frxUserGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If SameText('DTAREC', VarName) Then
    Value := fRetDataExtenso(StrToDate(mskDtaRec.Text), True)

  Else If SameText('VALREC', VarName) Then
    Value := fStrToFloat(strValRec)

  Else If SameText('NOMREC', VarName) Then
    Value := fRetNomeEmpresa

  Else If SameText('NOMASS', VarName) Then
    Value := qryRelatorio.FieldByName('OPE_NOMOPE').AsString

  Else If SameText('HISREC', VarName) Then
    Value := edtHisRec.Text

  Else If SameText('NROVIA', VarName) Then
    Value := intQtdVia

  Else If SameText('VLREXT', VarName) Then
    Value := UpperCase(fRetExtensoNumero(strValRec));

end;

procedure TfrmRelComissaoVendedorManualCTR.frxUserFirst(Sender: TObject);
begin
  inherited;
  intQtdVia := 1;
end;

procedure TfrmRelComissaoVendedorManualCTR.frxUserNext(Sender: TObject);
begin
  inherited;
  inc(intQtdVia);
end;

procedure TfrmRelComissaoVendedorManualCTR.frxUserCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;

  Eof := intQtdVia > StrToIntDef(edtQtdVia.Text, 0);

  If Eof Then
  Begin
    TfrxChild(frxRel.FindObject('CHeader')).Visible := True;
    TfrxPageHeader(frxRel.FindObject('PageHeader')).Visible := True;
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.frxUserPrior(Sender: TObject);
begin
  inherited;
  Dec(intQtdVia);
end;

function TfrmRelComissaoVendedorManualCTR.frxComVenCTR_MUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;
  If SameText(MethodName, 'pSetaTotalVendedor') Then
    strValRec := FloatToStr(fStrToFloat(Trim(Params[0])))
end;

Procedure TfrmRelComissaoVendedorManualCTR.pSetaPeriodoRecibo;
Begin
  If rdgTipRel.ItemIndex = 2 Then
    edtHisRec.Text := 'A COMISSAO DO PERIODO DE ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text))
  Else
    edtHisRec.Text := '';
End;

procedure TfrmRelComissaoVendedorManualCTR.mskDtaFinExit(Sender: TObject);
begin
  inherited;
  pSetaPeriodoRecibo;
end;

{*****************************************}
{* AJUSTA O PERCENTUAL DE COMISSÃO PARA  *}
{* NÃO ULTRAPASSAR O VALOR CONFIGURADO.  *}
{**************************************MV*}
procedure TfrmRelComissaoVendedorManualCTR.pAjustaPercentualDeComissao;
  Var
    fltPerCom: Double;
    fltNovaComissao: Double;
    intContador: Integer;
begin

  Try

    If (fltPmCmCr > 0) And (rdgPerCom.ItemIndex = 0) Then
    Begin
      qryRelatorio.Close;
      qryRelatorio.Open;

      pSetaClient(qryRelatorio);
      
      cdsRelatorio.Close;
      dspRelatorio.DataSet := qryRelatorio;
      cdsRelatorio.SetProvider(dspRelatorio);
      cdsRelatorio.Open;

      For intContador := 0 To cdsRelatorio.FieldCount -1 Do
      Begin
        cdsRelatorio.Fields[intContador].Required := False;
      End;

      cdsRelatorio.First;
      While (Not cdsRelatorio.Eof) Do
      Begin
        If (cdsRelatorio.FieldByName('CTR_RECCOM').AsFloat <> 0) Then
        Begin
          fltPerCom := cdsRelatorio.FieldByName('VALOR_COMISSAO').AsFloat /
                       cdsRelatorio.FieldByName('CTR_RECCOM').AsFloat * 100;

          fltPerCom := fFormataFloat(fltPerCom, 6);

          {*****************************************}
          {* RECALCULA O CAMPO "CTR_RECCOM", POIS  *}
          {* ASSIM NÃO PRECISA MUDAR O RESTANTE DO *}
          {* RELATÓRIO.                            *}
          {**************************************MV*}
          If (fltPerCom > fltPmCmCr) Then
          Begin
            fltPerCom := fltPmCmCr;
            fltNovaComissao := fFormataFloat(cdsRelatorio.FieldByName('CTR_VALREC').AsFloat * fltPerCom / 100, 6);

            cdsRelatorio.Edit;
            cdsRelatorio.FieldByName('VALOR_COMISSAO').AsFloat := fltNovaComissao;
            cdsRelatorio.Post;
          End;
        End;

        cdsRelatorio.Next;
      End;

      frxRelatorio.DataSet := cdsRelatorio;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaPercentualDeComissao]');
    End;
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.pCriaClientResumo;
begin
  {****************************************}
  {* CRIA CLIENTDATASET USADO NO RESUMO   *}
  {*************************************MM*}
  cdsResumoMod                  := TUniClientDataSet.Create(Self);
  cdsResumoMod.AggregatesActive := True;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_NOMVEN';
    DataType := ftString;
    Size := 30;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_DESMOD';
    DataType := ftString;
    Size := 20;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_COMIMP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_SEMIMP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_VALCOM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_TOTCOM';
    DataType := ftFloat;
    Required := False;
  End;

  cdsResumoMod.CreateDataSet;
  cdsResumoMod.IndexFieldNames := 'RMO_NOMVEN';
end;

procedure TfrmRelComissaoVendedorManualCTR.pMontaResumoModalidades(
  qryAnalitico: TUniQuery);
  Var
    intContador : Integer;
    fltDinRec,
    fltChqRec,
    fltCarRec,
    fltOrdRec,
    fltFinRec,
    fltComImp,
    fltSemImp,
    fltFator,
    fltFatorCom,
    fltTotMod,
    fltTotRec,
    fltValCom: Double;
    strModalidade: String;

  function fVistaPrazo: Double;
  begin
    If qryAnalitico.FieldByName('CTR_FORMAPG').AsString = 'A' Then
      Result := qryAnalitico.FieldByName('OPE_PERCOM').AsFloat
    Else
      Result := qryAnalitico.FieldByName('OPE_PERCO2').AsFloat;
  end;

  function fCalcValComOperador: Double;
  begin
    If relRecebido.blnConJur Then
      Result := fVistaPrazo * qryAnalitico.FieldByName('CTR_VALREC').AsFloat / 100
    Else
      Result := fVistaPrazo * (qryAnalitico.FieldByName('CTR_VALREC').AsFloat - qryAnalitico.FieldByName('CTR_VALJUR').AsFloat) / 100;
  end;

begin
  {*******************************************}
  {* MONTA RESUMOS POR VENDEDOR E MODALIDADE *}
  {****************************************MM*}

  With qryAnalitico Do
  begin
    First;

    While Not EOF Do
    Begin

      fltTotRec := 0;
      fltFator  := (FieldByName('CTR_RECIPI').AsFloat * 100) / FieldByName('CTR_VALREC').AsFloat;

      For intContador := 0 To High(arrModalidade) Do
      Begin
        strModalidade := String(arrModalidade[intContador]);

        If cdsResumoMod.Locate('RMO_NOMVEN;RMO_DESMOD;',
                               VarArrayOf([FieldByName('OPE_NOMOPE').AsString,strModalidade]),[]) Then
          cdsResumoMod.Edit
        Else
          cdsResumoMod.Append;

        fltValCom   := FieldByName('VALOR_COMISSAO').AsFloat;

        If (rdgPerCom.ItemIndex = 1) Then
          fltValCom := fCalcValComOperador;

        fltComImp   := 0;
        fltSemImp   := 0;
        //fltFatorCom := 0;

        fltDinRec := FieldByName('DINHEI').AsFloat;
        fltChqRec := FieldByName('CHQAVI').AsFloat + FieldByName('CHQPRE').AsFloat;
        fltCarRec := FieldByName('CARTAO').AsFloat;
        fltOrdRec := FieldByName('ORDPAG').AsFloat;
        fltFinRec := FieldByName('VALFIN').AsFloat;

        fltTotMod := Sum([fltDinRec, fltChqRec, fltCarRec, fltOrdRec, fltFinRec]);

        If fFormataFloat(fltTotMod, 2) <> fFormataFloat(FieldByName('CTR_VALREC').AsFloat, 2) Then
        Begin
          fltDinRec := fltDinRec + (FieldByName('CTR_VALREC').AsFloat - fltTotMod);
        End;

        cdsResumoMod.FieldByName('RMO_NOMVEN').AsString := FieldByName('OPE_NOMOPE').AsString;
        cdsResumoMod.FieldByName('RMO_DESMOD').AsString := strModalidade;

        If (strModalidade = 'DINHEIRO') Then
        Begin
          fltComImp := fltDinRec;
          fltSemImp := fltDinRec * (fltFator / 100);
        End
        Else If (strModalidade = 'CHEQUE') Then
        Begin
          fltComImp := fltChqRec;
          fltSemImp := fltChqRec * (fltFator / 100);
        End
        Else If (strModalidade = 'CARTAO') Then
        Begin
          fltComImp := fltCarRec;
          fltSemImp := fltCarRec * (fltFator / 100);
        End
        Else If (strModalidade = 'ORDEM') Then
        Begin
          fltComImp := fltOrdRec;
          fltSemImp := fltOrdRec * (fltFator / 100);
        End
        Else If (strModalidade = 'FINANCEIRO') Then
        Begin
          fltComImp := fltFinRec;
          fltSemImp := fltFinRec * (fltFator / 100);
        End;

        fltTotRec := fltTotRec + fltComImp;

        fltFatorCom := (fltComImp /  FieldByName('CTR_VALREC').AsFloat);

        cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat + fltComImp;
        cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat + fltSemImp;
        cdsResumoMod.FieldByName('RMO_VALCOM').AsFloat  := cdsResumoMod.FieldByName('RMO_VALCOM').AsFloat + (fltValCom * fltFatorCom);
        cdsResumoMod.FieldByName('RMO_TOTCOM').AsFloat  := cdsResumoMod.FieldByName('RMO_TOTCOM').AsFloat + fltValCom;

        cdsResumoMod.Post;

      End;

      Next;
    End;

    First;
  End;
end;

procedure TfrmRelComissaoVendedorManualCTR.pGravaComissao(strSQL: String);
  Var
    qryCom: TUniQuery;
    objGravaComissao: TGravaComissaoVen;
begin
  qryCom := fCriaQuery;
  objGravaComissao := TGravaComissaoVen.Create;
  Try
    objGravaComissao.pSetDtaVen(StrToDateDef(mskDtaVen.Text, 0));
    objGravaComissao.pSetCodCta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

    // Adiciona duplicatas da CADREC/X
    qryCom.SQL.Text := 'SELECT * FROM ('+ strSQL + ') TAB WHERE ROUND(VALOR_COMISSAO, 2) <> 0';
    pSetaParametros(qryCom, False);

    qryCom.Open;
    While Not qryCom.Eof Do
    Begin
      objGravaComissao.pAddDup(qryCom.FieldByName('CTR_NUMDUP').AsString,
                               IIF(qryCom.FindField('DOCUME') <> Nil, qryCom.FieldByName('DOCUME').AsString, ''),
                               qryCom.FieldByName('CTR_CODCLI').AsString,
                               qryCom.FieldByName('CTR_CODVEN').AsString,
                               qryCom.FieldByName('TABCTR').AsString,
                               '',
                               qryCom.FieldByName('VALOR_COMISSAO').AsFloat);
      qryCom.Next;
    End;

    If objGravaComissao.fGravaComissao Then
      fMensagem('', 'Contas a pagar gravadas com sucesso!', ['&O k']);
  Finally
    FreeAndNil(qryCom);
    FreeAndNil(objGravaComissao);
  End;
End;

end.
