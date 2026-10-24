
{**************************************************************************}
{* ESSE MÓDULO CONTÉM AS FUNÇÕES PARA A TENTATIVA DE EMULAÇÃO DE MACROS.  *}
{* O PROCESSO É O SEGUINTE:                                               *}
{*                                                                        *}
{* -> É CADASTRADO UM ARQUIVO DE CNF (CNFBOL, CNF_NF, ETC) COMO ANTIGA-   *}
{*    MENTE NO CLIPPER, PORÉM AS FUNÇÕES E SINTAXES SÃO DIFERENTES, POIS  *}
{     AGORA SERÃO USADOS COMANDOS DE SQL.                                 *}
{*                                                                        *}
{* -> PARA CADA LINHA DO ARQUIVO:                                         *}
{*                                                                        *}
{* -> A FUNÇÃO 'fRetPalavras' SE ENCARREGA DE SEPARAR TODAS AS 'PALAVRAS' *}
{*    DA LINHA                                                            *}
{* -> A FUNÇÃO 'fProcessaMacro' VERIFICA SE DETERMINADA 'PALAVRA' É UMA   *}
{*    PROPERTY DECLARADA NO FORM EM QUESTÃO E REALIZA A SUBSTITUIÇÃO DA   *}
{*    PALAVRA POR SEU VALOR                                               *}
{* -> DEPOIS DE TODAS AS SUBSTITUIÇÕES FEITAS NA LINHA, É EXECUTADO O SQL *}
{*    DA LINHA.                                                           *}
{*                                                                        *}
{* APÓS PERCORRER TODO O ARQUIVO, É GERADO UM ARQUIVO TEXTO QUE SERÁ EN-  *}
{* VIADO PARA IMPRESSÃO, ATRAVÉS DO COMANDO 'lpr'                         *}
{*                                                                        *}
{* A FUNÇÃO A SER CHAMADA QUANDO FOR UTILIZAR ESSE RECURSO, É A           *}
{* 'pI_Linhas', DE MANEIRA SEMELHANTE AO QUE EXISTE NO CLIPPER. HÁ UM     *}
{* EXEMPLO PROJETO "MACRO", NA UNIT 'untNota' NO BOTÃO 'Imprimir'.        *}
{* CASO QUEIRA OLHAR O CÓDIGO, TE DESEJO BOA SORTE!!                      *}
{***********************************************************************MV*}

unit untFuncMacro;

interface

uses Windows, SysUtils, Classes, StrUtils, TypInfo, Uni, Dialogs, DB,
     untFuncoesSimples, WinSpool, IOUtils;

  Var
    lstVariaveis: TStringList;
    lstRetirar: TStringList;

    intColMar, intLinTop: Integer;
    intLiTopo : Integer;
    strArqTxt: String = '';
    strBuffer: String = '';
    PrinterHandler: NativeUInt;

  function fIsNumber(strString: String): Boolean;
  function fStrSpace(strString: String; intTamanho: Integer): String;
  function fIsVarDeclared(strNomVar: String): Boolean;
  function fRetPalavras(strString: String): TStringList;
  function fRetNumeros(strString: STring): TStringList;
  function fExecutaSQL(strMacro: String; blnReformataNumeros: Boolean = True): String;
  function fReplaceValues(Sender: TObject; strMacro, strNomPro, strValPro: String): String;
  function fReformataNumeros(strString: String): String;

  procedure pEscreveLinha(Var strNomArq: String; strValLin: AnsiString; blnUltimoReg: Boolean; strNomImp: String = ''; strNomPro: String = ''; strDesPro: String = '');
  function  fProcessaMacro(Sender: TObject; cpuCampos: TCamposUso; strMacro: String): String;
  procedure pMontaLinha(Var strLinha: String; strValor: String; intColuna: Integer);
  procedure pInicializaVariaveis;
  procedure pI_Linhas(Sender: TObject; cpuCampos: TCamposUso;  Var intLinAtu: Integer; Var intLinha: Integer; strNomImp, strNomPro, strDesPro: String; qryCnfGen: TUniQuery; intColuna: Integer = 0);
  procedure pI_LinhasEti(Sender: TObject; cpuCampos: TCamposUso; Var strLinha: String; Var intLinAtu: Integer; Var intLinha: Integer; strNomImp, strNomPro, strDesPro: String; intColuna: Integer; qryCnfEti: TUniQuery);
  procedure pGravaLogErro(strErro: String);

implementation

uses   Printers, untSpoolImpressao;

{******************************************}
{* VERIFICA SE DETERMINADA STRING É UM    *}
{* NÚMERO VÁLIDO                          *}
{* MUDAR AQUI PARA USAR A PROCEDURE 'VAL' *}
{***************************************MV*}
function fIsNumber(strString: String): Boolean;
  Var
    intContador: Integer;
    blnPonto: Boolean;
begin
  Result := Trim(strString) <> '';
  blnPonto := False;
  For intContador := 1 To Length(strString) Do
  Begin
    If Not CharInSet(strString[intContador] , ['0'..'9', '.', ',']) Then
    Begin
      Result := False;
      Break;
    End
    Else If (strString[intContador] = '.') Then
    Begin
      If (blnPonto) Then
      Begin
        Result := False;
        Break;
      End
      Else
      Begin
        blnPonto := True;
      End;
    End;
  End;

end;

{******************************************}
{* INSERE ESPAÇOS À DIREITA DE 'strString'*}
{***************************************MV*}
function fStrSpace(strString: String;
  intTamanho: Integer): String;
  Var
    intContador: Integer;
    intQtdEspacos: Integer;
begin
  intQtdEspacos := intTamanho - Length(strString);
  Result := strString;
  For intContador := 1 To intQtdEspacos Do
    Result := Result + ' ';
end;

{*****************************************}
{* VERIFICA SE UMA DETERMINADA VARIAVEL  *}
{* JA FOI ENCONTRADA EM UMA EXPRESSÃO    *}
{**************************************MV*}
function fIsVarDeclared(strNomVar: String): Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  For intContador := 0 To lstVariaveis.Count - 1 Do
  Begin
    If strNomVar = lstVariaveis.Strings[intContador] Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function fProcessaMacro(Sender: TObject; cpuCampos: TCamposUso;
  strMacro: String): String;
  Var
    intContador: Integer;
    Lista: TStringList;
    strValPro: String;
    blnReformataNumeros: Boolean;
begin
  Lista := fRetPalavras(strMacro);

  blnReformataNumeros := True;
  If (Pos('strdess0', AnsiLowerCase(strMacro)) > 0) Or
     (Pos('strmen00', AnsiLowerCase(strMacro)) > 0) Then
  Begin
    blnReformataNumeros := False;
  End;

  For intContador := 0 To Lista.Count - 1 Do
  Begin

    If cpuCampos <> Nil Then
    Begin
      strValPro := cpuCampos[Lista.Strings[intContador]];
      If Trim(strValPro) <> '' Then
      Begin
        {*****************************************}
        {* CASO TENHA ENCONTRADO A INFORMAÇÃO NO *}
        {* BANCO DE DADOS, -> CONTINUA <- O LOOP *}
        {**************************************MV*}
        strMacro := AnsiReplaceStr(strMacro, Lista.Strings[intContador], strValPro);
        Continue;
      End;
    End;

    Try
      strValPro := GetPropValue(Sender, Lista.Strings[intContador]);
      strMacro  := fReplaceValues(Sender, strMacro, Lista.Strings[intContador], strValPro);
    Except

    End;
  End;

  Result := fExecutaSQL(strMacro, blnReformataNumeros);
end;

function fRetPalavras(strString: String): TStringList;
  Var
    intContador: Integer;
    intPosicao : Integer;
    strTemp: String;
begin
  Result := TStringList.Create;
  For intContador := 0 To lstRetirar.Count -1 Do
    strString := AnsiReplaceText(strString, lstRetirar.Strings[intContador], ' ');

  intPosicao := 0;
  repeat

    strString := strString + ' ';
    If Trim(strString) = '' Then
      Break
    Else
      intPosicao := Pos(' ', strString);

    strTemp := Copy(strString, 1, intPosicao);
    If (Trim(strTemp) <> '')               And
       (Not fIsNumber(Trim(strTemp)))      And
       (Not fIsVarDeclared(Trim(strTemp))) Then
    Begin
      Result.Add(Trim(strTemp));
      lstVariaveis.Add(Trim(strTemp));
    End;

    Delete(strString, 1, intPosicao);

  until False;
end;

function  fRetNumeros(strString: STring): TStringList;
  Var
    intContador: Integer;
    intPosicao : Integer;
    strTemp: String;
begin
  Result := TStringList.Create;
  For intContador := 0 To lstRetirar.Count -1 Do
  Begin
    If (Pos(lstRetirar[intContador], ',.') > 0) Then
      Continue;

    strString := AnsiReplaceText(strString, lstRetirar.Strings[intContador], ' ');
  End;

  intPosicao := 0;
  repeat

    strString := strString + ' ';
    If Trim(strString) = '' Then
      Break
    Else
      intPosicao := Pos(' ', strString);

    strTemp := Copy(strString, 1, intPosicao);
    If (Trim(strTemp) <> '')               And
//       (Not fIsNumber(Trim(strTemp)))      And
       (Not fIsVarDeclared(Trim(strTemp))) Then
    Begin
      Result.Add(Trim(strTemp));
      lstVariaveis.Add(Trim(strTemp));
    End;

    Delete(strString, 1, intPosicao);

  until False;

end;

procedure pMontaLinha(Var strLinha: String; strValor: String; intColuna: Integer);
  Var
    intContador: Integer;
begin

  For intContador := 1 To intColuna - Length(strLinha) Do
    strLinha := strLinha + ' ';
  strLinha := strLinha + strValor;

end;

procedure pI_Linhas(Sender: TObject; cpuCampos: TCamposUso; Var intLinAtu: Integer;
  Var intLinha: Integer; strNomImp, strNomPro, strDesPro: String; qryCnfGen: TUniQuery; intColuna: Integer = 0);
  Var
    _intColuna : Integer;
    intLinTmp  : Integer;
    intContador: Integer;

    blnUltimoReg: Boolean;

    strMacro: String;
    strLinha: String;
begin

  strLinha := '';
  blnUltimoReg := (qryCnfGen.RecNo = qryCnfGen.RecordCount);

  pInicializaVariaveis;

  If ((qryCnfGen.FieldByName('CNF_LINIMP').AsInteger = 0)  And
      (qryCnfGen.FieldByName('CNF_COLIMP').AsInteger = 0)) Then
  Begin
    If (qryCnfGen.FieldByName('CNF_IDENTI').AsString <> '00') Then
    Begin
      qryCnfGen.Next;
      Exit;
    End

    Else If (qryCnfGen.FieldByName('CNF_CHRANT').AsString = '') And
            (qryCnfGen.FieldByName('CNF_DESCAM').AsString = '') And
            (qryCnfGen.FieldByName('CNF_CHRDEP').AsString = '') Then
    Begin
      qryCnfGen.Next;
      Exit;
    End;

  End;


  For intContador := 1 To ((qryCnfGen.FieldByName('CNF_LINIMP').AsInteger + intLiTopo) - intLinAtu - 1) Do
  Begin
    pEscreveLinha(strArqTxt, '', False);
  End;

  If intLinha = 0 Then
  Begin
    intLinAtu := qryCnfGen.FieldByName('CNF_LINIMP').AsInteger + intLiTopo;
  End
  Else
  Begin
    intLinAtu := intLinha;
    Inc(intLinha);
  End;

  If (qryCnfGen.FieldByName('CNF_IDENTI').AsString = '01') Or
     (qryCnfGen.FieldByName('CNF_IDENTI').AsString = '02') Or
     (qryCnfGen.FieldByName('CNF_IDENTI').AsString = '03') Or
     (qryCnfGen.FieldByName('CNF_IDENTI').AsString = '99') Then
  Begin
    intLinTmp := qryCnfGen.FieldByName('CNF_LINIMP').AsInteger;
  End
  Else
    intLinTmp := intLinAtu;

  While (intLinTmp = qryCnfGen.FieldByName('CNF_LINIMP').AsInteger) And
        (Not qryCnfGen.Eof)                                         Do
  Begin

    If intColuna = 0 Then
    Begin
      _intColuna := qryCnfGen.FieldByName('CNF_COLIMP').AsInteger + intColMar;
    End
    Else
    Begin
      _intColuna := intColuna;
    End;

    strMacro := qryCnfGen.FieldByName('CNF_CHRANT').AsString;
    If Trim(strMacro) <> '' Then
    Begin
      pMontaLinha(strLinha, fProcessaMacro(Sender, cpuCampos, strMacro), _intColuna);
    End;

    strMacro := qryCnfGen.FieldByName('CNF_DESCAM').AsString;
    If Trim(strMacro) <> '' Then
    Begin
      pMontaLinha(strLinha, fProcessaMacro(Sender, cpuCampos, strMacro), _intColuna);
    End;

    strMacro := qryCnfGen.FieldByName('CNF_CHRDEP').AsString;
    If Trim(strMacro) <> '' Then
    Begin
      pMontaLinha(strLinha, fProcessaMacro(Sender, cpuCampos, strMacro), _intColuna);
    End;

    qryCnfGen.Next;
    lstVariaveis.Clear;
  End;

  pEscreveLinha(strArqTxt, AnsiString(strLinha), blnUltimoReg, strNomImp, strNomPro, strDesPro);
end;

procedure pI_LinhasEti(Sender: TObject; cpuCampos: TCamposUso; Var strLinha: String;
  Var intLinAtu: Integer; Var intLinha: Integer; strNomImp, strNomPro, strDesPro: String; intColuna: Integer; qryCnfEti: TUniQuery);
  Var
    strMacro: String;
    intContador: Integer;
begin

  pInicializaVariaveis;

  If (qryCnfEti.FieldByName('CNF_LINIMP').AsInteger = 0) Then
  Begin
    If (qryCnfEti.FieldByName('CNF_IDENTI').AsString <> '00') Then
    Begin
      Exit;
    End

    Else If (qryCnfEti.FieldByName('CNF_CHRANT').AsString = '') And
            (qryCnfEti.FieldByName('CNF_DESCAM').AsString = '') And
            (qryCnfEti.FieldByName('CNF_CHRDEP').AsString = '') Then
    Begin
      Exit;
    End;

  End;

  For intContador := 1 To (qryCnfEti.FieldByName('CNF_LINIMP').AsInteger - intLinAtu - 1) Do
  Begin
    pEscreveLinha(strArqTxt, '', False);
  End;

  intLinAtu := qryCnfEti.FieldByName('CNF_LINIMP').AsInteger;
  
  strMacro := qryCnfEti.FieldByName('CNF_CHRANT').AsString;
  If Trim(strMacro) <> '' Then
  Begin
    pMontaLinha(strLinha, fProcessaMacro(Sender, cpuCampos, strMacro), intColuna);
  End;

  strMacro := qryCnfEti.FieldByName('CNF_DESCAM').AsString;
  If Trim(strMacro) <> '' Then
  Begin
    pMontaLinha(strLinha, fProcessaMacro(Sender, cpuCampos, strMacro), intColuna);
  End;

  strMacro := qryCnfEti.FieldByName('CNF_CHRDEP').AsString;
  If Trim(strMacro) <> '' Then
  Begin
    pMontaLinha(strLinha, fProcessaMacro(Sender, cpuCampos, strMacro), intColuna);
  End;

  lstVariaveis.Clear;

end;

procedure AppendAnsiStringToFile(const AFileName: string; const AData: AnsiString);
var
  FS: TFileStream;
begin
  if AData = '' then
    Exit;

  if FileExists(AFileName) then
    FS := TFileStream.Create(AFileName, fmOpenReadWrite or fmShareDenyNone)
  else
    FS := TFileStream.Create(AFileName, fmCreate);

  try
    FS.Seek(0, soEnd);
    FS.WriteBuffer(AData[1], Length(AData));
  finally
    FS.Free;
  end;
end;

procedure pEscreveLinha(Var strNomArq: String; strValLin: AnsiString; blnUltimoReg: Boolean;
  strNomImp: String = ''; strNomPro: String = ''; strDesPro: String = '');
  Var
    DocInfo: TDocInfo1;
    escritos: Cardinal;
begin

  If fEmptyStr(strNomArq) Then
  Begin
    if not VS_SpoolImpressaoCitel then
    begin
      If (fEmptyStr(strNomImp)) Then
        Exit;

      OpenPrinter(PChar(strNomImp), PrinterHandler, Nil);
      with DocInfo do
      begin
        pDatatype := 'RAW';
        pDocName := PChar('Impressão de Faturamento');
        pOutputFile := nil;
      end;

      StartDocPrinter(PrinterHandler, 1, @DocInfo);
      StartPagePrinter(PrinterHandler);
    end;

    strNomArq := ExtractFilePath(ParamStr(0)) + 'tmp\';

    If Not DirectoryExists(strNomArq) Then
      CreateDir(strNomArq);

    if VS_SpoolImpressaoCitel then
      strNomArq := strNomArq + strLoginUsuarioLogado + RightStr(FloatToStr(VS_Date), 10) + 'arqtxt.esc'
    else
      strNomArq := strNomArq + strLoginUsuarioLogado + RightStr(FloatToStr(VS_Date), 10) + 'arqtxt.txt';

    If FileExists(strNomArq) then
      TFile.Delete(strNomArq);
  End;

  strValLin := AnsiString(fTiraCaracNota(String(strValLin)));

  If Not blnUltimoReg Then
    strValLin := strValLin + #13#10;

  if VS_SpoolImpressaoCitel then
    AppendAnsiStringToFile(strNomArq, strValLin)
  else
    WritePrinter(PrinterHandler, PAnsiChar(strValLin), Length(strValLin), escritos);

  If blnUltimoReg Then
  Begin
    if VS_SpoolImpressaoCitel then
      TSpoolImpressaoCitel.fEnviarESCParaImpressao(strNomPro, strDesPro, strNomImp, strNomArq)
    else
      ClosePrinter(PrinterHandler);
    strNomArq := '';
    strBuffer := '';
  End;

end;


{*****************************************}
{* EXECUTA UM SQL E RETORNA O VALOR      *}
{**************************************MV*}
function fExecutaSQL(strMacro: String; blnReformataNumeros: Boolean = True): String;
  Var
    strSQL   : String;
    qryGenMac: TUniQuery;

begin
  Try

    qryGenMac := fCriaQuery;

    Try
      With qryGenMac Do
      Begin
        Close;
        SQL.Clear;
        {*****************************************}
        {* ESSE CAST É USADO PARA LIMITAR O USO  *}
        {* DE MEMÓRIA QUE O MYSQL FAZ QUANDO SE  *}
        {* USA EXPRESSÕES EM UM SELECT. SE RETI- *}
        {* RAR ESSE CAST, DA O ERRO 'MEMORY LOW' *}
        {* MAIS UMA "PERIPÉCIA" DO DETINHO.      *}
        {**************************************MV*}
        strSQL := 'SELECT CAST(' + strMacro + ' AS CHAR(255) ) ';
        SQL.Add(strSQL);
        Open;
        Result := Fields[0].AsString;

        If (blnReformataNumeros) Then
          Result := fReformataNumeros(Result);

        Close;
      End;
    Except
      On E: Exception Do
      Begin
        fMensagem('', 'Erro ao interpretar uma configuração de impressão: ' +
                       strMacro, ['&Ok']);
        pGravaLogErro('Erro ao interpretar uma configuração de impressão: ' +
                       strMacro);
      End;
    End;

  Finally
    FreeAndNil(qryGenMac);
  End;

end;

{*****************************************}
{* TROCA O NOME DE UMA VARIAVEL POR SEU  *}
{* VALOR, DE ACORDO COM A PROPERTY       *}
{**************************************MV*}
function fReplaceValues(Sender: TObject; strMacro, strNomPro,
  strValPro: String): String;
  Var
    propInfo: PPropInfo;
begin

  propInfo := GetPropInfo(Sender, strNomPro);
  If (propInfo^.PropType^.Kind = tkString)  Or
     (propInfo^.PropType^.Kind = tkWString) Or
     (propInfo^.PropType^.Kind = tkLString) Then
  Begin

    Try
      StrToDate(strValPro)
    Except
      strValPro := fTiraCaracNota(strValPro);
    End;

    Result := AnsiReplaceStr(strMacro, strNomPro, QuotedStr(strValPro));
  End
  Else If (propInfo^.PropType^.Kind = tkInteger) Or
          (propInfo^.PropType^.Kind = tkFloat)   Then
  Begin
    strValPro := AnsiReplaceStr(strValPro, ',', '.');
    Result    := AnsiReplaceStr(strMacro, strNomPro, strValPro);
  End

  Else If (propInfo^.PropType^.Kind = tkEnumeration) Then
  Begin
    If (Pos(strValPro, 'False_True') > 0) Then
    Begin

      If (strValPro = 'True') Then
        strValPro := '1'
      Else
        strValPro := '0';

      Result    := AnsiReplaceStr(strMacro, strNomPro, strValPro);
    End
    Else
    Begin
      showMessage('Não foi tratada uma possibilidade: ' + strNomPro);
      pGravaLogErro('Não foi tratada uma possibilidade: ' + strNomPro);
    End;
  End

  Else
  Begin
    showMessage('Não foi tratada uma possibilidade: ' + strNomPro);
    pGravaLogErro('Não foi tratada uma possibilidade: ' + strNomPro);
  End;

end;

procedure pGravaLogErro(strErro: String);
  Var
    txtLog: TextFile;
    strArqLog: String;
begin
  strArqLog := 'erros.txt';
  AssignFile(txtLog, strArqLog);
  If FileExists(strArqLog) Then
  Begin
    Reset(txtLog);
  End
  Else
  Begin
    Rewrite(txtLog);
  End;

  Append(txtLog);
//  WriteLn(txtLog, 'Ocorreu algo surpreendentemente errado em ' + DateToStr(VS_Date) + ' - ' + TimeToStr(fTime()));
  WriteLn(txtLog, '=> ' + strErro);
  Flush(txtLog);
  Close(txtLog);
end;

procedure pInicializaVariaveis;
begin

  If lstRetirar = Nil Then
  Begin
    lstRetirar := TStringList.Create;

    lstRetirar.Add('.not.');
    lstRetirar.Add('.and.');
    lstRetirar.Add('.or.');
    lstRetirar.Add('(');
    lstRetirar.Add(')');
    lstRetirar.Add('[');
    lstRetirar.Add(']');
    lstRetirar.Add(',');
    lstRetirar.Add('!');
  End;

  If lstVariaveis = Nil Then
  Begin
    lstVariaveis := TStringList.Create;
  End;

end;

function fReformataNumeros(strString: String): String;
  Var
    stlPalavras: TStringList;
    intContador: Integer;
    strNumOri: String;
    strNumNov: String;
begin
  stlPalavras := fRetNumeros(strString);

  For intContador := 0 To stlPalavras.Count -1 Do
  Begin

    If (fIsNumber(stlPalavras[intContador])) Then
    Begin
      strNumOri := stlPalavras[intContador];
      strNumNov := AnsiReplaceStr(strNumOri, ',', '!');
      strNumNov := AnsiReplaceStr(strNumNov, '.', ',');
      strNumNov := AnsiReplaceStr(strNumNov, '!', '.');
      strString := AnsiReplaceStr(strString, strNumOri, strNumNov);
    End;

  End;
  Result := strString;
end;

end.

