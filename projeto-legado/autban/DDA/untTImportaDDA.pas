unit untTImportaDDA;

interface

Uses Classes, untFuncoesSimples, Uni, SysUtils, StrUtils, Windows, Forms,
     untFuncAutban, untFuncoesBoleto, UniClientDataSet, untTiposDDA,
     Data.DB;

Type
  TImportaDDA = class

  private
    FstrCodBco: String;
    FlstArquiv: TStringList;
    strNumDup : String;

    qryRetDDA : TUniQuery;

    procedure pDescobreNumDup(Var strDupArq: String);
    function fGetVal(strValor: String; blnFloat: Boolean = False): Variant;
    function fRetCodBarLinDig(strLinDig: String): String;
    function fCalculaLinhaDig(strCodBco, strMoeda, strDac, strFatorV, strValTit, strCamLiv, strModCar: String): String;

    function fRetornaCNPJEmpresa(strCodBco, strLinha: String): String;
    function fRetornaCPFEmpresa(strCodBco, strLinha: String): String;
    function fValida_C_G_C(str_C_G_C : String): Boolean;

    function RetornaCodigoEmpresa(ACGC,ACNPJ: String): String;

    procedure ApagaRetDDA(ACodigoBanco: String);

    function fImportaDDA_API_Sicoob(const ADados: TUniClientDataSet;
      const ACodigoBanco: string; const ADadosCarteira: TDDAAPIDadosCarteira): Boolean;
  public
    constructor Create;

    function fImportaDDA(lstArquiv: TStringList; strCodBco: String): Boolean; overload;
    function fImportaDDA(const ARegistros: TUniClientDataSet; const
      ACodigoBanco: string): Boolean; overload;

    procedure pImportaDDAFebraban;
    procedure pImportaDDABradesco;
    procedure pImportaDDASicredi;
End;

implementation
Uses untGravando;
{ TImportaDDA }

procedure TImportaDDA.ApagaRetDDA(ACodigoBanco: String);
  Var
    LApagar: TUniQuery;
begin
  fStartTransaction;
  LApagar := fCriaQuery;
  Try
    Try
      LApagar.SQL.Text := 'DELETE FROM RETDDA WHERE DDA_CODBCO = "' + ACodigoBanco + '"';
      LApagar.ExecSQL;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LApagar);
  End;
end;

constructor TImportaDDA.Create;
 Var
   strSQL: String;
begin
  If Not Assigned(qryRetDDA) Then
    qryRetDDA := fCriaQuery(Nil);

  strSQL := 'REPLACE INTO RETDDA (DDA_CODBCO, DDA_CODEMP, DDA_CODAGE, DDA_CODCTA, DDA_DTAARQ, DDA_CODLOT,';
  strSQL := strSQL + ' DDA_DIGCBR, DDA_FATVEN, DDA_VALBAR, DDA_CNPCPF, DDA_CNPJ__, DDA_NOMCED, DDA_DTAVEN, ';
  strSQL := strSQL + ' DDA_VALTIT, DDA_CODMOE, DDA_NUMDUP, DDA_AGECOB, DDA_DACAGE, DDA_MODCAR, DDA_ESPDOC, ';
  strSQL := strSQL + ' DDA_DTAEMI, DDA_CODMOV, DDA_BCOCOM, DDA_CAMLIV, DDA_CODFOR, DDA_LINDIG, DDA_CODBAR, DDA_DUPCOR)';
  strSQL := strSQL + ' VALUES (:CODBCO, :CODEMP, :CODAGE, :CODCTA, :DTAARQ, :CODLOT, ';
  strSQL := strSQL + ' :DIGCBR, :FATVEN, :VALBAR, :CNPCPF, :CNPJ__, :NOMCED, :DTAVEN, ';
  strSQL := strSQL + ' :VALTIT, :CODMOE, :NUMDUP, :AGECOB, :DACAGE, :MODCAR, :ESPDOC, ';
  strSQL := strSQL + ' :DTAEMI, :CODMOV, :BCOCOM, :CAMLIV, :CODFOR, :LINDIG, :CODBAR, :DUPCOR)';
  qryRetDDA.SQL.Add(strSQL);
end;

function TImportaDDA.fImportaDDA(lstArquiv: TStringList; strCodBco: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(strCodBco)) Or (lstArquiv.Count <= 0) Then
    Exit;

  If fMensagem('ATENÇÃO', 'Deseja importar o(s) arquivo(s) selecionado(s)?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  FlstArquiv := lstArquiv;
  FstrCodBco := strCodBco;
  If strCodBco = '341' Then
    TfrmGravando.fExecutarModal(pImportaDDAFebraban, 'Aguarde... Importando arquivos DDA (ITAÚ).', '')
  Else If strCodBco = '237' Then
    TfrmGravando.fExecutarModal(pImportaDDABradesco, 'Aguarde... Importando arquivos DDA (BRADESCO).', '')
  Else If strCodBco = '237_240' Then
    TfrmGravando.fExecutarModal(pImportaDDAFebraban, 'Aguarde... Importando arquivos DDA (BRADESCO).', '')
  Else If strCodBco = '033' Then
    TfrmGravando.fExecutarModal(pImportaDDAFebraban, 'Aguarde... Importando arquivos DDA (SANTANDER).', '')
  Else If strCodBco = '104' Then
    TfrmGravando.fExecutarModal(pImportaDDAFebraban, 'Aguarde... Importando arquivos DDA (CEF).', '')
  Else If strCodBco = '001' Then
    TfrmGravando.fExecutarModal(pImportaDDAFebraban, 'Aguarde... Importando arquivos DDA (BANCO DO BRASIL).', '')
  Else If strCodBco = '041' Then
    TfrmGravando.fExecutarModal(pImportaDDAFebraban, 'Aguarde... Importando arquivos DDA (BANRISUL).', '')
  Else If strCodBco = '748' Then
    TfrmGravando.fExecutarModal(pImportaDDASicredi, 'Aguarde... Importando arquivos DDA (SICREDI).', '');

end;

procedure TImportaDDA.pDescobreNumDup(Var strDupArq: String);
  Var
    intPos: Integer;
Begin
  strNumDup := strDupArq;

  If fEmptyStr(fRetSomenteNumeros(strNumDup)) Then
    Exit;

  intPos := Pos('-', strDupArq);

  If intPos = 0 Then
    intPos := Pos('/', strDupArq);

  If intPos = 0 Then
    intPos := Pos('.', strDupArq);

  If intPos > 0 Then
    strNumDup := Copy(strDupArq, 1, intPos - 1)
  Else
  Begin
    if fEmptyStr(fRetSomenteNumeros(Copy(strDupArq, Length(strDupArq)))) then
      strNumDup := Copy(strDupArq, 1, Length(strDupArq) - 1)
    Else
      strNumDup := fRetSomenteNumeros(strNumDup);
  End;
End;

procedure TImportaDDA.pImportaDDABradesco;
  Var
    arqArquiv  : TextFile;
    strLinha,
    strAgenc,
    strConta,
    strCNPJ,
    strCodBco,
    strDtaAux,
    strValTit,
    strNomArq,
    strCodEmp  : String;
    intContador: Integer;
    dtaDtaArq  : TDate;
    blnArqImp,
    blnArqDDA,
    blnSemEmp,
    blnTitBra  : Boolean;
    lstCNPJ    : TStringList;
begin
  Try
    dtaDtaArq := 0;
    blnArqImp := False;
    blnSemEmp := False;
    lstCNPJ   := TStringList.Create;

    If fCfgSis('DELDDA', varBoolean) Then
      ApagaRetDDA('237');

    For intContador := 0 To FlstArquiv.Count-1 Do
    Begin
      blnArqDDA := True;

      AssignFile(arqArquiv, FlstArquiv[intContador]);
      Reset(arqArquiv);
      Readln(arqArquiv,strLinha);

      Try
        strDtaAux := fGetVal(Copy(strLinha,79,8));
        dtaDtaArq := StrtoDate(Copy(strDtaAux, 7, 2) + '/' + Copy(strDtaAux, 5, 2) + '/' + Copy(strDtaAux, 1, 4));
      Except
        blnArqDDA := False;
      End;

      If (Copy(strLinha,66,68) = '202') And (blnArqDDA) Then //verifica se esse arquivo é do Bradesco
      Begin
        fStartTransaction;
        Readln(arqArquiv,strLinha);
        strCNPJ   := fGetVal(Copy(strLinha,12,14));

        strCodEmp := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [strCNPJ]);
        If fEmptyStr(strCodEmp) Then
        Begin
          blnSemEmp := True;
          If lstCNPJ.IndexOf(strCNPJ) = -1 Then
            lstCNPJ.Add(strCNPJ);
        End
        Else
        Begin
          blnArqImp := True;
          While Not Eof(arqArquiv) Do
          Begin
            Application.ProcessMessages;
            Readln(arqArquiv,strLinha);

            If Eof(arqArquiv) Then
              Continue;

            If (Copy(strLinha, 1, 1) = '1') Then
            Begin
              With qryRetDDA Do
              Begin
                strAgenc  := fGetVal(Copy(strLinha,99,6));
                strConta  := fGetVal(Copy(strLinha,105,14));

                ParamByName('CODBCO').AsString := strCodBco;
                ParamByName('CODEMP').AsString := strCodEmp;
                ParamByName('CODAGE').AsString := strAgenc;
                ParamByName('CODCTA').AsString := strConta;
                ParamByName('DTAARQ').AsDate   := dtaDtaArq;
                ParamByName('CODLOT').AsString := '0';
                ParamByName('BCOCOM').AsString := fGetVal(Copy(strLinha, 96, 3));
                blnTitBra := (ParamByName('BCOCOM').AsString = '237');
                ParamByName('CODMOE').AsString := IIF(blnTitBra, '9', fGetVal(Copy(strLinha, 400, 1)));
                ParamByName('FATVEN').AsString := fGetVal(Copy(strLinha, 191, 4));
                ParamByName('VALBAR').AsFloat  := fGetVal(Copy(strLinha, 195, 10), True);
                If blnTitBra Then
                Begin
                  ParamByName('CAMLIV').AsString := RightStr(fGetVal(Copy(strLinha,99,5)), 4) +
                                                    RightStr(fGetVal(Copy(strLinha,136,3)), 3) +
                                                    RightStr(fGetVal(Copy(strLinha,139,12)), 11) +
                                                    RightStr(fGetVal(Copy(strLinha,105,13)), 7) + '0';
                  ParamByName('DIGCBR').AsString := '';
                End
                Else
                Begin
                  ParamByName('DIGCBR').AsString := fGetVal(Copy(strLinha, 399, 1));
                  ParamByName('CAMLIV').AsString := fGetVal(Copy(strLinha, 374, 25));
                End;

                ParamByName('CNPCPF').AsString := fGetVal(Copy(strLinha, 02, 1));
                If ParamByName('CNPCPF').AsString = '1' Then
                  ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 3, 9)) +
                                                    fGetVal(Copy(strLinha, 16, 2))
                Else
                  ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 3, 9)) +
                                                    fGetVal(Copy(strLinha, 12, 4)) +
                                                    fGetVal(Copy(strLinha, 16, 2));

                ParamByName('NOMCED').AsString := fGetVal(Copy(strLinha, 18, 30));
                strDtaAux := fGetVal(Copy(strLinha, 174, 8));
                ParamByName('DTAEMI').AsDate := StrtoDate(Copy(strDtaAux, 7, 2) + '/' + Copy(strDtaAux, 5, 2) + '/' + Copy(strDtaAux, 1, 4));

                //SE FOR CONTRA APRESENTAÇÃO, A DATA DE VENCIMENTO SERÁ A DATA LIMITE DO PAGAMENTO
                strDtaAux := fGetVal(Copy(strLinha, 166, 8));
                If strDtaAux = '00000000' Then
                  ParamByName('DTAVEN').AsDate := ParamByName('DTAEMI').AsDate
                Else
                  ParamByName('DTAVEN').AsDate := StrtoDate(Copy(strDtaAux, 7, 2) + '/' + Copy(strDtaAux, 5, 2) + '/' + Copy(strDtaAux, 1, 4));

                ParamByName('VALTIT').AsFloat  := IIF(fGetVal(Copy(strLinha, 195, 10), True) = 0,
                                                      fGetVal(Copy(strLinha, 205, 15), True),
                                                      fGetVal(Copy(strLinha, 195, 10), True));

                {********************************}
                {* DEFINE O NUMERO DA DUPLICATA *}
                {*****************************AJ*}
                strNumDup := StringReplace(fGetVal(Copy(strLinha, 252, 10)), ' ', EmptyStr, [rfReplaceAll]);
                pDescobreNumDup(strNumDup);

                ParamByName('DUPCOR').AsString := strNumDup;
                ParamByName('NUMDUP').AsString := fGetVal(Copy(strLinha, 252, 10));
                ParamByName('AGECOB').AsString := fGetVal(Copy(strLinha, 99, 5));
                ParamByName('DACAGE').AsString := fGetVal(Copy(strLinha, 104, 1));
                ParamByName('MODCAR').AsString := fGetVal(Copy(strLinha, 179, 1));
                ParamByName('ESPDOC').AsString := IIF(StrtoInt(fGetVal(Copy(strLinha, 250, 2))) In [1, 2, 3], 'NF', 'PD');
                ParamByName('CODFOR').AsString := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [ParamByName('CNPJ__').AsString]);

                ParamByName('CODMOV').AsString := fGetVal(Copy(strLinha, 289, 1));
                strValTit := fPadL(StringReplace(StringReplace(FormatFloat('#,##0.00', ParamByName('VALBAR').AsFloat), ',', EmptyStr, [rfReplaceAll]),'.', EmptyStr, [rfReplaceAll]), 10, '0');
                ParamByName('LINDIG').AsString := fCalculaLinhaDig(ParamByName('BCOCOM').AsString,
                                                  ParamByName('CODMOE').AsString,
                                                  ParamByName('DIGCBR').AsString,
                                                  ParamByName('FATVEN').AsString,
                                                  strValTit,
                                                  ParamByName('CAMLIV').AsString,
                                                  ParamByName('MODCAR').AsString);
                ParamByName('CODBAR').AsString := fRetCodBarLinDig(ParamByName('LINDIG').AsString);

                ExecSQL;
              End;
            End;
          End;
        End;
        fCommit;
      End;
      CloseFile(arqArquiv);

      If (blnArqDDA) And (blnArqImp) And (Not blnSemEmp) Then
      Begin
        strNomArq := FlstArquiv[intContador];
        If (FileExists(AnsiReplaceStr(strNomArq, RightStr(strNomArq, 3), 'old'))) Then
          DeleteFile(PWideChar(AnsiReplaceStr(strNomArq, RightStr(strNomArq, 3), 'old')));
        RenameFile(strNomArq, AnsiReplaceStr(strNomArq, RightStr(strNomArq, 3), 'old'));
      End;
    End;

    If blnSemEmp Then
    Begin
      strCNPJ := '';
      For intContador := 0 to lstCNPJ.Count - 1 do
        strCNPJ := strCNPJ + lstCNPJ[intContador] + ', ';
      pMensagemOK('Algum(ns) arquivo(s) DDA selecionado(s) não foi(ram) importado(s), pois a Empresa do(s) com CNPJ(s) ' +
                  Copy(strCNPJ, 1, Length(strCNPJ) - 2) + ' não está(ão) cadastrada(s) no sistema. Verifique!');
    End;

    If Not blnArqImp Then
      pMensagemOK('Nenhum arquivo DDA foi importado!')
    Else
      pMensagemOK('Arquivo(s) importado(s) com sucesso!');

    FreeAndNil(lstCNPJ);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Ocorreu um erro ao importar os arquivos do Bradesco. ' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

procedure TImportaDDA.pImportaDDAFebraban;
Var
    arqArquiv  : TextFile;
    strLinha,
    strAgenc,
    strConta,
    strCNPJ,
    strCodBco,
    strDtaAux,
    strValTit,
    strVerArq,
    strNomArq  : String;
    intContador: Integer;
    dtaDtaArq  : TDate;
    blnArqImp,
    blnArqDDA,
    EhDDA,
    blnSemEmp,
    blnImporta : Boolean;
    lstCNPJ    : TStringList;
    SegmentoAnterior: String;
begin
  Try
    dtaDtaArq  := 0;
    blnArqImp  := False;
    blnSemEmp  := False;
    lstCNPJ    := TStringList.Create;
    EhDDA      := False;
    SegmentoAnterior := '';

    If fCfgSis('DELDDA', varBoolean) Then
      ApagaRetDDA(Copy(FstrCodBco, 1, 3));

    For intContador := 0 To FlstArquiv.Count-1 Do
    Begin
      blnArqDDA := True;

      AssignFile(arqArquiv, FlstArquiv[intContador]);
      Reset(arqArquiv);
      Readln(arqArquiv,strLinha);

      Try
        strDtaAux := fGetVal(Copy(strLinha,144,8));
        dtaDtaArq := StrtoDate(Copy(strDtaAux, 1, 2) + '/' + Copy(strDtaAux, 3, 2) + '/' + Copy(strDtaAux, 5, 4));
      Except
        blnArqDDA := False;
      End;
      strVerArq := fGetVal(Copy(strLinha,164,3));

      blnImporta := (Copy(strLinha,1,3) = Copy(FstrCodBco, 1, 3)) And
                    (not fEmptyStr(strVerArq)) And (blnArqDDA);

      If blnImporta Then //verifica se esse arquivo é de DDA dos layouts febraban
      Begin
        fStartTransaction;
        Readln(arqArquiv,strLinha);
        strCodBco := fGetVal(Copy(strLinha,1,3));
        strAgenc  := fGetVal(Copy(strLinha,53,6));
        strConta  := fGetVal(Copy(strLinha,59,6));

        If (fGetVal(Copy(strLinha,18,1)) = '2') Then
          strCNPJ := fRetornaCNPJEmpresa(Copy(FstrCodBco, 1, 3),
                                         strLinha)
         Else
          strCNPJ := fRetornaCPFEmpresa(Copy(FstrCodBco, 1, 3),
                                        strLinha);

        If fEmptyStr(fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [strCNPJ])) Then
        Begin
          blnSemEmp := True;
          If lstCNPJ.IndexOf(strCNPJ) = -1 Then
            lstCNPJ.Add(strCNPJ);
        End
        Else
        Begin
          blnArqImp := True;
          While Not Eof(arqArquiv) Do
          Begin
            Readln(arqArquiv,strLinha);

            If Eof(arqArquiv) Then
            begin
              {*******************************************************}
              {* SE O SEGMENTO ANTERIOR FOI G E É FIM DE ARQUIVO *****}
              {* SIGNIFICA QUE O ULTIMO REGISTRO G NÃO FOI EXECUTADO *}
              {*REQ*137946*****************************************MO*}
              if SegmentoAnterior = 'G' then
                qryRetDDA.ExecSQL;

              Continue;
            end;

            If (Copy(strLinha, 8, 1) = '1') Then
            Begin
              If (fGetVal(Copy(strLinha,18,1)) = '2') Then
                strCNPJ := fRetornaCNPJEmpresa(LeftStr(FstrCodBco, 3),
                                               strLinha)
              Else
                strCNPJ := fRetornaCPFEmpresa(LeftStr(FstrCodBco, 3),
                                              strLinha);

              If fEmptyStr(fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [strCNPJ])) Then
              Begin
                blnSemEmp := True;
                If lstCNPJ.IndexOf(strCNPJ) = -1 Then
                  lstCNPJ.Add(strCNPJ);
              End;

              Continue;
            End
            Else If (Copy(strLinha, 8, 1) = '3') And (Copy(strLinha, 14, 1) = 'G') Then
            Begin
              EhDDA := True;

              {**************************************************}
              {* SÓ EXECUTA O SQL SE O SEGMENTO ANTERIOR FOI G. *}
              {* OU SEJA, NÃO TEM SEGMENTO H ********************}
              {*REQ*137946************************************MO*}
              if SegmentoAnterior = 'G' then
                qryRetDDA.ExecSQL;

              SegmentoAnterior := 'G';

              With qryRetDDA Do Begin
                ParamByName('CODBCO').AsString := strCodBco;
                ParamByName('CODEMP').AsString := RetornaCodigoEmpresa(strCNPJ,fGetVal(Copy(strLinha,191,14)));
                ParamByName('CODAGE').AsString := strAgenc;
                ParamByName('CODCTA').AsString := strConta;
                ParamByName('DTAARQ').AsDate   := dtaDtaArq;
                ParamByName('CODLOT').AsString := fGetVal(Copy(strLinha, 4, 4));
                ParamByName('BCOCOM').AsString := fGetVal(Copy(strLinha, 18, 3));
                ParamByName('CODMOE').AsString := fGetVal(Copy(strLinha, 21, 1));
                ParamByName('DIGCBR').AsString := fGetVal(Copy(strLinha, 22, 1));
                ParamByName('FATVEN').AsString := fGetVal(Copy(strLinha, 23, 4));
                ParamByName('VALBAR').AsFloat  := fGetVal(Copy(strLinha, 27, 10), True);
                ParamByName('CAMLIV').AsString := fGetVal(Copy(strLinha, 37, 61));
                ParamByName('CNPCPF').AsString := fGetVal(Copy(strLinha, 62, 1));
                If ParamByName('CNPCPF').AsString = '1' Then
                  ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 67, 11))
                Else
                begin
                  ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 64, 14));
                  if strCodBco.Equals('001') then
                  begin
                    if not (fTestaCgc(ParamByName('CNPJ__').AsString)) then
                      ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 63, 14));
                  end;
                end;
                ParamByName('NOMCED').AsString := fGetVal(Copy(strLinha, 78, 30));
                strDtaAux := fGetVal(Copy(strLinha, 182, 8));
                ParamByName('DTAEMI').AsDate := StrtoDate(Copy(strDtaAux, 1, 2) + '/' + Copy(strDtaAux, 3, 2) + '/' + Copy(strDtaAux, 5, 4));

                //SE FOR CONTRA APRESENTAÇÃO, A DATA DE VENCIMENTO SERÁ A DATA LIMITE DO PAGAMENTO
                strDtaAux := fGetVal(Copy(strLinha, 108, 8));
                If strDtaAux = '11111111' Then
                  ParamByName('DTAVEN').AsDate := ParamByName('DTAEMI').AsDate
                Else If strDtaAux = '99999999' Then
                Begin
                  strDtaAux := fGetVal(Copy(strLinha, 232, 8));
                  ParamByName('DTAVEN').AsDate := StrtoDate(Copy(strDtaAux, 1, 2) + '/' + Copy(strDtaAux, 3, 2) + '/' + Copy(strDtaAux, 5, 4));
                End
                Else
                  ParamByName('DTAVEN').AsDate := StrtoDate(Copy(strDtaAux, 1, 2) + '/' + Copy(strDtaAux, 3, 2) + '/' + Copy(strDtaAux, 5, 4));

                ParamByName('VALTIT').AsFloat  := fGetVal(Copy(strLinha, 116, 15), True);

                {********************************}
                {* DEFINE O NUMERO DA DUPLICATA *}
                {*****************************AJ*}
                strNumDup := StringReplace(fGetVal(Copy(strLinha, 148, 15)), ' ', EmptyStr, [rfReplaceAll]);
                pDescobreNumDup(strNumDup);

                ParamByName('DUPCOR').AsString := strNumDup;
                ParamByName('NUMDUP').AsString := fGetVal(Copy(strLinha, 148, 15));
                ParamByName('AGECOB').AsString := fGetVal(Copy(strLinha, 163, 5));
                ParamByName('DACAGE').AsString := fGetVal(Copy(strLinha, 168, 1));
                ParamByName('MODCAR').AsString := fGetVal(Copy(strLinha, 179, 1));
                ParamByName('ESPDOC').AsString := fGetVal(Copy(strLinha, 180, 2));
                ParamByName('CODFOR').AsString := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [ParamByName('CNPJ__').AsString]);
                ParamByName('CODMOV').AsString := fGetVal(Copy(strLinha, 16, 2));
                strValTit := fPadL(StringReplace(StringReplace(FormatFloat('#,##0.00', ParamByName('VALBAR').AsFloat), ',', EmptyStr, [rfReplaceAll]),'.', EmptyStr, [rfReplaceAll]), 10, '0');
                ParamByName('LINDIG').AsString := fCalculaLinhaDig(ParamByName('BCOCOM').AsString,
                                                  ParamByName('CODMOE').AsString,
                                                  ParamByName('DIGCBR').AsString,
                                                  ParamByName('FATVEN').AsString,
                                                  strValTit,
                                                  ParamByName('CAMLIV').AsString,
                                                  ParamByName('MODCAR').AsString);
                ParamByName('CODBAR').AsString := fRetCodBarLinDig(ParamByName('LINDIG').AsString);
              End;
            End
            Else If (Copy(strLinha, 8, 1) = '3') And (Copy(strLinha, 14, 1) = 'H') Then
            Begin
              EhDDA := True;
              SegmentoAnterior := 'H';

              If (Copy(strLinha, 19, 15).Trim <> '') And
                 (StrToInt64Def(fGetVal(Copy(strLinha, 19, 15)),0) <> 0) Then
              Begin
                qryRetDDA.ParamByName('CNPCPF').AsString := fGetVal(Copy(strLinha, 18, 1));
                If qryRetDDA.ParamByName('CNPCPF').AsString = '1' Then
                  qryRetDDA.ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 23, 11))
                Else
                  qryRetDDA.ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 20, 14));
              End;
              qryRetDDA.ExecSQL;
            End;
          End;
        End;
        fCommit;
      End;
      CloseFile(arqArquiv);

      If (blnArqDDA) And (blnArqImp) And (Not blnSemEmp) And (EhDDA) Then
      Begin
        strNomArq := FlstArquiv[intContador];
        If FileExists(ChangeFileExt(strNomArq,'.old')) Then
          DeleteFile(PWideChar(ChangeFileExt(strNomArq,'.old')));
        RenameFile(strNomArq,ChangeFileExt(strNomArq,'.old'));
      End;
    End;

    If blnSemEmp Then
    Begin
      strCNPJ := '';
      For intContador := 0 to lstCNPJ.Count - 1 do
        strCNPJ := strCNPJ + lstCNPJ[intContador] + ', ';
      pMensagemOK('Algum(ns) arquivo(s) DDA selecionado(s) não foi(ram) importado(s), pois a Empresa do(s) com CNPJ(s) ' +
                  Copy(strCNPJ, 1, Length(strCNPJ) - 2) + ' não está(ão) cadastrada(s) no sistema. Verifique!');
    End;

    If Not blnArqImp Then
      pMensagemOK('Nenhum arquivo DDA foi importado!')
    Else
    begin
      If EhDDA then
        pMensagemOK('Arquivo(s) importado(s) com sucesso!')
      else
        pMensagemOK('O arquivo importado não corresponde ao padrão DDA do banco!');
    end;
    
    FreeAndNil(lstCNPJ);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Ocorreu um erro ao importar os arquivos do banco. ' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
End;

procedure TImportaDDA.pImportaDDASicredi;
Var
    arqArquiv  : TextFile;
    strLinha,
    strAgenc,
    strConta,
    strCNPJ,
    strCodBco,
    strDtaAux,
    strValTit,
    strVerArq,
    strNomArq  : String;
    intContador: Integer;
    dtaDtaArq  : TDate;
    blnArqImp,
    blnArqDDA,
    EhDDA,
    blnSemEmp,
    blnImporta : Boolean;
    lstCNPJ    : TStringList;
    SegmentoAnterior: String;
begin
  Try
    dtaDtaArq  := 0;
    blnArqImp  := False;
    blnSemEmp  := False;
    lstCNPJ    := TStringList.Create;
    EhDDA      := False;
    SegmentoAnterior := '';

    If fCfgSis('DELDDA', varBoolean) Then
      ApagaRetDDA('748');

    For intContador := 0 To FlstArquiv.Count-1 Do
    Begin
      blnArqDDA := True;

      AssignFile(arqArquiv, FlstArquiv[intContador]);
      Reset(arqArquiv);
      Readln(arqArquiv,strLinha);

      Try
        strDtaAux := fGetVal(Copy(strLinha,144,8));
        dtaDtaArq := StrtoDate(Copy(strDtaAux, 1, 2) + '/' + Copy(strDtaAux, 3, 2) + '/' + Copy(strDtaAux, 5, 4));
      Except
        blnArqDDA := False;
      End;
      strVerArq := fGetVal(Copy(strLinha,164,3));

      blnImporta := (Copy(strLinha,1,3) = Copy('748', 1, 3)) And
                    (not fEmptyStr(strVerArq)) And (blnArqDDA);

      If blnImporta Then //verifica se esse arquivo é de DDA dos layouts febraban
      Begin
        fStartTransaction;
        Readln(arqArquiv,strLinha);
        strCodBco := fGetVal(Copy(strLinha,1,3));
        strAgenc  := fGetVal(Copy(strLinha,53,6));  // AGENCIA/DIGITO
        strConta  := fGetVal(Copy(strLinha,59,12)); // CONTA CORRENTE

        If (fGetVal(Copy(strLinha,18,1)) = '2') Then
          strCNPJ := fRetornaCNPJEmpresa('748', strLinha)
        Else
          strCNPJ := fRetornaCPFEmpresa('748', strLinha);

        If fEmptyStr(fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [strCNPJ])) Then
        Begin
          blnSemEmp := True;
          If lstCNPJ.IndexOf(strCNPJ) = -1 Then
            lstCNPJ.Add(strCNPJ);
        End
        Else
        Begin
          blnArqImp := True;
          While Not Eof(arqArquiv) Do
          Begin
            Readln(arqArquiv,strLinha);

            If Eof(arqArquiv) Then
            begin
              {*******************************************************}
              {* SE O SEGMENTO ANTERIOR FOI G E É FIM DE ARQUIVO *****}
              {* SIGNIFICA QUE O ULTIMO REGISTRO G NÃO FOI EXECUTADO *}
              {*REQ*137946*****************************************MO*}
              if SegmentoAnterior = 'G' then
                qryRetDDA.ExecSQL;

              Continue;
            end;

            If (Copy(strLinha, 8, 1) = '1') Then
            Begin
              If (fGetVal(Copy(strLinha,18,1)) = '2') Then
                strCNPJ := fRetornaCNPJEmpresa(LeftStr(FstrCodBco, 3),
                                               strLinha)
              Else
                strCNPJ := fRetornaCPFEmpresa(LeftStr(FstrCodBco, 3),
                                              strLinha);

              If fEmptyStr(fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [strCNPJ])) Then
              Begin
                blnSemEmp := True;
                If lstCNPJ.IndexOf(strCNPJ) = -1 Then
                  lstCNPJ.Add(strCNPJ);
              End;

              Continue;
            End
            Else If (Copy(strLinha, 8, 1) = '3') And (Copy(strLinha, 14, 1) = 'G') Then
            Begin
              EhDDA := True;

              {**************************************************}
              {* SÓ EXECUTA O SQL SE O SEGMENTO ANTERIOR FOI G. *}
              {* OU SEJA, NÃO TEM SEGMENTO H ********************}
              {*REQ*137946************************************MO*}
              if SegmentoAnterior = 'G' then
                qryRetDDA.ExecSQL;

              SegmentoAnterior := 'G';

              With qryRetDDA Do Begin
                ParamByName('CODBCO').AsString := strCodBco;
                ParamByName('CODEMP').AsString := RetornaCodigoEmpresa(strCNPJ,fGetVal(Copy(strLinha,191,14)));
                ParamByName('CODAGE').AsString := strAgenc;
                ParamByName('CODCTA').AsString := strConta;
                ParamByName('DTAARQ').AsDate   := dtaDtaArq;
                ParamByName('CODLOT').AsString := fGetVal(Copy(strLinha, 4, 4));
                ParamByName('BCOCOM').AsString := fGetVal(Copy(strLinha, 18, 3));
                ParamByName('CODMOE').AsString := fGetVal(Copy(strLinha, 21, 1));
                ParamByName('DIGCBR').AsString := fGetVal(Copy(strLinha, 22, 1));
                ParamByName('FATVEN').AsString := fGetVal(Copy(strLinha, 23, 4));
                ParamByName('VALBAR').AsFloat  := fGetVal(Copy(strLinha, 27, 10), True);
                ParamByName('CAMLIV').AsString := fGetVal(Copy(strLinha, 37, 61));
                ParamByName('CNPCPF').AsString := fGetVal(Copy(strLinha, 62, 1));
                ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 64, 14));
                ParamByName('NOMCED').AsString := fGetVal(Copy(strLinha, 78, 30));
                strDtaAux := fGetVal(Copy(strLinha, 182, 8));
                ParamByName('DTAEMI').AsDate := StrtoDate(Copy(strDtaAux, 7, 2) + '/' + Copy(strDtaAux, 5, 2) + '/' + Copy(strDtaAux, 1, 4));

                //SE FOR CONTRA APRESENTAÇÃO, A DATA DE VENCIMENTO SERÁ A DATA LIMITE DO PAGAMENTO
                strDtaAux := fGetVal(Copy(strLinha, 108, 8));
                //If strDtaAux = '11111111' Then
                //  ParamByName('DTAVEN').AsDate := ParamByName('DTAEMI').AsDate
                //Else If strDtaAux = '99999999' Then
                //Begin
                //  strDtaAux := fGetVal(Copy(strLinha, 232, 8));
                //  ParamByName('DTAVEN').AsDate := StrtoDate(Copy(strDtaAux, 1, 2) + '/' + Copy(strDtaAux, 3, 2) + '/' + Copy(strDtaAux, 5, 4));
                //End
                //Else
                If strDtaAux = '00000000' Then
                  ParamByName('DTAVEN').AsDate := ParamByName('DTAEMI').AsDate
                Else
                If strDtaAux = '11111111' Then
                  ParamByName('DTAVEN').AsDate := ParamByName('DTAEMI').AsDate
                Else
                  ParamByName('DTAVEN').AsDate := StrtoDate(Copy(strDtaAux, 7, 2) + '/' + Copy(strDtaAux, 5, 2) + '/' + Copy(strDtaAux, 1, 4));

                ParamByName('VALTIT').AsFloat  := fGetVal(Copy(strLinha, 116, 15), True);

                {********************************}
                {* DEFINE O NUMERO DA DUPLICATA *}
                {*****************************AJ*}
                strNumDup := StringReplace(fGetVal(Copy(strLinha, 148, 15)), ' ', EmptyStr, [rfReplaceAll]);
                pDescobreNumDup(strNumDup);

                ParamByName('DUPCOR').AsString := strNumDup;
                ParamByName('NUMDUP').AsString := fGetVal(Copy(strLinha, 148, 15));
                ParamByName('AGECOB').AsString := fGetVal(Copy(strLinha, 163, 5));
                ParamByName('DACAGE').AsString := fGetVal(Copy(strLinha, 168, 1));
                ParamByName('MODCAR').AsString := fGetVal(Copy(strLinha, 179, 1));
                ParamByName('ESPDOC').AsString := fGetVal(Copy(strLinha, 180, 2));
                ParamByName('CODFOR').AsString := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [ParamByName('CNPJ__').AsString]);
                ParamByName('CODMOV').AsString := fGetVal(Copy(strLinha, 16, 2));
                strValTit := fPadL(StringReplace(StringReplace(FormatFloat('#,##0.00', ParamByName('VALBAR').AsFloat), ',', EmptyStr, [rfReplaceAll]),'.', EmptyStr, [rfReplaceAll]), 10, '0');
                ParamByName('LINDIG').AsString := fCalculaLinhaDig(ParamByName('BCOCOM').AsString,
                                                  ParamByName('CODMOE').AsString,
                                                  ParamByName('DIGCBR').AsString,
                                                  ParamByName('FATVEN').AsString,
                                                  strValTit,
                                                  ParamByName('CAMLIV').AsString,
                                                  ParamByName('MODCAR').AsString);
                ParamByName('CODBAR').AsString := fRetCodBarLinDig(ParamByName('LINDIG').AsString);
              End;
            End
            Else If (Copy(strLinha, 8, 1) = '3') And (Copy(strLinha, 14, 1) = 'H') Then
            Begin
              EhDDA := True;
              SegmentoAnterior := 'H';

              If (Copy(strLinha, 19, 15).Trim <> '') And
                 (StrToInt64Def(fGetVal(Copy(strLinha, 19, 15)),0) <> 0) Then
              Begin
                qryRetDDA.ParamByName('CNPCPF').AsString := fGetVal(Copy(strLinha, 18, 1));
                If qryRetDDA.ParamByName('CNPCPF').AsString = '1' Then
                  qryRetDDA.ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 23, 11))
                Else
                  qryRetDDA.ParamByName('CNPJ__').AsString := fGetVal(Copy(strLinha, 20, 14));
              End;
              qryRetDDA.ExecSQL;
            End;
          End;
        End;
        fCommit;
      End;
      CloseFile(arqArquiv);

      If (blnArqDDA) And (blnArqImp) And (Not blnSemEmp) And (EhDDA) Then
      Begin
        strNomArq := FlstArquiv[intContador];
        If FileExists(ChangeFileExt(strNomArq,'.old')) Then
          DeleteFile(PWideChar(ChangeFileExt(strNomArq,'.old')));
        RenameFile(strNomArq,ChangeFileExt(strNomArq,'.old'));
      End;
    End;

    If blnSemEmp Then
    Begin
      strCNPJ := '';
      For intContador := 0 to lstCNPJ.Count - 1 do
        strCNPJ := strCNPJ + lstCNPJ[intContador] + ', ';
      pMensagemOK('Algum(ns) arquivo(s) DDA selecionado(s) não foi(ram) importado(s), pois a Empresa do(s) com CNPJ(s) ' +
                  Copy(strCNPJ, 1, Length(strCNPJ) - 2) + ' não está(ão) cadastrada(s) no sistema. Verifique!');
    End;

    If Not blnArqImp Then
      pMensagemOK('Nenhum arquivo DDA foi importado!')
    Else
    begin
      If EhDDA then
        pMensagemOK('Arquivo(s) importado(s) com sucesso!')
      else
        pMensagemOK('O arquivo importado não corresponde ao padrão DDA do banco!');
    end;

    FreeAndNil(lstCNPJ);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Ocorreu um erro ao importar os arquivos do banco. ' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
End;

function TImportaDDA.RetornaCodigoEmpresa(ACGC, ACNPJ: String): String;
  Var
    LCodEmp: String;
begin
  If (FstrCodBco = '001') Then
    LCodEmp := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [ACNPJ]); // cnpj do detalhe G

  If fEmptyStr(LCodEmp) Then
    LCodEmp :=  fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [ACGC]); // cnpj/cpf do header

  Result := LCodEmp;
end;

function TImportaDDA.fGetVal(strValor: String; blnFloat: Boolean = False): Variant;
Var strTmp: String;
Begin
  strTmp := Trim(strValor);
  If blnFloat Then
    strTmp := FloattoStr(StrtoFloat(strTmp) / 100);

  Result := strTmp;
End;

function TImportaDDA.fImportaDDA(const ARegistros: TUniClientDataSet;
  const ACodigoBanco: string): Boolean;
var
  LChaveCarteira: string;
  LDadosCarteira: TDDAAPIDadosCarteira;
begin
  Result := False;

  if not Assigned(ARegistros) then
    Exit;

  if not ARegistros.Active then
    Exit;

  if ARegistros.IsEmpty then
    Exit;

  LChaveCarteira := 'CONFIGDDA' + ACodigoBanco + 'API' + '-' + VS_strCodEmp;

  LDadosCarteira := TDDAAPIDadosCarteira.Create(ACodigoBanco, LChaveCarteira);
  try
    Result := fImportaDDA_API_Sicoob(ARegistros, ACodigoBanco, LDadosCarteira);
  finally
    LDadosCarteira.Free;
  end;
end;

function TImportaDDA.fRetCodBarLinDig(strLinDig: String): String;
begin
  Result := Copy(strLinDig, 01, 04) + Copy(strLinDig, 33, 15) + Copy(strLinDig, 05, 05) +
            Copy(strLinDig, 11, 08) + Copy(strLinDig, 19, 02) + Copy(strLinDig, 22, 10);
end;

function TImportaDDA.fRetornaCNPJEmpresa(strCodBco, strLinha: String): String;
begin
  If (Pos(strCodBco, '237_033_104_341_748_') > 0) And fValida_C_G_C(fStrZero(Trim(fGetVal(Copy(strLinha,19,14))), 14)) Then //Incrição com 14 dígitos no header do lote
    Result := fStrZero(Trim(fGetVal(Copy(strLinha,19,14))), 14)
  Else //Incrição com 15 dígitos no header do lote
    Result := fStrZero(Trim(fGetVal(Copy(strLinha,20,14))), 14);
end;

function TImportaDDA.fRetornaCPFEmpresa(strCodBco, strLinha: String): String;
Begin
  If (Pos(strCodBco, '237_033_104_341_748_') > 0) And fValida_C_G_C(fStrZero(Trim(fGetVal(Copy(strLinha,23,11))), 11)) Then //Incrição com 14 dígitos no header do lote
    Result := fStrZero(Trim(fGetVal(Copy(strLinha,23,11))), 11)
  Else //Incrição com 15 dígitos no header do lote
    Result := fStrZero(Trim(fGetVal(Copy(strLinha,24,11))), 11);
End;

function TImportaDDA.fValida_C_G_C(str_C_G_C: String): Boolean;
begin
  Result := Not fEmptyStr(fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [str_C_G_C]))
end;

function TImportaDDA.fCalculaLinhaDig(strCodBco, strMoeda, strDac, strFatorV, strValTit, strCamLiv, strModCar: String): String;
begin
  untFuncoesBoleto.strIdeBan := strCodBco;
  untFuncoesBoleto.strMoeda1 := strMoeda;
  untFuncoesBoleto.strDiAuCo := strDac;
  untFuncoesBoleto.strFatVen := strFatorV;
  untFuncoesBoleto.strVlrTit := strValTit;
  untFuncoesBoleto.strCmpLiv := strCamLiv;

  If strModCar = '1' Then
    untFuncoesBoleto.strModCob := 'S'
  Else
    untFuncoesBoleto.strModCob := 'N';

  If fCalculaDigitos Then
    Result := strCodBco + strMoeda + Copy(strCamLiv, 1, 5) +
              strDigit1 + Copy(strCamLiv, 6, 10) + strDigit2 +
              Copy(strCamLiv, 16, 10)  + strDigit3 + strDiAuCo +
              strFatorV + strValTit
  Else
    Result := '';
end;

function TImportaDDA.fImportaDDA_API_Sicoob(const ADados: TUniClientDataSet;
  const ACodigoBanco: string;
  const ADadosCarteira: TDDAAPIDadosCarteira): Boolean;
var
  LCodigoAgencia  : string;
  LContaCorrente  : string;
begin
  Result := True;
  if (ADados = nil) then
    Exit;
  if (ADados.IsEmpty) then
    Exit;

  LCodigoAgencia := fGetBancoConfig(0, ADadosCarteira.Configuracao, 'CODAGEN', '');
  LContaCorrente := ADadosCarteira.ContaCorrente;

  ADados.First;

  while not ADados.Eof do

  begin
    qryRetDDA.ParamByName('CODBCO').AsString := ADados.FieldByName('CODBCO').AsString;
    qryRetDDA.ParamByName('CODEMP').AsString := ADados.FieldByName('CODEMP').AsString;
    qryRetDDA.ParamByName('CODAGE').AsString := ADados.FieldByName('CODAGE').AsString;
    qryRetDDA.ParamByName('CODCTA').AsString := ADados.FieldByName('CODCTA').AsString;
    qryRetDDA.ParamByName('DTAARQ').AsDateTime := ADados.FieldByName('DTAARQ').AsDateTime;
    qryRetDDA.ParamByName('CODLOT').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('DIGCBR').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('FATVEN').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('VALBAR').AsFloat := ADados.FieldByName('VALTIT').AsFloat;
    qryRetDDA.ParamByName('CNPCPF').AsString := EmptyStr; //NÃO TEM NO JSON
   	qryRetDDA.ParamByName('CNPJ__').AsString := ADados.FieldByName('CNPJ__').AsString;
   	qryRetDDA.ParamByName('NOMCED').AsString := ADados.FieldByName('NOMCED').AsString;
    qryRetDDA.ParamByName('DTAVEN').AsDateTime := ADados.FieldByName('DTAVEN').AsDateTime;
   	qryRetDDA.ParamByName('VALTIT').AsFloat := ADados.FieldByName('VALTIT').AsFloat;
    qryRetDDA.ParamByName('CODMOE').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('NUMDUP').AsString := ADados.FieldByName('NUMDUP').AsString;
    qryRetDDA.ParamByName('AGECOB').AsString := ADados.FieldByName('CODAGE').AsString;
    qryRetDDA.ParamByName('MODCAR').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('ESPDOC').AsString := ADados.FieldByName('ESPDOC').AsString;
    qryRetDDA.ParamByName('DTAEMI').AsDateTime := Date; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('CODMOV').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('BCOCOM').AsString := ADados.FieldByName('BCOCOM').AsString;
    qryRetDDA.ParamByName('CAMLIV').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('CODFOR').AsString := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [qryRetDDA.ParamByName('CNPJ__').AsString]);
    qryRetDDA.ParamByName('LINDIG').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ParamByName('CODBAR').AsString := ADados.FieldByName('CODBAR').AsString;
    qryRetDDA.ParamByName('DUPCOR').AsString := EmptyStr; //NÃO TEM NO JSON
    qryRetDDA.ExecSQL;
    ADados.Next;
  end;
end;

end.
