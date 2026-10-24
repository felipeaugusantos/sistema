unit untTGeraFCI;

interface

uses Classes, SysUtils, StrUtils, Uni, DB, StdCtrls, Controls, ExtCtrls,
  untFuncoesSimples, UniClientDataSet;

type
  TBloco0Reg0000 = Record
    sCnpj: String;
    sNomEmp: String;
    sVersao: String;
    sHash  : String;
    sDtRece: String;
    sCdRece: String;
    sDtVali: String;
    sValArq: String;
  End;

  TBloco5Reg5020 = Record
    sDesIte: String;
    sCodNcm: String;
    sCodIte: String;
    sCdGtin: String;
    sUnidad: String;
    fPreVen: Extended;
    fPropor: Extended;
    fCoefic: Extended;
    sCodFci: String;
    sValFci: String;
  End;

  TGeraFCI = class(TObject)
  private
    FLinPro: String;
    FCodPro: String;
    FCodEmp: String;
    FCamArq: String;

    FBloco0:  TStrings;
    FBloco5:  TStrings;
    FBloco9:  TStrings;
    FArquivo: TStrings;

    FQryItens: TUniQuery;
    FCdsItens: TUniClientDataSet;

    FReg0000: TBloco0Reg0000;
    FReg5020: Array of TBloco5Reg5020;

    Const
      SQL_ITENS = 'SELECT ' +
          'I.ITE_CODITE AS CODITE, ' +
          'I.ITE_DESITE AS DESITE, ' +
          'I.ITE_CLAIPI AS CODNCM, ' +
          '""           AS CDGTIN, ' +
          '"99"         AS UNIDAD, ' +
          'ROUND(SUM( ' +
          '    IF( ' +
          '      SUBSTR( ' +
          '        CASE ' +
          '          WHEN (F.FOR_MATREV = "C") THEN ICM.ABF_CODSIT_ENT_PER ' +
          '          WHEN (F.FOR_MATREV = "D") THEN ICM.ABF_CODSIT_ENT_PER ' +
          '          WHEN (F.FOR_MATREV = "I") THEN ICM.ABF_CODSIT_ENT_PEJ ' +
          '          WHEN (F.FOR_MATREV = "R") THEN ICM.ABF_CODSIT_ENT_PER ' +
          '          WHEN (F.FOR_MATREV = "M") THEN ICM.ABF_CODSIT_ENT_PER ' +
          '          ELSE "" ' +
          '        END, 1, 1) IN ("1", "2", "6", "7"), ' +
          '      DM.DMT_QTDITE, ' +
          '      0 ' +
          '    ) ' +
          '  ) / SUM(DM.DMT_QTDITE) * 100, 2) AS PROPOR, ' +
          '"OUTRAS UNIDADES" AS DESUNI, ' +
          '0.00 AS COEFIC, ' +
          '"" AS CODFCI, ' +
          '"" AS VALFCI, ' +
          'G.ITE_PREVE' + '<<TABPRE>>' + ' AS PREVEN, ' +
          'ROUND(COALESCE((G.ITE_PRECOM - (G.ITE_PRECOM * (COALESCE(G.ITE_ICMENT,0) / 100)) ' +
          '              - (G.ITE_PRECOM * (COALESCE(G.ITE_IPIENT,0) / 100))) ' +
          '              + (G.ITE_PRECOM * (COALESCE(G.ITE_FREENT,0) / 100)),0),2) C_PROPOR ' +
          'FROM ' +
          'GERMAT GM ' +
          'INNER JOIN CADITE I ' +
          '  ON GM.GMT_CODITE = I.ITE_CODITE ' +
          'INNER JOIN DETMAT DM ' +
          '  ON DM.DMT_SEQGER = GM.AUTOINCREM ' +
          'INNER JOIN ITEGER G ' +
          '  ON I.ITE_CODITE = G.ITE_CODITE ' +
          '  AND G.ITE_CODEMP = :CODEMP ' +
          'INNER JOIN CADITE DET ' +
          '  ON DM.DMT_ITESUB = DET.ITE_CODITE ' +
          'INNER JOIN CADFOR F ' +
          '  ON F.FOR_CODFOR = DET.ITE_CODFOR ' +
          'INNER JOIN CADCID CID ' +
          '  ON CID.CID_CODCID = F.FOR_CODCID ' +
          'INNER JOIN ABFICM ICM ' +
          '  ON ICM.ABF_CODABF = DET.ITE_CODABF ' +
          '  AND ICM.ABF_ESTADO = CID.CID_ESTADO ' +
          '<<WHERE>> ' +
          'GROUP BY GM.GMT_CODITE ' +
          '<<HAVING>>' +
          'ORDER BY I.ITE_DESITE ';

      SQL_UPDATE_ITENS = 'UPDATE CADITE SET ITE_NUMFCI = :NUMFCI, ' +
          'ITE_PER_CI = :PER_CI WHERE ITE_CODITE = :CODITE';

    function GerarBlocoZero: Boolean;
    function GerarBlocoCinco: Boolean;
    function GerarBlocoNove: Boolean;
    function GerarArquivo: Boolean;
    function CriarDataSetItens: TUniClientDataSet;
    procedure Limpar;
    function ValidarArquivoImportacao(ACamArq: String): Boolean;
  public
    constructor Create(ACodEmp: String); Reintroduce;
    destructor Destroy; Override;

    function FiltrarProdutos(ATabPre: String): Boolean; Overload;
    function FiltrarProdutos(ATabPre, ALinPro, ACodPro: String): Boolean; Overload;
    function ExportarDados(ACamArq, ATabPre, ALinPro, ACodPro: String): Boolean;
    function ImportarDados: Boolean;
    function CarregarProdutosArquivoImportacao(ACamArq: String): Boolean;

    property cdsItens: TUniClientDataSet read FCdsItens;
  end;

implementation

{ TGeraFCI }

function TGeraFCI.CarregarProdutosArquivoImportacao(ACamArq: String): Boolean;
  var
    i: Integer;
begin
  Result := False;

  If (fEmptyStr(ACamArq)) Then Begin
    fMensagem('AVISO', 'Arquivo informado para importação é inválido!', ['&Ok']);
  End Else If (Not FileExists(ACamArq)) Then Begin
    fMensagem('AVISO', 'Arquivo informado para importação não pôde ser encontrado!', ['&Ok']);
  End Else If (Not (Copy(ACamArq, Length(ACamArq) - 3, 4) = '.txt')) Then Begin
    fMensagem('AVISO', 'Arquivo informado para importação deve possuir extensão ''.txt''!', ['&Ok']);
  End Else If (ValidarArquivoImportacao(ACamArq)) Then Begin
    FCdsItens.Close();
    FCdsItens.Open();
    FCdsItens.EmptyDataSet();

    TFloatField(FCdsItens.FieldByname('PROPOR')).DisplayFormat   := '#,##0.00';
    TFloatField(FCdsItens.FieldByname('PREVEN')).DisplayFormat   := '#,##0.00';
    TFloatField(FCdsItens.FieldByname('COEFIC')).DisplayFormat   := '#,##0.00';

    For i := 0 To Length(FReg5020) - 1 Do Begin
      FCdsItens.Append();

      FCdsItens.FieldByName('CODITE').AsString := FReg5020[i].sCodIte;
      FCdsItens.FieldByName('DESITE').AsString := FReg5020[i].sDesIte;
      FCdsItens.FieldByName('CODNCM').AsString := FReg5020[i].sCodNcm;
      FCdsItens.FieldByName('CDGTIN').AsString := FReg5020[i].sCdGtin;
      FCdsItens.FieldByName('UNIDAD').AsString := FReg5020[i].sUnidad;
      FCdsItens.FieldByName('DESUNI').AsString := 'OUTRAS UNIDADES';
      FCdsItens.FieldByName('CODFCI').AsString := FReg5020[i].sCodFci;
      FCdsItens.FieldByName('VALFCI').AsString := FReg5020[i].sValFci;
      FCdsItens.FieldByName('PREVEN').AsFloat  := FReg5020[i].fPreVen;
      FCdsItens.FieldByName('COEFIC').AsFloat  := FReg5020[i].fCoefic;
      FCdsItens.FieldByName('PROPOR').AsFloat  := FReg5020[i].fPropor;
    End;

    Result := True;
  End;
end;

constructor TGeraFCI.Create(ACodEmp: String);
begin
  If (Not fEmptyStr(ACodEmp)) Then Begin
    FCodEmp := ACodEmp
  End Else Begin
    fMensagem('AVISO', 'Código da empresa deve ser informado!', ['&Ok']);
    Exit;
  End;

  FLinPro := '';
  FCodPro := '';
  FCamArq := '';

  FBloco0  := TStringList.Create();
  FBloco5  := TStringList.Create();
  FBloco9  := TStringList.Create();
  FArquivo := TStringList.Create();

  FQryItens := fCriaQuery(nil);
  FCdsItens := CriarDataSetItens();
end;

function TGeraFCI.CriarDataSetItens: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'CODITE';
    DataType := ftString;
    Size     := fTamCodIte;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'DESITE';
    DataType := ftString;
    Size     := 255;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'CODNCM';
    DataType := ftString;
    Size     := 8;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'CDGTIN';
    DataType := ftString;
    Size     := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'UNIDAD';
    DataType := ftString;
    Size     := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'DESUNI';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'CODFCI';
    DataType := ftString;
    Size     := 36;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'VALFCI';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'PROPOR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'PREVEN';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'COEFIC';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do Begin
    Name     := 'C_PROPOR';
    DataType := ftFloat;
  End;

  Result.CreateDataSet;
end;

destructor TGeraFCI.Destroy;
begin
  FreeAndNil(FQryItens);
  FreeAndNil(FCdsItens);
  FreeAndNil(FBloco0);
  FreeAndNil(FBloco5);
  FreeAndNil(FBloco9);
  FreeAndNil(FArquivo);

  inherited;
end;

function TGeraFCI.ExportarDados(ACamArq, ATabPre, ALinPro, ACodPro: String): Boolean;

  function ValidarProdutos: Boolean;
  begin
    Result := True;

    FCdsItens.First();

    While (Not FCdsItens.Eof) Do Begin
      Result := ((FCdsItens.FieldByName('PROPOR').AsFloat > 0) Or (FCdsItens.FieldByName('C_PROPOR').AsFloat > 0)) And
                (FCdsItens.FieldByName('PREVEN').AsFloat > 0) And
                (FCdsItens.FieldByName('COEFIC').AsFloat > 0);

      If (Not Result) Then
        Break
      Else
        FCdsItens.Next();
    End;
  end;

begin
  Result := False;

  //validar caminho arquivo
  If (fEmptyStr(ACamArq)) Then Begin
    fMensagem('AVISO', 'Caminho para geração do arquivo FCI é inválido!', ['&Ok']);
    Exit;
  End Else If (Not DirectoryExists(ACamArq)) Then Begin
    fMensagem('AVISO', 'Caminho para geração do arquivo FCI não foi encontrado!', ['&Ok']);
    Exit;
  End Else If (Copy(ACamArq, Length(ACamArq), 1) <> '\') Then Begin
    FCamArq := ACamArq + '\';
  End;

  //filtrar produtos
  FLinPro := ALinPro;
  FCodPro := ACodPro;

  If (Not ValidarProdutos()) Then Begin
    fMensagem('AVISO', 'Existem produtos com os campos ''Preço de Venda'', ''Prop. Importada'' ' + #13#10 +
      'ou ''% Coeficiente Imp.'' zerados. Verifique o cadastro dos produtos antes de realizar a exportação!', ['&Ok']);
    Exit;
  End;

  //gerar bloco 0
  If (Not GerarBlocoZero()) Then Exit;

  //gerar bloco 5
  If (Not GerarBlocoCinco()) Then Exit;

  //gerar bloco 9
  If (Not GerarBlocoNove()) Then Exit;

  //salvar arquivo
  Result := GerarArquivo();
end;

function TGeraFCI.FiltrarProdutos(ATabPre, ALinPro, ACodPro: String): Boolean;
begin
  //filtrar produtos
  FLinPro := ALinPro;
  FCodPro := ACodPro;

  Result := FiltrarProdutos(ATabPre);

  If (Not Result) Then
    fMensagem('AVISO', 'Nenhum produto foi encontrado para geração do arquivo FCI!', ['&Ok']);
end;

function TGeraFCI.FiltrarProdutos(ATabPre: String): Boolean;

  function AjustarSQL: String;
    var
      sSQL, sTemp, sHaving: String;
  begin
    sSQL := AnsiReplaceStr(SQL_ITENS, '<<TABPRE>>', ATabPre);

    If fCfgSis('GFCFCI') = 'V' Then //Proporcional ao preço de Venda
      sHaving := 'HAVING (PROPOR > 0) '
    Else If fCfgSis('GFCFCI') = 'C' then //Proporcional ao preço de Compra
      sHaving := 'HAVING (C_PROPOR > 0) ';

    sSQL := AnsiReplaceStr(sSQL, '<<HAVING>>', sHaving);

    If (Not fEmptyStr(FLinPro)) Or (Not fEmptyStr(FCodPro)) Then
    Begin
      sTemp := 'WHERE ';

      If (Not fEmptyStr(FLinPro)) Then
        sTemp := sTemp + 'I.ITE_CODGRU = :CODGRU ';

      If (Not fEmptyStr(FCodPro)) Then
        If (Pos('CODGRU', sTemp) > 0) Then
          sTemp := sTemp + 'AND I.ITE_CODITE = :CODITE '
        Else
          sTemp := sTemp + 'I.ITE_CODITE = :CODITE ';

      If fCfgSis('GFCFCI') = 'C' Then
      Begin
        sTemp := sTemp + ' AND SUBSTR(                                                    ';
        sTemp := sTemp + '        CASE                                                    ';
        sTemp := sTemp + '          WHEN (F.FOR_MATREV = "C") THEN ICM.ABF_CODSIT_ENT_PER ';
        sTemp := sTemp + '          WHEN (F.FOR_MATREV = "D") THEN ICM.ABF_CODSIT_ENT_PER ';
        sTemp := sTemp + '          WHEN (F.FOR_MATREV = "I") THEN ICM.ABF_CODSIT_ENT_PEJ ';
        sTemp := sTemp + '          WHEN (F.FOR_MATREV = "R") THEN ICM.ABF_CODSIT_ENT_PER ';
        sTemp := sTemp + '          WHEN (F.FOR_MATREV = "M") THEN ICM.ABF_CODSIT_ENT_PER ';
        sTemp := sTemp + '          ELSE ""                                               ';
        sTemp := sTemp + '        END, 1, 1) IN ("1", "2", "6", "7")                      ';
      End;

      sSQL := AnsiReplaceStr(sSQL, '<<WHERE>>', sTemp);
    End
    Else
    Begin
      sSQL := AnsiReplaceStr(sSQL, '<<WHERE>>', '');
    End;

    If (fCfgSis('UTIIND', varBoolean)) Then Begin
      sSQL := AnsiReplaceStr(sSQL, 'GERMAT', 'GEIMAT');
      sSQL := AnsiReplaceStr(sSQL, 'DETMAT', 'DEIMAT');
    End;

    Result := sSQL;
  end;

begin
  Result := False;

  If(fEmptyStr(ATabPre)) Then Begin
    fMensagem('AVISO', 'Tabela de preço inválida!', ['&Ok']);
    Exit;
  End;

  Try
    FQryItens.Close();
    FQryItens.SQL.Clear();
    FQryItens.SQL.Add(AjustarSQL());
    FQryItens.ParamByName('CODEMP').AsString := FCodEmp;

    If (Pos(':CODGRU', FQryItens.SQL.Text) > 0) Then
      FQryItens.ParamByName('CODGRU').AsString := FLinPro;

    If (Pos(':CODITE', FQryItens.SQL.Text) > 0) Then
      FQryItens.ParamByName('CODITE').AsString := FCodPro;

    FQryItens.Open();

    Result := (FQryItens.RecordCount > 0);

    If (Result) Then Begin
      FQryItens.First();
      FCdsItens.Close();
      FCdsItens.Open();
      FCdsItens.EmptyDataSet();

      TFloatField(FCdsItens.FieldByname('PROPOR')).DisplayFormat   := '#,##0.00';
      TFloatField(FCdsItens.FieldByname('PREVEN')).DisplayFormat   := '#,##0.00';
      TFloatField(FCdsItens.FieldByname('COEFIC')).DisplayFormat   := '#,##0.00';

      While (Not FQryItens.Eof) Do Begin
        FCdsItens.Append();

        FCdsItens.FieldByName('CODITE').AsString := FQryItens.FieldByname('CODITE').AsString;
        FCdsItens.FieldByName('DESITE').AsString := FQryItens.FieldByname('DESITE').AsString;
        FCdsItens.FieldByName('CODNCM').AsString := FQryItens.FieldByname('CODNCM').AsString;
        FCdsItens.FieldByName('CDGTIN').AsString := FQryItens.FieldByname('CDGTIN').AsString;
        FCdsItens.FieldByName('UNIDAD').AsString := FQryItens.FieldByname('UNIDAD').AsString;
        FCdsItens.FieldByName('DESUNI').AsString := FQryItens.FieldByname('DESUNI').AsString;
        FCdsItens.FieldByName('CODFCI').AsString := FQryItens.FieldByname('CODFCI').AsString;
        FCdsItens.FieldByName('VALFCI').AsString := FQryItens.FieldByname('VALFCI').AsString;
        FCdsItens.FieldByName('PREVEN').AsFloat  := FQryItens.FieldByname('PREVEN').AsFloat;
        if fCfgSis('GFCFCI') = 'V' then //Proporcional ao preço de Venda
        Begin
          FCdsItens.FieldByName('COEFIC').AsFloat  := FQryItens.FieldByName('PROPOR').AsFloat;
          FCdsItens.FieldByName('PROPOR').AsFloat  := (FQryItens.FieldByName('PROPOR').AsFloat / 100) *
                                                       FQryItens.FieldByname('PREVEN').AsFloat;
        End
        Else if fCfgSis('GFCFCI') = 'C' then //Proporcional ao preço de Compra
        Begin
          FCdsItens.FieldByName('COEFIC').AsFloat  := (FQryItens.FieldByName('C_PROPOR').AsFloat /
                                                       FQryItens.FieldByname('PREVEN').AsFloat) * 100;
          FCdsItens.FieldByName('PROPOR').AsFloat  := FQryItens.FieldByName('C_PROPOR').AsFloat;
        End;
        FQryItens.Next();
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TGeraFCI.FiltrarProdutos]');
  End;
end;

function TGeraFCI.GerarArquivo: Boolean;
   var
     i: Integer;
     sNomArq: String;
begin
  Try
    Result := True;

    Try
      For i := 0 To FBloco0.Count - 1 Do
        FArquivo.Add(FBloco0[i]);

      For i := 0 To FBloco5.Count - 1 Do
        FArquivo.Add(FBloco5[i]);

      For i := 0 To FBloco9.Count - 1 Do
        FArquivo.Add(FBloco9[i]);

      sNomArq := fTiraCaracEspeciais(fRetCGCEmpresa(FCodEmp)) +
        FormatDateTime('_YYYYMMDD_HHMMSS', fNow()) + '.txt';

      FArquivo.SaveToFile(FCamArq + sNomArq, TEncoding.UTF8);
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message, '[TGeraFCI.GerarArquivo]');
      End;
    End;
  Finally
    Limpar();
  End;
end;

function TGeraFCI.GerarBlocoCinco: Boolean;
  var
    iRegistro: Integer;
    sRegistro: String;

  procedure AdicionarRegistro;
  begin
    Inc(iRegistro);
    FBloco5.Add(sRegistro);
  end;

begin
  Result    := True;
  iRegistro := 0;

  Try
    //***********************Registro 5001***********************
    sRegistro := '5001';  //TIPO_REGISTRO
    AdicionarRegistro();

    //***********************Registro 5020***********************
    FCdsItens.First();
    While (Not FCdsItens.Eof) Do Begin
      sRegistro := '5020|'   +   //TIPO_REGISTRO
                   Copy(FCdsItens.FieldByName('DESITE').AsString,
                                                    1, 255)    + '|' + //NOME_MERCADORIA
                   fTiraCaracEspeciais(
                     FCdsItens.FieldByName('CODNCM').AsString) + '|' + //CODIGO_NCM
                   FCdsItens.FieldByName('CODITE').AsString    + '|' + //CODIGO_MERCADORIA
                   FCdsItens.FieldByName('CDGTIN').AsString    + '|' + //CODIGO_GTIN
                   FCdsItens.FieldByName('UNIDAD').AsString    + '|' + //UNIDADE_MERCADORIA
                   FormatFloat('0.00',
                     FCdsItens.FieldByName('PREVEN').AsFloat)  + '|' + //VALOR_SAIDA_MERCADORIA_INTERESTADUAL
                   FormatFloat('0.00',
                     FCdsItens.FieldByName('PROPOR').AsFloat)  + '|' + //VALOR_PARCELA_IMPORTADA_EXTERIOR
                   FormatFloat('0.00',
                     FCdsItens.FieldByName('COEFIC').AsFloat);         //CONTEUDO_IMPORTACAO_CI

      FCdsItens.Next();
      AdicionarRegistro();
    End;

    //***********************Registro 5990***********************
    sRegistro := '5990|' +                //TIPO_REGISTRO
                 IntToStr(iRegistro + 1); //QUANTIDADE_LINHAS
    FBloco5.Add(sRegistro);
  Except
    On E: Exception Do Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraFCI.GerarBlocoCinco]');
    End;
  End;
end;

function TGeraFCI.GerarBlocoNove: Boolean;
  var
    iRegistro: Integer;

begin
  Result    := True;

  Try
    //***********************Registro 9001***********************
    FBloco9.Add('9001');

    //***********************Registro 9900***********************
    FBloco9.Add('9900|0000|1');
    FBloco9.Add('9900|0010|1');
    FBloco9.Add('9900|5020|' + IntToStr(FCdsItens.RecordCount));

    //***********************Registro 9990***********************
    FBloco9.Add('9990|5');

    //***********************Registro 9999***********************
    iRegistro := FBloco0.Count + FBloco5.Count + FBloco9.Count + 1;
    FBloco9.Add('9999|' + IntToStr(iRegistro));
  Except
    On E: Exception Do Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraFCI.GerarBlocoNove]');
    End;
  End;
end;

function TGeraFCI.GerarBlocoZero: Boolean;
  var
    sRegistro: String;
begin
  Result := True;

  Try
    //***********************Registro 0000***********************
    sRegistro := '0000|'                                +       //TIPO_REGISTRO
                 fTiraCaracEspeciais(
                   fRetCGCEmpresa(FCodEmp))             + '|' + //CNPJ_CONTRIBUINTE
                 Copy(fRetNomeEmpresa(FCodEmp), 1, 255) + '|' + //NOME_CONTRIBUINTE
                 '1.0';                                         //VERSAO_LEIAUTE
    FBloco0.Add(sRegistro);

    //***********************Registro 0001***********************
    sRegistro := '0001|'                    +       //TIPO_REGISTRO
                 'Texto em caracteres UTF-8: (dígrafo BR)' + QuotedStr('ção') +
                 ',(dígrafo espanhol-enhe)' + QuotedStr('ñ') +
                 ',(trema)' + QuotedStr('Ü') + ',(ordinais)' +
                 QuotedStr('ªº') + ',(ligamento s+z alemão)' +
                 QuotedStr('ß') + '.'; //TEXTO_PADRAO_UTF8
    FBloco0.Add(sRegistro);

    //***********************Registro 0010***********************
    sRegistro := '0010|'                                    +       //TIPO_REGISTRO
                 fTiraCaracEspeciais(
                   fRetCGCEmpresa(FCodEmp))                 + '|' + //CNPJ_CONTRIBUINTE
                 Copy(fRetNomeEmpresa(FCodEmp), 1 ,255)     + '|' + //NOME_RAZAO_SOCIAL
                 Copy(fTiraCaracEspeciais(
                   fRetIE_Empresa(FCodEmp)), 1, 20)         + '|' + //INSCRIÇÃO_ESTADUA
                 Copy(fRetEnderecoEmpresa(FCodEmp), 1, 255) + '|' + //ENDEREÇO_ESTABELECIMENTO
                 fTiraCaracEspeciais(
                   fRetCEP_Empresa(FCodEmp))                + '|' + //CEP
                 Copy(fRetNomCidade(
                   fRetCidEmpresa(FCodEmp)), 1, 255)        + '|' + //MUNICÍPIO
                 fRetUFEmpresa(FCodEmp);       //UF
    FBloco0.Add(sRegistro);

    //***********************Registro 0990***********************
    sRegistro := '0990|' + //TIPO_REGISTRO
                 '4';      //QUANTIDADE_LINHAS
    FBloco0.Add(sRegistro);
  Except
    On E: Exception Do Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraFCI.GerarBlocoZero]');
    End;
  End;
end;

function TGeraFCI.ImportarDados: Boolean;
  var
    i: Integer;
begin
  Try
    If (Length(FReg5020) > 0) Then Begin
      fStartTransaction();

      For i := 0 To Length(FReg5020) - 1 Do Begin

        FQryItens.Close();
        FQryItens.SQL.Clear();
        FQryItens.SQL.Add(SQL_UPDATE_ITENS);
        FQryItens.ParamByName('CODITE').AsString := FReg5020[i].sCodIte;
        FQryItens.ParamByName('NUMFCI').AsString := FReg5020[i].sCodFci;
        FQryItens.ParamByName('PER_CI').AsFloat  := FReg5020[i].fCoefic;
        FQryItens.ExecSQL();
      End;

      fCommit();
      Limpar();
      Result := True;
    End Else Begin
      Result := False;
    End;
  Except
    On E: Exception Do Begin
      Result := False;
      fRollBack();
      pMensagensErro(E.Message, '[TGeraFCI.ImportarDados]');
    End;
  End;
end;

procedure TGeraFCI.Limpar;
begin
  FLinPro := '';
  FCodPro := '';
  FCamArq := '';

  FBloco0.Clear();
  FBloco5.Clear();
  FBloco9.Clear();
  FArquivo.Clear();

  FCdsItens.Close();
  FCdsItens.Open();
  FCdsItens.EmptyDataSet();
end;

function TGeraFCI.ValidarArquivoImportacao(ACamArq: String): Boolean;
  var
    i: Integer;

  function ContarPipes(ARegistros: TStrings): Integer;
    var
      i: Integer;
      sRegistro: String;
  begin
    Result    := 0;

    For i := 0 To ARegistros.Count - 1 Do Begin
      sRegistro := ARegistros[i];

      While (Pos('|', sRegistro) > 0) Do Begin
        sRegistro := Copy(sRegistro, Pos('|', sRegistro) + 1, Length(sRegistro));
        Inc(Result);
      End;
    End;
  end;

  procedure InicializarRegistro0000;
    var
      sTemp: String;
  begin
    With FReg0000 Do Begin
      sTemp := Copy(FBloco0[0], Pos('|', FBloco0[0]) + 1, Length(FBloco0[0]));
      sCnpj := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sNomEmp := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sVersao := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sHash   := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sDtRece := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sCdRece := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sDtVali := Copy(sTemp, 1, Pos('|', sTemp) - 1);

      sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
      sValArq := Copy(sTemp, 1, Length(sTemp));
    End;
  end;

  procedure InicializarRegistros5020;
    var
      i: Integer;
      sTemp: String;
  begin
    Try
      SetLength(FReg5020, FBloco5.Count);

      For i := 0 To FBloco5.Count - 1 Do Begin
        With FReg5020[i] Do Begin
          sTemp   := Copy(FBloco5[i], Pos('|', FBloco5[i]) + 1, Length(FBloco5[i]));
          sDesIte := Copy(sTemp, 1, Pos('|', sTemp) - 1);

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          sCodNcm := Copy(sTemp, 1, Pos('|', sTemp) - 1);

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          sCodIte := Copy(sTemp, 1, Pos('|', sTemp) - 1);

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          sCdGtin := Copy(sTemp, 1, Pos('|', sTemp) - 1);

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          sUnidad := Copy(sTemp, 1, Pos('|', sTemp) - 1);

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          fPreVen := fStrToFloat(Copy(sTemp, 1, Pos('|', sTemp) - 1));

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          fPropor := fStrToFloat(Copy(sTemp, 1, Pos('|', sTemp) - 1));

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          fCoefic := fStrToFloat(Copy(sTemp, 1, Pos('|', sTemp) - 1));

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          sCodFci := Copy(sTemp, 1, Pos('|', sTemp) - 1);

          sTemp   := Copy(sTemp, Pos('|', sTemp) + 1, Length(sTemp));
          sValFci := Copy(sTemp, 1, Length(sTemp));
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TGeraFCI.ValidarArquivoImportacao.InicializarRegistros5020]');
    End;
  end;

  function ValidarRegistro0000: Boolean;
  begin
    Result := (Not ((fEmptyStr(FReg0000.sHash))   Or (fEmptyStr(FReg0000.sDtRece))
                 Or (fEmptyStr(FReg0000.sCdRece)) Or (fEmptyStr(FReg0000.sDtVali))
                 Or (fEmptyStr(FReg0000.sValArq))));
  end;

  function ValidarRegistros5020: Boolean;
    var
      i: Integer;
  begin
    If (Length(FReg5020) = 0) Then Begin
      Result := False;
    End Else Begin
      Result := True;

      For i := 0 To Length(FReg5020) - 1 Do Begin
        If (fEmptyStr(FReg5020[i].sCodFci)) Or (fEmptyStr(FReg5020[i].sValFci)) Then Begin
          Result := False;
          Break;
        End;
      End;
    End;
  end;

begin
  //carregar arquivo
  FArquivo.LoadFromFile(ACamArq);

  //carregar linhas bloco 0
  FBloco0.Clear();

  For i := 0 To FArquivo.Count - 1 Do
    If (Copy(FArquivo[i], 1, 4) = '0000') Then
      FBloco0.Add(FArquivo[i]);

  If ((ContarPipes(FBloco0) mod 8) = 0) Then Begin  //quantidade de campos do registro menos 1
    InicializarRegistro0000();

    If (Not ValidarRegistro0000()) Then Begin
      fMensagem('AVISO', 'Informações de confirmação de validação do arquivo FCI não foram encontradas. Importação cancelada!', ['&Ok']);
      Result := False;
    End Else Begin
      If (Not (FReg0000.sCnpj = fTiraCaracEspeciais(fRetCGCEmpresa(FCodEmp)))) Then Begin
        fMensagem('AVISO', 'CNPJ do arquivo é diferente da empresa logada. Importação cancelada!', ['&Ok']);
        Result := False;
      End Else Begin
        //carregar linhas bloco 5
        FBloco5.Clear();

        For i := 0 To FArquivo.Count - 1 Do
          If (Copy(FArquivo[i], 1, 4) = '5020') Then
            FBloco5.Add(FArquivo[i]);

        If (ContarPipes(FBloco5) = (FBloco5.Count * 10)) Then Begin  //quantidade de campos do registro menos 1
          InicializarRegistros5020();

          If (Not ValidarRegistros5020()) Then Begin
            fMensagem('AVISO', 'Existem produtos sem o código FCI ou indicador de validação no arquivo ' + #13#10 +
              'informado. Importação cancelada!', ['&Ok']);
            Result := False;
          End Else Begin
            Result := True;
          End;
        End Else Begin
          fMensagem('AVISO', 'Quantidade de campos do bloco 5 (cinco) está incorreta. Importação cancelada!', ['&Ok']);
          Result := False;
        End
      End;
    End;
  End Else Begin
    fMensagem('AVISO', 'Quantidade de campos do bloco 0 (zero) está incorreta. Importação cancelada!', ['&Ok']);
    Result := False;
  End;

  If (Not Result) Then Limpar();
end;

end.
