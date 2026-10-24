unit untFuncTinta;

interface

uses  SysUtils, Forms, Classes, Uni, UniClientDataSet, StrUtils, untTypesSistema,
      untFuncoesSimples, untIConsultaTinta , DB, untITintasDeMaquina, untIConfTinta,
      untIConsulta, untITransferencias, untIFatOrdProTintaMaquina, untIConfEmb,
      UniDataSetProvider, untILibTintaFactory, untIFuncoesCRM,
      untIExecutaSQLReplicacaoTinta, untILibTintaDllRelacao,
      untIFatDefineLotesPedidoWMS, untILiberacao, untIFuncoesSaldos;

Const
  DLL_TINTA = 'AutcomTinta.dll';

{*******************************************}
{* FUNÇÕES AUXILIARES PARA O AUTTIN        *}
{***14/04/2008***************************MV*}
procedure pRetornaPrecos(Const strCodIte: String; Var fltPreCus, fltMargem,
  fltPreVen: Double);
function fCsvToClientDataSet(strNomArq, strDelimit: String): TUniClientDataSet;
function fGeTUniClientDataSet(strSql: string; strIndice: string; blnOpen: Boolean): TUniClientDataSet;
function fGetInsert(strNomTab: String): String;
procedure pAtualizaProCodAutInc(strNomeTabela: string; intAutoInc: Integer);
procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);

function fItemAtivo(Const strCodIte: String): Boolean;
function fGetDescricaoProdutoTinta(const strCodIte: string): string;

procedure pEnviarLogRep(strCodite : string;
                        strIdePro : string);

function fZerarCNV_ML( strCodite : String ;
                       strIdePro : string ) : Boolean;

function fExisteValorNoCampo(valor: Variant; strCampo, strTabela: String; strCondicao: String = ''): Boolean;

procedure pSetaParametros(dicParametros: TDicionario;
                          fGrvMovGer: TfGravaMovGer;
                          fGrvMovDet: TfGravaMovDet;
                          recModulos: TRecModulosAutcom;
                          objTransf: ITransferencias = nil;
                          objOrdPro: IFatOrdProTintaMaquina = nil; intDebugH: Byte = 0;
                          objLibera: ILiberacao = nil;
                          objTraceViewer: ITraceViewer = nil;
                          objExecSQL: IExecutaSQLReplicacaoTinta = nil;
                          objLotePedWMS: IFatDefineLotesPedidoWMS = nil;
                          objFuncoesCRM: IFuncoesCRM = nil;
                          objFuncoesSaldos : IFuncoesSaldos = nil;
                          fExecutarConsulta: TfConsulta = nil;
                          blnModoClassico: Boolean = True;
                          pImprimeImpFat   : TImprimeImpFatTin = Nil); stdcall; external DLL_TINTA name 'pSetaParametros';

function fRetornaTintasDisponiveis(lstTintas: TStringList; strNomArq: String): Boolean; stdcall; external DLL_TINTA name 'fRetornaTintasDisponiveis';

function fGetConsultaTinta(strIdePro: String): IConsultaTinta; stdcall; external DLL_TINTA name 'fGetConsultaTinta';
function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina; stdcall; external DLL_TINTA name 'fGetTintasdeMaquina';
function fGetConfTinta(strIdePro: String): IConfTinta; stdcall; external DLL_TINTA name 'fGetConfTinta';
function fGetConfEmb(strIdePro: String): IConfEmb; stdcall; external DLL_TINTA name 'fGetConfEmb';
function fGetIndicesTinta(strIdePro: String): IConsultaIndices; stdcall external DLL_TINTA name 'fGetIndicesTinta';
function fRetornaNomeTinta(strIdePro: String; blnExiLib: Boolean = True): String; stdcall external DLL_TINTA name 'fRetornaNomeTinta';
function fRetornaSiglaTinta(strIdePro: String; blnExiLib: Boolean = True): String; stdcall; external DLL_TINTA name 'fRetornaSiglaTinta';
function GetLibTintaFactory(): ILibTintaFactory; stdcall; external DLL_TINTA name 'GetLibTintaFactory';
function IsTintaExistente(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean; stdcall; external DLL_TINTA name 'IsTintaExistente';



{*************}
{* CONSULTAS *}
{**********PH*}

function fConsultaSalcomix(Sender: TForm; strCodEmp: String): String; stdcall; external DLL_TINTA name 'fConsultaSalcomix';
function fConsultaSalcomixGeralDinamica(Sender: TForm): String; stdcall; external DLL_TINTA name 'fConsultaSalcomixGeralDinamica';
function fConsultaGlasurit(Sender: TForm; strCodEmp: String): String; stdcall; external DLL_TINTA name 'fConsultaGlasurit';
function fConsultaGlasuritGeralDinamica(Sender: TForm): String; stdcall; external DLL_TINTA name 'fConsultaGlasuritGeralDinamica';

function fConsultaTintaGeral(strIdePro: String; Sender: TForm; strCodEmp: String): String; stdcall; external DLL_TINTA name 'fConsultaTintaGeral';
function fGetLibTintaDLLRelacao: ILibTintaDllRelacao; stdcall; external DLL_TINTA name 'fGetLibTintaDLLRelacao';
function fUsaTmq: Boolean;
function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String;

implementation

procedure pRetornaPrecos(Const strCodIte: String; Var fltPreCus, fltMargem,

  fltPreVen: Double);
  Var
    qryAux: TUniQuery;
begin

  fltPreCus := 0.0;
  fltMargem := 0.0;
  fltPreVen := 0.0;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                 ');
  qryAux.SQL.Add('  ITE_PRECUS,          ');
  qryAux.SQL.Add('  ITE_MARBR1,          ');
  qryAux.SQL.Add('  ITE_PREVE1           ');
  qryAux.SQL.Add('FROM                   ');
  qryAux.SQL.Add('  ITEGER               ');
  qryAux.SQL.Add('WHERE                  ');
  qryAux.SQL.Add('  ITE_CODITE = :CODITE ');

  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin
    fltPreCus := qryAux.FieldByName('ITE_PRECUS').AsFloat;
    fltMargem := qryAux.FieldByName('ITE_MARBR1').AsFloat;
    fltPreVen := qryAux.FieldByName('ITE_PREVE1').AsFloat;
  End;

  qryAux.Close;

  FreeAndNil(qryAux);

end;

function fItemAtivo(Const strCodIte: String): Boolean;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ITE_ITEATI FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;

  Result := (qryAux.FieldByName('ITE_ITEATI').AsString = 'S') Or
            (qryAux.FieldByName('ITE_ITEATI').AsString = '');

  FreeAndNil(qryAux);

end;

function fCsvToClientDataSet(strNomArq, strDelimit: String): TUniClientDataSet;
  Var
    stlArquivo: TStringList;
    intQtdDelim: Integer;
    intContador: Integer;
    intLinha: Integer;

    //USADAS PARA A FUNÇÃO VAL
    S: String;
    V: Real;
    Code: Integer;

    function fContaDelim(l: String): Integer;
      Var
        intCont: Integer;
    begin
      Result := 0;
      For intCont := 1 To Length(l) Do
      Begin
        If intCont = 1 Then
          Continue;

        If l[intCont] = strDelimit Then
        Begin
          If (intCont < Length(l)) Then
            Inc(Result);
        End
        Else If intCont = Length(l) Then
          Inc(Result);

      End;
    end;

  function fDummy(v: Real): Real;
  begin
    Result := v;
  end;

begin
  stlArquivo := TStringList.Create;

  If (Not FileExists(strNomArq)) Then
    Raise Exception.Create('Arquivo (' + strNomArq + ') não encontrado');

  stlArquivo.LoadFromFile(strNomArq);
  If (stlArquivo.Count <= 0) Then
  Begin
    FreeAndNil(stlArquivo);
    Raise Exception.Create('Arquivo (' + strNomArq + ') vazio!');
  End;

  intQtdDelim := fContaDelim(stlArquivo[0]);

  Result := TUniClientDataSet.Create(Nil);
  For intContador := 1 To intQtdDelim Do
  Begin

    With Result.FieldDefs.AddFieldDef Do
    Begin
      DataType := ftString;
      Name := fGetValorLinha(stlArquivo[0], strDelimit, intContador);
      Size := 50
    End;

  End;

  Result.CreateDataSet;

  For intLinha := 1 To stlArquivo.Count-1 Do
  Begin

    Result.Append;
    For intContador := 1 To intQtdDelim Do
    Begin
      Result.Fields[intContador-1].AsString := fGetValorLinha(stlArquivo[intLinha], strDelimit, intContador);
      S := Result.Fields[intContador-1].AsString;
      Val(S, V, Code);
      fDummy(v);

      If (Code = 0) Then
      Begin
        Result.Fields[intContador-1].AsString := AnsiReplaceStr(S, '.', ',');;
      End;
    End;
    Result.Post;

  End;

  FreeAndNil(stlArquivo);
end;

function fExisteValorNoCampo(valor: Variant; strCampo, strTabela: String; strCondicao: String = ''): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT COUNT(' + strCampo + ') QTD FROM ' + strTabela + ' WHERE ' + strCampo + ' = :VALOR ';
  If Not fEmptyStr(strCondicao) Then
    qryGen.SQL.Text := qryGen.SQL.Text + ' AND ' + strCondicao;
  qryGen.ParamByName('VALOR').Value := valor;
  qryGen.Open;
  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function fGeTUniClientDataSet(strSql: string; strIndice: string; blnOpen: Boolean): TUniClientDataSet;
var
  qryGen: TUniQuery;
  dspGen: TUniDataSetProvider;
begin
  Try
    Try
      Result := TUniClientDataSet.Create(nil);

      qryGen := fCriaQuery(Result);
      qryGen.SQL.Text := strSql;

      dspGen := TUniDataSetProvider.Create(Result);
      dspGen.DataSet := qryGen;

      Result.SetProvider(dspGen);
      Result.IndexFieldNames := strIndice;

      if blnOpen then
        Result.Open;
    Except
      on E: Exception do
      begin
        if Assigned(dspGen) then FreeAndNil(dspGen);
        if Assigned(qryGen) then FreeAndNil(qryGen);
        if Assigned(Result) then FreeAndNil(Result);
        raise;
      end;
    End;
  Finally

  End;
end;

function fGetInsert(strNomTab: String): String;
Var
  strInsert: String;

  procedure pInsert;
    Var qryGen: TUniQuery;
  begin
    strInsert := '';

    if strNomTab = '' then
    begin
      fMensagem('Parametro Inválido !', 'untComuns - gGetInsert()', ['&OK']);
      Exit;
    end;

    qryGen := fCriaQuery();
    qryGen.SQL.Text := 'DESC ' + strNomTab;
    qryGen.Open;
    With qryGen Do
    Begin
      If Not IsEmpty Then
      Begin
        strInsert := 'INSERT INTO ' + strNomTab + ' VALUES ( ';
        First;

        While Not Eof Do
        Begin
          strInsert := strInsert + ':' + RightStr(Fields[0].AsString, 6) + ', ';
          Next;
        End;

        strInsert := LeftStr(strInsert, Length(strInsert) - 2) + ' )';

        If SameText(strNomTab, 'CADFOR') then
          strInsert := AnsiReplaceStr(strInsert, ':0800__', ':_0800_');
      End
      Else fMensagem('', 'A Tabela ' + strNomTab + ' não Existe!', ['&OK']);
    End;
    FreeAndNil(qryGen);
  end;

begin
  pInsert;
  Result := strInsert;
end;

procedure pAtualizaProCodAutInc(strNomeTabela: string; intAutoInc: Integer);
var
  qryProCod : TUniQuery;
  qryAux    : TUniQuery;
begin
  qryProCod := nil;
  Try
    Try
      qryAux := fCriaQuery();
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'SELECT * FROM PROCOD WHERE FALSE';
      qryAux.Open;


      qryProCod := fCriaQuery();

      if intAutoInc = 0 then
      begin
        qryProCod.SQL.Clear;
        qryProCod.SQL.Text := 'SELECT MAX( SUBSTR( AUTOINCREM, 4,14 ) ) AS AUTO FROM ' + strNomeTabela;
        qryProCod.Open;
        intAutoInc := qryProCod.FieldByName('AUTO').AsInteger;
      end;

      qryProCod.SQL.Clear;


      if (qryAux.FindField('PRO_AUTINC') <> Nil) Then
      begin
        qryProCod.SQL.Text := ' UPDATE PROCOD SET ' +
                              '   PRO_AUTINC = ' + IntToStr(intAutoInc + 1) +
                              ' WHERE PRO_NOMARQ = ' + QuotedStr(strNomeTabela);


      end
      else
      begin
        qryProCod.SQL.Text := ' UPDATE PROINC SET ' +
                              '   PRO_AUTINC = ' + IntToStr(intAutoInc + 1) +
                              ' WHERE PRO_NOMARQ = ' + QuotedStr(strNomeTabela);

      end;

      qryProCod.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryProCod) then FreeAndNil(qryProCod);
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;  

procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
var
  qryGen: TUniQuery;
begin
  Try
    Try
      strDescri := '';
      strUnid := '';
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        '   UNI_SIGUNI                 ' +
        '   , UNI_DESUNI               ' +
        ' FROM                         ' +
        '   CADUNI                     ' +
        ' WHERE UNI_CODUNI = :CODUNI   ';

      qryGen.ParamByName('CODUNI').AsString := strCodUni;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      strDescri := qryGen.FieldByName('UNI_DESUNI').AsString;
      strUnid := qryGen.FieldByName('UNI_SIGUNI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function fGetDescricaoProdutoTinta(const strCodIte: string): string;
var
  qryGen: TUniQuery;
begin
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                             ' +
        '   I.ITE_DESITE                     ' +
        ' FROM                               ' +
        '   CADITE I                         ' +
        '   INNER JOIN ITEGER G              ' +
        '     ON I.ITE_CODITE = G.ITE_CODITE ' +
        '   INNER JOIN CADMAR M              ' +
        '     ON I.ITE_CODMAR = M.MAR_CODMAR ' +
        '   INNER JOIN CADUNI U              ' +
        '     ON I.ITE_CODUNI = U.UNI_CODUNI ' +
        ' WHERE G.ITE_IMPLIS = "S"           ' +
        '   AND G.ITE_CODEMP = :CODEMP       ' +
        '   AND I.ITE_CODITE = :CODITE       ';

      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      Result := qryGen.FieldByName('ITE_DESITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function fUsaTmq: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + '\auttin\AutcomTinta.dll') And
            fCfgSis('USATMQ', varBoolean);
end;

function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String;
  Var
    tintas: ITintasDeMaquina;
begin
  If fUsaTmq Then
  Begin
    If Not fEmptyStr(strAliasDet) Then
    Begin
      If strAliasDet[Length(strAliasDet)] <> '.' Then
        strAliasDet := strAliasDet + '.';
    End;

    tintas := fGetTintasdeMaquina;

    Result := ' IF((' + strAliasDet + 'DET_VOLPRO > 0) ';
    Result := Result + ' AND (LOCATE(' + strAliasDet + 'DET_IDEPRO,"' + tintas.fGetImobiliarias + '") <= 0) ';
    Result := Result + ' , ' + strAliasDet + 'DET_VOLPRO, ' + IIF(blnVeioMarkup, ' ITE_PESLIQ / DET_PESESP ', ' UNI_PESLIT / :LITGAL ') + ' ) ';
  End
  Else
  Begin
    If blnVeioMarkup Then
      Result := ' ITE_PESLIQ / DET_PESESP '
    Else
      Result := ' UNI_PESLIT / :LITGAL ';
  End;
end;


procedure pEnviarLogRep(strCodite : string;
                        strIdePro : string);
Var
  qryGen   : TUniQuery;
  strSQL   : String;
begin
  strSQL := '';

  If fZerarCnv_Ml(strCodite, strIdePro) then
  Begin
    Try
      strSQL := 'UPDATE CADITE '+
                '   SET ITE_CNV_ML = 0 '+
                ' WHERE ITE_CODITE = ' + strCodite;

      qryGen := fCriaQuery();
      qryGen.SQL.Text := strSQL;
      qryGen.ExecSQL;
    Finally
      FreeAndNil(qryGen);
    End;
  end;
end;

function fZerarCnv_Ml(strCodite : String ; strIdePro : string) : Boolean;
var
  tintas : ITintasDeMaquina;
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();

  tintas := fGetTintasdeMaquina;

  Try
    Try
      qryGen.SQL.Clear;
      qryGen.Close;

      If Not((Pos(strIdePro, tintas.fGetImobiliarias) > 0)
        Or (Pos(strIdePro, tintas.fGetIndustriais) > 0)) Then
      begin
        qryGen.SQL.Text := ' SELECT COUNT(*) AS QNTD_VINCULO '+
                           '   FROM ' + strIdePro + '_CADBAS ' +
                           '  WHERE BAS_CODITE = :CODITE     ';
      end
      Else
      begin
        qryGen.SQL.Text := ' SELECT COUNT(*) AS QNTD_VINCULO '+
                           '   FROM ' + strIdePro + '_CADCOL ' +
                           '  WHERE COL_CODITE = :CODITE     ';
      end;

      qryGen.ParamByName('CODITE').AsString := strCodite;
      qryGen.Open;

      Result := (qryGen.FieldByName('QNTD_VINCULO').AsInteger = 0);
    Except
      Result := False;
    End;

  finally
    FreeAndNil(qryGen);
  end;
end;


end.
