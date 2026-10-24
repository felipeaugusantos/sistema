unit untRelBancFluxoCaixa;

interface

uses
  SysUtils, Types, Classes, Variants, Windows, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, Menus, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  ComObj, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, Uni, untTypesSistema,
  AppEvnts, CheckLst, BitBtnLockedIncrem, DB, Math,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, RLTypes, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmRelBancFluxoCaixa = class(TfrmPaiRelatorio)
    Label27: TLabel;
    edtSalIni: TEditFocus;
    Label1: TLabel;
    edtFator: TEditFocus;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    gpbOpcao: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel2: TColorLabel;
    edtDesEmpresa: TEditFocus;
    svdExcel: TSaveDialog;
    edtDesPortador: TEditFocus;
    edtCodPor: TEditFocus;
    lblPortador: TLabel;
    edtDiaCDe: TEditFocus;
    Label3: TLabel;
    rdgEmpresa: TRadioGroup;
    Label4: TLabel;
    edtDiaCRe: TEditFocus;
    lstArquivos: TCheckListBox;
    Label5: TLabel;
    Label6: TLabel;
    edtPreVis: TEditFocus;
    cdsFluCai: TUniClientDataSet;
    cdsFluCaiFLU_AUTINC: TStringField;
    cdsFluCaiFLU_TABELA: TStringField;
    cdsFluCaiFLU_NUMDUP: TStringField;
    cdsFluCaiFLU_ESPDOC: TStringField;
    cdsFluCaiFLU_CODEMP: TStringField;
    cdsFluCaiFLU_PARCEL: TStringField;
    cdsFluCaiFLU_CODIGO: TStringField;
    cdsFluCaiFLU_DESCRI: TStringField;
    cdsFluCaiFLU_DTAVEN: TDateField;
    cdsFluCaiFLU_CHQPRE: TFloatField;
    cdsFluCaiFLU_CTAREC: TFloatField;
    cdsFluCaiFLU_MOVCAR: TFloatField;
    cdsFluCaiFLU_CTAPAG: TFloatField;
    cdsFluCaiFLU_PEDCOM: TFloatField;
    cdsFluCaiFLU_ENTFLX: TStringField;
    cdsFluCaiFLU_PRECOM: TFloatField;
    cdsFluCaiFLU_PREVEN: TFloatField;
    cdsFluCaiFLU_PEDVEN: TFloatField;
    cdsFluCaiFLU_DOCUME: TStringField;
    btnCalSalPor: TBitBtnLocked;
    cdsFluCaiFLU_CTADES: TFloatField;
    gpbPeriodo: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    cbxChecks: TCheckListBox;
    Label7: TLabel;
    edtPrePra: TEditFocus;
    edtLimiteDias: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    edtPeriod: TEditFocus;
    cdsFluCaiFLU_CTAIMP: TFloatField;
    cdsFluCaiANOMES: TStringField;
    edtDiaRec: TEditFocus;
    Label10: TLabel;
    dsListaPortadores: TDataSource;
    cdsSalPor: TUniClientDataSet;
    cdsSalPorPOR_CODPOR: TStringField;
    cdsSalPorPOR_NOMPOR: TStringField;
    cdsSalPorPOR_SALDOS: TFloatField;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstArquivosEnter(Sender: TObject);
    procedure lstArquivosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstArquivosClickCheck(Sender: TObject);
    procedure edtPreVisExit(Sender: TObject);
    procedure btnCalSalPorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLimiteDiasExit(Sender: TObject);
    procedure cbxChecksClickCheck(Sender: TObject);
    procedure cbxChecksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPrePraExit(Sender: TObject);
    procedure edtPeriodExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
  private
    qryGenPor    : TUniQuery;
    qryResumo    : TUniQuery;
    cdsLista     : TUniClientDataSet;
    stlCadFer    : TStringList;

    arrPortador  : TConsultasArray;
    arrEmp       : TConsultasArray;

    strPortador  : String;
    strEmp       : String;

    intSelfWidth : Integer;
    intAtuLst    : Integer;

    blnIncPre    : Boolean;
    blnInvFin    : Boolean;
    blnPdFlux    : Boolean;
    blnPdvFlux   : Boolean;
    blnSepCtp    : Boolean;
    blnCtrCtp    : Boolean;
    blnQbrDia    : Boolean;
    blnPreSab    : Boolean;
    blnPdcAcm    : Boolean;
    blnQbrMes    : Boolean;
    blnSalPor    : Boolean;

    { Private declarations }
    Function fMontaResumo: Boolean;
    Function fRetTotalCadRec: Double;
    Function fRetTotalCadPag: Double;
    Function fSQLResumo: String;
    Function fSQLTmpResumo: String;
    function fEhFeriado(dtaDtaVen: TDateTime): Boolean;
    Function fMontaTmpResumo: Boolean;
    Function fAjustaVencimento(dtaDtaVen: TDateTime; blnIncDia: Boolean; blnTribCtp: Boolean = False; blnCadRec: Boolean = False): TDateTime;

    procedure pGeraExcelFluxoCaixa(fltRecVen: Double = 0; fltPagVen: Double = 0);
    procedure pAjustaDataResumo;

    procedure pMsgEspera(Sender: TForm; strTexto: String; intTimeOut: Integer = 3; intPosicao: integer = 1);
    {*****************************************************************************}
    {* SUBSTITUI pAtualizalst, VALIDAR CASO NÃO EXISTAM AS TABELAS DE INVENTÁRIO *}
    {*RQ: 33336 ***************************************************************BB*}
    function fAtualizaLst : Boolean;
    function fRetNumMesSelec: String;
    function fContaSelecoes: Integer;

    procedure pInserePrevisaoDeVendaVista;

    function fQryToCds(qryTmp: TUniQuery; cdsTmp: TUniClientDataSet; blnCadRec: Boolean = False): Boolean;
    function fGerarFiltro : String;
    function fDataInvertida(strData : String): TDate;
    function fEhCtpTrib(strNomTab, strTipDoc: String): Boolean;
    procedure pInserePrevisaoDeVendaPrazo;
    procedure pCriarListaSaldoPortadores;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public

  end;

var
  frmRelBancFluxoCaixa: TfrmRelBancFluxoCaixa;

implementation

uses untConstantes,
     untQckBancFluxoCaixa, untExcel, untWaitWindow, DateUtils,
     untIFuncoes, untFuncoesFactory;

{$R *.dfm}

procedure TfrmRelBancFluxoCaixa.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmRelBancFluxoCaixa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelBancFluxoCaixa.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
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
        If (Sender = mskDtaIni)                   And
           (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data Inicial Vencimento informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End;

        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin

            If StrToDateDef(mskDtaFin.Text, 0) <= 0 Then
            Begin
              fMensagem('', 'Data Final Vencimento informada é inválida! Necessário correção.', ['&O k']);
              Result := False;
            End
            Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor ou igual à data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    {**************************}
    {* VALIDA PORTADOR        *}
    {***********************JB*}
    Else If (Sender = edtCodPor) Then
    Begin
      If fEmptyStr(edtCodPor.Text) Then
        edtDesPortador.Text := 'TODOS'
      Else If edtCodPor.Text <> '00000' Then
      Begin
        edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End

    Else

    {**************************}
    {* VERIFICA SALDO INICIAL *}
    {***********************AF*}
    If (Sender = edtSalIni) Then
    Begin
      If fEmptyStr(edtSalIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Saldo Inicial deve ter um valor!',['&O K']);
        Result := False;
      End;
    End
    Else

    {***************************}
    {* VERIFICA FATOR DESCONTO *}
    {************************AF*}
    If (Sender = edtFator) Then
    Begin
      If fEmptyStr(edtFator.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Fator Desc. C. Receber deve ter um valor!',['&O K']);
        Result := False;
      End;
    End
    Else

    {************************}
    {* VERIFICA CAMPO OPCAO *}
    {*********************AF*}
    If (Sender = edtOpcao) Then
    Begin

      If (edtOpcao.Text <> 'A') And (edtOpcao.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Opcao deve ser A ou S!',['&O K']);
        Result := False;
      End;

    End

    {**************************}
    {* VERIFICA CAMPO DESTINO *}
    {*RQ: 33336*************BB*}
    Else If (Sender = edtDestino) Then
    Begin

      //If (edtDestino.Text <> 'V') And (edtDestino.Text <> 'I') And (edtDestino.Text <> 'E') Then
      If Pos(edtDestino.Text, 'V_I_E') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Destino deve ser V, I ou E!',['&O K']);
        Result := False;
      End;

    End

    {*****************************************************}
    {* VERIFICA CAMPO DIAS P/ CONSID CHEQUES DEPOSITADOS *}
    {**************************************************LU*}
    Else If (Sender = edtDiaCDe) Then
    Begin

      If fEmptyStr(edtDiaCDe.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dias p/ considerar Cheques Depositados não pode ser nulo!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (StrToInt(edtDiaCDe.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Dias p/ considerar Cheques Depositados não pode ser menor que zero!',['&O K']);
          edtDiaCDe.Clear;
          Result := False;
        End;
      End;

    End

    {*****************************************************}
    {* VERIFICA CAMPO DIAS P/ CONSID CARTÕES RECEBIDOS   *}
    {**************************************************LU*}
    Else If (Sender = edtDiaCRe) Then
    Begin

      If fEmptyStr(edtDiaCRe.Text) Then
      Begin
        fMensagem('','O campo Dias p/ considerar Cartões Recebidos não pode ser nulo!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (StrToInt(edtDiaCRe.Text) < 0) Then
        Begin
          fMensagem('','O campo Dias p/ considerar Cartões Recebidos não pode ser menor que zero!',['&O K']);
          edtDiaCRe.Clear;
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
        edtDesEmpresa.Text := 'TODOS';
    End

    Else If (Sender = edtDiaRec) Then
    Begin
      If fEmptyStr(edtDiaRec.Text) Then
        edtDiaRec.Text := '0'
      Else
      Begin
        If StrToIntDef(edtDiaRec.Text, 0) < 0 Then
        Begin
          fMensagem('', 'O campo Dias p/ computar no cta. a receber deve ser maior ou igual a zero!', ['&O K']);
          Result := False;
        End;

      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmRelBancFluxoCaixa.fSQLTmpResumo: String;
Begin
  Result := '';
  Result := Result + ' CREATE TEMPORARY TABLE TMP_CADREC ';
  Result := Result + ' SELECT ';
  Result := Result + '   AUTOINCREM, ';
  Result := Result + '   CTR_DTAVEN, ';
  Result := Result + '   CTR_CODPOR, ';
  Result := Result + '   (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) - IFNULL(CTR_DESSUJ, 0)) AS CTR_VALDUP  ';
  Result := Result + ' FROM CADREC ';
  Result := Result + ' WHERE ';

  Result := Result + '   CTR_DTAREC IS NULL AND ';
  Result := Result + '   CTR_DESCON <> "S"  AND ';
  Result := Result + '   CTR_DTAVEN < :DTAINI   ';

  If blnCtrCtp Then
    Result := Result + '   AND DATEDIFF(:DTAINI, CTR_DTAVEN) <= :DIAS ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    Result := Result + '  AND CTR_CODEMP = :CODEMP '
  Else
    Result := Result + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(edtCodPor.Text) Then
    Result := Result + '  AND CTR_CODPOR = :CODPOR ';
End;

Function TfrmRelBancFluxoCaixa.fMontaTmpResumo: Boolean;

  procedure pMontaCaixa;
  Var
    strSQL: String;
  Begin
    If fTabelaExiste('TMP_CADREC') Then
    With qryResumo, SQL Do
    Begin
      Close;
      Clear;
      Add('DROP TABLE TMP_CADREC');
      ExecSQL;
      Close;
    End;

    With qryResumo, SQL Do
    Begin
      Clear;
      strSQL := fSQLTmpResumo;
      Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      If Not fEmptyStr(edtCodEmp.Text) Then
         ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If Not fEmptyStr(edtCodPor.Text) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      If blnCtrCtp Then
        ParamByName('DIAS').AsInteger := StrToInt(edtLimiteDias.Text);

      ExecSQL;
      pAjustaDataResumo;
    End;
  End;

Begin

  Try
   pMontaCaixa;
   Result := TRUE;
  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, 'fMontaTmpResumo');
    End;
  End;

End;

Function TfrmRelBancFluxoCaixa.fSQLResumo: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   POR_CODPOR AS CODPOR, ';
  Result := Result + '   CONCAT(IFNULL(POR_CODPOR,"          "), " - ", IFNULL(POR_NOMPOR,"NAO CADASTRADO")) AS NOMPOR, ';
  Result := Result + '   SUM(CTR_VALDUP) AS VALDUP ';
  Result := Result + ' FROM TMP_CADREC';
  Result := Result + ' LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
  Result := Result + ' WHERE ';
  Result := Result + '   CTR_DTAVEN < :DTAINI   ';
  Result := Result + ' GROUP BY POR_CODPOR      ';
End;

Function TfrmRelBancFluxoCaixa.fMontaResumo: Boolean;
  Var
    strSQL: String;
Begin
  Try
    Result := fMontaTmpResumo;

    If Not Result Then
      Exit;

    With qryResumo, SQL Do
    Begin
      Clear;
      strSQL := fSQLResumo;
      strSQL := strSQL + ' ORDER BY CODPOR ';

      Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      Open;
    End;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, 'fMontaResumo');
    End;
  End;

End;

Function TfrmRelBancFluxoCaixa.fRetTotalCadRec: Double;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;

      Add(' SELECT ');
      Add('   SUM(CTR_VALDUP) AS VALDUP ');
      Add(' FROM TMP_CADREC');
      Add(' WHERE CTR_DTAVEN < :DTAINI   ');

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      Open;

      Result := FieldByName('VALDUP').AsFloat;

      Close;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, 'fRetTotalCadRec');
    End;
  End;

End;

Function TfrmRelBancFluxoCaixa.fRetTotalCadPag: Double;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;

      Add(' SELECT ');
      Add('   SUM(CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)) AS VALDUP');
      Add(' FROM CADPAG ');
      Add(' WHERE CTP_DTAPAG IS NULL   ');
      Add('   AND CTP_DTAVEN < :DTAINI ');

      If Not fEmptyStr(edtCodEmp.Text) Then
        Add('   AND CTP_CODEMP = :CODEMP ')
      Else
        Add('  AND LOCATE(CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');

      If Not fEmptyStr(edtCodPor.Text) Then
        Add(' AND CTP_CODPOR = :CODPOR ');

      If fCfgSis('PAGPRV') = '2' Then
        Add(' AND CTP_PREVIS <> "S" ');

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      If Not fEmptyStr(edtCodEmp.Text) Then
         ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If Not fEmptyStr(edtCodPor.Text) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      Open;

      Result := FieldByName('VALDUP').AsFloat;

      Close;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, 'fRetTotalCadPag');
    End;
  End;

End;

procedure TfrmRelBancFluxoCaixa.btnCalSalPorClick(Sender: TObject);
  Var
    qryCadPor: TUniQuery;
    fltSalGer,
    fltSaldo: Double;
begin
  inherited;

  Try
    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.intPosicao := 1;
    frmWaitWindow.lblTexto.Caption := 'Calculando saldo de Portadores... Aguarde!';
    frmWaitWindow.Show;
    frmWaitWindow.Refresh;
    frmWaitWindow.tmrWait.Enabled := False;

    qryCadPor := fCriaQuery(Self);
    qryCadPor.SQL.Add('SELECT POR_CODPOR, POR_DTAINI FROM CADPOR WHERE POR_ENTFLX = "S"');
    qryCadPor.Open;

    fltSalGer := 0;
    While Not qryCadPor.Eof Do
    Begin

      If StrToDate(mskDtaIni.Text) < qryCadPor.FieldByName('POR_DTAINI').AsDateTime Then
        fltSaldo := 0
      Else
        fltSaldo := fRetSaldoAnterior(qryCadPor.FieldByName('POR_CODPOR').AsString, StrToDate(mskDtaIni.Text), edtCodEmp.Text);

      fltSalGer := fltSalGer + fltSaldo;
      qryCadPor.Next;
    End;

    frmWaitWindow.Close;
    edtSalIni.Text := FloatToStrF(fltSalGer, ffNumber,15,2);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'btnCalSalPorClick');
  End;

  FreeAndNil(qryCadPor);
  pFreeAndNil(frmWaitWindow);
end;

procedure TfrmRelBancFluxoCaixa.btnImprimirClick(Sender: TObject);
  Var
    strSQL           : String;
    strSqlBlo        : String;
    strCreate        : String;
    intContador      : Integer;
    qryGenCai        : TUniQuery;
    qryGenFlu        : TUniQuery;
    intQtdDup        : Integer;
    curTotalRes      : Currency;
    fltTotRec        : Double;
    fltTotPag        : Double;
    strCfgOrdemPedido: String;
    cdsAux           : TUniClientDataSet;
    fltValorAcm      : Double;

  Const
    CTP_VALDUP = ' (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)) ';

  procedure pMontaListaPorNEnt;
  begin

    cdsAux := fCriaClientDatset(cdsFluCai);

    strSQL := '';
    strSQL := strSQL + '   FLU_ENTFLX = ' + QuotedStr('N');
    strSQL := strSQL + '   AND FLU_TABELA = '+ QuotedStr('CADPOR');

    cdsAux.DisableControls;
    cdsAux.Filtered := False;
    cdsAux.Filter   := strSQL;
    cdsAux.Filtered := True;

    cdsAux.First;

    While Not cdsAux.Eof Do
    Begin

      If Not (cdsLista.Locate('FLU_CODIGO', cdsAux.FieldByName('FLU_CODIGO').AsString, [])) Then
      Begin
        cdsLista.Insert;
        cdsLista.FieldByName('FLU_CODIGO').AsString := cdsAux.FieldByName('FLU_CODIGO').AsString;
        cdsLista.FieldByName('FLU_DESCRI').AsString := cdsAux.FieldByName('FLU_DESCRI').AsString;
        cdsLista.Post;
      End;

      cdsAux.Next;
    End;

    cdsLista.First;

    cdsAux.Filtered := False;
    cdsAux.EnableControls;

    cdsLista.IndexFieldNames := 'FLU_CODIGO';

    FreeAndNil(cdsAux);

  end;

begin
  inherited;

  strCfgOrdemPedido := fCfgSis('FLXPEP');

  If blnInvFin Then
  Begin

    If fContaSelecoes = 0 Then
    Begin
      fMensagem('','Você deve selecionar um arquivo de inventário financeiro!',['&O K']);
      pSetFocus(lstArquivos);

      If lstArquivos.Items.Count > 0 Then
        lstArquivos.Selected[0] := True;

      Exit;
    End;

  End;

  cdsLista.EmptyDataSet;

  cdsFluCai.EmptyDataSet;
  cdsFluCai.Filtered := False;

  if not (edtOpcao.Text = 'S') then
    blnCtrCtp := False;

  If fEmptyStr(edtPeriod.Text) Then edtPeriod.Text := '0';

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  pMsgEspera(Nil, #13#10 + '    Processando o Fluxo de Caixa - Iniciando...');

  qryGenCai := fCriaQuery(Self);

  qryGenFlu := fCriaQuery(Self);

  If blnImprime Then
  Begin

    fltTotRec := 0;
    fltTotPag := 0;

    If blnCtrCtp Then
    Begin
      fMontaResumo;
      fltTotRec := fRetTotalCadRec;
      fltTotPag := fRetTotalCadPag;
    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Criando tabela...';
    frmWaitWindow.Refresh;

    strCreate := ''; //

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Contas a Receber...';
    frmWaitWindow.Refresh;

    {*************************}
    {* PEGA CONTAS A RECEBER *}
    {* SOMENTE AS NAO PAGAS  *}
    {*******************AF,JB*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  A.AUTOINCREM, ';
    strSQL := strSQL + '  "NOMTAB",  ';
    strSQL := strSQL + '  A.CTR_NUMDUP, ';
    strSQL := strSQL + '  A.CTR_ESPDOC, ';

    If rdgEmpresa.ItemIndex = 0 Then
      strSQL := strSQL + '  A.CTR_CODEMP, '
    Else
      strSQL := strSQL + '  IF(IFNULL(CTR_EMP_PD, "")<>"", IFNULL(CTR_EMP_PD,""), CTR_CODEMP) AS CTR_CODEMP, ';

    strSQL := strSQL + '  A.CTR_PARCEL, ';
    strSQL := strSQL + '  A.CTR_CODCLI,  ';
    strSQL := strSQL + '  CLI_NOMCLI,  ';

    strSQL := strSQL + '  DATE_ADD( ';
    strSQL := strSQL + '    (CASE DAYOFWEEK(CTR_DTAVEN)                        ';
    strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(CTR_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
    strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(CTR_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
    strSQL := strSQL + '      ELSE CTR_DTAVEN END)                             ';
    strSQL := strSQL + '      , INTERVAL ' + edtDiaRec.Text + ' DAY) AS CTR_DTAVEN, ';

    strSQL := strSQL + '  0 AS CHQPRE, ';
    strSQL := strSQL + '  (A.CTR_VALDUP + IFNULL(A.CTR_JURSUJ, 0) - IFNULL(A.CTR_DESSUJ, 0)) AS CTR_VALDUP,  ';
    strSQL := strSQL + '  0 AS MOVCAR, ';
    strSQL := strSQL + '  0 AS CTAPAG, ';
    strSQL := strSQL + '  0 AS PEDCOM, ';
    strSQL := strSQL + '  IF(POR_ENTFLX IS NULL,"S",POR_ENTFLX), ';
    strSQL := strSQL + '  0 AS PRECOM, ';
    strSQL := strSQL + '  0 AS PREVEN, ';
    strSQL := strSQL + '  0 AS PEDVEN, ';
    strSQL := strSQL + '  0 AS CTADES, ';
    strSQL := strSQL + '  0 AS CTAIMP, ';
    strSQL := strSQL + '  CONCAT("DOC: Duplicata: ", CTR_NUMDUP, CTR_PARCEL, " Especie: ",  ';
    strSQL := strSQL + '  CTR_ESPDOC, " Empresa: ", CTR_CODEMP) AS DOCUME,  ';
    strSQL := strSQL + '  DATE_FORMAT(A.CTR_DTAVEN,"%b/%Y") AS ANOMES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  NOMTAB A ';
    strSQL := strSQL + '  JOIN CADCLI      ON CLI_CODCLI   = A.CTR_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADPOR ON A.CTR_CODPOR = POR_CODPOR   ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  A.CTR_DTAREC IS NULL      AND ';
    strSQL := strSQL + '  A.CTR_DESCON <> "S"        ';

    If blnCtrCtp Then
      strSQL := strSQL + ' AND DATEDIFF(:DTAINI, A.CTR_DTAVEN) <= :DIAS ';

    If fCfgSis('FFFLUX') <> 'S' Then
      strSQL := strSQL + '  AND A.CTR_ESPDOC <> "FF" ';

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If rdgEmpresa.ItemIndex = 0 Then
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'A.CTR_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'IF(IFNULL(CTR_EMP_PD, "")<>"", IFNULL(CTR_EMP_PD,""), CTR_CODEMP)', 'CODEMP');
    End
    Else
    Begin
      If rdgEmpresa.ItemIndex = 0 Then
        strSQL := strSQL + '  AND LOCATE(A.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
      Else
        strSQL := strSQL + '  AND LOCATE(IF(IFNULL(CTR_EMP_PD, "")<>"", IFNULL(CTR_EMP_PD,""), CTR_CODEMP),'
                         + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'A.CTR_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(A.CTR_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(A.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + ' AND DATE_ADD( ';

    strSQL := strSQL + '    (CASE DAYOFWEEK(CTR_DTAVEN)                        ';
    strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(CTR_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
    strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(CTR_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
    strSQL := strSQL + '      ELSE CTR_DTAVEN END)                             ';

    strSQL := strSQL + '      , INTERVAL ' + edtDiaRec.Text + ' DAY) BETWEEN DATE_SUB(:DTAINI, INTERVAL 7 DAY) AND :DTAFIN ';

    If blnInvFin Then strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CTR_' + fRetNumMesSelec)
    Else strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CADREC');

    With qryGenFlu Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate + strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If blnCtrCtp Then
        ParamByName('DIAS').AsInteger := StrToInt(edtLimiteDias.Text);

      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryGenFlu);

      Open;
      fQryToCds(qryGenFlu, cdsFluCai, True);
      Close;
    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Cartões de Crédito...';
    frmWaitWindow.Refresh;

    {***************************}
    {* SOMA CARTOES DE CREDITO *}
    {* SOMENTE AS NAO PAGAS    *}
    {*********************AF,JB*}
    If fCfgSis('USACTC') = 'S' Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE  ';
      strSQL := strSQL + '  M.AUTOINCREM,      ';
      strSQL := strSQL + '  "MOVCAR",          ';
      strSQL := strSQL + '  MCA_NUMDUP,        ';
      strSQL := strSQL + '  "CR",              ';

      //strSQL := strSQL + '  MCA_CODEMP,        ';
      If rdgEmpresa.ItemIndex = 0 Then
        strSQL := strSQL + '  MCA_CODEMP, '
      Else
        strSQL := strSQL + '  IF(IFNULL(MCA_EMP_PD, "")<>"", IFNULL(MCA_EMP_PD,""), MCA_CODEMP) AS MCA_CODEMP, ';

      strSQL := strSQL + '  MCA_PARCEL,        ';
      strSQL := strSQL + '  MCA_CODCLI,        ';
      strSQL := strSQL + '  CLI_NOMCLI,        ';

      strSQL := strSQL + '  DATE_ADD( ';

      strSQL := strSQL + '    (CASE DAYOFWEEK(MCA_DTAVEN)                        ';
      strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(MCA_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
      strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(MCA_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
      strSQL := strSQL + '      ELSE MCA_DTAVEN END)                             ';

      strSQL := strSQL + '      , INTERVAL ' + edtDiaCRe.Text + ' DAY) AS MCA_DTAVEN, ';

      strSQL := strSQL + '  0 AS CHQPRE,       ';
      strSQL := strSQL + '  0 AS CTAREC,       ';
      strSQL := strSQL + '  MCA_VALDUP,        ';
      strSQL := strSQL + '  0 AS CTAPAG,       ';
      strSQL := strSQL + '  0 AS PEDCOM,       ';
      strSQL := strSQL + '  "S" AS ENTFLX,     ';
      strSQL := strSQL + '  0 AS PRECOM,       ';
      strSQL := strSQL + '  0 AS PREVEN,       ';
      strSQL := strSQL + '  0 AS PEDVEN,       ';
      strSQL := strSQL + '  0 AS CTADES, ';
      strSQL := strSQL + '  0 AS CTAIMP, ';
      strSQL := strSQL + '  CONCAT("DOC: Duplicata: ", MCA_NUMDUP, " Especie: ",  ';
      strSQL := strSQL + '  MCA_PARCEL, " Empresa: ", MCA_CODEMP) AS DOCUME,  ';
      strSQL := strSQL + '  DATE_FORMAT(MCA_DTAVEN,"%b/%Y") AS ANOMES ';
      strSQL := strSQL + 'FROM                 ';

      If blnInvFin Then
        strSQL := strSQL + '  CAR_' + fRetNumMesSelec + ' M '
      Else
        strSQL := strSQL + '  MOVCAR M ';

      strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ';
      strSQL := strSQL + 'WHERE                ';
      strSQL := strSQL + '  MCA_DTAREC IS NULL  AND ';

      strSQL := strSQL + '  DATE_ADD( ';

      strSQL := strSQL + '    (CASE DAYOFWEEK(MCA_DTAVEN)                        ';
      strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(MCA_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
      strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(MCA_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
      strSQL := strSQL + '      ELSE MCA_DTAVEN END)                             ';

      strSQL := strSQL + '      , INTERVAL ' + edtDiaCRe.Text + ' DAY) BETWEEN DATE_SUB(:DTAINI, INTERVAL 7 DAY) AND :DTAFIN ';

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If rdgEmpresa.ItemIndex = 0 Then
          strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'MCA_CODEMP', 'CODEMP')
        Else
          strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'IF(IFNULL(MCA_EMP_PD, "")<>"", IFNULL(MCA_EMP_PD,""), MCA_CODEMP)', 'CODEMP');
      End
      Else
      Begin
        If rdgEmpresa.ItemIndex = 0 Then
          strSQL := strSQL + '  AND LOCATE(MCA_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
        Else
          strSQL := strSQL + '  AND LOCATE(IF(IFNULL(MCA_EMP_PD, "")<>"", IFNULL(MCA_EMP_PD,""), MCA_CODEMP),'
                           + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      End;

      With qryGenFlu Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strCreate + strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

        Open;
        fQryToCds(qryGenFlu, cdsFluCai);
        Close;
      End;
    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Contas a Pagar...';
    frmWaitWindow.Refresh;

    {*************************}
    {* SOMA CONTAS A PAGAR   *}
    {* SOMENTE AS NAO PAGAS  *}
    {*******************AF,JB*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  P.AUTOINCREM,     ';
    strSQL := strSQL + '  "NOMTAB",         ';
    strSQL := strSQL + '  "",               ';
    strSQL := strSQL + '  CTP_TIPDOC,       ';
    strSQL := strSQL + '  "",               ';
    strSQL := strSQL + '  "",               ';
    strSQL := strSQL + '  CTP_CODFOR,       ';
    strSQL := strSQL + '  FOR_NOMFOR,       ';

    //strSQL := strSQL + '  CTP_DTAVEN,       ';
    strSQL := strSQL + '    (CASE DAYOFWEEK(CTP_DTAVEN)                        ';
    strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(CTP_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
    strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(CTP_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
    strSQL := strSQL + '      ELSE CTP_DTAVEN END) AS CTP_DTAVEN,             ';

    strSQL := strSQL + '  0 AS CHQPRE,      ';
    strSQL := strSQL + '  0 AS CTAREC,      ';
    strSQL := strSQL + '  0 AS MOVCAR,      ';
    strSQL := strSQL + IfThen(blnSepCtp, ' IF(CTA_FLXIMP = "F", ' + CTP_VALDUP + ', 0) ', CTP_VALDUP) + ' AS CTP_VALDUP, ';
    strSQL := strSQL + '  0 AS PEDCOM,      ';
    strSQL := strSQL + '  "S" AS ENTFLX,    ';
    strSQL := strSQL + '  0 AS PRECOM,      ';
    strSQL := strSQL + '  0 AS PREVEN,      ';
    strSQL := strSQL + '  0 AS PEDVEN,      ';
    strSQL := strSQL + IfThen(blnSepCtp, ' IF(CTA_FLXIMP = "D", ' + CTP_VALDUP + ', 0) ', '0') + ' AS CTADES, ';
    strSQL := strSQL + IfThen(blnSepCtp, ' IF(CTA_FLXIMP = "I", ' + CTP_VALDUP + ', 0) ', '0') + ' AS CTAIMP, ';
    strSQL := strSQL + '  CONCAT("DOC: Duplicata: ", CTP_NUMDUP, CTP_PARCEL,   ';
    strSQL := strSQL + '  IF(CTP_SERIE_ IS NULL, "", " Serie: "), IFNULL(CTP_SERIE_, ""),  ';
    strSQL := strSQL + '  " Empresa: ", CTP_CODEMP ) AS DOCUME,  ';
    strSQL := strSQL + '  DATE_FORMAT(CTP_DTAVEN,"%b/%Y") AS ANOMES ';
    strSQL := strSQL + 'FROM                ';
    strSQL := strSQL + '  NOMTAB P          ';
    strSQL := strSQL + '  JOIN CADFOR ON CTP_CODFOR = FOR_CODFOR ';
    strSQL := strSQL + '  JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ';
    strSQL := strSQL + 'WHERE               ';
    strSQL := strSQL + '  CTP_DTAPAG IS NULL                     AND ';
    strSQL := strSQL + '  CTP_DTAVEN BETWEEN DATE_SUB(:DTAINI, INTERVAL 7 DAY) AND :DTAFIN ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'CTP_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador, 'CTP_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If fCfgSis('PAGPRV') = '2' Then
      strSQL := strSQL + '  AND CTP_PREVIS <> "S" ';

    If blnInvFin Then strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CTP_' + fRetNumMesSelec)
    Else strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CADPAG');

    With qryGenFlu Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate + strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryGenFlu);

      Open;
      fQryToCds(qryGenFlu, cdsFluCai);
      Close;
    End;

    If fCfgSis('PAGPRV') = '2' Then 
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
      strSQL := strSQL + '  P.AUTOINCREM,           ';
      strSQL := strSQL + '  "NOMTAB",               ';
      strSQL := strSQL + '  "",                     ';
      strSQL := strSQL + '  CTP_TIPDOC,             ';
      strSQL := strSQL + '  "",                     ';
      strSQL := strSQL + '  "",                     ';
      strSQL := strSQL + '  CTP_CODFOR AS CODIGO,   ';
      strSQL := strSQL + '  FOR_NOMFOR AS DESCRI,   ';

      //strSQL := strSQL + '  CTP_DTAVEN AS DTAVEN,   ';
      strSQL := strSQL + '    (CASE DAYOFWEEK(CTP_DTAVEN)                        ';
      strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(CTP_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
      strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(CTP_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
      strSQL := strSQL + '      ELSE CTP_DTAVEN END) AS DTAVEN,             ';

      strSQL := strSQL + '  0          AS CHQPRE,   ';
      strSQL := strSQL + '  0          AS CTAREC,   ';
      strSQL := strSQL + '  0          AS MOVCAR,   ';
      strSQL := strSQL + '  0          AS VALDUP,   ';
      strSQL := strSQL + '  0          AS PEDCOM,   ';
      strSQL := strSQL + '  "S"        AS ENTFLX,   ';
      strSQL := strSQL + '  (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)) AS PRECOM, ';
      strSQL := strSQL + '  0          AS PREVEN,   ';
      strSQL := strSQL + '  0          AS PEDVEN,   ';
      strSQL := strSQL + '  0 AS CTADES, ';
      strSQL := strSQL + '  0 AS CTAIMP, ';
      strSQL := strSQL + '  CONCAT("DOC: Duplicata: ", CTP_NUMDUP, CTP_PARCEL,   ';
      strSQL := strSQL + '  IF(CTP_SERIE_ IS NULL, "", " Serie: "), IFNULL(CTP_SERIE_, ""),  ';
      strSQL := strSQL + '  " Empresa: ", CTP_CODEMP ) AS DOCUME, ';
      strSQL := strSQL + '  DATE_FORMAT(CTP_DTAVEN,"%b/%Y") AS ANOMES ';
      strSQL := strSQL + 'FROM                                     ';
      strSQL := strSQL + '  NOMTAB P                               ';
      strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ';
      strSQL := strSQL + 'WHERE                                    ';
      strSQL := strSQL + '  CTP_DTAVEN BETWEEN DATE_SUB(:DTAINI, INTERVAL 7 DAY) AND :DTAFIN AND ';
      strSQL := strSQL + '  CTP_PREVIS = "S" ';

      If Not fEmptyStr(edtCodEmp.Text) Then
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'CTP_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If blnInvFin Then strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CTP_' + fRetNumMesSelec)
      Else strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CADPAG');

      If Not fEmptyStr(edtCodPor.Text) Then
        strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador, 'CTP_CODPOR', 'CODPOR')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strSQL := strSQL + ' AND (IFNULL(CTP_PORBAI, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      With qryGenFlu Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add(strCreate + strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

        If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryGenFlu);

        Open;
        fQryToCds(qryGenFlu, cdsFluCai);
        Close;
      End;

    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Cheques Pré...';
    frmWaitWindow.Refresh;

    {***********************************}
    {* SOMA CHEQUES REFERENTE AS DATAS *}
    {********************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  C.AUTOINCREM,     ';
    strSQL := strSQL + '  "NOMTAB",      ';
    strSQL := strSQL + '  "",            ';
    strSQL := strSQL + '  "",            ';
    strSQL := strSQL + '  "",            ';
    strSQL := strSQL + '  "",            ';
    strSQL := strSQL + '  CHQ_CODCLI AS CODIGO, '; // " "
    strSQL := strSQL + '  CHQ_NOMEMI,    ';
    strSQL := strSQL + '  DATE_ADD( ';

    strSQL := strSQL + '    (CASE DAYOFWEEK(CHQ_DTAVEN)                        ';
    strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(CHQ_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
    strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(CHQ_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
    strSQL := strSQL + '      ELSE CHQ_DTAVEN END)                             ';

    strSQL := strSQL + '      , INTERVAL ' + edtDiaCDe.Text + ' DAY) AS CHQ_DTAVEN, ';

    strSQL := strSQL + '  CHQ_VALCHQ,    ';
    strSQL := strSQL + '  0 AS CTAREC,   ';
    strSQL := strSQL + '  0 AS MOVCAR,   ';
    strSQL := strSQL + '  0 AS CTAPAG,   ';
    strSQL := strSQL + '  0 AS PEDCOM,   ';
    strSQL := strSQL + '  "S" AS ENTFLX, ';
    strSQL := strSQL + '  0 AS PRECOM,   ';
    strSQL := strSQL + '  0 AS PREVEN,   ';
    strSQL := strSQL + '  0 AS PEDVEN,   ';
    strSQL := strSQL + '  0 AS CTADES, ';
    strSQL := strSQL + '  0 AS CTAIMP, ';
    strSQL := strSQL + '  CONCAT("DOC: Banco: ", CHQ_CODBCO, " Agencia: ", CHQ_NUMAGE,  ';
    strSQL := strSQL + '  " Conta Corrente: ", CHQ_CONCOR, " Numero Cheque: ", CHQ_NUMCHQ) AS DOCUME,  ';
    strSQL := strSQL + '  DATE_FORMAT(CHQ_DTAVEN,"%b/%Y") AS ANOMES ';
    strSQL := strSQL + 'FROM             ';
    strSQL := strSQL + '  NOMTAB C       ';
    strSQL := strSQL + 'WHERE            ';
    strSQL := strSQL + '  CHQ_DTADEP IS NULL AND ';
    strSQL := strSQL + '  DATE_ADD( ';

    strSQL := strSQL + '    (CASE DAYOFWEEK(CHQ_DTAVEN)                        ';
    strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(CHQ_DTAVEN, INTERVAL 1 DAY) ';  // DOMINGO
    strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(CHQ_DTAVEN, INTERVAL 2 DAY) ';  // SABADO
    strSQL := strSQL + '      ELSE CHQ_DTAVEN END)                             ';

    strSQL := strSQL + '      , INTERVAL ' + edtDiaCDe.Text + ' DAY) BETWEEN :DTAINI AND :DTAFIN AND ';

    strSQL := strSQL + '  CHQ_INCCTR = "N" ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'CHQ_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If blnInvFin Then strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CHQ_' + fRetNumMesSelec)
    Else strSQL := AnsiReplaceStr(strSQL,'NOMTAB','CADCHQ');

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador, 'CHQ_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CHQ_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    With qryGenFlu Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate + strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryGenFlu);

      Open; 
      fQryToCds(qryGenFlu, cdsFluCai);
      Close;
    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Previsões...';
    frmWaitWindow.Refresh;

    {******************}
    {* SOMA PREVISOES *}
    {***************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
    strSQL := strSQL + '  AUTOINCREM,           ';
    strSQL := strSQL + '  "CADPRE",             ';
    strSQL := strSQL + '  "",                   ';
    strSQL := strSQL + '  "",                   ';
    strSQL := strSQL + '  "",                   ';
    strSQL := strSQL + '  "",                   ';
    strSQL := strSQL + '  " "        AS CODIGO, ';

    {******** ACRESCENTADO EM 17/06/09 ***********}
    strSQL := strSQL + '  PRE_DESCRI AS DESCRI, ';
    {*************************************** AM **}

    //strSQL := strSQL + '  PRE_DTALAN AS DTALAN, ';
    strSQL := strSQL + '    (CASE DAYOFWEEK(PRE_DTALAN)                        ';
    strSQL := strSQL + '      WHEN 1 THEN DATE_ADD(PRE_DTALAN, INTERVAL 1 DAY) ';  // DOMINGO
    strSQL := strSQL + '      WHEN 7 THEN DATE_ADD(PRE_DTALAN, INTERVAL 2 DAY) ';  // SABADO
    strSQL := strSQL + '      ELSE PRE_DTALAN END) AS DTALAN,             ';

    strSQL := strSQL + '  0          AS VALCHQ, ';
    strSQL := strSQL + '  0          AS CTAREC, ';
    strSQL := strSQL + '  0          AS MOVCAR, ';
    strSQL := strSQL + '  0          AS CTAPAG, ';
    strSQL := strSQL + '  0          AS PEDCOM, ';
    strSQL := strSQL + '  "S"        AS ENTFLX, ';

    If fCfgSis('PAGPRV') = '2' Then
      strSQL := strSQL + '  0          AS PRECOM, '
    Else
      strSQL := strSQL + '  PRE_VALAPA AS PRECOM, ';

    strSQL := strSQL + '  PRE_VALARE AS PREVEN, ';
    strSQL := strSQL + '  0          AS PEDVEN, ';
    strSQL := strSQL + '  0 AS CTADES, ';
    strSQL := strSQL + '  0 AS CTAIMP, ';
    strSQL := strSQL + '  ""         AS DOCUME,  ';
    strSQL := strSQL + '  DATE_FORMAT(PRE_DTALAN,"%b/%Y") AS ANOMES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPRE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRE_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'PRE_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(PRE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    With qryGenFlu Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate + strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

      Open; 
      fQryToCds(qryGenFlu, cdsFluCai);
      Close;
    End;
    {***********************************************}
    {* PORTADORES QUE NÃO ENTRAM NO FLUXO DE CAIXA *}
    {********************************************JU*}
    strSQL := '';
    strSQL := strSQL + ' SELECT AUTOINCREM,                      ';
    strSQL := strSQL + '   "CADPOR",                             ';
    strSQL := strSQL + '   "",                                   ';
    strSQL := strSQL + '   "",                                   ';
    strSQL := strSQL + '   POR_CODEMP,                           ';
    strSQL := strSQL + '   " ",                                  ';
    strSQL := strSQL + '   POR_CODPOR,                           ';
    strSQL := strSQL + '   POR_NOMPOR,                           ';
    strSQL := strSQL + '   POR_DTAINI,                           ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   IF(POR_ENTFLX = "", "N", POR_ENTFLX), ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   0,                                    ';
    strSQL := strSQL + '   "                                  ", ';
    strSQL := strSQL + '   ""                                    ';
    strSQL := strSQL + ' FROM                                    ';
    strSQL := strSQL + '   CADPOR                                ';
    strSQL := strSQL + ' WHERE                                   ';
    strSQL := strSQL + '   (POR_ENTFLX = "N"                     ';
    strSQL := strSQL + '   OR POR_ENTFLX = "")                   ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'POR_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(POR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If fCfgSis('DACPOR', varBoolean) Then
      strSQL := strSQL + ' AND LOCATE(POR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0 ';

    With qryGenFlu Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate + strSQL);

      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

      Open;
      fQryToCds(qryGenFlu, cdsFluCai);
      Close;
    End;

    If blnPdvFlux Then
    Begin
      {********************************************}
      {* (SUB SELECT)  PAGAMENTO ANTECIPADO MENOS *}
      {*****************************************JB*}
      strSqlBlo := EmptyStr;
      strSqlBlo := strSqlBlo + '  (  ';
      strSqlBlo := strSqlBlo + '    SELECT SQL_NO_CACHE ';
      strSqlBlo := strSqlBlo + '      SUM(IF(CTR_SEQBAI = 0 AND CTR_VALDUP > 0.0, CTR_VALDUP, CTR_VALORI)) ';
      strSqlBlo := strSqlBlo + '    FROM ';
      strSqlBlo := strSqlBlo + '      CADREC ';
      strSqlBlo := strSqlBlo + '    WHERE ';
      strSqlBlo := strSqlBlo + '      CTR_NUMDUP = FGO_NUMDOC AND ';
      strSqlBlo := strSqlBlo + '      CTR_ESPDOC = FGO_ESPDOC AND ';
      strSqlBlo := strSqlBlo + '      CTR_CODEMP = FGO_CODEMP     ';
      strSqlBlo := strSqlBlo + '  )  ';

      frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                        #13#10 + '    - Pedidos de Venda...';
      frmWaitWindow.Refresh;

      {*******************************************}
      {* PEGA PEDIDOS DE VENDA                   *}
      {****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  T.AUTOINCREM,     ';
      strSQL := strSQL + '  FDO_NUMDOC,       ';
      strSQL := strSQL + '  FDO_CODCLI,       ';
      strSQL := strSQL + '  IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON) AS FDO_NOMCLI, ';
      strSQL := strSQL + '  FDO_DTAENT,       ';
      strSQL := strSQL + '  IF(FDO_CONPAG = "", "01000", FDO_CONPAG) AS FDO_CONPAG,       ';
      strSQL := strSQL + '  FGO_PREVIS,       ';

      {********************************************}
      {* TOTAL DOS PRODUTOS MENOS - DESCONTO ESP. *}
      {*****************************************JB*}
      strSQL := strSQL + '  SUM(FDO_TOTITE) - IF( ' + strSqlBlo + ' IS NULL, 0, ' + strSqlBlo + ') - FGO_DESESP AS VALOR,  ';
      strSQL := strSQL + '  CONCAT("DOC: Duplicata: ", FDO_NUMDOC, " Especie: ", FDO_ESPDOC, " Empresa: ", FDO_CODEMP) AS DOCUME  ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  NOMDET D ';
      strSQL := strSQL + '  JOIN NOMTAB T    ON T.AUTOINCREM = D.FDO_SEQGER ';
      strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI   = FDO_CODCLI   ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  FDO_JAFATU = FALSE AND ';
      strSQL := strSQL + '  FDO_ESPDOC <> "OR" ';

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'FDO_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(FDO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  FDO_NUMDOC ';

      If blnInvFin Then
           strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL,'NOMDET','FDO_' + fRetNumMesSelec),'NOMTAB','FGO_' + fRetNumMesSelec)
      Else strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL,'NOMDET','FATDOR'),'NOMTAB','FATGOR');

      With qryGenFlu Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

        Open;
        
        While Not Eof Do
        Begin
          intQtdDup := 0;
          curTotalRes := 0;

          fDigDuplicSemTela(intQtdDup,
                            curTotalRes,
                     FieldByName('FDO_CONPAG').AsString,
                     StrToInt64(FieldByName('FDO_NUMDOC').AsString),
                     FieldByName('VALOR').AsFloat,
                     False,
                     False,
                     FieldByName('FGO_PREVIS').AsDateTime,
                     False,
                     0,
                     'N',
                     True,
                     False,
                     0,
                     Nil,
                     False);

          For intContador := 0 To StrToIntDef(Copy(FieldByName('FDO_CONPAG').AsString,0,2), 0) - 1 Do
          Begin

            If (StrToDate(arrDuplicata[intContador].dtaDtaVen) < StrToDate(mskDtaIni.Text)) Or
               (StrToDate(arrDuplicata[intContador].dtaDtaVen) > StrToDate(mskDtaFin.Text)) Then
              Continue;

            If edtOpcao.Text = 'A' Then
            Begin
              cdsFluCai.Append;
              cdsFluCaiFLU_AUTINC.AsString := FieldByName('AUTOINCREM').AsString;
              cdsFluCaiFLU_TABELA.Value    := 'PEDIDO';
              cdsFluCaiFLU_NUMDUP.Value    := '';
              cdsFluCaiFLU_ESPDOC.Value    := '';
              cdsFluCaiFLU_CODEMP.Value    := '';
              cdsFluCaiFLU_PARCEL.Value    := '';
              cdsFluCaiFLU_CODIGO.AsString := FieldByName('FDO_CODCLI').AsString;
              cdsFluCaiFLU_DESCRI.AsString := FieldByName('FDO_NOMCLI').AsString;
              cdsFluCaiFLU_DTAVEN.Value    := StrToDate(arrDuplicata[intContador].dtaDtaVen);
              cdsFluCaiFLU_CHQPRE.Value    := 0;
              cdsFluCaiFLU_CTAREC.Value    := 0;
              cdsFluCaiFLU_MOVCAR.Value    := 0;
              cdsFluCaiFLU_CTAPAG.Value    := 0;
              cdsFluCaiFLU_PEDCOM.Value    := 0;
              cdsFluCaiFLU_ENTFLX.Value    := 'S';
              cdsFluCaiFLU_PRECOM.Value    := 0;
              cdsFluCaiFLU_PREVEN.Value    := 0;
              cdsFluCaiFLU_PEDVEN.Value    := arrDuplicata[intContador].curValor;
              cdsFluCaiFLU_CTADES.Value    := 0;
              cdsFluCaiFLU_CTAIMP.Value    := 0;
              cdsFluCaiFLU_DOCUME.AsString := FieldByName('DOCUME').AsString;
              cdsFluCaiANOMES.AsString     := FormatDateTime('mmm/yyyy',StrToDate(arrDuplicata[intContador].dtaDtaVen));
              cdsFluCai.Post;
            End
            Else
            Begin
              If cdsFluCai.FindKey([StrToDate(arrDuplicata[intContador].dtaDtaVen)]) Then
              Begin
                cdsFluCai.Edit;
                cdsFluCaiFLU_PEDVEN.Value := cdsFluCaiFLU_PEDVEN.Value + arrDuplicata[intContador].curValor;
              End
              Else
              Begin
                cdsFluCai.Append;
                cdsFluCaiFLU_AUTINC.AsString := FormatDateTime('yyyyMM', StrToDate(arrDuplicata[intContador].dtaDtaVen)) + IntToStr(WeekOf(StrToDate(arrDuplicata[intContador].dtaDtaVen)));
                cdsFluCaiFLU_DESCRI.AsString := FormatDateTime('yyyyMM', StrToDate(arrDuplicata[intContador].dtaDtaVen)) ;
                cdsFluCaiFLU_TABELA.Value    := 'PEDIDO';
                cdsFluCaiFLU_DTAVEN.Value    := StrToDate(arrDuplicata[intContador].dtaDtaVen);
                cdsFluCaiFLU_CHQPRE.Value    := 0;
                cdsFluCaiFLU_CTAREC.Value    := 0;
                cdsFluCaiFLU_MOVCAR.Value    := 0;
                cdsFluCaiFLU_CTAPAG.Value    := 0;
                cdsFluCaiFLU_PEDCOM.Value    := 0;
                cdsFluCaiFLU_ENTFLX.Value    := 'S';
                cdsFluCaiFLU_PRECOM.Value    := 0;
                cdsFluCaiFLU_PREVEN.Value    := 0;
                cdsFluCaiFLU_CTADES.Value    := 0;
                cdsFluCaiFLU_CTAIMP.Value    := 0;
                cdsFluCaiFLU_PEDVEN.Value    := arrDuplicata[intContador].curValor;
              End;
              cdsFluCai.Post;
            End;
          End;

          Next;
        End;

      End;

    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Pedidos de Compra...';
    frmWaitWindow.Refresh;

    {**************************}
    {* PEGA PEDIDO DE COMPRAS *}
    {***********************AF*}
    If blnPdFlux Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  G.AUTOINCREM, ';
      strSQL := strSQL + '  PCD_CODFOR, ';
      strSQL := strSQL + '  FOR_NOMFOR, ';

      If strCfgOrdemPedido = '1' Then
        strSQL := strSQL + '  PCD_DTAENT, '

      Else If strCfgOrdemPedido = '2' Then
        strSQL := strSQL + '  PCD_DTAPED AS PCD_DTAENT, '

      Else If strCfgOrdemPedido = '3' Then
        strSQL := strSQL + '  PCG_DTAFAT AS PCD_DTAENT, ';

      strSQL := strSQL + '  PCD_CONPAG, ';
      strSQL := strSQL + '  PCD_NUMPED, ';

      strSQL := strSQL + '  SUM((( PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
      strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
      strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
      strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
      strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
      strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
      strSQL := strSQL + '        * ( PCD_QTDITE - IF(PCD_ENTREG = "N" AND PCD_BAIXAD = 1, PCD_QTDITE, PCD_QTDBAI) )) * (1+((PCD_PERIPI)/100))) + (PCD_TOTSUB - PCD_SUBBAI)) AS VALOR, ';
      strSQL := strSQL + '  CONCAT("DOC: Documento: ", PCD_NUMPED, " Especie: ", PCD_ESPDOC, " Empresa: ", PCD_CODEMP, IF(PCD_NUMCTN IS NULL, "", " Container: "), IFNULL(PCD_NUMCTN, "")) AS DOCUME  ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  NOMDET  ';
      strSQL := strSQL + '  JOIN CADFOR   ON FOR_CODFOR = PCD_CODFOR ';

      strSQL := strSQL + '  JOIN NOMTAB G ON PCD_NUMPED = PCG_NUMPED '+
                         '               AND PCD_CODEMP = PCG_CODEMP '+
                         '               AND PCD_ESPDOC = PCG_ESPDOC '+
                         '               AND PCD_NUMCTN = PCG_NUMCTN ';

      If (Not blnInvFin) Or (fCampoExiste('PCG_' + fRetNumMesSelec, 'PCG_PEDBON')) Then
        strSQL := strSQL + '  AND IFNULL(PCG_PEDBON, "N") <> "S"';

      strSQL := strSQL + 'WHERE ';

      If fCfgSis('LIBPCM', varBoolean) Then
        strSQL := strSQL + '  PCG_PEDLIB IS NOT NULL AND ';

      strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
      strSQL := strSQL + '  PCG_BAIXAD = 0 AND ';
      strSQL := strSQL + '  PCD_BAIXAD = 0 AND ';
      strSQL := strSQL + '  PCD_ESPDOC <> "OR" AND ';
      strSQL := strSQL + '  (NOT LOCATE(PCD_CODFOR, :FORFIL) > 0) '; // NÃO COLOCA OS PEDIDOS DE COMPRA DE FILIAIS

      If Not fEmptyStr(edtCodEmp.Text) Then
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'IF(IFNULL(PCG_EMPDES,"") = "",PCD_CODEMP, PCG_EMPDES)', 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(IF(IFNULL(PCG_EMPDES,"") = "",PCD_CODEMP, PCG_EMPDES),' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  PCD_NUMPED, PCD_CODEMP ';

      If blnInvFin Then
           strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL,'NOMDET','PCD_' + fRetNumMesSelec),'NOMTAB','PCG_' + fRetNumMesSelec)
      Else strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL,'NOMDET','PCMDET'),'NOMTAB','PCMGER');

      With qryGenFlu Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('FORFIL').AsString := fRetForFilialTodos;
        //ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        //ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryGenFlu);

        Open;

        fltValorAcm := 0;
        While Not Eof Do
        Begin
          intQtdDup := 0;
          curTotalRes := 0;

          fDigDuplicSemTela(intQtdDup,
                     curTotalRes,
                     FieldByName('PCD_CONPAG').AsString,
                     FieldByName('PCD_NUMPED').AsInteger,
                     FieldByName('VALOR').AsFloat,
                     False,
                     False,
                     IfThen(strCfgOrdemPedido <> '1',
                         FieldByName('PCD_DTAENT').AsDateTime,
                         IfThen(FieldByName('PCD_DTAENT').AsDateTime < VS_Date,
                             VS_Date,
                             FieldByName('PCD_DTAENT').AsDateTime)),
                     False,
                     0,
                     'N',
                     True,
                     False,
                     0,
                     Nil,
                     False);

          For intContador := 0 To StrToIntDef(Copy(FieldByName('PCD_CONPAG').AsString,0,2), -1) -1 Do
          Begin

            If (StrToDate(arrDuplicata[intContador].dtaDtaVen) < StrToDate(mskDtaIni.Text)) Or
               (StrToDate(arrDuplicata[intContador].dtaDtaVen) > StrToDate(mskDtaFin.Text)) Then
            Begin

              If (StrToDate(arrDuplicata[intContador].dtaDtaVen) < StrToDate(mskDtaFin.Text)) Then
                fltValorAcm := fltValorAcm + arrDuplicata[intContador].curValor;

              Continue;
            End;

            If edtOpcao.Text = 'A' Then
            Begin
              cdsFluCai.Append;
              cdsFluCaiFLU_AUTINC.AsString := FieldByName('AUTOINCREM').AsString;
              cdsFluCaiFLU_TABELA.Value    := 'PCMGER';
              cdsFluCaiFLU_NUMDUP.Value    := '';
              cdsFluCaiFLU_ESPDOC.Value    := '';
              cdsFluCaiFLU_CODEMP.Value    := '';
              cdsFluCaiFLU_PARCEL.Value    := '';
              cdsFluCaiFLU_CODIGO.AsString := FieldByName('PCD_CODFOR').AsString;
              cdsFluCaiFLU_DESCRI.AsString := FieldByName('FOR_NOMFOR').AsString;
              cdsFluCaiFLU_DTAVEN.Value    := StrToDate(arrDuplicata[intContador].dtaDtaVen);
              cdsFluCaiFLU_CHQPRE.Value    := 0;
              cdsFluCaiFLU_CTAREC.Value    := 0;
              cdsFluCaiFLU_MOVCAR.Value    := 0;
              cdsFluCaiFLU_CTAPAG.Value    := 0;
              cdsFluCaiFLU_PEDCOM.Value    := arrDuplicata[intContador].curValor;
              cdsFluCaiFLU_ENTFLX.Value    := 'S';
              cdsFluCaiFLU_PRECOM.Value    := 0;
              cdsFluCaiFLU_PREVEN.Value    := 0;
              cdsFluCaiFLU_PEDVEN.Value    := 0;
              cdsFluCaiFLU_CTADES.Value    := 0;
              cdsFluCaiFLU_CTAIMP.Value    := 0;
              cdsFluCaiFLU_DOCUME.AsString := FieldByName('DOCUME').AsString;
              cdsFluCaiANOMES.AsString     := FormatDateTime('mmm/yyyy',StrToDate(arrDuplicata[intContador].dtaDtaVen));
              cdsFluCai.Post;
            End
            Else
            Begin
              If cdsFluCai.FindKey([StrToDate(arrDuplicata[intContador].dtaDtaVen)]) Then
              Begin
                cdsFluCai.Edit;
                cdsFluCaiFLU_PEDCOM.Value := cdsFluCaiFLU_PEDCOM.Value + arrDuplicata[intContador].curValor;
              End
              Else
              Begin
                cdsFluCai.Append;
                cdsFluCaiFLU_AUTINC.AsString := FormatDateTime('yyyyMM', StrToDate(arrDuplicata[intContador].dtaDtaVen)) + IntToStr(WeekOf(StrToDate(arrDuplicata[intContador].dtaDtaVen)));
                cdsFluCaiFLU_DESCRI.AsString := FormatDateTime('yyyyMM', StrToDate(arrDuplicata[intContador].dtaDtaVen)) ;
                cdsFluCaiFLU_TABELA.Value    := 'PCMGER';
                cdsFluCaiFLU_DTAVEN.Value    := StrToDate(arrDuplicata[intContador].dtaDtaVen);
                cdsFluCaiFLU_CHQPRE.Value    := 0;
                cdsFluCaiFLU_CTAREC.Value    := 0;
                cdsFluCaiFLU_MOVCAR.Value    := 0;
                cdsFluCaiFLU_CTAPAG.Value    := 0;
                cdsFluCaiFLU_PEDCOM.Value    := arrDuplicata[intContador].curValor;
                cdsFluCaiFLU_ENTFLX.Value    := 'S';
                cdsFluCaiFLU_PRECOM.Value    := 0;
                cdsFluCaiFLU_PREVEN.Value    := 0;
                cdsFluCaiFLU_PEDVEN.Value    := 0;
                cdsFluCaiFLU_CTADES.Value    := 0;
                cdsFluCaiFLU_CTAIMP.Value    := 0;
              End;
              cdsFluCai.Post;
            End;

          End;

          Next;
        End;

        If (fFormataFloat(fltValorAcm,2) > 0) And blnPdcAcm Then
        Begin
          cdsFluCai.Append;
          cdsFluCaiFLU_AUTINC.Value := '0';
          cdsFluCaiFLU_TABELA.Value := 'PCMGER';
          cdsFluCaiFLU_NUMDUP.Value := '';
          cdsFluCaiFLU_ESPDOC.Value := '';
          cdsFluCaiFLU_CODEMP.Value := '';
          cdsFluCaiFLU_PARCEL.Value := '';
          cdsFluCaiFLU_CODIGO.Value := '';
          cdsFluCaiFLU_DESCRI.Value := 'PEDIDOS DE COMPRA COM DATA ANTERIOR A INICIAL';
          cdsFluCaiFLU_DTAVEN.Value := StrToDate(mskDtaIni.Text);
          cdsFluCaiFLU_CHQPRE.Value := 0;
          cdsFluCaiFLU_CTAREC.Value := 0;
          cdsFluCaiFLU_MOVCAR.Value := 0;
          cdsFluCaiFLU_CTAPAG.Value := 0;
          cdsFluCaiFLU_PEDCOM.Value := fltValorAcm;
          cdsFluCaiFLU_ENTFLX.Value := 'S';
          cdsFluCaiFLU_PRECOM.Value := 0;
          cdsFluCaiFLU_PREVEN.Value := 0;
          cdsFluCaiFLU_PEDVEN.Value := 0;
          cdsFluCaiFLU_CTADES.Value := 0;
          cdsFluCaiFLU_CTAIMP.Value := 0;
          cdsFluCaiFLU_DOCUME.Value := '';
          cdsFluCai.Post;
        End;

        Close;
      End;
    End;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Ajustando datas...';
    frmWaitWindow.Refresh;

    If (fStrToFloat(edtPreVis.Text) > 0) Then
    Begin
      frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                        #13#10 + '    - Ajustando previsões diárias...';
      frmWaitWindow.Refresh;
      pInserePrevisaoDeVendaVista;
    End;

    If (fStrToFloat(edtPrePra.Text) > 0) Then
    Begin
      frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                        #13#10 + '    - Ajustando previsões diárias prazo...';
      frmWaitWindow.Refresh;
      pInserePrevisaoDeVendaPrazo;
    End;

    pMontaListaPorNEnt;

    cdsFluCai.Filter   := fGerarFiltro;
    cdsFluCai.Filtered := True;

    frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Ordenando registros...';
    frmWaitWindow.Refresh;

    pCriarListaSaldoPortadores();

    If Not cdsFluCai.IsEmpty Then
    Begin

      If (edtDestino.Text = 'E') Then   
      Begin
        If blnCtrCtp Then
          pGeraExcelFluxoCaixa(fltTotRec, fltTotPag)
        Else
          pGeraExcelFluxoCaixa;
        btnImprimir.Enabled := True;
        pnlInfo.Caption := '';
        Exit;
      End;

      frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                        #13#10 + '    - Criando relatório...';
      frmWaitWindow.Refresh;

      Try
        pCriarFormularios(TfrmQckBancFluxoCaixa,frmQckBancFluxoCaixa);

        if Not cdsLista.IsEmpty Then
        begin
          if strTipImp = 'M' Then
            frmQckBancFluxoCaixa.rllCaptionPortador.Caption := 'Portadores que nao entram no fluxo de caixa'
          else
            frmQckBancFluxoCaixa.rllCaptionPortador.Caption := 'Portadores que não entram no fluxo de caixa';

          frmQckBancFluxoCaixa.cdsListaPortadores  := cdsLista;
          frmQckBancFluxoCaixa.rllNomeForm.Visible := False;
        end
        else
        begin
          frmQckBancFluxoCaixa.RlbPortadores.Visible := False;
        end;

        frmQckBancFluxoCaixa.qryResumo := qryResumo;
        frmQckBancFluxoCaixa.cdsFluxoCaixa := cdsFluCai;
        frmQckBancFluxoCaixa.cdsSalPor     := cdsSalPor;
        frmQckBancFluxoCaixa.pAtribuiDataSet;
        frmQckBancFluxoCaixa.blnImpResumo := blnCtrCtp;
        frmQckBancFluxoCaixa.rllTotPorCtr.Caption := FloatToStrF(fltTotRec,ffNumber,15,2);
        frmQckBancFluxoCaixa.rllTotPorCtp.Caption := FloatToStrF(fltTotPag,ffNumber,15,2);

        frmQckBancFluxoCaixa.pnlCtpVen.Visible := blnCtrCtp;
        frmQckBancFluxoCaixa.pnlCtrVen.Visible := blnCtrCtp;

        {*****************************}
        {* FILTRO - INCLUIR PREVISÃO *}
        {**************************JB*}
        frmQckBancFluxoCaixa.blnIncPre := blnIncPre;
        frmQckBancFluxoCaixa.blnPdFlux := blnPdFlux;

        If strTipImp = 'M' Then
          frmQckBancFluxoCaixa.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckBancFluxoCaixa.qckPagina.DefaultFilter := Nil;

        frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                      #13#10 + '    - Preenchendo campos...';
        frmWaitWindow.Refresh;

        frmQckBancFluxoCaixa.strOrdem                 := 'REFERENTE AO ' + ifThen(strTipImp = 'M', 'PERIODO', 'PERÍODO') + ' DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
        frmQckBancFluxoCaixa.rllSaldoInicial.Caption  := 'SALDO INICIAL:';
        frmQckBancFluxoCaixa.rllCtrVen.Caption        := FloatToStrF(fltTotRec,ffNumber,15,2);
        frmQckBancFluxoCaixa.rllCtpVen.Caption        := FloatToStrF(fltTotPag,ffNumber,15,2);
        frmQckBancFluxoCaixa.fltSalIni                := fStrToFloat(edtSalIni.Text) + fltTotRec - fltTotPag;
        frmQckBancFluxoCaixa.rllSalIni.Caption        := edtSalIni.Text;
        frmQckBancFluxoCaixa.fltFator                 := StringToFloat(edtFator.Text);

        frmQckBancFluxoCaixa.subSalPor.Visible := blnSalPor;

        If Not(strTipImp = 'M') Then
        Begin
          frmQckBancFluxoCaixa.rllPagina.Caption := 'PÁGINA';
          frmQckBancFluxoCaixa.rllChqPre.Caption := 'CHQ PRÉ';
          frmQckBancFluxoCaixa.rllChqPre2.Caption := 'CHQ PRÉ';
          frmQckBancFluxoCaixa.rllVarDiaria.Caption := 'V.DIÁRIA';
          frmQckBancFluxoCaixa.rllVarDiaria2.Caption := 'V.DIÁRIA';
          frmQckBancFluxoCaixa.rllTotMes.Caption := 'TOTAL MÊS:';
        End;

        If fEmptyStr(edtCodEmp.Text) Then
          frmQckBancFluxoCaixa.rllFilEmp.Caption        := 'EMPRESA: TODAS'
        Else
          frmQckBancFluxoCaixa.rllFilEmp.Caption        := fStrTitulo(edtCodEmp.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');

        If fEmptyStr(edtCodPor.Text) Then
          frmQckBancFluxoCaixa.rllFilPor.Caption        := 'PORTADOR: TODAS'
        Else
          frmQckBancFluxoCaixa.rllFilPor.Caption        := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR');

        If edtOpcao.Text = 'A' Then
        Begin
          frmQckBancFluxoCaixa.rllNomeRelatorio.Caption := ifThen(strTipImp = 'M', 'RELATORIO DE FLUXO DE CAIXA - ANALITICO ', 'RELATÓRIO DE FLUXO DE CAIXA - ANALÍTICO ');
          frmQckBancFluxoCaixa.rlbTitulo.Visible        := True;
          frmQckBancFluxoCaixa.rlbSaldo.Visible         := True;
          frmQckBancFluxoCaixa.rlbGrupo.Visible         := True;
        End
        Else
        Begin
          frmQckBancFluxoCaixa.rllNomeRelatorio.Caption  := ifThen(strTipImp = 'M', 'RELATORIO DE FLUXO DE CAIXA - SINTETICO', 'RELATÓRIO DE FLUXO DE CAIXA - SINTÉTICO');
          frmQckBancFluxoCaixa.rlbTitulo2.Visible        := True;
          frmQckBancFluxoCaixa.rlbSaldo.Visible          := True;
          frmQckBancFluxoCaixa.rlbGrupoSintetico.Visible := True;
        End;

        frmQckBancFluxoCaixa.rllNomeRelatorio.Caption := frmQckBancFluxoCaixa.rllNomeRelatorio.Caption;

        frmQckBancFluxoCaixa.rllFatDes.Caption := 'FATOR DESC. C. RECEBER: ' + edtFator.Text;
        frmQckBancFluxoCaixa.rllDiaCar.Caption := 'DIAS P/ CONS. ' + ifThen(strTipImp = 'M', 'CARTOES','CARTÕES') + ' REC.: ' + edtDiaCRe.Text;
        frmQckBancFluxoCaixa.rllDiaChq.Caption := 'DIAS P/ CONS. CHEQUES DEP.: ' + edtDiaCDe.Text;
        frmQckBancFluxoCaixa.rllDiaCtr.Caption := 'DIAS P/ COMPUTAR NO CONTAS A RECEBER: ' + edtDiaRec.Text;
        frmQckBancFluxoCaixa.rllLimDia.Caption := 'LIMITE DE DIAS DE ATRASO PARA CONSIDERAR CTP / CTR VENCIDOS: ' + edtLimiteDias.Text;
        frmQckBancFluxoCaixa.rllPreDVi.Caption := ifThen(strTipImp = 'M', 'PREVISAO DIARIA DE VENDA A VISTA: ' + edtPreVis.Text, 'PREVISÃO DIÁRIA DE VENDA À VISTA: ' + edtPreVis.Text);
        frmQckBancFluxoCaixa.rllPreDPr.Caption := ifThen(strTipImp = 'M','PREVISAO DIARIA','PREVISÃO DIÁRIA') + ' DE VENDA A PRAZO: ' + edtPrePra.Text + ' A PARTIR DE ' + edtPeriod.Text + ' DIAS ';
        frmQckBancFluxoCaixa.rllTipEmp.Caption := 'EMPRESA DE ' + IfThen(rdgEmpresa.ItemIndex = 0, 'FATURAMENTO', 'ORIGEM');

        If Not blnSepCtp Then
        Begin
          frmQckBancFluxoCaixa.pnlI1.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI2.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI3.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI4.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI5.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI6.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI7.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;
          frmQckBancFluxoCaixa.pnlI8.Left := frmQckBancFluxoCaixa.rllTpagar1.Left;

          frmQckBancFluxoCaixa.rllTpagar1.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar2.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar3.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar4.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar5.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar6.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar7.Visible := False;
          frmQckBancFluxoCaixa.rllTpagar8.Visible := False;

          frmQckBancFluxoCaixa.pnl1.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl2.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl3.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl4.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl5.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl6.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl7.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl8.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl9.Left  := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl10.Left := frmQckBancFluxoCaixa.rllCadPag1.Left;
          frmQckBancFluxoCaixa.pnl11.Left := frmQckBancFluxoCaixa.rllCadPag1.Left;

          frmQckBancFluxoCaixa.rllCadPag1.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag2.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag3.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag4.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag5.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag6.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag7.Visible := False;
          frmQckBancFluxoCaixa.rllCadPag8.Visible := False;

          frmQckBancFluxoCaixa.rllImposto.Visible := False;
          frmQckBancFluxoCaixa.rllImposto2.Visible := False;
          frmQckBancFluxoCaixa.rllImposto3.Visible := False;
          frmQckBancFluxoCaixa.rllImposto4.Visible := False;
          frmQckBancFluxoCaixa.rllImposto5.Visible := False;
          frmQckBancFluxoCaixa.rllImposto6.Visible := False;
          frmQckBancFluxoCaixa.rllImposto7.Visible := False;
          frmQckBancFluxoCaixa.rllImposto8.Visible := False;
          
          frmQckBancFluxoCaixa.qckPagina.PageSetup.Orientation := poPortrait;

          If (blnSalPor) Then Begin
            With frmQckBancFluxoCaixa Do Begin
              rllTitCodPor.Left    := rllTitSalPort.Left;
              rllTitNomPor.Left    := rllTitCodPor.Left  + rllTitCodPor.Width;
              rllTitSalPor.Left    := rllTitNomPor.Left  + rllTitNomPor.Width  - 3;
              rllCodPor.Left       := rllTitSalPort.Left;
              rllNomSalPor.Left    := rllTitCodPor.Left  + rllTitCodPor.Width;
              rllSalPor.Left       := rllTitNomPor.Left  + rllTitNomPor.Width  - 3;
              rllFtrSalPor.Left    := (rllTitNomPor.Left + rllTitNomPor.Width) - rllFtrSalPor.Width;
              rllFtrValSalPor.Left := rllTitNomPor.Left  + rllTitNomPor.Width  - 3;
            End;
          End;
        End
        Else
        Begin
          frmQckBancFluxoCaixa.rllCtaPagar.Caption := 'CTP.FORNEC.';
          frmQckBancFluxoCaixa.rllCtaPagar2.Caption := 'CTP.FORNEC.';
        End;

        If blnPdcAcm Then
        Begin
          frmQckBancFluxoCaixa.rllTextoLeg.Caption   := '* Valores de pedidos de compra não baixados acumulados no dia ' + FormatDateTime('dd/mm/yy',fAjustaVencimento(StrToDate(mskDtaIni.Text), False));
          frmQckBancFluxoCaixa.rllPedCompra.Caption  := 'PED.COM*';
          frmQckBancFluxoCaixa.rllPedCompra2.Caption := 'PED.COM*';
        End
        Else
          frmQckBancFluxoCaixa.rllTextoLeg.Caption := '';

        If Not blnQbrDia Then
        Begin
          frmQckBancFluxoCaixa.rlbResumoGrupo.Visible := False;
          frmQckBancFluxoCaixa.RLBand1.Visible := False;
          frmQckBancFluxoCaixa.RLBand2.Visible := False;

          IF (blnQbrMes) And (edtOpcao.Text = 'A') Then
          Begin
            frmQckBancFluxoCaixa.rlbResumoGrupo.Visible := True;
            frmQckBancFluxoCaixa.blnQbrMes := blnQbrMes;
            frmQckBancFluxoCaixa.rlbGrupo.DataFields := 'ANOMES';
          End

          Else IF (blnQbrMes) And (edtOpcao.Text = 'S') Then
          Begin
            frmQckBancFluxoCaixa.RLBand2.Visible := True;
            frmQckBancFluxoCaixa.blnQbrMes := blnQbrMes;
          End;

        End
        Else
        Begin
          frmQckBancFluxoCaixa.rlbResumoGrupo.Visible := True;
          frmQckBancFluxoCaixa.RLBand1.Visible := True;
          frmQckBancFluxoCaixa.RLBand2.Visible := True;
        End;

        Application.ProcessMessages;

        If edtDestino.Text = 'V' Then
          frmQckBancFluxoCaixa.qckPagina.PreviewModal
        Else
          frmQckBancFluxoCaixa.qckPagina.Print;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckBancFluxoCaixa);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);

  FreeAndNil(qryGenCai);
  FreeAndNil(qryGenFlu);

end;

procedure TfrmRelBancFluxoCaixa.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelBancFluxoCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryGenPor);
  FreeAndNil(qryResumo);
  cdsFluCai.Close;
  cdsSalPor.Close;

  FreeAndNil(cdsLista);
  FreeAndNil(stlCadFer);
end;

procedure TfrmRelBancFluxoCaixa.FormCreate(Sender: TObject);
  Var
    qryGen: TUniQuery;
begin
  inherited;
  intAtuLst := -1;

  qryGenPor := fCriaQuery(Self);
  qryResumo := fCriaQuery(Self);
  cdsLista  := TUniClientDataSet.Create(Self);

  With cdsLista.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FLU_CODIGO';
    DataType := ftString;
    Size     := 8;
  end;

  With cdsLista.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FLU_DESCRI';
    DataType := ftString;
    Size     := 50;
  end;

  cdsLista.CreateDataSet;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  cdsFluCai.CreateDataSet;
  cdsFluCai.EmptyDataSet;
  cdsFluCai.IndexFieldNames := 'FLU_DTAVEN';
  dsListaPortadores.DataSet := cdsLista;

  With cbxChecks Do
  Begin
    Items.Clear;
    Items.Add('Incluir Previsão');
    Checked[0] := True;

    Items.Add('Utilizar inventário financeiro');

    Items.Add('Considerar Pedido de Compra');
    Checked[2] := (fCfgSis('PDFLUX') = 'S');

    Items.Add('Considerar Pedido de Venda');
    Checked[3] := (fCfgSis('PDVFLX') = 'S');

    Items.Add('Separar coluna do Cta.Pag. em Fornecedores e Despesas');
    Items.Add('Exibir Cta.Receber / Cta.Pagar Vencidos (Apenas Sintético)');

    Items.Add('Quebrar por dia');
    Checked[6] := True;

    Items.Add('Quebrar por mês (Analítico apenas sem quebra por dia)');
    Checked[7] := False;

    Items.Add('Considerar Previsões Diárias no Sábado');
    Checked[8] := True;

    Items.Add('Mostrar os ped. compra em aberto anterior a data inicial acumulados');
    Checked[9] := False;

    Items.Add('Exibir listagem de saldo dos portadores');
    Checked[10] := False;
  End;
  cbxChecksClickCheck(Sender);

  {**************************}
  {* CARREGANDO OS FERIADOS *}
  {***********************AF*}
  stlCadFer := TStringList.Create;
  Try
    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT       ');
    qryGen.SQL.Add('   FER_DTAFER ');
    qryGen.SQL.Add(' FROM         ');
    qryGen.SQL.Add('   CADFER     ');
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      stlCadFer.Add(FormatDateTime('dd/mm/yyyy',qryGen.FieldByName('FER_DTAFER').AsDateTime));
      qryGen.Next;
    End;

    qryGen.Close;
  Except
    On E:Exception Do
      pMensagensErro(E.Message, 'TfrmRelBancFluxoCaixa.FormCreate');
  End;
  FreeAndNil(qryGen);

  blnSalPor := False;
end;

procedure TfrmRelBancFluxoCaixa.pGeraExcelFluxoCaixa(fltRecVen: Double = 0; fltPagVen: Double = 0);
  Var
    objExcel: TExcel;
    intLinha : Integer;
    intQtdCol: Integer;
    intCont  : Integer;
    blnAnalitico: Boolean;
    dtaDtaAtu: TDateTime;

    fltVDiari: Double;
    fltSalIni: Double;

    fltFator: Double;

    strTitulo: String;
    arrAnalitico: Array Of String;
    arrSintetico: Array Of String;

    {*******************************************}
    {* VALORES DO DIA                          *}
    {****************************************MV*}
    fltPreCom: Double;
    fltPreVen: Double;
    fltChqPre: Double;
    fltCtaRec: Double;
    fltCarCre: Double;
    fltCtaPag: Double;
    fltCtaDes: Double;
    fltCtaImp: Double;
    fltPedCom: Double;
    fltVarDia: Double;
    fltPedVen: Double;
    fltPedVe2: Double;
    fltTReceb: Double;
    fltTRece2: Double;
    fltTPagar: Double;

    {*******************************************}
    {* VALORES TOTAIS                          *}
    {****************************************MV*}
    fltTotCom: Double;
    fltTotVen: Double;
    fltTotChq: Double;
    fltTotRec: Double;
    fltTotCar: Double;
    fltTotPag: Double;
    fltTotDes: Double;
    fltTotImp: Double;
    fltTotPed: Double;
    fltTotVar: Double;
    fltTotPVn: Double;
    fltTotTRc: Double;
    fltTotPgr: Double;

    fltSalPor: Double;

begin

  fltTotCom := 0.0;
  fltTotVen := 0.0;
  fltTotChq := 0.0;
  fltTotRec := 0.0;
  fltTotCar := 0.0;
  fltTotPag := 0.0;
  fltTotDes := 0.0;
  fltTotImp := 0.0;
  fltTotPed := 0.0;
  fltTotVar := 0.0;
  fltTotPVn := 0.0;
  fltTotTRc := 0.0;
  fltTotPgr := 0.0;

  fltSalIni := fStrToFloat(edtSalIni.Text);
  fltFator  := fStrToFloat(edtFator.Text);

  If blnSepCtp Then
  Begin
    SetLength(arrAnalitico, 18);
    SetLength(arrSintetico, 15);
  End
  Else
  Begin
    SetLength(arrAnalitico, 15);
    SetLength(arrSintetico, 12);
  End;

  arrAnalitico[00] := 'DATA';
  arrAnalitico[01] := 'CODIGO';
  arrAnalitico[02] := 'CLIENTE / FORNECEDOR';
  arrAnalitico[03] := 'DOCUMENTO';
  arrAnalitico[04] := 'PREV. CTP.';
  arrAnalitico[05] := 'PREV. CTR.';
  arrAnalitico[06] := 'CHEQUE PRE';
  arrAnalitico[07] := 'CTA. REC.';
  arrAnalitico[08] := 'PED. VEN.';
  arrAnalitico[09] := 'CRT. CRED.';
  arrAnalitico[10] := 'T. RECEBER';
  If blnSepCtp Then
  Begin
    arrAnalitico[11] := 'CTP.FORNEC.';
    arrAnalitico[12] := 'CTP.DESPES.';
    arrAnalitico[13] := 'CTP.IMPOSTO';
    arrAnalitico[14] := 'PED. COM.' + IfThen(blnPdcAcm,'*','');
    arrAnalitico[15] := 'T. PAGAR';
    arrAnalitico[16] := 'V. DIARIA';
    arrAnalitico[17] := 'SALDO';
  End
  Else
  Begin
    arrAnalitico[11] := 'C. PAGAR';
    arrAnalitico[12] := 'PED. COM.' + IfThen(blnPdcAcm,'*','');
    arrAnalitico[13] := 'V. DIARIA';
    arrAnalitico[14] := 'SALDO';
  End;

  arrSintetico[00] := 'DATA';
  arrSintetico[01] := 'PREV. CTP.';
  arrSintetico[02] := 'PREV. CTR.';
  arrSintetico[03] := 'CHEQUE PRE';
  arrSintetico[04] := 'CTA. REC.';
  arrSintetico[05] := 'PED. VEN.';
  arrSintetico[06] := 'CRT. CRED.';
  arrSintetico[07] := 'T. RECEBER';
  If blnSepCtp Then
  Begin
    arrSintetico[08] := 'CTP.FORNEC.';
    arrSintetico[09] := 'CTP.DESPES.';
    arrSintetico[10] := 'CTP.IMPOSTO';
    arrSintetico[11] := 'PED. COM.' + IfThen(blnPdcAcm,'*','');
    arrSintetico[12] := 'T. PAGAR';
    arrSintetico[13] := 'V. DIARIA';
    arrSintetico[14] := 'SALDO';
  End
  Else
  Begin
    arrSintetico[08] := 'C. PAGAR';
    arrSintetico[09] := 'PED. COM.' + IfThen(blnPdcAcm,'*','');
    arrSintetico[10] := 'V. DIARIA';
    arrSintetico[11] := 'SALDO';
  End;

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************MV*}
  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;
  {********************************}
  {* EMPRESA PADRAO DO SISTEMA    *}
  {*****************************MV*}
  objExcel.LinhaAtual := 01;
  objExcel.Escrever(objExcel.ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

  blnAnalitico := edtOpcao.Text = 'A';

  If blnAnalitico Then
    strTitulo := 'RELATÓRIO DE FLUXO DE CAIXA - ANALÍTICO '
  Else
    strTitulo := 'RELATÓRIO DE FLUXO DE CAIXA - SINTÉTICO ';

  {*******************************************}
  {* TITULO DO RELATORIO                     *}
  {****************************************MV*}
  objExcel.Escrever(objExcel.ProximaLinha, 01, strTitulo);
  {*******************************************}
  {* OUTROS DADOS DO RELATÓRIO               *}
  {****************************************MV*}
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'FATOR DESC. C. RECEBER: ' + edtFator.Text);
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'DIAS P/ CONS. CARTÕES REC.: ' + edtDiaCRe.Text);
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'DIAS P/ CONS. CHEQUES DEP.: ' + edtDiaCDe.Text);
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'DIAS P/ COMPUTAR NO CONTAS A RECEBER: ' + edtDiaRec.Text);
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'LIMITE DE DIAS DE ATRASO PARA CONSIDERAR CTP / CTR VENCIDOS: ' + edtLimiteDias.Text);
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'PREVISÃO DIÁRIA DE VENDA À VISTA: ' + edtPreVis.Text);
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'PREVISÃO DIÁRIA DE VENDA A PRAZO: ' + edtPrePra.Text + ' A PARTIR DE ' + edtPeriod.Text + ' DIAS ');
  objExcel.Escrever(objExcel.ProximaLinha, 01, 'EMPRESA DE ' + IfThen(rdgEmpresa.ItemIndex = 0, 'FATURAMENTO', 'ORIGEM'));

  If fEmptyStr(edtCodEmp.Text) Then
    objExcel.Escrever(objExcel.ProximaLinha, 01, 'EMPRESA: TODAS')
  Else
    objExcel.Escrever(objExcel.ProximaLinha, 01, fStrTitulo(edtCodEmp.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA'));

  If fEmptyStr(edtCodPor.Text) Then
    objExcel.Escrever(objExcel.ProximaLinha, 01, 'PORTADOR: TODAS')
  Else
    objExcel.Escrever(objExcel.ProximaLinha, 01, fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR'));

  objExcel.Escrever(objExcel.ProximaLinha, 01, 'REFERENTE AO PERÍODO DE '+ mskDtaIni.Text + ' A ' + mskDtaFin.Text);

  {********************************}
  {* COLOCA EM NEGRITO E ALINHA   *}
  {* AO CENTRO DA CELULA          *}
  {*****************************MV*}
  For intLinha := 1 To objExcel.LinhaAtual Do
  Begin
    objExcel.Mesclar('A' + IntToStr(intLinha), IfThen(blnSepCtp,'R','O') + IntToStr(intLinha));
    objExcel.Negrito('A' + IntToStr(intLinha), IfThen(blnSepCtp,'R','O') + IntToStr(intLinha), True);
    objExcel.Alinhamento('A' + IntToStr(intLinha), IfThen(blnSepCtp,'R','O') + IntToStr(intLinha), Centro);
  End;

  objExcel.ProximaLinha;

  {*******************************************}
  {* COLUNAS                                 *}
  {****************************************MV*}
  intQtdCol := Length(arrAnalitico);
  If(blnAnalitico) Then
  Begin
    For intCont := 1 To intQtdCol Do
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, intCont, arrAnalitico[intCont - 1]);
      objExcel.Negrito(objExcel.LinhaAtual, intCont, True);
    End;
  End
  Else
  Begin
    objExcel.Escrever(objExcel.LinhaAtual, 01, arrSintetico[00]);
    objExcel.Escrever(objExcel.LinhaAtual, 04, arrSintetico[01]);
    objExcel.Escrever(objExcel.LinhaAtual, 05, arrSintetico[02]);
    objExcel.Escrever(objExcel.LinhaAtual, 06, arrSintetico[03]);
    objExcel.Escrever(objExcel.LinhaAtual, 07, arrSintetico[04]);
    objExcel.Escrever(objExcel.LinhaAtual, 08, arrSintetico[05]);
    objExcel.Escrever(objExcel.LinhaAtual, 09, arrSintetico[06]);
    objExcel.Escrever(objExcel.LinhaAtual, 10, arrSintetico[07]);
    objExcel.Escrever(objExcel.LinhaAtual, 11, arrSintetico[08]);
    objExcel.Escrever(objExcel.LinhaAtual, 12, arrSintetico[09]);
    objExcel.Escrever(objExcel.LinhaAtual, 13, arrSintetico[10]);
    objExcel.Escrever(objExcel.LinhaAtual, 14, arrSintetico[11]);
    If blnSepCtp Then
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 15, arrSintetico[12]);
      objExcel.Escrever(objExcel.LinhaAtual, 16, arrSintetico[13]);
      objExcel.Escrever(objExcel.LinhaAtual, 17, arrSintetico[14]);
    End;

    objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));

    For intCont := 1 To intQtdCol Do
    Begin
      objExcel.Negrito(objExcel.LinhaAtual, intCont, True);
    End;
  End;

  {*******************************************}
  {* COLOCA NEGRITO NAS COLUNAS              *}
  {****************************************MV*}
  objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual), Centro);

  {*************************************}
  {* COLORI O FUNDO DA CELULA P/ CINZA *}
  {**********************************MV*}
  objExcel.CorFundo('A2', IfThen(blnSepCtp,'R2','O2'), Cinza);
  objExcel.CorFonte('A1', IfThen(blnSepCtp,'R2','O2'), Preto);
  objExcel.CorFundo('A3', IfThen(blnSepCtp,'R3','O3'), Cinza);
  objExcel.CorFonte('A3', IfThen(blnSepCtp,'R3','O3'), Preto);
  objExcel.CorFundo('A' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual), Cinza);
  objExcel.CorFonte('A' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual), Preto);

  {********************************}
  {* INSERE BORDAS NA CELULA      *}
  {*****************************MV*}
  objExcel.Bordas('A2', IfThen(blnSepCtp,'R2','O2'));
  objExcel.Bordas('A3', IfThen(blnSepCtp,'R3','O3'));
  //objExcel.Bordas('A5', IfThen(blnSepCtp,'R5','O5'));
  objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual));
  objExcel.ProximaLinha;

  If blnCtrCtp then
  Begin
    With qryResumo Do
    Begin
      First;

      While Not Eof Do
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 06, FloatToStrF(qryResumo.FieldByName('VALDUP').AsFloat, ffNumber, 12, 2));
        objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'E' + IntToStr(objExcel.LinhaAtual));
        objExcel.Escrever(objExcel.LinhaAtual, 01, qryResumo.FieldByName('NOMPOR').AsString);
        objExcel.Alinhamento('F' + IntToStr(objExcel.LinhaAtual), 'G' + IntToStr(objExcel.LinhaAtual), Direita);

        Next;

        objExcel.ProximaLinha;
      End;
    End;

    If blnSepCtp Then
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 14, 'CTR VENCIDO:');
      objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltRecVen, ffFixed, 12, 2));
      objExcel.Mesclar('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.ProximaLinha;

      objExcel.Escrever(objExcel.LinhaAtual, 14, 'CTP VENCIDO:');
      objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltPagVen, ffFixed, 12, 2));
      objExcel.Mesclar('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.ProximaLinha;

      objExcel.Escrever(objExcel.LinhaAtual, 14, 'SALDO INICIAL:');
      If (blnAnalitico) Then
        objExcel.Escrever(objExcel.LinhaAtual, 18, FloatToStrF(fltSalIni, ffFixed, 12, 2))
      Else
        objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      objExcel.Mesclar('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
    End
    Else
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 12, 'CTR VENCIDO:');
      objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltRecVen, ffFixed, 12, 2));
      objExcel.Mesclar('K' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('K' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('K' + IntToStr(objExcel.LinhaAtual), 'N' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.ProximaLinha;

      objExcel.Escrever(objExcel.LinhaAtual, 12, 'CTP VENCIDO:');
      objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltPagVen, ffFixed, 12, 2));
      objExcel.Mesclar('K' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('K' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('K' + IntToStr(objExcel.LinhaAtual), 'N' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.ProximaLinha;

      objExcel.Escrever(objExcel.LinhaAtual, 12, 'SALDO INICIAL:');
      If (blnAnalitico) Then
        objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltSalIni, ffFixed, 12, 2))
      Else
        objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      objExcel.Mesclar('K' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('K' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('K' + IntToStr(objExcel.LinhaAtual), 'N' + IntToStr(objExcel.LinhaAtual), Direita);
    End;

    objExcel.ProximaLinha;
  End
  Else
  Begin

    If blnSepCtp Then
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 14, 'SALDO INICIAL:');
      If (blnAnalitico) Then
        objExcel.Escrever(objExcel.LinhaAtual, 18, FloatToStrF(fltSalIni, ffFixed, 12, 2))
      Else
        objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('N' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
    End
    Else
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 12, 'SALDO INICIAL:');
      If (blnAnalitico) Then
        objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltSalIni, ffFixed, 12, 2))
      Else
        objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual));
      objExcel.Negrito('A' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), True);
      objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'L' + IntToStr(objExcel.LinhaAtual), Direita);
      objExcel.Alinhamento('K' + IntToStr(objExcel.LinhaAtual), 'N' + IntToStr(objExcel.LinhaAtual), Direita);
    End;

    objExcel.ProximaLinha;
  End;

  With cdsFluCai Do
  Begin
    First;
    dtaDtaAtu := FieldByName('FLU_DTAVEN').AsDateTime;

    fltSalIni := fltSalIni + fltRecVen - fltPagVen;

    While (Not Eof) Do
    Begin

      fltPreCom := 0.0;
      fltPreVen := 0.0;
      fltChqPre := 0.0;
      fltCtaRec := 0.0;
      fltCarCre := 0.0;
      fltCtaPag := 0.0;
      fltCtaDes := 0.0;
      fltCtaImp := 0.0;
      fltPedCom := 0.0;
      fltVarDia := 0.0;
      fltPedVe2 := 0.0;
      fltTRece2 := 0.0;
      fltTPagar := 0.0;

      While (Not Eof) And (dtaDtaAtu = FieldByName('FLU_DTAVEN').AsDateTime) Do
      Begin

        If blnIncPre Then
        Begin
          If blnPdvFlux Then
          Begin
            fltVDiari := FieldByName('FLU_CHQPRE').AsFloat +
                        (FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                         FieldByName('FLU_MOVCAR').AsFloat -
                         FieldByName('FLU_CTAPAG').AsFloat -
                         FieldByName('FLU_CTADES').AsFloat -
                         FieldByName('FLU_CTAIMP').AsFloat -
                         Math.IfThen(blnPdFlux,FieldByName('FLU_PEDCOM').AsFloat,0) -
                         //IfThen(Not blnPdFlux,0,FieldByName('FLU_PEDCOM').AsFloat) -
                         FieldByName('FLU_PRECOM').AsFloat +
                         FieldByName('FLU_PREVEN').AsFloat +
                         FieldByName('FLU_PEDVEN').AsFloat;


          End
          Else
          Begin
            fltVDiari := FieldByName('FLU_CHQPRE').AsFloat +
                         (FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                         FieldByName('FLU_MOVCAR').AsFloat -
                         FieldByName('FLU_CTAPAG').AsFloat -
                         FieldByName('FLU_CTADES').AsFloat -
                         FieldByName('FLU_CTAIMP').AsFloat -
                         IfThen(fCfgSis('PDFLUX') = '',0,FieldByName('FLU_PEDCOM').AsFloat) -
                         FieldByName('FLU_PRECOM').AsFloat +
                         FieldByName('FLU_PREVEN').AsFloat;
          End;
        End
        Else
        Begin
          If  blnPdvFlux Then
          Begin
            fltVDiari := FieldByName('FLU_CHQPRE').AsFloat +
                        (FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                         FieldByName('FLU_MOVCAR').AsFloat -
                         FieldByName('FLU_CTAPAG').AsFloat -
                         FieldByName('FLU_CTADES').AsFloat -
                         FieldByName('FLU_CTAIMP').AsFloat -
                         IfThen(Not blnPdFlux,0,FieldByName('FLU_PEDCOM').AsFloat) +
                         FieldByName('FLU_PEDVEN').AsFloat;
          End
          Else
          Begin
            fltVDiari := FieldByName('FLU_CHQPRE').AsFloat +
                        (FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                         FieldByName('FLU_MOVCAR').AsFloat -
                         FieldByName('FLU_CTAPAG').AsFloat -
                         FieldByName('FLU_CTADES').AsFloat -
                         FieldByName('FLU_CTAIMP').AsFloat -
                         IfThen(fCfgSis('PDFLUX') = '',0,FieldByName('FLU_PEDCOM').AsFloat);
          End;
        End;

        fltSalIni := fltSalIni + fltVDiari;

        // ATENÇÃO NÃO USAR A FORMATAÇÃO ABAIXO. DUVIDAS FALAR COM ALEXANDRE. BROFF
        //objExcel.Escrever(objExcel.LinhaAtual, 01, FormatDateTime('mm/dd/yyyy', FieldByName('FLU_DTAVEN').AsDateTime));
        objExcel.Escrever(objExcel.LinhaAtual, 01, FormatDateTime('dd/mm/yyyy', FieldByName('FLU_DTAVEN').AsDateTime));

        If(blnAnalitico) Then
        Begin
          objExcel.Escrever(objExcel.LinhaAtual, 02, FieldByName('FLU_CODIGO').AsString);
          objExcel.Escrever(objExcel.LinhaAtual, 03, FieldByName('FLU_DESCRI').AsString);
          If (blnAnalitico) Then
            objExcel.Escrever(objExcel.LinhaAtual, 04, FieldByName('FLU_DOCUME').AsString);
        End;

        If Not blnIncPre Then
        Begin
          If (blnAnalitico) Then
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 05, '0,00');
            objExcel.Escrever(objExcel.LinhaAtual, 06, '0,00');
          End
          Else
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 04, '0,00');
            objExcel.Escrever(objExcel.LinhaAtual, 05, '0,00');
          End;
        End
        Else
        Begin
          If (blnAnalitico) Then
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 05, FloatToStrF(FieldByName('FLU_PRECOM').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 06, FloatToStrF(FieldByName('FLU_PREVEN').AsFloat, ffFixed, 12, 2));
          End
          Else
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 04, FloatToStrF(FieldByName('FLU_PRECOM').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 05, FloatToStrF(FieldByName('FLU_PREVEN').AsFloat, ffFixed, 12, 2));
          End;
        End;

        If (blnAnalitico) Then
        Begin
          objExcel.Escrever(objExcel.LinhaAtual, 07, FloatToStrF(FieldByName('FLU_CHQPRE').AsFloat, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 08, FloatToStrF(FieldByName('FLU_CTAREC').AsFloat * fltFator, ffFixed, 12, 2));
          If Not blnPdvFlux Then
            objExcel.Escrever(objExcel.LinhaAtual, 09, FloatToStrF(0, ffFixed, 12, 2))
          Else
            objExcel.Escrever(objExcel.LinhaAtual, 09, FloatToStrF(FieldByName('FLU_PEDVEN').AsFloat, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 10, FloatToStrF(FieldByName('FLU_MOVCAR').AsFloat, ffFixed, 12, 2));
        End
        Else
        Begin
          objExcel.Escrever(objExcel.LinhaAtual, 06, FloatToStrF(FieldByName('FLU_CHQPRE').AsFloat, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 07, FloatToStrF(FieldByName('FLU_CTAREC').AsFloat * fltFator, ffFixed, 12, 2));
          If Not blnPdvFlux Then
            objExcel.Escrever(objExcel.LinhaAtual, 08, FloatToStrF(0, ffFixed, 12, 2))
          Else
            objExcel.Escrever(objExcel.LinhaAtual, 08, FloatToStrF(FieldByName('FLU_PEDVEN').AsFloat, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 9, FloatToStrF(FieldByName('FLU_MOVCAR').AsFloat, ffFixed, 12, 2));
        End;

        If Not blnPdvFlux Then
          fltPedVen := 0
        Else
          fltPedVen := FieldByName('FLU_PEDVEN').AsFloat;

        fltTReceb := FieldByName('FLU_CHQPRE').AsFloat +
                    (FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                     FieldByName('FLU_MOVCAR').AsFloat +
                     fltPedVen;

        If blnSepCtp Then
        Begin

          If (blnAnalitico) Then
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 11, FormatFloat('##,#0.00', fltTReceb));
            objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(FieldByName('FLU_CTAPAG').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(FieldByName('FLU_CTADES').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(FieldByName('FLU_CTAIMP').AsFloat, ffFixed, 12, 2));
            If blnPdFlux Then
              objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(FieldByName('FLU_PEDCOM').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 16, FloatToStrF(FieldByName('FLU_CTAPAG').AsFloat +
                                                                   FieldByName('FLU_CTADES').AsFloat +
                                                                   FieldByName('FLU_CTAIMP').AsFloat +
                                                                   IfThen(blnPdFlux, FieldByName('FLU_PEDCOM').AsFloat, 0), ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltVDiari, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 18, FloatToStrF(fltSalIni, ffFixed, 12, 2));
          End
          Else
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 10, FormatFloat('##,#0.00', fltTReceb));
            objExcel.Escrever(objExcel.LinhaAtual, 11, FloatToStrF(FieldByName('FLU_CTAPAG').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(FieldByName('FLU_CTADES').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(FieldByName('FLU_CTAIMP').AsFloat, ffFixed, 12, 2));
            If blnPdFlux Then
              objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(FieldByName('FLU_PEDCOM').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(FieldByName('FLU_CTAPAG').AsFloat +
                                                                   FieldByName('FLU_CTADES').AsFloat +
                                                                   FieldByName('FLU_CTAIMP').AsFloat +
                                                                   IfThen(blnPdFlux, FieldByName('FLU_PEDCOM').AsFloat, 0), ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 16, FloatToStrF(fltVDiari, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltSalIni, ffFixed, 12, 2));
          End;

          objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), 'R' + IntToStr(objExcel.LinhaAtual));
          objExcel.Alinhamento('D' + IntToStr(objExcel.LinhaAtual), 'R' + IntToStr(objExcel.LinhaAtual), Direita);

        End
        Else
        Begin

          If (blnAnalitico) Then
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 11, FormatFloat('##,#0.00', fltTReceb));
            objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(FieldByName('FLU_CTAPAG').AsFloat, ffFixed, 12, 2));
            If blnPdFlux Then
              objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(FieldByName('FLU_PEDCOM').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltVDiari, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltSalIni, ffFixed, 12, 2));
          End
          Else
          Begin
            objExcel.Escrever(objExcel.LinhaAtual, 10, FormatFloat('##,#0.00', fltTReceb));
            objExcel.Escrever(objExcel.LinhaAtual, 11, FloatToStrF(FieldByName('FLU_CTAPAG').AsFloat, ffFixed, 12, 2));
            If blnPdFlux Then
              objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(FieldByName('FLU_PEDCOM').AsFloat, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltVDiari, ffFixed, 12, 2));
            objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltSalIni, ffFixed, 12, 2));
          End;

          objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual));
          objExcel.Alinhamento('D' + IntToStr(objExcel.LinhaAtual), 'O' + IntToStr(objExcel.LinhaAtual), Direita);
        End;

        If (Not blnAnalitico) Then
        Begin
          objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'A' + IntToStr(objExcel.LinhaAtual), Direita);
          objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));
        End;

        fltPreCom := fltPreCom + FieldByName('FLU_PRECOM').AsFloat;
        fltPreVen := fltPreVen + FieldByName('FLU_PREVEN').AsFloat;
        fltChqPre := fltChqPre + FieldByName('FLU_CHQPRE').AsFloat;
        fltCtaRec := fltCtaRec + FieldByName('FLU_CTAREC').AsFloat;
        fltCarCre := fltCarCre + FieldByName('FLU_MOVCAR').AsFloat;
        fltCtaPag := fltCtaPag + FieldByName('FLU_CTAPAG').AsFloat;
        fltCtaDes := fltCtaDes + FieldByName('FLU_CTADES').AsFloat;
        fltCtaImp := fltCtaImp + FieldByName('FLU_CTAIMP').AsFloat;
        If blnPdFlux Then
          fltPedCom := fltPedCom + FieldByName('FLU_PEDCOM').AsFloat;
        fltVarDia := fltVarDia + fltVDiari;
        fltPedVe2 := fltPedVe2 + fltPedVen;
        fltTRece2 := fltTRece2 + fltTReceb;

        fltTPagar := fltTPagar + FieldByName('FLU_CTAPAG').AsFloat +
                                 FieldByName('FLU_CTADES').AsFloat +
                                 FieldByName('FLU_CTAIMP').AsFloat +
                                 IfThen(blnPdFlux, FieldByName('FLU_PEDCOM').AsFloat, 0);

        Next;
        objExcel.ProximaLinha;
      End;

      fltTotCom := fltTotCom + fltPreCom;
      fltTotVen := fltTotVen + fltPreVen;
      fltTotChq := fltTotChq + fltChqPre;
      fltTotRec := fltTotRec + fltCtaRec;
      fltTotCar := fltTotCar + fltCarCre;
      fltTotPag := fltTotPag + fltCtaPag;
      fltTotDes := fltTotDes + fltCtaDes;
      fltTotImp := fltTotImp + fltCtaImp;
      fltTotPed := fltTotPed + fltPedCom;
      fltTotVar := fltTotVar + fltVarDia;
      fltTotPVn := fltTotPVn + fltPedVe2;
      fltTotTRc := fltTotTRc + fltTRece2;
      fltTotPgr := fltTotPgr + fltTPagar;

      {*******************************************}
      {* CASO FOR ANALITICO IMPRIME TOTAL DO DIA *}
      {****************************************MV*}
      If (blnAnalitico) Then
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 03, 'TOTAL DO DIA:');
        objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual));
        objExcel.Alinhamento('C' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual), Direita);
        objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));

        If Not blnIncPre Then
        Begin
          objExcel.Escrever(objExcel.LinhaAtual, 05, '0,00');
          objExcel.Escrever(objExcel.LinhaAtual, 06, '0,00');
        End
        Else
        Begin
          objExcel.Escrever(objExcel.LinhaAtual, 05, FloatToStrF(fltPreCom, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 06, FloatToStrF(fltPreVen, ffFixed, 12, 2));
        End;
        objExcel.Escrever(objExcel.LinhaAtual, 07, FloatToStrF(fltChqPre, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 08, FloatToStrF(fltCtaRec, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 09, FloatToStrF(fltPedVe2, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 10, FloatToStrF(fltCarCre, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 11, FloatToStrF(fltTRece2, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(fltCtaPag, ffFixed, 12, 2));

        If blnSepCtp Then
        Begin
          objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltCtaDes, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltCtaImp, ffFixed, 12, 2));
          If blnPdFlux Then
            objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltPedCom, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 16, FloatToStrF(fltTPagar, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltVarDia, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 18, FloatToStrF(fltSalIni, ffFixed, 12, 2));
        End
        Else
        Begin
          If blnPdFlux Then
            objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltPedCom, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltVarDia, ffFixed, 12, 2));
          objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltSalIni, ffFixed, 12, 2));
        End;

        objExcel.ProximaLinha;
        objExcel.ProximaLinha;

      End;

      dtaDtaAtu := FieldByName('FLU_DTAVEN').AsDateTime;
    End;

    objExcel.Escrever(objExcel.LinhaAtual, 03, 'TOTAL GERAL:');

    If Not blnIncPre Then 
    Begin
      If (blnAnalitico) Then
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 05, '0,00');
        objExcel.Escrever(objExcel.LinhaAtual, 06, '0,00');
      End
      Else
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 04, '0,00');
        objExcel.Escrever(objExcel.LinhaAtual, 05, '0,00');
      End;
    End
    Else
    Begin
      If (blnAnalitico) Then
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 05, FloatToStrF(fltTotCom, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 06, FloatToStrF(fltTotVen, ffFixed, 12, 2));
      End
      Else
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 04, FloatToStrF(fltTotCom, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 05, FloatToStrF(fltTotVen, ffFixed, 12, 2));
      End;
    End;

    If (blnAnalitico) Then
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 07, FloatToStrF(fltTotChq, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 08, FloatToStrF(fltTotRec, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 09, FloatToStrF(fltTotPVn, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 10, FloatToStrF(fltTotCar, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 11, FloatToStrF(fltTotTRc, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(fltTotPag, ffFixed, 12, 2));
      If blnSepCtp Then
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltTotDes, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltTotImp, ffFixed, 12, 2));
        If blnPdFlux Then
          objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltTotPed, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 16, FloatToStrF(fltTotPgr, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltTotVar, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 18, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      End
      Else
      Begin
        If blnPdFlux Then
          objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltTotPed, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltTotVar, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      End;
    End
    Else
    Begin
      objExcel.Escrever(objExcel.LinhaAtual, 06, FloatToStrF(fltTotChq, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 07, FloatToStrF(fltTotRec, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 08, FloatToStrF(fltTotPVn, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 09, FloatToStrF(fltTotCar, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 10, FloatToStrF(fltTotTRc, ffFixed, 12, 2));
      objExcel.Escrever(objExcel.LinhaAtual, 11, FloatToStrF(fltTotPag, ffFixed, 12, 2));
      If blnSepCtp Then
      Begin
        objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(fltTotDes, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltTotImp, ffFixed, 12, 2));
        If blnPdFlux Then
          objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltTotPed, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 15, FloatToStrF(fltTotPgr, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 16, FloatToStrF(fltTotVar, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 17, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      End
      Else
      Begin
        If blnPdFlux Then
          objExcel.Escrever(objExcel.LinhaAtual, 12, FloatToStrF(fltTotPed, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 13, FloatToStrF(fltTotVar, ffFixed, 12, 2));
        objExcel.Escrever(objExcel.LinhaAtual, 14, FloatToStrF(fltSalIni, ffFixed, 12, 2));
      End;
    End;

    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual));
    objExcel.Alinhamento('C' + IntToStr(objExcel.LinhaAtual), IfThen(blnSepCtp,'R','O') + IntToStr(objExcel.LinhaAtual), Direita);

    objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));
    objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual), Direita);

  End;

  If blnPdcAcm Then
  Begin
    objExcel.ProximaLinha;
    objExcel.Escrever(objExcel.LinhaAtual, 01, '* Valores de pedidos de compra não baixados acumulados no dia ' + FormatDateTime('dd/mm/yy',fAjustaVencimento(StrToDate(mskDtaIni.Text), False)));
  End;

  If Not(CdsLista.IsEmpty) Then
  Begin
    With CdsLista Do
    Begin
      First;
      ObjExcel.ProximaLinha;
      objExcel.Escrever(objExcel.LinhaAtual, 01, '* Portadores que não entram no Fluxo de Caixa *');
      While Not Eof do
      Begin
        objExcel.Escrever(objExcel.ProximaLinha,01, FieldByName('FLU_CODIGO').AsString + ' - ' + FieldByName('FLU_DESCRI').AsString);
        Next;
      End;
    End;
  End;

  If (blnSalPor) And (Not cdsSalPor.IsEmpty) Then Begin
    ObjExcel.ProximaLinha;
    ObjExcel.ProximaLinha;


    objExcel.Escrever(objExcel.LinhaAtual, 01, 'SALDO DE PORTADORES');
    objExcel.Mesclar('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual));
    objExcel.Negrito('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), True);
    objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Centro);
    objExcel.CorFundo('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Cinza);
    objExcel.CorFonte('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Preto);
    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual));

    ObjExcel.ProximaLinha;
    objExcel.Escrever(objExcel.LinhaAtual, 01, 'CÓDIGO');
    objExcel.Escrever(objExcel.LinhaAtual, 02, 'NOME');
    objExcel.Escrever(objExcel.LinhaAtual, 04, 'SALDO');
    objExcel.Mesclar('B' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));
    objExcel.Negrito('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), True);
    objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual), Esquerda);
    objExcel.Alinhamento('D' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Direita);
    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual));

    objExcel.CorFundo('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Cinza);
    objExcel.CorFonte('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Preto);

    fltSalPor := 0;

    With cdsSalPor Do Begin
      First;

      While (Not Eof) do Begin
        ObjExcel.ProximaLinha;

        objExcel.Escrever(objExcel.LinhaAtual, 01, FieldByName('POR_CODPOR').AsString);

        objExcel.Escrever(objExcel.LinhaAtual, 02, FieldByName('POR_NOMPOR').AsString);
        objExcel.Mesclar('B' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));

        objExcel.Escrever(objExcel.LinhaAtual, 04, FloatToStrF(FieldByName('POR_SALDOS').AsFloat, ffFixed, 12, 2));
        objExcel.Alinhamento('D' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Direita);

        objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual));

        fltSalPor := fltSalPor + FieldByName('POR_SALDOS').AsFloat;

        Next();
      End;
    End;

    ObjExcel.ProximaLinha;
    objExcel.Escrever(objExcel.LinhaAtual, 02, 'SALDO GERAL PORTADORES:');
    objExcel.Escrever(objExcel.LinhaAtual, 04, FloatToStrF(fltSalPor, ffFixed, 12, 2));

    objExcel.Mesclar('B' + IntToStr(objExcel.LinhaAtual), 'C' + IntToStr(objExcel.LinhaAtual));
    objExcel.Negrito('B' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), True);

    objExcel.Alinhamento('B' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Direita);
    objExcel.CorFundo('B' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Cinza);
    objExcel.CorFonte('B' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual), Preto);
    objExcel.Bordas('B' + IntToStr(objExcel.LinhaAtual), 'D' + IntToStr(objExcel.LinhaAtual));

    objExcel.ProximaLinha;
  End;

  objExcel.CongelarPaines('A17');
  objExcel.AutoAjuste;
  objExcel.SalvarArquivo;
  objExcel.FecharArquivo;

  fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']); 

  FreeAndNil(objExcel);

end;

procedure TfrmRelBancFluxoCaixa.edtDestinoExit(Sender: TObject);
begin
  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If (Copy(edtDestino.Text, 1, 1) <> 'V') And
          (COpy(edtDestino.Text, 1, 1) <> 'I') And
          (Copy(edtDestino.Text, 1, 1) <> 'E') Then
  Begin
    pSetFocus(edtDestino);
  End;
end;

procedure TfrmRelBancFluxoCaixa.edtLimiteDiasExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtLimiteDias.Text) Then
  Begin
    fMensagem('', 'O campo Limite de dias deve ser maior ou igual a zero!', ['&OK']);
    pSetFocus(edtLimiteDias);
  End;
end;

procedure TfrmRelBancFluxoCaixa.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtCodEmpExit(Sender);
  inherited;

  intSelfWidth := Self.Width;
  Self.Width := intSelfWidth - (lstArquivos.Width + 09);

  lstArquivos.Enabled := False;
  shpMultSel.Visible  := True;
  shpMultSel.Left     := pnlInfo.Width - shpMultSel.Width;
end;

procedure TfrmRelBancFluxoCaixa.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmRelBancFluxoCaixa.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador, False) Then
    Self.SelectNext(ActiveControl, True, True);
end;

Function TfrmRelBancFluxoCaixa.fAjustaVencimento(dtaDtaVen: TDateTime; blnIncDia: Boolean; blnTribCtp: Boolean = False; blnCadRec: Boolean = False): TDateTime;
  Var
    blnIncDiaUtil: Boolean;
    blnContinua  : Boolean;
    intContador  : Integer;
Begin
  If (blnCadRec) Then
  Begin

    intContador := 0;
    blnContinua := True;

    While (blnContinua) Do
    Begin
      If (Not (DayOfWeek(dtaDtaVen) In [1,7])) And
         (Not (fEhFeriado(dtaDtaVen)))        Then
        Inc(intContador);

      If (intContador < 2) Then
        dtaDtaVen := dtaDtaVen + 1
      Else
        blnContinua := False;
    End;
  End
  Else If blnTribCtp = False Then
  Begin
    blnIncDiaUtil := Not blnIncDia;

    While (DayOfWeek(dtaDtaVen) In [1,7]) Or
          (fEhFeriado(dtaDtaVen)) Or
          (Not blnIncDiaUtil) Do
    Begin

      If (Not ((DayOfWeek(dtaDtaVen) In [1,7]) Or
               (fEhFeriado(dtaDtaVen)))) Then
      Begin
        blnIncDiaUtil := True;
      End;

      dtaDtaVen := dtaDtaVen + 1;

    End;
  End
  Else
  Begin
    {***********************************************}
    {* TRIBUTOS NÃO PODEM SER PAGOS APÓS O VENCTO, *}
    {* MESMO QUE CAIA EM SAB, DOM OU FERIADO       *}
    {********************************************RN*}
    While (DayOfWeek(dtaDtaVen) In [1,7]) Or
          (fEhFeriado(dtaDtaVen)) Do
    Begin

      dtaDtaVen := dtaDtaVen - 1;

    End;
  End;

  Result := dtaDtaVen;
End;

procedure TfrmRelBancFluxoCaixa.pAjustaDataResumo;
Var
  strSQL   : String;
  strSQLUpd: String;
  dtaDtaVen: TDateTime;
  dtaDtaAnt: TDateTime;

  qryCadFer: TUniQuery;
  qryTmp   : TUniQuery;
  qryUpd   : TUniQuery;
Begin

  Try

    qryCadFer := fCriaQuery(Nil);
    qryTmp    := fCriaQuery(Nil);
    qryUpd    := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   CTR_DTAVEN  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   TMP_CADREC ';

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.add(strSQL);
      Open;
    End;
    qryTmp.First;

    While Not qryTmp.Eof Do
    Begin
      dtaDtaVen := qryTmp.fieldbyname('CTR_DTAVEN').AsDateTime;
      dtaDtaAnt := qryTmp.fieldbyname('CTR_DTAVEN').AsDateTime;

      dtaDtaVen := fAjustaVencimento(dtaDtaVen, True);

      If dtaDtaVen <> dtaDtaAnt Then
      Begin

        strSQLUpd := '';
        strSQLUpd := strSQLUpd + ' UPDATE ';
        strSQLUpd := strSQLUpd + '   TMP_CADREC ';
        strSQLUpd := strSQLUpd + ' SET ';
        strSQLUpd := strSQLUpd + '   CTR_DTAVEN = :DTAVEN ';
        strSQLUpd := strSQLUpd + ' WHERE ';
        strSQLUpd := strSQLUpd + '   AUTOINCREM = :AUTINC ';
        With qryUpd Do
        Begin
          SQL.Clear;
          SQL.add(strSQLUpd);

          ParamByName('AUTINC').AsString   := qryTmp.fieldbyname('AUTOINCREM').AsString;
          ParamByName('DTAVEN').AsDate     := dtaDtaVen;

          ExecSQL;
        End;

      End;

      qryTmp.Next;
    End;

    FreeAndNil(qryCadFer);
    FreeAndNil(qryTmp);
    FreeAndNil(qryUpd);

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaDataResumo]');
    End;
  End;

End;

procedure TfrmRelBancFluxoCaixa.pCriarListaSaldoPortadores;
  Var
    qrySalPor: TUniQuery;

  function fGetSQLSalPor: String; begin
    Result := 'SELECT SQL_NO_CACHE ';
    Result := Result + '  P.* ';
    Result := Result + 'FROM ';
    Result := Result + '  CADPOR P ';
    Result := Result + ' WHERE P.POR_SALPOR = "S" ';

    If (Not fEmptyStr(edtCodPor.Text)) Then Begin
      Result := Result + fStrLocate(edtCodPor, arrPortador,'P.POR_CODPOR','CODPOR');
    End Else If fCfgSis('DACPOR', varBoolean) Then Begin
      Result := Result + ' AND (IFNULL(P.POR_CODPOR, "") = "" ';
      Result := Result + ' OR LOCATE(P.POR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    Result := Result + ' ORDER BY ';
    Result := Result + '  P.POR_NOMPOR ';
  end;

  procedure pInicializarQuerys; begin
    cdsSalPor.Close();
    cdsSalPor.CreateDataSet();
    cdsSalPor.EmptyDataSet();

    qrySalPor := fCriaQuery;
    qrySalPor.SQL.Clear();
    qrySalPor.SQL.Text := fGetSQLSalPor();
    pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qrySalPor);
    qrySalPor.Open();
    qrySalPor.First();
  end;

  function fCalcularSaldoPortador: Double; begin
    If (StrToDateDef(mskDtaFin.Text, 0) < fRetDataPortador(qrySalPor.FieldByName('POR_CODPOR').AsString)) Then Begin
      Result := 0;
    End Else Begin
      Result := fRetSaldoAnterior(qrySalPor.FieldByName('POR_CODPOR').AsString,
                                  StrToDateDef(mskDtaFin.Text, 0),
                                  VS_strCodEmp,
                                  TSituacaoLancBancario.sitTodos);
    End;
  end;
begin
  Try
    Try
      If (blnSalPor) Then Begin
        frmWaitWindow.lblTexto.Caption := #13#10 + '    Processando o Fluxo de Caixa:' +
                                          #13#10 + '    - Resumo de saldo de portadores...';
        frmWaitWindow.Refresh;

        pInicializarQuerys();

        While (Not qrySalPor.Eof) Do Begin
          cdsSalPor.Append();

          cdsSalPor.FieldByName('POR_CODPOR').AsString := qrySalPor.FieldByName('POR_CODPOR').AsString;
          cdsSalPor.FieldByName('POR_NOMPOR').AsString := qrySalPor.FieldByName('POR_NOMPOR').AsString;
          cdsSalPor.FieldByName('POR_SALDOS').AsFloat  := fCalcularSaldoPortador();
          cdsSalPor.Post();

          qrySalPor.Next();
        End;
      End;
    Except
      On E : Exception Do
        pMensagensErro(E.Message, '[TfrmRelBancFluxoCaixa.pCriarListaSaldoPortadores]');
    End;
  Finally
    FreeAndNil(qrySalPor);
  End;
end;

function TfrmRelBancFluxoCaixa.fEhCtpTrib(strNomTab, strTipDoc: String): Boolean;
begin
  If strTipDoc <> '2' Then
    Result := False
  Else
  Begin
    Result := (Copy(strNomTab, 1, 3) = 'CTP');
    If Not (Result) Then
      Result := (Copy(strNomTab, 1, 6) = 'CADPAG');
  End;
end;

function TfrmRelBancFluxoCaixa.fEhFeriado(dtaDtaVen: TDateTime): Boolean;
Begin
  Result := false;
  Try
    Result := stlCadFer.IndexOf(FormatDateTime('dd/mm/yyyy',dtaDtaVen)) > -1;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'fEhFeriado');
  End;

End;

function TfrmRelBancFluxoCaixa.fGerarFiltro : String;
begin
  Result := '';
  Result := Result + ' (FLU_ENTFLX = '+QuotedStr('S') + ') AND ';
  Result := Result + '  ((FLU_CTAREC IS NOT NULL AND ';
  Result := Result + '   FLU_CTAREC <> 0) OR ';
  Result := Result + '  (FLU_MOVCAR IS NOT NULL AND ';
  Result := Result + '   FLU_MOVCAR <> 0) OR ';
  Result := Result + '  (FLU_CTAPAG IS NOT NULL AND ';
  Result := Result + '   FLU_CTAPAG <> 0) OR ';
  Result := Result + '  (FLU_CTADES IS NOT NULL AND ';
  Result := Result + '   FLU_CTADES <> 0) OR ';
  Result := Result + '  (FLU_CTAIMP IS NOT NULL AND ';
  Result := Result + '   FLU_CTAIMP <> 0) OR ';
  Result := Result + '  (FLU_CHQPRE IS NOT NULL AND ';
  Result := Result + '   FLU_CHQPRE <> 0) OR ';
  Result := Result + '  (FLU_PEDCOM IS NOT NULL AND ';
  Result := Result + '   FLU_PEDCOM <> 0) OR ';
  Result := Result + '  (FLU_PRECOM IS NOT NULL AND ';
  Result := Result + '   FLU_PRECOM <> 0) OR ';
  Result := Result + '  (FLU_PREVEN IS NOT NULL AND ';
  Result := Result + '   FLU_PREVEN <> 0) OR ';
  Result := Result + '  (FLU_PEDVEN IS NOT NULL AND ';
  Result := Result + '   FLU_PEDVEN <> 0)) ';
end;

procedure TfrmRelBancFluxoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ((ActiveControl) = Nil) Or (SameText(ActiveControl.ClassName, 'TGroupButton')) Then
    SelectNext(ActiveControl, True, True);
  inherited;
end;

procedure TfrmRelBancFluxoCaixa.pMsgEspera(Sender: TForm; strTexto: String;
  intTimeOut: Integer = 3; intPosicao: integer = 1);
begin
  Try
    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.intPosicao := intPosicao;
    frmWaitWindow.lblTexto.Caption := strTexto;
    frmWaitWindow.tmrWait.Interval := (intTimeOut * 1000) + 200;
//    AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
    frmWaitWindow.Show;
    frmWaitWindow.Refresh;
    frmWaitWindow.tmrWait.Enabled := True;

    If (Sender <> Nil) Then
      pSetFocus(Sender);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pMsgEspera]');
    End;
  End;

end;

function TfrmRelBancFluxoCaixa.fQryToCds(qryTmp: TUniQuery;
  cdsTmp: TUniClientDataSet; blnCadRec: Boolean = False): Boolean;
  Var
    intCnt : Integer;
    dtaDta : TDate;
begin
  Result := false;

  If qryTmp.Fields.Count <> cdsTmp.Fields.Count Then
  Begin
    Result := False;
    Exit;
  End;

  qryTmp.DisableControls;
  cdsTmp.DisableControls;

  If edtOpcao.Text = 'A' Then
  Begin

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin

      If (qryTmp.FieldByName(qryTmp.Fields[8].FieldName).IsNull) Then
      Begin
        qryTmp.Next;
        Continue;
      End;

      dtaDta := fDataInvertida(qryTmp.FieldByName(qryTmp.Fields[8].FieldName).AsString);

      dtaDta := fAjustaVencimento(dtaDta, False, fEhCtpTrib(qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString, qryTmp.FieldByName(qryTmp.Fields[3].FieldName).AsString), blnCadRec);

      If qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString <> 'CADPOR' Then
      Begin
        If  (dtaDta < StrToDate(mskDtaIni.Text)) Or (dtaDta > StrToDate(mskDtaFin.Text)) Then
        Begin
          qryTmp.Next;
          Continue;
        End;
      End;

      cdsTmp.Append;
      For intCnt := 0 To (qryTmp.Fields.Count-1) Do
      Begin
        If Not qryTmp.FieldByName( qryTmp.Fields[intCnt].FieldName ).IsNull Then
        Begin
          If intCnt = 8 Then
          Begin
            cdsTmp.Fields[intCnt].Value := dtaDta;
           End
          Else
            cdsTmp.Fields[intCnt].Value := qryTmp.Fields[intCnt].Value;
        End;

      End;
      cdsTmp.Post;

      qryTmp.Next;
    End;
  End
  Else
  Begin

    cdsTmp.IndexFieldNames := 'FLU_DTAVEN';

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin

      If (qryTmp.FieldByName(qryTmp.Fields[8].FieldName).IsNull) Then
      Begin
        qryTmp.Next;
        Continue;
      End;

      dtaDta := fDataInvertida(qryTmp.FieldByName(qryTmp.Fields[8].FieldName).AsString);

      dtaDta := fAjustaVencimento(dtaDta, False, fEhCtpTrib(qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString, qryTmp.FieldByName(qryTmp.Fields[3].FieldName).AsString), blnCadRec);

      If qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString <> 'CADPOR' Then
      Begin
        If  (dtaDta < StrToDate(mskDtaIni.Text)) Or (dtaDta > StrToDate(mskDtaFin.Text)) Then
        Begin
          qryTmp.Next;
          Continue;
        End;
      End;

      If qryTmp.FieldByName(qryTmp.Fields[14].FieldName).AsString = 'S' Then
      Begin
        If cdsTmp.FindKey([dtaDta]) Then
        Begin
          cdsTmp.Edit;
          cdsTmp.FieldByName('FLU_CHQPRE').Value := cdsTmp.FieldByName('FLU_CHQPRE').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[9].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[9].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_CTAREC').Value := cdsTmp.FieldByName('FLU_CTAREC').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[10].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[10].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_MOVCAR').Value := cdsTmp.FieldByName('FLU_MOVCAR').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[11].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[11].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_CTAPAG').Value := cdsTmp.FieldByName('FLU_CTAPAG').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[12].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[12].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_PEDCOM').Value := cdsTmp.FieldByName('FLU_PEDCOM').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[13].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[13].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_PRECOM').Value := cdsTmp.FieldByName('FLU_PRECOM').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[15].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[15].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_PREVEN').Value := cdsTmp.FieldByName('FLU_PREVEN').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[16].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[16].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_PEDVEN').Value := cdsTmp.FieldByName('FLU_PEDVEN').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[17].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[17].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_CTADES').Value := cdsTmp.FieldByName('FLU_CTADES').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[18].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[18].FieldName).AsFloat);
          cdsTmp.FieldByName('FLU_CTAIMP').Value := cdsTmp.FieldByName('FLU_CTAIMP').Value + IfThen(qryTmp.FieldByName(qryTmp.Fields[19].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[19].FieldName).AsFloat);
        End
        Else
        Begin
          cdsTmp.Append;
          If qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString <> 'CADPOR' Then
          Begin
            cdsTmp.FieldByName('FLU_AUTINC').Value := FormatDateTime('yyyyMM', dtaDta) + IntToStr(WeekOf(dtaDta));
            cdsTmp.FieldByName('FLU_DESCRI').Value := FormatDateTime('yyyyMM', dtaDta) ;
            cdsTmp.FieldByName('FLU_TABELA').Value := qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString;
            cdsTmp.FieldByName('FLU_DTAVEN').Value := dtaDta;
            cdsTmp.FieldByName('FLU_ENTFLX').Value := qryTmp.FieldByName(qryTmp.Fields[14].FieldName).AsString;
            cdsTmp.FieldByName('FLU_CHQPRE').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[9].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[9].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_CTAREC').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[10].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[10].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_MOVCAR').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[11].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[11].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_CTAPAG').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[12].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[12].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_PEDCOM').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[13].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[13].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_PRECOM').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[15].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[15].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_PREVEN').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[16].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[16].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_PEDVEN').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[17].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[17].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_CTADES').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[18].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[18].FieldName).AsFloat);
            cdsTmp.FieldByName('FLU_CTAIMP').Value := IfThen(qryTmp.FieldByName(qryTmp.Fields[19].FieldName).IsNull, 0, qryTmp.FieldByName(qryTmp.Fields[19].FieldName).AsFloat);
          End
          Else
          Begin
            cdsTmp.FieldByName('FLU_AUTINC').Value := qryTmp.FieldByName(qryTmp.Fields[0].FieldName).AsString;
            cdsTmp.FieldByName('FLU_TABELA').Value := qryTmp.FieldByName(qryTmp.Fields[1].FieldName).AsString;
            cdsTmp.FieldByName('FLU_CODIGO').Value := qryTmp.FieldByName(qryTmp.Fields[6].FieldName).AsString;
            cdsTmp.FieldByName('FLU_DESCRI').Value := qryTmp.FieldByName(qryTmp.Fields[7].FieldName).AsString;
            cdsTmp.FieldByName('FLU_ENTFLX').Value := qryTmp.FieldByName(qryTmp.Fields[14].FieldName).AsString;
          End;
        End;

        cdsTmp.Post;
      End;

      qryTmp.Next;
    End;

  End;

  qryTmp.EnableControls;
  cdsTmp.EnableControls;
end;

{*********************}
{* ATUALIZA O LST DE *}
{* INVENTARIO FISICO *}
{******************AF*}
{*****************************************************************************}
{* SUBSTITUI pAtualizalst, VALIDAR CASO NÃO EXISTAM AS TABELAS DE INVENTÁRIO *}
{*RQ: 33336 ***************************************************************BB*}
function TfrmRelBancFluxoCaixa.fAtualizaLst : Boolean;
  Var
    qryGenTmp: TUniQuery;
    intGen: Integer;
Begin

  Result := False;

  If InterlockedIncrement(intAtuLst) = 0 Then
  Begin

    Try
      qryGenTmp := fCriaQuery(Self);

      lstArquivos.Items.Clear;

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SHOW TABLES LIKE "CTR\_%" ');
        Open;


        If IsEmpty Then
          Result := False
        Else
        Begin

          While Not Eof Do
          Begin
            Application.ProcessMessages;

            If (TryStrToInt(Copy(Fields[0].AsString,9,2), intGen)) And (TryStrToInt(Copy(Fields[0].AsString,5,4), intGen)) Then
            Begin
              If StrToInt(Copy(Fields[0].AsString,9,2)) <= High(arrMesAbr) Then
                lstArquivos.Items.Add(String(arrMesAbr[StrToInt(Copy(Fields[0].AsString,9,2))]) + '/' + Copy(Fields[0].AsString,5,4));
            End;

            Next;
          End;

          Result := True;

        End;

        Close;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmRelBancFluxoCaixa.fAtualizaLst');
        Result := False;
      End;

    End;

    InterlockedDecrement(intAtuLst);
    FreeAndNil(qryGenTmp);

  End
  Else
    InterlockedDecrement(intAtuLst);

End;

procedure TfrmRelBancFluxoCaixa.cbxChecksClickCheck(Sender: TObject);
begin
  inherited;

  blnIncPre := cbxChecks.Checked[0];
  blnInvFin := cbxChecks.Checked[1];

  If cbxChecks.ItemIndex = 1 Then
  Begin
    if fAtualizaLst Then
    Begin
      If blnInvFin Then
      Begin
        If Not lstArquivos.Enabled Then
        Begin
          Self.Width := intSelfWidth;
          lstArquivos.Enabled := True;
        End;
      End
      Else
      Begin
        If lstArquivos.Enabled Then
        Begin
          Self.Width := intSelfWidth - (lstArquivos.Width + 09);
          lstArquivos.Enabled := False;
        End;
      End;
    End
    Else
    Begin
      pMensagemOk('Não há registros de Inventário Financeiro');
      blnInvFin := False;
      cbxChecks.Checked[1] := False;
    End;
  End;

  blnPdFlux  := cbxChecks.Checked[2];
  blnPdvFlux := cbxChecks.Checked[3];
  blnSepCtp  := cbxChecks.Checked[4];
  //blnCtrCtp  := IfThen(edtOpcao.Text = 'S', cbxChecks.Checked[5], False);
  if (edtOpcao.Text = 'S') then
    blnCtrCtp:= cbxChecks.Checked[5]
  else
    blnCtrCtp:= False;


  cbxChecks.Checked[5] := blnCtrCtp;
  edtLimiteDias.Enabled := blnCtrCtp;

  If (edtLimiteDias.Enabled) And (fEmptyStr(edtLimiteDias.Text)) Then
    edtLimiteDias.Text := '9999';

  blnQbrDia  := cbxChecks.Checked[6];
  blnQbrMes  := cbxChecks.Checked[7];
  blnPreSab  := cbxChecks.Checked[8];
  blnPdcAcm  := cbxChecks.Checked[9];
  blnSalPor  := cbxChecks.Checked[10];
end;

procedure TfrmRelBancFluxoCaixa.cbxChecksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: SelectNext(ActiveControl, True, True);
  End;
  
end;

function TfrmRelBancFluxoCaixa.fRetNumMesSelec: String;
  Var
    strMes     : String;
    intContador: Integer;
    intIndice  : Integer;
Begin
  intIndice := 0;
  Result := '00';

  For intContador := 0 To lstArquivos.Items.Count -1 Do
  Begin

    If lstArquivos.Checked[intContador] Then
    Begin
      intIndice := intContador;
      Continue;
    End;

  End;

  strMes := LeftStr(lstArquivos.Items[intIndice],3);

  If strMes = 'JAN' Then Result := '01' Else
  If strMes = 'FEV' Then Result := '02' Else
  If strMes = 'MAR' Then Result := '03' Else
  If strMes = 'ABR' Then Result := '04' Else
  If strMes = 'MAI' Then Result := '05' Else
  If strMes = 'JUN' Then Result := '06' Else
  If strMes = 'JUL' Then Result := '07' Else
  If strMes = 'AGO' Then Result := '08' Else
  If strMes = 'SET' Then Result := '09' Else
  If strMes = 'OUT' Then Result := '10' Else
  If strMes = 'NOV' Then Result := '11' Else
  If strMes = 'DEZ' Then Result := '12';

  Result := RightStr(lstArquivos.Items[intIndice],4) + Result;

End;

procedure TfrmRelBancFluxoCaixa.lstArquivosEnter(Sender: TObject);
begin
  inherited;
  If lstArquivos.Count > 0 Then
    lstArquivos.Selected[0] := True;
end;

procedure TfrmRelBancFluxoCaixa.lstArquivosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: Close;
    VK_Return: SelectNext(ActiveControl,True,True);
  End;
  
end;

{***********************************}
{* CONTA QUANTOS ARQUIVOS JÁ ESTÃO *}
{* SELECIONADAS                    *}
{********************************AF*}
function TfrmRelBancFluxoCaixa.fContaSelecoes: Integer;
  Var
    intContador: Integer;
begin
  Result := 0;

  For intContador := 0 To lstArquivos.Items.Count -1 Do
  Begin

    If lstArquivos.Checked[intContador] Then
      Inc(Result);

  End;

end;

function TfrmRelBancFluxoCaixa.fDataInvertida(strData: String): TDate;
begin
  If strData[5] = '-' Then
    Result := StrToDate(Copy(strData, 9, 2) + '/' +
                        Copy(strData, 6, 2) + '/' +
                        Copy(strData, 1, 4)) 
  Else
    Result := StrToDate(strData);
end;

procedure TfrmRelBancFluxoCaixa.lstArquivosClickCheck(Sender: TObject);
  Var
    intContador: Integer;
    intIndex   : Integer;
begin
  inherited;

  intIndex := lstArquivos.ItemIndex;

  For intContador := 0 To lstArquivos.Items.Count -1 Do
  Begin

    If intContador <> intIndex Then
    Begin
      lstArquivos.Checked[intContador] := False;
    End;

  End;
  
end;

procedure TfrmRelBancFluxoCaixa.edtPeriodExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPeriod.Text) Then
    edtPeriod.Text := '0';
end;

procedure TfrmRelBancFluxoCaixa.edtPrePraExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPrePra.Text) Then
    edtPrePra.Text := '0,00';
end;

procedure TfrmRelBancFluxoCaixa.edtPreVisExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPreVis.Text) Then
    edtPreVis.Text := '0,00';
end;

procedure TfrmRelBancFluxoCaixa.pInserePrevisaoDeVendaVista;
  Var
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    blnDiaUtil: Boolean;
    strFiltro : String;

    function fDiaComMovimento(dtaDia: TDateTime): Boolean;
    begin
      cdsFluCai.Filtered := False;
      If edtOpcao.Text = 'A' Then
        cdsFluCai.Filter   := 'FLU_DTAVEN = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaDia)) + ' AND FLU_TABELA = ' + QuotedStr('CADPRE')
      Else
        cdsFluCai.Filter   := 'FLU_DTAVEN = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaDia));
      cdsFluCai.Filtered := True;

      Result := cdsFluCai.RecordCount > 0;
    end;
begin
  strFiltro := cdsFluCai.Filter;

  dtaDtaIni := StrToDate(mskDtaIni.Text);
  dtaDtaFin := StrToDate(mskDtaFin.Text);  

  While (dtaDtaIni <= dtaDtaFin) Do
  Begin

    If blnPreSab Then
    Begin
      blnDiaUtil := (Not ((DayOfWeek(dtaDtaIni) In [1]) Or
                          (fEhFeriado(dtaDtaIni))));
    End
    Else
    Begin
      blnDiaUtil := (Not ((DayOfWeek(dtaDtaIni) In [1,7]) Or
                          (fEhFeriado(dtaDtaIni))));
    End;

    If (blnDiaUtil) Then
    Begin
      If (fDiaComMovimento(dtaDtaIni)) Then
      Begin
        cdsFluCai.First;
        While Not cdsFluCai.Eof Do
        Begin

          cdsFluCai.Edit;
          cdsFluCaiFLU_PREVEN.Value := cdsFluCaiFLU_PREVEN.Value + fStrToFloat(edtPreVis.Text);
          cdsFluCai.Post;

          cdsFluCai.Next;
        End;
      End
      Else
      Begin

        If edtOpcao.Text = 'A' Then
        Begin
          cdsFluCai.Append;
          cdsFluCaiFLU_AUTINC.Value := '0';
          cdsFluCaiFLU_TABELA.Value := 'CADPRE';
          cdsFluCaiFLU_DESCRI.Value := 'PREVISÃO DIÁRIA DE VENDA À VISTA';
          cdsFluCaiFLU_DTAVEN.Value := dtaDtaIni;
          cdsFluCaiFLU_CHQPRE.Value := 0;
          cdsFluCaiFLU_CTAREC.Value := 0;
          cdsFluCaiFLU_MOVCAR.Value := 0;
          cdsFluCaiFLU_CTAPAG.Value := 0;
          cdsFluCaiFLU_PEDCOM.Value := 0;
          cdsFluCaiFLU_ENTFLX.Value := 'S';
          cdsFluCaiFLU_PRECOM.Value := 0;
          cdsFluCaiFLU_PREVEN.Value := fStrToFloat(edtPreVis.Text);
          cdsFluCaiFLU_PEDVEN.Value := 0;
          cdsFluCaiFLU_CTADES.Value := 0;
          cdsFluCaiFLU_CTAIMP.Value := 0;
          cdsFluCaiFLU_DOCUME.Value := '';
          cdsFluCai.Post;
        End
        Else
        Begin
          cdsFluCai.Append;
          cdsFluCaiFLU_AUTINC.AsString := FormatDateTime('yyyyMM', dtaDtaIni) + IntToStr(WeekOf(dtaDtaIni));
          cdsFluCaiFLU_DESCRI.AsString := FormatDateTime('yyyyMM', dtaDtaIni);
          cdsFluCaiFLU_TABELA.Value    := 'CADPRE';
          cdsFluCaiFLU_DTAVEN.Value    := dtaDtaIni;
          cdsFluCaiFLU_CHQPRE.Value    := 0;
          cdsFluCaiFLU_CTAREC.Value    := 0;
          cdsFluCaiFLU_MOVCAR.Value    := 0;
          cdsFluCaiFLU_CTAPAG.Value    := 0;
          cdsFluCaiFLU_PEDCOM.Value    := 0;
          cdsFluCaiFLU_ENTFLX.Value    := 'S';
          cdsFluCaiFLU_PRECOM.Value    := 0;
          cdsFluCaiFLU_PREVEN.Value    := fStrToFloat(edtPreVis.Text);;
          cdsFluCaiFLU_PEDVEN.Value    := 0;
          cdsFluCaiFLU_CTADES.Value    := 0;
          cdsFluCaiFLU_CTAIMP.Value    := 0;
          cdsFluCaiFLU_DOCUME.Value    := '';
          cdsFluCai.Post;
        End;

      End;

    End;

    dtaDtaIni := IncDay(dtaDtaIni, 1);

  End;

  cdsFluCai.Filter := strFiltro;
  cdsFluCai.Filtered := True;
end;

procedure TfrmRelBancFluxoCaixa.pInserePrevisaoDeVendaPrazo;
  Var
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    blnDiaUtil: Boolean;
    strFiltro : String;

    function fDiaComMovimento(dtaDia: TDateTime): Boolean;
    begin
      cdsFluCai.Filtered := False;
      If edtOpcao.Text = 'A' Then
        cdsFluCai.Filter   := 'FLU_DTAVEN = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaDia)) + ' AND FLU_TABELA = ' + QuotedStr('CADPRE')
      Else
        cdsFluCai.Filter   := 'FLU_DTAVEN = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaDia));
      cdsFluCai.Filtered := True;

      Result := cdsFluCai.RecordCount > 0;
    end;
begin
  strFiltro := cdsFluCai.Filter;

  dtaDtaIni := StrToDate(mskDtaIni.Text);
  dtaDtaFin := StrToDate(mskDtaFin.Text);

  dtaDtaIni := IncDay(dtaDtaIni, StrToIntDef(edtPeriod.Text, 0));

  While (dtaDtaIni <= dtaDtaFin) Do
  Begin

    If blnPreSab Then
    Begin
      blnDiaUtil := (Not ((DayOfWeek(dtaDtaIni) In [1]) Or
                          (fEhFeriado(dtaDtaIni))));
    End
    Else
    Begin
      blnDiaUtil := (Not ((DayOfWeek(dtaDtaIni) In [1,7]) Or
                          (fEhFeriado(dtaDtaIni))));
    End;

    If (blnDiaUtil) Then
    Begin
      If (fDiaComMovimento(dtaDtaIni)) Then
      Begin
        cdsFluCai.First;
        While Not cdsFluCai.Eof Do
        Begin

          cdsFluCai.Edit;
          cdsFluCaiFLU_PREVEN.Value := cdsFluCaiFLU_PREVEN.Value + fStrToFloat(edtPrePra.Text);
          cdsFluCai.Post;

          cdsFluCai.Next;
        End;
      End
      Else
      Begin

        If edtOpcao.Text = 'A' Then
        Begin
          cdsFluCai.Append;
          cdsFluCaiFLU_AUTINC.Value := '0';
          cdsFluCaiFLU_TABELA.Value := 'CADPRE';
          cdsFluCaiFLU_DESCRI.Value := 'PREVISÃO DIÁRIA DE VENDA A PRAZO';
          cdsFluCaiFLU_DTAVEN.Value := dtaDtaIni;
          cdsFluCaiFLU_CHQPRE.Value := 0;
          cdsFluCaiFLU_CTAREC.Value := 0;
          cdsFluCaiFLU_MOVCAR.Value := 0;
          cdsFluCaiFLU_CTAPAG.Value := 0;
          cdsFluCaiFLU_PEDCOM.Value := 0;
          cdsFluCaiFLU_ENTFLX.Value := 'S';
          cdsFluCaiFLU_PRECOM.Value := 0;
          cdsFluCaiFLU_PREVEN.Value := fStrToFloat(edtPrePra.Text);
          cdsFluCaiFLU_PEDVEN.Value := 0;
          cdsFluCaiFLU_CTADES.Value := 0;
          cdsFluCaiFLU_CTAIMP.Value := 0;
          cdsFluCaiFLU_DOCUME.Value := '';
          cdsFluCai.Post;
        End
        Else
        Begin
          cdsFluCai.Append;
          cdsFluCaiFLU_AUTINC.AsString := FormatDateTime('yyyyMM', dtaDtaIni) + IntToStr(WeekOf(dtaDtaIni));
          cdsFluCaiFLU_DESCRI.AsString := FormatDateTime('yyyyMM', dtaDtaIni);
          cdsFluCaiFLU_TABELA.Value    := 'CADPRE';
          cdsFluCaiFLU_DTAVEN.Value    := dtaDtaIni;
          cdsFluCaiFLU_CHQPRE.Value    := 0;
          cdsFluCaiFLU_CTAREC.Value    := 0;
          cdsFluCaiFLU_MOVCAR.Value    := 0;
          cdsFluCaiFLU_CTAPAG.Value    := 0;
          cdsFluCaiFLU_PEDCOM.Value    := 0;
          cdsFluCaiFLU_ENTFLX.Value    := 'S';
          cdsFluCaiFLU_PRECOM.Value    := 0;
          cdsFluCaiFLU_PREVEN.Value    := fStrToFloat(edtPrePra.Text);;
          cdsFluCaiFLU_PEDVEN.Value    := 0;
          cdsFluCaiFLU_CTADES.Value    := 0;
          cdsFluCaiFLU_CTAIMP.Value    := 0;
          cdsFluCaiFLU_DOCUME.Value    := '';
          cdsFluCai.Post;
        End;

      End;

    End;

    dtaDtaIni := IncDay(dtaDtaIni, 1);

  End;

  cdsFluCai.Filter := strFiltro;
  cdsFluCai.Filtered := True;
end;

end.

