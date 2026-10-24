unit untCtrAgrupDupRecibo;

interface

uses
  SysUtils, Classes, frxClass, frxDMPExport, frxDBSet, Uni, strUtils, UniClientDataSet,
  UniDataSetProvider, Vcl.Forms, frxExportPDF, untParcelamento;

type

    TArqAgrupamentos = Record
      strCliente:   string;
      strArqAnexos: string;
      strEmail:     string;
    End;
    TarrArqAgrupamentos = array of TArqAgrupamentos;

  TfrmCtrAgrupDupRecibo = class(TForm)
    frxComandos: TfrxUserDataSet;
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    frxComprovanteM: TfrxReport;
    frxComprovanteJ: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxCompMod3J: TfrxReport;
    frxCompMod3M2: TfrxReport;
    frxCadRec: TfrxDBDataset;
    frxCompMod2J: TfrxReport;
    frxCompMod2M: TfrxReport;
    frxComprovante: TfrxReport;
    frxCompMod4_40c: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDupJun: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure frxComandosGetValue(const VarName: String;
      var Value: Variant);
    function frxComprovanteMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    function frxComprovanteJUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    function frxCompMod3JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxComprovanteUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxCompMod2MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxCompMod2JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxCompMod4_40cUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }

    strTipImp: String;
    strNomImp: String;
    strCodCliBkp: String;
    intQtdRegMod3: Integer;

    FListaNumAgr,
    FListaEmpAgr,
    FListaCodCli : TStringList;

    function fLoadReport : Boolean;
    function fVerificaComponenteRelExiste(strComponente,
                                          strInformacao : String;
                                          blnVisible: Boolean = True) : Boolean;

    function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;
    function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp : String): String;
    function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;
    function fMontaDataVenctoAgr(strNumDoc, strEspDoc, strCodEmp: String): String;


    function fGetSql(strNumAgr : String; stlNumAgr, stlEmpAgr,stlCodCli : TStringList; FCodCli : String = ''; FCodEmp : String = '') : String;
    procedure pImprimeComprovanteInterna(strNomForm, strSQL: String; intQtdImp: Integer; strNumAgr: String = ''; blnPDF: Boolean = false);
    procedure pCarregaVariaveisModelo2_3(strCodCli, strCodEmp: String; frxRel: TfrxReport);
    function fCarregaDuplicatasCadRec(strNumDup, strCodEmp, strCodCli: String): String;
    function fCarregaDocAgr(strNumAgr, strEmpAgr, strCodCli: String): String;
    function fRetQtdReg: Integer;
    function fRetornaComprovanteCustomizado: String;

    function RetornaValorMultaParcelamento(ADataset: TUniClientDataset): Double;
  public
    blnVariosAgrupamentos: Boolean;
    strEmailCli: string;
    stlArqAgrupamentos: TStringList;
    blnImprimePorNomCli: Boolean;

    arrArqAgrupamentos: TarrArqAgrupamentos;

    objParcelamento: TParcelamento;

    function fTamanhoArrAgrupamento(i: integer): boolean;
    procedure pImprimeComprovante(strNumAgr, strNomForm: String; intQtdImp: Integer = 1; blnPDF: Boolean = false; strCodCli : String = ''; strCodEmp : String = '');overload;
    procedure pImprimeComprovante(strNumAgr, strNomForm: String; stlNumAgr, stlEmpAgr, stlCodCli: TStringList; intQtdImp: Integer = 1; blnPDF: Boolean = false);overload;

    { Public declarations }
  end;

var
  frmCtrAgrupDupRecibo: TfrmCtrAgrupDupRecibo;

implementation

uses untFuncoesSimples, untCfgRel, untFuncoesGenerica, untValorPorExtenso, Data.DB;

{$R *.dfm}

procedure TfrmCtrAgrupDupRecibo.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  frxComprovanteM.AddFunction('function fFormataCondPag(strCond: String): String');
  frxComprovanteJ.AddFunction('function fFormataCondPag(strCond: String): String');
  frxComprovanteM.AddFunction('function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;');
  frxComprovanteJ.AddFunction('function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;');
  frxComprovanteM.AddFunction('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');
  frxComprovanteJ.AddFunction('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');
  frxComprovanteJ.AddFunction('function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;');
  frxComprovanteJ.AddFunction('function fMontaDataVenctoAgr(strNumDoc, strEspDoc, strCodEmp: String): String;');

  frxComprovante.AddFunction('function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;');
  frxComprovante.AddFunction('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');
  frxComprovante.AddFunction('function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;');

  frxComprovanteM.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
  frxComprovanteJ.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');

  frxCompMod2M.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
  frxCompMod2J.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
  frxCompMod2J.AddFunction('function fFormataCondPag(strCond: String): String');
  frxCompMod2J.AddFunction('function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;');
  frxCompMod2J.AddFunction('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');

   frxCompMod3M2.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
   frxCompMod3J.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
   frxCompMod3J.AddFunction('function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;');
   frxCompMod3J.AddFunction('function fMontaDataVenctoAgr(strNumDoc, strEspDoc, strCodEmp: String): String;');
   frxCompMod3J.AddFunction('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');

   frxCompMod4_40c.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
   frxCompMod4_40c.AddFunction('function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;');
   frxCompMod4_40c.AddFunction('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');
   frxCompMod4_40c.AddFunction('function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;');

  If fCfgSis('MODAGR', varInteger) = 3 Then
  Begin
    frxCompMod3M2.AddFunction('function fRetQtdReg: Integer');
    frxCompMod3J.AddFunction('function fRetQtdReg: Integer');
  End;

  frxComprovanteJ.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);
  frxCompMod2J.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);
  frxCompMod3J.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);

  frxComprovanteM.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);
  frxCompMod2M.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);
  frxCompMod3M2.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);

end;

procedure TfrmCtrAgrupDupRecibo.pImprimeComprovante(strNumAgr, strNomForm: String; intQtdImp: Integer = 1; blnPDF: Boolean = false; strCodCli : String = ''; strCodEmp : String = '');
begin
  pImprimeComprovanteInterna(strNomForm, fGetSql(strNumAgr, Nil, Nil,Nil,strCodCli,strCodEmp), intQtdImp, strNumAgr, blnPDF);
end;

procedure TfrmCtrAgrupDupRecibo.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)

  Else If VarName = 'REL_NOMREL' Then
    Value := 'COMPROVANTE - DUPLICATAS AGRUPADAS'

  Else If VarName = 'REL_TITREL' then
    Value := 'COMPROVANTE - DUPLICATAS AGRUPADAS';
end;

function TfrmCtrAgrupDupRecibo.fVerificaComponenteRelExiste(strComponente,
                                                            strInformacao: String;
                                                            blnVisible : Boolean = True): Boolean;
begin
  Result := False;

  If fCfgSis('MODAGR', varInteger) = 1 Then
  Begin
    If (strTipImp = 'M') Then
    Begin
      If Assigned(frxComprovanteM.FindObject(strComponente)) Then
      Begin
        TfrxMemoView(frxComprovanteM.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
    End
    Else
    Begin
      If Assigned(frxComprovanteJ.FindObject(strComponente)) Then
      Begin
        TfrxMemoView(frxComprovanteJ.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
    End;
  End


  Else If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    If (strTipImp = 'M') Then
    Begin
      If Assigned(frxCompMod2M.FindObject(strComponente)) Then
      Begin
        TfrxMemoView(frxCompMod2M.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
    End
    Else
    Begin
      If Assigned(frxCompMod2J.FindObject(strComponente)) Then
      Begin
        TfrxMemoView(frxCompMod2J.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
    End;
  End


  Else If fCfgSis('MODAGR', varInteger) = 3 Then
  Begin
    If (strTipImp = 'M') Then
    Begin
      If Assigned(frxCompMod3M2.FindObject(strComponente)) Then
      Begin
        TfrxMemoView(frxCompMod3M2.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
    End
    Else
    Begin
      If Assigned(frxCompMod3J.FindObject(strComponente)) Then
      Begin
        If strInformacao = 'Visible' Then
        Begin
          frxCompMod3J.FindObject(strComponente).Visible := blnVisible;
        End
        Else
          TfrxMemoView(frxCompMod3J.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
    End;
  End

  Else If fCfgSis('MODAGR', varInteger) = 4 Then
  Begin
      If Assigned(frxCompMod4_40c.FindObject(strComponente)) Then
      Begin
        TfrxMemoView(frxCompMod4_40c.FindObject(strComponente)).Memo.Text := strInformacao;
        Result:= True;
      End;
  End;
end;

procedure TfrmCtrAgrupDupRecibo.pCarregaVariaveisModelo2_3(strCodCli,
  strCodEmp: String; frxRel: TfrxReport);
  Var
    strSQL : String;
    qryCab : TUniQuery;

begin

  qryCab := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT                                                ';
  strSQL := strSQL + '   EMP_NOMEMP,                                         ';
  strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM) AS EMP_ENDERE, ';
  strSQL := strSQL + '   EMP_BAIRRO,                                         ';
  strSQL := strSQL + '   EMP_C_E_P_,                                         ';
  strSQL := strSQL + '   EMP_FONE01,                                         ';
  strSQL := strSQL + '   EMP_C_G_C_,                                         ';
  strSQL := strSQL + '   EMP_I_E_S_,                                         ';
  strSQL := strSQL + '   CID_NOMCID AS EMP_CIDEMP,                           ';
  strSQL := strSQL + '   CID_ESTADO AS EMP_ESTEMP                            ';
  strSQL := strSQL + ' FROM                                                  ';
  strSQL := strSQL + '   CADEMP                                              ';
  strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = EMP_CODCID              ';
  strSQL := strSQL + ' WHERE                                                 ';
  strSQL := strSQL + '   EMP_CODEMP = :CODEMP                                ';

  With qryCab Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    frxRel.Script.Variables['NOMEMP'] := FieldByName('EMP_NOMEMP').AsString;
    frxRel.Script.Variables['ENDEMP'] := FieldByName('EMP_ENDERE').AsString;
    frxRel.Script.Variables['CIDEMP'] := FieldByName('EMP_CIDEMP').AsString;
    frxRel.Script.Variables['BAIEMP'] := FieldByName('EMP_BAIRRO').AsString;
    frxRel.Script.Variables['ESTEMP'] := FieldByName('EMP_ESTEMP').AsString;
    frxRel.Script.Variables['TELEMP'] := fFormataFone(FieldByName('EMP_FONE01').AsString);
    frxRel.Script.Variables['CEPEMP'] := fFormataCEP(fTiraCaracEspeciais(FieldByName('EMP_C_E_P_').AsString));
    frxRel.Script.Variables['IESEMP'] := FieldByName('EMP_I_E_S_').AsString;
    frxRel.Script.Variables['CGCEMP'] := fFormataCpfCgc(FieldByName('EMP_C_G_C_').AsString, fSetaPais);
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT                                                                   ';
  strSQL := strSQL + '   CLI_NOMCLI,                                                            ';
  strSQL := strSQL + '   CLI_FANSOB,                                                            ';
  strSQL := strSQL + '   IF(IFNULL(CLI_ENDCOB, "") = "", CONCAT(CLI_ENDERE, ", ", CLI_ENDNUM, " ", IF(IFNULL(CLI_ENDCOM, "") = "", "", CLI_ENDCOM)), CLI_ENDCOB) AS CLI_ENDERE, ';
  strSQL := strSQL + '   IF(IFNULL(CLI_BAICOB, "") = "", CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
  strSQL := strSQL + '   IF(IFNULL(CLI_CEPCOB, "") = "", CLI_C_E_P_, CLI_CEPCOB) AS CLI_C_E_P_, ';
  strSQL := strSQL + '   IF(IFNULL(CLI_TELCOB, "") = "", CLI_FONE01, CLI_TELCOB) AS CLI_TELCLI, ';
  strSQL := strSQL + '   CLI_C_G_C_,                                                            ';
  strSQL := strSQL + '   CLI_I_E_S_,                                                            ';
  strSQL := strSQL + '   CID_NOMCID AS CLI_CIDCLI,                                              ';
  strSQL := strSQL + '   CID_ESTADO AS CLI_ESTCLI                                               ';
  strSQL := strSQL + ' FROM                                                                     ';
  strSQL := strSQL + '   CADCLI                                                                 ';
  strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = CLI_CODCID                                 ';
  strSQL := strSQL + ' WHERE                                                                    ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI                                                   ';

  With qryCab Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    frxRel.Script.Variables['NOMCLI'] := strCodCli + ' - ' + FieldByName('CLI_NOMCLI').AsString;
    frxRel.Script.Variables['NOMFAN'] := FieldByName('CLI_FANSOB').AsString;
    frxRel.Script.Variables['ENDCLI'] := FieldByName('CLI_ENDERE').AsString;
    frxRel.Script.Variables['CIDCLI'] := FieldByName('CLI_CIDCLI').AsString;
    frxRel.Script.Variables['BAICLI'] := FieldByName('CLI_BAIRRO').AsString;
    frxRel.Script.Variables['ESTCLI'] := FieldByName('CLI_ESTCLI').AsString;
    frxRel.Script.Variables['TELCLI'] := fFormataFone(FieldByName('CLI_TELCLI').AsString);
    frxRel.Script.Variables['CEPCLI'] := fFormataCEP(fTiraCaracEspeciais(FieldByName('CLI_C_E_P_').AsString));
    frxRel.Script.Variables['IESCLI'] := FieldByName('CLI_I_E_S_').AsString;
    frxRel.Script.Variables['CGCCLI'] := fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, fSetaPais);
  End;

  frxRel.Script.Variables['DTAEMI']     := FormatDateTime('dd/mm/yyyy', VS_Date);
  //frxRel.Script.Variables['CFG_COMAGR'] := fCfgSis('COMAGR', varString);

  FreeAndNil(qryCab);

end;

procedure TfrmCtrAgrupDupRecibo.pImprimeComprovante(strNumAgr, strNomForm: String; stlNumAgr,
  stlEmpAgr, stlCodCli: TStringList; intQtdImp: Integer; blnPDF: Boolean);
begin
  FListaNumAgr := stlNumAgr;
  FListaEmpAgr := stlEmpAgr;
  FListaCodCli := stlCodCli;

  pImprimeComprovanteInterna(strNomForm, fGetSql('', stlNumAgr, stlEmpAgr,stlCodCli), intQtdImp, strNumAgr, blnPDF);
end;

procedure TfrmCtrAgrupDupRecibo.pImprimeComprovanteInterna(strNomForm, strSQL: String;
  intQtdImp: Integer; strNumAgr: String = ''; blnPDF: Boolean = false);
  Var
    qryGenRec: TUniQuery;
    qrySubRec: TUniQuery;
    qryJunRec: TUniQuery;
    frxRelGen: TfrxReport;
    qryCfgRel: TUniQuery;
    fltTotGer: Double;
    fltValDup: Double;
    fltJurTmp: Double;
    fltJurTot: Double;
    fltValDes: Double;
    fltTaxJurAgr: Double;
    cdsGenRec: TUniClientDataSet;
    dspGenRec: TUniDataSetProvider;
    strComprovante: String;
    blnComprovanteCustomizavel: Boolean;
    intCont  : integer;
    blnTemCli: boolean;
    LUsaLayImp: Boolean;
begin
  qryGenRec := fCriaQuery;
  cdsGenRec := TUniClientDataSet.Create(Self);
  dspGenRec := TUniDataSetProvider.Create(Self);
  dspGenRec.DataSet := qryGenRec;
  cdsGenRec.SetProvider(dspGenRec);
  fltJurTot := 0;

  if not assigned(arrArqAgrupamentos) then
     setLength(arrArqAgrupamentos,1);

  frxRelGen := nil;
  fltTotGer := 0.0;
  fltTaxJurAgr := fCfgSis('JURAGR', varDouble);

  {*******************************************}
  {* PEGA O TIPO DE IMPRESSÃO E A IMPRESSORA *}
  {****************************************JB*}
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, strNomForm);
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  If not blnPDF then
     fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

  If(strTipImp = 'M') Then
  Begin
    If Not TCfgRel.IsPrinterMatrix(strNomImp) Then
      strTipImp := 'J';
  End;

  //fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);
  FreeAndNil(qryCfgRel);

  qryGenRec.Close;
  qryGenRec.SQL.Clear;
  qryGenRec.SQL.Add(strSQL);
  qryGenRec.Open;
  pSetaClient(qryGenRec);

  If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    qrySubRec := fCriaQuery(Nil);

    With qrySubRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fCarregaDuplicatasCadRec(strNumAgr,
                                       Trim(LeftStr(qryGenRec.FieldByName('NOMEMP').AsString, 03)),
                                       Trim(LeftStr(qryGenRec.FieldByName('NOMCLI').AsString, 08))));
      Open;
      First;

      fltTotGer := 0;
      While Not Eof Do
      Begin
        fltTotGer := fltTotGer + FieldByName('VALDUP').AsFloat;
        Next;
      End;
    End;

    frxCadRec.DataSet := qrySubRec;

    qryJunRec := fCriaQuery(Nil);

    With qryJunRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fCarregaDocAgr(strNumAgr,
                             Trim(LeftStr(qryGenRec.FieldByName('NOMEMP').AsString, 03)),
                             Trim(LeftStr(qryGenRec.FieldByName('NOMCLI').AsString, 08))));
      Open;
      First;
    End;

    frxDupJun.DataSet := qryJunRec;

  End;

  cdsGenRec.Open;

  cdsGenRec.DisableControls;
  cdsGenRec.First;

  While Not cdsGenRec.Eof Do
  Begin

    If fCfgSis('UTDEFN') = '2' Then
    Begin
      If cdsGenRec.FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date Then
        fltValDes := cdsGenRec.FieldByName('CTR_DESSUJ').AsFloat
      Else
        fltValDes := 0;
    End
    Else
      fltValDes := cdsGenRec.FieldByName('CTR_DESSUJ').AsFloat;

    fltValDup := cdsGenRec.FieldByName('CTR_VALDUP').AsFloat +
                 cdsGenRec.FieldByName('CTR_JURSUJ').AsFloat +
                 cdsGenRec.FieldByName('CTR_DESCOB').AsFloat -
                 fltValDes;


    if cdsGenRec.FieldByName('CTR_VALJUR').AsFloat  = 0 then
    begin
      fltJurTmp := fCalculaJurosCadCtr(cdsGenRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                       fltValDup,
                                       fltTaxJurAgr,
                                       0,
                                       0)
    end
    else
      fltJurTmp := cdsGenRec.FieldByName('CTR_VALJUR').AsFloat;

    fltJurTmp := fltJurTmp + RetornaValorMultaParcelamento(cdsGenRec);

    fltJurTot := fltJurTot + fltJurTmp;
    cdsGenRec.Edit;
    cdsGenRec.FieldByName('CTR_VALDUP').AsFloat := fltValDup + fltJurTmp;
    cdsGenRec.FieldByName('CTR_TOTJUR').AsFloat := fltJurTot;
    cdsGenRec.FieldByName('CTR_VALJUR').AsFloat := fltJurTmp;

    cdsGenRec.Post;

    cdsGenRec.Next;
  End;

  cdsGenRec.First;
  cdsGenRec.EnableControls;

  {************************************}
  {* LIGA A QRY NO RELATORIO          *}
  {*********************************JB*}
  frxRelatorio.DataSet := cdsGenRec;

  {************************************}
  {* DEFINE O TIPO DE IMPRESSAO       *}
  {*********************************JB*}

  strComprovante := fRetornaComprovanteCustomizado;
  LUsaLayImp := fLoadReport;
  blnComprovanteCustomizavel := Not(LUsaLayImp) And (Not fEmptyStr(strComprovante));

  If blnComprovanteCustomizavel Then
  Begin
    frxComprovante.LoadFromFile(strComprovante);
    frxRelGen := frxComprovante;
  End
  Else
  If fCfgSis('MODAGR', varInteger) = 1 Then
  Begin
    If strTipImp = 'J' Then
      frxRelGen := frxComprovanteJ
    Else
      frxRelGen := frxComprovanteM;

    pCarregaVariaveisModelo2_3(Trim(LeftStr(qryGenRec.FieldByName('NOMCLI').AsString, 08)),
                               Trim(LeftStr(qryGenRec.FieldByName('NOMEMP').AsString, 03)),
                               frxRelGen);

  End
  Else If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin

    If strTipImp = 'J' Then
    Begin
      frxRelGen := frxCompMod2J;
      If Not LUsaLayImp Then
      Begin
        frxRelGen.DotMatrixReport           := False;
        frxRelGen.PrintOptions.PrintMode    := pmScale;
        frxRelGen.PrintOptions.PrintOnSheet := 9; //A4
      End;
    End
    Else
    Begin
      frxDotMatrixExport1.PageBreaks := True;
      frxRelGen := frxCompMod2M;
    End;

    pCarregaVariaveisModelo2_3(Trim(LeftStr(qryGenRec.FieldByName('NOMCLI').AsString, 08)),
                               Trim(LeftStr(qryGenRec.FieldByName('NOMEMP').AsString, 03)),
                               frxRelGen);

    frxRelGen.Script.Variables['TOTGER'] := FormatFloat('#,##0.00', fltTotGer);
    frxRelGen.Script.Variables['NUMAGR'] := strNumAgr;
    frxRelGen.Script.Variables['VALEXT'] := fRetExtensoNumero(FormatFloat('#,##0.00', fltTotGer));
  End
  Else If fCfgSis('MODAGR', varInteger) = 3 Then
  Begin
    If strTipImp = 'J' Then
      frxRelGen := frxCompMod3J
    Else
      frxRelGen := frxCompMod3M2;

    pCarregaVariaveisModelo2_3(Trim(LeftStr(qryGenRec.FieldByName('NOMCLI').AsString, 08)),
                               Trim(LeftStr(qryGenRec.FieldByName('NOMEMP').AsString, 03)),
                               frxRelGen);

    frxRelGen.Script.Variables['MSGAGR'] := qryGenRec.FieldByName('CTR_HIST01').AsString + ' ' + qryGenRec.FieldByName('CTR_HIST02').AsString;
    frxRelGen.Script.Variables['QTDREG'] := IntToStr(qryGenRec.RecordCount);
    frxRelGen.Script.Variables['DTAEXT'] := fRetDataExtenso(VS_Date, True);

    intQtdRegMod3 := qryGenRec.RecordCount;
  End
  Else If fCfgSis('MODAGR', varInteger) = 4 Then
  Begin
    frxRelGen := frxCompMod4_40c;

    If strTipImp = 'J' Then
    Begin
      If Not LUsaLayImp Then
      Begin
        frxRelGen.DotMatrixReport           := False;
        frxRelGen.PrintOptions.PrintMode    := pmScale;
      End;
    End
    Else
    Begin
      frxDotMatrixExport1.PageBreaks := True;
    End;
  End;

  {************************************}
  {* PASSA OS DADOS DO CABEÇALHO      *}
  {*********************************JB*}
  If Not fEmptyStr(strNomImp) Then
  Begin
    frxRelGen.PrintOptions.ShowDialog    := False;
    frxRelGen.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
  End
  Else
    frxRelGen.PrintOptions.ShowDialog    := True;
  frxRelGen.PrintOptions.Copies        := intQtdImp;

  With qryGenRec Do
  Begin

    If (Not IsEmpty) Then
    Begin

      If blnPdf Then
      Begin
        If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'AgrupDuplicatas') Then
          CreateDir(ExtractFilePath(Application.ExeName) + 'AgrupDuplicatas');

        //frxBanco.PrepareReport;
        frxPDFExport.FileName    := qryGenRec.FieldByName('NUMAGR').AsString + '_' + qryGenRec.FieldByName('CLI_CODCLI').AsString + '.pdf';
        frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + 'AgrupDuplicatas';
        frxPDFExport.ShowDialog := False;
        frxPDFExport.ShowProgress := False;
        //frxBanco.Export(frxPDFExport);

        //*********

        //DESTINATARIO(S)
        If (fCfgSis('GPEMCB', VarBoolean)) Then
        Begin
          strEmailCli := '';

          If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMCOB1').AsString) Then
            strEmailCli := qryGenRec.FieldByName('CLI_EMCOB1').AsString;

          If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMCOB2').AsString) Then
          Begin
            If fEmptyStr(strEmailCli) Then
              strEmailCli := qryGenRec.FieldByName('CLI_EMCOB2').AsString
            Else
              strEmailCli := strEmailCli + '; ' + qryGenRec.FieldByName('CLI_EMCOB2').AsString;
          End;

          If fEmptyStr(strEmailCli) Then
          Begin
            If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMAIL_').AsString) Then
              strEmailCli := qryGenRec.FieldByName('CLI_EMAIL_').AsString
            Else If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMAIL2').AsString) Then
              strEmailCli := qryGenRec.FieldByName('CLI_EMAIL2').AsString;
          End;
        End
        Else
        Begin
          If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMCOB1').AsString) Then
            strEmailCli := qryGenRec.FieldByName('CLI_EMCOB1').AsString
          Else If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMCOB2').AsString) Then
            strEmailCli := qryGenRec.FieldByName('CLI_EMCOB2').AsString
          Else If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMAIL_').AsString) Then
            strEmailCli := qryGenRec.FieldByName('CLI_EMAIL_').AsString
          Else If Not fEmptyStr(qryGenRec.FieldByName('CLI_EMAIL2').AsString) Then
            strEmailCli := qryGenRec.FieldByName('CLI_EMAIL2').AsString
          Else
            strEmailCli := '';
        End;

        If (Not fEmptyStr(qryGenRec.FieldByName('CLI_EMAIL3').AsString)) Then Begin
          If (Not fEmptyStr(strEmailCli)) Then
            strEmailCli := strEmailCli + '; ' + qryGenRec.FieldByName('CLI_EMAIL3').AsString
          Else
            strEmailCli := qryGenRec.FieldByName('CLI_EMAIL3').AsString;
        End;

        strEmailCli := AnsiReplaceStr(strEmailCli, ';;', ';');
      End;

      If blnComprovanteCustomizavel Then
      Begin
         If frxComprovante.PrepareReport Then
         Begin
            if blnPdf then
               frxComprovante.Export(frxPDFExport)
           else
              pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxComprovante);
        End;

      End
      Else
      If fCfgSis('MODAGR', varInteger) = 1 Then
      Begin
        If (strTipImp = 'M') Then
        Begin
          If frxComprovanteM.PrepareReport Then
          Begin
             If blnPdf then
                frxComprovanteM.Export(frxPDFExport)
             Else
                pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxComprovanteM);
          End;
        End
        Else
        Begin
          If frxComprovanteJ.PrepareReport Then
          Begin
             If blnPdf then
                frxComprovanteJ.Export(frxPDFExport)
             Else
                pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxComprovanteJ);
          End;
        End;
      End
      Else If fCfgSis('MODAGR', varInteger) = 2 Then
      Begin
        If (strTipImp = 'M') Then
        Begin
          If frxCompMod2M.PrepareReport Then
          Begin
             If blnPdf then
                frxCompMod2M.Export(frxPDFExport)
             Else
                pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxCompMod2M);
          End;
        End
        Else
        Begin
          If frxCompMod2J.PrepareReport Then
          Begin
             If blnPdf then
                frxCompMod2J.Export(frxPDFExport)
             Else
                pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxCompMod2J);
          End;
        End;

        FreeAndNil(qrySubRec);
      End
      Else If fCfgSis('MODAGR', varInteger) = 3 Then
      Begin
        If (strTipImp = 'M') Then
        Begin
          If frxCompMod3M2.PrepareReport Then
          Begin
             If blnPdf then
                frxCompMod3M2.Export(frxPDFExport)
             Else
                pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxCompMod3M2);
          End;
        End
        Else
        Begin
          If frxCompMod3J.PrepareReport Then
          Begin
             If blnPdf then
                frxCompMod3J.Export(frxPDFExport)
             Else
                pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxCompMod3J);
          End;
        End;
      End
      Else If fCfgSis('MODAGR', varInteger) = 4 Then
      Begin
        frxCadRec.DataSet := cdsGenRec;
        If frxCompMod4_40c.PrepareReport Then
          Begin
             If blnPdf then
                frxCompMod4_40c.Export(frxPDFExport)
             Else
               pPrintReport(strNomForm, 'Agrupamento de contas a Receber (Recibo)', strNomImp, frxCompMod4_40c);
          End;
      End;

      if blnPdf then
      begin
        blnTemCli := false;
        for intCont := low(arrArqAgrupamentos) to  high(arrArqAgrupamentos) do
        begin
          if arrArqAgrupamentos[intCont].strCliente = qryGenRec.FieldByName('CLI_CODCLI').AsString then
          begin
            arrArqAgrupamentos[intCont].strArqAnexos := arrArqAgrupamentos[intCont].strArqAnexos+frxPDFExport.FileName+',';
            blnTemCli := true;
            break;
          end;
        end;
        if not blnTemCli then
        begin
          intCont := intCont - 1;
          if arrArqAgrupamentos[intCont].strCliente <> '' then
          begin
            setLength(arrArqAgrupamentos,length(arrArqAgrupamentos)+1);
            intCont := high(arrArqAgrupamentos);
          end;
          arrArqAgrupamentos[intCont].strCliente   := qryGenRec.FieldByName('CLI_CODCLI').AsString;
          arrArqAgrupamentos[intCont].strArqAnexos := frxPDFExport.FileName+',';
          arrArqAgrupamentos[intCont].strEmail     := strEmailCli;
        end;
        strArqBoletos := strArqBoletos + frxPDFExport.FileName+',';
      end;

    End;

  End;

  If blnComprovanteCustomizavel Then
     FreeAndNil(frxComprovante);

  FreeAndNil(qryGenRec);

end;

function TfrmCtrAgrupDupRecibo.RetornaValorMultaParcelamento(ADataset: TUniClientDataset): Double;
  Var
    LContador: Integer;
begin
  Result := 0.00;

  If Not Assigned(objParcelamento) Then
    Exit;

  For LContador := 0 To Length(objParcelamento.ArrayDocsAgrupar) - 1 Do
  Begin
    If Concat(ADataset.FieldByName('CTR_NUMDUP').AsString,
              ADataset.FieldByName('CTR_PARCEL').AsString,
              ADataset.FieldByName('CTR_ESPDOC').AsString,
              ADataset.FieldByName('CTR_CODEMP').AsString,
              ADataset.FieldByName('CLI_CODCLI').AsString)
       .Equals(Concat(objParcelamento.ArrayDocsAgrupar[LContador].strNumDoc,
                      objParcelamento.ArrayDocsAgrupar[LContador].strParcel,
                      objParcelamento.ArrayDocsAgrupar[LContador].strEspdoc,
                      objParcelamento.ArrayDocsAgrupar[LContador].strCodEmp,
                      objParcelamento.ArrayDocsAgrupar[LContador].strCodCli)) Then
    Begin
      Result := fFormataFloat(objParcelamento.ArrayDocsAgrupar[LContador].fltValMul, 2);
      Break;
    End;
  End;
end;

function TfrmCtrAgrupDupRecibo.fLoadReport : Boolean;
 Var
   mmsLoad: TStream;
   FLayImp: TUniQuery;
Begin
  Result := False;
  FLayImp:= fCriaQuery(nil);
  Try
    With FLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'AGCTR'+IntToStr(fCfgSis('MODAGR', varInteger));

      If(strTipImp = 'M') Then
        ParamByName('TIPLAY').AsString := 'M'
      Else
        ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
        If fCfgSis('MODAGR', varInteger) = 1 Then
        Begin
          If (strTipImp = 'M') Then
          Begin
            frxComprovanteM.LoadFromStream(mmsLoad);
            frxComprovanteM.Variables.Clear;
          End
          Else
          Begin
            frxComprovanteJ.LoadFromStream(mmsLoad);
            frxComprovanteJ.Variables.Clear;
          End;
        End
        Else If fCfgSis('MODAGR', varInteger) = 2 Then
        Begin
          If (strTipImp = 'M') Then
          Begin
            frxCompMod2M.LoadFromStream(mmsLoad);
            frxCompMod2M.Variables.Clear;
          End
          Else
          Begin
            frxCompMod2J.LoadFromStream(mmsLoad);
            frxCompMod2J.Variables.Clear;
          End;;
        End
        Else If fCfgSis('MODAGR', varInteger) = 3 Then
        Begin
          If (strTipImp = 'M') Then
          Begin
            frxCompMod3M2.LoadFromStream(mmsLoad);
            frxCompMod3M2.Variables.Clear;
          End
          Else
          Begin
            frxCompMod3J.LoadFromStream(mmsLoad);
            frxCompMod3J.Variables.Clear;
          End;
        End
        Else If fCfgSis('MODAGR', varInteger) = 4 Then
        Begin
          frxCompMod4_40c.LoadFromStream(mmsLoad);
          frxCompMod4_40c.Variables.Clear;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;
  FreeAndNil(mmsLoad);
  FreeAndNil(FLayImp);
End;

procedure TfrmCtrAgrupDupRecibo.frxComandosGetValue(const VarName: String;
  var Value: Variant);
begin

  {****************************}
  {* ESPAÇAMENTO ENTRE LINHAS *}
  {*************************JB*}
  If VarName = 'UM_OITAVO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#270'

    Else
      Value := '';

  End

  Else If VarName = 'UM_OITAVO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#272'

    Else
      Value := '';

  End

  {***********}
  {* NEGRITO *}
  {********JB*}
  Else If VarName = 'NEGRITO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#69'

    Else
      Value := '';

  End

  Else If VarName = 'NEGRITO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#70'

    Else
      Value := '';

  End

  {*************}
  {* EXPANDIDO *}
  {**********JB*}
  Else If VarName = 'EXPANDIDO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#871'

    Else
      Value := '';

  End

  Else If VarName = 'EXPANDIDO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#870'

    Else
      Value := '';

  End

  {*************}
  {* ITÁLICO   *}
  {**********JB*}
  Else If VarName = 'ITALICO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#274'

    Else
      Value := '';

  End

  Else If VarName = 'ITALICO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#275'

    Else
      Value := '';

  End

  {*************************}
  {* CONDENSADO PARA 10CPI *}
  {**********************JB*}
  Else If VarName = 'COND_10CPI_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#15#27#80'

    Else
      Value := '';

  End

  Else If VarName = 'COND_10CPI_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#18#27#80'

    Else
      Value := '';

  End

  {*************************}
  {* CONDENSADO PARA 12CPI *}
  {**********************JB*}
  Else If VarName = 'COND_12CPI_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#15#27#77'

    Else
      Value := '';

  End

  Else If VarName = 'COND_12CPI_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#18#27#77'

    Else
      Value := '';

  End

  {**************************************}
  {* RESETA                             *}
  {***********************************JB*}
  Else If VarName = 'RESETA' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#64#18#27#80'

    Else
      Value := '';

  End;

end;

function TfrmCtrAgrupDupRecibo.frxComprovanteMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := fFormataCondPag(Params[0])

  Else If MethodName = 'FMONTAVENCIMENTOS' Then
    Result := fMontaVencimentos(Params[0],Params[1],Params[2]);

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);

  If MethodName = 'FRETORNAPARCELASAGRUPAMENTO' Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);

end;

function TfrmCtrAgrupDupRecibo.frxComprovanteUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FMONTAVENCIMENTOS' Then
    Result := fMontaVencimentos(Params[0],Params[1],Params[2])
  Else If MethodName = 'FMONTAEMISSAO' Then
    Result := fMontaEmissao(Params[0],Params[1],Params[2]);

  If MethodName = 'FRETORNAPARCELASAGRUPAMENTO' Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);
end;

function TfrmCtrAgrupDupRecibo.frxCompMod2JUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);
  If MethodName = 'FFORMATACONDPAG' Then
    Result := fFormataCondPag(Params[0])
  Else If MethodName = 'FMONTAVENCIMENTOS' Then
    Result := fMontaVencimentos(Params[0],Params[1],Params[2]);

  If MethodName = 'FRETORNAPARCELASAGRUPAMENTO' Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);
end;

function TfrmCtrAgrupDupRecibo.frxCompMod2MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);
end;

function TfrmCtrAgrupDupRecibo.frxCompMod3JUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FRETQTDREG' Then
    Result := fRetQtdReg;

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);

  If MethodName = 'FMONTAEMISSAO' Then
    Result := fMontaEmissao(Params[0],Params[1],Params[2]);

  If MethodName = 'FMONTADATAVENCTOAGR' Then
    Result := fMontaDataVenctoAgr(Params[0],Params[1],Params[2]);

  If MethodName = 'FRETORNAPARCELASAGRUPAMENTO' Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);

end;

function TfrmCtrAgrupDupRecibo.frxCompMod4_40cUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FMONTAVENCIMENTOS' Then
    Result := fMontaVencimentos(Params[0],Params[1],Params[2])
  Else
  If MethodName = 'FMONTAEMISSAO' Then
    Result := fMontaEmissao(Params[0],Params[1],Params[2])
  Else
  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);

  If MethodName = 'FRETORNAPARCELASAGRUPAMENTO' Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);
end;

function TfrmCtrAgrupDupRecibo.frxComprovanteJUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := fFormataCondPag(Params[0])

  Else If MethodName = 'FMONTAVENCIMENTOS' Then
    Result := fMontaVencimentos(Params[0],Params[1],Params[2]);

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);

  If MethodName = 'FMONTAEMISSAO' Then
    Result := fMontaEmissao(Params[0],Params[1],Params[2]);

  If MethodName = 'FMONTADATAVENCTOAGR' Then
    Result := fMontaDataVenctoAgr(Params[0],Params[1],Params[2]);

  If MethodName = 'FRETORNAPARCELASAGRUPAMENTO' Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);

end;

function TfrmCtrAgrupDupRecibo.fCarregaDocAgr(strNumAgr,
  strEmpAgr, strCodCli: String): String;
Var
    strSQL : String;
    intContador: Integer;
begin

  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CONCAT(CTR_NUMDUP,"-",CTR_ESPDOC,"-",CTR_CODEMP) AS DUPAGR, ';
  strSQL := strSQL + '   SUM(CTR_VALDUP) AS VALJUN, ';
  strSQL := strSQL + '   CTR_DTACAD AS DTACAD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   DUPAGR ';
  strSQL := strSQL + ' WHERE ';

  If Assigned(FListaNumAgr) And
     Assigned(FListaEmpAgr) And
     Assigned(FListaCodCli) Then
  Begin
    If FListaNumAgr.Count > 1 Then
      strSQL := strSQL + ' ( ';

    For intContador := 0 To FListaNumAgr.Count -1 do
    Begin
      strSQL := strSQL + ' ( CTR_NUMAGR = ' + QuotedStr(FListaNumAgr[intcontador]) + ' AND';
      strSQL := strSQL + '   CTR_EMPAGR = ' + QuotedStr(FListaEmpAgr[intcontador]) + ' AND';
      strSQL := strSQL + '   CTR_CODCLI = ' + QuotedStr(FListaCodCli[intcontador]) + ') ';

      If (intContador < FListaNumAgr.Count -1) Then
        strSQL := strSQL + ' OR ';
    End;

    If FListaNumAgr.Count > 1 Then
      strSQL := strSQL + ' ) ';

  End
  Else
  Begin
    strSQL := strSQL + '   CTR_NUMAGR IN (' + strNumAgr + ')';
    strSQL := strSQL + '   AND CTR_EMPAGR = ' + QuotedStr(strEmpAgr);
    strSQL := strSQL + '   AND CTR_CODCLI = ' + QuotedStr(strCodCli);
  End;

  strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP, CTR_DTACAD ';

  Result := strSQL;

end;

function TfrmCtrAgrupDupRecibo.fCarregaDuplicatasCadRec(strNumDup, strCodEmp,
  strCodCli: String): String;
  Var
    strSQL : String;
    intContador: Integer;

begin

  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CONCAT(CTR_NUMDUP, "-", CTR_PARCEL) AS NUMDOC, ';
  strSQL := strSQL + '   CONCAT(CTR_NUMDUP, "-AG") AS NUMAGR, ';
  strSQL := strSQL + '   CTR_VALDUP AS VALDUP, ';
  strSQL := strSQL + '   CTR_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '   CTR_CODCND AS CODCND, ';
  strSQL := strSQL + '   CND_DESCRI AS DESCND ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' LEFT JOIN CADCND ON (CND_CODIGO = CTR_CODCND) ';

  strSQL := strSQL + ' WHERE ';

  If Assigned(FListaNumAgr) And
     Assigned(FListaEmpAgr) And
     Assigned(FListaCodCli) Then
  Begin
    If FListaNumAgr.Count > 1 Then
      strSQL := strSQL + ' ( ';

    For intContador := 0 To FListaNumAgr.Count -1 do
    Begin
      strSQL := strSQL + ' ( CTR_NUMDUP = ' + QuotedStr(FListaNumAgr[intcontador]) + ' AND';
      strSQL := strSQL + '   CTR_CODEMP = ' + QuotedStr(FListaEmpAgr[intcontador]) + ' AND';
      strSQL := strSQL + '   CTR_CODCLI = ' + QuotedStr(FListaCodCli[intcontador]) + ' AND ';
      strSQL := strSQL + '   CTR_ESPDOC = ' + QuotedStr('AG') + ') ';


      If (intContador < FListaNumAgr.Count -1) Then
        strSQL := strSQL + ' OR ';
    End;

    If FListaNumAgr.Count > 1 Then
      strSQL := strSQL + ' ) ';

  End
  Else
  Begin
    strSQL := strSQL + '   CTR_NUMDUP IN (' + strNumDup + ')';
    strSQL := strSQL + '   AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
    strSQL := strSQL + '   AND CTR_CODCLI = ' + QuotedStr(strCodCli);
    strSQL := strSQL + '   AND CTR_ESPDOC = ' + QuotedStr('AG');
  End;

  Result := strSQL;

end;

function TfrmCtrAgrupDupRecibo.fGetSql(strNumAgr: String; stlNumAgr,
  stlEmpAgr, stlCodCli: TStringList; FCodCli : String; FCodEmp : String): String;
  var
    strSQL : String;
    intContador : Integer;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_CODCLI, ';
  strSQL := strSQL + '  CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, "-", CTR_PARCEL, "-", CTR_ESPDOC, "-", CTR_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '  CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS NOMEMP, ';
  strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  CLI_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_FANSOB, ';
  strSQL := strSQL + '  IF(IFNULL(CLI_DESCON, "") = "", 0, CLI_DESCON) AS CLI_DESCON, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_VALORI, ';
  strSQL := strSQL + '  CTR_NUMAGR, ';
  strSQL := strSQL + '  CTR_EMPAGR, ';
  strSQL := strSQL + '  CTR_CONPAG, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_JURSUJ, ';
  strSQL := strSQL + '  CTR_DESSUJ, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_VALJUR, ';
  strSQL := strSQL + '  0.00 AS CTR_TOTJUR,  ';
  strSQL := strSQL + '  CONCAT(CTR_NUMAGR, "-AG") AS NUMAGR, ';
  strSQL := strSQL + '  C.CLI_EMCOB1, ';
  strSQL := strSQL + '  C.CLI_EMCOB2, ';
  strSQL := strSQL + '  C.CLI_EMAIL_, ';
  strSQL := strSQL + '  C.CLI_EMAIL2, ';
  strSQL := strSQL + '  C.CLI_EMAIL3, ';
  strSQL := strSQL + '  CTR_VALDES,   ';

  strSQL := strSQL + '  D.CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '  R.REG_DESREG AS DESREG ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DUPAGR ';

  strSQL := strSQL + 'INNER JOIN CADEMP ON      ';
  strSQL := strSQL + '  EMP_CODEMP = CTR_EMPAGR ';

  strSQL := strSQL + 'INNER JOIN CADCLI C ON    ';
  strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI ';

  strSQL := strSQL + 'LEFT JOIN CADCID D ON    ';
  strSQL := strSQL + '  D.CID_CODCID = C.CLI_CODCID ';

  strSQL := strSQL + 'LEFT JOIN CADREG R ON    ';
  strSQL := strSQL + '  C.CLI_CODREG = R.REG_CODREG ';


  strSQL := strSQL + 'WHERE ';

  If not fEmptyStr(strNumAgr) Then
  Begin
    strSQL := strSQL + '  CTR_NUMAGR IN (' + strNumAgr + ') AND';

    If Not fEmptyStr(FCodEmp) Then
      strSQL := strSQL + '  CTR_EMPAGR = ' + QuotedStr(FCodEmp)
    Else
      strSQL := strSQL + '  CTR_EMPAGR = ' + QuotedStr(VS_strCodEmp);

    If Not fEmptyStr(FCodCli) Then
    Begin
      strCodCliBkp := FCodCli;
      strSQL := strSQL + ' AND CTR_CODCLI = ' + QuotedStr(FCodCli);
    End;
  End
  Else If Assigned(stlNumAgr) And Assigned(stlEmpAgr) And Assigned(stlCodCli) Then
  Begin
    If stlNumAgr.Count > 1 Then
      strSQL := strSQL + ' ( '
    Else
    If (stlNumAgr.Count = 1) And (fCfgSis('AGRTPR', varInteger) = 4) Then
      strCodCliBkp := stlCodCli[0];

    For intContador := 0 To stlNumAgr.Count -1 do
    Begin
      strSQL := strSQL + ' ( CTR_NUMAGR = ' + QuotedStr(stlNumAgr[intcontador]) + ' AND';
      strSQL := strSQL + '   CTR_EMPAGR = ' + QuotedStr(stlEmpAgr[intcontador]) + ' AND';
      strSQL := strSQL + '   CTR_CODCLI = ' + QuotedStr(stlCodCli[intcontador]) + ') ';


      If (intContador < stlNumAgr.Count -1) Then
        strSQL := strSQL + ' OR ';
    End;

    If stlNumAgr.Count > 1 Then
      strSQL := strSQL + ' ) ';

  End;

  strSQL := strSQL + 'ORDER BY ';

  If Not blnImprimePorNomCli Then
    strSQL := strSQL + '  CTR_NUMAGR, CTR_ESPDOC, CTR_NUMDUP'
  Else
    strSQL := strSQL + '  CLI_NOMCLI ';

  Result := strSQL;
end;

function TfrmCtrAgrupDupRecibo.fMontaEmissao(strNumDoc, strEspDoc,
  strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTR_DTACAD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDOC AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP     ';
  strSQL := strSQL + ' ORDER BY CTR_DTAVEN        ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    Result := FieldByName('CTR_DTACAD').AsString;
    Close;
  End;
  FreeAndNil(qryGen);
end;

function TfrmCtrAgrupDupRecibo.fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + ' GROUP_CONCAT(                                                                            '+
                     '   CONCAT(                                                                                '+
                     '     DATE_FORMAT(CTR_DTAVEN, "%d/%m/%Y"),                                                 '+
                     '     " ",                                                                                 '+
                     '     (                                                                                    '+
                     '       CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) '+
                     '      )                                                                                   '+
                     '   ) SEPARATOR "   "                                                                      '+
                     ' ) AS DTAVEN                                                                              ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDOC AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP     ';
  If Not fEmptyStr(strCodCliBkp) Then
    strSQL := strSQL + ' AND CTR_CODCLI = :CODCLI   ';
  strSQL := strSQL + ' ORDER BY CTR_DTAVEN        ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    If Not fEmptyStr(strCodCliBkp) Then
      ParamByName('CODCLI').AsString := strCodCliBkp;
    Open;
    Result := FieldByName('DTAVEN').AsString;
    Close;
  End;
  FreeAndNil(qryGen);

End;

function TfrmCtrAgrupDupRecibo.fRetQtdReg: Integer;
begin
  Result := intQtdRegMod3;
end;

function TfrmCtrAgrupDupRecibo.fRetornaComprovanteCustomizado: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Fr3\' + 'comprovante_agrupamento_ctr.fr3';

  If Not FileExists(Result) Then
    Result := '';
end;

function TfrmCtrAgrupDupRecibo.fRetornaParcelasAgrupamento(ANumDup, ACodCli,
  ACodEmp: String): String;
var
  LConsulta : TUniQuery;
begin
  Result := '';
  try
    LConsulta := fCriaQuery();
    try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Text := ' SELECT                                     ' +
                            '   GROUP_CONCAT(                            ' +
                            '     CONCAT(                                ' +
                            '       "AG: ",                              ' +
                            '       CTR_NUMDUP,                          ' +
                            '       " | PARC: ",                         ' +
                            '       CTR_PARCEL,                          ' +
                            '       " | VALOR: ",                        ' +
                            '       CTR_VALDUP,                          ' +
                            '       " | VENCIMENTO: ",                   ' +
                            '       DATE_FORMAT(CTR_DTAVEN, "%d/%m/%Y")  ' +
                            '     ) SEPARATOR "\n"                       ' +
                            '   ) AS PARCELAS                            ' +
                            ' FROM                                       ' +
                            '   CADREC                                   ' +
                            ' WHERE CTR_NUMDUP = :NUMDUP                 ' +
                            '   AND CTR_CODCLI = :CODCLI                 ' +
                            '   AND CTR_ESPDOC = :ESPDOC                 ' +
                            '   AND CTR_CODEMP = :CODEMP                 ' ;
      LConsulta.ParamByName('NUMDUP').AsString := ANumDup;
      LConsulta.ParamByName('CODCLI').AsString := ACodCli;
      LConsulta.ParamByName('ESPDOC').AsString := 'AG';
      LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
      LConsulta.Open;
      if not LConsulta.IsEmpty then
         Result := LConsulta.FieldByName('PARCELAS').AsString;
      LConsulta.Close;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TRelCtrAgrupDupRecibo.fRetornaParcelasAgrupamento]');
    end;
  finally
    FreeAndNil(LConsulta);
  end;

end;

function TfrmCtrAgrupDupRecibo.fTamanhoArrAgrupamento(i: integer): boolean;
begin
   result := true;
   if not assigned(arrArqAgrupamentos) then
     setlength(arrArqAgrupamentos,i)
   else
     result := false;
end;

function TfrmCtrAgrupDupRecibo.fMontaDataVenctoAgr(strNumDoc, strEspDoc,
  strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTR_DTAVEN ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDOC AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP     ';
  strSQL := strSQL + ' ORDER BY CTR_DTAVEN        ';
  strSQL := strSQL + ' LIMIT 1 ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    Result := FieldByName('CTR_DTAVEN').AsString;
    Close;
  End;
  FreeAndNil(qryGen);
end;

end.
