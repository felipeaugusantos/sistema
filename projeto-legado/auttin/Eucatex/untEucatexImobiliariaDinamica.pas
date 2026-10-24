
unit untEucatexImobiliariaDinamica;

interface

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants, ADODB, untIConfTinta;

Type
  {*********************************************}
  {* EVENTOS DISPARADOS AO LONGO DOS CADASTROS *}
  {******************************************PH*}
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;

  TEucatexImobiliariaDinamica = class(TComponent)
  private
    strPat : String;
    intOpcao: Integer;

    {********************************}
    {* CADASTROS DO SISTEMA         *}
    {*****************************PH*}
    qryCadBas : TUniQuery;
    qryCadCol : TUniQuery;
    qryCadEuc : TUniQuery;
    qryCadUni : TUniQuery;
    qryTmpCadEuc : TUniQuery;

    {******************************************************************}
    {* QUERYS QUE SAO CARREGADAS E FICAM NA MEMORIA                   *}
    {* PARA NAO FICAR CONSULTANDO O BANCO EM CADA REGISTRO DO ARQUIVO *}
    {***************************************************************PH*}
    qryCadBasMen: TUniClientDataSet;
    qryCadColMen: TUniClientDataSet;
    qryCadUniMen: TUniClientDataSet;

    {***********************************************************}
    {* ARQUIVO EXCEL QUE SERA INPORTADO,                       *}
    {* USE O ADO PARA PODER USAR O ARQUIVO COMO BANCO (SELECT) *}
    {********************************************************PH*}
//    qryAdoExcel: TADOQuery;

    FRegistraAcao     : TEventoStrAcao;
    FRegistraProgresso : TEventoProgresso;

    conf: IConfTinta;

    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadEuc: Boolean;

    {*******************************************}
    {* PROCESSA ARQUIVOS DBF                   *}
    {****************************************PH*}
    function fProcessaCadBasDbf: Boolean;
    function fProcessaCadColDbf: Boolean;
    function fProcessaCadEucDbf: Boolean;

    function fRetUnidade(strEmbalagem: String): String;
    function fRetFatorUnidade(strUnidade: String): Double;
    function fRetFatorUnidadeExcel(strUnidade: String): Double;

    function fVerificaCadBasVazio: Boolean;
    function fVerificaCadBasConfigurado: Boolean;
    function fVerificaCadColVazio: Boolean;
    function fVerificaCadColConfigurado: Boolean;
    function fFormataStringFloat(strValor: String): String;

    procedure pListaTodasAsTintasArquivo;
    procedure pCriaTmpCadEuc;
    procedure pDestroiTmpCadEuc;
    procedure pPreencheTmpCadEuc;
    procedure pHabilitaKeysTmpCadEuc;

  protected
    function fCarregaDataSet(dataSet: TUniQuery): TUniClientDataSet;
  public
    constructor Create(AOWner: TComponent; intOpcao: Integer); reintroduce; overload;
    constructor Create(AOWner: TComponent); overload; override;
    function fProcessaArquivos: Boolean;
    function fGravaCadNfms: Boolean;

    {*******************************************}
    {* FUNCAO PARA ACHAR O PROXIMO AUTOINCREM  *}
    {****************************************PH*}
    function fAjustaAutoIncrem(strTabela, strCodEmp: String; intInicio: Integer): Boolean;

    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  published
    property  RegistraAcao  : TEventoStrAcao  Read  FRegistraAcao Write FRegistraAcao;
    property  RegistraProgresso : TEventoProgresso  Read  FRegistraProgresso  Write FRegistraProgresso;
end;

  function fGravaCadNfm(qryCadNfm: TUniQuery): Boolean;
  function fGetProxCodSeq: Integer;
  function fRemoverFormula(strCodNfm: String): Boolean;
  function fRetFatorUnidade(strUnidade: String): Double;

implementation

uses untFuncoesSimples, untFuncTinta, SyncObjs, untFuncoes, StrUtils,
  untTintadeMaquina, untExcelOfc, untModulo;

{ TEucatexImobiliariaDinamica }

constructor TEucatexImobiliariaDinamica.Create(AOWner: TComponent;
  intOpcao: Integer);
begin
  conf     := fGetConfTinta('EUC');
  {******************************************}
  {* PATH PARA O ARQUIVO PARA SER IMPORTADO *}
  {***************************************PH*}
  strPat := conf.fGet('EUCPAT');

  {**********************************************************************}
  {* ABRE O ARQUIVO EXCEL COMO SE FOSSE UMA TABELA, PODENDO USAR SELECT *}
  {*******************************************************************PH*}
  {*************************************************************************}
  {* USE Extended Properties="Excel 8.0" PARA TRABALHAR COM ARQUIVOS EXCEL *}
  {**********************************************************************PH*}

  Self.intOpcao := intOpcao;

  qryCadBas := fCriarQuery('SELECT * FROM EUC_CADBAS', Self);
  qryCadCol := fCriarQuery('SELECT * FROM EUC_CADCOL', Self);
  qryCadEuc := fCriarQuery('SELECT * FROM EUC_CADEUC', Self);
  qryCadUni := fCriarQuery('SELECT * FROM CADUNI', Self);
end;

{****************************************************************************************}
{* CARREGA ALGUM DATASET NA MEMORIA, ISSO EVITA ACESSAR O BANCO DURANTE O PROCESSAMENTO *}
{*************************************************************************************PH*}
function TEucatexImobiliariaDinamica.fCarregaDataSet(
  dataSet: TUniQuery): TUniClientDataSet;
  Var
    intCont: Integer;
    intPos: Integer;
begin
  {**********************************}
  {* USA O OWNER DO PROPRIO DATASET *}
  {*******************************PH*}
  Result := TUniClientDataSet.Create(dataSet.Owner);

  {*********************************************}
  {* CLONA TODOS OS CAMPOS E SUAS PROPRIEDADES *}
  {******************************************PH*}
  For intCont := 0 To dataSet.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs.Add(dataSet.FieldDefs[intCont].Name, dataSet.FieldDefs[intCont].DataType,
                    dataSet.FieldDefs[intCont].Size, dataSet.FieldDefs[intCont].Required);
  End;

  {****************************************************************}
  {* METODO PARA CRIAR O DATASET NA MEMORIA ATRAVES DO FIELDDEFS, *}
  {* PODENDO TRABALHAR COM ELE                                    *}
  {*************************************************************PH*}
  Result.CreateDataSet;

  {**********************************}
  {* ABRE O DATASET CASO NAO ESTEJA *}
  {*******************************PH*}
  If (dataSet.Active = False) Then
    dataSet.Open;

  intPos := dataSet.RecNo;
  dataSet.First;

  {*******************************************************************************}
  {* PERCORRE TODOS OS REGISTROS DO DATASET ARMAZENANDO-OS NO DATASET NA MEMORIA *}
  {****************************************************************************PH*}
  While Not dataSet.Eof Do
  Begin

    Result.Insert;
    For intCont := 0 To dataSet.Fields.Count - 1 Do
    Begin
      Result.Fields.Fields[intCont].Value := dataSet.Fields.Fields[intCont].Value;
    End;
    Result.Post;

    dataSet.Next;
  End;

  {********************************}
  {* RESTAURA POSICAO DO DATASET  *}
  {*****************************PH*}
  dataSet.RecNo := intPos;
end;

function TEucatexImobiliariaDinamica.fProcessaArquivos: Boolean;
begin
  {********************************}
  {* VERIFICA SE O ARQUIVO EXISTE *}
  {*****************************PH*}
//  If Not FileExists(strPat) Then
  Result := False;

  If Not DirectoryExists(strPat) Then
  Begin
    fMensagem('ATENÇÃO', Format('O diretório %s não existe', [strPat]), ['OK']);
    Result := False;
    Exit;
  End;

  //If (fArqIniTinta(0, 'Eucatex Imobiliaria', 'USADBF', '') = 'S') Then
  If (conf.fGet('USADBF') = 'S') Then
  Begin
    strPat := ExtractFileDir(strPat);
  End;

  case intOpcao of
    1:
      Begin
        {******************}
        {* PROCESSA BASES *}
        {***************PH*}
//        If (fArqIniTinta(0, 'Eucatex Imobiliaria', 'USADBF', '') = 'S') Then
        If (conf.fGet('USADBF') = 'S') Then
        Begin
          Result := fProcessaCadBasDbf;
        End
        Else
          Result := fProcessaCadBas;

        If Not Result Then
          Exit;


        {**********************************************************}
        {* CASO TENHA PROCESSADO AS BASES, PROCESSA OS COLORANTES *}
        {*******************************************************PH*}
//        If (fArqIniTinta(0, 'Eucatex Imobiliaria', 'USADBF', '') = 'S') Then
        If (conf.fGet('USADBF') = 'S') Then
          Result := fProcessaCadColDbf
        Else
          Result := fProcessaCadCol;
      End;
    2:
      Begin
        {*********************************}
        {* PROCESSA AS TINTAS DO ARQUIVO *}
        {******************************PH*}
//        If (fArqIniTinta(0, 'Eucatex Imobiliaria', 'USADBF', '') = 'S') Then
        If (conf.fGet('USADBF') = 'S') Then
          Result := fProcessaCadEucDbf
        Else
          Result := fProcessaCadEuc;
      End;
  End;
end;

function TEucatexImobiliariaDinamica.fProcessaCadBas: Boolean;
  Var
    intCont: Integer;
    intLinhas : Integer;
    Excel     : TExcelOfc;
    intMaxLin,
    intAtual  : Integer;
    strBase,
    strProduto,
    strCodCor: String;
    search_rec : TSearchRec;
begin
  {**************************************}
  {* OBTEM OS REGISTROS ATUAIS DO BANCO *}
  {***********************************PH*}
  qryCadBas.Close;
  qryCadBas.Open;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Abrindo cadastro de bases...');

  Application.ProcessMessages;

  {***************************************}
  {* OBTEM AS BASES QUE ESTAO NO ARQUIVO *}
  {************************************PH*}

  strBase    := '';
  strProduto := '';
  strCodCor  := '';

  Result := True;

  If FindFirst(strPat + '\*.xls', faAnyFile, search_rec) = 0 Then
  Begin

    repeat

      strBase    := '';
      strProduto := '';
      strCodCor  := '';
      intAtual   := 1;
      intMaxLin  := 0;

      Try
        Excel      := TExcelOfc.Create(Self);
        try
          Excel.AbrirArquivo(strPat + '\' + search_rec.Name);
          intMaxLin := Excel.MaximodeLinhas;
        Except
          On E: Exception Do
          Begin
            fMensagem('Erro','Erro ao criar excel Processa CadBas',['OK']);
          End;
        End;

        If (Assigned(RegistraProgresso)) Then
          RegistraProgresso(0, intAtual, intMaxLin);
        Application.ProcessMessages;

      {//ac  qryAdoExcel.Open;}

        If (Assigned(FRegistraAcao)) Then
          FRegistraAcao('Processando cadastro de bases... Planilha: ' + search_rec.Name);

        Application.ProcessMessages;

        {//ac  While Not qryAdoExcel.Eof Do}
        For intLinhas := 2 To intMaxLin Do
        Begin

          strCodCor  := Excel.Ler_Celula('A' + IntToStr(intLinhas));
          strProduto := Excel.Ler_Celula('J' + IntToStr(intLinhas));
          strBase    := Excel.Ler_Celula('F' + IntToStr(intLinhas));

          {*************************************************}
          {* SO CADASTRAR SE NAO ENCONTRAR A BASE NO BANCO *}
          {**********************************************PH*}
          If (Not (qryCadBas.Locate('BAS_DESCRI;BAS_PRODUT', VarArrayOf([AnsiUpperCase(strBase), AnsiUpperCase(strProduto)]), []))) And
             (Not fEmptyStr(strBase)) And
             (strCodCor <> 'Key1') Then
          Begin
            For intCont := 1 To 3 Do
            Begin
              qryCadBas.Insert;
              qryCadBas.FieldByName('BAS_DESCRI').AsString := AnsiUpperCase(strBase); {//ac AnsiUpperCase(qryAdoExcel.FieldByName('BASE').AsString);}
              qryCadBas.FieldByName('BAS_PRODUT').AsString := AnsiUpperCase(strProduto); {//ac AnsiUpperCase(Trim(qryAdoExcel.FieldByName('PRODUTO').AsString));}

              If intCont = 1 Then
                qryCadBas.FieldByName('BAS_CODUNI').AsString := AnsiUpperCase(fRetUnidade('Galao'))
              Else If intCont = 2 Then
                qryCadBas.FieldByName('BAS_CODUNI').AsString := AnsiUpperCase(fRetUnidade('Quarto'))
              Else
                qryCadBas.FieldByName('BAS_CODUNI').AsString := AnsiUpperCase(fRetUnidade('Lata'));

              qryCadBas.FieldByName('BAS_CODEMP').AsString := AnsiUpperCase(VS_strCodEmp);
              qryCadBas.FieldByName('AUTOINCREM').AsString := AnsiUpperCase(fRetAutoIncrem('EUC_CADBAS', VS_strCodEmp));
              qryCadBas.Post;
            End;

            qryCadBas.Close;
            qryCadBas.Open;
          End;

          intAtual := intAtual + 1;
          If (Assigned(RegistraProgresso)) Then
            RegistraProgresso(1, intAtual, intMaxLin);
          Application.ProcessMessages;
        End;
      Finally
        Excel.FecharArquivo;
        FreeAndNil(Excel);
      End;

    until FindNext(search_rec) <> 0;

    FindClose(search_rec);
  End
  Else
    Result := False;

  If (Assigned(FRegistraAcao)) Then
  Begin
    If Result Then
      FRegistraAcao('Cadastro de bases processado com sucesso!')
    Else
      FRegistraAcao('Não foi possível gerar o cadastro de bases!');
  End;

  Application.ProcessMessages;

  qryCadBas.Close;
end;

function TEucatexImobiliariaDinamica.fProcessaCadCol: Boolean;
  Var
    intLinhas: Integer;
    strCodCor: String;
    Excel: TExcelOfc;
    intMaxLin,
    intAtual,
    intCol: Integer;
    arrCol: Array Of String;
    search_rec: TSearchRec;
begin
  {**************************************}
  {* OBTEM OS REGISTROS ATUAIS DO BANCO *}
  {***********************************PH*}

    qryCadCol.Close;
    qryCadCol.Open;

    If (Assigned(FRegistraAcao)) Then
      FRegistraAcao('Abrindo cadastro de colorantes...');

    Application.ProcessMessages;

    Result := True;

    If FindFirst(strPat + '\*.xls', faAnyFile, search_rec) = 0 Then
    Begin
      repeat
        strCodCor  := '';
        intAtual   := 1;
        intMaxLin  := 0;

        Try
          Excel := TExcelOfc.Create(Self);

          try
            Excel.AbrirArquivo(strPat + '\' + search_rec.Name);
            intMaxLin := Excel.MaximodeLinhas;
          Except
            On E: Exception Do
            Begin
              fMensagem('Erro','Erro ao criar excel Processa CadCol',['OK']);
            End;
          End;

          If (Assigned(RegistraProgresso)) Then
            RegistraProgresso(0, intAtual, intMaxLin);
          Application.ProcessMessages;

          {*********************************************************************}
          {* SELECIONA SOMENTE OS COLORANTES UNICOS NAS 5 COLUNAS DAS FORMUALS *}
          {******************************************************************PH*}

          If (Assigned(FRegistraAcao)) Then
            FRegistraAcao('Processando cadastro de colorantes... Planilha: ' + search_rec.Name);

          Application.ProcessMessages;

          For intLinhas := 2 To intMaxLin Do
          Begin

            SetLength(arrCol,5);

            arrCol[0] := Excel.Ler_Celula('S' + IntToStr(intLinhas));
            arrCol[1] := Excel.Ler_Celula('U' + IntToStr(intLinhas));
            arrCol[2] := Excel.Ler_Celula('W' + IntToStr(intLinhas));
            arrCol[3] := Excel.Ler_Celula('Y' + IntToStr(intLinhas));
            arrCol[4] := Excel.Ler_Celula('AA' + IntToStr(intLinhas));

            strCodCor := Excel.Ler_Celula('A' + IntToStr(intLinhas));

            For intCol := 1 To 5 Do
            Begin
              {//ac If Not (qryCadCol.Locate('COL_CODCOL', qryAdoExcel.FieldByName('COLORANTE 1').AsString, [])) Then}
              If (Not (qryCadCol.Locate('COL_CODCOL', AnsiUpperCase(arrCol[intCol - 1]), []))) And
                 (Not fEmptyStr(arrCol[intCol - 1])) And
                 (strCodCor <> 'Key1') Then
              Begin
                qryCadCol.Insert;
                qryCadCol.FieldByName('COL_CODCOL').AsString := AnsiUpperCase(arrCol[intCol - 1]); {//ac AnsiUpperCase(qryAdoExcel.FieldByName('COLORANTE 1').AsString);}
                qryCadCol.FieldByName('COL_CODEMP').AsString := AnsiUpperCase(VS_strCodEmp);
                qryCadCol.FieldByName('AUTOINCREM').AsString := AnsiUpperCase(fRetAutoIncrem('EUC_CADCOL', VS_strCodEmp));
                qryCadCol.Post;

                qryCadCol.Close;
                qryCadCol.Open;
              End;
            End;

            intAtual := intAtual + 1;
            If (Assigned(RegistraProgresso)) Then
              RegistraProgresso(1, intAtual , intMaxLin);

            Application.ProcessMessages;
          End;

        Finally
          Excel.FecharArquivo;
          FreeAndNil(Excel);
        end;

        until FindNext(search_rec) <> 0;

        FindClose(search_rec);

    End
    Else
      Result := False;

    If (Assigned(FRegistraAcao)) Then
      FRegistraAcao('Cadastro de colorantes processados com sucesso!');

    Application.ProcessMessages;
    qryCadCol.Close;
end;

function TEucatexImobiliariaDinamica.fProcessaCadEuc: Boolean;
  Var
    qryGen : TUniQuery;
    intCont: Integer;
    intCodSeq: Integer;

    fltPesAtu : Double;
    fltPesNov : Double;
    fltQtdNov : Double;
    strEmbNov : String;
begin
  Result := False;
  {*********************************************}
  {* VERIFICAR SE CADASTRO DE BASES ESTA VAZIO *}
  {******************************************PH*}
  If (fVerificaCadBasVazio) Then
  Begin
    Result := False;
    fMensagem('', 'O cadastro de bases está vazio!', ['OK']);
    Exit;
  End;

  {***********************************************************}
  {* VERIFICAR SE EXISTE ALGUMA BASE CADASTRADA              *}
  {* SO CONTINUAR SE EXISTIR PELO MENOS UMA BASE CONFIGURADA *}
  {********************************************************PH*}
  If Not (fVerificaCadBasConfigurado) Then
  Begin
    Result := False;
    fMensagem('', 'O cadastro de bases não está configurado', ['OK']);
    Exit;
  End;

  {**************************************************}
  {* VERIFICAR SE CADASTRO DE COLORANTES ESTA VAZIO *}
  {***********************************************PH*}

  If (fVerificaCadColVazio) Then
  Begin
    Result := False;
    fMensagem('', 'O cadasttro de colorantes está vazio', ['ok']);
    Exit;
  End;

  {***************************************************************}
  {* SO CONTINUAR SE PELO MENOS UM COLORANTE ESTIVER CONFIGURADO *}
  {************************************************************PH*}
  If Not (fVerificaCadColConfigurado) Then
  Begin
    Result := False;
    fMensagem('', 'O cadastro de colorantes não está configurado!', ['OK']);
    Exit;
  End;

  {*****************************************************************}
  {* ATUALIZA QUERYS PARA PEGAR OS DADOS MAIS RECENTES DO SERVIDOR *}
  {**************************************************************PH*}
  qryCadBas.Close;
  qryCadBas.Open;
  qryCadBasMen := fCarregaDataSet(qryCadBas);


  qryCadCol.Close;
  qryCadCol.Open;
  qryCadColMen := fCarregaDataSet(qryCadCol);

  qryCadUni.Close;
  qryCadUni.Open;
  qryCadUniMen := fCarregaDataSet(qryCadUni);

  qryCadEuc.Close;
  qryCadEuc.Open;

  {************************************}
  {* LISTA TODAS AS TINTAS DO ARQUIVO *}
  {*********************************PH*}
  Try
    RegistraAcao('Carregando arquivo cadastro de tintas...');
    pListaTodasAsTintasArquivo;

    if qryTmpCadEuc.IsEmpty then
      Exit;

    {****************************************************}
    {* REMOVE TODAS AS TINTAS JA CADASTRADAS NO SISTEMA *}
    {*************************************************PH*}
    qryGen := fCriaQuery(Self);
    qryGen.SQL.Text := 'TRUNCATE TABLE EUC_CADEUC';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);


    intCodSeq := 1;

    If (Assigned(RegistraAcao)) Then
      RegistraAcao('Processando cadastro de tintas...');
    Application.ProcessMessages;

    {*********************************}
    {* PERCORRE O ARQUIVO DAS TINTAS *}
    {******************************PH*}
{//ac    While Not qryAdoExcel.Eof Do}
    While Not qryTmpCadEuc.Eof Do
    Begin

      {***********************************************************}
      {* ATIVA O FILTRO NA QUERY DE BASES PARA MOSTRAR SOMENTE A *}
      {* BASE DA TINTA DO REGISTRO ATUAL                         *}
      {********************************************************PH*}
      qryCadBasMen.Filtered := False;
      qryCadBasMen.Filter := Format('BAS_DESCRI = %s AND BAS_PRODUT = %s AND BAS_CODITE <> %s',
                              [QuotedStr(AnsiUpperCase(qryTmpCadEuc.FieldByName('BASE').AsString)),
                              QuotedStr(Trim(AnsiUpperCase(qryTmpCadEuc.FieldByName('PRODUTO').AsString))),
                              QuotedStr('')]);

      qryCadBasMen.Filtered := True;
      qryCadBasMen.First;

      {********************************}
      {* PERCORRE O CADASTRO DE BASES *}
      {*****************************PH*}
      While Not qryCadBasMen.Eof Do
      Begin
        qryCadEuc.Insert;

      {*******************************************************}
      {* O ARQUIVO CONTEM NO MAXIMO 5 COLORANTES POR FORMULA *}
      {****************************************************PH*}
        For intCont := 1 To 5 Do
        Begin

          {*****************************************}
          {* SE NAO TIVER COLORANTE JA SAI DO LOOP *}
          {**************************************PH*}
          If (fEmptyStr(qryTmpCadEuc.FieldByName('COLORANTE_' + IntToStr(intCont)).AsString)) Then
          Begin
            Break;
          End;

          {***************************************************************}
          {* SE NAO ACHAR O COLORANTE NO SISTEMA,                        *}
          {* CANCELA O CADASTRO DA TINTA E PASSA PARA O PROXIMO REGISTRO *}
          {************************************************************PH*}

          If Not (qryCadColMen.Locate('COL_CODCOL',
                  qryTmpCadEuc.FieldByName('COLORANTE_' + IntToStr(intCont)).AsString, [])) Then
          Begin
            qryCadEuc.Cancel;
            Break;
          End;

          {***********************************************************************}
          {* SE O COLORANTES NAO ESTIVER CONFIGURADO CANCELA O CADASTRO DA TINTA *}
          {********************************************************************PH*}
          If (fEmptyStr(qryCadColMen.FieldByName('COL_CODITE').AsString)) Then
          Begin
            qryCadEuc.Cancel;
            Break;
          End;

          qryCadEuc.FieldByName('EUC_FORM' + fStrZero(intCont, 2)).AsString :=
                                  qryTmpCadEuc.FieldByName('COLORANTE_' + IntToStr(intCont)).AsString;

          {**************************************************}
          {* LOCALIZANDO PESO DA EMBALAGEM NA FORMULA ATUAL *}
          {***********************************************PH*}
          fltPesAtu := fRetFatorUnidadeExcel(qryTmpCadEuc.FieldByName('UNIDADE').AsString);
          {*********************************************}
          {* VERIFICA SE O PESO DA UNIDADE ESTA ZERADO *}
          {******************************************PH*}
          If (fltPesAtu = 0.0) Then
          Begin
            fMensagem('ATENÇÃO', Format('A unidade %s não está configurada', [qryCadUniMen.FieldByName('UNI_CODUNI').AsString]), ['OK']);
            Result := False;
            qryCadEuc.Cancel;
            Exit;
          End;



          {**********************************************************}
          {* LOCALIZANDO PESO DA EMBALAGEM DESEJADA (NOVA EMBALAGEM)*}
          {*******************************************************PH*}

          fltPesNov := fRetFatorUnidade(qryCadBasMen.FieldByName('BAS_CODUNI').AsString);

          {*********************************************}
          {* VERIFICA SE O PESO DA UNIDADE ESTA ZERADO *}
          {******************************************PH*}
          If (fltPesNov = 0.0) Then
          Begin
            fMensagem('ATENÇÃO', Format('A unidade %s não está configurada corretamente', [qryCadUniMen.FieldByName('UNI_CODUNI').AsString]), ['OK']);
            Result := False;
            qryCadEuc.Cancel;
            Exit;
          End;

          strEmbNov := qryCadBasMen.FieldByName('BAS_CODUNI').AsString;

          {************************************************************************************}
          {* NOVA QUANTIDADE = QUANTIDADE ATUAL * PESO NOVA EMBALAGEM / PESO EMBALAGEM ANTIGA *}
          {*********************************************************************************PH*}
          fltQtdNov := (qryTmpCadEuc.FieldByName('QUANTCOL_' + IntToStr(intCont)).AsFloat * fltPesNov / fltPesAtu);
          qryCadEuc.FieldByName('EUC_QTDB' + fStrZero(intCont, 2)).AsFloat := fltQtdNov;
        End;

        {*****************************************************************************}
        {* SO COINTINUAR SE TODOS OS COLORANTES ESTIVEREM CADASTRADOS E CONFIGURADOS *}
        {**************************************************************************PH*}
        If (qryCadEuc.State = dsInsert) Then
        Begin
          qryCadEuc.FieldByName('EUC_CODSEQ').AsString := AnsiUpperCase(fStrZero(intCodSeq, 6));
          qryCadEuc.FieldByName('AUTOINCREM').AsString := AnsiUpperCase(fFormataAutInc(intCodSeq, VS_strCodEmp));
          qryCadEuc.FieldByName('EUC_CODEMP').AsString := AnsiUpperCase(VS_strCodEmp);
          qryCadEuc.FieldByName('EUC_CODCOR').AsString := AnsiUpperCase(qryTmpCadEuc.FieldByName('CODIGO_COR').AsString);
          qryCadEuc.FieldByName('EUC_DESCOR').AsString := AnsiUpperCase(qryTmpCadEuc.FieldByName('NOME_COR').AsString);
          qryCadEuc.FieldByName('EUC_PRODUT').AsString := AnsiUpperCase(qryTmpCadEuc.FieldByName('PRODUTO').AsString);
          qryCadEuc.FieldByName('EUC_DESBAS').AsString := AnsiUpperCase(qryTmpCadEuc.FieldByName('BASE').AsString);

          qryCadEuc.FieldByName('EUC_UNIDAD').AsString := AnsiUpperCase(strEmbNov);

          {**************************************************************}
          {* ESTA IMPORTANDO DO ARQUIVO, NAO TEM CODIGO DE NOVA FORMULA *}
          {***********************************************************PH*}
          qryCadEuc.FieldByName('EUC_CODNFM').AsString := '';

          {*********************************************************}
          {* CADASTRA A TINTA E VAI PARA A PROXIMA UNIDADE DA BASE *}
          {******************************************************PH*}
          qryCadEuc.Post;
          intCodSeq := intCodSeq + 1;
        End;

        qryCadBasMen.Next;
      End;

      {************************************************************}
      {* ACABOU DE PERCORRER TODAS AS UNIDADES DA BASE,           *}
      {* VAI PARA O PROXIMO REGISTRO DO ARQUIVO                   *}
      {*********************************************************PH*}
      If (Assigned(RegistraProgresso)) Then
{//ac        RegistraProgresso(1, qryAdoExcel.RecNo, qryAdoExcel.RecordCount);}
        RegistraProgresso(1, qryTmpCadEuc.RecNo, qryTmpCadEuc.RecordCount);

      Application.ProcessMessages;
{//ac
      qryAdoExcel.Next;
}
      qryTmpCadEuc.Next;
    End;

    fGravaAutoIncrem('EUC_CADEUC', intCodSeq);

    {********************************}
    {* CADASTRO DE NOVAS FORMULAS   *}
    {*****************************PH*}

    If Not (fGravaCadNfms) Then
    Begin
      If (Assigned(RegistraAcao)) Then
        RegistraAcao('Não foi possivel cadastrar novas formulas');
    End;

    {**************************************************}
    {* ACABOU DE PROCESSAR TODO O ARQUIVO COM SUCESSO *}
    {***********************************************PH*}
    Result := True;
    If (Assigned(RegistraAcao)) Then
      RegistraAcao('Cadastro de tintas processado com sucesso!');

    Application.ProcessMessages;
  Finally
    pDestroiTmpCadEuc;
  End;
end;

function TEucatexImobiliariaDinamica.fRetUnidade(
  strEmbalagem: String): String;
begin
  {*********************************}
  {* RETORNA A UNIDADE CONFIGURADA *}
  {******************************PH*}
  If (strEmbalagem = 'Galao') Then
    Result := conf.fGet('EUCGAL') //fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCGAL', '')
  Else If (strEmbalagem = 'Quarto') Then
    Result := conf.fGet('EUCQUA') //fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCQUA', '')
  Else If (strEmbalagem = 'Lata') Then
    Result := conf.fGet('EUCLAT') //fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCLAT', '')
end;

function TEucatexImobiliariaDinamica.fVerificaCadBasVazio: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS CONT FROM EUC_CADBAS', nil);
  qryGen.Open;

  Result := (qryGen.FieldByName('CONT').AsInteger = 0);
end;

function TEucatexImobiliariaDinamica.fVerificaCadBasConfigurado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(BAS_CODITE) AS CONT FROM EUC_CADBAS', nil);
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;
end;

function TEucatexImobiliariaDinamica.fVerificaCadColVazio: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS CONT FROM EUC_CADCOL', nil);
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger = 0;
end;

function TEucatexImobiliariaDinamica.fVerificaCadColConfigurado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(COL_CODITE) AS CONT FROM EUC_CADCOL', nil);
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;
end;

function fGravaCadNfm(qryCadNfm: TUniQuery): Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
    qryCadBas: TUniQuery;
begin
  qryGen := fCriaQuery(qryCadNfm.Owner);
  qryGen.SQL.Text := 'DELETE FROM EUC_CADEUC WHERE EUC_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
  qryGen.ExecSQL;


  qryGen.SQL.Text := 'SELECT * FROM EUC_CADEUC WHERE FALSE';
  qryGEN.Open;

  qryCadBas := fCriaQuery();
  qryCadBas.SQL.Text := 'SELECT * FROM EUC_CADBAS WHERE BAS_DESCRI = :DESCRI AND BAS_PRODUT = :PRODUT';
  qryCadBas.ParamByName('DESCRI').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_DESBAS').AsString);
  qryCadBas.ParamByName('PRODUT').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_PRODUT').AsString);
  qryCadBas.Open;

  While Not qryCadBas.Eof Do
  Begin
    qryGen.Insert;

    qryGen.FieldByName('EUC_CODSEQ').AsInteger := fGetProxCodSeq;
    qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADEUC', VS_strCodEmp);
    qryGen.FieldByName('EUC_CODEMP').AsString := VS_strCodEmp;
    qryGen.FieldByName('EUC_DESCOR').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_DESCOR').AsString);
    qryGen.FieldByName('EUC_PRODUT').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_PRODUT').AsString);
    qryGen.FieldByName('EUC_DESBAS').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_DESBAS').AsString);
    qryGen.FieldByName('EUC_UNIDAD').AsString := AnsiUpperCase(qryCadBas.FieldByName('BAS_CODUNI').AsString);
    qryGen.FieldByName('EUC_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

    For intCont := 1 To 6 Do
    Begin
      If (fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString)) Then
        Break;

      qryGen.FieldByName('EUC_FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryGen.FieldByName('EUC_QTDB' + fStrZero(intCont, 2)).AsFloat :=
        qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat * fRetFatorUnidade(qryCadBas.FieldByName('BAS_CODUNI').AsString) / 0.9;
    End;

    qryGen.FieldByName('EUC_CODNFM').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
    qryGen.FieldByName('EUC_CODCOR').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
    qryGen.Post;
    qryCadBas.Next;
  End;

  FreeAndNil(qryGen);

  Result := True;
end;

function fGetProxCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT IFNULL(MAX(EUC_CODSEQ) + 1,1) AS "PROX" FROM EUC_CADEUC');
  qryGen.Open;
  Result := qryGen.FieldByName('PROX').AsInteger;
  FreeAndNil(qryGen);
end;


function TEucatexImobiliariaDinamica.fGravaCadNfms: Boolean;
  Var
    qryCadNfm: TUniQuery;
begin

  If (Assigned(RegistraAcao)) Then
    RegistraAcao('Cadastrando novas formulas...');

  TTintadeMaquina.fAjustaInicialAutoIncremento('EUC_CADEUC', VS_strCodEmp);

  qryCadNfm := fCriarQuery('SELECT * FROM EUC_CADNFM', Self);
  qryCadNfm.Open;

  While Not qryCadNfm.Eof Do
  Begin
    If (fGravaCadNfm(qryCadNfm)) Then
    Begin
      If (Assigned(RegistraProgresso)) Then
        RegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

      Application.ProcessMessages;
      qryCadNfm.Next
    End
    Else
    Begin
      Break;
    End;
  End;

  If (Assigned(RegistraAcao)) Then
    RegistraAcao('Novas formulas cadastradas com sucesso!');

  Result := True;
end;

function fRemoverFormula(strCodNfm: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'DELETE FROM EUC_CADEUC WHERE EUC_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
  Result := True;
end;

constructor TEucatexImobiliariaDinamica.Create(AOWner: TComponent);
begin
  inherited;
end;

function TEucatexImobiliariaDinamica.fRetFatorUnidade(
  strUnidade: String): Double;
begin
//
  Result := 0;
  If (strUnidade = conf.fGet('EUCGAL')) Then
    Result := 3.6
  Else If (strUnidade = conf.fGet('EUCQUA')) Then //If (strUnidade = fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCQUA', '')) Then
    Result := 0.9
  Else If (strUnidade = conf.fGet('EUCLAT')) Then //If (strUnidade = fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCLAT', ''))
    Result := 18;
end;

function TEucatexImobiliariaDinamica.fRetFatorUnidadeExcel(
  strUnidade: String): Double;
begin
  If strUnidade = 'Galao' Then
    Result := 3.6
  Else If strUnidade = 'Quarto' Then
    Result := 0.9
  Else If strUnidade = 'Lata' Then
    Result := 18
  Else
    Result := 1;
end;

function TEucatexImobiliariaDinamica.fProcessaCadBasDbf: Boolean;
  Var
    qryPaths: TUniQuery;
    qryBas: TUniQuery;
    arrUnidades: Array[1..3] of String;
    intCont: Integer;

    qryZBas: TUniQuery;
begin
  Result := false;

  Try
    qryPaths := fCriaQuery(Self, frmModulo.DataDBF);
    qryPaths.SQL.Text := 'SELECT PATH FROM ' + strPat + '\PRODUCTS.DBF';
    qryPaths.Open;
  Except
    fMensagem('ATENÇÃO', 'Não foram encontrados arquivos "*.DBF" no path para geração da tinta.' , ['OK']);
    Exit;
  End;


  qryPaths.First;

  arrUnidades[1] := conf.fGet('EUCQUA'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCQUA', '');
  arrUnidades[2] := conf.fGet('EUCGAL'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCGAL', '');
  arrUnidades[3] := conf.fGet('EUCLAT'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCLAT', '');

  qryBas := fCriaQuery(Self, frmModulo.DataDBF);

  qryZBas := fCriaQuery(Self);
  qryZBas.SQL.Text := 'SELECT * FROM EUC_CADBAS';
  qryZBas.Open;

  pRegistraAcao('Cadastrando bases...');
  While Not qryPaths.Eof Do
  Begin
    qryBas.Close;
    qryBas.SQL.Text := 'SELECT DISTINCT BASES.DESCR BASE, SUBPRODS.DESCR PRODUTO FROM ' + strPat + '\BASES.DBF, ' +
      qryPaths.FieldByName('PATH').AsString + '\SUBPRODS';
    qryBas.Open;

    While Not qryBas.Eof Do
    Begin

      For intCont := 1 To 3 Do
      Begin

        If Not qryZBas.Locate('BAS_DESCRI;BAS_PRODUT;BAS_CODUNI',
          VarArrayOf([UpperCase(Trim(qryBas.FieldByName('BASE').AsString)),
          UpperCase(Trim(qryBas.FieldByName('PRODUTO').AsString)), arrUnidades[intCont]]), []) Then
        Begin
          qryZBas.Insert;

          qryZBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
          qryZBas.FieldByName('BAS_DESCRI').AsString := UpperCase(Trim(qryBas.FieldByName('BASE').AsString));
          qryZBas.FieldByName('BAS_PRODUT').AsString := UpperCase(Trim(qryBas.FieldByName('PRODUTO').AsString));
          qryZBas.FieldByName('BAS_CODUNI').AsString := arrUnidades[intCont];
          qryZBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADBAS', VS_strCodEmp);

          qryZBas.Post;
        End;

      End;

      qryBas.Next;
      pRegistraProgresso(0, qryBas.RecNo, qryBas.RecordCount);
    End;
    qryPaths.Next;
  End;
  pRegistraAcao('Bases cadastradas com sucesso!');

  FreeAndNil(qryBas);
  FreeAndNil(qryPaths);
  FreeAndNil(qryZBas);
  Result := True;
end;

procedure TEucatexImobiliariaDinamica.pRegistraAcao(strAcao: String);
begin
  If Assigned(FRegistraAcao) Then FRegistraAcao(strAcao);
end;

procedure TEucatexImobiliariaDinamica.pRegistraProgresso(intInicio,
  intAtual, intFinal: Integer);
begin
  If Assigned(FRegistraProgresso) Then FRegistraProgresso(intInicio, intAtual, intFinal);
end;

function TEucatexImobiliariaDinamica.fProcessaCadColDbf: Boolean;
  Var
    qryColDbf: TUniQuery;
    qryCol: TUniQuery;
begin
  Result := false;
  Try
    qryColDbf := fCriaQuery(Self, frmModulo.DataDBF);
    qryColDbf.SQL.Text := 'SELECT DISTINCT ID, CODE FROM ' + strPat + '\CNTS.DBF';
    qryColDbf.Open;
  Except
    fMensagem('ATENÇÃO', 'Não foram encontrados arquivos "*.DBF" no path para geração da tinta.' , ['OK']);
    Exit;
  End;


  qryColDbf.First;

  qryCol := fCriaQuery(Self);
  qryCol.SQL.Text := 'SELECT * FROM EUC_CADCOL';
  qryCol.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('EUC_CADCOL', VS_strCodEmp);

  pRegistraAcao('Cadastrando colorantes...');
  While Not qryColDbf.Eof Do
  Begin
    qryCol.Insert;
    qryCol.FieldByName('COL_CODCOL').AsString := UpperCase(Trim(qryColDbf.FieldByName('CODE').AsString));
    qryCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
    qryCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADCOL', VS_strCodEmp);
    qryCol.Post;

    qryColDbf.Next;
    pRegistraProgresso(0, qryColDbf.RecNo, qryColDbf.RecordCount);
  End;

  FreeAndNil(qryCol);
  FreeAndNil(qryColDbf);
  Result := True;
end;

function TEucatexImobiliariaDinamica.fAjustaAutoIncrem(strTabela,
  strCodEmp: String; intInicio: Integer): Boolean;
begin
  Result := True;
end;

function TEucatexImobiliariaDinamica.fProcessaCadEucDbf: Boolean;
  Var
    qryColDbf: TUniQuery;
    qryEmbDbf: TUniQuery;
    qryPaths: TUniQuery;
    qrySubProds: TUniQuery;
    qryFrm: TUniQuery;
    qryBasesDbf: TUniQuery;

    qryEuc: TUniQuery;
    intCodSeq: Integer;
    intCont: Integer;

    arrUnidades: Array[1..3] of String;

    strFormula : String;
    intCol: Integer;
    strCol: String;
    fltQtd: Double;

    fltEmbOri: Double;
    fltEmbDes: Double;
begin
  Result := false;

  arrUnidades[1] := conf.fGet('EUCQUA'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCQUA', ''); { QUARTO }
  arrUnidades[2] := conf.fGet('EUCGAL'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCGAL', ''); { GALAO }
  arrUnidades[3] := conf.fGet('EUCLAT'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCLAT', ''); { LATA }

  Try
    qryColDbf := fCriaQuery(Self, frmModulo.DataDBF);
    qryColDbf.SQL.Text := 'SELECT DISTINCT ID, DESCR FROM ' + strPat + '\CNTS.DBF';
    qryColDbf.Open;

    qryEmbDbf := fCriaQuery(Self, frmModulo.DataDBF);
    qryEmbDbf.SQL.Text := 'SELECT ID, DESCR, NOM_Q QTD FROM ' + strPat + '\CANS.DBF';
    qryEmbDbf.Open;

    qryPaths := fCriaQuery(Self, frmModulo.DataDBF);
    qryPaths.SQL.Text := 'SELECT ID, PATH FROM ' + strPat + '\PRODUCTS.DBF';
    qryPaths.Open;
    qryPaths.First;

    qrySubProds := fCriaQuery(Self, frmModulo.DataDBF);
    qryFrm := fCriaQuery(Self, frmModulo.DataDBF);

    qryBasesDbf := fCriaQuery(Self, frmModulo.DataDBF);
    qryBasesDbf.SQL.Text := 'SELECT * FROM ' + strPat + 'BASES.DBF';
    qryBasesDbf.Open;
  Except
    fMensagem('ATENÇÃO', 'Não foram encontrados arquivos "*.DBF" no path para geração da tinta.' , ['OK']);
    Exit;
  End;


  qryEuc := fCriaQuery(Self);
  qryEuc.SQL.Text := 'TRUNCATE TABLE EUC_CADEUC';
  qryEuc.ExecSQL;

  qryEuc.SQL.Text := 'SELECT * FROM EUC_CADEUC';
  qryEuc.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('EUC_CADEUC', VS_strCodEmp);

  pRegistraAcao('Cadastrando tintas...');
  intCodSeq := 1;
  While Not qryPaths.Eof Do
  Begin
    qrySubProds.Close;
    qrySubProds.SQL.Text := 'SELECT ID, DESCR, PATH FROM ' +
      qryPaths.FieldByName('PATH').AsString + '\SUBPRODS ORDER BY ID';
    qrySubProds.Open;

    While Not qrySubProds.Eof Do
    Begin

      If FileExists(strPat + '\' +
        qryPaths.FieldByName('PATH').AsString + '\' +
        qrySubProds.FieldByName('PATH').AsString + '\' +
        'FRM.DBF') Then
      Begin
        qryFrm.SQL.Text := 'SELECT * FROM ' + qryPaths.FieldByName('PATH').AsString + '\' +
        qrySubProds.FieldByName('PATH').AsString + '\FRM';
      End
      Else
      Begin
        qryFrm.SQL.Text := 'SELECT * FROM ' + qryPaths.FieldByName('PATH').AsString + '\FRM';
      End;
      qryFrm.Open;
      qryFrm.First;

      pRegistraAcao('Cadastrando ' + UpperCase(Trim(qrySubProds.FieldByName('DESCR').AsString)) + '...');

      While Not qryFrm.Eof Do
      Begin
        {**********************************************************************}
        {* PROCURA NO CADASTRO DE BASES DBF A BASES DESSE PRODUTO\SUBPRODUTO, *}
        {* CASO NAO ENCONTRE PROCURA UMA BASES "GENERICA"                     *}
        {*******************************************************************PH*}
        If Not qryBasesDbf.Locate('ID;PROD_KEY;SUBP_KEY', VarArrayOf([qryFrm.FieldByName('BASE_ID').AsString,
          qryPaths.FieldByName('ID').AsString, qrySubProds.FieldByName('ID').AsString]), []) Then
        Begin
          qryBasesDbf.Locate('ID;PROD_KEY;SUBP_KEY', VarArrayOf([qryFrm.FieldByName('BASE_ID').AsString,
            '    0','    0']), []); {* BASE GENERICA PARA TODOS OS PRODUTOS *}
        End;

        For intCont := 1 To 3 Do
        Begin
          qryEuc.Insert;
          qryEuc.FieldByName('EUC_CODSEQ').AsString := fStrZero(intCodSeq, 6);
          qryEuc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADEUC', VS_strCodEmp);
          qryEuc.FieldByName('EUC_CODEMP').AsString := VS_strCodEmp;
          qryEuc.FieldByName('EUC_CODCOR').AsString := UpperCase(Trim(qryFrm.FieldByName('KEY1').AsString));
          qryEuc.FieldByName('EUC_DESCOR').AsString := UpperCase(Trim(qryFrm.FieldByName('KEY2').AsString));
          qryEuc.FieldByName('EUC_PRODUT').AsString := UpperCase(Trim(qrySubProds.FieldByName('DESCR').AsString));
          qryEuc.FieldByName('EUC_DESBAS').AsString := UpperCase(Trim(qryBasesDbf.FieldByName('DESCR').AsString));
          qryEuc.FieldByName('EUC_UNIDAD').AsString := arrUnidades[intCont];

          {********************************************************************}
          {* REALIZA O CALCULO DA QUANTIDADE DE COLORANTE PARA CADA EMBALAGEM *}
          {*****************************************************************PH*}
          strFormula := qryFrm.FieldByName('FORMULA').AsString + ',';
          intCol := 1;
          While Not fEmptyStr(strFormula) Do
          Begin
            {*****************************************************************************************}
            {* OBTEM O CODIGO DO COLORANTE NO DBF, E PROCURA A DESCRICAO NA TABELA DE COLORANTES DBF *}
            {**************************************************************************************PH*}
            strCol := fPadL(Copy(strFormula, 1, Pos(',', strFormula) - 1), 5);
            qryColDbf.Locate('ID', strCol, []);
            qryEuc.FieldByName('EUC_FORM' + fStrZero(intCol, 2)).AsString := UpperCase(Trim(qryColDbf.FieldByName('DESCR').AsString));

            {*****************************************************************}
            {* OBTEM A QUANTIDADE DE COLORANTE INFORMADA NO COMPO DE FORMULA *}
            {**************************************************************PH*}
            strFormula := Copy(strFormula, Pos(',', strFormula) + 1, Length(strFormula));
            fltQtd := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, Pos(',', strFormula) - 1), '.', ','));

            {************************************************************}
            {* OBTEM A QUANTIDADE DA EMBALAGEM DA FORMULA DA TABELA DBF *}
            {*********************************************************PH*}
            qryEmbDbf.Locate('ID', qryFrm.FieldByName('CAN_ID').AsString, []);
            fltEmbOri := qryEmbDbf.FieldByName('QTD').AsFloat;

            {*******************************************}
            {* OBTEM A UNIDADE DESTINO                 *}
            {****************************************PH*}
            If intCont = 1 Then { SE A UNIDADE DESTINO E QUARTO }
            Begin
              qryEmbDbf.Locate('DESCR', 'Quarto', []);
            End
            Else If intCont = 2 Then { SE A UNIDADE FOR GALAO }
            Begin
              qryEmbDbf.Locate('DESCR', 'Galao', []);
            End
            Else {SE A UNIDADE FOR LATA}
            Begin
              qryEmbDbf.Locate('DESCR', 'Lata', []);
            End;

            {*******************************************}
            {* OBTEM A QUANTIDADE DA EMBALAGEM DESTINO *}
            {****************************************PH*}
            fltEmbDes := qryEmbDbf.FieldByName('QTD').AsFloat;

            {*******************************************}
            {* OBTEM A QUANTIDADE A SER CADASTRADA     *}
            {****************************************PH*}
            fltQtd := fltQtd * fltEmbDes / fltEmbOri;

            qryEuc.FieldByName('EUC_QTDB' + fStrZero(intCol, 2)).AsFloat := fltQtd;
            strFormula := Copy(strFormula, Pos(',', strFormula) + 1, Length(strFormula));
            intCol := intCol + 1;
          End;

          qryEuc.Post;
          intCodSeq := intCodSeq + 1;
        End;

        qryFrm.Next;
        pRegistraProgresso(0, qryFrm.RecNo, qryFrm.RecordCount);
      End;
      qrySubProds.Next;
    End;
    qryPaths.Next;
  End;
  pRegistraAcao('Cadastro de tintas realizado com sucesso!');

  FreeAndNil(qryColDbf);
  FreeAndNil(qryEmbDbf);
  FreeAndNil(qryPaths);
  FreeAndNil(qrySubProds);
  FreeAndNil(qryFrm);
  FreeAndNil(qryBasesDbf);
  FreeAndNil(qryEuc);

  Result := True;
end;

function fRetFatorUnidade(strUnidade: String): Double;
Var
  conf: IConfTinta;
begin
  conf   := fGetConfTinta('EUC');
  Result := 1;
  If (strUnidade = conf.fGet('EUCGAL')) Then //If (strUnidade = fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCGAL', '')) Then
    Result := 3.6
  Else If (strUnidade = conf.fGet('EUCQUA')) Then //If (strUnidade = fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCQUA', '')) Then
    Result := 0.9
  Else If (strUnidade = conf.fGet('EUCLAT')) Then //If (strUnidade = fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'EUCLAT', '')) Then
    Result := 18;
end;

function TEucatexImobiliariaDinamica.fFormataStringFloat(
  strValor: String): String;
var
  strResultado: String;
  strResto    : String;
begin
  strResto     := '';
  strResultado := Copy(strValor,1,Pos('.',strValor) - 1);
  strResto     := Copy(strValor,Pos('.',strValor) + 1, Length(strValor));
  if Pos('.',strResto) > 0 then
    strResultado := AnsiReplaceStr(strResultado+strResto,'.',',')
  else
    strResultado := AnsiReplaceStr(strValor,'.',',');
  Result := strResultado;
end;

procedure TEucatexImobiliariaDinamica.pListaTodasAsTintasArquivo;
begin
  pCriaTmpCadEuc;
  pPreencheTmpCadEuc;
  pHabilitaKeysTmpCadEuc;
end;

procedure TEucatexImobiliariaDinamica.pCriaTmpCadEuc;
begin
  qryTmpCadEuc := fCriaQuery(Self);
  With qryTmpCadEuc Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_CADEUC(             ');
    SQL.Add('  CODIGO_COR          VARCHAR(100),  ');
    SQL.Add('  NOME_COR            VARCHAR(100),  ');
    SQL.Add('  GRUPO_PRODUTO       VARCHAR(100),  ');
    SQL.Add('  PRODUTO             VARCHAR(100),  ');
    SQL.Add('  BASE                VARCHAR(50),   ');
    SQL.Add('  COLORANTE_1         VARCHAR(20),   ');
    SQL.Add('  COLORANTE_2         VARCHAR(20),   ');
    SQL.Add('  COLORANTE_3         VARCHAR(20),   ');
    SQL.Add('  COLORANTE_4         VARCHAR(20),   ');
    SQL.Add('  COLORANTE_5         VARCHAR(20),   ');
    SQL.Add('  EMBALAGEM           VARCHAR(20),   ');
    SQL.Add('  UNIDADE             VARCHAR(20),   ');
    SQL.Add('  QUANTCOL_1          VARCHAR(20),   ');
    SQL.Add('  QUANTCOL_2          VARCHAR(20),   ');
    SQL.Add('  QUANTCOL_3          VARCHAR(20),   ');
    SQL.Add('  QUANTCOL_4          VARCHAR(20),   ');
    SQL.Add('  QUANTCOL_5          VARCHAR(20)) ENGINE=MyIsam ');

    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_CADEUC DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_CADEUC VALUES ');
    SQL.Add('(:CODIGO_COR, :NOME_COR, :GRUPO_PRODUTO, :PRODUTO, :BASE, :COLORANTE_1, ');
    SQL.Add(' :COLORANTE_2, :COLORANTE_3, :COLORANTE_4, :COLORANTE_5, :EMBALAGEM, :UNIDADE, ');
    SQL.Add(' :QUANTCOL_1, :QUANTCOL_2, :QUANTCOL_3, :QUANTCOL_4, :QUANTCOL_5)');
  End;
end;

procedure TEucatexImobiliariaDinamica.pDestroiTmpCadEuc;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_CADEUC');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryTmpCadEuc) then
    FreeAndNil(qryTmpCadEuc);
end;

procedure TEucatexImobiliariaDinamica.pPreencheTmpCadEuc;
var
  Excel: TExcelOfc;
  intMaxLin: Integer;
  intCont: Integer;
  intLinha: Integer;
  search_rec: TSearchRec;
begin
  If FindFirst(strPat + '\*.xls', faAnyFile, search_rec) = 0 Then
  Begin

    repeat

      Try
        try
          Excel := TExcelOfc.Create(Self);
          Excel.AbrirArquivo(strPat + '\' + search_rec.Name);
          intMaxLin := Excel.MaximodeLinhas;

          intLinha := 0;

          RegistraAcao('Carregando Planilha: ' + search_rec.Name);

          If (Assigned(RegistraProgresso)) Then
            RegistraProgresso(0, intLinha, intMaxLin);
          Application.ProcessMessages;

          for intCont := 2 to intMaxLin do
          begin
            if (Excel.Ler_Celula('A' + IntToStr(intCont)) <> 'Key1') And //codigo da cor
               (Excel.Ler_Celula('B' + IntToStr(intCont)) <> '') then    //nome da cor
            begin
              qryTmpCadEuc.ParamByName('CODIGO_COR').AsString    := Excel.Ler_Celula('A' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('NOME_COR').AsString      := Excel.Ler_Celula('B' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('GRUPO_PRODUTO').AsString := Excel.Ler_Celula('H' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('PRODUTO').AsString       := Excel.Ler_Celula('J' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('BASE').AsString          := Excel.Ler_Celula('F' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('COLORANTE_1').AsString   := Excel.Ler_Celula('S' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('COLORANTE_2').AsString   := Excel.Ler_Celula('U' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('COLORANTE_3').AsString   := Excel.Ler_Celula('W' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('COLORANTE_4').AsString   := Excel.Ler_Celula('Y' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('COLORANTE_5').AsString   := Excel.Ler_Celula('AA' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('EMBALAGEM').AsString     := Excel.Ler_Celula('E' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('UNIDADE').AsString       := Excel.Ler_Celula('L' + IntToStr(intCont));
              qryTmpCadEuc.ParamByName('QUANTCOL_1').AsString    := fFormataStringFloat(Excel.Ler_Celula('T' + IntToStr(intCont)));
              qryTmpCadEuc.ParamByName('QUANTCOL_2').AsString    := fFormataStringFloat(Excel.Ler_Celula('V' + IntToStr(intCont)));
              qryTmpCadEuc.ParamByName('QUANTCOL_3').AsString    := fFormataStringFloat(Excel.Ler_Celula('X' + IntToStr(intCont)));
              qryTmpCadEuc.ParamByName('QUANTCOL_4').AsString    := fFormataStringFloat(Excel.Ler_Celula('Z' + IntToStr(intCont)));
              qryTmpCadEuc.ParamByName('QUANTCOL_5').AsString    := fFormataStringFloat(Excel.Ler_Celula('AB' + IntToStr(intCont)));
              qryTmpCadEuc.ExecSQL;
            end;
            intLinha := intLinha + 1;

            If (Assigned(RegistraProgresso)) Then
              RegistraProgresso(1, intLinha, intMaxLin);

            Application.ProcessMessages;
          end;

        Except
          On E: Exception Do
          Begin
            fMensagem('Erro','Erro ao criar excel Preenche TmpCadEuc',['OK']);
          End;
        End;
      Finally
        FreeAndNil(Excel);
      End;

    until FindNext(search_rec) <> 0;

    FindClose(search_rec);
  End
end;

procedure TEucatexImobiliariaDinamica.pHabilitaKeysTmpCadEuc;
begin
  qryTmpCadEuc.SQL.Clear;
  qryTmpCadEuc.SQL.Add('ALTER TABLE TMP_CADEUC ENABLE KEYS');
  qryTmpCadEuc.ExecSQL;
  qryTmpCadEuc.Close;

  qryTmpCadEuc.SQL.Clear;
  qryTmpCadEuc.SQL.Add('SELECT * FROM TMP_CADEUC');
  qryTmpCadEuc.Open;
  qryTmpCadEuc.First;
end;

end.
