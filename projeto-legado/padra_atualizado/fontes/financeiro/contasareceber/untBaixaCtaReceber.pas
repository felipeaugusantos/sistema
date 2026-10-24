{***************************}
{* qryConCli -> CADCLI     *}
{* qryConEve -> CADEVE     *}
{* qryConEmp -> CADEMP     *}
{* qryConPor -> CADPOR     *}
{************************JB*}
unit untBaixaCtaReceber;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, DB, StrUtils, Menus,
  AppEvnts, frxDMPExport, Math, untRcxComissao, MemoFocus, UniClientDataSet,
  untCadRec, Provider;

type
  TfrmBaixaCtaReceber = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    edtNosNum: TEditFocus;
    Label4: TLabel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    dbgDuplicatas: TDBGridCitel;
    Label21: TLabel;
    Label23: TLabel;
    pnlBotoesBaixa: TPanel;
    btnIniBus: TBitBtn;
    btnLocProx: TBitBtn;
    btnConfirma: TBitBtn;
    btnSairBaixa: TBitBtn;
    Label6: TLabel;
    Label9: TLabel;
    edtNomCli: TEditFocus;
    edtQtdDuplicatas: TEditFocus;
    edtQtdSelecionadas: TEditFocus;
    edtValorTotal: TEditFocus;
    edtTotalRecebido: TEditFocus;
    edtCodEve: TEditFocus;
    Label8: TLabel;
    edtDesEve: TEditFocus;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtCodPorBai: TEditFocus;
    edtNomPorBai: TEditFocus;
    edtNosNumBai: TEditFocus;
    edtCodEveBai: TEditFocus;
    edtDesEveBai: TEditFocus;
    edtCodVel: TEditFocus;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtJurosTotal: TEditFocus;
    edtDescontoTotal: TEditFocus;
    btnRecalculaJuros: TBitBtn;
    Label20: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    Label5: TLabel;
    edtDesPortador: TEditFocus;
    edtCodPortador: TEditFocus;
    BtnSelecionadas: TBitBtn;
    btnMarcarTodas: TBitBtn;
    btnDesmarcarTodas: TBitBtn;
    edtHistor: TMemoFocus;
    lblDespCob: TLabel;
    edtDespCob: TEditFocus;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDuplicatasDblClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure btnRecalculaJurosClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnSelecionadasClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    cdsCtaRec: TUniClientDataSet;
    dtsCtaRec: TDataSource;

    strTipBai: String;
    strDtaRec: String;
    fltValPag: Double;
    fltValJur: Double;
    fltValDes: Double;

    strPorBai: String;
    strPorBa2: String;
    strCtaBai: String;
    strDtaLan: String;
    strDocBai: String;
    strHisBai: String;

    intDCrRec: Integer;
    intDCrRecPor1: Integer;
    intDcrRecPor2: Integer;

    intIdenti: Integer;

    strDocumento: String;

    strValorFiltro: String;
    strCampoFiltro: String;

    strTabelaMovBan: String;

    cdsChqPre: TUniClientDataSet;
    cdsChqVis: TUniClientDataSet;

    cdsRateio: TUniClientDataSet;

    intSeqCon: Integer;

    strNomFil  : String;
    strTipImp  : String;

    procedure pMostraObsCliente;
    procedure pSelecionaTodas(blnMarcar: Boolean);
    procedure pMarcaDuplicata(blnMarcar: Boolean;
                              strTipBai: String;
                              fltValor,
                              fltValDes,
                              fltValJur: Double;
                              strDtaRec: String);
    procedure pCarregaEvento;
    procedure pCarregaCliente;
    procedure pSelecionaDuplicata(blnTodas: Boolean = FALSE);
    procedure pLimpaDados;
    function fCriaClientRecibo: TUniClientDataSet;
    function fCriaListaClientes: TStringList;

    procedure pRetDupSelecionadas(Var intDupCx1, intDupCx2: Integer;
      Var fltTotCx1, fltTotCx2: Double);

    procedure pSetaFieldsContasReceber(cdsClient: TUniClientDataSet);  
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    function fBaixaDuplicatas: Boolean;
    procedure pImprimeRecibo;
    procedure pRecalculaJuros;
    procedure pCarregaEmpresa;
    procedure pCarregaPortador;
    procedure pCalculaJuros(fltPerJur: Double; strAplJur: String);
    function fGravaCheques(rcxComissao: TRcxComissao): Boolean;
    function fGravaCreditoCliente(fltValCre: Double; Var arrLogCtr: TRegistroLogCtr): Boolean;

  protected
    procedure pCriaTemporaria;
    procedure pCalculaValorCorrigido;
    procedure pCalculaTotalDuplicatas(edtDesconto, edtJuros, edtTotal, edtQuant: TEditFocus; blnFiltrar: Boolean);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmBaixaCtaReceber: TfrmBaixaCtaReceber;

implementation

uses untFuncoes, untfuncoesSimples,  untPesqAux,
  untBaixaDigValores, untBaixaCtrAnalitica, untConsultas,
  untBaixaSintetica, untBaixaBusca, 
  untCtrRecalculoJuros, untFatFormasPagamento,
  untConsultaComp,
  untConsDuplicSelec, untQckReciboCtaReceber,
  untFatMostraObsCliente, untFuncoesConsulta, untCadChq, untMovCar, untMovBan,
  untCfgRel;

{$R *.dfm}

procedure TfrmBaixaCtaReceber.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmBaixaCtaReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCli.Clear;
      End;

      If Result And blnBuscaPorChave And fCfgSis('EXOBCR', varBoolean) Then
        pMostraObsCliente;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = edtCodEve) Then
    Begin
      If Not fEmptyStr(edtCodEve.Text) Then
      Begin
        pCarregaEvento;
        If fEmptyStr(edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesEve.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Clear;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    {*******************}
    {* VALIDA PORTADOR *}
    {****************AF*}
    Else If (Sender = edtCodPortador) Then
    Begin

      If (fEmptyStr(edtCodPortador.Text)) Then
      Begin
        edtDesPortador.Clear;
      End
      Else
      Begin
        pCarregaPortador;
        If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin

      mskDtaFin.Clear;
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O NOSSO NUMERO                 *}
    {**************************************MV*}
    Else If (Sender = edtNosNum) Then
    Begin
      pCriaTemporaria;
    End

  End;

  If Not Result Then
    Sender.SetFocus;
end;

function TfrmBaixaCtaReceber.fCriaClientRecibo: TUniClientDataSet;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    dspGen: TUniDataSetProvider;
    cdsGen: TUniClientDataSet;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT';
  strSQL := strSQL + '  REPEAT(" ", 9) AS NUMDUP,';
  strSQL := strSQL + '  REPEAT(" ", 300) AS HIST01,';
  strSQL := strSQL + '  REPEAT(" ", 150) AS HIST02,';
  strSQL := strSQL + '  REPEAT(" ", 12) AS NOSNUM,';
  strSQL := strSQL + '  CONVERT(NULL, DATE) AS DTAVEN,';
  strSQL := strSQL + '  CONVERT(NULL, DATE) AS DTAREC, ';
  strSQL := strSQL + '  0.00 AS VALDUP,';
  strSQL := strSQL + '  0.00 AS VALREC,';
  strSQL := strSQL + '  0.00 AS VALJUR,';
  strSQL := strSQL + '  0.00 AS VALDES,';
  strSQL := strSQL + '  REPEAT(" ", 8) AS CODCLI,';
  strSQL := strSQL + '  REPEAT(" ", 60) AS NOMCLI,';
  strSQL := strSQL + '  REPEAT(" ", 15) AS FONE01,';
  strSQL := strSQL + '  REPEAT(" ", 15) AS F_A_X_';
  strSQL := strSQL + '  LIMIT 0';

  qryGen := fCriaQuery(Self);
  dspGen := TUniDataSetProvider.Create(Self);
  dspGen.DataSet := qryGen;
  Result := TUniClientDataSet.Create(Self);
  Result.SetProvider(dspGen);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    pSetaClient(qryGen);
    Result.Open;

    Close;
  End;

  cdsGen := TUniClientDataSet.Create(Self);
  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;

    Filtered := False;
    Filter := 'CTR_MARDES = ''M''';
    Filtered := True;

    First;
    While Not Eof Do
    Begin
      Result.Append;
      Result.FieldByName('NUMDUP').AsString := FieldByName('NRODUP').AsString + '-' + FieldByName('CTR_ESPDOC').AsString;
      Result.FieldByName('HIST01').AsString := FieldByName('CTR_HIST01').AsString;
      Result.FieldByName('HIST02').AsString := FieldByName('CTR_HIST02').AsString;
      Result.FieldByName('NOSNUM').AsString := FieldByName('CTR_NOSNUM').AsString;
      Result.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
      Result.FieldByName('DTAREC').AsDateTime := FieldByName('CTR_DTAREC').AsDateTime;
      Result.FieldByName('VALDUP').AsFloat := FieldByName('CTR_VALDUP').AsFloat;
      Result.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
      Result.FieldByName('VALJUR').AsFloat := FieldByName('CTR_VALJUR').AsFloat;
      Result.FieldByName('VALDES').AsFloat := FieldByName('CTR_VALDES').AsFloat;
      Result.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
      Result.FieldByName('NOMCLI').AsString := FieldByName('CLI_NOMCLI').AsString;
      Result.FieldByName('FONE01').AsString := FieldByName('CLI_FONE01').AsString;
      Result.FieldByName('F_A_X_').AsString := FieldByName('CLI_F_A_X_').AsString;
      Result.Post;

      Application.ProcessMessages;
      Next;
    End;
  End;

  Result.SetProvider(nil);
  FreeAndNil(dspGen);
  FreeAndNil(qryGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCtaReceber.pCriaTemporaria;
  Var
    strSQL: String;
    strSQL2: String;
    qryCtaRec: TUniQuery;
    dspCtaRec: TUniDataSetProvider;
begin
  Try
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Self);
    dspCtaRec := TUniDataSetProvider.Create(Self);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
    strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';
    strSQL := strSQL + '  R.CTR_DTAENV AS CTR_DTAENV, ';
    strSQL := strSQL + '  R.CTR_VALDUP AS CTR_VALDUP, ';
    strSQL := strSQL + '  R.CTR_VALORI AS CTR_VALORI, ';
    strSQL := strSQL + '  R.CTR_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_FONE01 AS CLI_FONE01, ';
    strSQL := strSQL + '  C.CLI_F_A_X_ AS CLI_F_A_X_, ';
    strSQL := strSQL + '  CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS CTR_NOMCLI, ';
    strSQL := strSQL + '  R.CTR_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '  R.CTR_CODPOR AS CTR_CODPOR, ';
    strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR, ';
    strSQL := strSQL + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
    strSQL := strSQL + '  R.CTR_HIST01 AS CTR_HIST01, ';
    strSQL := strSQL + '  R.CTR_HIST02 AS CTR_HIST02, ';
    strSQL := strSQL + '  R.CTR_CODEVE AS CTR_CODEVE, ';
    strSQL := strSQL + '  E.EVE_DESEVE AS EVE_DESEVE, ';
    strSQL := strSQL + '  R.CTR_CODVEL AS CTR_CODVEL, ';
    strSQL := strSQL + '  R.CTR_CODVEN AS CTR_CODVEN, ';
    strSQL := strSQL + '  R.CTR_CODDIG AS CTR_CODDIG, ';
    strSQL := strSQL + '  R.CTR_DTACAD AS CTR_DTACAD, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_DESCON AS CTR_DESCON, ';
    strSQL := strSQL + '  R.CTR_OBSAG1 AS CTR_OBSAG1, ';
    strSQL := strSQL + '  R.CTR_OBSAG2 AS CTR_OBSAG2, ';
    strSQL := strSQL + '  R.CTR_OBSAG3 AS CTR_OBSAG3, ';
    strSQL := strSQL + '  "ID_CAIXA" AS CTR_IDENTI, ';
    strSQL := strSQL + '  (R.CTR_VALDUP - IFNULL(R.CTR_DESSUJ, 0) + IFNULL(R.CTR_JURSUJ, 0)) AS CTR_VALSUJ, ';
    strSQL := strSQL + '  IFNULL(R.CTR_DESSUJ, 0) AS CTR_DESSUJ, ';
    strSQL := strSQL + '  IFNULL(R.CTR_JURSUJ, 0) AS CTR_JURSUJ, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS CTR_DTAREC, ';
    strSQL := strSQL + '  0.00 AS CTR_VALDES, ';
    strSQL := strSQL + '  0.00 AS CTR_VALJUR, ';
    strSQL := strSQL + '  0.00 AS CTR_VALCAL, ';
    strSQL := strSQL + '  0.00 AS CTR_VALREC, ';
    strSQL := strSQL + '  " " AS CTR_TIPBAI, ';
    strSQL := strSQL + '  " " AS CTR_MARDES, ';
    strSQL := strSQL + '  ' + AnsiReplaceStr(FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 4), ',', '.') + ' AS CTR_TAXJUR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  TBLCADREC R ';
    strSQL := strSQL + 'LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';

    {**************************************}
    {* CASO O CODIGO DO EVENTO FOR NULO   *}
    {* TRAZ TODAS AS DUPLICATAS INCLUSIVE *}
    {* AS SEM EVENTOS.                    *}
    {***********************************LB*}
    If fEmptyStr(edtCodEve.Text) Then
      strSQL := strSQL + 'LEFT JOIN CADEVE E ON R.CTR_CODEVE = E.EVE_CODEVE  '
    Else
      strSQL := strSQL + '  , CADEVE E ';

    strSQL := strSQL + 'WHERE ';

    If Not fEmptyStr(edtCodEve.Text) Then
      strSQL := strSQL + '  R.CTR_CODEVE = E.EVE_CODEVE AND ';

    strSQL := strSQL + '  R.CTR_CODCLI = C.CLI_CODCLI AND ';
    strSQL := strSQL + '  R.CTR_DTAREC IS NULL AND ';
    strSQL := strSQL + '  R.CTR_SEQBAI = 0 ';

    If Not fEmptyStr(edtNosNum.Text) Then
    Begin
      strSQL  := strSQL  + '  AND R.CTR_NOSNUM = :NOSNUM ';
    End
    Else
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
        strSQL := strSQL + '  AND R.CTR_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtCodEve.Text) Then
        strSQL := strSQL + '  AND R.CTR_CODEVE = :CODEVE ';

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        strSQL := strSQL + '  AND R.CTR_CODEMP = :CODEMP ';

      If (Not fEmptyStr(edtCodPortador.Text)) Then
        strSQL := strSQL + '  AND R.CTR_CODPOR = :CODPOR ';

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        strSQL  := strSQL  + '  AND R.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    End;

    If intCaixa = 1 Then
    Begin
      strSQL := AnsiReplaceStr(strSQL, 'TBLCADREC', 'CADREC');
      strSQL := AnsiReplaceStr(strSQL, 'ID_CAIXA', '1');
    End
    Else
    Begin
      If fMensagem('', 'Opção: ', ['Individual', 'Global']) = 1 Then
      Begin
        strSQL := AnsiReplaceStr(strSQL, 'TBLCADREC', 'CADRECX');
        strSQL := AnsiReplaceStr(strSQL, 'ID_CAIXA', '2');
      End
      Else
      Begin
        strSQL2 := AnsiReplaceStr(strSQL, 'TBLCADREC', 'CADRECX');
        strSQL2 := AnsiReplaceStr(strSQL2, 'ID_CAIXA', '2');

        strSQL  := AnsiReplaceStr(strSQL, 'TBLCADREC', 'CADREC');
        strSQL  := AnsiReplaceStr(strSQL, 'ID_CAIXA', '1');

        strSQL  := strSQL + '  UNION  ' + strSQL2;
      End;
    End;

    With qryCtaRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(edtNosNum.Text) Then
        ParamByName('NOSNUM').AsString := edtNosNum.Text
      Else
      Begin
        If Not fEmptyStr(edtCodCli.Text) Then
          ParamByName('CODCLI').AsString := edtCodCli.Text;

        If Not fEmptyStr(edtCodEve.Text) Then
          ParamByName('CODEVE').AsString := edtCodEve.Text;

        If (Not fEmptyStr(edtCodEmp.Text)) Then
          ParamByName('CODEMP').AsString := edtCodEmp.Text;

        If (Not fEmptyStr(edtCodPortador.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPortador.Text;

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
        End;
      End;
      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaRec);
        With cdsCtaRec Do
        Begin
          Open;
          pSetaFieldsContasReceber(cdsCtaRec);
          IndexFieldNames := 'CTR_DTAVEN;CTR_CODCLI;CTR_NUMDUP;CTR_CODEMP';

          pCalculaValorCorrigido;
          pCalculaTotalDuplicatas(nil, nil, edtValorTotal, edtQtdDuplicatas, False);
          pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True);
          First;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);
        pLimpaDados;
        blnMudarFoco := False;
        edtCodCli.SetFocus;
      End;

      Close;
    End;

    strDocumento := EmptyStr;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pCriaTemporaria]');
  End;

  cdsCtaRec.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
end;

procedure TfrmBaixaCtaReceber.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmBaixaCtaReceber.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaDuplicata;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    edtCodCli.SetFocus;
  End
  Else If (Key = VK_F3) Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    btnDesmarcarTodas.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnRecalculaJuros.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    BtnSelecionadas.Click;
  End;
end;

procedure TfrmBaixaCtaReceber.pSelecionaTodas(blnMarcar: Boolean);
  Var
    intRecNo: Integer;
Begin
  With cdsCtaRec Do
  Begin
    Try
      DisableControls;
      intRecNo := RecNo;

      First;
      While Not Eof Do
      Begin
        {****************************************************}
        {* A DUPLICATA DEVE ESTAR COM A DATA DE ENVIO VAZIA *}
        {* SIGNIFICA QUE NAO FOI ENVIADA POR BOLETO         *}
        {*************************************************AN*}
        If (fEmptyStr(FieldByName('CTR_DTAENV').AsString)) Or (fCfgSis('BAIBOL', varBoolean)) Then
        Begin
          Edit;
          If blnMarcar Then
          Begin
            FieldByName('CTR_MARDES').AsString := 'M';
            FieldByName('CTR_TIPBAI').AsString := 'T';
            FieldByName('CTR_DTAREC').AsDateTime := VS_Date;
            FieldByName('CTR_VALREC').AsFloat := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;
          End
          Else
          Begin
            FieldByName('CTR_MARDES').AsString := 'D';
            FieldByName('CTR_TIPBAI').AsString := '';
            FieldByName('CTR_DTAREC').Value := Null;
            FieldByName('CTR_VALREC').AsFloat := 0;
          End;

          FieldByName('CTR_VALDES').AsFloat := 0;
          Post;
        End;

        Application.ProcessMessages;
        Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pSelecionaTodas]');
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True);
  Self.SetFocus;
End;

procedure TfrmBaixaCtaReceber.pSetaFieldsContasReceber(
  cdsClient: TUniClientDataSet);
begin
  (cdsClient.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsClient.FieldByName('CTR_VALSUJ') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsClient.FieldByName('CTR_VALCAL') As TFloatField).DisplayFormat := '#,##0.00';
end;

{*****************************************}
{* SELECIONA UMA DUPLICATA ABRE A TELA   *}
{* PARA DIGITAÇÃO DE VALORES             *}
{**************************************MV*}
procedure TfrmBaixaCtaReceber.pSelecionaDuplicata;
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  {***********************************************************}
  {* VERIFICA SE DEIXA BAIXAR DUPLICATAS ENVIADAS POR BOLETO *}
  {********************************************************LU*}
  If (Not fCfgSis('BAIBOL', varBoolean)) And (Not fEmptyStr(cdsCtaRec.FieldByName('CTR_DTAENV').AsString))  Then
  Begin
    fMensagem('', 'Duplicata enviada por boleto! Não é permitida a baixa manual!', ['&Ok']);
    Exit;
  End;

  If cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M' Then
  Begin
    Try
      pCriarFormularios(TfrmBaixaDigValores, frmBaixaDigValores);
      frmBaixaDigValores.blnVemCtr := True;
      frmBaixaDigValores.dtaDtaCad := cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime;
      frmBaixaDigValores.dtaDtaVen := cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime;
      frmBaixaDigValores.fltValDup := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat;
      frmBaixaDigValores.fltValCal := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;

      If fEmptyStr(fTiraCaracEspeciais(strDtaRec)) Then
        frmBaixaDigValores.dtaDtaPag := VS_Date
      Else
        frmBaixaDigValores.dtaDtaPag := StrToDate(strDtaRec);

      fltJur := cdsCtaRec.FieldByName('CTR_TAXJUR').AsFloat;
      frmBaixaDigValores.fltJurDup := fCalculaJurosCadCtr(cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                                          cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat,
                                                          fltJur);
      frmBaixaDigValores.ShowModal;

      If frmBaixaDigValores.blnConfirma Then
      Begin
        strTipBai := frmBaixaDigValores.strTipBai;
        fltValPag := frmBaixaDigValores.fltValPag;
        fltValJur := frmBaixaDigValores.fltValJur;
        fltValDes := frmBaixaDigValores.fltValDes;
        strDtaRec := frmBaixaDigValores.strDtaRec;

        pMarcaDuplicata(True,
                        strTipBai,
                        fltValPag,
                        fltValDes,
                        fltValJur,
                        strDtaRec);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmBaixaCtaReceber.pSelecionaDuplicata]');
    End;

    pFreeAndNil(frmBaixaDigValores);
  End
  Else
  Begin
    pMarcaDuplicata(False, '', 0, 0, 0, '');
  End;

  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True);
  cdsCtaRec.Next;
  Self.SetFocus;
end;

{*****************************************}
{* MARCA / DESMARCA UMA DUPLICATA        *}
{**************************************MV*}
procedure TfrmBaixaCtaReceber.pMarcaDuplicata(blnMarcar: Boolean;
                                              strTipBai: String;
                                              fltValor,
                                              fltValDes,
                                              fltValJur: Double;
                                              strDtaRec: String);
  Var
    dtaDtaVen: TDateTime;
    fltValDup: Double;
    fltTaxJur: Double;
begin
  dtaDtaVen := cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime;
  fltValDup := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat;
  fltTaxJur := cdsCtaRec.FieldByName('CTR_TAXJUR').AsFloat;

  With cdsCtaRec Do
  Begin
    Edit;
    FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    FieldByName('CTR_TIPBAI').AsString := strTipBai;
    FieldByName('CTR_VALREC').AsFloat := fltValor;

    If blnMarcar Then
      FieldByName('CTR_DTAREC').AsDateTime := StrToDateTime(strDtaRec)
    Else
    Begin
      FieldByName('CTR_DTAREC').Value   := Null;
      fltValDes := 0.0;
      fltValJur := fCalculaJurosCadCtr(dtaDtaVen, fltValDup, fltTaxJur);
    End;

    FieldByName('CTR_VALDES').AsFloat  := fltValDes;
    FieldByName('CTR_VALJUR').AsFloat  := fltValJur;
    Post;
  End;
end;

procedure TfrmBaixaCtaReceber.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If (cdsCtaRec.IsEmpty) Or (cdsCtaRec.FindField('CTR_MARDES') = Nil) Then
    Exit;

  If cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M' Then
  Begin
    If (State = [gdSelected]) And (dbgDuplicatas.Focused) Then
      dbgDuplicatas.Canvas.Font.Color := clLime
    Else
      dbgDuplicatas.Canvas.Font.Color := clBlue;
  End;

  If Column.FieldName = 'CTR_VALCAL' Then
  Begin
    If (Not cdsCtaRec.FieldByName('CTR_VALJUR').IsNull) And
       (cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat > 0.0) Then
    Begin
      dbgDuplicatas.Canvas.Font.Color := clRed;
      dbgDuplicatas.Canvas.FillRect(Rect);
    End;
  End;

  dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

{*****************************************}
{* ATUALIZA OS DADOS INFORMATIVOS DA DU- *}
{* PLICATAS                              *}
{**************************************MV*}
procedure TfrmBaixaCtaReceber.pAtualizaDados(DataSet: TDataSet);
begin
  edtCodPorBai.Text := DataSet.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := DataSet.FieldByName('POR_NOMPOR').AsString;
  edtCodEveBai.Text := DataSet.FieldByName('CTR_CODEVE').AsString;
  edtDesEveBai.Text := DataSet.FieldByName('EVE_DESEVE').AsString;
  edtNosNumBai.Text := DataSet.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := DataSet.FieldByName('CTR_HIST01').AsString;
  edtCodVel.Text    := DataSet.FieldByName('CTR_CODVEL').AsString;
  edtDespCob.Text   := FormatFloat('#,##0.00', DataSet.FieldByName('CTR_DESCOB').AsFloat);

  edtDespCob.Visible:= fStrToFloat(edtDespCob.Text) > 0;
  lblDespCob.Visible:= fStrToFloat(edtDespCob.Text) > 0;     
end;

procedure TfrmBaixaCtaReceber.FormCreate(Sender: TObject);
begin
  inherited;

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriaQuery(Self);

  cdsCtaRec := TUniClientDataSet.Create(Self);
  cdsCtaRec.AfterScroll := pAtualizaDados;
  cdsCtaRec.OnFilterRecord := pFilterRecord;
  dtsCtaRec := fCriaDataSource(cdsCtaRec);
  dbgDuplicatas.DataSource := dtsCtaRec;

  cdsChqPre := fCriaCdsCheques(Self);
  cdsChqVis := fCriaCdsCheques(Self);

  edtNosNum.TipoTexto := ttAlfanumerico;
end;

procedure TfrmBaixaCtaReceber.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
end;

{*****************************************}
{* LIMPA DADOS INFORMATIVOS DAS DUPLICA- *}
{* TAS                                   *}
{**************************************MV*}
procedure TfrmBaixaCtaReceber.pLimpaDados;
begin
  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtCodEveBai.Clear;
  edtDesEveBai.Clear;
  edtNosNumBai.Clear;
  edtHistor.Clear;
  edtCodVel.Clear;
  edtDespCob.Clear;
  edtDespCob.Visible := False;
  lblDespCob.Visible := False;

  edtJurosTotal.Clear;
  edtDescontoTotal.Clear;
  edtValorTotal.Clear;
  edtTotalRecebido.Clear;
  edtQtdDuplicatas.Clear;
  edtQtdSelecionadas.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodEve.Clear;
  edtDesEve.Clear;

  cdsCtaRec.Close;
end;

{*****************************************}
{* FAZ A BAIXA DE TODAS AS DUPLICATAS    *}
{**************************************MV*}
function TfrmBaixaCtaReceber.fBaixaDuplicatas: Boolean;
  Var
    blnBaiAna   : Boolean;
    blnConfirma : Boolean;
    strSeqLan   : String;
    strCreDeb   : String;
    strSeqMod   : String;
    fltValRec   : Double;
    intSeqBai   : Integer;
    intContador : Integer;
    intDupCx1   : Integer;
    intDupCx2   : Integer;
    intContCopia: Integer;
    intContador2: Integer;
    intRecNoCtr : Integer;

    fltTotCx1   : Double;
    fltTotCx2   : Double;

    fltValDes   : Double;
    fltValJur   : Double;
    fltValCqP   : Double;
    fltValCqV   : Double;
    fltValDin   : Double;
    fltValCar   : Double;
    fltValOrd   : Double;
    fltValFin   : Double;
    fltValCre   : Double;

    fltTotRec   : Double;
    fltTotCqP   : Double;
    fltTotCqV   : Double;
    fltTotDin   : Double;
    fltTotCar   : Double;
    fltTotOrd   : Double;
    fltTotFin   : Double;

    fltAuxRec   : Double;
    fltAuxCqP   : Double;
    fltAuxCqV   : Double;
    fltAuxDin   : Double;
    fltAuxCar   : Double;
    fltAuxOrd   : Double;
    fltAuxFin   : Double;

    blnValCqP   : Boolean;
    blnValCqV   : Boolean;
    blnValDin   : Boolean;
    blnValCar   : Boolean;
    blnValOrd   : Boolean;
    blnValFin   : Boolean;

    arrCartoes  : Array Of TCartoesResumoCaixa; //CARTOES ARMAZENADOS NA FORMA DE PAGAMENTO
    arrDuplicFat: Array[0..11] Of TArrDigDuplic;

    fltNovoValDup: Double;
    fltNovoValOri: Double;
    dtaDtaVen    : TDateTime;

    cdsTmpRec: TUniClientDataSet;
    cdsBackup: TUniClientDataSet;

    intQtdDup: Integer;
    strDocume: String;
    intSeqPar: Integer;
    strNumDupCartao: String;
    arrLogCtr: TRegistroLogCtr;
    strPriCli: String;
    rcxComissao: TRcxComissao;
    bkmPosGri: TBookmark;
    blnHisAut: Boolean;
    strManVen: String;

    procedure pBackupClientContasReceber;
    begin
      If Not Assigned(cdsBackup) Then
      Begin
        cdsBackup := TUniClientDataSet.Create(Self);
        cdsBackup.Data := cdsCtaRec.Data;
        cdsBackup.IndexFieldNames := cdsCtaRec.IndexFieldNames;
        cdsBackup.RecNo := cdsCtaRec.RecNo;
      End Else
      Begin
        cdsCtaRec.Data := cdsBackup.Data;
        cdsCtaRec.IndexFieldNames := cdsBackup.IndexFieldNames;
        cdsCtaRec.RecNo := cdsBackup.RecNo;
        pSetaFieldsContasReceber(cdsCtaRec);
        FreeAndNil(cdsBackup);
      End;
    end;

begin
  blnConfirma := False;

  Try
    SetLength(arrLogCtr,0);
    intQtdDup := 0;
    strDocume := '';

    fltValDes := 0;
    fltValCqP := 0;
    fltValCqV := 0;
    fltValDin := 0;
    fltValCar := 0;
    fltValOrd := 0;
    fltValFin := 0;
    fltValCre := 0;

    fltTotRec := 0;
    fltTotCqP := 0;
    fltTotCqV := 0;
    fltTotDin := 0;
    fltTotCar := 0;
    fltTotOrd := 0;
    fltTotFin := 0;

    fltAuxRec := 0;
    fltAuxCqP := 0;
    fltAuxCqV := 0;
    fltAuxDin := 0;
    fltAuxCar := 0;
    fltAuxOrd := 0;
    fltAuxFin := 0;

    intSeqBai := 0;

    blnValCqP := False;
    blnValCqV := False;
    blnValDin := False;
    blnValCar := False;
    blnValOrd := False;
    blnValFin := False;

    cdsRateio := fCriaCdsRateio(Self);

    Result    := False;
    blnBaiAna := fCfgSis('CTR_AS') = 'A';
    strSeqLan := '';

    pBackupClientContasReceber;
    intRecNoCtr := cdsCtaRec.RecNo;

    pRetDupSelecionadas(intDupCx1, intDupCx2, fltTotCx1, fltTotCx2);

    {*****************************************}
    {* ENCONTRA PRIMEIRO CLIENTE.            *}
    {**************************************MV*}
    cdsCtaRec.DisableControls;
    cdsCtaRec.First;
    While (Not cdsCtaRec.Eof) Do
    Begin

      If (cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M') And (fEmptyStr(strPriCli)) Then
      Begin
        strPriCli := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;
        bkmPosGri := cdsCtaRec.GetBookmark;
        Break;
      End;

      cdsCtaRec.Next;
    End;

    cdsCtaRec.First;
    cdsCtaRec.EnableControls;

    {*****************************************}
    {* CASO SEJA GRAVAÇÃO ANALITICA...       *}
    {**************************************MV*}
    intIdenti := intCaixa;
    If blnBaiAna Then
    Begin

      {******************************************}
      {* ...CHAMA A TELA DE BAIXA ANALÍTICA...  *}
      {***************************************MV*}
      Try
        pCriarFormularios(TfrmBaixaCtrAnalitica, frmBaixaCtrAnalitica);

        If intCaixa = 2 Then
        Begin

          If intDupCx1 <= 0 Then
            frmBaixaCtrAnalitica.edtPorBai.Enabled := False;

          If intDupCx2 <= 0 Then
            frmBaixaCtrAnalitica.edtPorBa2.Enabled := False;

        End;

        frmBaixaCtrAnalitica.showModal;

        strCtaBai     := frmBaixaCtrAnalitica.strCtaBai;
        strPorBai     := frmBaixaCtrAnalitica.strPorBai;
        strPorBa2     := frmBaixaCtrAnalitica.strPorBa2;
        strHisBai     := frmBaixaCtrAnalitica.strHisBai;
        intDCrRecPor1 := frmBaixaCtrAnalitica.intDCrRecPor1;
        intDcrRecPor2 := frmBaixaCtrAnalitica.intDCrRecPor2;
        blnConfirma   := frmBaixaCtrAnalitica.blnConfirma;
        blnHisAut     := fEmptyStr(strHisBai);

      Except
        On E: Exception Do
        Begin
          strCtaBai := '';
          strPorBai := '';
          strPorBa2 := '';
          strHisBai := '';
          pMensagensErro(E.Message,'[fBaixaDuplicatas - frmBaixaCtrAnalitica]');
        End;
      End;

      pFreeAndNil(frmBaixaCtrAnalitica);

    End
    Else
    Begin

      {*****************************************}
      {* ...CASO SEJA SINTÉTICA, CHAMA TELA DE *}
      {* BAIXA SINTÉTICA, E ATRIBUI OS VALORES *}
      {* QUE SERÃO ATRIBUIDOS PARA TODAS AS    *}
      {* DUPLICATAS E PARA O ÚNICO MOVBAN      *}
      {**************************************MV*}
      Try
        pCriarFormularios(TfrmBaixaSintetica, frmBaixaSintetica);

        If intCaixa = 2 Then
        Begin
          If intDupCx1 <= 0 Then
            frmBaixaSintetica.edtPorBai.Enabled := False;

          If intDupCx2 <= 0 Then
            frmBaixaSintetica.edtPorBa2.Enabled := False;

        End;

        frmBaixaSintetica.showModal;

        strPorBai     := frmBaixaSintetica.strPorBai;
        strPorBa2     := frmBaixaSintetica.strPorBa2;
        strCtaBai     := frmBaixaSintetica.strCtaBai;
        strDtaLan     := frmBaixaSintetica.strDtaLan;
        strDocBai     := frmBaixaSintetica.strDocBai;
        strHisBai     := frmBaixaSintetica.strHisBai;
        intDCrRecPor1 := frmBaixaSintetica.intDCrRecPor1;
        intDcrRecPor2 := frmBaixaSintetica.intDCrRecPor2;
        blnConfirma   := frmBaixaSintetica.blnConfirma;

      Except
        On E: Exception Do
        Begin
          strPorBai     := '';
          strPorBa2     := '';
          strCtaBai     := '';
          strDtaLan     := '';
          strDocBai     := '';
          strHisBai     := '';
          pMensagensErro(E.Message,'[fBaixaDuplicatas - frmBaixaSintetica]');
        End
      End;

      pFreeAndNil(frmBaixaSintetica);

    End;

    {******************************************}
    {* SE SAIU DA TELA DE BAIXA, NÃO CONTINUA *}
    {***************************************PZ*}
    If (Not blnConfirma) Then
    Begin
      pBackupClientContasReceber;
      Exit;
    End;

    Try

      cdsTmpRec := TUniClientDataSet.Create(Self);
      With cdsTmpRec Do
      Begin
        Data := cdsCtaRec.Data;
        Filtered := False;
        Filter := 'CTR_MARDES = ''M''';
        Filtered := True;
        IndexFieldNames := cdsCtaRec.IndexFieldNames;

        If RecordCount = 1 Then
          strDocumento := FieldByName('NRODUP').AsString +
                          FieldByName('PARDUP').AsString +
                          FieldByName('CTR_ESPDOC').AsString +
                          FieldByName('CTR_CODEMP').AsString
        Else
          strDocumento := 'DIVERSOS';

        pCriarFormularios(TfrmFatFormasPagamento,frmFatFormasPagamento);
        frmFatFormasPagamento.strCodOpe := strLoginUsuarioLogado;
        frmFatFormasPagamento.blnCtaRec := True;
        frmFatFormasPagamento.fltValTot := fStrToFloat(edtTotalRecebido.Text);
        frmFatFormasPagamento.edtFaturado.Enabled := False;
        frmFatFormasPagamento.edtFaturado.Visible := False;
        frmFatFormasPagamento.lblFaturado.Visible := False;
        frmFatFormasPagamento.cdsChqPre           := cdsChqPre;
        frmFatFormasPagamento.cdsChqVis           := cdsChqVis;
        frmFatFormasPagamento.strDocume           := strDocumento;
        frmFatFormasPagamento.Height := 269;

        If (frmFatFormasPagamento.fltValTot < 0.0) Then
        Begin
          frmFatFormasPagamento.edtChqVista.Enabled    := False;
          frmFatFormasPagamento.edtChqVista.Visible    := False;
          frmFatFormasPagamento.lblChequeVista.Visible := False;

          frmFatFormasPagamento.edtChqPre.Enabled    := False;
          frmFatFormasPagamento.edtChqPre.Visible    := False;
          frmFatFormasPagamento.lblChequePre.Visible := False;

          frmFatFormasPagamento.edtCartao.Enabled := False;
          frmFatFormasPagamento.edtCartao.Visible := False;
          frmFatFormasPagamento.lblCartao.Visible := False;

          frmFatFormasPagamento.edtFaturado.Enabled := False;
          frmFatFormasPagamento.edtFaturado.Visible := False;
          frmFatFormasPagamento.lblFaturado.Visible := False;

          frmFatFormasPagamento.edtOrdPag.Enabled := False;
          frmFatFormasPagamento.edtOrdPag.Visible := False;
          frmFatFormasPagamento.lblOrdPag.Visible := False;

          frmFatFormasPagamento.Height := 179;
        End;

        frmFatFormasPagamento.strCliente := strPriCli;

        If (frmFatFormasPagamento.fltValTot = 0.0) Or (frmFatFormasPagamento.ShowModal = mrOK) Then
          blnConfirma := True
        Else
          blnConfirma := False;

        Close;
      End;

      cdsChqPre := frmFatFormasPagamento.cdsChqPre;
      cdsChqVis := frmFatFormasPagamento.cdsChqVis;

      If blnConfirma Then
      Begin

        {************************************}
        {* ALIMENTA VARIAVEIS QUE VÃO SER   *}
        {* GRAVADAS NO CADREC               *}
        {* PS. "ALIMENTA" ME DEU FOME       *}
        {*********************************AF*}
        fltValCqP := frmFatFormasPagamento.fltChqPre;
        fltValCqV := frmFatFormasPagamento.fltChqVis;
        fltValDin := frmFatFormasPagamento.fltDinhei;
        fltValCar := frmFatFormasPagamento.fltCartao;
        fltValOrd := frmFatFormasPagamento.fltOrdPag;
        fltValFin := frmFatFormasPagamento.fltValFin;
        fltValCre := frmFatFormasPagamento.fltValCre;

        fltTotRec := frmFatFormasPagamento.fltValTot;

        blnValCqP := fltValCqP > 0;
        blnValCqV := fltValCqV > 0;
        blnValDin := fltValDin > 0;
        blnValCar := fltValCar > 0;
        blnValOrd := fltValOrd > 0;
        blnValFin := fltValFin > 0;

        SetLength(arrCartoes,Length(frmFatFormasPagamento.arrCartoes));

        For intContador := 0 To Length(frmFatFormasPagamento.arrCartoes)-1 Do
          arrCartoes[intContador] := frmFatFormasPagamento.arrCartoes[intContador];

      End;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message,'[fBaixaDuplicatas - frmFatFormasPagamento]');
      End;
    End;

    FreeAndNil(cdsTmpRec);
    pFreeAndNil(frmFatFormasPagamento);

    If blnConfirma Then
      strSeqMod := fRetSequencial('MODCTR');

    If fEmptyStr(strSeqMod) Then
      blnConfirma := False;

    {*****************************************}
    {* CASO CANCELAR, SAI                    *}
    {**************************************MV*}
    If Not blnConfirma Then
    Begin
      pBackupClientContasReceber;
      cdsChqPre.EmptyDataSet;
      cdsChqVis.EmptyDataSet;
      Exit;
    End;

    fStartTransaction;

    Try

      intSeqCon := StrToInt(fRetRcxCon);

      Result := True;
      
      rcxComissao := TRcxComissao.Create(fltTotCx1 + fltTotCx2,
                                         fltValCqP + fltValCqV + fltValCar, self);

      If Not rcxComissao.fComissaoOk Then
      Begin
        pBackupClientContasReceber;
        cdsChqPre.EmptyDataSet;
        cdsChqVis.EmptyDataSet;

        fRollback;
        Result := FALSE;
        FreeAndNil(rcxComissao);
        Exit;
      End;

      {*****************************************}
      {* BAIXA AS DUPLICATAS SELECIONADAS...   *}
      {**************************************MV*}
      With cdsCtaRec Do
      Begin
        DisableControls;

        {*****************************************}
        {* AGORA, GRAVA O MOVBAN DA BAIXA SIN-   *}
        {* TÉTICA                                *}
        {**************************************MV*}
        If Not blnBaiAna Then
        Begin
          {*****************************************}
          {* GRAVA MOVBAN CAIXA 1                  *}
          {**************************************MV*}
          If fltTotCx1 <> 0.0 Then
          Begin

            strCreDeb := IIF(fltTotCx1 > 0, 'C', 'D');
            fltTotCx1 := IIF(fltTotCx1 > 0, fltTotCx1, -fltTotCx1);

            strSeqLan := fGravaMovBan('MOVBAN',
                                      strCtaBai,                          // Centro de Custo
                                      strPorBai,                          // Portador da Baixa
                                      strLoginUsuarioLogado,              // Operador da Baixa
                                      StrToDate(strDtaLan)+intDCrRecPor1, // Data do Lançamento
                                      Time(),                             // Hora do Lançamento
                                      strDocBai,                          // Numero do Documento
                                      strCreDeb,                          // Credito / Debito
                                      VS_strCodEmp,                       // Empresa da Baixa
                                      fltTotCx1,                          // Valor Do Lançamento
                                      strHisBai,                          // Histórico 1
                                      '',                                 // Histórico 2
                                      '',                                 // Cliente da Duplicata
                                      '',                                 // Fornecedor da Duplicata
                                      '',                                 // Número da Duplicata
                                      0,                                  // Sequencial de Baixa
                                      '',                                 // Parcela da Duplicata
                                      '',                                 // Empresa da Duplicata
                                      '',                                 // Série
                                      //strSeqLan,                        // Sequencial de Lançamento
                                      '',                                 // Codigo do Evento
                                      '');

            If (fEmptyStr(strSeqLan)) Then
            Begin
              Result := False;

              pBackupClientContasReceber;
              cdsChqPre.EmptyDataSet;
              cdsChqVis.EmptyDataSet;

              fRollback;
              FreeAndNil(rcxComissao);

              EnableControls;

              Exit;
            End;
          End;

          {*****************************************}
          {* GRAVA MOVBAN CAIXA 2                  *}
          {**************************************MV*}
          If intCaixa = 2 Then
          Begin
            If fltTotCx2 <> 0.0 Then
            Begin

              strCreDeb := IIF(fltTotCx2 > 0, 'C', 'D');
              fltTotCx2 := IIF(fltTotCx2 > 0, fltTotCx2, -fltTotCx2);

              strSeqLan := fGravaMovBan('MOVBANX',
                                        strCtaBai,                          // Centro de Custo
                                        strPorBa2,                          // Portador da Baixa
                                        strLoginUsuarioLogado,              // Operador da Baixa
                                        StrToDate(strDtaLan)+intDCrRecPor2, // Data do Lançamento
                                        Time(),                             // Hora do Lançamento
                                        strDocBai,                          // Numero do Documento
                                        strCreDeb,                          // Credito / Debito
                                        VS_strCodEmp,                       // Empresa da Baixa
                                        fltTotCx2,                          // Valor Do Lançamento
                                        strHisBai,                          // Histórico 1
                                        '',                                 // Histórico 2
                                        '',                                 // Cliente da Duplicata
                                        '',                                 // Fornecedor da Duplicata
                                        '',                                 // Número da Duplicata
                                        0,                                  // Sequencial de Baixa
                                        '',                                 // Parcela da Duplicata
                                        '',                                 // Empresa da Duplicata
                                        '',                                 // Serie
                                        //strSeqLan,                        // Sequencial de Lançamento
                                        '',                                 // Codigo do Evento
                                        '');

              If (fEmptyStr(strSeqLan)) Then
              Begin
                Result := False;

                pBackupClientContasReceber;
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;
                FreeAndNil(rcxComissao);

                EnableControls;

                Exit;
              End;
            End;

          End;

        End;

        First;
        While Not Eof Do
        Begin

          If FieldByName('CTR_MARDES').AsString = 'M' Then
          Begin
            {*****************************************}
            {* ALTERA A VARIAVEL 'strNomeTabela'.    *}
            {* ASSIM, É REFLETIDO PARA O MODULO DE   *}
            {* BAIXA QUAL TABELA DEVE SER USADA, OU  *}
            {* CADREC OU CADRECX                     *}
            {**************************************MV*}
            If FieldByName('CTR_IDENTI').AsInteger = 1 Then
            Begin
              strNomeTabela   := 'CADREC';
              strTabelaMovBan := 'MOVBAN';
            End
            Else
            Begin
              strNomeTabela   := 'CADRECX';
              strTabelaMovBan := 'MOVBANX';
            End;

            intIdenti := FieldByName('CTR_IDENTI').AsInteger;

            {*****************************************}
            {* ...GRAVANDO O MOVBAN CASO SEJA GRAVA- *}
            {* ÇÃO ANALÍTICA OU...                   *}
            {**************************************MV*}
            If blnBaiAna Then
            Begin

              If (blnHisAut) Then
                strHisBai := 'Rec. ' +
                             cdsCtaRec.FieldByName('CTR_CODCLI').AsString + ' - ' +
                             cdsCtaRec.FieldByName('CLI_NOMCLI').AsString;

              If FieldByName('CTR_VALREC').AsFloat < 0 Then
              Begin
                fltValRec := -FieldByName('CTR_VALREC').AsFloat; // Valor negativo
                strCreDeb := 'D';
              End
              Else
              Begin
                fltValRec := FieldByName('CTR_VALREC').AsFloat;
                strCreDeb := 'C';
              End;

              intSeqBai := fRetSeqBaiCadRec(strNomeTabela,
                                            FieldByName('NRODUP').AsString,
                                            FieldByName('PARDUP').AsString,
                                            FieldByName('CTR_CODEMP').AsString,
                                            FieldByName('CTR_ESPDOC').AsString,
                                            FieldByName('CTR_CODCLI').AsString);

              Inc(intQtdDup);

              If intIdenti = 1 Then
                intDCrRec := intDCrRecPor1
              Else
                intDCrRec := intDcrRecPor2;

              strSeqLan := fGravaMovBan(strTabelaMovBan,
                                        strCtaBai,                                        // Centro de Custo
                                        IIF(intIdenti = 1, strPorBai, strPorBa2),         // Portador da Baixa
                                        strLoginUsuarioLogado,                            // Operador da Baixa
                                        FieldByName('CTR_DTAREC').AsDateTime + intDCrRec, // Data do Lançamento
                                        Time(),                                           // Hora do Lançamento
                                        FieldByName('CTR_NUMDUP').AsString,               // Numero do Documento
                                        strCreDeb,                                        // Credito / Debito
                                        VS_strCodEmp,                                     // Empresa da Baixa
                                        fltValRec,                                        // Valor Do Lançamento
                                        strHisBai,                                        // Histórico 1
                                        '',                                               // Histórico 2
                                        FieldByName('CTR_CODCLI').AsString,               // Cliente da Duplicata
                                        '',                                               // Fornecedor da Duplicata
                                        FieldByName('NRODUP').AsString,                   // Número da Duplicata
                                        intSeqBai + 1,                                    // Sequencial de Baixa
                                        FieldByName('PARDUP').AsString,                   // Parcela da Duplicata
                                        FieldByName('CTR_CODEMP').AsString,               // Empresa da Duplicata
                                        '',                                               // Série
                                        //'',                                             // Sequencial de Lançamento
                                        FieldByName('CTR_CODEVE').AsString,               // Codigo do Evento
                                        '');

              If (fEmptyStr(strSeqLan)) Then
              Begin
                Result := False;

                pBackupClientContasReceber;
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;
                FreeAndNil(rcxComissao);

                EnableControls;

                Exit;
              End;

            End
            Else
            Begin
              {*****************************************}
              {* ...SOMANDO OS VALORES RECEBIDOS PARA  *}
              {* A GRAVAÇÃO ÚNICA DO MOVBAN CASO SEJA  *}
              {* GRAVAÇÃO SINTÉTICA.                   *}
              {**************************************MV*}
    //          fltValLan := fltValLan + FieldByName('CTR_VALREC').AsFloat;
            End;

            {*****************************************}
            {* AGORA, GRAVA O CADREC                 *}
            {**************************************MV*}
            If FieldByName('CTR_TIPBAI').AsString = 'T' Then
            Begin

              fltValDes := 0.0;
              fltValJur := 0.0;

              If cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat > cdsCtaRec.FieldByName('CTR_VALREC').AsFloat Then
              Begin
                fltValDes := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat - cdsCtaRec.FieldByName('CTR_VALREC').AsFloat;
              End
              Else
              Begin
                fltValJur := cdsCtaRec.FieldByName('CTR_VALREC').AsFloat - cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat;
              End;

              Result := rcxComissao.fAcumula(cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,
                                             cdsCtaRec.FieldByName('CTR_CODVEN').AsString);

              {*********************************}
              {* RATEIO DOS VALORES RECEBIDOS  *}
              {******************************RV*}
              fltAuxCqP := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValCqP);
              fltAuxCqV := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValCqV);
              fltAuxDin := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValDin);
              fltAuxCar := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValCar);
              fltAuxOrd := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValOrd);
              fltAuxFin := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValFin);

              fltTotCqP := fltTotCqP + fltAuxCqP;
              fltTotCqV := fltTotCqV + fltAuxCqV;
              fltTotDin := fltTotDin + fltAuxDin;
              fltTotCar := fltTotCar + fltAuxCar;
              fltTotOrd := fltTotOrd + fltAuxOrd;
              fltTotFin := fltTotFin + fltAuxFin;
              {*********************************}
              {* DIFERENÇA NA ÚLTIMA DUPLICATA *}
              {******************************RV*}
              If (intQtdDup = StrToInt(edtQtdSelecionadas.Text)) Then
              Begin

                If (fltTotCqP < fltValCqP) Then
                  fltAuxCqP := fltAuxCqP + (fltValCqP - fltTotCqP)
                Else If (fltTotCqP > fltValCqP) Then
                  fltAuxCqP := fltAuxCqP - (fltTotCqP - fltValCqP);

                If (fltTotCqV < fltValCqV) Then
                  fltAuxCqV := fltAuxCqV + (fltValCqV - fltTotCqV)
                Else If (fltTotCqV > fltValCqV) Then
                  fltAuxCqV := fltAuxCqV - (fltTotCqV - fltValCqV);

                If (fltTotDin < fltValDin) Then
                  fltAuxDin := fltAuxDin + (fltValDin - fltTotDin)
                Else If (fltTotDin > fltValDin) Then
                  fltAuxDin := fltAuxDin - (fltTotDin - fltValDin);

                If (fltTotCar < fltValCar) Then
                  fltAuxCar := fltAuxCar + (fltValCar - fltTotCar)
                Else If (fltTotCar > fltValCar) Then
                  fltAuxCar := fltAuxCar - (fltTotCar - fltValCar);

                If (fltTotOrd < fltValOrd) Then
                  fltAuxOrd := fltAuxOrd + (fltValOrd - fltTotOrd)
                Else If (fltTotOrd > fltValOrd) Then
                  fltAuxOrd := fltAuxOrd - (fltTotOrd - fltValOrd);

                If (fltTotFin < fltValFin) Then
                  fltAuxFin := fltAuxFin + (fltValFin - fltTotFin)
                Else If (fltTotFin > fltValFin) Then
                  fltAuxFin := fltAuxFin - (fltTotFin - fltValFin);

              End;

              pGravaRateio(cdsRateio,
                           0,
                           strNomeTabela,
                           FieldByName('NRODUP').AsString, FieldByName('PARDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                           fltAuxDin, fltAuxCqV, fltAuxCqP, fltAuxCar, fltAuxOrd, fltAuxFin,
                           fltValDin, fltValCqV, fltValCqP, fltValCar, fltValOrd, fltValFin);

              Result := fBaixaTotal(strNomeTabela,                                         // Nome do Arquivo
                                    cdsCtaRec.FieldByName('NRODUP').AsString,       // Duplicata
                                    cdsCtaRec.FieldByName('PARDUP').AsString,       // Parcela
                                    cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,   // Espécie
                                    cdsCtaRec.FieldByName('CTR_CODEMP').AsString,   // Empresa
                                    cdsCtaRec.FieldByName('CTR_CODCLI').AsString,   // Cliente
                                    cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,    // Valor Recebido
                                    fltValJur,                                                       // Valor de Juros
                                    fltValDes,                                                       // Valor de Desconto
                                    fltAuxCqP,                                                       // Valor de CHQ VISTA (rateado)
                                    fltAuxCqV,                                                       // Valor de CHQ PRAZO (rateado)
                                    fltAuxDin,                                                       // Valor de dinheiro (rateado)
                                    fltAuxCar,                                                       // Valor de cartao (rateado)
                                    fltAuxOrd,                                                       // Valor da Ordem de Pagamento (rateado)
                                    fltAuxFin,
                                    cdsCtaRec.FieldByName('CTR_DTAREC').AsDateTime, // Data de Recebimento
                                    strSeqLan,                                                       // Sequencial de Lancamento(MOVBAN)
                                    strHisBai,                                                       // Histórico da Baixa
                                    strCtaBai,                                                       // Coentro de Custo
                                    IIF(intIdenti = 1, strPorBai, strPorBa2),                        // Portador da Baixa
                                    strLoginUsuarioLogado,     // Operador da Baixa
                                    StrToInt(strSeqMod),
                                    blnValCqP,
                                    blnValCqV,
                                    blnValDin,
                                    blnValCar,
                                    blnValOrd,
                                    blnValFin,
                                    0,                                                               // Recebido pelo res. caixa?
                                    cdsCtaRec.FieldByName('CTR_VALORI').AsFloat,    // Valor Original
                                    rcxComissao.strSeqCom,
                                    rcxComissao.fltPerDes,
                                    intSeqCon);                                                      // Sequencial de Controle


              strDocume := FieldByName('NRODUP').AsString + '-' +
                           FieldByName('PARDUP').AsString + '-' +
                           FieldByName('CTR_ESPDOC').AsString + '-' +
                           FieldByName('CTR_CODEMP').AsString + '-' +
                           fStrZero(intSeqBai,3);

              If Result Then
                Result := fInsereLogCtrArr(arrLogCtr,
                                           cdsCtaRec.FieldByName('NRODUP').AsString,
                                           cdsCtaRec.FieldByName('PARDUP').AsString,
                                           0,
                                           cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODVEN').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODDIG').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODPOR').AsString,
                                           cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime,
                                           cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                           0,
                                           cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_DESCON').AsString,
                                           cdsCtaRec.FieldByName('CTR_HIST01').AsString,
                                           cdsCtaRec.FieldByName('CTR_HIST02').AsString,
                                           strHisBai,
                                           IIF(intIdenti = 1, strPorBai, strPorBa2),
                                           strCtaBai,
                                           strLoginUsuarioLogado,
                                           strSeqLan,
                                           cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_DTAREC').AsDateTime,
                                           VS_Date,
                                           cdsCtaRec.FieldByName('CTR_CODEVE').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODVEL').AsString,
                                           'BAIXA TOTAL',
                                           Self.Name,
                                           0,
                                           fltValDes,
                                           fltValJur,
                                           fltValCqP,
                                           fltValCqV,
                                           fltValDin,
                                           fltValCar,
                                           fltValOrd,
                                           fltValFin,
                                           blnValCqP,
                                           blnValCqV,
                                           blnValDin,
                                           blnValCar,
                                           blnValOrd,
                                           blnValFin,
                                           StrToInt(strSeqMod),
                                           '',
                                           '',
                                           False,
                                           '',
                                           intSeqCon,
                                           '',
                                           cdsCtaRec.FieldByName('CTR_OBSAG1').AsString,
                                           cdsCtaRec.FieldByName('CTR_OBSAG2').AsString,
                                           cdsCtaRec.FieldByName('CTR_OBSAG3').AsString,
                                           '',
                                           0,
                                           0,
                                           0,
                                           rcxComissao.strSeqCom,
                                           rcxComissao.fltPerDes);
              If (Not Result) Then
              Begin
                pBackupClientContasReceber;
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;
                FreeAndNil(rcxComissao);

                EnableControls;

                Exit;
              End;

            End
            Else
            Begin

              fltValJur     := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat -
                               cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat;

              fltNovoValDup := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat -
                               cdsCtaRec.FieldByName('CTR_VALREC').AsFloat ;

              fltNovoValOri := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;

              strManVen := fCfgSis('MANVEN');

              If (cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime > VS_Date) Then
                dtaDtaVen := cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime
              Else
              Begin
                {*******************************************}
                {* SE FOR RECEBIMENTO PARCIAL E ESTIVER    *}
                {* CONFIGURADO PARA MANTER A DATA DO       *}
                {* VENCIMENTO, GRAVA A DATA DE VENCIMENTO  *}
                {* REAL, SENÃO GRAVA A DATA DO RECEBIMENTO.*}
                {****************************************PZ*}
                If (strManVen = 'S') Then
                  dtaDtaVen := cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime
                Else
                  dtaDtaVen := cdsCtaRec.FieldByName('CTR_DTAREC').AsDateTime;
              End;

              If Result Then
                Result := rcxComissao.fAcumula(cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,
                                               cdsCtaRec.FieldByName('CTR_CODVEN').AsString);

              {*********************************}
              {* RATEIO DOS VALORES RECEBIDOS  *}
              {******************************RV*}
              fltAuxCqP := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValCqP);
              fltAuxCqV := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValCqV);
              fltAuxDin := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValDin);
              fltAuxCar := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValCar);
              fltAuxOrd := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValOrd);
              fltAuxFin := fRateioRec(fltTotRec, FieldByName('CTR_VALREC').AsFloat, fltValFin);

              fltTotCqP := fltTotCqP + fltAuxCqP;
              fltTotCqV := fltTotCqV + fltAuxCqV;
              fltTotDin := fltTotDin + fltAuxDin;
              fltTotCar := fltTotCar + fltAuxCar;
              fltTotOrd := fltTotOrd + fltAuxOrd;
              fltTotFin := fltTotFin + fltAuxFin;
              {*********************************}
              {* DIFERENÇA NA ÚLTIMA DUPLICATA *}
              {******************************RV*}
              If (intQtdDup = StrToInt(edtQtdSelecionadas.Text)) Then
              Begin

                If (fltTotCqP < fltValCqP) Then
                  fltAuxCqP := fltAuxCqP + (fltValCqP - fltTotCqP)
                Else If (fltTotCqP > fltValCqP) Then
                  fltAuxCqP := fltAuxCqP - (fltTotCqP - fltValCqP);

                If (fltTotCqV < fltValCqV) Then
                  fltAuxCqV := fltAuxCqV + (fltValCqV - fltTotCqV)
                Else If (fltTotCqV > fltValCqV) Then
                  fltAuxCqV := fltAuxCqV - (fltTotCqV - fltValCqV);

                If (fltTotDin < fltValDin) Then
                  fltAuxDin := fltAuxDin + (fltValDin - fltTotDin)
                Else If (fltTotDin > fltValDin) Then
                  fltAuxDin := fltAuxDin - (fltTotDin - fltValDin);

                If (fltTotCar < fltValCar) Then
                  fltAuxCar := fltAuxCar + (fltValCar - fltTotCar)
                Else If (fltTotCar > fltValCar) Then
                  fltAuxCar := fltAuxCar - (fltTotCar - fltValCar);

                If (fltTotOrd < fltValOrd) Then
                  fltAuxOrd := fltAuxOrd + (fltValOrd - fltTotOrd)
                Else If (fltTotOrd > fltValOrd) Then
                  fltAuxOrd := fltAuxOrd - (fltTotOrd - fltValOrd);

                If (fltTotFin < fltValFin) Then
                  fltAuxFin := fltAuxFin + (fltValFin - fltTotFin)
                Else If (fltTotFin > fltValFin) Then
                  fltAuxFin := fltAuxFin - (fltTotFin - fltValFin);
              End;

              If Result Then
                Result := fBaixaParcial(strNomeTabela,                                        // Nome do Arquivo
                                        cdsCtaRec.FieldByName('NRODUP').AsString,        // Duplicata
                                        cdsCtaRec.FieldByName('PARDUP').AsString,        // Parcela
                                        cdsCtaRec.FieldByName('CTR_CODEMP').AsString,    // Empresa
                                        cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,    // Espécie
                                        cdsCtaRec.FieldByName('CTR_CODCLI').AsString,    // Cliente
                                        cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,     // Valor Recebido
                                        fltValJur,                                                        // Valor do Juros
                                        cdsCtaRec.FieldByName('CTR_VALDES').AsFloat,     // Valor do Desconto
                                        cdsCtaRec.FieldByName('CTR_DTAREC').AsDateTime,  // Data do Recebimento
                                        dtaDtaVen,                                                        // Data de Vencimento
                                        IIF(intIdenti = 1, strPorBai, strPorBa2),                         // Portador de Baixa
                                        strHisBai,                                                        // Histórico de Baixa
                                        strCtaBai,                                                        // Centro de Custo da Baixa
                                        strLoginUsuarioLogado,                                            // Operador da Baixa
                                        strSeqLan,                                                        // Sequencial de Lancamento (MOVBAN)
                                        fltNovoValOri,                                                    // Novo Valor Original
                                        fltNovoValDup,                                                    // Novo Valor da Duplicata
                                        fltAuxCqP,                                                        // Valor de CHQ VISTA
                                        fltAuxCqV,                                                        // Valor de CHQ PRAZO
                                        fltAuxDin,                                                        // Valor de dinheiro
                                        fltAuxCar,                                                        // Valor de cartao
                                        fltAuxOrd,                                                        // Valor da ordem de pagamento
                                        fltAuxFin,
                                        0,                                                                // Veio do Resumo de Caixa?
                                        StrToInt(strSeqMod),
                                        blnValCqP,
                                        blnValCqV,
                                        blnValDin,
                                        blnValCar,
                                        blnValOrd,
                                        blnValFin,
                                        intSeqPar,
                                        rcxComissao.strSeqCom,
                                        rcxComissao.fltPerDes,
                                        intSeqCon);                                                       // Sequencial de Controle

              pGravaRateio(cdsRateio,
                           intSeqPar,
                           strNomeTabela,
                           FieldByName('NRODUP').AsString, FieldByName('PARDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                           fltAuxDin, fltAuxCqV, fltAuxCqP, fltAuxCar, fltAuxOrd, fltAuxFin,
                           fltValDin, fltValCqV, fltValCqP, fltValCar, fltValOrd, fltValFin);


              strDocume := FieldByName('NRODUP').AsString + '-' +
                           FieldByName('PARDUP').AsString + '-' +
                           FieldByName('CTR_ESPDOC').AsString + '-' +
                           FieldByName('CTR_CODEMP').AsString + '-' +
                           fStrZero(intSeqPar,3);

              {********************************}
              {* GRAVA LOG DO BAIXADO         *}
              {*****************************AF*}
              If Result Then
                Result := fInsereLogCtrArr(arrLogCtr,
                                           cdsCtaRec.FieldByName('NRODUP').AsString,
                                           cdsCtaRec.FieldByName('PARDUP').AsString,

                                           fRetSeqBaiCadRec(strNomeTabela,
                                                            cdsCtaRec.FieldByName('NRODUP').AsString,
                                                            cdsCtaRec.FieldByName('PARDUP').AsString,
                                                            cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                                                            cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                                            cdsCtaRec.FieldByName('CTR_CODCLI').AsString),

                                           cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODVEN').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODDIG').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODPOR').AsString,
                                           cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime,
                                           cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                           0,
                                           cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_DESCON').AsString,
                                           cdsCtaRec.FieldByName('CTR_HIST01').AsString,
                                           cdsCtaRec.FieldByName('CTR_HIST02').AsString,
                                           strHisBai,
                                           IIF(intIdenti = 1, strPorBai, strPorBa2),
                                           strCtaBai,
                                           strLoginUsuarioLogado,
                                           strSeqLan,
                                           cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_DTAREC').AsDateTime,
                                           VS_Date,
                                           cdsCtaRec.FieldByName('CTR_CODEVE').AsString,
                                           cdsCtaRec.FieldByName('CTR_CODVEL').AsString,
                                           'BAIXA PARCIAL',
                                           Self.Name,
                                           0,
                                           fltValDes,
                                           fltValJur,
                                           fltValCqP,
                                           fltValCqV,
                                           fltValDin,
                                           fltValCar,
                                           fltValOrd,
                                           fltValFin,
                                           blnValCqP,
                                           blnValCqV,
                                           blnValDin,
                                           blnValCar,
                                           blnValOrd,
                                           blnValFin,
                                           StrToInt(strSeqMod),
                                           '',
                                           '',
                                           False,
                                           '',
                                           intSeqCon,
                                           '',
                                           cdsCtaRec.FieldByName('CTR_OBSAG1').AsString,
                                           cdsCtaRec.FieldByName('CTR_OBSAG2').AsString,
                                           cdsCtaRec.FieldByName('CTR_OBSAG3').AsString,
                                           '',
                                           0,
                                           0,
                                           0,
                                           rcxComissao.strSeqCom,
                                           rcxComissao.fltPerDes);

              If (Not Result) Then
              Begin
                pBackupClientContasReceber;
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;
                FreeAndNil(rcxComissao);

                EnableControls;

                Exit;
              End;

              {********************************}
              {* GRAVA LOG DO ABERTO          *}
              {*****************************AF*}
              Result := fInsereLogCtrArr(arrLogCtr,
                                         cdsCtaRec.FieldByName('NRODUP').AsString,
                                         cdsCtaRec.FieldByName('PARDUP').AsString,
                                         0,
                                         cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                         cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                                         cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                                         cdsCtaRec.FieldByName('CTR_CODVEN').AsString,
                                         cdsCtaRec.FieldByName('CTR_CODDIG').AsString,
                                         cdsCtaRec.FieldByName('CTR_CODPOR').AsString,
                                         cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime,
                                         dtaDtaVen,
                                         fltNovoValDup,
                                         fltNovoValOri,
                                         cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat,
                                         cdsCtaRec.FieldByName('CTR_DESCON').AsString,
                                         cdsCtaRec.FieldByName('CTR_HIST01').AsString,
                                         cdsCtaRec.FieldByName('CTR_HIST02').AsString,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         cdsCtaRec.FieldByName('CTR_CODEVE').AsString,
                                         cdsCtaRec.FieldByName('CTR_CODVEL').AsString,
                                         'ALTERAÇÃO DE BAIXA',
                                         Self.Name,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         blnValCqP,
                                         blnValCqV,
                                         blnValDin,
                                         blnValCar,
                                         blnValOrd,
                                         blnValFin,
                                         0,
                                         '',
                                         '',
                                         False,
                                         '',
                                         0,
                                         '',
                                         cdsCtaRec.FieldByName('CTR_OBSAG1').AsString,
                                         cdsCtaRec.FieldByName('CTR_OBSAG2').AsString,
                                         cdsCtaRec.FieldByName('CTR_OBSAG3').AsString);

              If (Not Result) Then
              Begin
                pBackupClientContasReceber;
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;
                FreeAndNil(rcxComissao);

                EnableControls;

                Exit;
              End;

            End;

            fltAuxCqP := 0;
            fltAuxCqV := 0;
            fltAuxDin := 0;
            fltAuxCar := 0;
            fltAuxOrd := 0;
            fltAuxFin := 0;

          End;

          Next;
        End; {While Not Eof Do}

        {*******************************************}
        {* FAZ O ACERTO DO RATEIO                  *}
        {****************************************RV*}
        If (Not fAcertaRateio(cdsRateio)) Then
        Begin
          pBackupClientContasReceber;
          cdsChqPre.EmptyDataSet;
          cdsChqVis.EmptyDataSet;

          fRollback;

          EnableControls;

          Exit;
        End;

        {*******************************************}
        {* GRAVA CREDITO CLIENTE SE HOUVER         *}
        {****************************************JB*}
        cdsCtaRec.GotoBookmark(bkmPosGri);
        If fFormataFloat(fltValCre,2) > 0 Then
        Begin
          If (Not fGravaCreditoCliente(fltValCre, arrLogCtr)) Then
          Begin
            pBackupClientContasReceber;
            cdsChqPre.EmptyDataSet;
            cdsChqVis.EmptyDataSet;

            fRollback;

            EnableControls;

            Exit;
          End;
        End;

        {*******************************************}
        {* GRAVA FISICAMENTO O LOGCTR              *}
        {****************************************AF*}
        If Length(arrLogCtr) > 0 Then
          If Not fGravaLogCtr(arrLogCtr) Then
          Begin
            pBackupClientContasReceber;
            fRollback;

            EnableControls;

            Exit;
          End;

        EnableControls;
      End;

      cdsTmpRec := TUniClientDataSet.Create(Self);
      With cdsTmpRec Do
      Begin
        Data := cdsCtaRec.Data;
        Filtered := False;
        Filter := 'CTR_MARDES = ''M''';
        Filtered := True;
        IndexFieldNames := cdsCtaRec.IndexFieldNames;
        First;
      End;

      {*******************************************}
      {* REALIZA GRAVAÇÃO DO CARTÃO              *}
      {****************************************AF*}
      If (fCfgSis('USACTC', varBoolean)) And (Length(arrCartoes) > 0) Then
      Begin

        For intContador := 0 To Length(arrCartoes) -1 Do
        Begin

          fDigDuplic(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDig, False, False, False, VS_Date, False, 0, 'N', False);

          For intContCopia := 0 To 11 Do
          Begin
            arrDuplicFat[intContCopia] := arrDuplicata[intContCopia];
          End;

          fDigDuplic(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDes, False, False, False, VS_Date, False, 0, 'N', False);

          strNumDupCartao := fRetSequencialMovCar('MOVCAR');

          intContador2 := 0;
          While (intContador2 < 12)                                   And
                (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Do
          Begin

            Result := fGravaMovCar(strNumDupCartao,
                                   cdsTmpRec.FieldByName('CTR_CODCLI').AsString,
                                   arrDuplicata[intContador2].strSequen,
                                   VS_strCodEmp,
                                   arrCartoes[intContador].strCodCar,
                                   VS_Date,
                                   StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                                   arrDuplicata[intContador2].curValor,
                                   arrDuplicata[intContador2].curValor,
                                   arrCartoes[intContador].strObsCar,
                                   '',
                                   arrCartoes[intContador].strCndPag,
                                   0,
                                   0.0,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   arrCartoes[intContador].fltPerDes,
                                   arrDuplicFat[intContador2].curValor,
                                   arrDuplicFat[intContador2].curValor - arrDuplicata[intContador2].curValor,
                                   arrCartoes[intContador].strNumCcd,
                                   IIF(intQtdDup > 1,'DIVERSOS',strDocume),
                                   rcxComissao.strSeqCom,
                                   intSeqCon,
                                   VS_strCodEmp,
                                   False,
                                   '',
                                   'B');

            Inc(intContador2);

            If (Not Result) Then
            Begin
              pBackupClientContasReceber;
              fRollBack;
              SetLength(arrCartoes,0);
              FreeAndNil(cdsTmpRec);
              FreeAndNil(rcxComissao);
              Exit;
            End;

          End;

        End;

        SetLength(arrCartoes,0);
      End;
      FreeAndNil(cdsTmpRec);

      {********************************}
      {* REALIZA GRAVAÇÃO DOS CHEQUES *}
      {*****************************AF*}
      If (Not cdsChqPre.IsEmpty) Or (Not cdsChqVis.IsEmpty) Then
      Begin

        Result := fGravaCheques(rcxComissao);

        cdsChqPre.EmptyDataSet;
        cdsChqVis.EmptyDataSet;

        If (Not Result) Then
        Begin
          pBackupClientContasReceber;
          fRollBack;
          FreeAndNil(rcxComissao);
          Exit;
        End;

      End;

      Result := rcxComissao.fGravaArquivos;
      If Not Result Then
      Begin
        pBackupClientContasReceber;
        fRollBack;
        FreeAndNil(rcxComissao);
        Exit;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        Result := False;

        pBackupClientContasReceber;
        FreeAndNil(rcxComissao);

        cdsChqPre.EmptyDataSet;
        cdsChqVis.EmptyDataSet;

        fRollBack;
        pMensagensErro(E.Message, '[fBaixaDuplicatas]');
      End;

    End;

    If blnConfirma Then
      cdsCtaRec.RecNo := intRecNoCtr;

  Finally
    FreeMem(bkmPosGri);
    bkmPosGri := nil;
    FreeAndNil(rcxComissao);
    If Assigned(cdsTmpRec) Then
      FreeAndNil(cdsTmpRec);
  End;
end;

function TfrmBaixaCtaReceber.fCriaListaClientes: TStringList;
  Var
    cdsGen: TUniClientDataSet;
    strCodCli: String;
begin
  Result := TStringList.Create;
  cdsGen := TUniClientDataSet.Create(Self);

  With cdsGen Do
  Begin

    Data := cdsCtaRec.Data;
    Filtered := False;
    Filter := 'CTR_MARDES = ''M''';
    Filtered := True;
    First;

    strCodCli := '';
    While Not Eof Do
    Begin

      If Not SameText(strCodCli, FieldByName('CTR_CODCLI').AsString) then
      Begin
        strCodCli := FieldByName('CTR_CODCLI').AsString;
        Result.Add(strCodCli);
      End;
      Next;

    End;
  End;

  FreeAndNil(cdsGen);
end;

{************************************}
{* GRAVA CHEQUES CARREGADOS NA TEMP *}
{*********************************AF*}
function TfrmBaixaCtaReceber.fGravaCheques(rcxComissao: TRcxComissao): Boolean;
  Var
    strTabela: String;
Begin
  Try
    Result := True;

    strTabela := 'CADCHQ' + IIF(intCaixa = 2, 'X', '');

    With cdsChqPre Do
    Begin

      If Assigned(cdsChqPre) And (Active) And (Not IsEmpty) Then
      Begin

        First;

        While (Not Eof) Do
        Begin
          Application.ProcessMessages;

          Result := fGravaCheque(strTabela,
                                 FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 IfThen(FieldByName('CHQ_DOCUME').AsString = 'DIVERSOS', FieldByName('CHQ_DOCUME').AsString + '-PRZ', FieldByName('CHQ_DOCUME').AsString),
                                 FieldByName('CHQ_INCCTR').AsString,
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 rcxComissao.strSeqCom,
                                 intSeqCon,
                                 VS_strCodEmp,
                                 0,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString);

          Next;
        End;

      End;

    End;

   {************************************}
   {* CHEQUE A VISTA                   *}
   {*********************************AF*}
    With cdsChqVis Do
    Begin

      If Assigned(cdsChqVis) And (Active) And (Not IsEmpty) Then
      Begin

        First;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          Result := fGravaCheque(strTabela,
                                 FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 IfThen(FieldByName('CHQ_DOCUME').AsString = 'DIVERSOS', FieldByName('CHQ_DOCUME').AsString + '-AVI', FieldByName('CHQ_DOCUME').AsString),
                                 FieldByName('CHQ_INCCTR').AsString,
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 rcxComissao.strSeqCom,
                                 intSeqCon,
                                 VS_strCodEmp,
                                 0,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString);

          Next;
        End;

      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaCheques]');
      Result := False;
    End;
  End;

End;

procedure TfrmBaixaCtaReceber.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If StrToIntDef(edtQtdSelecionadas.Text,0) <= 0 Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not cdsCtaRec.IsEmpty Then
  Begin
    If fBaixaDuplicatas Then
    Begin
      If fMensagem('', 'Deseja imprimir Recibo?', ['', ''], 2) = 1 Then
      Begin
        pImprimeRecibo;
      End;
      pLimpaDados;
      edtCodCli.SetFocus;
    End;
  End;
  Self.SetFocus;
end;

procedure TfrmBaixaCtaReceber.pCalculaValorCorrigido;
  Var
    fltJuros: Double;
begin
  With cdsCtaRec Do
  Begin
    DisableControls;

    Try
      First;
      While Not Eof Do
      Begin
        fltJuros := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                        FieldByName('CTR_VALSUJ').AsFloat,
                                        FieldByName('CTR_TAXJUR').AsFloat);
        Edit;
        FieldByName('CTR_VALCAL').AsFloat := fltJuros + FieldByName('CTR_VALSUJ').AsFloat;
        FieldByName('CTR_VALJUR').AsFloat := fltJuros;
        Post;
        Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pCalculaValorCorrigido]');
    End;

    First;
    EnableControls;
  End;
end;

procedure TfrmBaixaCtaReceber.pCalculaTotalDuplicatas(edtDesconto, edtJuros, edtTotal, edtQuant: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldDes: TAggregateField;
    fldJur: TAggregateField;
    fldTot: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldTot := fCriaAggregateField(cdsGen, 'FLDTOT', 'SUM(CTR_' + IIF(blnFiltrar, 'VALREC', 'VALCAL') + ')', '#,##0.00');

  If blnFiltrar Then
  Begin
    fldDes := fCriaAggregateField(cdsGen, 'FLDDES', 'SUM(CTR_VALDES)', '#,##0.00');
    fldJur := fCriaAggregateField(cdsGen, 'FLDJUR', 'SUM(CTR_VALJUR)', '#,##0.00');
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;

    If blnFiltrar Then
    Begin
      Filtered := False;
      Filter := 'CTR_MARDES = ''M''';
      Filtered := True;
    End;

    AggregatesActive := True;

    If blnFiltrar Then
    Begin
      edtDesconto.Text := FormatFloat('#,##0.00', IIF(fldDes.Value = Null, 0, fldDes.Value));
      edtJuros.Text    := FormatFloat('#,##0.00', IIF(fldJur.Value = Null, 0, fldJur.Value));
    End;

    edtTotal.Text    := FormatFloat('#,##0.00', IIF(fldTot.Value = Null, 0, fldTot.Value));
    edtQuant.Text    := IntToStr(RecordCount);
  End;

  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCtaReceber.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaReceber.dbgDuplicatasDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmBaixaCtaReceber.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If cdsCtaRec.IsEmpty Then
    Exit;

  Try
    pCriarFormularios(TfrmBaixaBusca, frmBaixaBusca);
    frmBaixaBusca.ShowModal;

    If (Not fEmptyStr(frmBaixaBusca.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBaixaBusca.strValorFiltro;
      strCampoFiltro := frmBaixaBusca.strCampoFiltro;
      cdsCtaRec.FindFirst;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmBaixaCtaReceber.dbgDuplicatasDblClick]');
  End;
  pFreeAndNil(frmBaixaBusca);
end;

procedure TfrmBaixaCtaReceber.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmBaixaCtaReceber.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If (Not cdsCtaRec.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
    cdsCtaRec.FindNext;
end;

procedure TfrmBaixaCtaReceber.pImprimeRecibo;
  Var
    strSQL: String;
    intCont: Integer;
    cdsRelCtr: TUniClientDataSet;
    stlClientes: TStringList;
Begin
  pCarregaConfImpr(qryCfgRel, Self.Name);
  fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

  Try
    stlClientes := fCriaListaClientes;
    cdsRelCtr   := fCriaClientRecibo;
    pCriarFormularios(TfrmQckReciboCtaReceber, frmQckReciboCtaReceber);

    For intCont := 0 To stlClientes.Count -1 Do
    Begin
      cdsRelCtr.Filtered := False;
      cdsRelCtr.Filter := 'CODCLI = ' + QuotedStr(stlClientes[intCont]);
      cdsRelCtr.Filtered := True;

      frmQckReciboCtaReceber.pImprimeRecibo(False,
                                            VS_blnDlgPri,
                                            strTipImp,
                                            strNomFil,
                                            IntToStr(intSeqCon),
                                            cdsRelCtr,
                                            fCfgSis('CTRVIA', varInteger));
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pImprimeRecibo]');
  End;

  pDestroiModulo(frmQckReciboCtaReceber);
  FreeAndNil(stlClientes);
  FreeAndNil(cdsRelCtr);
End;

{******************************************}
{* RETORNA A QUANTIDADE DE DUPLICATAS SE- *}
{* LECIONADAS DISCRIMINADAS EM CAIXA 1 E 2*}
{***************************************MV*}
procedure TfrmBaixaCtaReceber.pRetDupSelecionadas(var intDupCx1,
  intDupCx2: Integer; Var fltTotCx1, fltTotCx2: Double);
  Const
    strFiltro = 'CTR_MARDES = ''M'' AND CTR_IDENTI = ';
  Var
    cdsGen: TUniClientDataSet;
    fldTot: TAggregateField;
begin
  intDupCx1 := 0;
  intDupCx2 := 0;

  fltTotCx1 := 0.0;
  fltTotCx2 := 0.0;

  Try
    cdsGen := TUniClientDataSet.Create(Self);
    fldTot := fCriaAggregateField(cdsGen, 'FLDTOT', 'SUM(CTR_VALREC)', '#,##0.00');

    With cdsGen Do
    Begin
      Data := cdsCtaRec.Data;

      {*********************************************************}
      {* CARREGANDO A QTD DE REGISTRO E VALOR TOTAL DO CAIXA 1 *}
      {******************************************************AN*}
      Filtered := False;
      Filter := strFiltro + '1';
      Filtered := True;

      AggregatesActive := True;
      intDupCx1 := RecordCount;
      fltTotCx1 := IIF(fldTot.Value = Null, 0, fldTot.Value);
      AggregatesActive := False;

      {*********************************************************}
      {* CARREGANDO A QTD DE REGISTRO E VALOR TOTAL DO CAIXA 2 *}
      {******************************************************AN*}
      Filtered := False;
      Filter := strFiltro + '2';
      Filtered := True;

      AggregatesActive := True;
      intDupCx2 := RecordCount;
      fltTotCx2 := IIF(fldTot.Value = Null, 0, fldTot.Value);
      AggregatesActive := False;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pRetDupSelecionadas]');
  End;
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCtaReceber.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaReceber.pCarregaEvento;
begin
  If Not fEmptyStr(edtCodEve.Text) Then
    edtDesEve.Text := fRetNomEvento(edtCodEve.Text)
  Else
    edtDesEve.Clear;
end;

procedure TfrmBaixaCtaReceber.btnRecalculaJurosClick(Sender: TObject);
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
    pRecalculaJuros;
end;

procedure TfrmBaixaCtaReceber.pRecalculaJuros;
  Var
    blnConfirma: Boolean;
    strAplJur: String;
    fltPerJur: Double;
begin
  Screen.Cursor := crHourGlass;

  {***********************************************}
  {* CHAMANDO A TELA PARA CONFIGURACAO DOS JUROS *}
  {********************************************AN*}
  Try
    pCriarFormularios(TfrmCtrRecalculoJuros, frmCtrRecalculoJuros);
    frmCtrRecalculoJuros.ShowModal;
    blnConfirma :=  frmCtrRecalculoJuros.blnConfirma;

    If blnConfirma Then
    Begin
      fltPerJur := fStrToFloat(frmCtrRecalculoJuros.edtPerJur.Text);
      strAplJur := frmCtrRecalculoJuros.edtAplJur.Text;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmBaixaCtaReceber.pRecalculaJuros]');
    End;
  End;
  pFreeAndNil(frmCtrRecalculoJuros);

  {*******************************}
  {* SE CONFIRMOU ENTAO CONTINUA *}
  {****************************AN*}
  If (blnConfirma) Then
  Begin
    If (strAplJur = 'T') And (fStrToFloat(edtTotalRecebido.Text) > 0) Then
    Begin
      fMensagem('', 'Para efetuar o recalculo do juros, nenhuma duplicata pode estar selecionada!', ['&Ok']);
      Screen.Cursor := crDefault;
      Exit;
    End
    Else If (strAplJur = 'D') And (cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M') Then
    Begin
      fMensagem('', 'Para efetuar o recalculo do juros a duplicata não pode estar selecionada!', ['&Ok']);
      Screen.Cursor := crDefault;
      Exit;
    End;

    Try
      pCalculaJuros(fltPerJur, strAplJur);

      pCalculaTotalDuplicatas(nil, nil, edtValorTotal, edtQtdDuplicatas, False);
      pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pRecalculaJuros]');
    End;
  End;

  Screen.Cursor := crDefault;
end;

procedure TfrmBaixaCtaReceber.pCalculaJuros(fltPerJur: Double; strAplJur: String);
  Var
    fltJuros: Double;
    intRecNo: Integer;
    strIndexFieldNames: String;
begin
  With cdsCtaRec Do
  Begin
    DisableControls;

    If strAplJur = 'T' Then
    Begin
      intRecNo := RecNo;
      strIndexFieldNames := IndexFieldNames;
      IndexFieldNames := 'CTR_NOMCLI;CTR_DTAVEN';
      First;
    End;

    Try
      While Not Eof Do
      Begin
        {***************************************}
        {* CALCULA JUROS PARA O REGISTRO ATUAL *}
        {************************************AN*}
        fltJuros := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                        FieldByName('CTR_VALSUJ').AsFloat,
                                        fltPerJur);

        {********************************}
        {* ATUALIZANDO O REGISTRO ATUAL *}
        {*****************************AN*}
        Edit;
        FieldByName('CTR_TAXJUR').AsFloat := fltPerJur;
        FieldByName('CTR_VALJUR').AsFloat := fltJuros;
        FieldByName('CTR_VALCAL').AsFloat := fltJuros + FieldByName('CTR_VALSUJ').AsFloat;
        Post;

        {**************************************************}
        {* SE FOR CALCULO DE JUROS PARA A DUPLICATA ATUAL *}
        {* ENTAO PARA A EXECUCAO DO WHILE                 *}
        {***********************************************AN*}
        If strAplJur = 'D' Then
          Break;

        Application.ProcessMessages;
        Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmBaixaCtaReceber.pCalculaJuros]');
    End;

    If strAplJur = 'T' Then
    Begin
      IndexFieldNames := strIndexFieldNames;
      RecNo := intRecNo;
    End;

    EnableControls;
  End;
end;

procedure TfrmBaixaCtaReceber.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaReceber.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmBaixaCtaReceber.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPortador.Text);
  With qryConPor Do
  Begin
    edtDesPortador.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaCtaReceber.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqPortador(conSimples,
                   Self,
                   edtCodPortador,
                   edtDesPortador,
                   nil,
                   Key,
                   arrSel)  then
  Begin
    If (fValidaCampos(edtCodPortador)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaReceber.FormShow(Sender: TObject);
begin
  inherited;
  fltJur := -1;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
end;

procedure TfrmBaixaCtaReceber.BtnSelecionadasClick(Sender: TObject);
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
    frmConsDuplicSelec.pMostraDuplicatasSelecionadas('CADREC', cdsCtaRec);
end;

procedure TfrmBaixaCtaReceber.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
    pSelecionaTodas(TBitBtn(Sender).Name = 'btnMarcarTodas');
end;

function TfrmBaixaCtaReceber.fGravaCreditoCliente(fltValCre: Double; Var arrLogCtr: TRegistroLogCtr): Boolean;
  Var
    strNumDup  : String;
    strPortador: String;
begin

  Try

    strPortador := fRetornaPortadorCliente(cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

    If fEmptyStr(strPortador) Then
      strPortador := strPorBai;

    If fEmptyStr(strPortador) Then
      strPortador := strPorBa2;

    strNumDup := fRetSequencial('PROCCO');
    {*******************************************}
    {* GRAVA CADREC                            *}
    {****************************************AF*}
    Result := fGravaCadRec(strNomeTabela,
                           strNumDup,                                                          // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'CC',                                                               // Espécie
                           cdsCtaRec.FieldByName('CTR_CODCLI').AsString,      // Cliente
                           VS_strCodEmp,                                                       // Empresa
                           cdsCtaRec.FieldByName('CTR_CODVEN').AsString,      // Vendedor
                           cdsCtaRec.FieldByName('CTR_CODDIG').AsString,      // Digitador
                           strPortador,                                                        // Portador
                           VS_Date,                                                            // Data de Cadastro
                           VS_Date,                                                            // Data de Vencimento
                           -fltValCre,                                                         // Valor da Duplicata
                           -fltValCre,                                                         // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           'REF. LANC. CREDITO',                                               // Histórico 1
                           '',                                                                 // Histórico 2
                           '',                                                                 // Portador da Baixa
                           '',                                                                 // Centro de Custo da Baixa
                           '',                                                                 // Operador da Baixa
                           '',                                                                 // Documento da Baixa
                           0.0,                                                                // Valor do Recebimento
                           0,                                                                  // Data do Recebimento
                           '',                                                                 // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           '',                                                                 // Codigo do Centro de Custo
                           0,
                           '',                                                                 // Observação de Agrupamento 1
                           '',                                                                 // Observação de Agrupamento 2
                           '');                                                                // Observação de Agrupamento 3

    If (Not Result) Then
      Exit;

    {********************************}
    {* GRAVA LOG DO CADREC          *}
    {*****************************AF*}
    Result := fInsereLogCtrArr(arrLogCtr,
                               strNumDup,
                               'A',
                               0,
                               'CC',
                               cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                               VS_strCodEmp,
                               cdsCtaRec.FieldByName('CTR_CODVEN').AsString,
                               cdsCtaRec.FieldByName('CTR_CODDIG').AsString,
                               strPorBai,
                               VS_Date,
                               VS_Date,
                               -fltValCre,
                               -fltValCre,
                               0,
                               'N',
                               'REF. LANC. CREDITO',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               0,
                               0,
                               '',
                               '',
                               'INCLUSÃO',
                               Self.Name,
                               1,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               False,
                               False,
                               True,
                               False,
                               False,
                               False,
                               0,
                               '',
                               '',
                               False,
                               '',
                               0,
                               '',
                               '',
                               '',
                               '');

    {***********************}
    { GRAVA MOVBAN          }
    {********************JB*}
    If intIdenti = 1 Then
      intDCrRec := intDCrRecPor1
    Else
      intDCrRec := intDcrRecPor2;

    fGravaMovBan(strTabelaMovBan,
                 strCtaBai,                                                                   // Centro de Custo
                 IIF(intIdenti = 1, strPorBai, strPorBa2),                                    // Portador da Baixa
                 strLoginUsuarioLogado,                                                       // Operador da Baixa
                 IIF(fEmptyStr(strDtaLan), VS_Date, StrToDateDef(strDtaLan, 0)) + intDCrRec,  // Data do Lançamento
                 Time(),                                                                      // Hora do Lançamento
                 cdsCtaRec.FieldByName('CTR_NUMDUP').AsString,               // Numero do Documento
                 'C',                                                                         // Credito / Debito
                 VS_strCodEmp,                                                                // Empresa da Baixa
                 fltValCre,                                                                   // Valor Do Lançamento
                 'REF. LANC. CREDITO',                                                        // Histórico 1
                 '',                                                                          // Histórico 2
                 cdsCtaRec.FieldByName('CTR_CODCLI').AsString,               // Cliente da Duplicata
                 '',                                                                          // Fornecedor da Duplicata
                 cdsCtaRec.FieldByName('NRODUP').AsString,                   // Número da Duplicata
                 0,                                                                           // Sequencial de Baixa
                 cdsCtaRec.FieldByName('PARDUP').AsString,                   // Parcela da Duplicata
                 cdsCtaRec.FieldByName('CTR_CODEMP').AsString,               // Empresa da Duplicata
                 '',                                                                          // Série
                 cdsCtaRec.FieldByName('CTR_CODEVE').AsString,               // Codigo do Evento
                 '');


  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCtaReceber - fGravaCreditoCliente]');
      Result := False;
    End;
  End;

end;

procedure TfrmBaixaCtaReceber.pMostraObsCliente;
begin
  If fEmptyStr(edtCodCli.Text) Or (Not qryConCli.Active) Then
    Exit;

  {*****************************************}
  {* SE ESTIVER TUDO EM BRANCO, SAI        *}
  {**************************************MV*}
  If (fEmptyStr(qryConCli.FieldByName('CLI_OBSERV').AsString)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.memObserv.Text := qryConCli.FieldByName('CLI_OBSERV').AsString;
    frmFatMostraObsCliente.strCodCli := qryConCli.FieldByName('CLI_CODCLI').AsString;
    frmFatMostraObsCliente.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraObsCliente]');
  End;

  pFreeAndNil(frmFatMostraObsCliente);
end;

end.


