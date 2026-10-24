unit untRelFichaCadFuncionario;

interface

uses
  Windows, System.Generics.Collections, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, Math,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, BitBtnLockedIncrem, Uni, UniClientDataSet, UniDataSetProvider, DB, untTypesSistema,
  MaskEditFocus, Mapi, frxExportCSVTestabilidade, MemDS, DBAccess, untZClient, untFuncoesGenerica;

type
  TfrmRelFichaCadFuncionario = class(TfrmPaiRelatorio)
    rdgModelo: TRadioGroup;
    gpbContato: TGroupBox;
    lblEmail: TLabel;
    lblContato: TLabel;
    edtEmail: TEditFocus;
    edtContato: TEditFocus;
    lblProduto: TLabel;
    edtCodFun: TEditFocus;
    edtDesFun: TEditFocus;
    frxBeneficia: TfrxDBDataset;
    GroupBox1: TGroupBox;
    chkFotoFuncionario: TCheckBox;
    chkExibirFuncDemitidos: TCheckBox;
    frxFerias: TfrxDBDataset;
    frxReportJ: TfrxReport;
    procedure edtCodFunKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFunExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure rdgModeloClick(Sender: TObject);
    procedure edtDestinoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function frxReportJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    FPais: TPais;
    arrFuncionario : TConsultasArray;
    qryRelatorio   : TZClient;
    qryBeneficia   : TZClient;
    qryFerias      : TZClient;
    strCodEmpresa  : String;


    //ZClient : IZClient;

    function fGetSql : String;
    function fGetSqlBeneficia : String;
    function fGetSqlFerias : String;
    function fAbreConsulta : Boolean;
    procedure pAbreRelatorio;
    procedure pEnviaEmail;
    procedure pQryRelatorioAfterScroll(DataSet : TDataSet);

    function fPesqFuncionarios(aSelf: TForm;                      {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                           edtDescri: TEditFocus;                 {* Edit do Nome do Funcionário                 *}
                           qryTabela: TUniQuery;                  {* Query                                       *}
                           var chrKey: Char;                      {* Key                                         *}
                           var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;

    function fFormataFonePaisInterna(strFone: String): String;
    function FrFileExists(FileName : string):boolean;


    procedure pLoadReport(var frxModelo: TFrxReport; strCodLay: String; strTipImp: String = 'J');
    function fFormataCpfCgcInterna(strValor: String): String;
    function fFormataCEPInterna(strValor: String): String;
  public
    class procedure pRelFichaCadFuncionario(strCodFun, strCodEmp : String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetNomeFuncionario(strCodFun, strCodEmp: String): String;
  end;



implementation

uses
  untFuncoesSimples, untFuncoesConsulta, untConsultas, untFastPrintEditor;

{$R *.dfm}

function TfrmRelFichaCadFuncionario.FrFileExists(FileName : string):boolean;
begin
  Result := FileExists(FileName);
end;


function TfrmRelFichaCadFuncionario.fRetNomeFuncionario(strCodFun, strCodEmp: String): String;
Var
  strSQL : String;
  qryGenOpe : TUniQuery;
begin
  Try
    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFUN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FUN_CODFUN = :CODFUN ';
    strSQL := strSQL + ' AND FUN_CODEMP = :CODEMP ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFUN').AsString := strCodFun;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := qryGenOpe.FieldByName('FUN_NOMFUN').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;
end;


procedure TfrmRelFichaCadFuncionario.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if not blnImprime Then
    Exit;

  pAbreRelatorio;
  pSetFocus(rdgModelo.Buttons[rdgModelo.ItemIndex]);
end;

procedure TfrmRelFichaCadFuncionario.edtCodFunExit(Sender: TObject);
var
  strNomFun: String;
begin
  inherited;

  //pEdtCodSelectExit(edtCodFun, edtDesFun, arrFuncionario, fRetNomeFuncionario, nil, 'do Funcionário');
  strNomFun := fRetNomeFuncionario(edtCodFun.Text, strCodEmpresa);

  If (fEmptyStr(strNomFun)) Then
  Begin
    fMensagem('AVISO', 'Funcionário não encontrado.', ['&O K']);
    edtCodFun.Clear;
    pSetFocus(edtCodFun);
  End
  Else
    edtDesFun.Text := strNomFun;
end;

procedure TfrmRelFichaCadFuncionario.edtCodFunKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqFuncionarios(Self, edtCodFun, edtDesFun, nil, Key, arrFuncionario, False) then
  Begin
    if fValidaCampos(edtCodFun, False) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFichaCadFuncionario.edtDestinoChange(Sender: TObject);
begin
  inherited;
  lblEmail.Enabled   := (edtDestino.Text = 'E');
  edtEmail.Enabled   := (edtDestino.Text = 'E');
  edtContato.Enabled := (edtDestino.Text = 'E');
  lblContato.Enabled := (edtDestino.Text = 'E');
end;

function TfrmRelFichaCadFuncionario.fFormataFonePaisInterna(strFone: String): String;
begin
    Result := fFormataFone(strFone);
end;

procedure TfrmRelFichaCadFuncionario.pLoadReport(var frxModelo: TFrxReport; strCodLay: String; strTipImp: String = 'J');
Var
  FLayImp: TUniQuery;
  mmsLoad: TStream;
begin
  Try
    FLayImp := fCriaQuery(Nil);
    Try
      With FLayImp, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * ');
        Add('  FROM LAYIMP');
        Add(' WHERE LAY_TIPLAY = :TIPLAY ');
        Add('   AND LAY_CODEMP = :CODEMP ');
        Add('   AND LAY_CODLAY = :CODLAY ');
        Add(' ORDER BY LAY_DTAALT DESC,');
        Add('          LAY_HORALT DESC ');
        Add(' LIMIT 1');
        ParamByName('CODLAY').AsString := strCodLay;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('TIPLAY').AsString := IIF(strTipImp = 'J','L','M');

        Open;
        If Not IsEmpty Then
        Begin
          mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
          frxModelo.LoadFromStream(mmsLoad);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fLoadReport]');
      End;
    End;
  Finally
    FreeAndNil(mmsLoad);
    pFreeAndNil(FLayImp);
  End;
end;

function TfrmRelFichaCadFuncionario.fAbreConsulta : Boolean;
  Var
    intCorre : Integer;
begin
  Try
    With qryBeneficia Do
    Begin
      qryQuery.Sql.Clear;
      qryQuery.Sql.Add(fGetSqlBeneficia);
    End;


    With qryFerias Do
    Begin
      qryQuery.Sql.Clear;
      qryQuery.Sql.Add(fGetSqlFerias);
    End;

    With qryRelatorio Do
    Begin
      qryQuery.Sql.Clear;
      qryQuery.Sql.Add(fGetSql);

      If (Not fEmptyStr(edtCodFun.Text)) Then
      Begin
        qryQuery.ParamByName('CODFUN').AsString := edtCodFun.Text;
        qryQuery.ParamByName('CODEMP').AsString := strCodEmpresa;
      End;

      Result := fAbreClient(True, 'TfrmRelFichaCadFuncionario.fAbreConsulta');

      if Not Result then Exit;

      if IsEmpty and (rdgModelo.ItemIndex = 1) then
      Begin
        Result := False;
        pTabelaVazia;
        Exit;
      End;

      if (rdgModelo.ItemIndex = 0) then
      Begin
        Insert;
        for intCorre := 0 to Fields.Count - 1 do
          Fields[intCorre].AsVariant := null;
        Post;
      End;
      Result := True;
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TfrmRelFichaCadFuncionario.fAbreConsulta]');
    End;
  End;
end;

procedure TfrmRelFichaCadFuncionario.pAbreRelatorio;
begin
  Try
    if not fAbreConsulta then
      Exit;

    {*****************************}
    {* CARREGA O LAYOUT DO BANCO *}
    {**************************LM*}
    pLoadReport(frxReportJ,'FICFUN', 'J');

    With frxReportJ Do
    Begin
      Script.Variables['NOMREL'] := 'FICHA CADASTRAL - FUNCIONÁRIO';
      TfrxPictureView(frxReportJ.FindObject('FOTO_FUNCIONARIO')).Visible := False;

     if chkFotoFuncionario.Checked Then
       TfrxPictureView(frxReportJ.FindObject('FOTO_FUNCIONARIO')).Visible := True
     else
       TfrxPictureView(frxReportJ.FindObject('FOTO_FUNCIONARIO')).Visible := False;

      if PrepareReport then
      Begin
        if edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxReportJ)
        else if edtDestino.Text = 'I' Then
        begin
          if strTipImp = 'J' then
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxReportJ)
          else
          begin
            pMensagemOk('Impressão da ficha cadastral somente a jato ou laser.');
            pSetFocus(btnImprimir);
          end;
        end
        Else
          pEnviaEmail;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmRelFichaCadFuncionario.fAbreRelatorio]');
    End;
  End;
end;

function TfrmRelFichaCadFuncionario.fGetSql: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE';
  Result := Result + '       FUN_CODEMP,';
  Result := Result + '       FUN_CODFUN,';
  Result := Result + '       FUN_NOMFUN,';
  Result := Result + '       FNC_NOMFNC AS FUN_FUNCAO,';
  Result := Result + '       FUN_DTAADM,';
  Result := Result + '       FUN_DTADEM,';
  Result := Result + '       FUN_SALBAS,';
  Result := Result + '       FUN_BANCO_,';
  Result := Result + '       FUN_AGENCI,';
  Result := Result + '       FUN_CONTA_,';
  Result := Result + '       FUN_PISPAS,';
  Result := Result + '       FUN_CARPON,';
  Result := Result + '       FUN_REGIST,';
  Result := Result + '       FUN_OBSERV,';
  Result := Result + '       FUN_N_CTPS,';
  Result := Result + '       FUN_NUMSER,';
  Result := Result + '       FUN_C_P_F_,';
  Result := Result + '       FUN_NUM_RG,';
  Result := Result + '       FUN_HT1DOM,';
  Result := Result + '       FUN_HT2DOM,';
  Result := Result + '       FUN_HT3DOM,';
  Result := Result + '       FUN_HT4DOM,';
  Result := Result + '       FUN_HT1SEG,';
  Result := Result + '       FUN_HT2SEG,';
  Result := Result + '       FUN_HT3SEG,';
  Result := Result + '       FUN_HT4SEG,';
  Result := Result + '       FUN_HT1TER,';
  Result := Result + '       FUN_HT2TER,';
  Result := Result + '       FUN_HT3TER,';
  Result := Result + '       FUN_HT4TER,';
  Result := Result + '       FUN_HT1QUA,';
  Result := Result + '       FUN_HT2QUA,';
  Result := Result + '       FUN_HT3QUA,';
  Result := Result + '       FUN_HT4QUA,';
  Result := Result + '       FUN_HT1QUI,';
  Result := Result + '       FUN_HT2QUI,';
  Result := Result + '       FUN_HT3QUI,';
  Result := Result + '       FUN_HT4QUI,';
  Result := Result + '       FUN_HT1SEX,';
  Result := Result + '       FUN_HT2SEX,';
  Result := Result + '       FUN_HT3SEX,';
  Result := Result + '       FUN_HT4SEX,';
  Result := Result + '       FUN_HT1SAB,';
  Result := Result + '       FUN_HT2SAB,';
  Result := Result + '       FUN_HT3SAB,';
  Result := Result + '       FUN_HT4SAB,';
  Result := Result + '       FUN_GRAINS,';
  Result := Result + '       FUN_NACION,';
  Result := Result + '       FUN_NOMPAI,';
  Result := Result + '       FUN_NOMMAE,';
  Result := Result + '       FUN_LOCNAS,';
  Result := Result + '       FUN_DTANAS,';
  Result := Result + '       FUN_ESTCIV,';
  Result := Result + '       FUN_CERMIL,';
  Result := Result + '       FUN_CARHAB,';
  Result := Result + '       FUN_MOTDES,';
  Result := Result + '       FUN_NUMTIT,';
  Result := Result + '       FUN_ZONTIT,';
  Result := Result + '       FUN_SECTIT,';
  Result := Result + '       FUN_CATHAB,';
  Result := Result + '       FUN_VALHAB,';
  Result := Result + '       FUN_CODVEN,';
  Result := Result + '       FUN_NUMTEL,';
  Result := Result + '       FUN_NUMCEL,';
  Result := Result + '       EMP_NOMEMP,';
  Result := Result + '       EMP_C_G_C_,';
  Result := Result + '       OPE_NOMOPE,';
  Result := Result + '       CI.CID_NOMCID,';
  Result := Result + '       FUN_ENDERE,';
  Result := Result + '       FUN_ENDNUM,';
  Result := Result + '       FUN_BAIRRO,';
  Result := Result + '       FUN_FOTO01,';
  Result := Result + '       FUN_FOTO02,';
  Result := Result + '       FUN_NRGEXP,';
  Result := Result + '       FUN_RG_CUF,';
  Result := Result + '       BCO_NOMBCO,';
  Result := Result + '       FUN_SEXOFU,';
  Result := Result + '       FUN_CODCBO,';
  Result := Result + '       FUN_CTPSUF,';
  Result := Result + '       FUNC_RGDEM,';
  Result := Result + '       FUN_CPFDEM,';
  Result := Result + '       FUN_DTAEXA,';
  Result := Result + '       FUN_CORFUN,';
  Result := Result + '       FUN_CORFUN,';
  Result := Result + '       FUN_SALBAS,';
  Result := Result + '       C.CID_ESTADO AS FUN_ESTADO,';
  Result := Result + '       C.CID_NOMCID AS FUN_CIDADE,';
  Result := Result + '       CP.CID_NOMCID AS EMP_CIDADE,';
  Result := Result + '       CP.CID_ESTADO AS EMP_ESTADO,';
  Result := Result + '       FUN_FILHOS,';
  Result := Result + '       FUN_QTDFIL,';
  Result := Result + '       FUN_TAMANH,';
  Result := Result + '       FUN_ALTURA,';
  Result := Result + '       FUN_PESFUN,';
  Result := Result + '       FUN_COMPLE, ';
  Result := Result + '       FUN_EMEXPE, ';
  Result := Result + '       FUN_EXP45D, ';
  Result := Result + '       FUN_EXPM45, ';
  Result := Result + '       FUN_C_E_P_ ';

  Result := Result + '  FROM CADFUN       ';

  Result := Result + '  LEFT JOIN CADEMP ON EMP_CODEMP = FUN_CODEMP ';
  Result := Result + '  LEFT JOIN CADOPE ON OPE_CODOPE = FUN_CODVEN ';
  Result := Result + '  LEFT JOIN CADCID CI ON CI.CID_CODCID = FUN_LOCNAS ';
  Result := Result + '  LEFT JOIN CADBCO ON BCO_CODBCO = FUN_BANCO_ ';
  Result := Result + '  LEFT JOIN CADFNC ON FNC_CODFNC = FUN_FUNATU ';
  Result := Result + '  LEFT JOIN CADCID C ON C.CID_CODCID = FUN_CODCID ';
  Result := Result + '  LEFT JOIN CADCID CP ON CP.CID_CODCID = EMP_CODCID ';

  //Result := Result + 'WHERE ' + IIF(rdgModelo.ItemIndex = 0, 'FALSE',' TRUE' ) ;
  If (rdgModelo.ItemIndex = 0) then
    Result := Result + 'WHERE FALSE'
  else
    Result := Result + 'WHERE TRUE' + IIF(chkExibirFuncDemitidos.Checked,'',' AND FUN_DTADEM IS NULL ');

  If (Not fEmptyStr(edtCodFun.Text)) Then
  Begin
    Result := Result + fStrLocate(edtCodFun, arrFuncionario, 'FUN_CODFUN', 'CODFUN');
    Result := Result + fStrLocate(strCodEmpresa, arrFuncionario, 'FUN_CODEMP', 'CODEMP');
  End;

end;

function TfrmRelFichaCadFuncionario.fGetSqlBeneficia: String;
begin
  Result := 'SELECT * FROM FUNBNF ';

  //Result := Result + 'WHERE ' + IIF(rdgModelo.ItemIndex = 0, 'FALSE',' TRUE' ) ;
  If (rdgModelo.ItemIndex = 0) then
    Result := Result + 'WHERE FALSE'
  else
    Result := Result + 'WHERE TRUE';

  Result := Result + '  AND BNF_CODFUN = :CODFUN ';
  Result := Result + '  AND BNF_CODEMP = :CODEMP ';
end;

function TfrmRelFichaCadFuncionario.fGetSqlFerias: String;
begin
  Result := 'SELECT * FROM FUNFER ';

  If (rdgModelo.ItemIndex = 0) then
    Result := Result + ' WHERE FALSE '
  Else
    Result := Result + ' WHERE TRUE ';

  Result := Result + '  AND FER_CODFUN = :CODFUN ';
  Result := Result + '  AND FER_CODEMP = :CODEMP ';

end;

procedure TfrmRelFichaCadFuncionario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //FreeAndNil(qryBeneficia);
  //FreeAndNil(qryRelatorio);
  //FreeAndNil(qryFerias);

end;

procedure TfrmRelFichaCadFuncionario.FormCreate(Sender: TObject);
begin
  inherited;
  qryBeneficia             := TZClient.Create(Self);
  frxBeneficia.DataSet     := qryBeneficia.fGetDataset;

  qryFerias                := TZClient.Create(Self);
  frxFerias.DataSet        := qryFerias.fGetDataset;

  qryRelatorio             := TZClient.Create(Self);
  qryRelatorio.AfterScroll := pQryRelatorioAfterScroll;

  frxRelatorio.DataSet     := qryRelatorio.fGetDataset;

  blnExcel                 := True;
  blnFecharComEscape       := True;
end;

procedure TfrmRelFichaCadFuncionario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and (ActiveControl is TRadioButton) then
    pEscapePressed;

  if (Key = VK_RETURN) and (ActiveControl is TRadioButton) then
  Begin
    SelectNext(ActiveControl, True, True);
    Key := 0;
    Exit;
  End;
end;

procedure TfrmRelFichaCadFuncionario.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rdgModelo.Buttons[rdgModelo.ItemIndex]);

  frxReportJ.AddFunction('function fFormataFonePaisInterna(strFone: String): String;');
  frxReportJ.AddFunction('function FrFileExists(FileName:String):Boolean;');
  frxReportJ.AddFunction('function fFormataCpfCgcInterna(strValor: String): String;');
  frxReportJ.AddFunction('function fFormataCEPInterna(strCEP: String): String;');

end;

function TfrmRelFichaCadFuncionario.fPesqFuncionarios(aSelf: TForm;
edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
  var strSQL,strWhere: String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  FUN_CODEMP,       ';
      strSQL := strSQL + '  FUN_CODFUN,       ';
      strSQL := strSQL + '  FUN_NOMFUN,       ';
      strSQL := strSQL + '  FNC_NOMFNC,       ';
      strSQL := strSQL + '  FUN_DTAADM,       ';
      strSQL := strSQL + '  FUN_SALBAS,       ';
      strSQL := strSQL + '  FUN_PISPAS,       ';
      strSQL := strSQL + '  FUN_DTADEM,       ';
      strSQL := strSQL + '  FUN_BANCO_,       ';
      strSQL := strSQL + '  FUN_AGENCI,       ';
      strSQL := strSQL + '  FUN_CONTA_,       ';
      strSQL := strSQL + '  IF(FUN_CARPON = "S","SIM","NÃO") AS FUN_CARPON, ';
      strSQL := strSQL + '  IF(FUN_REGIST = "S","SIM","NÃO") AS FUN_REGIST, ';
      strSQL := strSQL + '  CADFUN.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADFUN            ';
      strSQL := strSQL + 'LEFT JOIN CADFNC ON FNC_CODFNC = FUN_FUNATU ';

      strWhere := '';
      strWhere := strWhere + 'WHERE  ';
      strWhere := strWhere + '  TRUE ' ;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Empresa',
                   'Código',
                   'Nome',
                   'Função',
                   'Dt. Admissão',
                   'Sal. Base',
                   'Pis Pasep',
                   'Dt. Demissão',
                   'Banco',
                   'Agência',
                   'Conta',
                   'Ponto OK?',
                   'Registro OK?'],
                   ['FUN_CODFUN'],
                   '',
                   'CADFUN',
                   Self.Name,
                   'Consulta de Funcionários',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'FUN_CODFUN') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FUN_CODFUN').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FUN_CODFUN').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('FUN_NOMFUN').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function TfrmRelFichaCadFuncionario.frxReportJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0]);

  If SameText(MethodName, 'fFormataCpfCgcInterna') Then
    Result := fFormataCpfCgcInterna(Params[0]);

  If SameText(MethodName, 'fFormataCEPInterna') Then
    Result := fFormataCEPInterna(Params[0]);

  if MethodName = 'FRFILEEXISTS' then
    Result := FrFileExists(Params[0]);
end;

function TfrmRelFichaCadFuncionario.fFormataCEPInterna(strValor: String): String;
begin
  Result := fFormataCep(strValor);
end;

function TfrmRelFichaCadFuncionario.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TfrmRelFichaCadFuncionario.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    if (Sender = edtCodFun) then
    Begin
      pDesmarcaLista(edtCodFun, arrFuncionario);
    End
    Else
    if (Sender = edtContato) and (edtDestino.Text = 'E') and fEmptyStr(edtContato.Text) then
    Begin
      fMensagem('','Preencha o Contato', ['&OK']);
      Result := False;
    End
    Else
    if (Sender = edtEmail) and (edtDestino.Text = 'E') and fEmptyStr(edtEmail.Text) then
    Begin
      fMensagem('','Preencha o E-Mail', ['&OK']);
      Result := False;
    End;

  End;

  if Not Result then
    pSetFocus(Sender);

end;

procedure TfrmRelFichaCadFuncionario.pEnviaEmail;
  Var
    strExecutavel : String;
    strNomArquivo : String;
    strAssunto    : String;
    strTexto      : String;
    blnCodFunc    : Boolean;

begin
  Try
    {*******************************************}
    {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
    {*******************************************}
    strExecutavel := ExtractFilePath(Application.ExeName);

    {*******************************************}
    {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
    {*******************************************}
    If Not DirectoryExists(strExecutavel+'FichaCliente') Then
      CreateDir(strExecutavel+'FichaCliente');

    blnCodFunc := not fEmptyStr(fRetNomeFuncionario(edtCodFun.Text, strCodEmpresa));
    {*******************************************}
    {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
    {*******************************************}
    if blnCodFunc then
      strNomArquivo := 'FUN_' + edtCodFun.Text + '.pdf'
    Else
      strNomArquivo := 'FUN_' + FormatDateTime('ddMMyyy_hhmmss', fNow()) + '.pdf';

    If frxReportJ.PrepareReport Then
    Begin
      frxExpPDF.FileName    := strNomArquivo;
      frxExpPDF.DefaultPath := strExecutavel+'FichaCliente';
      frxExpPDF.ShowDialog  := False;
      frxReportJ.Export(frxExpPDF);

      {**************************}
      {* GERA O ANEXO NO EMAIL  *}
      {**************************}
      strNomArquivo := strExecutavel+'FichaCliente\'+strNomArquivo;

      {************************************************}
      {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O  ARQUIVO *}
      {************************************************}
      If (Not fEmptyStr(strNomArquivo)) and FileExists(strNomArquivo) Then
      Begin
        strTexto := 'A/C ' + edtContato.Text;
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + 'Segue em anexo Ficha Cadastral.';
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
        strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

        //strAssunto := 'Ficha Cadastral ' + IIF(blnCodFunc, 'Funcionario Código: ' + edtCodFun.Text, '');
        If blnCodFunc then
          strAssunto := 'Ficha Cadastral ' + 'Funcionário Código: ' + edtCodFun.Text
        else
          strAssunto := 'Ficha Cadastral';

        strAssunto := fRetNomeEmpresa + ' - ' + strAssunto;

        If (untFuncoesSimples.EnviarEMailComAnexo(edtEmail.Text, strAssunto, strTexto, strNomArquivo) = 1) Then
          fMensagem('ATENÇÃO!', 'Ficha Cadastral enviada com sucesso !', ['&Ok']);

      End
      Else
        fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
    End
    Else
      fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

  Except
    On E : Exception Do
      pMensagensErro(e.Message, '[TfrmRelFichaCadFuncionario.pEnviaEmail]');
  End;
end;

procedure TfrmRelFichaCadFuncionario.pQryRelatorioAfterScroll(DataSet: TDataSet);
  Const
    NUMERO_REG = 11;
    NUM_REGFERIAS = 1;
  Var
    intCorre : Integer;
    intRegis : Integer;
begin
  With qryBeneficia Do
  Begin
    qryQuery.Close;
    qryQuery.ParamByName('CODFUN').AsString := qryRelatorio.FieldByName('FUN_CODFUN').AsString;
    qryQuery.ParamByName('CODEMP').AsString := qryRelatorio.FieldByName('FUN_CODEMP').AsString;
    fAbreClient(True, 'TfrmRelFichaCadFuncionario.pQryRelatorioAfterScroll' );

    For intRegis := RecordCount to NUMERO_REG -1 do
    Begin
      Append;
      for intCorre := 0 to Fields.Count - 1 do
        Fields[intCorre].AsVariant := null;
      Post;
    End;
  End;

  With qryFerias Do
  Begin
    qryQuery.Close;
    qryQuery.ParamByName('CODFUN').AsString := qryRelatorio.FieldByName('FUN_CODFUN').AsString;
    qryQuery.ParamByName('CODEMP').AsString := qryRelatorio.FieldByName('FUN_CODEMP').AsString;
    fAbreClient(True, 'TfrmRelFichaCadFuncionario.pQryRelatorioAfterScroll' );

    For intRegis := RecordCount to NUM_REGFERIAS -1 do
    Begin
      Append;
      for intCorre := 0 to Fields.Count - 1 do
        Fields[intCorre].AsVariant := null;
      Post;
    End;

  End;
end;

procedure TfrmRelFichaCadFuncionario.rdgModeloClick(Sender: TObject);
begin
  inherited;
  if (rdgModelo.ItemIndex = 1) Then
  edtCodFun.Enabled := False else  edtCodFun.Enabled := True;

  if (rdgModelo.ItemIndex = 0) Then
  chkFotoFuncionario.Enabled := False else  chkFotoFuncionario.Enabled := True;

  if (rdgModelo.ItemIndex = 0) Then
  chkFotoFuncionario.Checked := False;

  chkExibirFuncDemitidos.Enabled := (rdgModelo.ItemIndex = 1);
  chkExibirFuncDemitidos.Checked := True;

end;

class procedure TfrmRelFichaCadFuncionario.pRelFichaCadFuncionario(strCodFun, strCodEmp: String);
  var
    frmRelFichaCadFuncionario: TfrmRelFichaCadFuncionario;
begin
  pCriarFormularios(TfrmRelFichaCadFuncionario, frmRelFichaCadFuncionario);
  With frmRelFichaCadFuncionario Do
  Begin
    if Not fEmptyStr(fRetNomeFuncionario(strCodFun, strCodEmp)) then
    Begin
      edtCodFun.Text := strCodFun;
      strCodEmpresa  := strCodEmp;
      edtCodFunExit(edtCodFun);
      rdgModelo.ItemIndex := 1;
    End;
    ShowModal;
  End;

  FreeAndNil(frmRelFichaCadFuncionario);
end;

end.
