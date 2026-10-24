unit untRelCtrReceber;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, RLRichFilter, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  ComObj, AppEvnts, UniDataSetProvider, UniClientDataSet, Windows, DB,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, Math, untClassPanelCx,
  Datasnap.DBClient,untFuncoesConsulta,untFuncoesSimples, untConsultas;

type
  TfrmRelCtrReceber = class(TfrmPaiRelatorio)
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    Label12: TLabel;
    edtCodCli: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    Label5: TLabel;

    gpbTitulos: TGroupBox;
    edtTitulos: TEditFocus;
    ColorLabel2: TColorLabel;
    edtDesCli: TEditFocus;
    edtDesPor: TEditFocus;
    edtDesEmp: TEditFocus;
    Label1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    gpbTipoData: TGroupBox;
    ColorLabel3: TColorLabel;
    edtTipoDta: TEditFocus;
    gbpDupDesc: TGroupBox;
    ColorLabel4: TColorLabel;
    edtDupDesc: TEditFocus;
    Label2: TLabel;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    gpbOrdem: TGroupBox;
    ColorLabel5: TColorLabel;
    edtOrdem: TEditFocus;
    lblVenDig: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    svdExcel: TSaveDialog;
    lblOrdCli: TColorLabel;
    edtOrdemCli: TEditFocus;
    frxRelatorioM: TfrxReport;
    lblEspDoc: TLabel;
    chkDiaCre: TCheckBox;
    chkAjuDta: TCheckBox;
    gpbTipCliente: TGroupBox;
    ColorLabel7: TColorLabel;
    edtTipCliente: TEditFocus;
    chkImpRes : TCheckBox;
    edtPorCli: TEditFocus;
    edtDesPorCli: TEditFocus;
    rdgPortador: TRadioGroup;
    rdgStatus: TRadioGroup;
    gpbImp: TGroupBox;
    chkImpAdc: TCheckBox;
    chkImpEnd: TCheckBox;
    chkNossNum: TCheckBox;
    chkMeiaFolha: TCheckBox;
    rdgEmpresa: TRadioGroup;
    edtPorBai: TEditFocus;
    edtDesPorBai: TEditFocus;
    Label4: TLabel;
    gpbNome: TGroupBox;
    lblNome: TColorLabel;
    edtNome: TEditFocus;
    chkResumoSint: TCheckBox;
    cdsResumoSint: TUniClientDataSet;
    cdsResumoSintCODCLI: TStringField;
    cdsResumoSintNOMCLI: TStringField;
    cdsResumoSintFONE01: TStringField;
    cdsResumoSintVALDUP: TFloatField;
    cdsResumoSintVLRCOR: TFloatField;
    frxDBResumo: TfrxDBDataset;
    Label7: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    Label8: TLabel;
    mskCadIni: TMaskEditFocus;
    Label9: TLabel;
    mskCadFin: TMaskEditFocus;
    Label10: TLabel;
    LblCadIni: TLabel;
    chkValCor: TCheckBox;
    gpbValor: TGroupBox;
    lblValor: TColorLabel;
    edtValor: TEditFocus;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    cdsResumoSintCODCND: TStringField;
    gpbHistorico: TGroupBox;
    ColorLabel6: TColorLabel;
    edtHistorico: TEditFocus;
    chkProfis: TCheckBox;
    frxRelatorioJ: TfrxReport;
    chkHisCob: TCheckBox;
    mskEspecie: TMaskEditFocus;
    chkNovaPaginaQuebra: TCheckBox;
    procedure edtTitulosExit(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaPortador(Var qryCadPor: TUniQuery);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEventos(Var qryCadEve: TUniQuery);
    procedure edtTipoDtaExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    function frxRelatorioMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure chkMeiaFolhaClick(Sender: TObject);
    procedure edtPorCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure chkNossNumClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtPorCliExit(Sender: TObject);
    procedure edtPorBaiExit(Sender: TObject);
    procedure edtOrdemCliChange(Sender: TObject);
  private
    strLinCli: String;
    strLinPor: String;
    strPorCli: String;
    strPorBai: String;
    strLinEve: String;
    strLinEmp: String;
    strLinCid: String;
    strLinVen: String;
    strRegiao: String;
    strLinRed: String;
    strConPag: String;
    strAceCtr: String;
    intIndRel: Smallint;

    fltTotVen: Double;
    fltTotAve: Double;
    fltTotRec: Double;

    qryRelatorio: TUniQuery;

    qryTemp  : TUniQuery;

    blnDescFinanSomenteAteVenc : boolean;

    function fGetVal001: Double;
    function fGetVal002: Double;
    function fGetVal003: Double;

    {****************************************************}
    {* PROCEDURES PARA ALIMENTAR AS VARIAVEIS DO RESUMO *}
    {* RQ 32348 **************************************BB*}
    procedure pSetTotAve(fltValue : Double);
    procedure pSetTotVen(fltValue : Double);
    procedure pSetTotRec(fltValue : Double);
    procedure pZeraTotais;

    procedure pSetaFiltros(Var strSQL: String);
    procedure pSetaParametros(Var qryGen: TUniQuery);
    procedure pSetaOrdem(Var cdsAux: TUniClientDataSet);

    procedure pMontaResumo(Var frxRel: TfrxReport);
    procedure pAjustaData;
    procedure pGeraExcel;

    procedure pCriaQryRelatorio;

    function fFormataFonePaisInterna(strTelefo: String): String;
    function fRetObsCobranca(strCodCli, strCliObs: String): String;
    function fRetObsCobCliente(strCodCli: String): String;
    function fColValorBruto(var intCol: Integer): Boolean;
    procedure pControlaCheckBox(strOrdemCli: string; blnResult: boolean = True);
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }
    arrLinPor: TConsultasArray;
    arrLinCli: TConsultasArray;
    arrLinEve: TConsultasArray;
    arrLinEmp: TConsultasArray;
    arrLinCid: TConsultasArray;
    arrLinVen: TConsultasArray;
    arrPorCli: TConsultasArray;
    arrPorBai: TConsultasArray;
    arrRegiao: TConsultasArray;
    arrRede  : TConsultasArray;
    arrCndPag: TConsultasArray;

    blnMostraVlrBru : Boolean;

    dspRelatorio: TUniDataSetProvider;
    cdsRelatorio: TUniClientDataSet;
  end;

var
  frmRelCtrReceber: TfrmRelCtrReceber;

implementation

uses untFuncoesGenerica, untExcel, untIFuncoes;

{$R *.dfm}

procedure TfrmRelCtrReceber.edtTitulosExit(Sender: TObject);
begin
  inherited;

  If edtTitulos.Text = 'Q' Then
  Begin
    lblDtaIni.Caption := '(RECEBIMENTO)';
    lblDtaFin.Caption := '(RECEBIMENTO)';
    gpbTipoData.Enabled   := False;
    chkResumoSint.Checked := False;
    chkResumoSint.Visible := False;
  End
  Else
  Begin
    lblDtaIni.Caption := '(VENCIMENTO)';
    lblDtaFin.Caption := '(VENCIMENTO)';
    gpbTipoData.Enabled := True;

    If edtTitulos.Text = 'A' Then
         chkResumoSint.Visible := True
    Else
    Begin
      chkResumoSint.Checked := False;
      chkResumoSint.Visible := False;
    End;
  End;

  If edtTitulos.Text = 'A' Then
  Begin
    gpbValor.Enabled := True;
    edtValor.Enabled := True;
    edtValor.Text    := 'T';
    lblValor.Enabled := True;
  End;{
  Else
  Begin
    gpbValor.Enabled := False;
    edtValor.Enabled := False;
    edtValor.Text    := 'T';
    lblValor.Enabled := False;
  End;}

  if not chkResumoSint.Visible then
     chkNovaPaginaQuebra.Top :=  chkResumoSint.Top
  else
     chkNovaPaginaQuebra.Top := 312;
end;

procedure TfrmRelCtrReceber.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If Not edtCodCli.ReadOnly Then
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrLinCli, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodPor);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;

end;

procedure TfrmRelCtrReceber.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrLinCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd,edtDesCnd,arrCndPag,fRetDesConPag,Nil,'da Condição de Pagamento');
end;

procedure TfrmRelCtrReceber.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not fCfgSis('USACND', varBoolean) Then
    Exit;

  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCndPag, False) Then
  Begin
    If fValidaCampos(edtCodCnd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCli.Text)) Then
    edtDesCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCli.Text := '';
End;

procedure TfrmRelCtrReceber.edtCodPorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodPor,edtDespor, arrLinPor, Nil,fRetNomPortador, 'do portador da duplicata');
end;

procedure TfrmRelCtrReceber.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrLinPor, False) Then  
  Begin
    If fValidaCampos(edtCodPor,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelCtrReceber.edtCodRedeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrRegiao, fRetDesReg, Nil, 'da Região');
end;

procedure TfrmRelCtrReceber.edtCodRegKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.pCarregaPortador(Var qryCadPor: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString
  Else
    edtDesPor.Text := '';
End;

procedure TfrmRelCtrReceber.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

function TfrmRelCtrReceber.fRetObsCobranca(strCodCli, strCliObs: String): String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' REPLACE (COB_HISCOB, "<<csq>>", " ") AS COB_HISCOB, ';
  strSQL := strSQL + '  COB_DTALAN, ';
  strSQL := strSQL + '  COB_HORLAN, ';
  strSQL := strSQL + '  COB_DTAAGE  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCOB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COB_CODCLI = :CODCLI ';
  strSQL := strSQL + '  AND COB_BAIXAD <> "S" ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  COB_DTALAN, COB_HORLAN  ';

  if not Assigned(qryTemp) Then
    qryTemp := fCriaQuery(Self);
  With qryTemp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString   := strCodCli;
    Open;
    First;
    Result := '';
    while Not qryTemp.Eof do
    Begin
      if Result = '' then
        Result := FieldByName('COB_HISCOB').AsString
      else
        //Result := Result + #13#10 + FieldByName('COB_HISCOB').AsString;
        Result := Result + ' ' + FieldByName('COB_HISCOB').AsString;
      qryTemp.Next;
    End;
  End;

  if Assigned(qryTemp) Then
    FreeAndNil(qryTemp);

end;

function TfrmRelCtrReceber.fRetObsCobCliente(strCodCli: String): String;
begin
  Result := '';
  Try

    If chkHisCob.Checked Then
      Result := fRetObsCobranca(strCodCli, '');

  Except
    Result:= '';
    pMensagensErro('Falha ao tentar retornar obs de cobrança, código do cliente: '+ strCodCli, 'untRelCtrReceber');
    Exit;
  End;
end;


procedure TfrmRelCtrReceber.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrLinEmp, fRetNomeEmpresa, Nil, 'da empresa');

end;

procedure TfrmRelCtrReceber.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrLinEmp, False, True, '', True, strAceCtr) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelCtrReceber.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
 begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {***************LU,BB*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If (Sender = mskDtaIni) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          If StrToDateDef(mskDtaIni.Text, 0) <= 0 Then
          Begin
            fMensagem('', 'Data Inicial ' + fTiraCaracEspeciais(lblDtaIni.Caption) + ' informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = mskDtaFin) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
              fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
              Result := False;
              If (Sender = mskDtaFin) Then
                Sender := mskDtaIni;
          End
          Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End
          Else If StrToDateDef(mskDtaFin.Text, 0) <= 0 Then
          Begin
            fMensagem('', 'Data Final  ' + fTiraCaracEspeciais(lblDtaIni.Caption) + '  informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End;
        End
      End;
    End
    Else If (Sender = mskCadIni) Or (Sender = mskCadFin) Then
    Begin
      If (Sender = mskCadIni) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
        Begin
          If StrToDateDef(mskCadIni.Text, 0) <= 0 Then
          Begin
            fMensagem('', 'Data Inicial  ' + fTiraCaracEspeciais(lblCadIni.Caption) + '  informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = mskCadFin) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
          Begin
              fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
              Result := False;
              If (Sender = mskCadFin) Then
                Sender := mskCadIni;
          End
          Else If StrToDate(mskCadIni.Text) > StrToDate(mskCadFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End
          Else If StrToDateDef(mskCadFin.Text, 0) <= 0 Then
          Begin
            fMensagem('', 'Data Final  ' + fTiraCaracEspeciais(lblCadIni.Caption) + '  informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End;
        End
        Else If fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) And
        fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))  Then
        Begin
          Sender := mskDtaIni;
          fMensagem('','É Necessário informar pelo menos uma data.',['&O K']);
          Result := False;
        End;
      End;
    End

    {*****************}
    {* VALIDA TITULO *}
    {**************AF*}
    Else If (Sender = edtTitulos) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
      Begin
        If StrToDateDef(mskCadIni.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data Inicial Vencimento informada é invalida! Necessário correção.', ['&O k']);
          Result := False;
        End;
      
        If (Sender = mskCadFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else If StrToDate(mskCadIni.Text) > StrToDate(mskCadFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End
          Else If StrToDateDef(mskCadFin.Text, 0) <= 0 Then
          Begin
            fMensagem('', 'Data Final Vencimento informada é invalida! Necessário correção.', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End;

    {*****************}
    {* VALIDA TITULO *}
    {**************AF*}
    If (Sender = edtTitulos) Then
    Begin
      If edtTitulos.Text = '' Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Titulos deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If (edtTitulos.Text <> 'T') And (edtTitulos.Text <> 'Q') And (edtTitulos.Text <> 'A') Then
      Begin
        fMensagem('ATENÇÃO!','Valor invalido no campo Titulos!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtTipoDta) Then
    Begin

      If fEmptyStr(edtTipoDta.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo tipo de data deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtTipoDta.Text <> 'V') And (edtTipoDta.Text <> 'C') Then
      Begin
        fMensagem('ATENÇÃO','O campo tipo de data deve conter somente V ou C!',['&O K']);
        Result := False;
      End;

    End

    {**************************}
    {* VALIDA ORDENAR POR     *}
    {***********************JB*}
    Else If (Sender = edtOrdem) Then
    Begin

      If fEmptyStr(edtOrdem.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Ordenar deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Not (Pos(edtOrdem.Text, 'D_V_') > 0) Then
      Begin
        fMensagem('ATENÇÃO','O campo tipo de data deve conter somente D ou V!',['&O K']);
        Result := False;
      End;

    End
    Else If (Sender = edtNome) Then
    Begin

      If fEmptyStr(edtNome.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Exibir deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Not (Pos(edtNome.Text, 'R_N_') > 0) Then
      Begin
        fMensagem('ATENÇÃO','O campo Exibir deve conter somente R ou N!',['&O K']);
        Result := False;
      End;

    End
    Else If (Sender = edtTipCliente) Then
    Begin

      If fEmptyStr(edtTipCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Tipo de Pessoa Cliente deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else If (Pos(edtTipCliente.Text, 'FJT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Tipo de Pessoa Cliente deve conter somente F,J ou T!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtOrdemCli) Then
    Begin

      If fEmptyStr(edtOrdemCli.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Ordenar (Cod Cliente / Nome Cliente) deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If fCfgSis('USACND', varBoolean) Then
        Begin
          If (Pos(edtOrdemCli.Text, 'CNP') <= 0) Then
          Begin
            fMensagem('ATENÇÃO','O campo (Código do Cliente / Nome do Cliente / Condição de Pagamento) deve conter somente C, N ou P!',['&O K']);
            Result := False;
          End;
        End
        Else
        Begin
          If (Pos(edtOrdemCli.Text, 'CN') <= 0) Then
          Begin
            fMensagem('ATENÇÃO','O campo (Código do Cliente / Nome do Cliente) deve conter somente C ou N!',['&O K']);
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = edtValor) Then
    Begin

      If (Pos(edtValor.Text, 'PNT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO','O campo Valor das Duplicatas deve conter somente P, N ou T!',['&O K']);
        Result := False;
      End;

    End
    Else If (Sender = edtDupDesc) Then
    Begin

      If fEmptyStr(edtDupDesc.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Duplicata Descontada deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtDupDesc.Text <> 'S') And (edtDupDesc.Text <> 'N') And (edtDupDesc.Text <> 'T') Then
      Begin
        fMensagem('ATENÇÃO','O campo Duplicata Descontada deve conter somente T, S ou N!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp, arrLinEmp);

      If Not fEmptyStr(edtCodEmp.Text) And (edtCodEmp.Text <> '000') Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          //Verifica se possui acesso na Baixa de Contas a Receber
          If (Pos(edtCodEmp.Text, strAceCtr) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtHistorico) And (edtHistorico.Enabled) Then
    Begin
      If fEmptyStr(edtHistorico.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Histórico deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtHistorico.Text, 'T_L_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Histórico deve ser T ou L!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin

        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
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

    Else If Sender = edtPorBai Then
    Begin
      If Not fEmptyStr(edtPorBai.Text) And (edtPorBai.Text <> '00000') Then
      Begin

        edtDesPorBai.Text := fRetNomPortador(edtPorBai.Text);

        If fEmptyStr(edtDesPorBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If Sender = edtPorCli Then
    Begin
      If Not fEmptyStr(edtPorCli.Text) And (edtPorCli.Text <> '00000') Then
      Begin

        edtDesPorCli.Text := fRetNomPortador(edtPorCli.Text);

        If fEmptyStr(edtDesPorCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorCli.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End;

    If (Result) Then
      pControlaCheckBox(edtOrdemCli.Text, Result);

  End;

  If Not Result Then
    pSetFocus(Sender);


end;

procedure TfrmRelCtrReceber.pControlaCheckBox(strOrdemCli: string; blnResult: boolean = True);
begin
  {***************************************************}
  {* VALIDA/CONTROLA CHECKBOX INDEPENDENDO DO SENDER *}
  {************************************************BB*}
  If (blnResult) And (strOrdemCli = 'P') Then
  Begin
    If (chkImpEnd.Checked) Then
      chkImpEnd.Checked := False;

    If (chkImpAdc.Checked) Then
      chkImpAdc.Checked := False;

    If (chkHisCob.Checked) Then
      chkHisCob.Checked := False;

    If (chkNossNum.Checked) Then
      chkNossNum.Checked := False;

    chkImpEnd.Enabled := False;
    chkImpAdc.Enabled := False;
    chkHisCob.Enabled := False;
    chkNossNum.Enabled := False;
  End
  Else
  Begin
    chkImpEnd.Enabled := True;

    If Not(chkMeiaFolha.Checked) then
    Begin
      chkNossNum.Enabled := True;
      chkImpAdc.Enabled := True;
      chkHisCob.Enabled := True;
      chkImpRes.Enabled := True;
      chkDiaCre.Enabled := True;
    End;
  End;

  If (blnResult) And (chkMeiaFolha.Checked) Then
  Begin
    chkDiaCre.Checked := False;
    chkDiaCre.Enabled := False;

    If edtOrdemCli.Text <> 'P' Then
    Begin
      chkImpRes.Checked := False;
      chkImpRes.Enabled := False;
      chkDiaCre.Enabled := True;
    End;
  End;
  
end;

procedure TfrmRelCtrReceber.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    frxRel: TfrxReport;
    intCor: Integer;

    function getSQLHis : String;
      Var
        strSQL: String;
    begin
      strSQL := strSQL + '   ( ';
      strSQL := strSQL + '      SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '        COB_HISCOB ';
      strSQL := strSQL + '      FROM ';
      strSQL := strSQL + '        CADCOB ';
      strSQL := strSQL + '      WHERE ';
      strSQL := strSQL + '        COB_CODCLI = CTR_CODCLI    ';
      strSQL := strSQL + '        AND COB_CODEMP = CTR_CODEMP ';
      strSQL := strSQL + '      ORDER BY ';
      strSQL := strSQL + '        COB_DTALAN DESC, COB_HORLAN DESC ';
      strSQL := strSQL + '      LIMIT 1 ';
      strSQL := strSQL + '   ) ';

      Result := strSQL;

    End;

begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  intCor := StrToIntDef(fCfgSis('CORZEB'), clWhite);

  If SameText(edtDestino.Text, 'E') Then
  Begin
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;
  End
  Else
    inherited;

  If blnImprime Then
  Begin
    Application.ProcessMessages;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    If chkDiaCre.Checked Then
      strSQL := strSQL + '  CAST(DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY) AS DATETIME) AS CTR_DTAVEN, '
    Else
      strSQL := strSQL + '  R.CTR_DTAVEN, ';

    strSQL := strSQL + '  R.CTR_DTACAD, ';

    strSQL := strSQL + IfThen( rdgEmpresa.ItemIndex = 0, '  R.CTR_CODEMP, ',
                       ' IF(R.CTR_EMP_PD <> "", R.CTR_EMP_PD, R.CTR_CODEMP) AS CTR_CODEMP, ');

    strSQL := strSQL + '  R.CTR_CODVEN, ';
    strSQL := strSQL + '  R.CTR_DTAREC, ';
    strSQL := strSQL + '  R.CTR_CODCLI, ';

    If blnDescFinanSomenteAteVenc Then
      strSQL := strSQL + ' IF((R.CTR_DTAVEN < CURDATE()), ' +
        ' (R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - 0), ' +
        ' (R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0))) '+
        '  AS CTR_VALDUP, '
    else
      strSQL := strSQL + '  (R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0)) AS CTR_VALDUP, ';

    strSQL := strSQL + '  R.CTR_VALREC, ';
    strSQL := strSQL + '  R.CTR_VALORI, ';
    strSQL := strSQL + '  R.CTR_VALJUR, ';
    strSQL := strSQL + '  R.CTR_VALDES, ';
    strSQL := strSQL + '  R.CTR_DESCON, ';
    strSQL := strSQL + '  R.CTR_JURSUJ, ';
    strSQL := strSQL + '  R.CTR_DESSUJ, ';
    //strSQL := strSQL + '  R.CTR_HIST01, ';
    strSQL := strSQL + '  REPLACE(R.CTR_HIST01, "<<csq>>", " ") AS CTR_HIST01, ';
    strSQL := strSQL + '  IF(LENGTH(R.CTR_HIST01) > 60, "TRUE", "FALSE") AS TAM_HIST, ';
    strSQL := strSQL + '  R.CTR_NOSNUM, ';
    strSQL := strSQL + '  R.CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_PARCEL, ';
    strSQL := strSQL + '  R.CTR_SEQBAI, ';
    strSQL := strSQL + '  R.CTR_ESPDOC, ';
    strSQL := strSQL + '  R.CTR_CODCND, ';
    strSQL := strSQL + '  CONCAT(IF(R.CTR_SEQBAI > 0, "P ", ""), CTR_NUMDUP, CTR_PARCEL, "-", CTR_ESPDOC) AS NUMDUP, ';
    strSQL := strSQL + '  IF(CTR_EMP_PD <> "", CTR_EMP_PD, CTR_CODEMP) EMPORD, ';

    Case rdgPortador.ItemIndex Of
      0: strSQL := strSQL + '  PD.POR_NOMPOR AS NOMPOR, ';
      1: strSQL := strSQL + '  PC.POR_NOMPOR AS NOMPOR, ';
      2: strSQL := strSQL + '  PB.POR_NOMPOR AS NOMPOR, ';
    End;

    strSQL := strSQL + '  IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) AS VALORI, '; //TODOS VAL. ORIGEM
    strSQL := strSQL + '  IF(CTR_VALREC > 0, CTR_VALREC - (CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)), 0) AS VALDIF, '; //TODOS VAL. JUROS

    strSQL := strSQL + '  R.CTR_VALDUP AS CTR_VLRCOR, '; // VALOR CORRIGIDO DAS DUPLICATAS

    If chkDiaCre.Checked Then
    Begin
      strSQL := strSQL + '  IF(CTR_DTAREC IS NOT NULL, ';
      strSQL := strSQL + '      IF(DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY) >= CTR_DTAREC, 0, DATEDIFF(CTR_DTAREC, DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY))), ';
      strSQL := strSQL + '      IF(DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY) >= ' + fCurrentDate + ', 0, DATEDIFF(' + fCurrentDate + ', DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY)))) AS CTR_DIAATR, ';
    End
    Else
    Begin
      strSQL := strSQL + '  IF(CTR_DTAREC IS NOT NULL, ';
      strSQL := strSQL + '      IF(CTR_DTAVEN >= CTR_DTAREC, 0, DATEDIFF(CTR_DTAREC, CTR_DTAVEN)), ';
      strSQL := strSQL + '      IF(CTR_DTAVEN >= ' + fCurrentDate + ', 0, DATEDIFF(' + fCurrentDate + ', CTR_DTAVEN))) AS CTR_DIAATR, ';
    End;

    If fCfgSis('USACND', varBoolean) Then
    Begin
      If edtOrdemCli.Text = 'P' Then
        strSQL := strSQL + ' P.CND_DESCRI, ';
    End;

    If (chkImpAdc.Checked) Then
      strSQL := strSQL + '  REPLACE (C.CLI_OBSERV,"<<csq>>", " ") AS CLI_OBSERV,  '
    else
      strSQL := strSQL + ' (" ") AS CLI_OBSERV, ';

    If edtNome.Text = 'R' Then
         strSQL := strSQL + '  C.CLI_NOMCLI, '
    Else strSQL := strSQL + '  IF(C.CLI_FANSOB = "" OR C.CLI_FANSOB IS NULL, C.CLI_NOMCLI, C.CLI_FANSOB) AS CLI_NOMCLI, ';

    strSQL := strSQL + '  C.CLI_CGCCPF, ';
    strSQL := strSQL + '  C.CLI_C_G_C_, ';
    strSQL := strSQL + '  CONCAT(C.CLI_ENDERE, IF(C.CLI_ENDNUM IS NOT NULL, CONCAT(", ", C.CLI_ENDNUM), "")) AS CLI_ENDERE, ';
    strSQL := strSQL + '  C.CLI_C_E_P_, ';
    strSQL := strSQL + '  C.CLI_BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_STATUS = "A", "ATIVO", "INATIVO") AS CLI_STATUS, ';

    If chkImpEnd.Checked Then
    Begin
      strSQL := strSQL + '    IF((C.CLI_ENDCOB IS NULL) OR (C.CLI_ENDCOB = ""), ';
      strSQL := strSQL + '       CONCAT( ';
      strSQL := strSQL + '                C.CLI_ENDERE, IF(C.CLI_ENDNUM IS NOT NULL, CONCAT(", ", C.CLI_ENDNUM), ""), " - ", ';
      strSQL := strSQL + '                IF(C.CLI_ENDCOM IS NOT NULL, C.CLI_ENDCOM, ""), " - ", ';
      strSQL := strSQL + '                IF(C.CLI_CAIPOS IS NOT NULL, CONCAT("CX.POSTAL: ", C.CLI_CAIPOS), ""), " - ", ';
      strSQL := strSQL + '                IF(C.CLI_BAIRRO IS NOT NULL, CONCAT(C.CLI_BAIRRO, " - "), ""), ';
      strSQL := strSQL + '                IF(C.CLI_C_E_P_ IS NOT NULL, CONCAT(" CEP.: ", INSERT(C.CLI_C_E_P_, 6, 0, "-"), " - "), ""), ';
      strSQL := strSQL + '                IF(D1.CID_NOMCID IS NOT NULL, CONCAT(D1.CID_NOMCID, " - ", D1.CID_ESTADO), "") ';
      strSQL := strSQL + '             ), ';
      strSQL := strSQL + '       CONCAT( ';
      strSQL := strSQL + '                C.CLI_ENDCOB, " - ", ';
      strSQL := strSQL + '                IF(C.CLI_BAICOB IS NOT NULL, CONCAT(C.CLI_BAICOB, " - "), ""), ';
      strSQL := strSQL + '                IF(C.CLI_CEPCOB IS NOT NULL, CONCAT(" CEP.: ", INSERT(C.CLI_CEPCOB, 6, 0, "-"), " - "), ""), ';
      strSQL := strSQL + '                IF(D2.CID_NOMCID IS NOT NULL, CONCAT(D2.CID_NOMCID, " - ", D2.CID_ESTADO), "") ';
      strSQL := strSQL + '             ) ';
      strSQL := strSQL + '      ) AS ENDERE, ';
    End;

    strSQL := strSQL + '  CONCAT(D1.CID_NOMCID, " - ", D1.CID_ESTADO) AS CLI_NOMCID, ';
    strSQL := strSQL + '  C.CLI_ENDCOB, ';
    strSQL := strSQL + '  C.CLI_BAICOB, ';
    strSQL := strSQL + '  CONCAT(D2.CID_NOMCID, " - ", D2.CID_ESTADO) AS CLI_CIDCOB, ';
    strSQL := strSQL + '  C.CLI_CONTAT, ';
    strSQL := strSQL + '  C.CLI_LIMCRE AS LIMCRE, ';
    strSQL := strSQL + '    IF((C.CLI_ENDCOB IS NULL) OR (CLI_ENDCOB = ""),C.CLI_FONE01,IF((C.CLI_TELCOB IS NULL) OR (C.CLI_TELCOB = ""),C.CLI_FONE01,C.CLI_TELCOB)) AS TELEFONE, ';

    If blnMostraVlrBru Then
      strSQL := strSQL + '  (IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI) / (1-(C.CLI_DESCON / 100))) AS CTR_VLRBRU, '
    Else
      strSQL := strSQL + '  0.00 AS CTR_VLRBRU, ';

    strSQL := strSQL + '  C.CLI_DTACAD AS DTACAD  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC R LEFT JOIN CADCLI C ON CTR_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID D1 ON D1.CID_CODCID = C.CLI_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CADCID D2 ON D2.CID_CODCID = C.CLI_CIDCOB ';
    strSQL := strSQL + '  LEFT JOIN CADPOR PD ON PD.POR_CODPOR = CTR_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN CADPOR PC ON PC.POR_CODPOR = CLI_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN CADPOR PB ON PB.POR_CODPOR = CTR_PORBAI ';

    If fCfgSis('USACND', varBoolean) Then
    Begin
      If edtOrdemCli.Text = 'P' Then
        strSQL := strSQL + '  LEFT JOIN CADCND P ON P.CND_CODIGO = R.CTR_CODCND ';
    End;

    pSetaFiltros(strSQL);

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametros(qryRelatorio);
        Open;
    End;

    pSetaClient(qryRelatorio);

    dspRelatorio := TUniDataSetProvider.Create(Self);
    cdsRelatorio := TUniClientDataSet.Create(Self);

    dspRelatorio.DataSet := qryRelatorio;
    cdsRelatorio.SetProvider(dspRelatorio);

    frxRelatorio.DataSet := cdsRelatorio;

    {***************************************}
    {* CRIA O INDICE PARA AGRUPAMENTO      *}
    {************************************IV*}
    With cdsRelatorio.IndexDefs.AddIndexDef Do
    Begin
      Name   := 'IDX_CLIENT';
      If Pos(edtOrdemCli.Text, 'C_N') > 0 Then
        Fields := 'CTR_CODCLI'
      Else
        Fields := 'CTR_CODCND';  
    End;

    {***************************************}
    {* CRIA OS AGGREGATES                  *}
    {************************************IV*}
    cdsRelatorio.AggregatesActive := True;
    With TAggregateField.Create(Self) Do
    Begin
      FieldName     := 'TOT_VLRDUP';
      DataSet       := cdsRelatorio;
      Expression    := 'SUM(CTR_VALDUP)';
      IndexName     := 'IDX_CLIENT';
      GroupingLevel := 1;
      Active        := True;
    End;

    With TAggregateField.Create(Self) Do
    Begin
      FieldName     := 'TOT_VLRCOR';
      DataSet       := cdsRelatorio;
      Expression    := 'SUM(CTR_VLRCOR)';
      IndexName     := 'IDX_CLIENT';
      GroupingLevel := 1;
      Active        := True;
    End;

    cdsRelatorio.IndexName := 'IDX_CLIENT';
    cdsRelatorio.Open;

    If chkAjuDta.Checked Then
      pAjustaData;

    If Not cdsRelatorio.IsEmpty Then
    Begin

      With cdsRelatorio Do
      Begin
        First;

        If chkValCor.Checked Then
        Begin

          While Not Eof Do
          Begin
            Edit;

              FieldByName('CTR_VLRCOR').AsFloat := FieldByName('CTR_VALDUP').AsCurrency +
                                                   fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                                       FieldByName('CTR_VALDUP').AsFloat);

            Post;
            Next;
          End;

        End;

        cdsResumoSint.CreateDataSet;
        cdsResumoSint.Open;

        First;
        While Not Eof Do
        Begin
          If gbFirst in GetGroupState(1) Then
          Begin
            cdsResumoSint.Append;
            cdsResumoSint.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
            cdsResumoSint.FieldByName('NOMCLI').AsString := FieldByName('CLI_NOMCLI').AsString;
            cdsResumoSint.FieldByName('FONE01').AsString := FieldByName('TELEFONE').AsString;
            cdsResumoSint.FieldByName('VALDUP').AsFloat  := TAggregateField(FieldByName('TOT_VLRDUP')).Value;
            cdsResumoSint.FieldByName('VLRCOR').AsFloat  := TAggregateField(FieldByName('TOT_VLRCOR')).Value;
            cdsResumoSint.FieldByName('CODCND').AsString := FieldByName('CTR_CODCND').AsString;
            cdsResumoSint.Post;
          End;

          Next;
        End;

      End;

      If SameText(edtOrdemCli.Text, 'C') Then
           cdsResumoSint.IndexFieldNames := 'CODCLI'
      Else If SameText(edtOrdemCli.Text, 'N') Then
        cdsResumoSint.IndexFieldNames := 'NOMCLI'
      Else
        cdsResumoSint.IndexFieldNames := 'CODCND';

      {******************************************************}
      {*  PARA CRIAR ÍNDICE EM TEMPO DE EXECUÇÃO            *}
      {***************************************************MA*}
      cdsRelatorio.Active := False;
      cdsRelatorio.IndexDefs.Update;

      cdsRelatorio.IndexName := '';
      pSetaOrdem(cdsRelatorio);

      cdsRelatorio.SetProvider(dspRelatorio);
      cdsRelatorio.Active := True;

      cdsRelatorio.FieldByName('CTR_VALDUP').AsCurrency;

      {******************************************************}
      {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
      {***************************************************JB*}
      If SameText(strTipImp, 'M') Then
      Begin
        frxRel := frxRelatorioM;
        If edtOrdemCli.Text = 'P' Then
        Begin
          TfrxReportPage(frxRel.Pages[1]).Visible := False;
          TfrxReportPage(frxRel.Pages[2]).Visible := True;
        End
        Else
        Begin
          TfrxReportPage(frxRel.Pages[1]).Visible := True;
          TfrxReportPage(frxRel.Pages[2]).Visible := False;
        End;
      End
      Else
      Begin
        frxRel := frxRelatorioJ;
        frxRel.DotMatrixReport           := False;
        frxRel.PrintOptions.PrintMode    := pmScale;
        frxRel.PrintOptions.PrintOnSheet := 9;
                          
        If edtOrdemCli.Text = 'P' Then
        Begin
          TfrxMemoView(frxRel.FindObject('rllZebraCnd')).Highlight.Color := intCor;
          TfrxReportPage(frxRel.Pages[2]).Visible := True;
          TfrxReportPage(frxRel.Pages[1]).Visible := False;
        End
        Else
        Begin
          TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := intCor;
          TfrxReportPage(frxRel.Pages[1]).Visible := True;
          TfrxReportPage(frxRel.Pages[2]).Visible := False;
        End;
      End;

      {******************************************************************}
      {* CONTROLA IMPRESSÃO DO LIMITE, MEDIA ATRASO, E DATA DE CADASTRO *}
      {* JUNTO COM CHECKBOX DE OBSERVAÇÕES DO CADSASTRO DO CLIENTE ******}
      {* RQ: 31957 ***************************************************BB*}
      If chkImpAdc.Checked Then
      Begin
        TfrxMemoView(frxRel.FindObject('rllLimite')).Visible   := True;
        TfrxMemoView(frxRel.FindObject('rdbLimite')).Visible   := True;
        TfrxMemoView(frxRel.FindObject('rllMedAtr')).Visible   := True;
        TfrxMemoView(frxRel.FindObject('rdbMedAtr')).Visible   := True;
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible   := True;
        TfrxMemoView(frxRel.FindObject('rdbDtaCad')).Visible   := True;
        TfrxMemoView(frxRel.FindObject('rllAtrGeral')).Visible := True;
        TfrxMemoView(frxRel.FindObject('rdbAtrGeral')).Visible := True;
      End
      Else
      Begin
        TfrxMemoView(frxRel.FindObject('rllLimite')).Visible   := False;
        TfrxMemoView(frxRel.FindObject('rdbLimite')).Visible   := False;
        TfrxMemoView(frxRel.FindObject('rllMedAtr')).Visible   := False;
        TfrxMemoView(frxRel.FindObject('rdbMedAtr')).Visible   := False;
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible   := False;
        TfrxMemoView(frxRel.FindObject('rdbDtaCad')).Visible   := False;
        TfrxMemoView(frxRel.FindObject('rllAtrGeral')).Visible := False;
        TfrxMemoView(frxRel.FindObject('rdbAtrGeral')).Visible := False;
      End;

      {*****************************}
      {* IMPRESSAO EM MEIA FOLHA   *}
      {**************************JC*}
      frxRel.Script.Variables['blnMeiaFolha'] := chkMeiaFolha.Checked;
      TfrxGroupHeader(frxRel.FindObject('rgpTitGru')).StartNewPage := chkMeiaFolha.Checked;

      {**************************************}
      {* PASSA AS FUNCTION P\ O FASTREPORT  *}
      {***********************************JB*}
      frxRel.AddFunction('function fGetVal001: Double');
      frxRel.AddFunction('function fGetVal002: Double');
      frxRel.AddFunction('function fGetVal003: Double');
      frxRel.AddFunction('function fRetObsCobCliente(strCodCli: String): String');


      Try
        {******************************}
        {* CARREGA CABEÇALHO          *}
        {***************************JB*}
        If SameText(edtTitulos.Text, 'A') Then
          frxRel.Script.Variables['NOMREL'] := IfThen(strTipImp = 'M','RELATORIO', 'RELATÓRIO') + ' DE CONTA CORRENTE A RECEBER - ABERTO'
        Else If SameText(edtTitulos.Text, 'Q') Then
          frxRel.Script.Variables['NOMREL'] := IfThen(strTipImp = 'M','RELATORIO', 'RELATÓRIO') + ' DE CONTA CORRENTE A RECEBER - QUITADOS'
        Else
          frxRel.Script.Variables['NOMREL'] := IfThen(strTipImp = 'M','RELATORIO', 'RELATÓRIO') + ' DE CONTA CORRENTE A RECEBER - TODOS';

        If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          frxRel.Script.Variables['PERIODO'] := IfThen(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)), '', 'REFERENTE AO ' +
          IfThen(strTipImp = 'M','PERIODO ', 'PERÍODO ') + lblDtaIni.Caption +' DE ' +
          FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text)));
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) then
        Begin
          frxRel.Script.Variables['PERIODO'] := frxRel.Script.Variables['PERIODO'] +
          IfThen(fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)), '', ' REFERENTE AO ' +
          IfThen(strTipImp = 'M','PERIODO ', 'PERÍODO ') + lblCadIni.Caption +' DE ' +
          FormatDateTime('dd/mm/yyyy',StrToDate(mskCadIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskCadFin.Text)));
        End;

        frxRel.Script.Variables['TIPTIT'] := edtTitulos.Text;
        frxRel.Script.Variables['FILCLI'] := fStrTitulo(edtCodCli.Text, edtDesCli, arrLinCli, strLinCli, 'CLIENTE');
        frxRel.Script.Variables['FILPOR'] := fStrTitulo(edtCodPor.Text, edtDesPor, arrLinPor, strLinPor, 'PORTADOR DA DUPLICATA');
        frxRel.Script.Variables['PORCLI'] := fStrTitulo(edtPorCli.Text, edtDesPorCli, arrPorCli, strPorCli, 'PORTADOR DO CLIENTE');
        frxRel.Script.Variables['PORBAI'] := fStrTitulo(edtPorBai.Text, edtDesPorBai, arrPorBai, strPorBai, 'PORTADOR DA BAIXA');
        frxRel.Script.Variables['FILEMP'] := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrLinEmp, strLinEmp, 'EMPRESA');
        frxRel.Script.Variables['FILEVE'] := fStrTitulo(edtCodEve.Text, edtDesEve, arrLinEve, strLinEve, 'EVENTO');
        frxRel.Script.Variables['FILCID'] := fStrTitulo(edtCodCid.Text, edtDesCid, arrLinCid, strLinCid, 'CIDADE');
        frxRel.Script.Variables['REDLOJ'] := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strLinRed, 'REDE DE LOJAS');
        frxRel.Script.Variables['FILVEN'] := fStrTitulo(edtCodVen.Text, edtDesVen, arrLinVen, strLinVen, 'VENDEDOR');
        frxRel.Script.Variables['REGIAO'] := fStrTitulo(edtCodReg.Text, edtDesReg, arrRegiao, strRegiao, IfThen(strTipImp = 'M','REGIAO', 'REGIÃO'));
        frxRel.Script.Variables['FILDUP'] := 'DUPLICATA DESCONTADA: ' + IfThen(SameText(edtDupDesc.Text, 'S'), 'SIM', IfThen(SameText(edtDupDesc.Text, 'N'),
        IfThen(strTipImp = 'M', 'NAO', 'NÃO'), 'TODAS'));
        If edtOrdemCli.Text = 'P' then
          frxRel.Script.Variables['FILORD'] := 'ORDEM: COND. PAGAMENTO,  ' + IfThen(SameText(edtOrdem.Text, 'D'),    'DOCUMENTO', 'VENCIMENTO')
        Else
          frxRel.Script.Variables['FILORD'] := 'ORDEM:  ' + IfThen(SameText(edtOrdemCli.Text, 'C'), 'COD. CLIENTE, ', 'NOME CLIENTE, ') +
                                                            IfThen(SameText(edtOrdem.Text, 'D'),    'DOCUMENTO', 'VENCIMENTO');

        frxRel.Script.Variables['FILESP'] := IfThen(fEmptyStr(mskEspecie.Text),
                                                    IfThen(strTipImp = 'M', 'ESPECIE', 'ESPÉCIE') + ' DOCUMENTO: GERAL',
                                                    IfThen(strTipImp = 'M', 'ESPECIE', 'ESPÉCIE') + ' DOCUMENTO: '+ mskEspecie.Text);

        frxRel.Script.Variables['FILTIP'] := IfThen(edtTipCliente.Text = 'J','TIPO DE PESSOA CLIENTE: ' + IfThen(strTipImp = 'M', 'JURIDICA', 'JURÍDICA'),
        IfThen(edtTipCliente.Text = 'F','TIPO DE PESSOA CLIENTE: ' + IfThen(strTipImp = 'M','FISICA', 'FÍSICA') ,'TIPO DE PESSOA CLIENTE: TODOS'));
        frxRel.Script.Variables['TIPEMP'] := 'EMPRESA DE: ' + IfThen(rdgEmpresa.ItemIndex = 0, 'FATURAMENTO', 'ORIGEM');
        frxRel.Script.Variables['FILVLD'] := 'VALOR DAS DUPLICATAS: ' + IfThen(edtValor.Text = 'P', 'POSITIVO', IfThen(edtValor.Text = 'N', 'NEGATIVO', 'TODOS'));

        If fCfgSis('USACND', varBoolean) Then
          frxRel.Script.Variables['FILCND'] := fStrTitulo(edtCodCnd.Text, edtDesCnd, arrCndPag, strConPag, IfThen(strTipImp = 'M','CONDICAO', 'CONDIÇÃO') + ' DE PAGAMENTO')
        Else
          frxRel.Script.Variables['FILCND'] := '';

        Case rdgStatus.ItemIndex Of
          0: frxRel.Script.Variables['FILSTA'] := 'STATUS: ENVIADOS AO BANCO';
          1: frxRel.Script.Variables['FILSTA'] := 'STATUS: '+ IfThen(strTipImp = 'M','NAO', 'NÃO') + ' ENVIADOS AO BANCO';
          2: frxRel.Script.Variables['FILSTA'] := 'STATUS: TODOS';
        End;

        if blnMostraVlrBru And SameText(edtTitulos.Text, 'A') then
        Begin
          TfrxMemoView(frxRel.FindObject('rllCapBru')).Text    := 'VL.BRUTO';
          TfrxMemoView(frxRel.FindObject('rllValBru')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllValPBr')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllValGBr')).Visible := True;

          TfrxMemoView(frxRel.FindObject('rllCapBruCnd')).Text    := 'VL.BRUTO';
          TfrxMemoView(frxRel.FindObject('rllValBruCnd')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllValPBrCnd')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllValGBrCnd')).Visible := True;
        End
        Else
        Begin
          TfrxMemoView(frxRel.FindObject('rllCapBru')).Text    := ' ';
          TfrxMemoView(frxRel.FindObject('rllValBru')).Visible := False;
          TfrxMemoView(frxRel.FindObject('rllValPBr')).Visible := False;
          TfrxMemoView(frxRel.FindObject('rllValGBr')).Visible := False;

          TfrxMemoView(frxRel.FindObject('rllCapBruCnd')).Text    := ' ';
          TfrxMemoView(frxRel.FindObject('rllValBruCnd')).Visible := False;
          TfrxMemoView(frxRel.FindObject('rllValPBrCnd')).Visible := False;
          TfrxMemoView(frxRel.FindObject('rllValGBrCnd')).Visible := False;
        End;

        {******************************************}
        {* CONFIGURA TIPO DO RELATÓRIO ( ABERTO ) *}
        {***************************************JB*}
        If SameText(edtTitulos.Text, 'A') Then
        Begin
          TfrxMemoView(frxRel.FindObject('rdbDtaVen')).Visible   := False;
          TfrxMemoView(frxRel.FindObject('rllDtaVen')).Visible   := False;

          If (strTipImp = 'M') Then
            TfrxMemoView(frxRel.FindObject('rdbHistor')).Width     := 275;

          TfrxMemoView(frxRel.FindObject('rdbDtaRec')).Text      := '[<frxRelatorio."CTR_DTAVEN">]';
          TfrxMemoView(frxRel.FindObject('rllDtaRec')).Text      := 'VENCTO.';

          if edtOrdemCli.Text = 'P' then
          Begin
            TfrxMemoView(frxRel.FindObject('rllCap001cnd')).Text   := 'VALOR';
            TfrxMemoView(frxRel.FindObject('rllCap002cnd')).Text   := 'VL.JUROS';
            TfrxMemoView(frxRel.FindObject('rllCap003cnd')).Text   := 'VL.COR';
          End
          Else
          Begin
            TfrxMemoView(frxRel.FindObject('rllCap001')).Text      := 'VALOR';
            TfrxMemoView(frxRel.FindObject('rllCap002')).Text      := 'VL.JUROS';
            TfrxMemoView(frxRel.FindObject('rllCap003')).Text      := 'VL.COR';
          End;

          intIndRel := 1;

        End
        Else
        Begin
          //TfrxMemoView(frxRel.FindObject('rdbHistor')).Width     := 210;

          TfrxMemoView(frxRel.FindObject('rdbDtaVen')).Visible   := True;
          TfrxMemoView(frxRel.FindObject('rllDtaVen')).Visible   := True;

          TfrxMemoView(frxRel.FindObject('rdbDtaRec')).Text      := '[<frxRelatorio."CTR_DTAREC">]';
          TfrxMemoView(frxRel.FindObject('rllDtaRec')).Text      := 'RECEBIM.';

          if edtOrdemCli.Text = 'P' then
          Begin
            TfrxMemoView(frxRel.FindObject('rdbDtaRecCnd')).Text      := '[<frxRelatorio."CTR_DTAREC">]';

            TfrxMemoView(frxRel.FindObject('rllCap001cnd')).Text   := 'VALOR';
            TfrxMemoView(frxRel.FindObject('rllCap002cnd')).Text   := 'VL.REC';
            TfrxMemoView(frxRel.FindObject('rllCap003cnd')).Text   := 'DIFER';
          End
          Else
          Begin
            TfrxMemoView(frxRel.FindObject('rllCap001')).Text      := 'VALOR';
            TfrxMemoView(frxRel.FindObject('rllCap002')).Text      := 'VL.REC';
            TfrxMemoView(frxRel.FindObject('rllCap003')).Text      := 'DIFER';
          End;

          intIndRel := 2;
        End;

        //TfrxChild(frxRel.FindObject('chdEndere')).Visible := chkImpEnd.Checked;

        If chkImpEnd.Checked Then
        Begin
          TfrxGroupHeader(frxRel.FindObject('rgpTitGru')).Child := TfrxChild(frxRel.FindObject('chdEndere'));
          //TfrxChild(frxRel.FindObject('chdEndere')).Child       := TfrxChild(frxRel.FindObject('chdEspGru'));
        End
        Else
        Begin
          TfrxGroupHeader(frxRel.FindObject('rgpTitGru')).Child := TfrxChild(frxRel.FindObject('chdObserv'));
        End;

        {************************************************}
        {* IMPRIMI O NOSSO NUMERO NA COLUNA DO HISTORICO }
        {*********************************************JB*}
        If (chkNossNum.Checked) Then
        Begin
          If edtOrdemCli.Text = 'P' Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllHistorACnd')).Text := 'NOSSO ' + IfThen(strTipImp = 'M','NUMERO','NÚMERO');
            If Not SameText(edtTitulos.Text, 'A') Then
              TfrxMemoView(frxRel.FindObject('rdbHistorCnd')).Text  := '[(Copy(<frxRelatorio."CTR_NOSNUM">,0,21))]'
            Else
              TfrxMemoView(frxRel.FindObject('rdbHistorCnd')).Text  := '[(Copy(<frxRelatorio."CTR_NOSNUM">,0,32))]';
          End
          Else
          Begin
            TfrxMemoView(frxRel.FindObject('rllHistorA')).Text := 'NOSSO ' + IfThen(strTipImp = 'M','NUMERO','NÚMERO');
            If Not SameText(edtTitulos.Text, 'A') Then
              TfrxMemoView(frxRel.FindObject('rdbHistor')).Text  := '[(Copy(<frxRelatorio."CTR_NOSNUM">,0,21))]'
            Else
              TfrxMemoView(frxRel.FindObject('rdbHistor')).Text  := '[(Copy(<frxRelatorio."CTR_NOSNUM">,0,32))]';
          End;
        End
        Else
        Begin
          If edtOrdemCli.Text = 'P' Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllHistorACnd')).Text := IfThen(strTipImp = 'M','HISTORICO','HISTÓRICO');
            TfrxMemoView(frxRel.FindObject('rdbHistorCnd')).Text  := IfThen(edtHistorico.Text = 'T', '[(<frxRelatorio."CTR_HIST01">)]',
              IfThen(strTipImp = 'M', '[(Copy(<frxRelatorio."CTR_HIST01">,1,22))]', '[(Copy(<frxRelatorio."CTR_HIST01">,1,25))]'));
          End
          Else
          Begin
            TfrxMemoView(frxRel.FindObject('rllHistorA')).Text := IfThen(strTipImp = 'M','HISTORICO','HISTÓRICO');
            TfrxMemoView(frxRel.FindObject('rdbHistor')).Text  := IfThen(edtHistorico.Text = 'T', '[(<frxRelatorio."CTR_HIST01">)]',
              IfThen(strTipImp = 'M', '[(Copy(<frxRelatorio."CTR_HIST01">,1,22))]', '[(Copy(<frxRelatorio."CTR_HIST01">,1,25))]'));
          End;
        End;

        If edtOrdemCli.Text = 'P' Then
        Begin
          frxRel.FindObject('rllTotVencCnd').Visible  := chkImpRes.Checked;
          frxRel.FindObject('rllTotRecebCnd').Visible := chkImpRes.Checked;
          frxRel.FindObject('rllTotVenCnd').Visible   := chkImpRes.Checked;
          frxRel.FindObject('rllTotAVenCnd').Visible  := chkImpRes.Checked;
          frxRel.FindObject('rllTotAVencCnd').Visible := chkImpRes.Checked;
          frxRel.FindObject('rllTotRecCnd').Visible   := chkImpRes.Checked;        
        End
        Else
        Begin
          frxRel.FindObject('rllTotVenc').Visible  := chkImpRes.Checked;
          frxRel.FindObject('rllTotRecb').Visible  := chkImpRes.Checked;
          frxRel.FindObject('rllTotVen').Visible   := chkImpRes.Checked;
          frxRel.FindObject('rllTotAVen').Visible  := chkImpRes.Checked;
          frxRel.FindObject('rllTotAVenc').Visible := chkImpRes.Checked;
          frxRel.FindObject('rllTotRec').Visible   := chkImpRes.Checked;
        End;

        If chkImpRes.Checked Then
          pMontaResumo(frxRel);

        {**********************************}
        {* AJUSTA TAMANHO DA FOLHA        *}
        {*******************************JB*}
        If chkMeiaFolha.Checked Then
        Begin
          TfrxReportPage(frxRel.Pages[1]).PaperHeight  := 143.933240376449; // 33 Ch
          TfrxReportPage(frxRel.Pages[1]).ColumnWidth  := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).TopMargin    := 0.00000000000000; // 00 Ch
          TfrxReportPage(frxRel.Pages[1]).BottomMargin := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).LeftMargin   := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).RightMargin  := 4.49791376176403; // 01 Ch
        End
        Else
        Begin
          TfrxReportPage(frxRel.Pages[1]).PaperHeight  := 292.364394514662; // 65 Ch
          TfrxReportPage(frxRel.Pages[1]).ColumnWidth  := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).TopMargin    := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).BottomMargin := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).LeftMargin   := 4.49791376176403; // 01 Ch
          TfrxReportPage(frxRel.Pages[1]).RightMargin  := 4.49791376176403; // 01 Ch
        End;

        If Not chkResumoSint.Checked Then
          frxRel.Pages[3].Visible := False
        Else
        Begin
          frxRel.Pages[3].Visible := True;
          If SameText(strTipImp, 'M') Then
          Begin
            TfrxReportPage(frxRel.Pages[3]).PaperHeight  := 292.364394514662; // 65 Ch
            TfrxReportPage(frxRel.Pages[3]).ColumnWidth  := 4.49791376176403; // 01 Ch
            TfrxReportPage(frxRel.Pages[3]).TopMargin    := 4.49791376176403; // 01 Ch
            TfrxReportPage(frxRel.Pages[3]).BottomMargin := 4.49791376176403; // 01 Ch
            TfrxReportPage(frxRel.Pages[3]).LeftMargin   := 4.49791376176403; // 01 Ch
            TfrxReportPage(frxRel.Pages[3]).RightMargin  := 4.49791376176403; // 01 Ch
          End;
        End;

        If chkNovaPaginaQuebra.Checked Then
        Begin
          TfrxGroupHeader(frxRel.FindObject('rgpTitGru')).StartNewPage := True;
        End;

        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxRel)
        Else If edtDestino.Text = 'I' Then
        Begin
          If frxRel.PrepareReport Then
          Begin
            frxRel.PrintOptions.ShowDialog := (strNomImp = '');
            frxRel.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
          End;
        End
        Else If edtDestino.Text = 'E' Then
          pGeraExcel;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;

      End;

    End
    Else
      pTabelaVazia;

    cdsResumoSint.Close;
    Self.SelectFirst;
    FreeAndNil(cdsRelatorio);

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelCtrReceber.pSetaParametros(Var qryGen: TUniQuery);
begin

  With qryGen Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
    Begin
      ParamByName('CADINI').AsDate := StrToDate(mskCadIni.Text);
      ParamByName('CADFIN').AsDate := StrToDate(mskCadFin.Text);
    End;

    If (edtDupDesc.Text = 'S') Or (edtDupDesc.Text = 'N') Then
      ParamByName('DESCON').AsString := edtDupDesc.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      ParamByName('ESPDOC').AsString := mskEspecie.Text;

    {****************************}
    {* FILTRO POR REDE DE LOJAS *}
    {*************************DP*}
    If Not fEmptyStr(edtCodRede.Text) Then
      pSetaParamOR(edtCodRede,arrRede,'CODRED',qryRelatorio);

    pSetaParam(edtCodCli.Text, arrLinCli, strLinCli, 'CODCLI', qryGen);
    pSetaParam(edtCodPor.Text, arrLinPor, strLinPor, 'CODPOR', qryGen);
    pSetaParam(edtPorCli.Text, arrPorCli, strPorCli, 'PORCLI', qryGen);
    pSetaParam(edtPorBai.Text, arrPorBai, strPorBai, 'PORBAI', qryGen);

    If (rdgEmpresa.ItemIndex = 0) and (edtDesEmp.Text <> 'TODOS') Then
    Begin
      pSetaParam(edtCodEmp.Text, arrLinEmp, strLinEmp, 'CODEMP', qryGen);
    End;

    pSetaParam(edtCodEve.Text, arrLinEve, strLinEve, 'CODEVE', qryGen);
    pSetaParam(edtCodCid.Text, arrLinCid, strLinCid, 'CODCID', qryGen);
    pSetaParam(edtCodVen.Text, arrLinVen, strLinVen, 'CODVEN', qryGen);
    pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', qryGen);
    pSetaParam(edtCodCnd.Text, arrCndPag, strConPag, 'CODCND', qryGen);
  End;

end;

procedure TfrmRelCtrReceber.pSetTotAve(fltValue: Double);
begin
  fltTotAve := fltTotAve + fltValue;
end;

procedure TfrmRelCtrReceber.pSetTotRec(fltValue: Double);
begin
  fltTotRec := fltTotRec + fltValue;
end;

procedure TfrmRelCtrReceber.pSetTotVen(fltValue: Double);
begin
  fltTotVen := fltTotVen + fltValue;
end;

procedure TfrmRelCtrReceber.pZeraTotais;
begin
  fltTotAve := 0;
  fltTotVen := 0;
  fltTotRec := 0;
end;

procedure TfrmRelCtrReceber.pSetaOrdem(Var cdsAux: TUniClientDataSet);
  Var strOrdem: String;
begin
  strOrdem := '';

  If (edtOrdemCli.Text = 'C') Then
    strOrdem := strOrdem + 'CTR_CODCLI; '
  Else If (edtOrdemCli.Text = 'N') Then
    strOrdem := strOrdem + 'CLI_NOMCLI; CTR_CODCLI; '
  Else
    strOrdem := strOrdem + 'CND_DESCRI; ';

  If (edtOrdem.Text = 'D') Then
  Begin
    strOrdem := strOrdem + 'CTR_NUMDUP; CTR_PARCEL; ';

    If (rdgEmpresa.ItemIndex = 0) Then
      strOrdem := strOrdem + 'CTR_SEQBAI; CTR_ESPDOC; CTR_CODEMP '
    Else
      strOrdem := strOrdem + 'CTR_SEQBAI; CTR_ESPDOC; EMPORD ';

  End
  Else
    strOrdem := strOrdem + 'CTR_DTAVEN';

  cdsAux.IndexFieldNames := strOrdem;
end;

procedure TfrmRelCtrReceber.pSetaFiltros(Var strSQL: String);
begin
  strSQL := strSQL + ' WHERE TRUE ';

  If chkProfis.Checked Then
    strSQL := strSQL + ' AND IFNULL(CTR_DOCDIV,"") <> "" ';

  If (edtDupDesc.Text = 'S') Or (edtDupDesc.Text = 'N') Then
    strSQL := strSQL + ' AND  CTR_DESCON = :DESCON ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
    strSQL := strSQL + '  AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';

  If edtTitulos.Text = 'Q' Then
  Begin
    strSQL := strSQL + ' AND CTR_DTAREC IS NOT NULL ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';

  End
  Else
  Begin

    If edtTitulos.Text = 'A' Then
    Begin
      strSQL := strSQL + ' AND CTR_DTAREC IS NULL';

    //    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then //If edtTipoDta.Text = 'C' Then //
    //    strSQL := strSQL + ' AND CTR_DTACAD BETWEEN :CADINI AND :CADFIN ';

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then //Else
      Begin
        If chkDiaCre.Checked Then
          strSQL := strSQL + ' AND DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY) BETWEEN :DTAINI AND :DTAFIN '
        Else 
          strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
      End;

    End
    Else If edtTitulos.Text = 'T' Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If chkDiaCre.Checked Then
          strSQL := strSQL + ' AND DATE_ADD(R.CTR_DTAVEN, INTERVAL IFNULL(PD.POR_DCRREC,0) DAY) BETWEEN :DTAINI AND :DTAFIN '
        Else 
          strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
      End;
    End;
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
    strSQL := strSQL + '  AND CTR_DTACAD BETWEEN :CADINI AND :CADFIN ';

  If edtTipCliente.Text = 'J' Then strSQL := strSQL + ' AND CLI_CGCCPF = 1 ';
  If edtTipCliente.Text = 'F' Then strSQL := strSQL + ' AND CLI_CGCCPF = 2 ';

  strSQL := strSQL + fStrLocate(edtCodCli, arrLinCli, 'CTR_CODCLI', 'CODCLI');

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor, arrLinPor, 'CTR_CODPOR', 'CODPOR')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If Not fEmptyStr(edtPorCli.Text) Then
    strSQL := strSQL + fStrLocate(edtPorCli, arrPorCli, 'CLI_CODPOR', 'PORCLI')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CLI_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CLI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If Not fEmptyStr(edtPorBai.Text) Then
    strSQL := strSQL + fStrLocate(edtPorBai, arrPorBai, 'CTR_PORBAI', 'PORBAI')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_PORBAI, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  strSQL := strSQL + fStrLocate(edtCodEve, arrLinEve, 'CTR_CODEVE', 'CODEVE');
  strSQL := strSQL + fStrLocate(edtCodCid, arrLinCid, 'CLI_CODCID', 'CODCID');
  strSQL := strSQL + fStrLocate(edtCodVen, arrLinVen, 'CTR_CODVEN', 'CODVEN');
  strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');
  strSQL := strSQL + fStrLocate(edtCodCnd, arrCndPag, 'CTR_CODCND', 'CODCND');

  {***********************************}
  {* FILTRO POR VALOR DAS DUPLICATAS *}
  {********************************IV*}
  If gpbValor.Enabled Then
  Begin
    If edtValor.Text = 'P' Then
      strSQL := strSQL + ' AND ROUND((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)), 2) > 0.0 '
    Else If edtValor.Text = 'N' Then
      strSQL := strSQL + ' AND ROUND((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)), 2) < 0.0 ';
  End;

  {****************************}
  {* FILTRO POR REDE DE LOJAS *}
  {*************************DP*}
  If Not fEmptyStr(edtCodRede.Text) Then
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

  If (rdgEmpresa.ItemIndex = 0) and (edtDesEmp.Text <> 'TODOS') Then
  Begin
    strSql := strSQL + fStrLocate(edtCodEmp,  arrLinEmp,  'CTR_CODEMP', 'CODEMP');
  End
  Else
  If (rdgEmpresa.ItemIndex = 0) and (edtDesEmp.Text = 'TODOS') Then
  Begin
    strSQL := strSQL + '  AND (LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 OR LOCATE(CTR_CODEMP,' + QuotedStr(strAceCtr) + ') > 0) ';
  End
  Else
  If (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    strSql := strSQL + ' AND IF(IFNULL(CTR_EMP_PD, "") = "", CTR_CODEMP = ' + QuotedStr(edtCodEmp.Text) + ', CTR_EMP_PD = ' + QuotedStr(edtCodEmp.Text) + ') ';
  End;


  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + ' AND CTR_DTAENV IS NOT NULL ';
    1: strSQL := strSQL + ' AND CTR_DTAENV IS NULL     ';
  End;

end;

procedure TfrmRelCtrReceber.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  {***********************************}
  {* EXIBE O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM  *}
  {* MULTISELEÇÃO                    *}
  {***30/06/2008*******************JB*}
  shpMultSel.Visible := True;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  mskCadIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskCadFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;

  If Not fCfgSis('USACND', varBoolean) Then
  Begin
    lblCndPag.Visible := False;
    edtCodCnd.Visible := False;
    edtDesCnd.Visible := False;
    lblOrdCli.Caption := '(C)ódigo do Cliente / (N)ome do Cliente';
  End
  Else
    lblOrdCli.Caption := '(C)ódigo do Cliente / (N)ome do Cliente / Cond. de (P)agamento';

  if not chkResumoSint.Visible then
     chkNovaPaginaQuebra.Top :=  chkResumoSint.Top
  else
     chkNovaPaginaQuebra.Top := 312;
end;

procedure TfrmRelCtrReceber.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtTitulos);
end;

procedure TfrmRelCtrReceber.FormCreate(Sender: TObject);
begin
  inherited;
  blnExcel  := True;

  frxRelatorioM.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxRelatorioJ.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxRelatorioM.AddFunction('function fRetObsCobCliente(strCodCli: String): String');
  frxRelatorioJ.AddFunction('function fRetObsCobCliente(strCodCli: String): String');

  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');

  If fCfgSis('CLIDES', varBoolean) And (fCfgSis('MODCOC', varString) = '2') Then
    blnMostraVlrBru := True
  Else
    blnMostraVlrBru := False;

  //Seleciona a permissão de Baixa do Contas a Receber do usuário logado
  strAceCtr := fCampoTabela('OPE_EMPCTR', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
end;

procedure TfrmRelCtrReceber.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtrReceber.edtCodEveExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEve, edtDesEve, arrLinEve, fRetNomEvento, Nil, 'do evento');

end;

procedure TfrmRelCtrReceber.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrLinEve, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.pCarregaEventos(Var qryCadEve: TUniQuery);
begin

  If Not (fEmptyStr(edtCodEve.Text)) Then
    edtDesEve.Text := qryCadEve.FieldByName('EVE_DESEVE').AsString
  Else
    edtDesEve.Text := '';

end;

procedure TfrmRelCtrReceber.edtTipoDtaExit(Sender: TObject);
begin
  inherited;

  If Not (edtTitulos.Text = 'Q') Then
  Begin
    If edtTipoDta.Text = 'C' Then
    Begin
      lblDtaIni.Caption := '(CADASTRO)';
      lblDtaFin.Caption := '(CADASTRO)';
    End
    Else
    Begin
      lblDtaIni.Caption := '(VENCIMENTO)';
      lblDtaFin.Caption := '(VENCIMENTO)';
    End;
  End;

end;

procedure TfrmRelCtrReceber.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtDesCid, Nil, Nil, Key, arrLinCid, False) Then
  Begin
    fValidaCampos(edtCodCid, False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.edtCodCidExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCid, edtDesCid, arrLinCid, fRetNomCidadeSemOpc,nil,'da Cidade');

end;

procedure TfrmRelCtrReceber.edtCodVenExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodVen, edtDesVen, arrLinVen, fRetNomVendRep,nil,'do Vendedor');
  
end;

procedure TfrmRelCtrReceber.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodVen, edtDesVen, nil, Key, arrLinVen, False) Then  
  Begin
    If fvalidaCampos(edtCodVen, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.edtOrdemCliChange(Sender: TObject);
begin
  inherited;
  chkNovaPaginaQuebra.Enabled := ((edtOrdemCli.Text = 'C') or (edtOrdemCli.Text = 'N'));

  if not chkNovaPaginaQuebra.Enabled then
     chkNovaPaginaQuebra.Checked := False;

end;

function TfrmRelCtrReceber.frxRelatorioMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;

  {*****************************************}
  {* FUNÇÕES PARA CALCULAR OS VALORES      *}
  {* INDEX: (1) ABERTO, QUITADO  (2) TODOS *}
  {**************************************JB*}
  If MethodName = 'FGETVAL001' Then
    Result := fGetVal001
  Else If MethodName = 'FGETVAL002' Then
    Result := fGetVal002
  Else If MethodName = 'FGETVAL003' Then
    Result := fGetVal003
  Else If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0])
  Else If SameText('fRetObsCobCliente', MethodName) Then
    Result := fRetObsCobCliente(Params[0])
end;

function TfrmRelCtrReceber.fColValorBruto(var intCol: Integer): Boolean;
begin
  Result := blnMostraVlrBru;

  if Result then
    intCol := 1
  else
    intCol := 0;
end;

function TfrmRelCtrReceber.fFormataFonePaisInterna(strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

function TfrmRelCtrReceber.fGetVal001: Double;
begin
  With cdsRelatorio Do
  Begin
    If intIndRel = 1 Then
      {******************************}
      {* TIPO DE REL  = ABERTO      *}
      {***************************JB*}
      Result := FieldByName('CTR_VALDUP').AsCurrency
      
    Else
    {************************************}
    {* TIPO DE REL  = QUITADOS OU TODOS *}
    {*********************************JB*}
    If (FieldByName('CTR_DTAREC').IsNull) Then
      Result := FieldByName('CTR_VALDUP').AsCurrency +
                IfThen(chkValCor.Checked,  fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                FieldByName('CTR_VALDUP').AsFloat), 0)
    Else
      Result := FieldByName('VALORI').AsCurrency;
  End;
end;

function TfrmRelCtrReceber.fGetVal002: Double;
begin
  With cdsRelatorio Do
  Begin
    If intIndRel = 1 Then
    Begin
      {******************************}
      {* TIPO DE REL  = ABERTO      *}
      {***************************JB*}
      Result := IfThen(chkValCor.Checked, fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                       FieldByName('CTR_VALDUP').AsFloat), 0);

    End
    Else
    Begin
      {************************************}
      {* TIPO DE REL  = QUITADOS OU TODOS *}
      {*********************************JB*}
      Result := FieldByName('CTR_VALREC').AsCurrency;

    End;

  End;

end;

function TfrmRelCtrReceber.fGetVal003: Double;
begin
  With cdsRelatorio Do
  Begin
    If intIndRel = 1 Then
    Begin
      {******************************}
      {* TIPO DE REL  = ABERTO      *}
      {***************************JB*}
      Result := FieldByName('CTR_VALDUP').AsCurrency +
                    IfThen(chkValCor.Checked,  fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                       FieldByName('CTR_VALDUP').AsFloat), 0);
    End
    Else
    Begin
      {************************************}
      {* TIPO DE REL  = QUITADOS OU TODOS *}
      {*********************************JB*}
      If FieldByName('CTR_DTAREC').IsNull Then
        Result := 0
      Else
        Result := FieldByName('CTR_VALREC').AsFloat - FieldByName('VALORI').AsFloat;
    End;
  End;
end;

procedure TfrmRelCtrReceber.pAjustaData;
Var
  strSQL   : String;
  dtaDtaVen: TDateTime;
  dtaDtaAnt: TDateTime;

  qryCadFer: TUniQuery;
Begin

  Try

    qryCadFer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FER_DTAFER ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FER_DTAFER = :DTAFER ';

    cdsRelatorio.First;

    While Not cdsRelatorio.Eof Do
    Begin

      dtaDtaVen := cdsRelatorio.fieldbyname('CTR_DTAVEN').AsDateTime;
      dtaDtaAnt := cdsRelatorio.fieldbyname('CTR_DTAVEN').AsDateTime;

      {*********************************************************}
      {* VERIFICA SE O VENCIMENTO EXISTE NA TABELA DE FERIADOS *}
      {******************************************************LU*}
      With qryCadFer Do
      Begin
        SQL.Clear;
        SQL.add(strSQL);
        ParamByName('DTAFER').AsDateTime := dtaDtaVen;
        Open;
      End;

      {*****************************************}
      {* CASO SEJA FERIADO SOMA MAIS 1 NA DATA *}
      {**************************************LU*}
      If qryCadFer.RecordCount > 0 Then
        dtaDtaVen := dtaDtaVen + 1;

      {************************}
      {* VERIFICA SE É SÁBADO *}
      {*********************LU*}
      If DayOfWeek(dtaDtaVen) = 7 Then
        dtaDtaVen := dtaDtaVen + 2
      Else
      {*************************}
      {* VERIFICA SE É DOMINGO *}
      {**********************LU*}
      Begin
        If DayOfWeek(dtaDtaVen) = 1 Then
          dtaDtaVen := dtaDtaVen + 1;
      End;

      {************************************************}
      {* CASO TENHA SIDO NECESSARIA ALTERACAO NA DATA *}
      {*********************************************LU*}
      If dtaDtaVen <> dtaDtaAnt Then
      Begin
        cdsRelatorio.Edit;
        cdsRelatorio.FieldByName('CTR_DTAVEN').AsDateTime := dtaDtaVen;
        cdsRelatorio.Post;
      End;

      cdsRelatorio.Next;
    End;

    FreeAndNil(qryCadFer);

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaData]');
    End;
  End;


End;

procedure TfrmRelCtrReceber.chkMeiaFolhaClick(Sender: TObject);
  Var
    blnHabilita: Boolean;
begin
  inherited;
  blnHabilita := (Not chkMeiaFolha.Checked);

  chkNossNum.Enabled := (blnHabilita) And (Not(edtOrdemCli.Text = 'P'));
  chkImpAdc.Enabled  := (blnHabilita) And (Not(edtOrdemCli.Text = 'P'));
  chkHisCob.Enabled  := (blnHabilita) And (Not(edtOrdemCli.Text = 'P'));
  chkDiaCre.Enabled  := blnHabilita;  

  If Not blnHabilita Then
  Begin
    chkNossNum.Checked := blnHabilita;
    chkImpAdc.Checked  := blnHabilita;
    chkHisCob.Checked  := blnHabilita;
    chkDiaCre.Checked  := blnHabilita;
  End; 
End;

procedure TfrmRelCtrReceber.chkNossNumClick(Sender: TObject);
begin
  inherited;
  If chkNossNum.Checked Then
    edtHistorico.Enabled := False
  Else
    edtHistorico.Enabled := True;
end;

procedure TfrmRelCtrReceber.pGeraExcel;
  Var
    objExcel : TExcel;
    strUltLet: String;
    fltToPOri: Double;
    fltToPDif: Double;
    fltToPRec: Double;
    fltToGOri: Double;
    fltToGDif: Double;
    fltToGRec: Double;
    fltValDup: Double;
    fltValBru: Double;
    fltToPBru: Double;
    fltTotalRecebido: Double;
    fltTotalReceber:  Double;
    fltTotalVencido:  Double;
    fltCalcMedParcial: Double;
    fltCalcMedGeral: Double;
    intQtdRegParcial : Integer;
    strDtaCad : String;
    strLimite : String;
    intCol: Integer;

    strGruCli: String;

begin
  strUltLet := ifThen(blnMostraVlrBru,'N','M');

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************JB*}
  objExcel := TExcel.fCriarExcel(Self);

  {*******************************************}
  {* ADICIONA UMA PASTA DE TRABALHO          *}
  {****************************************JB*}
  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin
    LinhaAtual := 01;

    {********************************}
    {* EMPRESA PADRAO DO SISTEMA    *}
    {*****************************MV*}
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    {*******************************************}
    {* TITULO DO RELATORIO                     *}
    {****************************************JB*}
    If edtTitulos.Text = 'T' Then
      Escrever(ProximaLinha, 01, 'RELATÓRIO DE CONTA CORRENTE A RECEBER - TODOS')
    Else If edtTitulos.Text = 'Q' Then
      Escrever(ProximaLinha, 01, 'RELATÓRIO DE CONTA CORRENTE A RECEBER - QUITADOS')
    Else If edtTitulos.Text = 'A' Then
      Escrever(ProximaLinha, 01, 'RELATÓRIO DE CONTA CORRENTE A RECEBER - EM ABERTO');

    {*******************************************}
    {* FILTRO DE ORDENAÇÃO DO RELATORIO        *}
    {*RQ 32348*******************************BB*}
    If edtOrdemCli.Text = 'P' then
      Escrever(ProximaLinha, 01, 'ORDEM: COND. PAGAMENTO,  ' + IfThen(SameText(edtOrdem.Text, 'D'),    'DOCUMENTO', 'VENCIMENTO'))
    Else
      Escrever(ProximaLinha, 01, 'ORDEM:  ' + IfThen(SameText(edtOrdemCli.Text, 'C'), 'COD. CLIENTE, ', 'NOME CLIENTE, ') +
                                                        IfThen(SameText(edtOrdem.Text, 'D'),    'DOCUMENTO', 'VENCIMENTO'));

    {*******************************************}
    {* OUTROS DADOS DO RELATÓRIO               *}
    {****************************************JB*}   
    If edtCodCli.Text = '' Then
      Escrever(ProximaLinha, 01, 'CLIENTE: TODOS')
    Else
      Escrever(ProximaLinha, 01, 'CLIENTE: ' + edtDesCli.Text);

    If edtCodRede.Text = '' Then
      Escrever(ProximaLinha, 01, 'REDE DE LOJAS: TODAS')
    Else
      Escrever(ProximaLinha, 01, 'REDE DE LOJAS: ' + edtCodRede.Text + ' - ' + edtDesRede.Text);


    If edtCodEmp.Text = '' Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
    Else
      Escrever(ProximaLinha, 01, 'EMPRESA: ' + edtDesEmp.Text);

    If edtCodEve.Text = '' Then
      Escrever(ProximaLinha, 01, 'EVENTO: TODOS')
    Else
      Escrever(ProximaLinha, 01, 'EVENTO ' + edtCodEve.Text + ' - ' + edtDesEve.Text);

    If (edtDupDesc.Text = 'S') Then
      Escrever(ProximaLinha, 01, 'DUPLICATAS DESCONTADAS: SIM ')
    Else If (edtDupDesc.Text = 'N') Then
      Escrever(ProximaLinha, 01, 'DUPLICATAS DESCONTADAS: NÃO ')
    Else
      Escrever(ProximaLinha, 01, 'DUPLICATAS DESCONTADAS: TODAS ');

    Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO DE '+ lblDtaIni.Caption + mskDtaIni.Text + ' A ' + mskDtaFin.Text +
      IfThen(fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)), '', ' REFERENTE AO PERÍODO ' + lblCadIni.Caption + ' DE ' +
      mskCadIni.Text + ' A ' + mskCadFin.Text));

    {********************************}
    {* COLOCA EM NEGRITO E ALINHA   *}
    {* AO CENTRO DA CELULA          *}
    {*****************************JB*}
    Mesclar('A1', strUltLet + '1');
    Mesclar('A2', strUltLet + '2');
    Mesclar('A3', strUltLet + '3');
    Alinhamento('A2', strUltLet + '3', Centro);
    Negrito('A2', strUltLet + '3', True);

    Mesclar('A4', strUltLet + '4');
    Mesclar('A5', strUltLet + '5');
    Mesclar('A6', strUltLet + '6');
    Mesclar('A7', strUltLet + '7');
    Mesclar('A8', strUltLet + '8');
    Mesclar('A9', strUltLet + '9');
    Mesclar('A10', strUltLet + '10');

    Alinhamento('A4', strUltLet + '10', Centro);
    Negrito('A4', strUltLet + '10', True);

    ProximaLinha;
    {*******************************************}
    {* COLUNAS                                 *}
    {****************************************JB*}
    intCol := 0;
    Escrever(LinhaAtual, 01, 'DTA CAD');
    Escrever(LinhaAtual, 02, 'DUPLIC');
    Escrever(LinhaAtual, 03, 'LOJA');
    Escrever(LinhaAtual, 04, 'VEND');
    Escrever(LinhaAtual, 05, 'PORTADOR');
    Escrever(LinhaAtual, 06, 'HISTÓRICO');
    Escrever(LinhaAtual, 07, 'DESCONT.');
    Escrever(LinhaAtual, 08, 'VENCTO.');
    Escrever(LinhaAtual, 09, 'RECEBIM.');
    Escrever(LinhaAtual, 10, 'ATR');

    if fColValorBruto(intCol) then
      Escrever(LinhaAtual, 11, 'VL.BRUTO');

    Escrever(LinhaAtual, 11 + intCol, IfThen(SameText(edtTitulos.Text, 'A'), 'VALOR', 'VALOR'));
    Escrever(LinhaAtual, 12 + intCol, IfThen(SameText(edtTitulos.Text, 'A'), 'VL.JUROS', 'VL.REC'));
    Escrever(LinhaAtual, 13 + intCol, IfThen(SameText(edtTitulos.Text, 'A'), 'VL.COR', 'DIFER'));


    {*******************************************}
    {* COLOCA NEGRITO NAS COLUNAS              *}
    {****************************************JB*}
    Negrito('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), True);

    {*************************************}
    {* COLORI O FUNDO DA CELULA P/ CINZA *}
    {**********************************JB*}
    CorFundo('A2',  strUltLet + '2', Cinza);
    CorFundo('A3',  strUltLet + '3', Cinza);
    CorFundo('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Cinza);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************JB*}
    Bordas('A2',  strUltLet + '2');
    Bordas('A3',  strUltLet + '3');
    Bordas('A4',  strUltLet + '11');
    Bordas('A5',  strUltLet + '11');

    With cdsRelatorio Do
    Begin
      First;
      ProximaLinha;

      fltToPOri := 0;
      fltToPDif := 0;
      fltToPRec := 0;

      fltToGOri := 0;
      fltToGDif := 0;
      fltToGRec := 0;

      fltCalcMedParcial := 0;
      fltCalcMedGeral   := 0;
      intQtdRegParcial  := 0;

      fltValBru := 0;
      fltToPBru := 0;

      fltTotalReceber := 0;
      fltTotalVencido := 0;
      fltTotalRecebido := 0;

      strDtaCad := '';
      strLimite := '';

      strGruCli := EmptyStr;

      While (Not Eof) Do
      Begin
        {************************************}
        {* INSERE O CABEÇALHO DO GRUPO      *}
        {*********************************JB*}
        If Pos(edtOrdemCli.Text, 'C_N_') > 0 Then
        Begin
          If Not SameText(strGruCli, FieldByName('CTR_CODCLI').AsString) Then
          Begin
            strGruCli := FieldByName('CTR_CODCLI').AsString;
            Escrever(LinhaAtual, 01, fFrtStrExcel('CLIENTE: ' + FieldByName('CTR_CODCLI').AsString + '-' +
                                                                FieldByName('CLI_NOMCLI').AsString));
            Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
            ProximaLinha;

            If chkImpEnd.Checked Then
            Begin
              Escrever(LinhaAtual, 01, fFrtStrExcel('ENDEREÇO: ' + FieldByName('ENDERE').AsString +
                                                    ' TELEFONE: '+ fFormataFone(FieldByName('TELEFONE').AsString)));

              Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
              Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
              ProximaLinha;
            End;

            {************************************}
            {* INSERE A OBSERVAÇÃO              *}
            {*********************************PE*}
            If (chkImpAdc.Checked) Or (chkHisCob.Checked) Then
            Begin
              Escrever(LinhaAtual, 01, fFrtStrExcel('OBS:'));
              ProximaLinha;
              Escrever(LinhaAtual, 01, fFrtStrExcel(AnsiReplaceStr(
              IfThen(chkImpAdc.Checked, FieldByName('CLI_OBSERV').AsString, '') +
              IfThen(chkHisCob.Checked,fRetObsCobCliente(strGruCli), ''), '<<csq>>', ' ')));
              Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
            End
            Else
            Begin
              Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
            End;

            Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
            ProximaLinha;
          End;
        End
        Else
        Begin
          If Not SameText(strGruCli, FieldByName('CTR_CODCND').AsString) Then
          Begin
            strGruCli := FieldByName('CTR_CODCND').AsString;
            Escrever(LinhaAtual, 01, fFrtStrExcel('CONDICAO: ' + FieldByName('CTR_CODCND').AsString + '-' +
                                                                 FieldByName('CND_DESCRI').AsString));
            Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

            Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
            ProximaLinha;
          End;
        End;

        Escrever(LinhaAtual, 01, fFrtStrExcel(FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime)));
        Escrever(LinhaAtual, 02, fFrtStrExcel(FieldByName('CTR_NUMDUP').AsString + FieldByName('CTR_PARCEL').AsString));
        Escrever(LinhaAtual, 03, fFrtStrExcel(FieldByName('CTR_CODEMP').AsString));
        Escrever(LinhaAtual, 04, fFrtStrExcel(FieldByName('CTR_CODVEN').AsString));
        Escrever(LinhaAtual, 05, fFrtStrExcel(FieldByName('NOMPOR').AsString));
        Escrever(LinhaAtual, 06, fFrtStrExcel(IfThen(Not fEmptyStr(FieldByName('CTR_NOSNUM').AsString),
                                 AnsiReplaceStr(FieldByName('CTR_HIST01').AsString, '<<csq>>', ' ') + ' - ' + FieldByName('CTR_NOSNUM').AsString,
                                 AnsiReplaceStr(FieldByName('CTR_HIST01').AsString, '<<csq>>', ' '))));
        Escrever(LinhaAtual, 07, fFrtStrExcel(IfThen(FieldByName('CTR_DESCON').AsString = 'S', 'SIM', 'NAO')));

        Escrever(LinhaAtual, 08, fFrtStrExcel(FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime)));
        Escrever(LinhaAtual, 09, fFrtStrExcel(IfThen(Not fEmptyStr(FieldByName('CTR_DTAREC').AsString),
                                 FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAREC').AsDateTime))));
        Escrever(LinhaAtual, 10, fFrtStrExcel(FieldByName('CTR_DIAATR').AsString));

        if blnMostraVlrBru then
        Begin
          fltValBru := fltValBru + FieldByName('CTR_VLRBRU').AsCurrency;
          fltToPBru := fltToPBru + FieldByName('CTR_VLRBRU').AsCurrency;
          Escrever(LinhaAtual, 11, FloatToStrF(FieldByName('CTR_VLRBRU').AsCurrency, ffNumber, 15, 2));
          Alinhamento(LinhaAtual, 11, Direita);
        End;

        if edtTitulos.Text = 'A' then
          fltValDup := FieldByName('CTR_VALDUP').AsCurrency
        else
          fltValDup := FieldByName('CTR_VALDUP').AsCurrency +
                                 IfThen(chkValCor.Checked,
                                 fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                 FieldByName('CTR_VALDUP').AsFloat), 0);

        If intIndRel = 1 Then
        Begin
          {******************************}
          {* TIPO DE REL  = ABERTO      *}
          {***************************JB*}
          fltToPOri := fltToPOri + fltValDup;

          Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltValDup, ffNumber, 15, 2));
          Alinhamento(LinhaAtual, 11 + intCol, Direita);
        End
        Else
        Begin
          {************************************}
          {* TIPO DE REL  = QUITADOS OU TODOS *}
          {*********************************JB*}

          If (FieldByName('CTR_DTAREC').IsNull) Then
          Begin
            fltToPOri := fltToPOri + fltValDup;
            Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltValDup, ffNumber, 15, 2));
          End
          Else
          Begin
            fltToPOri := fltToPOri + FieldByName('VALORI').AsCurrency;
            Escrever(LinhaAtual, 11 + intCol, FloatToStrF(FieldByName('VALORI').AsFloat, ffNumber, 15, 2));
          End;

          Alinhamento(LinhaAtual, 11 + intCol, Direita);
        End;

        If intIndRel = 1 Then
        Begin
          fltToPDif := fltToPDif + IfThen(chkValCor.Checked, fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                          FieldByName('CTR_VALDUP').AsFloat), 0);

          Escrever(LinhaAtual, 12 + intCol, FloatToStrF(IfThen(chkValCor.Checked, fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                                      FieldByName('CTR_VALDUP').AsFloat), 0), ffNumber, 15, 2));
        End
        Else
        Begin

          fltToPDif := fltToPDif + FieldByName('CTR_VALREC').AsFloat;
          Escrever(LinhaAtual,  12 + intCol, FloatToStrF(FieldByName('CTR_VALREC').AsFloat, ffNumber, 15, 2));

        End;

        Alinhamento(LinhaAtual, 12 + intCol, Direita);

        If intIndRel = 1 Then
        Begin
          {******************************}
          {* TIPO DE REL  = ABERTO      *}
          {***************************JB*}
          fltToPRec := fltToPRec + FieldByName('CTR_VALDUP').AsCurrency +
                       IfThen(chkValCor.Checked,  fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                               FieldByName('CTR_VALDUP').AsFloat), 0);


          Escrever(LinhaAtual, 13 + intCol, FloatToStrF(FieldByName('CTR_VALDUP').AsCurrency +
                                   IfThen(chkValCor.Checked,  fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                   FieldByName('CTR_VALDUP').AsFloat), 0), ffNumber, 15, 2));
        End
        Else
        Begin

          If FieldByName('CTR_DTAREC').IsNull Then
            fltToPRec := fltToPRec + 0
          Else
            fltToPRec := fltToPRec + FieldByName('CTR_VALREC').AsFloat - FieldByName('VALORI').AsFloat;

          Escrever(LinhaAtual, 13 + intCol, FloatToStrF(IfThen(FieldByName('CTR_DTAREC').IsNull, 0, FieldByName('CTR_VALREC').AsFloat - FieldByName('VALORI').AsFloat), ffNumber, 15, 2));
        End;

        Alinhamento(LinhaAtual, 13 + intCol, Direita);

        If chkImpRes.Checked Then
        Begin
          If (FieldByName('CTR_DTAREC').IsNull) And  (FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date) Then
            fltTotalReceber := fltTotalReceber + FieldByName('CTR_VALDUP').AsCurrency + IfThen(chkValCor.Checked,
                                                 fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                 FieldByName('CTR_VALDUP').AsFloat), 0)
          Else If  (FieldByName('CTR_DTAREC').IsNull) And (FieldByName('CTR_DTAVEN').AsDateTime < VS_Date) Then
            fltTotalVencido := fltTotalVencido + FieldByName('CTR_VALDUP').AsCurrency + IfThen(chkValCor.Checked,
                                                 fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                 FieldByName('CTR_VALDUP').AsFloat), 0)
          Else If Not(FieldByName('CTR_DTAREC').IsNull) Then
            fltTotalRecebido := fltTotalRecebido + FieldByName('CTR_VALREC').AsCurrency;
        End;

        {******************************************************}
        {* ALIMENTA VARIAVEIS PARA CALCULO DE MÉDIA DE ATRASO *}
        {* RQ: 32348 ***************************************BB*}
        Inc(intQtdRegParcial);
        fltCalcMedParcial := fltCalcMedParcial + FieldByName('CTR_DIAATR').AsCurrency;
        fltCalcMedGeral   := fltCalcMedGeral + FieldByName('CTR_DIAATR').AsCurrency;

        If (fEmptyStr(strDtaCad) And Not(FieldByName('DTACAD').Isnull)) Or (Not SameText(strGruCli, FieldByName('CTR_CODCLI').AsString)) Then
          strDtaCad := FormatDateTime('dd/mm/yyyy', FieldByName('DTACAD').AsDateTime);



        If (fEmptyStr(strLimite) And Not(FieldByName('LIMCRE').Isnull)) Or (Not SameText(strGruCli, FieldByName('CTR_CODCLI').AsString)) Then
          strLimite := FieldByName('LIMCRE').AsString;

        ProximaLinha;
        Next;
        {******************************************************}
        {* INSERE LIMITE CRÉDITO, MÉDIA ATRASO, DATA CADASTRO *}
        {* RQ: 30481 ***************************************BB*}
        If chkImpAdc.Checked And (Not SameText(strGruCli, FieldByName('CTR_CODCLI').AsString)
        And ((edtOrdemCli.Text = 'C') Or (edtOrdemCli.Text = 'N')) Or (Eof)) Then
        Begin
          Escrever(LinhaAtual, 01, 'LIM. CRÉDITO:');
          Mesclar('A' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 01, Esquerda);
          Negrito(LinhaAtual, 01, True);

          Escrever(LinhaAtual, 03, FloatToStrF(strToFloat(strLimite), ffNumber, 15,2));
          Alinhamento(LinhaAtual, 03, Direita);
          strLimite := '';

          Escrever(LinhaAtual, 04, 'MÉDIA ATRASO:');
          Mesclar('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 04, Esquerda);
          Negrito(LinhaAtual, 04, True);

          Escrever(LinhaAtual, 06, FloatToStrF(RoundTo(fltCalcMedParcial/intQtdRegParcial,-2), ffNumber, 15, 2));
          Mesclar('F' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 06, Direita);
          fltCalcMedParcial := 0;
          intQtdRegParcial := 0;

          Escrever(LinhaAtual, 08, 'DATA CADASTRO:');
          Mesclar('H' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 08, Esquerda);
          Negrito(LinhaAtual, 08, True);

          Escrever(LinhaAtual, 10, strDtaCad);
          Mesclar('J' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 10, Direita);
          strDtaCad := '';

          Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
          ProximaLinha;
        End;

        {*******************************************************}
        {* INSERE O TOTAL PARCIAL // MEDIA ATRASO P/ PAGAMENTO *}
        {*************************************************JB,BB*}
        {* INSERE MÉDIA DE ATRASO PARCIAL PARA ORDENAÇÃO POR CONDIÇÃO DE PAGAMENTO *BB*}
        If (Not SameText(strGruCli, FieldByName('CTR_CODCND').AsString) Or (Eof))
        And(edtOrdemCli.Text = 'P') Then
        Begin
          Escrever(LinhaAtual, 01, 'Média Atraso Parcial:');
          Mesclar('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 01, Esquerda);
          Negrito(LinhaAtual, 01, True);

          Escrever(LinhaAtual, 04, FormatCurr('#.##,##',(RoundTo(fltCalcMedParcial/intQtdRegParcial,-2))));
          Mesclar('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 04, Esquerda);
          fltCalcMedParcial := 0;
          intQtdRegParcial := 0;

          Escrever(LinhaAtual, 07, 'Total Parcial:');
          Mesclar('F' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 07, Direita);
          Negrito(LinhaAtual, 10, True);

          if blnMostraVlrBru then
          Begin
            Escrever(LinhaAtual, 11, FloatToStrF(fltToPBru, ffNumber, 15, 2));
            Alinhamento(LinhaAtual, 11, Direita);
            Negrito(LinhaAtual, 11, True);
            fltToPBru:= 0;
          End;

          Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltToPOri, ffNumber, 12, 2));
          Alinhamento(LinhaAtual, 11 + intCol, Direita);
          Negrito(LinhaAtual, 11 + intCol, True);

          Escrever(LinhaAtual, 12 + intCol, FloatToStrF(fltToPDif, ffNumber, 12, 2));
          Alinhamento(LinhaAtual, 12 + intCol, Direita);
          Negrito(LinhaAtual, 12 + intCol, True);

          Escrever(LinhaAtual,  13 + intCol, FloatToStrF(fltToPRec, ffNumber, 12, 2));
          Alinhamento(LinhaAtual, 13 + intCol, Direita);
          Negrito(LinhaAtual, 13 + intCol, True);

          Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

          ProximaLinha;

          fltToGOri := fltToGOri + fltToPOri;
          fltToGDif := fltToGDif + fltToPDif;
          fltToGRec := fltToGRec + fltToPRec;

          fltToPOri := 0;
          fltToPDif := 0;
          fltToPRec := 0;
        End
         {* INSERE MÉDIA DE ATRASO PARCIAL PARA ORDENAÇÃO POR CLIENTE *BB*}
        Else If (Not SameText(strGruCli, FieldByName('CTR_CODCLI').AsString) Or (Eof))
        And ((edtOrdemCli.Text = 'C') Or (edtOrdemCli.Text = 'N')) then
        Begin
          Escrever(LinhaAtual, 03, 'Total Parcial:');
          Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
          Alinhamento(LinhaAtual, 03, Direita);
          Negrito(LinhaAtual, 03, True);

          if blnMostraVlrBru then
          Begin
            Escrever(LinhaAtual, 11, FloatToStrF(fltToPBru, ffNumber, 15, 2));
            Alinhamento(LinhaAtual, 11, Direita);
            Negrito(LinhaAtual, 11, True);
            fltToPBru:= 0;
          End;

          Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltToPOri, ffNumber, 12, 2));
          Alinhamento(LinhaAtual, 11 + intCol, Direita);
          Negrito(LinhaAtual, 11 + intCol, True);

          Escrever(LinhaAtual, 12 + intCol, FloatToStrF(fltToPDif, ffNumber, 12, 2));
          Alinhamento(LinhaAtual, 12 + intCol, Direita);
          Negrito(LinhaAtual, 12 + intCol, True);

          Escrever(LinhaAtual,  13 + intCol, FloatToStrF(fltToPRec, ffNumber, 12, 2));
          Alinhamento(LinhaAtual, 13 + intCol, Direita);
          Negrito(LinhaAtual, 13 + intCol, True);

          Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

          ProximaLinha;

          fltToGOri := fltToGOri + fltToPOri;
          fltToGDif := fltToGDif + fltToPDif;
          fltToGRec := fltToGRec + fltToPRec;

          fltToPOri := 0;
          fltToPDif := 0;
          fltToPRec := 0;
        End;

      End;

      If (edtOrdemCli.Text = 'P') Or (chkImpadc.Checked) Then
      Begin
        Escrever(LinhaAtual, 01, 'Média Atraso Geral:');
        Mesclar('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual,01, Esquerda);
        Negrito(LinhaAtual, 01, True);

        Escrever(LinhaAtual, 04, FormatCurr('#.##,##',(RoundTo(fltCalcMedGeral/cdsRelatorio.RecordCount,-2))));
        Mesclar('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 04, Esquerda);

        Escrever(LinhaAtual, 07, 'Total Geral:');
        Mesclar('F' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 07, Direita);
        Negrito(LinhaAtual, 10, True);
      End
      Else
      Begin
        Escrever(LinhaAtual, 03, 'Total Geral:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);
        Negrito(LinhaAtual, 03, True);
      End;

      if blnMostraVlrBru then
      begin
        Escrever(LinhaAtual, 11, FloatToStrF(fltValBru, ffNumber, 15, 2));
        Alinhamento(LinhaAtual, 11, Direita);
        Negrito(LinhaAtual, 11, True);
      end;

      Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltToGOri, ffNumber, 12, 2));
      Alinhamento(LinhaAtual, 11 + intCol, Direita);
      Negrito(LinhaAtual, 11 + intCol, True);

      Escrever(LinhaAtual, 12 + intCol, FloatToStrF(fltToGDif, ffNumber, 12, 2));
      Alinhamento(LinhaAtual, 12 + intCol, Direita);
      Negrito(LinhaAtual, 12 + intCol, True);

      Escrever(LinhaAtual, 13 + intCol, FloatToStrF(fltToGRec, ffNumber, 12, 2));
      Alinhamento(LinhaAtual, 13 + intCol, Direita);
      Negrito(LinhaAtual, 13 + intCol, True);

      Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

      {**************************************}
      {* CHECA SE IMPRIME RESUMO DE VALORES *}
      {***********************************BB*}
      If chkImpRes.Checked Then
      Begin
        {* TOTAL VENCIDO *}
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Total Vencido:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);

        Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltTotalVencido, ffNumber, 12, 2));
        Mesclar('K' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 11, Direita);
        Negrito(LinhaAtual, 11, True);
        Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

        {* TOTAL A VENCER *}
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Total a Vencer:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);

        Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltTotalReceber, ffNumber, 12, 2));
        Mesclar('K' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 11, Direita);
        Negrito(LinhaAtual, 11, True);
        Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

        {* TOTAL RECEBIDO *}
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Total Recebido:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);

        Escrever(LinhaAtual, 11 + intCol, FloatToStrF(fltTotalRecebido, ffNumber, 12, 2));
        Mesclar('K' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 11, Direita);
        Negrito(LinhaAtual, 11, True);
        Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
      End;

    End;

    //CongelarPaines('A12');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

  End;

  FreeAndNil(objExcel);

  fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

End;

procedure TfrmRelCtrReceber.edtPorCliExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtPorCli,edtDesPorCli, arrPorCli, nil, fRetNomPortador, 'do Portador do Cliente');
end;

procedure TfrmRelCtrReceber.edtPorCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorCli, edtDesPorCli, nil, Key, arrPorCli, False) Then  
  Begin
    If fValidaCampos(edtPorCli, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrReceber.pMontaResumo(Var frxRel: TfrxReport);
    function fCampo(strCampo: String): TField;
    begin
      Result := cdsRelatorio.FieldByName('CTR_' + strCampo);
    end;

begin
  pZeraTotais;

  With cdsRelatorio Do
  Begin
    First;
    While Not Eof Do
    Begin

      If (fCampo('DTAVEN').AsDateTime >= VS_Date) And (fCampo('DTAREC').IsNull) Then
        pSetTotAve(fCampo('VALDUP').AsFloat + IfThen(chkValCor.Checked, fCalculaJurosCadCtr(fCampo('DTAVEN').AsDateTime, fCampo('VALDUP').AsFloat), 0));

      If (fCampo('DTAVEN').AsDateTime <  VS_Date) And (fCampo('DTAREC').IsNull) Then
        pSetTotVen(fCampo('VALDUP').AsFloat + IfThen(chkValCor.Checked, fCalculaJurosCadCtr(fCampo('DTAVEN').AsDateTime, fCampo('VALDUP').AsFloat), 0));

      If Not(fCampo('DTAREC').IsNull) Then
        pSetTotRec(fCampo('VALREC').AsFloat);

      Next;
    End;
    First;
  End;

  With frxRel.Script Do
  Begin
    Variables['TOTVEN'] := FormatFloat('#,##0.00',fltTotVen);
    Variables['TOTAVE'] := FormatFloat('#,##0.00',fltTotAve);
    Variables['TOTREC'] := FormatFloat('#,##0.00',fltTotRec);
  End;

end;

procedure TfrmRelCtrReceber.edtPorBaiExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtPorBai,edtDesporBai,arrPorBai, nil, fRetNomPortador, 'do Portador da Baixa');
end;

procedure TfrmRelCtrReceber.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorBai, edtDesPorBai, nil, Key, arrPorBai, False) Then  
  Begin
    If fValidaCampos(edtPorBai, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

End.

