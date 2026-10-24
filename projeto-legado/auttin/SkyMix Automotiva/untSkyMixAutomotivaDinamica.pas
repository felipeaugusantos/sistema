unit untSkyMixAutomotivaDinamica;

interface

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants, Windows, ADODB, untTintadeMaquina,
  untIConfTinta;

Type
  {*********************************************}
  {* EVENTOS DISPARADOS AO LONGO DOS CADASTROS *}
  {******************************************PH*}
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;

  TSkyMixAutomotivaDinamica = class(TTintadeMaquina)
    private
      strPat : String;
      intOpcao: Integer;
      conf: IConfTinta;

      {***************************************************}
      {* IMPORTA OS ARQUIVOS PARA AS RESPECTIVAS TABELAS *}
      {************************************************PH*}
      function fImportaCadBas: Boolean;
      function fImportaCadGru: Boolean;
      function fImportaCadMon: Boolean;
      function fImportaCadSky: Boolean;
      function fImportaCadSubGru: Boolean;

      {*******************************************}
      {* RETORNA A UNIDADE CONFIGURADA           *}
      {****************************************PH*}
      function fRetornaUnidade(strUnidade: String): String;

      function fCriaAdoQuery(strSql: String): TADODataSet;

    protected
    public
      constructor Create(AOWner: TComponent; intOpcao: Integer); reintroduce; overload;
      constructor Create(AOwner: TComponent); overload; override;
      function fImportaArquivos: Boolean;

      function fGravarNovasFormulas(): Boolean; override;
  end;
  function fRetLinha(strCodGru : String) : String;

  function fCriaZQuery(strSql: String; AOwner: TComponent = nil): TUniQuery;
  function fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
  function fRetornaVariante(strAnuancia: String): String;

implementation

uses untFuncoesSimples, untFuncoes, untDDLFactory,untFuncTinta;

{ TSkyMixAutomotivaDinamica }

constructor TSkyMixAutomotivaDinamica.Create(AOWner: TComponent; intOpcao: Integer);
begin
  {*******************************************}
  {* PATH DO ARQUIVO A SER IMPORTADO         *}
  {****************************************PH*}
  conf   := fGetConfTinta('SKY');
  strPat := conf.fGet('SKYPAT'); //fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPAT', '');
  Self.intOpcao := intOpcao;
end;

function TSkyMixAutomotivaDinamica.fImportaCadGru: Boolean;
  Var
    qryAdoCadGru: TADODataSet;
    qryCadGru: TUniQuery;
begin
  qryAdoCadGru := fCriaAdoQuery('SELECT DISTINCT * FROM INFGRUPO');
  qryCadGru := fCriaQuery(Self);
  qryCadGru.SQL.Text := 'SELECT * FROM SKY_CADGRU';
  qryCadGru.Open;

  pRegistraAcao('Cadastrando grupos...');
  While Not qryAdoCadGru.Eof Do
  Begin
    If Not qryCadGru.Locate('GRU_CODGRU',
      VarArrayOf([qryAdoCadGru.FieldByName('GRUPO').AsString]), []) Then
    Begin
      qryCadGru.Insert;

      qryCadGru.FieldByName('GRU_CODGRU').AsString := qryAdoCadGru.FieldByName('GRUPO').AsString;
      qryCadGru.FieldByName('GRU_VALIDA').AsString := qryAdoCadGru.FieldByName('VALIDADE').AsString;
      qryCadGru.FieldByName('GRU_LINHA_').AsString := qryAdoCadGru.FieldByName('LINHA').AsString;
      qryCadGru.FieldByName('GRU_MARCA_').AsString := qryAdoCadGru.FieldByName('MARCA').AsString;
      qryCadGru.FieldByName('GRU_QUANTI').AsFloat := qryAdoCadGru.FieldByName('QUANTEMB').AsFloat;

      qryCadGru.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SKY_CADGRU', VS_strCodEmp);
      qryCadGru.FieldByName('GRU_CODEMP').AsString := VS_strCodEmp;

      qryCadGru.Post;

      pRegistraProgresso(0, qryAdoCadGru.RecNo, qryAdoCadGru.RecordCount);
    End;

    qryAdoCadGru.Next;
  End;

  pRegistraAcao('Grupos cadastrados com sucesso!');

  FreeAndNil(qryAdoCadGru);
  FreeAndNil(qryCadGru);

  Result := True;
end;

function TSkyMixAutomotivaDinamica.fImportaCadSky: Boolean;
Var
  qryAdoCadProd: TADODataSet;
  qryAdoCadForm: TADODataSet;
  qryCadSky: TUniQuery;
  qryCadGen: TUniQuery;
  qryCadNfm: TUniQuery;

  dtsCadProd: TDataSource;
//  intCont: Integer;
  intFormC: Integer;
  intFormD: Integer;
  fltFator: Double;

  intVersao : Integer;
  strMd5Key : String;

begin
  qryCadGen := fCriaQuery(Self);
  qryCadGen.SQL.Text := 'TRUNCATE TABLE SKY_CADSKY';
  qryCadGen.ExecSQL;
  FreeAndNil(qryCadGen);

  qryAdoCadProd := TADODataSet.Create(Self);
  qryAdoCadProd.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Password="";'+
    'Data Source=' +  strPat + ';Persist Security Info=True';

  qryAdoCadForm  := TADODataSet.Create(Self);
  qryAdoCadForm.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Password="";'+
    'Data Source=' +  strPat + ';Persist Security Info=True';


  qryCadSky := fCriaQuery(Self);


  For intVersao := 1 To 2 DO
  Begin

    qryAdoCadProd.CommandText :=
      ' SELECT CADPROD.*, INFGRUPO.* '+
      '      , CADPROD.GRUPO, CADPROD.SGRUPO '+
      '   FROM (CADPROD'+
      '   LEFT JOIN INFGRUPO ON CADPROD.GRUPO = INFGRUPO.GRUPO)';
    qryAdoCadProd.Open;

    qryAdoCadForm.Close;
    qryAdoCadForm.CommandText := 'SELECT CADFORM.* '+
                                 '  FROM CADFORM '+
                                 ' WHERE CADFORM.VERSAO = ' + IntToStr(intVersao);
    qryAdoCadForm.Open;

    dtsCadProd := fCriaDataSource(qryAdoCadProd);

    qryAdoCadForm.DataSource := dtsCadProd;


    qryAdoCadForm.IndexFieldNames := 'CODPROD';
    qryAdoCadForm.MasterFields    := 'CODPROD';


    pRegistraAcao('Executando a geração das tintas da versão ('+ IntToStr(intVersao) +') do arquivo...');

    qryAdoCadProd.First;

    While Not qryAdoCadProd.Eof Do
    Begin
      strMd5Key := GetMD5(  qryAdoCadProd.FieldByName('CODPROD').AsString +
                            qryAdoCadProd.FieldByName('DESC_PTB').AsString +
                            qryAdoCadProd.FieldByName('ANO').AsString +
                            qryAdoCadProd.FieldByName('ANUANCIA').AsString +
                            qryAdoCadProd.FieldByName('COR_PAI').AsString +
                            qryAdoCadProd.FieldByName('NAC_IMP').AsString +
                            qryAdoCadProd.FieldByName('CD_MONT').AsString +
                            qryAdoCadProd.FieldByName('CADPROD.GRUPO').AsString +
                            qryAdoCadProd.FieldByName('CADPROD.SGRUPO').AsString +
                            qryAdoCadForm.FieldByName('VERSAO').AsString);


      qryCadSky.Close;
      qryCadSky.SQL.Text := 'SELECT * '+
                            '  FROM SKY_CADSKY '+
                            ' WHERE SKY_MD5KEY = :MD5KEY ';

      qryCadSky.ParamByName('MD5KEY').AsString := strMd5Key;
      qryCadSky.Open;


      If (qryCadSky.IsEmpty)
        And (Not fEmptyStr(qryAdoCadForm.FieldByName('CODPROD').AsString)) Then
      begin
        qryCadSky.Insert;
        qryCadSky.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SKY_CADSKY', VS_strCodEmp);
        qryCadSky.FieldByName('SKY_CODEMP').AsString := VS_strCodEmp;

        qryCadSky.FieldByName('SKY_CODPRO').AsString := qryAdoCadProd.FieldByName('CODPROD').AsString;
        qryCadSky.FieldByName('SKY_DESCRI').AsString := qryAdoCadProd.FieldByName('DESC_PTB').AsString;
        qryCadSky.FieldByName('SKY_ANOFAB').AsString := qryAdoCadProd.FieldByName('ANO').AsString;
        qryCadSky.FieldByName('SKY_CODUNI').AsString := qryAdoCadProd.FieldByName('CODUNIV').AsString;
        qryCadSky.FieldByName('SKY_ANUANC').AsString := qryAdoCadProd.FieldByName('ANUANCIA').AsString;
        qryCadSky.FieldByName('SKY_CORPAI').AsString := qryAdoCadProd.FieldByName('COR_PAI').AsString;
        qryCadSky.FieldByName('SKY_NACIMP').AsString := qryAdoCadProd.FieldByName('NAC_IMP').AsString;
        qryCadSky.FieldByName('SKY_CODMON').AsString := qryAdoCadProd.FieldByName('CD_MONT').AsString;
        qryCadSky.FieldByName('SKY_CODGRU').AsString := qryAdoCadProd.FieldByName('CADPROD.GRUPO').AsString;
        qryCadSky.FieldByName('SKY_CODSGR').AsString := qryAdoCadProd.FieldByName('CADPROD.SGRUPO').AsString;
        qryCadSky.FieldByName('SKY_CONDIL').AsString := qryAdoCadForm.FieldByName('CONDIL').AsString;
        qryCadSky.FieldByName('SKY_VERSAO').AsString := qryAdoCadForm.FieldByName('VERSAO').AsString;
        qryCadSky.FieldByName('SKY_MD5KEY').AsString := strMd5Key;

        qryCadSky.FieldByName('SKY_ATIVAD').AsString := 'S';
        qryCadSky.FieldByName('SKY_VARIAN').AsString := fRetornaVariante(qryAdoCadProd.FieldByName('ANUANCIA').AsString);
        qryCadSky.FieldByName('SKY_OBS001').AsString := qryAdoCadProd.FieldByName('OBSCON').AsString;

        fltFator := 1;
        if Trim(UpperCase(qryAdoCadProd.FieldByName('LINHA').AsString)) = Trim(UpperCase('PU')) then
          fltFator := 900 / 675;

        qryAdoCadForm.First;

        intFormD := 1;
        intFormC := 1;

        While Not qryAdoCadForm.Eof Do
        Begin
          If qryAdoCadForm.FieldByName('CONDIL').AsString = 'DILUIDO' Then
          Begin
            qryCadSky.FieldByName('SKY_FORM' + fStrZero(intFormD, 02)).AsString := qryAdoCadForm.FieldByName('BASE').AsString;
            qryCadSky.FieldByName('SKY_QTDB' + fStrZero(intFormD, 02)).AsFloat  := qryAdoCadForm.FieldByName('PESO_GR').AsFloat * fltFator;
            intFormD := intFormD + 1;
          End
          Else
          Begin
            qryCadSky.FieldByName('SKY_FORM' + fStrZero(intFormC, 02)).AsString := qryAdoCadForm.FieldByName('BASE').AsString;
            qryCadSky.FieldByName('SKY_QTDC' + fStrZero(intFormC, 02)).AsFloat  := qryAdoCadForm.FieldByName('PESO_GR').AsFloat;
            intFormC := intFormC + 1;
          End;

          qryAdoCadForm.Next;
        End;


        qryCadSky.Post;
      End;

      pRegistraProgresso(0, qryAdoCadProd.RecNo, qryAdoCadProd.RecordCount);

      qryAdoCadProd.Next;

    End;

//    fGravaAutoIncrem('SKY_CADSKY', qryAdoCadProd.RecNo);
  End;


  pRegistraAcao('Cadastro de tintas realizado com sucesso!');

  qryCadNfm := fCriaQuery(Self);
  qryCadNfm.SQL.Text := 'SELECT * FROM SKY_CADNFM';
  qryCadNfm.Open;

  pRegistraAcao('Cadastrando novas formulas...');

  While Not qryCadNfm.Eof Do
  Begin
    If Not fGravaNovaFormula(qryCadNfm) Then
    Begin
      Result := False;
      pRegistraAcao('Não foi possivel cadastrar as novas formulas!');
      Exit;
    End;

    pRegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
    qryCadNfm.Next;
  End;

  pRegistraAcao('Novas formulas cadastradas com sucesso!');

  FreeAndNil(qryAdoCadForm);
  FreeAndNil(qryAdoCadProd);
  FreeAndNil(qryCadSky);
  FreeAndNil(qryCadNfm);

  Result := True;
end;

function TSkyMixAutomotivaDinamica.fImportaArquivos: Boolean;
begin
  Result := True;
  case intOpcao of
    1: Result := fImportaCadBas;
    2: Result := fImportaCadSubGru And fImportaCadGru;
    3: Result := fImportaCadMon;
    4: Result := fImportaCadSky;
  End;
end;

function TSkyMixAutomotivaDinamica.fImportaCadBas: Boolean;
  Var
    qryAdoCadBas: TADODataSet;
    qryCadBas: TUniQuery;
begin
  qryAdoCadBas := fCriaAdoQuery('SELECT DISTINCT * FROM CADBASE INNER JOIN CADEMB ON CADBASE.EMBAL = CADEMB.EMBAL');
  qryCadBas := fCriaZQuery('SELECT * FROM SKY_CADBAS', Self);
  qryCadBas.Open;

  pRegistraAcao('Cadastrando bases...');

  While Not qryAdoCadBas.Eof Do
  Begin
    If Not qryCadBas.Locate('BAS_CODPRO;BAS_CODBAS',
      VarArrayOf([Trim(qryAdoCadBas.FieldByName('CODPROD').AsString),
                  Trim(qryAdoCadBas.FieldByName('CODBASE').AsString)]), []) Then
    Begin
      qryCadBas.Insert;

      qryCadBas.FieldByName('BAS_CODPRO').AsString := Trim(qryAdoCadBas.FieldByname('CODPROD').AsString);
      qryCadBas.FieldByName('BAS_CODBAS').AsString := Trim(qryAdoCadBas.FieldByname('CODBASE').AsString);
      qryCadBas.FieldByName('BAS_PESESP').AsFloat := qryAdoCadBas.FieldByname('PESO_ESP').AsFloat;
      qryCadBas.FieldByName('BAS_DESCRI').AsString := Trim(qryAdoCadBas.FieldByname('MIXING').AsString);
      qryCadBas.FieldByName('BAS_CODUNI').AsString := Trim(fRetornaUnidade(qryAdoCadBas.FieldByName('DESCEMB').AsString));
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat := qryAdoCadBas.FieldByName('QUANT').AsFloat * 1000;

      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SKY_CADBAS', VS_strCodEmp);

      qryCadBas.Post;

      pRegistraProgresso(0, qryAdoCadBas.RecNo, qryAdoCadBas.RecordCount);
    End;

    qryAdoCadBas.Next;
  End;

  pRegistraAcao('Bases cadastradas com sucesso!');

  FreeAndNil(qryAdoCadBas);
  FreeAndNil(qryCadBas);

  Result := True;
end;

function TSkyMixAutomotivaDinamica.fImportaCadMon: Boolean;
  Var
    qryAdoCadMon: TADODataSet;
    qryCadMon: TUniQuery;
begin
  qryAdoCadMon := fCriaAdoQuery('SELECT DISTINCT * FROM CADMONT');
  qryCadMon := fCriaZQuery('SELECT * FROM SKY_CADMON', Self);
  qryCadMon.Open;

  pRegistraAcao('Cadastrando montadoras...');

  While Not qryAdoCadMon.Eof Do
  Begin
    If Not qryCadMon.Locate('MON_CODMON;MON_DESMON',
      VarArrayOf([qryAdoCadMon.FieldByName('COD_MONT').AsString,
      qryAdoCadMon.FieldByName('MONTADORA').AsString]), []) Then
    Begin
      qryCadMon.Insert;

      qryCadMon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SKY_CADMON', VS_strCodEmp);
      qryCadMon.FieldByName('MON_CODEMP').AsString := VS_strCodEmp;

      qryCadMon.FieldByName('MON_CODMON').AsString := qryAdoCadMon.FieldByName('COD_MONT').AsString;
      qryCadMon.FieldByName('MON_DESMON').AsString := qryAdoCadMon.FieldByName('MONTADORA').AsString;

      qryCadMon.Post;
    End;

    pRegistraProgresso(0, qryAdoCadMon.RecNo, qryAdoCadMon.RecordCount);

    qryAdoCadMon.Next;

  End;

  pRegistraAcao('Montadoras cadastradas com sucesso!');

  FreeAndNil(qryAdoCadMon);
  FreeAndNil(qryCadMon);

  Result := True;
end;

function TSkyMixAutomotivaDinamica.fImportaCadSubGru: Boolean;
  Var
    qryAdoCadSubGru: TADODataSet;
    qryCadSubGru: TUniQuery;
begin
  qryAdoCadSubGru := fCriaAdoQuery('SELECT DISTINCT * FROM INFSGRUPO');
  qryCadSubGru := fCriaZQuery('SELECT * FROM SKY_CADSGR', Self);
  qryCadSubGru.Open;

  pRegistraAcao('Cadastrando sub grupos...');

  While Not qryAdoCadSubGru.Eof Do
  Begin
    If Not qryCadSubGru.Locate('SGR_CODSGR;SGR_ASPECT', VarArrayOf([qryAdoCadSubGru.FieldByName('SGRUPO').AsString,
      qryAdoCadSubGru.FieldByName('ASPECTO').AsString]), []) Then
    Begin
      qryCadSubGru.Insert;

      qryCadSubGru.FieldByName('SGR_CODSGR').AsString := qryAdoCadSubGru.FieldByName('SGRUPO').AsString;
      qryCadSubGru.FieldByName('SGR_ASPECT').AsString := qryAdoCadSubGru.FieldByName('ASPECTO').AsString;

      qryCadSubGru.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SKY_CADSGR', VS_strCodEmp);
      qryCadSubGru.FieldByName('SGR_CODEMP').AsString := VS_strCodEmp;

      qryCadSubGru.Post;
    End;

    pRegistraProgresso(0, qryAdoCadSubGru.RecNo, qryAdoCadSubGru.RecordCount);

    qryAdoCadSubGru.Next;
  End;

  pRegistraAcao('Subgrupos cadastrados com sucesso!');

  FreeAndNil(qryAdoCadSubGru);
  FreeAndNil(qryCadSubGru);

  Result := True;
end;

function fRetLinha(strCodGru: String): String;
Var
  qryAux : TUniQuery;
begin
  Try
    qryAux:= fCriaQuery();
    qryAux.SQL.Text := 'SELECT GRU_LINHA_ '+
                       '  FROM SKY_CADGRU '+
                       ' WHERE GRU_CODGRU = :CODGRU '+
                       '   AND GRU_CODEMP = :CODEMP ';
    qryAux.ParamByName('CODGRU').AsString := strCodGru;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    Result := qryAux.FieldByName('GRU_LINHA_').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TSkyMixAutomotivaDinamica.fRetornaUnidade(
  strUnidade: String): String;
begin
  If Pos('1 Galão', strUnidade) > 0 Then
    Result := conf.fGet('SKYUGL') //fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYUGL', '')
  Else If Pos('1 Quarto', strUnidade) > 0 Then
    Result := conf.fGet('SKYULT') //fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYULT', '')
  Else If Pos('Lata 18 Litos', strUnidade) > 0 Then
    Result := conf.fGet('SKYULA'); //fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYULA', '');
end;

function TSkyMixAutomotivaDinamica.fCriaAdoQuery(
  strSql: String): TADODataSet;
begin
  Result := TADODataSet.Create(Self);
  Result.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Password="";Data Source=' +
    strPat + ';Persist Security Info=True';
  Result.CommandText := strSql;
  Result.Open;
end;

function fCriaZQuery(strSql: String; AOwner: TComponent = nil): TUniQuery;
  Var
    intCont: Integer;
begin
  Result := fCriaQuery(AOwner);
  Result.SQL.Text := strSql;
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;

function fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
  Var
    qryGen   : TUniQuery;
    intCont  : Integer;
    fltFator : Double;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'DELETE FROM SKY_CADSKY WHERE SKY_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT * FROM SKY_CADSKY WHERE FALSE';
  qryGen.Open;

  qryGen.Insert;
  qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SKY_CADSKY', VS_strCodEmp);
  qryGen.FieldByName('SKY_CODEMP').AsString := VS_strCodEmp;
  qryGen.FieldByName('SKY_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryGen.FieldByName('SKY_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryGen.FieldByName('SKY_ANOFAB').AsString := qryCadNfm.FieldByName('NFM_ANOFAB').AsString;
  qryGen.FieldByName('SKY_CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;
  qryGen.FieldByName('SKY_ANUANC').AsString := qryCadNfm.FieldByName('NFM_ANUANC').AsString;
  qryGen.FieldByName('SKY_CORPAI').AsString := qryCadNfm.FieldByName('NFM_CORPAI').AsString;
  qryGen.FieldByName('SKY_NACIMP').AsString := qryCadNfm.FieldByName('NFM_NACIMP').AsString;
  qryGen.FieldByName('SKY_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
  qryGen.FieldByName('SKY_CODGRU').AsString := qryCadNfm.FieldByName('NFM_CODGRU').AsString;
  qryGen.FieldByName('SKY_CODSGR').AsString := qryCadNfm.FieldByName('NFM_CODSGR').AsString;
  qryGen.FieldByName('SKY_CONDIL').AsString := qryCadNfm.FieldByName('NFM_CONDIL').AsString;
  qryGen.FieldByName('SKY_VERSAO').AsString := '1';

  qryGen.FieldByName('SKY_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
  qryGen.FieldByName('SKY_VARIAN').AsString   := fRetornaVariante(qryCadNfm.FieldByName('NFM_ANUANC').AsString);
  qryGen.FieldByName('SKY_OBS001').AsString   := qryCadNfm.FieldByName('NFM_OBS001').AsString;
  qryGen.FieldByName('SKY_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

  fltFator := 1;

  If fRetLinha(qryCadNfm.FieldByName('NFM_CODGRU').AsString) = Trim(UpperCase('PU')) Then
    fltFator := 900 / 675;


  For intCont := 1 To 20 Do
  Begin
    If fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
      Break;

    qryGen.FieldByName('SKY_FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

    If qryGen.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
      qryGen.FieldByName('SKY_QTDB' + fStrZero(intCont, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat * fltFator
    else
      qryGen.FieldByName('SKY_QTDC' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsString;

  End;

  qryGen.FieldByName('SKY_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
  qryGen.FieldByName('SKY_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryGen.FieldByName('SKY_MD5KEY').AsString := GetMD5(qryGen.FieldByName('SKY_CODPRO').AsString +
                                                qryGen.FieldByName('SKY_DESCRI').AsString +
                                                qryGen.FieldByName('SKY_ANOFAB').AsString +
                                                qryGen.FieldByName('SKY_ANUANC').AsString +
                                                qryGen.FieldByName('SKY_CORPAI').AsString +
                                                qryGen.FieldByName('SKY_NACIMP').AsString +
                                                qryGen.FieldByName('SKY_CODMON').AsString +
                                                qryGen.FieldByName('SKY_CODGRU').AsString +
                                                qryGen.FieldByName('SKY_CODSGR').AsString +
                                                qryGen.FieldByName('SKY_VERSAO').AsString);
  qryGen.Post;

  Result := True;
end;

function fRetornaVariante(strAnuancia: String): String;
  function fCodigoVarianteCores(strCodigo: String) : String;
  begin
    Result := '';
    
    If strCodigo = 'A' Then
      Result := 'Principal'
    Else If strCodigo = 'T' Then
      Result := 'Tri-Coat'
    Else If strCodigo = 'B' Then
      Result := 'Mais Clara'
    Else If strCodigo = 'C' Then
      Result := 'Mais Escura'
    Else If strCodigo = 'D' Then
      Result := 'Mais Azul'
    Else If strCodigo = 'E' Then
      Result := 'Mais Amarelo'
    Else If strCodigo = 'F' Then
      Result := 'Mais Verde'
    Else If strCodigo = 'G' Then
      Result := 'Mais Vermelho'
    Else If strCodigo = 'H' Then
      Result := 'Mais Fino'
    Else If strCodigo = 'I' Then
      Result := 'Mais Graúdo'
    Else If strCodigo = 'J' Then
      Result := 'Frente'
    Else If strCodigo = 'K' Then
      Result := 'Alumínio'
    Else If strCodigo = 'W' Then
      Result := 'Limpo'
    Else If strCodigo = 'X' Then
      Result := 'Sujo'
    Else If strCodigo = 'Y' Then
      Result := 'Leitoso'
    Else If strCodigo = 'Z' Then
      Result := 'No Ângulo';
  end;

  var intCont: Integer;
begin
  Result := '';

  If Not fEmptyStr(strAnuancia) Then
    For intCont := 1 To Length(strAnuancia) Do
    Begin
      If fEmptyStr(Result) Then
        Result := fCodigoVarianteCores(Copy(strAnuancia,intCont,1))
      Else
        Result := Result + ' e ' + fCodigoVarianteCores(Copy(strAnuancia,intCont,1));
    End;
end;

function TSkyMixAutomotivaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM SKY_CADNFM';
  qryGen.Open;
  
  pRegistraAcao('Cadastrando novas formulas...');

  While Not qryGen.Eof Do
  Begin
    Result := fGravaNovaFormula(qryGen);
    If Not Result Then
    Begin
      pRegistraAcao('Não foi possivel cadastrar as novas formulas!');
      Exit;
    End;

    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
    qryGen.Next;
  End;

  pRegistraAcao('Novas formulas cadastradas com sucesso!');
  Result := True;
end;

constructor TSkyMixAutomotivaDinamica.Create(AOwner: TComponent);
begin
  NomeTinta := 'SkyMix Automotiva';
  inherited;
end;

end.

