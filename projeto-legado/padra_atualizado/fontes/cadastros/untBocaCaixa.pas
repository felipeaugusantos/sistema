unit untBocaCaixa;

interface

uses Classes, Uni, UniClientDataSet, UniDataSetProvider, DB, ComCtrls,
  untTypesSistema, Vcl.StdCtrls, untFastPrintEditor, untRecBaixaBocaCaixa;

const
    arrColunas : array of char = ['A','B','C','D','E','F','G','H','I','J','K',
                                  'L','M','N','O','P','Q','R','S','T','U','V',
                                  'W','X','Y','Z'];

Type
  TInconsistencia = class
  public
    class function fValidaInconsistencia(intLinha : Integer;
     strColuna : String; strValor : String; enumTipValor : TFieldType; blnRequerido : Boolean = False) : String;
    class function fTrataCampoRequired(strValor : string) : string;
    class function fTrataCampoNumerico(strValor : string) : string;
  end;

  TBcaCai = Class(TComponent)
  Private
    FCodIte: String;
    FPreMin: Double;
    FComVar: Double;
    FCodGru: String;
    FCodPro: String;
    FCodMar: String;
    FCodFor: String;
    FDesIni: String;
    FDesFin: String;
    FRefere: String;
    FRefFin: String;
    FCodUni: String;
    FCodEmp: String;
    FDtaCad: String;
    FSeqGer: String;
    // variáveis específicas da baixa
    FQtdIte: String;
    FVlrTot: Double;
    FVlrCom: Double;
    FEmpBai: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodVen: String;
    FNomTab: String;
    FNomFrm: String;
    FTipImp: String;
    FFilImp: String;
    FDocImp: String;
    FIteImp: String;
    // variáveis do relatorio - boca de caixa por vendedor
    FDtaIni: String;
    FDtaFin: String;

    FTipAlt: TTipAltBoca;

    editorFast: TFastPrintFileEditor;
    RecBaixaBocaCaixa : TRecBaixaBocaCaixa;

    FarrLinGru : TConsultasArray;
    FarrCodPro : TConsultasArray;
    FarrCodMar : TConsultasArray;
    FarrCodFor : TConsultasArray;

    qryCfgRel: TUniQuery;

    Function fSQLBcaCaiAlteracao: String;

    function getPreMin: String;
    function getComVar: String;
    function getVlrTot: String;
    function getVlrCom: String;

    procedure setPreMin(const Value: String);
    procedure setComVar(const Value: String);
    procedure setVlrTot(const Value: String);
    procedure setVlrCom(const Value: String);

    {**************************************}
    {* PROCEDURES E FUNÇÕES GERAIS        *}
    {***********************************AF*}
    procedure pAfterOpen(DataSet: TDataSet);

    function fRetCmpVen: String;
    function fImprimeReciboLayout( qryRec : TUniQuery): Boolean;

  Public

    qryBcaCai: TUniQuery;
    cdsBcaCai: TUniClientDataSet;

    qryBcaCaiAlt: TUniQuery;

    qryBaixaBcaCai: TUniQuery;
    dspBaixaBcaCai: TUniDataSetProvider;
    cdsBaixaBcaCai: TUniClientDataSet;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    property strCodIte: String Read FCodIte   Write FCodIte;
    property strPreMin: String Read getPreMin Write setPreMin;
    property strComVar: String Read getComVar Write setComVar;
    property strCodGru: String Read FCodGru   Write FCodGru;
    property strCodPro: String Read FCodPro   Write FCodPro;
    property strCodMar: String Read FCodMar   Write FCodMar;
    property strCodFor: String Read FCodFor   Write FCodFor;
    property strDesIni: String Read FDesIni   Write FDesIni;
    property strDesFin: String Read FDesFin   Write FDesFin;
    property strRefere: String Read FRefere   Write FRefere;
    property strRefFin: String Read FRefFin   Write FRefFin;
    property strCodUni: String Read FCodUni   Write FCodUni;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDtaCad: String Read FDtaCad   Write FDtaCad;
    property strQtdIte: String Read FQtdIte   Write FQtdIte;
    property strVlrTot: String Read getVlrTot Write setVlrTot;
    property strVlrCom: String Read getVlrCom Write setVlrCom;
    property strEmpBai: String Read FEmpBai   Write FEmpBai;
    property strNumDoc: String Read FNumDoc   Write FNumDoc;
    property strEspDoc: String Read FEspDoc   Write FEspDoc;
    property strCodVen: String Read FCodVen   Write FCodVen;
    property strNomTab: String Read FNomTab   Write FNomTab;
    property strNomFrm: String Read FNomFrm   Write FNomFrm;
    property strTipImp: String Read FTipImp   Write FTipImp;
    property strFilImp: String Read FFilImp   Write FFilImp;
    property strDtaIni: String Read FDtaIni   Write FDtaIni;
    property strDtaFin: String Read FDtaFin   Write FDtaFin;
    property strDocImp: String Read FDocImp   Write FDocImp;
    property strIteImp: String Read FIteImp   Write FIteImp;
    property strSeqGer: String Read FSeqGer   Write FSeqGer;

    property arrLinGru : TConsultasArray Read FarrLinGru Write FarrLinGru;
    property arrCodPro : TConsultasArray Read FarrCodPro Write FarrCodPro;
    property arrCodMar : TConsultasArray Read FarrCodMar Write FarrCodMar;
    property arrCodFor : TConsultasArray Read FarrCodFor Write FarrCodFor;

    property talTipAlt: TTipAltBoca Read FTipAlt Write FTipAlt;

    Function fCarregaItensAlteracao: Boolean;
    Function fGravaAlteracao(ProgressBar: TProgressBar): Boolean;

    procedure pGeraRelatorioBocaCaixa(intOrdem: Integer); // dados para o relatorio
    procedure pCriaTemporaria; // cria o clientdatset para armazenar os itens / grid
    procedure pAdicionaItem(strTipo       : String;
                            edtLinhaGrupo : TCustomEdit = Nil;
                            edtProduto    : TCustomEdit = Nil;
                            edtMarca      : TCustomEdit = Nil;
                            edtFornecedor : TCustomEdit = Nil); // adiciona item

    procedure pDeletaItem(strItem: String; strEmp: String); // deleta item
    procedure pIncluiItemGrid;  // inclui item no grid
    procedure pAlteraItemGrid;  // altera item do grid
    function  fItemJaInclusoGrid(strCodIte: String): Boolean; // verifica se o item já está incluso no grid
    function  fItemJaInclusoTab(strCodIte: String; strCodEmp: String): Boolean; // verifica se o item já esta incluso na tabela
    function  fMontaSQL(strTipo: String): String; // monta o sql do insert ou update na tabela
    procedure pGravaBcaCaixa(strEmpresa:String; blnDeleta : Boolean = False); // grava os dados na tabela CADBCA
    procedure pCarregaDadosBaixa(strCodVen: String); // carrega os dados no grid para a baixa
    procedure pGravaBaixaBcaCaixa; // grava a baixa
    procedure pImprimeReciboVendedor; // imprimi recibo da baixa
    procedure pGravaCodOperAuxMov;
  End;

implementation

uses SysUtils, Forms, StrUtils, untFuncoesSimples, untQckBocaCaixa,
  untFuncoesConsulta;

{ TBcaCai }

Constructor TBcaCai.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  qryBcaCai := fCriaQuery(Self);

  qryCfgRel := fCriaQuery(Self);

  cdsBcaCai := TUniClientDataSet.Create(Self);
  cdsBcaCai.AfterOpen := pAfterOpen;

  cdsBaixaBcaCai := TUniClientDataSet.Create(Self);
  qryBaixaBcaCai := fCriaQuery(Self);
  dspBaixaBcaCai := TUniDataSetProvider.Create(Self);

  qryBcaCaiAlt := fCriaQuery(Self);

  FDtaCad := DateToStr(VS_Date);

end;

Destructor TBcaCai.Destroy;
begin
  FreeAndNil(qryBcaCai);
  FreeAndNil(cdsBcaCai);
  FreeAndNil(qryBaixaBcaCai);
  FreeAndNil(dspBaixaBcaCai);
  FreeAndNil(cdsBaixaBcaCai);
  FreeAndNil(qryBcaCaiAlt);

  inherited Destroy;
end;

function TBcaCai.getPreMin: String;
begin
  Result := FloatToStrF(FPreMin,ffFixed,12,2);
end;

function TBcaCai.getComVar: String;
begin
  Result := FloatToStrF(FComVar,ffFixed,12,2);
end;

function TBcaCai.getVlrTot: String;
begin
  Result := FloatToStrF(FVlrTot,ffFixed,12,2);
end;

function TBcaCai.getVlrCom: String;
begin
  Result := FloatToStrF(FVlrCom,ffFixed,12,2);
end;

procedure TBcaCai.setPreMin(const Value: String);
begin
  FPreMin := fStrToFloat(Value);
end;

procedure TBcaCai.setComVar(const Value: String);
begin
  FComVar := fStrToFloat(Value);
end;

procedure TBcaCai.setVlrTot(const Value: String);
begin
  FVlrTot := fStrToFloat(Value);
end;

procedure TBcaCai.setVlrCom(const Value: String);
begin
  FVlrTot := fStrToFloat(Value);
end;

procedure TBcaCai.pAfterOpen(DataSet: TDataSet);
begin

  With DataSet Do
  Begin
//    (FieldByName('QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
//    (FieldByName('QTDITE') As TFloatField).EditFormat    := '#,##0.00';

    (FieldByName('PRECUS') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('PRECUS') As TFloatField).EditFormat    := '#,##0.00';

    (FieldByName('PREVEN') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('PREVEN') As TFloatField).EditFormat    := '#,##0.00';

    (FieldByName('PREMIN') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('PREMIN') As TFloatField).EditFormat    := '#,##0.00';

    (FieldByName('COMVAR') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('COMVAR') As TFloatField).EditFormat    := '#,##0.00';
  End;

end;

function TBcaCai.fMontaSQL(strTipo: String): String;
Var
  strSQL : String;
Begin

  If strTipo = 'I' Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' INSERT INTO ';
    strSQL := strSQL + ' CADBCA (';
    strSQL := strSQL + ' BCA_CODITE, ';
    strSQL := strSQL + ' BCA_PREMIN, ';
    strSQL := strSQL + ' BCA_COMVAR, ';
    strSQL := strSQL + ' BCA_CODEMP, ';
    strSQL := strSQL + ' BCA_DTACAD, ';
    strSQL := strSQL + ' AUTOINCREM ';
    strSQL := strSQL + ' ) VALUES ( ';
    strSQL := strSQL + ' :CODITE, ';
    strSQL := strSQL + ' :PREMIN, ';
    strSQL := strSQL + ' :COMVAR, ';
    strSQL := strSQL + ' :CODEMP, ';
    strSQL := strSQL + ' :DTACAD, ';
    strSQL := strSQL + ' :AUTINC ) ';
  End
  Else If strTipo = 'A' Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + ' CADBCA SET ';
    strSQL := strSQL + '   BCA_PREMIN = :PREMIN, ';
    strSQL := strSQL + '   BCA_COMVAR = :COMVAR, ';
    strSQL := strSQL + '   BCA_DTACAD = :DTACAD  ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   BCA_CODITE = :CODITE AND ';
    strSQL := strSQL + '   BCA_CODEMP = :CODEMP ';
  End
  Else If strTipo = 'D' Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' DELETE FROM ';
    strSQL := strSQL + ' CADBCA ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   BCA_CODITE = :CODITE AND ';
    strSQL := strSQL + '   BCA_CODEMP = :CODEMP ';
  End;

  Result := strSQL;
End;

function TBcaCai.fRetCmpVen: String;
begin
  Result := IIF(fCfgSis('BCAVEN', varString)='1', ' DET_CODVEN ', ' DET_CODVE2 ');
end;

procedure TBcaCai.pGravaBcaCaixa(strEmpresa:String; blnDeleta : Boolean = False);
Var
  strSQL : String;
  qryAux : TUniQuery;
Begin

  qryAux := fCriaQuery(Self);
  cdsBcaCai.First;

  While Not cdsBcaCai.Eof Do
  Begin
    Application.ProcessMessages;

    {************************************************************}
    {* VERIFICA SE O ITEM JÁ EXISTE CADASTRADO                  *}
    {* CASO JÁ EXISTA ALTERA OS VALORES PREÇO MÍNIMO E COMISSÃO *}
    {*********************************************************LU*}
    If (Not blnDeleta) Then
    Begin
      If fItemJaInclusoTab(cdsBcaCai.FieldByName('CODITE').AsString,strEmpresa) Then
      Begin
        strSQL := fMontaSQL('A');
        With qryAux Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODITE').AsString := cdsBcaCai.FieldByName('CODITE').AsString;
          ParamByName('PREMIN').AsFloat  := cdsBcaCai.FieldByName('PREMIN').AsFloat;
          ParamByName('COMVAR').AsFloat  := cdsBcaCai.FieldByName('COMVAR').AsFloat;
          ParamByName('DTACAD').AsDate   := StrToDate(strDtaCad);
          ParamByName('CODEMP').AsString := strEmpresa;
          ExecSQL;
        End;
      End
      Else
      Begin
        strSQL := fMontaSQL('I');
        With qryAux Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODITE').AsString := cdsBcaCai.FieldByName('CODITE').AsString;
          ParamByName('PREMIN').AsFloat  := cdsBcaCai.FieldByName('PREMIN').AsFloat;
          ParamByName('COMVAR').AsFloat  := cdsBcaCai.FieldByName('COMVAR').AsFloat;
          ParamByName('CODEMP').AsString := strEmpresa;
          ParamByName('DTACAD').AsDate   := StrToDate(strDtaCad);
          ParamByName('AUTINC').AsString := fRetAutoIncrem('CADBCA',strEmpresa);
          ExecSQL;
        End;
      End;
    End
    Else
    Begin
      If fItemJaInclusoTab(cdsBcaCai.FieldByName('CODITE').AsString,strEmpresa) Then
      Begin
        strSQL := fMontaSQL('D');
        With qryAux Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODITE').AsString := cdsBcaCai.FieldByName('CODITE').AsString;
          ParamByName('CODEMP').AsString := strEmpresa;
          ExecSQL;
        End;
      End;
    End;
    cdsBcaCai.Next;
  End;
  FreeAndNil(qryAux);
End;

procedure TBcaCai.pAdicionaItem(strTipo       : String;
                                edtLinhaGrupo : TCustomEdit = Nil;
                                edtProduto    : TCustomEdit = Nil;
                                edtMarca      : TCustomEdit = Nil;
                                edtFornecedor : TCustomEdit = Nil);
Var
  strSQL,
  strLinhaGrupo,
  strProduto,
  strMarca,
  strFornecedor : String;
begin
  {******************************************************************}
  {* BUSCA AS INFORMAÇÕES DO ITEM E LOCALIZA ELE NO CADASTRO CADITE *}
  {***************************************************************LU*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
  strSQL := strSQL + '  C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  C.ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  C.ITE_CODUNI AS CODUNI, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  I.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  I.ITE_PREVE1 AS PREVEN, ';
  If strTipo = 'A' Then
    strSQL := strSQL + '  B.BCA_DTACAD AS DTACAD, '
  Else
    strSQL := strSQL + '  null AS DTACAD, ';

  If strTipo = 'G' Then
  Begin
    strSQL := strSQL + AnsiReplaceStr(AnsiReplaceStr(strPreMin,'.',''),',','.') + ' AS PREMIN, ';
    strSQL := strSQL + AnsiReplaceStr(AnsiReplaceStr(strComVar,'.',''),',','.') + ' AS COMVAR  ';
  End
  Else
  Begin
    strSQL := strSQL + '  B.BCA_PREMIN AS PREMIN, ';
    strSQL := strSQL + '  B.BCA_COMVAR AS COMVAR ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE C, ';
  strSQL := strSQL + '  ITEGER I, ';
  strSQL := strSQL + '  CADUNI U ';

  If strTipo = 'A' Then
    strSQL := strSQL + ', CADBCA B ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  C.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '  C.ITE_CODUNI = U.UNI_CODUNI AND ';
  strSQL := strSQL + '  C.ITE_ITEATI = "S" AND ';

  If strTipo = 'A' Then
    strSQL := strSQL + '  C.ITE_CODITE = B.BCA_CODITE AND ';

  If strTipo = 'A' Then
    strSQL := strSQL + '  B.BCA_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP ';

  if (strTipo <> 'A') then
  begin
    strSQL := strSQL + fStrLocate(edtProduto,          arrCodPro, 'C.ITE_CODITE', 'CODITE');
    strSQL := strSQL + fStrLocate(edtMarca,            arrCodMar, 'C.ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtFornecedor,       arrCodFor, 'C.ITE_CODFOR', 'CODFOR');
    strSQL := strSQL + fStrLocateLinGru(edtLinhaGrupo, arrLinGru, 'C.ITE_CODGRU', 'CODGRU');
  end
  else
  begin
    {Consulta via tela de pesquisa}
    If (Not fEmptyStr(FCodPro)) Then
      strSQL := strSQL + '  AND C.ITE_CODITE = :CODITE  ';
  end;

  If (Not fEmptyStr(FDesIni)) And (fEmptyStr(FDesFin)) Then
    strSQL := strSQL + '  AND C.ITE_DESITE LIKE :DESITE ';

  If (Not fEmptyStr(FDesIni)) and (Not fEmptyStr(FDesFin)) Then
    strSQL := strSQL + '  AND LEFT(C.ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

  If Not fEmptyStr(FRefere) Then
    strSQL := strSQL + '  AND C.ITE_REFERE = :REFERE ';

  If Not fEmptyStr(FCodUni) Then
    strSQL := strSQL + '  AND C.ITE_CODUNI = :CODUNI ';

  strSQL := strSQL + 'ORDER BY C.ITE_DESITE ';

  With qryBcaCai Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If strTipo <> 'A' Then
      ParamByName('CODEMP').AsString := VS_strCodEmp
    Else
      ParamByName('CODEMP').AsString := FCodEmp;

    if (strTipo <> 'A') then
    begin
      pSetaParam(FCodPro, arrCodPro, strProduto,    'CODITE', qryBcaCai);
      pSetaParam(FCodMar, arrCodMar, strMarca,      'CODMAR', qryBcaCai);
      pSetaParam(FCodFor, arrCodFor, strFornecedor, 'CODFOR', qryBcaCai);
      pSetaParam(FCodGru, arrLinGru, strLinhaGrupo, 'CODGRU', qryBcaCai);
    end
    else
    begin
      {Consulta via tela de pesquisa}
      If (Not fEmptyStr(FCodPro)) Then
        ParamByName('CODITE').AsString := FCodPro;
    end;

    If (Not fEmptyStr(FDesIni)) and (Not fEmptyStr(FDesFin)) Then
    Begin
      ParamByName('MAIOR').AsString := FDesIni;
      ParamByName('DESITE').AsString := FDesIni ;
      ParamByName('DESITE1').AsString := FDesFin ;
    End
    Else
    Begin
      If Not fEmptyStr(FDesIni) Then
        ParamByName('DESITE').AsString := FDesIni + '%';
    End;

    If Not fEmptyStr(FRefere) Then
      ParamByName('REFERE').AsString := FRefere;

    If Not fEmptyStr(FCodUni) Then
      ParamByName('CODUNI').AsString := FCodUni;

    Open;
  End;

  If qryBcaCai.RecordCount = 0 Then
  Begin
    fMensagem('','Nenhum Item foi encontrado!',['&O K'],0);
  End
  Else
  Begin
    While Not qryBcaCai.Eof Do
    Begin
      {**********************************************}
      {* VERIFICA SE O ITEM JÁ ESTA INCLUSO NO GRID *}
      {*******************************************LU*}
      If Not fItemJaInclusoGrid(qryBcaCai.fieldbyname('CODITE').AsString) Then
        pIncluiItemGrid
      Else
        pAlteraItemGrid;
      qryBcaCai.Next;
    End;
  End;

end;

procedure TBcaCai.pIncluiItemGrid;
Begin
  cdsBcaCai.Insert;
  cdsBcaCai.FieldByName('CODITE').AsString := qryBcaCai.fieldbyname('CODITE').AsString;
  cdsBcaCai.FieldByName('DESITE').AsString := qryBcaCai.fieldbyname('DESITE').AsString;
  cdsBcaCai.FieldByName('CODGRU').AsString := qryBcaCai.fieldbyname('CODGRU').AsString;
  cdsBcaCai.FieldByName('CODUNI').AsString := qryBcaCai.fieldbyname('CODUNI').AsString;
  cdsBcaCai.FieldByName('UNIDAD').AsString := qryBcaCai.fieldbyname('UNIDAD').AsString;
  cdsBcaCai.FieldByName('PRECUS').AsFloat  := qryBcaCai.fieldbyname('PRECUS').AsFloat;
  cdsBcaCai.FieldByName('PREVEN').AsFloat  := qryBcaCai.fieldbyname('PREVEN').AsFloat;
  cdsBcaCai.FieldByName('PREMIN').AsFloat  := qryBcaCai.fieldbyname('PREMIN').AsFloat;
  cdsBcaCai.FieldByName('COMVAR').AsFloat  := qryBcaCai.fieldbyname('COMVAR').AsFloat;
  cdsBcaCai.FieldByName('DTACAD').AsString := qryBcaCai.fieldbyname('DTACAD').AsString;
  cdsBcaCai.Post;
End;

procedure TBcaCai.pAlteraItemGrid;
Begin
  cdsBcaCai.Edit;
  cdsBcaCai.FieldByName('PREMIN').AsFloat  := qryBcaCai.fieldbyname('PREMIN').AsFloat;
  cdsBcaCai.FieldByName('COMVAR').AsFloat  := qryBcaCai.fieldbyname('COMVAR').AsFloat;
  cdsBcaCai.Post;
End;

procedure TBcaCai.pCriaTemporaria;
Begin

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 70;
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODGRU';
    DataType := ftString;
    Size := 5;
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODUNI';
    DataType := ftString;
    Size := 2;
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNIDAD';
    DataType := ftString;
    Size := 4;
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PRECUS';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PREVEN';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PREMIN';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'COMVAR';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsBcaCai.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTACAD';
    DataType := ftDate;
  End;

  cdsBcaCai.CreateDataSet;

End;

function TBcaCai.fItemJaInclusoGrid(strCodIte: String): Boolean;
begin
  Result := False;

  If Assigned(cdsBcaCai) Then
  Begin
    cdsBcaCai.First;
    While Not cdsBcaCai.Eof Do
    Begin
      If cdsBcaCai.FieldByName('CODITE').AsString = strCodIte Then
      Begin
        Result := True;
        Exit;
      End
      Else
        cdsBcaCai.Next;
    End;
  End;

end;

function TBcaCai.fItemJaInclusoTab(strCodIte: String; strCodEmp: String): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Result := True;
  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   CADBCA.*, ';
  strSQL := strSQL + '   ITE_CODGRU "BCA_CODGRU"';
  strSQL := strSQL + ' FROM CADBCA ';
  strSQL := strSQL + '   INNER JOIN CADITE ';
  strSQL := strSQL + '     ON BCA_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE               ';
  strSQL := strSQL + '   BCA_CODITE = :CODITE AND ';
  strSQL := strSQL + '   BCA_CODEMP = :CODEMP ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := strCodEmp;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := False;

  FreeAndNil(qryGen);

end;

procedure TBcaCai.pDeletaItem(strItem: String; strEmp: String);
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(Self);

    fStartTransaction;

    strSQL := '';
    strSQL := strSQL + ' SELECT * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADBCA ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   BCA_CODITE = :CODITE AND ';
    strSQL := strSQL + '   BCA_CODEMP = :CODEMP ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODITE').AsString := strItem;
    qryGen.ParamByName('CODEMP').AsString := strEmp;
    qryGen.Open;

    fVerificaIntegridade(Self.Name, 'CADBCA', qryGen, True);

    strSQL := '';
    strSQL := strSQL + ' DELETE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADBCA ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   BCA_CODITE = :CODITE AND ';
    strSQL := strSQL + '   BCA_CODEMP = :CODEMP ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODITE').AsString := strItem;
    qryGen.ParamByName('CODEMP').AsString := strEmp;
    qryGen.ExecSQL;

    fCommit;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TBcaCai.pDeletaItem]');
    End;

  End;

End;

{**************************************************************}
{* GERA O RELATÓRIO DE BOCA DE CAIXA - ITENS EM BOCA DE CAIXA *}
{***********************************************************LU*}
procedure TBcaCai.pGeraRelatorioBocaCaixa(intOrdem: Integer);
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  LEFT(ITE_CODGRU,3) AS LINHA, ';
  strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
  strSQL := strSQL + '  CONCAT(LEFT(I.ITE_CODGRU,3), ".", RIGHT(I.ITE_CODGRU,3)) AS CODGRU, ';
  strSQL := strSQL + '  B.BCA_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  B.BCA_PREMIN AS PREMIN, ';
  strSQL := strSQL + '  B.BCA_COMVAR AS COMVAR, ';
  strSQL := strSQL + '  B.BCA_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS PREVEN, ';
  strSQL := strSQL + '  G.ITE_MARBR1 AS MARBRU, ';
  strSQL := strSQL + '  CONCAT(B.BCA_CODEMP, "-", E.EMP_NOMEMP) AS NOMEMP ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADBCA B';
  strSQL := strSQL + '  JOIN CADITE I ON (B.BCA_CODITE=I.ITE_CODITE) ';
  strSQL := strSQL + '  JOIN CADUNI U ON (I.ITE_CODUNI=U.UNI_CODUNI) ';
  strSQL := strSQL + '  JOIN CADEMP E ON (B.BCA_CODEMP=E.EMP_CODEMP) ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = B.BCA_CODEMP ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  1 = 1 ';

  If Not fEmptyStr(strCodGru) Then
  Begin
    If RightStr(strCodGru,3) = '000' Then
      strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
    Else
      strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '  AND B.BCA_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(B.BCA_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(strCodFor) Then
    strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';

  If Not fEmptyStr(strCodMar) Then
    strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';

  If Not fEmptyStr(strDesIni) Then
  Begin
    If (Not fEmptyStr(strDesFin)) Then
      strSQL := strSQL + ' AND LEFT(I.ITE_DESITE, LENGTH(:MAIORDES)) BETWEEN :DESITE AND :DESFIN '
    Else
      strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(strRefere) Then
  Begin
    If (Not fEmptyStr(strRefFin)) Then
      strSQL := strSQL + ' AND LEFT(I.ITE_REFERE, LENGTH(:MAIORREF)) BETWEEN :REFERE AND :REFFIN '
    Else
      strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
  End;

  strSQL := strSQL + ' ORDER BY ';

  Case intOrdem Of
    1: strSQL := strSQL + ' CODEMP, DESITE ';
    2: strSQL := strSQL + ' CODEMP, LINHA, CODGRU, CODITE, DESITE ';
  End;

  With qryBcaCai Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := FCodEmp;

    If Not fEmptyStr(strCodGru) Then
      ParamByName('CODGRU').AsString := FCodGru;

    If Not fEmptyStr(strCodFor) Then
      ParamByName('CODFOR').AsString := FCodFor;

    If Not fEmptyStr(strCodMar) Then
      ParamByName('CODMAR').AsString := FCodMar;

    If Not fEmptyStr(strDesIni) Then
    Begin
      If (Not fEmptyStr(strDesFin)) Then
      Begin
        ParamByName('DESITE').AsString := strDesIni;
        ParamByName('DESFIN').AsString := strDesFin;

        If Length(strDesIni) > Length(strDesFin) Then
          ParamByName('MAIORDES').AsString := strDesIni
        Else
          ParamByName('MAIORDES').AsString := strDesFin;

      End
      Else
        ParamByName('DESITE').AsString := strDesIni + '%';
    End;

    If Not fEmptyStr(strRefere) Then
    Begin
      If (Not fEmptyStr(strRefFin)) Then
      Begin
        ParamByName('REFERE').AsString := strRefere;
        ParamByName('REFFIN').AsString := strRefFin;

        If Length(strRefere) > Length(strRefFin) Then
          ParamByName('MAIORREF').AsString := strRefere
        Else
          ParamByName('MAIORREF').AsString := strRefFin;

      End
      Else
        ParamByName('REFERE').AsString := strRefere + '%';
    End;

    Open;

    If IsEmpty Then
      Raise Exception.Create('Não há dados para gerar relatório!');

  End;

end;

procedure TBcaCai.pCarregaDadosBaixa(strCodVen: String);
Var
  strSQL : String;
  fltVlrTot: Double;
  fltVlrCom: Double;
Begin
  cdsBaixaBcaCai.Filtered := False;
  cdsBaixaBcaCai.Close;

  dspBaixaBcaCai.DataSet := qryBaixaBcaCai;
  cdsBaixaBcaCai.SetProvider(dspBaixaBcaCai);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '   DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + fRetCmpVen + ' AS CODVEN, ';
  strSQL := strSQL + '   DET_NUMDOC AS NRODOC, ';
  strSQL := strSQL + '   DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '   DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   DET_CODITE AS CODITE, ';
  strSQL := strSQL + '   DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '   UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '   DET_QTDITE AS QTDITE, ';

  strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5, -((DET_TOTITE - DET_DESESP - DET_DESCFF)/DET_QTDITE), ((DET_TOTITE - DET_DESESP - DET_DESCFF)/DET_QTDITE)) AS VLRUNI, ';
  strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF),(DET_TOTITE - DET_DESESP - DET_DESCFF)) AS VLRTOT, ';
  strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5, -DET_BCACOM, DET_BCACOM) AS VLRCOM, ';

  strSQL := strSQL + '   MOVDET.AUTOINCREM, ';
  strSQL := strSQL + '   "MOVDET" AS NOMTAB, ';
  strSQL := strSQL + '   " " AS MARDES, ';
  strSQL := strSQL + '   MOVDET.DET_SEQGER AS SEQGER ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + '   LEFT JOIN CADUNI ON (DET_UNIDAD=UNI_CODUNI) ';
  strSQL := strSQL + ' WHERE ';
  If fCfgSis('PERBAI', varString) = '1' Then
    strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';

  strSQL := strSQL + fRetCmpVen + ' = :CODVEN AND ';
  strSQL := strSQL + '   DET_UNIDAD IS NOT NULL AND ';
  strSQL := strSQL + '   DET_BCACOM <> 0 AND ';
  strSQL := strSQL + '   DET_DTABCA IS NULL AND ';
  strSQL := strSQL + '   DET_ESPDOC <> "PR" ';

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   CODVEN ';

  With qryBaixaBcaCai Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If fCfgSis('PERBAI', varString) = '1' Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    ParamByName('CODVEN').AsString := strCodVen;
    Open;
  End;

  pSetaClient(qryBaixaBcaCai);
  cdsBaixaBcaCai.Open;

  TFloatField(cdsBaixaBcaCai.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsBaixaBcaCai.FieldByName('VLRUNI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsBaixaBcaCai.FieldByName('VLRTOT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsBaixaBcaCai.FieldByName('VLRCOM')).DisplayFormat := '#,##0.00';

  cdsBaixaBcaCai.First;
  fltVlrTot := 0;
  fltVlrCom := 0;

  While Not cdsBaixaBcaCai.Eof Do
  Begin
    fltVlrTot := fltVlrTot + cdsBaixaBcaCai.fieldbyname('VLRTOT').AsFloat;
    fltVlrCom := fltVlrCom + cdsBaixaBcaCai.fieldbyname('VLRCOM').AsFloat;
    cdsBaixaBcaCai.Next;
  End;
  cdsBaixaBcaCai.First;

  FQtdIte := IntToStr(cdsBaixaBcaCai.RecordCount);
  FVlrTot := fltVlrTot;
  FVlrCom := fltVlrCom;
End;

procedure TBcaCai.pGravaBaixaBcaCaixa;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  qryGen := fCriaQuery(Self);

  try
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + FNomTab ;
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   DET_DTABCA = :DTABCA ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + fRetCmpVen + ' = :CODVEN AND ';
    strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   DET_CODITE = :CODITE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTABCA').AsDateTime := VS_Date;

      ParamByName('CODEMP').AsString   := FEmpBai;
      ParamByName('CODVEN').AsString   := FCodVen;
      ParamByName('NUMDOC').AsString   := FNumDoc;
      ParamByName('ESPDOC').AsString   := FEspDoc;
      ParamByName('CODITE').AsString   := FCodIte;
      ExecSQL;
    End;
  finally
    FreeAndNil(qryGen);
  end;
End;

procedure TBcaCai.pGravaCodOperAuxMov;
var
  qryAuxMov: TUniQuery;
begin
  qryAuxMov := fCriaQuery(Self);

  try
    qryAuxMov.Close;
    qryAuxMov.SQL.Clear;

    qryAuxMov.SQL.Text := ' UPDATE AUXMOV A              '+
                          ' SET A.AUX_OPEBCA   = :OPEBCA '+
                          ' WHERE A.AUX_SEQGER = :SEQGER ';

    qryAuxMov.ParamByName('OPEBCA').AsString := strLoginUsuarioLogado;
    qryAuxMov.ParamByName('SEQGER').AsString := FSeqGer;
    qryAuxMov.ExecSQL;
  finally
    FreeAndNil(qryAuxMov);
  end;
end;

procedure TBcaCai.pImprimeReciboVendedor;
Var
  frmQckBocaCaixa: TfrmQckBocaCaixa;
  strSQL    : String;
  qryRecibo : TUniQuery;
Begin

  If fEmptyStr(FDocImp) Or fEmptyStr(FIteImp) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '   DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   CONCAT("ENDERECO: ", EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS ENDERE, ';
  strSQL := strSQL + '   CONCAT("CIDADE: ", CID_NOMCID, " - ", CID_ESTADO, " - CEP: ", EMP_C_E_P_) AS NOMCID, ';
  strSQL := strSQL + '   CONCAT("FONE: ", EMP_FONE01, " - FAX: ", EMP_F_A_X_) AS FONE, ';
  strSQL := strSQL + '   EMP_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '   EMP_I_E_S_ AS IES, ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '   OPE_NOMOPE AS NOMVEN, ';
  strSQL := strSQL + '   CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '   DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   DET_CODITE AS CODITE, ';
  strSQL := strSQL + '   CONCAT(DET_CODITE, "-", DET_DESCRI) AS ITEM, ';
  strSQL := strSQL + '   UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '   DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5, -((DET_TOTITE - DET_DESESP - DET_DESCFF)/DET_QTDITE), ((DET_TOTITE - DET_DESESP - DET_DESCFF)/DET_QTDITE)) AS VLRUNI, ';
  strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)) AS VLRTOT, ';
  strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5, -DET_BCACOM, DET_BCACOM) AS VLRCOM ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + '   JOIN CADUNI ON (DET_UNIDAD=UNI_CODUNI) ';
  strSQL := strSQL + '   JOIN CADOPE ON (' + fRetCmpVen + '=OPE_CODOPE) ';
  strSQL := strSQL + '   JOIN CADEMP ON (' + VS_strCodEmp +'=EMP_CODEMP) ';
  strSQL := strSQL + '   JOIN CADCID ON (EMP_CODCID=CID_CODCID) ';
  strSQL := strSQL + ' WHERE ';
  If fCfgSis('PERBAI', varString) = '1' Then
    strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';

  strSQL := strSQL + fRetCmpVen + ' = :CODVEN AND ';
  strSQL := strSQL + '   DET_DTABCA = :DTABCA AND ';
  strSQL := strSQL + '   DET_CODITE IN (' + FIteImp + ') AND ';
  strSQL := strSQL + '   DET_NUMDOC IN (' + FDocImp + ') ';

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   NUMDOC, CODITE ';

  qryRecibo := fCriaQuery(Self);

  With qryRecibo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If fCfgSis('PERBAI', varString) = '1' Then
      ParamByName('CODEMP').AsString   := VS_strCodEmp;

    ParamByName('CODVEN').AsString   := FCodVen;
    ParamByName('DTABCA').AsDateTime := VS_Date;
    Open;
  End;

  If Not fImprimeReciboLayout(qryRecibo) Then
  Begin

    Try
      pCriarFormularios(TfrmQckBocaCaixa, frmQckBocaCaixa);
      frmQckBocaCaixa.frxDados.DataSet := qryRecibo;
      qryRecibo.RecordCount;

      frmQckBocaCaixa.frxReciboBaixaM.PrintOptions.Printer   := AnsiReplaceStr(FFilImp,'\\' + fRetNomeRede + '\','');
      frmQckBocaCaixa.frxReciboBaixaJ.PrintOptions.Printer   := AnsiReplaceStr(FFilImp,'\\' + fRetNomeRede + '\','');

      frmQckBocaCaixa.frxReciboBaixaM.PrintOptions.ShowDialog := fEmptyStr(FFilImp);
      frmQckBocaCaixa.frxReciboBaixaJ.PrintOptions.ShowDialog := fEmptyStr(FFilImp);

      If FTipImp = 'M' Then
      Begin
        If fEmptyStr(FFilImp) Then
          pPreviewReport(strNomFrm, 'Boca de caixa - Recibo do vendedor', frmQckBocaCaixa.frxReciboBaixaM)
        Else
          If frmQckBocaCaixa.frxReciboBaixaM.PrepareReport Then
            pPrintReport(strNomFrm, 'Boca de caixa - Recibo do vendedor', FFilImp, frmQckBocaCaixa.frxReciboBaixaM);
      End
      Else
      Begin
        If fCfgSis('ORBXBC') = '1' Then
        Begin
          If fEmptyStr(FFilImp) Then
            pPreviewReport(strNomFrm, 'Boca de caixa - Recibo do vendedor', frmQckBocaCaixa.frxReciboBaixaJRetrato)
          Else
            If frmQckBocaCaixa.frxReciboBaixaJRetrato.PrepareReport Then
              pPrintReport(strNomFrm, 'Boca de caixa - Recibo do vendedor', FFilImp, frmQckBocaCaixa.frxReciboBaixaJRetrato);
        End
        Else
        Begin
          If fEmptyStr(FFilImp) Then
            pPreviewReport(strNomFrm, 'Boca de caixa - Recibo do vendedor', frmQckBocaCaixa.frxReciboBaixaJ)
          Else
            If frmQckBocaCaixa.frxReciboBaixaJ.PrepareReport Then
              pPrintReport(strNomFrm, 'Boca de caixa - Recibo do vendedor', FFilImp, frmQckBocaCaixa.frxReciboBaixaJ);
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TBcaCai.pImprimeReciboVendedor]');
    End;

    pDestroiModulo(frmQckBocaCaixa);
  End;

  FreeAndNil(qryRecibo);

End;

Function TBcaCai.fSQLBcaCaiAlteracao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  B.AUTOINCREM,         ';
  strSQL := strSQL + '  BCA_CODITE AS CODITE, ';
  strSQL := strSQL + '  ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  BCA_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  BCA_PREMIN AS PREATU, ';
  strSQL := strSQL + '  BCA_COMVAR AS COMATU, ';

  Case talTipAlt Of
    talFator : Begin
                 If Not fEmptyStr(strPreMin) Then
                   strSQL := strSQL + '  BCA_PREMIN * :PREMIN AS PRENOV, ';

                 If Not fEmptyStr(strComVar) Then
                   strSQL := strSQL + '  BCA_COMVAR * :COMVAR AS COMNOV  ';
               End;

    talValor : Begin
                 If Not fEmptyStr(strPreMin) Then
                   strSQL := strSQL + '  0.0000 + :PREMIN AS PRENOV, ';

                 If Not fEmptyStr(strComVar) Then
                   strSQL := strSQL + '  0.0000 + :COMVAR AS COMNOV  ';
               End;
  End;

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADBCA B ';
  strSQL := strSQL + '   INNER JOIN CADITE ON ITE_CODITE = BCA_CODITE ';
  strSQL := strSQL + ' WHERE TRUE ';
  strSQL := strSQL + '  AND ITE_ITEATI = "S" ';

  If Not fEmptyStr(strCodGru) Then
  Begin
    If RightStr(strCodGru,3) = '000' Then
      strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
    Else
      strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(strCodPro) Then
    strSQL := strSQL + '  AND BCA_CODITE = :CODPRO ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '  AND BCA_CODEMP = :CODEMP ';

  If Not fEmptyStr(strCodFor) Then
    strSQL := strSQL + '  AND ITE_CODFOR = :CODFOR ';

  If Not fEmptyStr(strCodMar) Then
    strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

  If Not fEmptyStr(strCodUni) Then
    strSQL := strSQL + '  AND ITE_CODUNI = :CODUNI ';

  If Not fEmptyStr(strDesIni) Then
  Begin
    If (Not fEmptyStr(strDesFin)) Then
      strSQL := strSQL + ' AND LEFT(ITE_DESITE, LENGTH(:MAIORDES)) BETWEEN :DESITE AND :DESFIN '
    Else
      strSQL := strSQL + '  AND ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(strRefere) Then
  Begin
    If (Not fEmptyStr(strRefFin)) Then
      strSQL := strSQL + ' AND LEFT(ITE_REFERE, LENGTH(:MAIORREF)) BETWEEN :REFERE AND :REFFIN '
    Else
      strSQL := strSQL + '  AND ITE_REFERE LIKE :REFERE ';
  End;

  Result := strSQL;
End;

Function TBcaCai.fCarregaItensAlteracao: Boolean;
Begin
  Try
    With qryBcaCaiAlt Do
    Begin
      Close;

      SQL.Text := fSQLBcaCaiAlteracao;

      If Not fEmptyStr(strCodGru) Then
        ParamByName('CODGRU').AsString := FCodGru;

      If Not fEmptyStr(strCodPro) Then
        ParamByName('CODPRO').AsString := FCodPro;

      If Not fEmptyStr(strCodFor) Then
        ParamByName('CODFOR').AsString := FCodFor;

      If Not fEmptyStr(strCodMar) Then
        ParamByName('CODMAR').AsString := FCodMar;

      If Not fEmptyStr(strCodUni) Then
        ParamByName('CODUNI').AsString := FCodUni;

      If Not fEmptyStr(strDesIni) Then
      Begin
        If (Not fEmptyStr(strDesFin)) Then
        Begin
          ParamByName('DESITE').AsString := strDesIni;
          ParamByName('DESFIN').AsString := strDesFin;

          If Length(strDesIni) > Length(strDesFin) Then
            ParamByName('MAIORDES').AsString := strDesIni
          Else
            ParamByName('MAIORDES').AsString := strDesFin;

        End
        Else
          ParamByName('DESITE').AsString := strDesIni + '%';
      End;

      If Not fEmptyStr(strRefere) Then
      Begin
        If (Not fEmptyStr(strRefFin)) Then
        Begin
          ParamByName('REFERE').AsString := strRefere;
          ParamByName('REFFIN').AsString := strRefFin;

          If Length(strRefere) > Length(strRefFin) Then
            ParamByName('MAIORREF').AsString := strRefere
          Else
            ParamByName('MAIORREF').AsString := strRefFin;

        End
        Else
          ParamByName('REFERE').AsString := strRefere + '%';
      End;

      If Not fEmptyStr(strPreMin) Then
        ParamByName('PREMIN').AsFloat := fStrToFloat(strPreMin);

      If Not fEmptyStr(strComVar) Then
        ParamByName('COMVAR').AsFloat := fStrToFloat(strComVar);

      Open;

      (FieldByName('PREATU') As TFloatField).DisplayFormat := '#,###0.00';
      (FieldByName('COMATU') As TFloatField).DisplayFormat := '#,###0.00';

      If Not fEmptyStr(strPreMin) Then
        (FieldByName('PRENOV') As TFloatField).DisplayFormat := '#,###0.00';

      If Not fEmptyStr(strComVar) Then
        (FieldByName('COMNOV') As TFloatField).DisplayFormat := '#,###0.00';

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TBcaCai.fCarregaItensAlteracao]');
    End;
  End;

End;

Function TBcaCai.fGravaAlteracao(ProgressBar: TProgressBar): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Try

    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + ' CADBCA SET ';

    If fStrToFloat(strPreMin) > 0 Then
    Begin
      strSQL := strSQL + '   BCA_PREMIN = :PREMIN ';

      If fStrToFloat(strComVar) > 0 Then
        strSQL := strSQL + '  , ';

    End;

    If fStrToFloat(strComVar) > 0 Then
      strSQL := strSQL + '   BCA_COMVAR = :COMVAR  ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   AUTOINCREM = :AUTINC ';

    qryGen := fCriaQuery;
    qryGen.SQL.Text := strSQL;


    With qryBcaCaiAlt Do
    Begin
      ProgressBar.Max := RecordCount;
      ProgressBar.Position := 0;

      fStartTransaction;
      
      DisableControls;
      First;
      While Not Eof Do
      Begin
        qryGen.Close;

        If fStrToFloat(strPreMin) > 0 Then
          qryGen.ParamByName('PREMIN').AsFloat := FieldByName('PRENOV').AsFloat;

        If fStrToFloat(strComVar) > 0 Then
          qryGen.ParamByName('COMVAR').AsFloat := FieldByName('COMNOV').AsFloat;

        qryGen.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        qryGen.ExecSQL;

        Next;

        ProgressBar.StepBy(1);
      End;
      EnableControls;

      fCommit;

    End;

    FreeAndNil(qryGen);

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TBcaCai.fGravaAlteracao]');
    End;
  End;

End;

function TBcaCai.fImprimeReciboLayout( qryRec : TUniQuery): Boolean;
Var
  blnEmpty : Boolean;
  cdsRec   : TUniClientDataSet;
begin

  cdsRec   := fCriaClientDatset(qryRec);

  editorFast := TFastPrintFileEditor.Create(Self);

  RecBaixaBocaCaixa  := TRecBaixaBocaCaixa.CreateInstance(cdsRec);
  RecBaixaBocaCaixa.ModoProducao := True;
  editorFast.pSetFastPrintFile(RecBaixaBocaCaixa);
  blnEmpty := RecBaixaBocaCaixa.IsEmpty;
  RecBaixaBocaCaixa.pSetFastType(strTipImp);

  Result := False;

  If Not blnEmpty Then
  Begin

    If editorFast.fLoadReport Then
    Begin

      // editorFast.intNumeroVias := IIf(strRecctr = 'N', fCfgSis('CTRVIA', varInteger), 1);
      editorFast.pConfigPrinter;
      editorFast.pPrint;
      Result := True;
    End;

  End;
  FreeAndNil(editorFast);
end;

class function TInconsistencia.fTrataCampoNumerico(strValor : string): string;
var
  curOut: Currency;
begin
  Result := EmptyStr;
  strValor := AnsiReplaceStr(strValor, '.', ',');

  if not TryStrToCurr(strValor, curOut) then
    Result := 'Informado valor incorreto em campo numérico. Valor Informado: ' + strValor;
end;

class function TInconsistencia.fTrataCampoRequired(strValor : string): string;
var
  intOut : Integer;
begin
  intOut := 0;
  Result := EmptyStr;

  if fEmptyStr(strValor) then
  begin
   Result :=  'Campo obrigatório e o mesmo não foi informado. Codigo Informado: ' + strValor;
   Exit;
  end;

  if not TryStrToInt(strValor, intOut) then
  begin
    Result := 'Campo Codigo está informado incorretamente. Codigo Informado: ' + strValor;
    Exit;
  end;

  strValor := FormatFloat('00000', intOut);
  if fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [strValor]) = '' then
    Result := 'Codigo do produto não encontrado. Codigo: ' + strValor;
end;

class function TInconsistencia.fValidaInconsistencia(intLinha : Integer;
 strColuna : String; strValor : String;
 enumTipValor : TFieldType; blnRequerido : Boolean): String;
var
  strLinhaColuna : string;
begin
  strLinhaColuna := ' Linha: ' + IntToStr(intLinha) + ' Coluna: ' + strColuna + ';';

  if blnRequerido then
    Result := IIF(fTrataCampoRequired(strValor).IsEmpty, EmptyStr, fTrataCampoRequired(strValor) + strLinhaColuna)
  else
    Result := IIF(fTrataCampoNumerico(strValor).IsEmpty, EmptyStr, fTrataCampoNumerico(strValor) + strLinhaColuna);
end;

end.

