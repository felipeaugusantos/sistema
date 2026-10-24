unit untQckCopiaCheque;

interface

uses
  SysUtils, Classes, DB,   Uni, Variants, Forms,
  frxClass, frxDBSet, frxDMPExport, StrUtils, untfuncoesSimples;

type
  TfrmQckCopiaCheque = class(TForm)
    frxCopiaCheque_M: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxDuplicatas: TfrxDBDataset;
    FrxCheque: TfrxUserDataSet;
    procedure FrxChequeGetValue(const VarName: string; var Value: Variant);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    cpuCampos: TCamposUso;

    fltValChq : Double;
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;
    strCidChq : String;
    strNomPor : String;
    strExtenso: String;

    FValExt : String;
    FDtaBai : String;
    FDtaBom : String;
    FDtEmis : String;
    FFavore : String;
    FValExt2: String;
  public
    { Public declarations }

    published
    {*****************************************}
    {* PROPRIEDADES QUE SERÃO USADAS PARA A  *}
    {* IMPRESSÃO DO CHEQUE                   *}
    {**************************************AC*}
    property strValExt : String read FValExt  write FValExt;
    property strDtaBai : String read FDtaBai  write FDtaBai;
    property strBomPar : String read FDtaBom  write FDtaBom;
    property strDtEmis : String read FDtEmis  write FDtEmis;
    property strNomFav : String read FFavore  write FFavore;
    property strValExt2: String read FValExt2 write FValExt2;
  end;

  procedure pImprimeCopiaCheque(strCodBco, strNumAge, strNumChq, strConCor, strNomForm: String );

  procedure pImprimeCheque(strCodBco, strNumAge, strNumChq, strConCor, strFavore,
    strDtaBom, strPorBai, strNomForm, strDtaEmi: String );

var
  frmQckCopiaCheque: TfrmQckCopiaCheque;

implementation

uses untFuncMacro, untValorPorExtenso, untCadChq, untCfgRel;

{$R *.dfm}

procedure TfrmQckCopiaCheque.DataModuleCreate(Sender: TObject);
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
end;

procedure TfrmQckCopiaCheque.FrxChequeGetValue(const VarName: string;
  var Value: Variant);
begin
  If SameText('VALOR_CHEQUE', VarName) Then
    Value := fltValChq
  Else If SameText('EXTENSO_CHEQUE', VarName) Then
    Value := strValExt
  Else If SameText('EXTENSO2_CHEQUE', VarName) Then
    Value := strValExt2
  Else If SameText('FAVORECIDO_CHEQUE', VarName) Then
    Value := strNomFav
  Else If SameText('CIDADE_CHEQUE', VarName) Then
    Value := strCidChq
  Else If SameText('DATA_CHEQUE', VarName) Then
    Value := strDtaBai
  Else If SameText('BOMPARA_CHEQUE', VarName) Then
    Value := strBomPar
  Else If SameText('EMISSAO_CHEQUE', VarName) Then
    Value := strDtEmis
  Else If SameText('PORTADOR_CHEQUE', VarName) Then
    Value := strNomPor;
end;

procedure pImprimeCopiaCheque(strCodBco, strNumAge, strNumChq, strConCor, strNomForm: String );
  Var
    strSQL: String;
    qryDuplicatas, qryCfgRel: TUniQuery;
begin

  Try

    With frmQckCopiaCheque Do
    Begin
      qryDuplicatas := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '   FOR_NOMFOR, ';
      strSQL := strSQL + '   EMI_VALBAI, ';
      strSQL := strSQL + '   CONCAT(EMI_NUMDUP,EMI_PARCEL,"-",EMI_SERIE_,"-",EMI_CODEMP) AS EMI_NUMDUP, ';
      strSQL := strSQL + '   EMI_HISTOR, ';
      strSQL := strSQL + '   EMI_NUMCHQ, ';
      strSQL := strSQL + '   EMI_SERIE_, ';
      strSQL := strSQL + '   EMI_CODEMP, ';
      strSQL := strSQL + '   CONCAT(EMI_CODBCO," - ",BCO_NOMBCO) AS EMI_CODBCO, ';
      strSQL := strSQL + '   EMI_CONCOR, ';
      strSQL := strSQL + '   EMI_NUMAGE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CHQEMI ';
      strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = EMI_CODFOR ';
      strSQL := strSQL + '  JOIN CADBCO ON BCO_CODBCO = EMI_CODBCO ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  EMI_CODBCO = :CODBCO ';
      strSQL := strSQL + '  AND EMI_NUMAGE = :NUMAGE ';
      strSQL := strSQL + '  AND EMI_NUMCHQ = :NUMCHQ ';
      strSQL := strSQL + '  AND EMI_CONCOR = :CONCOR ';

      {********************************************}
      {* SELECIONO A(S) DUPLICATA(S) REFERENTE(S) *}
      {* AO CHEQUE EM QUESTÃO.                    *}
      {*****************************************AC*}
      With qryDuplicatas Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('NUMCHQ').AsString := strNumChq;
        ParamByName('CONCOR').AsString := strConCor;

        Open;
      End;

      frxDuplicatas.DataSet := qryDuplicatas;

      {*******************************************}
      {* FILA DE IMPRESSAO                       *}
      {****************************************AC*}
      qryCfgRel := fCriaQuery;

      pCarregaConfImpr(qryCfgRel, strNomForm + '_COPIA');

      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
      strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

      FreeAndNil(qryCfgRel);

      If (Not fEmptyStr(strNomImp)) Then
      Begin
        frxCopiaCheque_M.PrintOptions.Printer    := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
        frxCopiaCheque_M.PrintOptions.ShowDialog := False;
        If frxCopiaCheque_M.PrepareReport Then
          pPrintReport(strNomForm + '_COPIA', 'Impressão de cópia de cheque', strNomImp, frxCopiaCheque_M);
      End;
    End;

    FreeAndNil(qryDuplicatas);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeCopiaCheque]');
    End;
  End;

end;

procedure pImprimeCheque(strCodBco, strNumAge, strNumChq, strConCor, strFavore, strDtaBom,
  strPorBai, strNomForm, strDtaEmi: String );
  Var
    strSQL: String;
    intLinhaAtu: Integer;
    intLinha: Integer;
    qryChqEmi, qryCfgRel, qryCnfChq: TUniQuery;
begin
  Try
    With frmQckCopiaCheque Do
    Begin
      cpuCampos := Nil;

      intLinhaAtu := 1;
      intLinha    := 0;

      {*******************************************}
      {* CRIA QUERY CHEQUE                       *}
      {****************************************AC*}
      qryChqEmi := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '   CID_NOMCID, ';
      strSQL := strSQL + '   DATE_FORMAT(EMI_DTABAI, "%d/%m/%Y") AS EMI_DTABAI, ';
      strSQL := strSQL + '   EMI_HISTOR, ';
      strSQL := strSQL + '   SUM(EMI_VALBAI) AS EMI_VALBAI ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CHQEMI ';
      strSQL := strSQL + '  JOIN CADEMP ON EMP_CODEMP = "' +  VS_strCodEmp + '" ';
      strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  EMI_CODBCO = :CODBCO ';
      strSQL := strSQL + '  AND EMI_NUMAGE = :NUMAGE ';
      strSQL := strSQL + '  AND EMI_NUMCHQ = :NUMCHQ ';
      strSQL := strSQL + '  AND EMI_CONCOR = :CONCOR ';
      strSQL := strSQL + 'GROUP BY CID_NOMCID, EMI_DTABAI ';

      With qryChqEmi Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('NUMCHQ').AsString := strNumChq;
        ParamByName('CONCOR').AsString := strConCor;

        Open;

        {*******************************************}
        {* ATRIBUI OS CAMPOS DE USO                *}
        {****************************************AC*}
        cpuCampos := TCamposUso.Create;
        cpuCampos.AdicionaCampos(qryChqEmi, 'CHQEMI');

        {*******************************************}
        {* VARIÁVEIS USADAS NO CNFCHQ              *}
        {****************************************AC*}
        strExtenso := fRetExtensoNumero(AnsiReplaceStr(FieldByName('EMI_VALBAI').AsString,'-',''));
        strValExt  := fPadR(AnsiUpperCase(Copy(strExtenso,1,95)) + '++',93,'*'); //Valor por Extenso
        strValExt2 := fPadR(AnsiUpperCase(Copy(strExtenso,96,95)),100,'*'); //Valor por Extenso2
        If (Not fEmptyStr(fTiraCaracEspeciais(strDtaBom))) Then //Bom Para
          strBomPar := 'BOM PARA : ' + strDtaBom
        Else
          strBomPar := '';

        If (Not fEmptyStr(fTiraCaracEspeciais(strDtaEmi))) Then //Bom Para
          strDtEmis := 'EMISSAO  : ' + strDtaEmi
        Else
          strDtEmis := '';

        strNomFav  := strFavore; //Favorecido
        strDtaBai  := FormatDateTime('dd              mmmm             yyyy', StrToDateDef(FieldByName('EMI_DTABAI').AsString, 0)); //Data Emissão

        {**********************************************}
        {* ARMAZENO ESSAS VARIAVEIS PARA PODER USA-LA *}
        {* NA EMISSAO DA COPIA DO CHEQUE              *}
        {*******************************************AC*}
        fltValChq := FieldByName('EMI_VALBAI').AsFloat;
        strCidChq := FieldByName('CID_NOMCID').AsString;
        strNomPor := strPorBai;
      End;
      {*******************************************}
      {* FILA DE IMPRESSAO                       *}
      {****************************************AC*}
      qryCfgRel := fCriaQuery;

      pCarregaConfImpr(qryCfgRel, strNomForm + '_CNF');

      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
      strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

      FreeAndNil(qryCfgRel);

      {*******************************************}
      {* IMPRIME CHEQUE                          *}
      {****************************************AC*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CNFCHQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CNF_CODBCO = :CODBCO AND ';
      strSQL := strSQL + '  CNF_CODEMP = :CODEMP     ';
      strSQL := strSQL + ' ORDER BY CNF_IDENTI, CNF_LINIMP, CNF_COLIMP ';

      qryCnfChq := fCriarQuery(strSQL);
      With qryCnfChq Do
      Begin
        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;
        First;

        While Not Eof Do
        Begin
          pI_Linhas(frmQckCopiaCheque, cpuCampos, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, qryCnfChq);
        End;

      End;
      FreeAndNil(qryCnfChq);

      If Assigned(cpuCampos) Then
        FreeAndNil(cpuCampos);

    End;

    FreeAndNil(qryChqEmi);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeCheque]');
    End;
  End;

end;

end.
