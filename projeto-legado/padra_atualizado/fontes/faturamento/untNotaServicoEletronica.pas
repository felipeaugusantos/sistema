unit untNotaServicoEletronica;

interface

uses Classes, Uni;

Type
  TDadosServico = class(TInterfacedObject, IInterface)
    private
      function GetCodSLC: String;
      function GetTriMun: String;
    public
      strCodSer: String;
      strDesSer: String;
      strCodCid: String;
      fltQtdSer: Double;
      fltUniSer: Double;
      fltTotSer: Double;
      blnTrSeCi: Boolean;

      property strCodSLC: String Read GetCodSLC;
      property strTriMun: String Read GetTriMun;
  end;

Type
  TDadosNotaServico = class(TInterfacedObject, IInterface)
    public
      strNumDoc: String;
      strEspDoc: String;
      strSerie : string;
      strCodEmp: String;
      strForCli: String;
      strTip_Fc: String;
      strHistor: String;
      dtaDtaEnt: TDateTime;
      strCodCid: String;
      strNomCid: String;
      strEstado: String;
      strNomCli: String;
      strIesCli: String;
      strCgcCli: String;
      strInsMun: String;
      strCepCli: String;
      strEndCli: String;
      strComple: String;
      strBaiCli: String;
      strEndNum: String;
      strEmail_: String;
      fltTotSer: Double;
      fltAlqIss: Double;
      fltValIss: Double;
      fltPisRet: Double;
      fltCofRet: Double;
      fltIrfRet: Double;
      fltCslRet: Double;
      fltVlSgSo: Double;
      strRetIss: String;
      strTipNot: String;
      dtaDtaCan: TDateTime;

      strDentroForaMunicipio: String;
      strTomadorNoMunicipio : String;
      strIsentoInscEstadual : String;
      strTipoLogradouro     : String;
      strTituloLogradouro   : String;

      arrServicos: Array Of TDadosServico;

      constructor Create(strNumDoc, strEspDoc, strCodEmp, strForCli,
        strSerie, strTip_Fc: String);
  end;

Type
  INFES = interface(IInterface)
    function fFormataData(dtaData: TDateTime): String;
    function fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;  
    procedure pGerarNotaServicoParaPessoaFisica;
    procedure pGravarArquivo(strLinha: String);
    procedure pCarregaDocumento(dadosNotaServico: TDadosNotaServico);
    procedure pGerarNotaServicoParaPessoaJuridica;
    procedure pGerarArquivoNota;
  End;

Type
  TNFESGissOnline = class(TInterfacedObject, INFES)
    private
      dadosNotaServico: TDadosNotaServico;
      function fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;
      function fFormataData(dtaData: TDateTime): String;
      procedure pGerarNotaServicoParaPessoaFisica;
      procedure pGravarArquivo(strLinha: String);
      procedure pCarregaDocumento(dadosNotaServico: TDadosNotaServico);
      procedure pGerarNotaServicoParaPessoaJuridica;
    public
      procedure pGerarArquivoNota;
  End;

Type
  TNFESLimeira = class(TInterfacedObject, INFES)
    private
      dadosNotaServico: TDadosNotaServico;
      function fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;
      function fFormataData(dtaData: TDateTime): String;
      procedure pGerarNotaServico;
      procedure pGerarNotaServicoParaPessoaFisica;
      procedure pGerarNotaServicoParaPessoaJuridica;
      procedure pGravarArquivo(strLinha: String);
      procedure pCarregaDocumento(dadosNotaServico: TDadosNotaServico);

    public
      procedure pGerarArquivoNota;
  End;

Type
  TNFESJaboticabal = class(TInterfacedObject, INFES)
    private
      dadosNotaServico: TDadosNotaServico;
      function fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;
      function fFormataData(dtaData: TDateTime): String;
      function fMesReferencia(dtaData: TDateTime): String;
      function fAnoReferencia(dtaData: TDateTime): String;            
      procedure pGerarNotaServico;
      procedure pGerarNotaServicoParaPessoaFisica;
      procedure pGerarNotaServicoParaPessoaJuridica;
      procedure pGravarArquivo(strLinha: String);
      procedure pCarregaDocumento(dadosNotaServico: TDadosNotaServico);

    public
      procedure pGerarArquivoNota;
  End;

  procedure pEnviarNotaDeServicoEletronica(strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTip_Fc: String);
  function fGerarNotaServicoSIAM(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;//Prestcon  

implementation

uses TypInfo, SysUtils, StrUtils,untFuncoesSimples, untFuncoesGenerica, Data.DB,
  untTypesSistema;

{ TDadosServico }

function TDadosServico.GetCodSLC: String;
begin
  if blnTrSeCi And fTabelaExiste('TRISER', True) then
    Result := fCampoTabela('TSE_CDLSSE', 'TRISER', ['TSE_CODSER', 'TSE_CODCID'], [strCodSer, strCodCid])
  Else
    Result := fCampoTabela('SER_CDLSSE', 'CADSER', ['SER_CODSER'], [strCodSer]);
end;

function TDadosServico.GetTriMun: String;
begin
  if blnTrSeCi And fTabelaExiste('TRISER', True) then
    Result := fCampoTabela('TSE_TRIMUN', 'TRISER', ['TSE_CODSER', 'TSE_CODCID'], [strCodSer, strCodCid])
  Else
    Result := fCampoTabela('SER_TRIMUN', 'CADSER', ['SER_CODSER'], [strCodSer]);
end;

procedure pEnviarNotaDeServicoEletronica(strNumDoc, strEspDoc, strCodEmp,
  strForCli, strSerie, strTip_Fc: String);
  Var
    nse: INFES;
    dados: TDadosNotaServico;
begin
  If (strEspDoc = 'NS') And ((fCfgSis('EMPSER') = 'GISS ONLINE') Or
                             (fCfgSis('EMPSER') = 'PREFEITURA DE LIMEIRA') Or
                             (fCfgSis('EMPSER') = 'PREFEITURA DE JABOTICABAL')) Then
  Begin
    dados := TDadosNotaServico.Create(strNumDoc, strEspDoc, strCodEmp,
      strForCli, strSerie, strTip_Fc);

    If (fCfgSis('EMPSER') = 'GISS ONLINE') Then
      nse := TNFESGissOnline.Create;

    If (fCfgSis('EMPSER') = 'PREFEITURA DE LIMEIRA') Then
      nse := TNFESLimeira.Create;

    If (fCfgSis('EMPSER') = 'PREFEITURA DE JABOTICABAL') Then
      nse := TNFESJaboticabal.Create;

    nse.pCarregaDocumento(dados);
    nse.pGerarArquivoNota;
  End;
end;

{ TDadosNotaServico }

constructor TDadosNotaServico.Create(strNumDoc, strEspDoc, strCodEmp, strForCli,
  strSerie, strTip_Fc: String);
  Const
    STR_TOTAL_SERVICOS = 'SUM(IF(RIGHT(DET_CLAFIS, 3) = "933", DET_TOTITE - DET_DESESP, 0))';

  Var
    qryDados : TUniQuery;
    intContador : Integer;
    intIndSer: Integer;

  function fCampoCerto(strCampoFor, strCampoCli, strCampoCon, strAlias: String): String;
  begin
    Result := 'IF(GER_TIP_FC = "F", ' + strCampoFor + ' , ' +
                 'IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", ' + strCampoCon + ', ' + strCampoCli + ')) AS ' + strAlias + ', '
  end;

  Var
    blnTrSeCi : Boolean;
begin
  blnTrSeCi := fCfgSis('TRSECI', varBoolean);

  qryDados := fCriaQuery(Nil);
  qryDados.SQL.Add('SELECT ');
  qryDados.SQL.Add('  GER_NUMDOC, ');
  qryDados.SQL.Add('  GER_SERIE_, ');
  qryDados.SQL.Add('  GER_DTAENT, ');
  qryDados.SQL.Add('  GER_CODEMP, ');
  qryDados.SQL.Add('  FIS_HISTOR, ');
  qryDados.SQL.Add(fCampoCerto('FOR_CODCID', 'CLI_CODCID', 'GER_CIDCON', 'GER_CODCID'));
  qryDados.SQL.Add(fCampoCerto('FOR_NOMFOR', 'CLI_NOMCLI', 'GER_NOMCON', 'GER_NOMCLI'));
  qryDados.SQL.Add(fCampoCerto('FOR_I_E_S_', 'CLI_I_E_S_', 'GER_IESCON', 'GER_IESCLI'));
  qryDados.SQL.Add(fCampoCerto('FOR_C_G_C_', 'CLI_C_G_C_', 'GER_CGCCON', 'GER_CGCCLI'));
  qryDados.SQL.Add(fCampoCerto('000000000000', '000000000000', '000000000000', 'GER_INSMUN'));
  qryDados.SQL.Add(fCampoCerto('FOR_C_E_P_', 'CLI_C_E_P_', 'GER_CEPCON', 'GER_CEPCLI'));
  qryDados.SQL.Add(fCampoCerto('FOR_ENDERE', 'CLI_ENDERE', 'GER_ENDCON', 'GER_ENDCLI'));
  qryDados.SQL.Add(fCampoCerto('""',         'CLI_ENDCOM', '""',         'GER_COMPLE'));
  qryDados.SQL.Add(fCampoCerto('FOR_BAIRRO', 'CLI_BAIRRO', 'GER_BAICON', 'GER_BAICLI'));
  qryDados.SQL.Add(fCampoCerto('FOR_ENDNUM', 'CLI_ENDNUM', '""',         'GER_ENDNUM'));
  qryDados.SQL.Add(fCampoCerto('FOR_EMAIL3', 'CLI_EMAIL3', 'GER_EMLCON', 'GER_EMAIL_'));
  qryDados.SQL.Add('  IF(GER_TOTSER > 0, GER_TOTSER, ' + STR_TOTAL_SERVICOS + ') AS GER_TOTSER, ');
  qryDados.SQL.Add('  AUX_RETISS AS GER_RETISS, ');
  qryDados.SQL.Add('  GER_PERISS, ');
  qryDados.SQL.Add('  GER_VALISS, ');
  qryDados.SQL.Add('  GER_PISRET, ');
  qryDados.SQL.Add('  GER_COFRET, ');
  qryDados.SQL.Add('  GER_IRFRET, ');
  qryDados.SQL.Add('  GER_CSLRET, ');
  qryDados.SQL.Add('  GER_VLSGSO, ');

  For intContador := 1 To 30 Do
  Begin
    qryDados.SQL.Add('  GER_CODS' + fStrZero(intContador, 2) + ', ');
    qryDados.SQL.Add('  GER_DESS' + fStrZero(intContador, 2) + ', ');
    qryDados.SQL.Add('  GER_QTDS' + fStrZero(intContador, 2) + ', ');
    qryDados.SQL.Add('  GER_VALS' + fStrZero(intContador, 2) + ', ');
    qryDados.SQL.Add('  GER_DECS' + fStrZero(intContador, 2) + ', ');
  End;

  qryDados.SQL.Add('  CADEMP.EMP_CODCID, ');
  qryDados.SQL.Add('  MOVGER.AUTOINCREM ');

  qryDados.SQL.Add('FROM ');
  qryDados.SQL.Add('  MOVGER ');
  qryDados.SQL.Add('  INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM ');
  qryDados.SQL.Add('  INNER JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ');
  qryDados.SQL.Add('  INNER JOIN CADEMP ON EMP_CODEMP = MOVGER.GER_CODEMP ');

  qryDados.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ');
  qryDados.SQL.Add('  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ');

  qryDados.SQL.Add('  LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ');

  qryDados.SQL.Add('  JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ');
  qryDados.SQL.Add('                 FIS_ESPDOC = GER_ESPDOC AND ');
  qryDados.SQL.Add('                 FIS_CODEMP = GER_CODEMP AND ');
  qryDados.SQL.Add('                 IFNULL(FIS_SERIE_, "") = IFNULL(GER_SERIE_, "") AND ');
  qryDados.SQL.Add('                 FIS_FORCLI = IF(GER_TIP_FC = "F", FOR_CODFOR, CLI_CODCLI) AND ');
  qryDados.SQL.Add('                 FIS_TIP_FC = GER_TIP_FC ');

  qryDados.SQL.Add('WHERE ');
  qryDados.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryDados.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryDados.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryDados.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND ');
  qryDados.SQL.Add('  IF(:TIP_FC = "C", GER_CODCLI, GER_CODFOR) = :CLIFOR AND ');
  qryDados.SQL.Add('  GER_TIP_FC = :TIP_FC ');

  qryDados.SQL.Add('GROUP BY ');
  qryDados.SQL.Add('  MOVGER.AUTOINCREM ');

  qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
  qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
  qryDados.ParamByName('CODEMP').AsString := strCodEmp;
  qryDados.ParamByName('SERIE_').AsString := strSerie;
  qryDados.ParamByName('TIP_FC').AsString := strTip_Fc;
  qryDados.ParamByName('CLIFOR').AsString := strForCli;
  qryDados.Open;

  if (qryDados.IsEmpty) then
  begin
    qryDados.Close;
    qryDados.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(qryDados.SQL.Text, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'), 'AUXMOV', 'AUXNOT'), 'SERMOV', 'SERNOT');
    qryDados.Open;
  end;

  Self.strNumDoc := strNumDoc;
  Self.strEspDoc := strEspDoc;
  Self.strCodEmp := strCodEmp;
  Self.strSerie  := strSerie;
  Self.strTip_Fc := strTip_Fc;
  Self.strForCli := strForCli;

  Self.strHistor := qryDados.FieldByName('FIS_HISTOR').AsString;
  Self.dtaDtaEnt := qryDados.FieldByName('GER_DTAENT').AsDateTime;
  Self.strCodCid := qryDados.FieldByName('GER_CODCID').AsString;
  Self.strNomCid := fRetNomCidade(qryDados.FieldByName('GER_CODCID').AsString);
  Self.strEstado := fRetNomCidade(qryDados.FieldByName('GER_CODCID').AsString, 2);
  Self.strNomCli := qryDados.FieldByName('GER_NOMCLI').AsString;
  Self.strIesCli := qryDados.FieldByName('GER_IESCLI').AsString;
  Self.strCgcCli := qryDados.FieldByName('GER_CGCCLI').AsString;
  Self.strInsMun := qryDados.FieldByName('GER_INSMUN').AsString;
  Self.strCepCli := qryDados.FieldByName('GER_CEPCLI').AsString;
  Self.strEndCli := qryDados.FieldByName('GER_ENDCLI').AsString;
  Self.strComple := qryDados.FieldByName('GER_COMPLE').AsString;
  Self.strBaiCli := qryDados.FieldByName('GER_BAICLI').AsString;
  Self.strEndNum := qryDados.FieldByName('GER_ENDNUM').AsString;
  Self.strEmail_ := qryDados.FieldByName('GER_EMAIL_').AsString;
  Self.fltTotSer := qryDados.FieldByName('GER_TOTSER').AsFloat;
  Self.fltAlqIss := qryDados.FieldByName('GER_PERISS').AsFloat;
  Self.fltValIss := qryDados.FieldByName('GER_VALISS').AsFloat;
  Self.strRetIss := qryDados.FieldByName('GER_RETISS').AsString;
  Self.fltPisRet := qryDados.FieldByName('GER_PISRET').AsFloat;
  Self.fltCofRet := qryDados.FieldByName('GER_COFRET').AsFloat;
  Self.fltIrfRet := qryDados.FieldByName('GER_IRFRET').AsFloat;
  Self.fltCslRet := qryDados.FieldByName('GER_CSLRET').AsFloat;
  Self.fltVlSgSo := qryDados.FieldByName('GER_VLSGSO').AsFloat;

  Self.strTipNot := IIF(Pos('CANCELADO', qryDados.FieldByName('FIS_HISTOR').AsString) > 0, '2', '1');
  Self.dtaDtaCan := IIF(Pos('CANCELADO', qryDados.FieldByName('FIS_HISTOR').AsString) > 0, Self.dtaDtaEnt, 0);
  strDentroForaMunicipio := IIF(qryDados.FieldByName('GER_CODCID').AsString = fCadEmp('CODCID'), 'D', 'F');
  strTomadorNoMunicipio  := IIF(qryDados.FieldByName('GER_CODCID').AsString = fCadEmp('CODCID'), 'S', 'N');
  strIsentoInscEstadual  := IIF(fEmptyStr(qryDados.FieldByName('GER_IESCLI').AsString), 'S', 'N');
  strTipoLogradouro      := fPadR('RUA', 5, ' ');
  strTituloLogradouro    := fPadR('RUA', 5, ' ');

  For intContador := 1 To 30 Do
  Begin
    If (fEmptyStr(qryDados.FieldByName('GER_DESS' + fStrZero(intContador, 2)).AsString)) Then
      Continue;

    SetLength(arrServicos, Length(arrServicos) + 1);

    intIndSer := Length(arrServicos) -1;

    arrServicos[intIndSer] := TDadosServico.Create;
    arrServicos[intIndSer].strCodSer := qryDados.FieldByName('GER_CODS' + fStrZero(intContador, 2)).AsString;
    arrServicos[intIndSer].strDesSer := qryDados.FieldByName('GER_DESS' + fStrZero(intContador, 2)).AsString;
    arrServicos[intIndSer].strCodCid := qryDados.FieldByName('EMP_CODCID').AsString;
    arrServicos[intIndSer].blnTrSeCi := blnTrSeCi;
    arrServicos[intIndSer].fltQtdSer := qryDados.FieldByName('GER_QTDS' + fStrZero(intContador, 2)).AsFloat;
    arrServicos[intIndSer].fltTotSer := qryDados.FieldByName('GER_VALS' + fStrZero(intContador, 2)).AsFloat;

    If arrServicos[intIndSer].fltQtdSer = 0 Then
      arrServicos[intIndSer].fltQtdSer := 1;
        
    If qryDados.FieldByName('GER_DECS' + fStrZero(intContador, 2)).AsFloat <> 0 Then
    Begin
      arrServicos[intIndSer].fltTotSer := fFormataFloat(arrServicos[intIndSer].fltTotSer * (1 - qryDados.FieldByName('GER_DECS' + fStrZero(intContador, 2)).AsFloat / 100), 2);
    End;

    arrServicos[intIndSer].fltUniSer := arrServicos[intIndSer].fltTotSer / arrServicos[intIndSer].fltQtdSer;
  End;

  FreeAndNil(qryDados);

end;

{ TNFESGissOnline }

procedure TNFESGissOnline.pGerarNotaServicoParaPessoaFisica;
  Var
    strLinha: String;
begin
  strLinha := '';
  strLinha := strLinha + 'C'                                       ; // 001 a 001 - Registro 'C'
  strLinha := strLinha + fStrZero(RightStr(dadosNotaServico.strNumDoc,10), 10); // 002 a 011 - Nro. da Nota Inicial
  strLinha := strLinha + fPadL(dadosNotaServico.strSerie,  10, '0'); // 012 a 021 - Serie da Nota
  strLinha := strLinha + fStrZero(RightStr(dadosNotaServico.strNumDoc,10), 10); // 022 a 031 - Nro. da NOta Final
  strLinha := strLinha + fFormataData(dadosNotaServico.dtaDtaEnt)  ; // 032 a 041 - Data DD/MM/AAAA
  strLinha := strLinha + dadosNotaServico.strTipNot                ; // 042 a 042 - Tipo da Nota
  strLinha := strLinha + fFormataValor(dadosNotaServico.fltTotSer) ; // 043 a 054 - Valor da Nota Fiscal
  strLinha := strLinha + fPadL(fCfgSis('CCLNSE'), 10, ' ')         ; // 055 a 064 - Codigo da Atividade ou Servico
  strLinha := strLinha + '1'                                       ; // 065 a 065 - Tomador '1' ( valor fixo )
  strLinha := strLinha + dadosNotaServico.strDentroForaMunicipio   ; // 066 a 066 - Dentro/Fora do Municipio

  pGravarArquivo(strLinha);  
end;

procedure TNFESGissOnline.pGerarNotaServicoParaPessoaJuridica;
  Var
    strLinha: String;
begin
  strLinha := '';
  strLinha := strLinha + 'C'                                        ; // 001 a 001 - Registro 'C'
  strLinha := strLinha + fStrZero(RightStr(dadosNotaServico.strNumDoc,10), 10); // 002 a 011 - Nro. da Nota Inicial
  strLinha := strLinha + fPadL(dadosNotaServico.strSerie,  010, '0'); // 012 a 021 - Serie da Nota
  strLinha := strLinha + fStrZero(RightStr(dadosNotaServico.strNumDoc,10), 10); // 022 a 031 - Nro. da NOta Final
  strLinha := strLinha + fFormataData(dadosNotaServico.dtaDtaEnt)   ; // 032 a 041 - Data DD/MM/AAAA
  strLinha := strLinha + dadosNotaServico.strTipNot                 ; // 042 a 042 - Tipo da Nota
  strLinha := strLinha + fFormataValor(dadosNotaServico.fltTotSer)  ; // 043 a 054 - Valor da Nota Fiscal
  strLinha := strLinha + fPadL(fCfgSis('CCLNSE'), 10, ' ')          ; // 055 a 064 - Codigo da Atividade ou Servico
  strLinha := strLinha + '2'                                        ; // 065 a 065 - Tomador '2' ( valor fixo )
  strLinha := strLinha + dadosNotaServico.strTomadorNoMunicipio     ; // 066 a 066 - Tomador estabelecido no municipio
  strLinha := strLinha + fPadR(dadosNotaServico.strNomCli, 100, ' '); // 067 a 166 - Razao Social do Tomador
  strLinha := strLinha + fPadL(dadosNotaServico.strInsMun, 012, '0'); // 167 a 178 - Inscricao Municipal + Digito
  strLinha := strLinha + fPadL(dadosNotaServico.strCgcCli, 014, '0'); // 179 a 192 - CNPJ
  strLinha := strLinha + dadosNotaServico.strIsentoInscEstadual     ; // 193 a 193 - Isento de Insc.Est. S/N
  strLinha := strLinha + fPadL(dadosNotaServico.strIesCli, 015, '0'); // 194 a 208 - Inscr. Estadual
  strLinha := strLinha + fPadL(dadosNotaServico.strCepCli, 008, '0'); // 209 a 216 - CEP
  strLinha := strLinha + dadosNotaServico.strTipoLogradouro         ; // 217 a 221 - Tipo do Logradouro Rua, Avn, etc...
  strLinha := strLinha + dadosNotaServico.strTituloLogradouro       ; // 222 a 226 - Titulo do Logradouro Sen, Dr, Cel, etc...
  strLinha := strLinha + fPadR(dadosNotaServico.strEndCli, 050, ' '); // 227 a 276 - Endereco
  strLinha := strLinha + fPadR(dadosNotaServico.strComple, 040, ' '); // 277 a 316 - Complemento Endereco
  strLinha := strLinha + fPadR(dadosNotaServico.strEndNum, 010, ' '); // 317 a 326 - Nro. Endereco
  strLinha := strLinha + fPadR(dadosNotaServico.strBaiCli, 050, ' '); // 327 a 376 - Bairro
  strLinha := strLinha + dadosNotaServico.strEstado                 ; // 377 a 378 - Estado
  strLinha := strLinha + fPadR(dadosNotaServico.strNomCid, 050, ' '); // 379 a 428 - Municipio
  strLinha := strLinha + dadosNotaServico.strDentroForaMunicipio    ; // 429 a 429 - Dentro/Fora do Municipio

  pGravarArquivo(strLinha);
end;

function TNFESGissOnline.fFormataData(dtaData: TDateTime): String;
begin
  Result := FormatDateTime('dd/mm/yyyy', dtaData);
end;

function TNFESGissOnline.fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;
begin
  Result := AnsiReplaceStr(AnsiReplaceStr(FloatToStrF(fltValor, ffNumber, 12, intPrecisao), ',', ''), '.', '');
  Result := fPadL(Result, 12, '0');
end;

procedure TNFESGissOnline.pGravarArquivo(strLinha: String);
  Var
    strNomArq: String;
    stlArq: TStringList;
begin
  strNomArq := fCfgSis('PATNES') + '\NFS_' + dadosNotaServico.strNumDoc + '_' +
                                             dadosNotaServico.strSerie  + '_' +
                                             dadosNotaServico.strCodEmp + '.txt';
  stlArq := TStringList.Create;
  stlArq.Add(strLinha);
  stlArq.SaveToFile(strNomArq);
  FreeAndNil(stlArq);
end;

procedure TNFESGissOnline.pCarregaDocumento(
  dadosNotaServico: TDadosNotaServico);
begin
  Self.dadosNotaServico := dadosNotaServico;
end;

procedure TNFESGissOnline.pGerarArquivoNota;
begin
  If Length(dadosNotaServico.strCgcCli) <= 11 Then
    pGerarNotaServicoParaPessoaFisica
  Else
    pGerarNotaServicoParaPessoaJuridica;
end;

{ TNFESJaboticabal }

procedure TNFESJaboticabal.pGerarNotaServicoParaPessoaFisica;
begin
  pGerarNotaServico;
end;

procedure TNFESJaboticabal.pGerarNotaServicoParaPessoaJuridica;
begin
  pGerarNotaServico;
end;

procedure TNFESJaboticabal.pGerarNotaServico;
  Var
    strLinha: String;
begin
  strLinha := '';
  strLinha := strLinha + fCadEmp('C_G_C_')                           + '|' ; // CNPJ/IM do PRESTADOR
  strLinha := strLinha + '0'                                         + '|' ; // 0–CNPJ  1–CPF  2–IM
  strLinha := strLinha + '1'                                         + '|' ; // 1-Nota emitida  2–Nota recebida
  strLinha := strLinha + dadosNotaServico.strNumDoc                  + '|' ; // Número da nota
  strLinha := strLinha + '1'                                         + '|' ; // 1–Série A Tributado  2–Série C Não tributado  3–Mista
  strLinha := strLinha + fFormataData(dadosNotaServico.dtaDtaEnt)    + '|' ; // Data de emissão da nota AAAAMMDD
  strLinha := strLinha + fMesReferencia(dadosNotaServico.dtaDtaEnt)  + '|' ; // Mês de referência da nota – Numerico(2)
  strLinha := strLinha + fAnoReferencia(dadosNotaServico.dtaDtaEnt)  + '|' ; // Ano de referência da nota – Numerico(4)
  strLinha := strLinha + dadosNotaServico.strTipNot                  + '|' ; // STATUS – Situação da nota – 1–Normal 2–Cancelada

  If dadosNotaServico.strTipNot = '2' Then
    strLinha := strLinha + fFormataData(dadosNotaServico.dtaDtaCan)  + '|'   // Data de cancelamento da nota AAAAMMDD
  Else
    strLinha := strLinha + ''                                        + '|' ; // Data de cancelamento da nota AAAAMMDD

  strLinha := strLinha + '1'                                         + '|' ; // Natureza da Operação 1–Serviço  2–Mista
  strLinha := strLinha + fFormataValor(dadosNotaServico.fltTotSer)   + '|' ; // Valor da Nota Fiscal
  strLinha := strLinha + fFormataValor(dadosNotaServico.fltTotSer)   + '|' ; // Valor dos Serviços

  If fCfgSis('SIMPAU', varBoolean) Then
  Begin
    strLinha := strLinha + fFormataValor(0.00)                       + '|' ; // Valor do imposto a ser retido
    strLinha := strLinha + '3'                                       + '|' ; // Tipo de recolhimento de imposto 0-Isento 1–Retido 2–A recolher 3–Simples
  End
  Else
  Begin
    strLinha := strLinha + fFormataValor(dadosNotaServico.fltValIss) + '|' ; // Valor do imposto a ser retido

    If dadosNotaServico.strRetIss <> 'S' Then
      strLinha := strLinha + '1'                                     + '|'   // Tipo de recolhimento de imposto 0-Isento 1–Retido 2–A recolher 3–Simples
    Else
      strLinha := strLinha + '2'                                     + '|' ; // Tipo de recolhimento de imposto 0-Isento 1–Retido 2–A recolher 3–Simples
  End;

  strLinha := strLinha + fCfgSis('TRMNCR')                           + '|' ; // Codigo da Atividade 
  strLinha := strLinha + fFormataValor(dadosNotaServico.fltAlqIss)   + '|' ; // Alíquota
  strLinha := strLinha + fCadEmp('NOMEMP')                           + '|' ; // Razão social do prestador
  strLinha := strLinha + fCadEmp('NOMCID')                           + '|' ; // Cidade do prestador
  strLinha := strLinha + fCadEmp('ESTADO')                           + '|' ; // UF do prestador
  strLinha := strLinha + '0'                                         + '|' ; // Indica se o prestador é da cidade 0–Da cidade 1–De fora 2–Não cadastrado no município (Não pode ser IM, somente CNPJ/CPF)
  strLinha := strLinha + dadosNotaServico.strCgcCli                  + '|' ; // CNPJ/IM do tomador

  If Length(dadosNotaServico.strCgcCli) > 11 Then
    strLinha := strLinha + '0'                                       + '|'   // Tipo identificação tomador 0–CNPJ 1–CPF 2–IM
  Else
    strLinha := strLinha + '1'                                       + '|' ; // Tipo identificação tomador 0–CNPJ 1–CPF 2–IM

  strLinha := strLinha + dadosNotaServico.strNomCli                  + '|' ; // Razao Social do Tomador
  strLinha := strLinha + dadosNotaServico.strNomCid                  + '|' ; // Cidade do Tomador
  strLinha := strLinha + dadosNotaServico.strEstado                  + '|' ; // UF do Tomador

  If dadosNotaServico.strTomadorNoMunicipio = 'S' Then
    strLinha := strLinha + '0'                                       + '|'   // Indica se o tomador é da cidade 0–Da cidade 1–De fora 2–Não cadastrado no município (Não pode ser IM, somente CNPJ/CPF) 3–Consumidor Final
  Else
    strLinha := strLinha + '1'                                       + '|' ; // Indica se o tomador é da cidade 0–Da cidade 1–De fora 2–Não cadastrado no município (Não pode ser IM, somente CNPJ/CPF) 3–Consumidor Final

  pGravarArquivo(strLinha);
end;

function TNFESJaboticabal.fFormataData(dtaData: TDateTime): String;
begin
  Result := FormatDateTime('yyyymmdd', dtaData);
end;

function TNFESJaboticabal.fMesReferencia(dtaData: TDateTime): String;
begin
  Result := FormatDateTime('mm', dtaData);
end;

function TNFESJaboticabal.fAnoReferencia(dtaData: TDateTime): String;
begin
  Result := FormatDateTime('yyyy', dtaData);
end;

function TNFESJaboticabal.fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;
begin
  Result := AnsiReplaceStr(AnsiReplaceStr(FloatToStrF(fltValor, ffNumber, 12, intPrecisao), ',', ''), '.', '');
end;

procedure TNFESJaboticabal.pGravarArquivo(strLinha: String);
  Var
    strNomArq: String;
    stlArq: TStringList;
begin
  strNomArq := fCfgSis('PATNES') + '\NFS_' + dadosNotaServico.strNumDoc + '_' +
                                             dadosNotaServico.strEspDoc + '_' +
                                             dadosNotaServico.strCodEmp + '.txt';
  stlArq := TStringList.Create;
  stlArq.Add(strLinha);
  stlArq.SaveToFile(strNomArq);
  FreeAndNil(stlArq);
end;

procedure TNFESJaboticabal.pCarregaDocumento(
  dadosNotaServico: TDadosNotaServico);
begin
  Self.dadosNotaServico := dadosNotaServico;
end;

procedure TNFESJaboticabal.pGerarArquivoNota;
begin
  If Length(dadosNotaServico.strCgcCli) <= 11 Then
    pGerarNotaServicoParaPessoaFisica
  Else
    pGerarNotaServicoParaPessoaJuridica;
end;

{ TNFESLimeira }

procedure TNFESLimeira.pGerarNotaServicoParaPessoaFisica;
begin
  pGerarNotaServico;
end;

procedure TNFESLimeira.pGerarNotaServicoParaPessoaJuridica;
begin
  pGerarNotaServico;
end;

procedure TNFESLimeira.pGerarNotaServico;
  Var
    strLinhas: String;
    strCodSer: String;
    strEndere: String;
    fltIssRet: Double;
    fltIssMun: Double;    
    intLinhas: Integer;
    servico  : TDadosServico;
begin
  fltIssRet := 0;
  
  If dadosNotaServico.strRetIss = 'S' Then
    fltIssRet := dadosNotaServico.fltValIss;

  strCodSer := dadosNotaServico.arrServicos[0].strCodSLC;

  If fCfgSis('NTOPNS') = '1' Then //Tributacao no Municipio
    fltIssMun := 0.00
  Else
    fltIssMun := dadosNotaServico.fltAlqIss;

  strEndere := dadosNotaServico.strEndCli + ' ' +
               dadosNotaServico.strEndNum + ' ' +
               dadosNotaServico.strComple + ' - ' +
               dadosNotaServico.strBaiCli;

  intLinhas := 1 + Length(dadosNotaServico.arrServicos) + 1; //(Registro 2, 3, 4)                

  strLinhas := '';
  
  {***************************}
  {* 1 - Linha de Cabeçalho  *}
  {***************************}
  strLinhas := strLinhas + '1';                                                      // Tam 001 Col 001 - 001 -> Tipo de Registro = 1
  strLinhas := strLinhas + '001';                                                    // Tam 003 Col 002 - 004 -> Versao do Layout de Importacao = 001
  strLinhas := strLinhas + fStrZero(fTiraCaracEspeciaisPonto(fCadEmp('INSMUN')), 8); // Tam 008 Col 005 - 012 -> CCM = Inscricao Municipal do Contribuinte EX: 00007546
  strLinhas := strLinhas + fFormataData(dadosNotaServico.dtaDtaEnt);                 // Tam 008 Col 013 - 020 -> Data Inicial (NFs Periodo) AAAAMMDD
  strLinhas := strLinhas + fFormataData(dadosNotaServico.dtaDtaEnt);                 // Tam 008 Col 021 - 028 -> Data Final   (NFs Periodo) AAAAMMDD
  strLinhas := strLinhas + #13#10;                                                   // Tam 002 Col 029 - 030 -> Fim de Linha (Chr(13) + Chr(10))

  {***********************************}
  {* 2 - Registro de Nota Fiscal     *}
  {***********************************}
  strLinhas := strLinhas + '2';                                                      // Tam 001 Col 001 - 001 -> Tipo de Registro = 2
  strLinhas := strLinhas + fPadR(dadosNotaServico.strNumDoc, 12);                    // Tam 012 Col 002 - 013 -> Referencia unica da Nota Fiscal Gerada Pelo Contribuinte
  strLinhas := strLinhas + fFormataData(dadosNotaServico.dtaDtaEnt);                 // Tam 008 Col 014 - 021 -> Data de Emissão da nota Fiscal AAAAMMDD
  strLinhas := strLinhas + '1';                                                      // Tam 001 Col 022 - 022 -> Local de Prestacao do Servico 1-No Municipio 2-Outro Municipio 5-Servico no Exterior
  strLinhas := strLinhas + fStrZero(fFormataValor(dadosNotaServico.fltTotSer), 15);  // Tam 015 Col 023 - 037 -> Valor Total dos Servicos (Decimais sem Virgula)
  strLinhas := strLinhas + fPadR(strCodSer, 5);                                      // Tam 005 Col 038 - 042 -> Codigo do Servico Prestado EX: "01.06", "101 "
  strLinhas := strLinhas + fStrZero(fFormataValor(fltIssMun), 04);                   // Tam 004 Col 043 - 046 -> Aliquota ISS outro Municipio
  strLinhas := strLinhas + fStrZero(fFormataValor(fltIssRet), 15);                   // Tam 015 Col 047 - 061 -> Valor do ISS    a ser Retido pelo Tomador
  strLinhas := strLinhas + fStrZero(fFormataValor(dadosNotaServico.fltIrfRet), 15);  // Tam 015 Col 062 - 076 -> Valor do IRRF   a ser Retido pelo Tomador
  strLinhas := strLinhas + fStrZero(fFormataValor(dadosNotaServico.fltPisRet), 15);  // Tam 015 Col 077 - 091 -> Valor do PIS    a ser Retido pelo Tomador
  strLinhas := strLinhas + fStrZero(fFormataValor(dadosNotaServico.fltCofRet), 15);  // Tam 015 Col 092 - 106 -> Valor do COFINS a ser Retido pelo Tomador
  strLinhas := strLinhas + fStrZero(fFormataValor(dadosNotaServico.fltCslRet), 15);  // Tam 015 Col 107 - 121 -> Valor do CSLL   a ser Retido pelo Tomador
  strLinhas := strLinhas + fStrZero(fFormataValor(dadosNotaServico.fltVlSgSo), 15);  // Tam 015 Col 122 - 136 -> Valor do INSS   a ser Retido pelo Tomador
  strLinhas := strLinhas + fPadR(dadosNotaServico.strCgcCli, 14);                    // Tam 014 Col 137 - 150 -> Numero do CNPJ do tomador sem formatacao
  strLinhas := strLinhas + fPadR('', 08);                                            // Tam 008 Col 151 - 158 -> Data de Vencimento da Fatura associada a Nota Fiscal (A vista deixar em branco)
  strLinhas := strLinhas + fPadR('', 255);                                           // Tam 255 Col 159 - 413 -> Instrucoes de Pagamento da Fatura associada a Nota Fiscal
  strLinhas := strLinhas + #13#10;                                                   // Tam 002 Col 414 - 415 -> Fim de Linha (Chr(13) + Chr(10))

  {**************************************************}
  {* 3 - Registro do Item de Servico de Nota Fiscal *}
  {**************************************************}
  For servico In dadosNotaServico.arrServicos Do
  Begin
    strLinhas := strLinhas + '3';                                                    // Tam 001 Col 001 - 001 -> Tipo de Registro = 3
    strLinhas := strLinhas + fPadR(dadosNotaServico.strNumDoc, 12);                  // Tam 012 Col 002 - 013 -> Referencia unica da Nota Fiscal
    strLinhas := strLinhas + fStrZero(fFormataValor(servico.fltQtdSer, 4), 15);      // Tam 015 Col 014 - 028 -> Quantidade do item de servico (4 decimais sem virgula)
    strLinhas := strLinhas + fPadR('UM', 5);                                         // Tam 005 Col 029 - 033 -> Unidade do item de servico. Preencha com "UM" ou com a unidade utilizada
    strLinhas := strLinhas + fPadR(servico.strDesSer, 255);                          // Tam 255 Col 034 - 288 -> Descrição do Item de servico
    strLinhas := strLinhas + fStrZero(fFormataValor(servico.fltUniSer, 4), 15);      // Tam 015 Col 289 - 303 -> Valor unitario do item de servico (4 decimais sem virgula)
    strLinhas := strLinhas + #13#10;                                                 // Tam 002 Col 304 - 305 -> Fim de Linha (Chr(13) + Chr(10))
  End;

  {**************************************}
  {* 4 - Registro do Tomador de Servico *}
  {**************************************}
  strLinhas := strLinhas + '4';                                                      // Tam 001 Col 001 - 001 -> Tipo de Registro = 4
  strLinhas := strLinhas + fPadR(dadosNotaServico.strCgcCli, 14);                    // Tam 014 Col 002 - 015 -> Numero do CNPJ/CPF do tomador sem formatacao
  strLinhas := strLinhas + fPadR(dadosNotaServico.strNumDoc, 12);                    // Tam 012 Col 016 - 027 -> Referencia unica da Nota Fiscal
  strLinhas := strLinhas + fPadR(dadosNotaServico.strNomCli, 50);                    // Tam 050 Col 028 - 077 -> Nome do Tomador
  strLinhas := strLinhas + fPadR('', 20);                                            // Tam 020 Col 078 - 097 -> Incricao Municipal do tomador pessoa juridica (Preenchimento Opcional)
  strLinhas := strLinhas + fPadR('', 20);                                            // Tam 020 Col 098 - 117 -> Incricao Estadual ou RG do tomador (Preenchimento Opcional)
  strLinhas := strLinhas + fPadR(strEndere, 50);                                     // Tam 050 Col 118 - 167 -> Endereco do tomador
  strLinhas := strLinhas + fPadR(dadosNotaServico.strNomCid, 50);                    // Tam 050 Col 168 - 217 -> Municipio do tomador
  strLinhas := strLinhas + fPadR(dadosNotaServico.strEstado, 02);                    // Tam 002 Col 218 - 219 -> UF do tomador
  strLinhas := strLinhas + fPadR(dadosNotaServico.strCepCli, 08);                    // Tam 008 Col 220 - 227 -> CEP do tomador sem formatacao
  strLinhas := strLinhas + fPadR(dadosNotaServico.strEmail_, 50);                    // Tam 050 Col 228 - 277 -> Email do tomador para envio da NF
  strLinhas := strLinhas + fPadR('', 50);                                            // Tam 050 Col 278 - 327 -> Endereco de cobranca do tomador (Preenchimento Opcional)
  strLinhas := strLinhas + #13#10;                                                   // Tam 002 Col 328 - 329 -> Fim de Linha (Chr(13) + Chr(10))

  {***********************}
  {* 9 - Linha do Rodape *}
  {***********************}
  strLinhas := strLinhas + '9';                                                      // Tam 001 Col 001 - 001 -> Tipo de Registro = 9
  strLinhas := strLinhas + fStrZero(IntToStr(intLinhas), 07);                        // Tam 007 Col 002 - 008 -> Numero de registros do Arquivo (sem considerar linha cabecalho e rodape)
  strLinhas := strLinhas + #13#10;                                                   // Tam 002 Col 009 - 010 -> Fim de Linha (Chr(13) + Chr(10))

  pGravarArquivo(strLinhas);
end;

function TNFESLimeira.fFormataData(dtaData: TDateTime): String;
begin
  Result := FormatDateTime('yyyymmdd', dtaData);
end;

function TNFESLimeira.fFormataValor(fltValor: Double; intPrecisao: Integer = 2): String;
begin
  Result := AnsiReplaceStr(AnsiReplaceStr(FloatToStrF(fltValor, ffNumber, 12, intPrecisao), ',', ''), '.', '');
end;

procedure TNFESLimeira.pGravarArquivo(strLinha: String);
  Var
    strNomArq: String;
    stlArq: TStringList;
begin
  strNomArq := fCfgSis('PATNES') + '\NFS_' + dadosNotaServico.strNumDoc + '_' +
                                             dadosNotaServico.strEspDoc + '_' +
                                             dadosNotaServico.strCodEmp + '.txt';
  stlArq := TStringList.Create;
  stlArq.Add(strLinha);
  stlArq.SaveToFile(strNomArq);
  FreeAndNil(stlArq);
end;

procedure TNFESLimeira.pCarregaDocumento(
  dadosNotaServico: TDadosNotaServico);
begin
  Self.dadosNotaServico := dadosNotaServico;
end;

procedure TNFESLimeira.pGerarArquivoNota;
begin
  If Length(dadosNotaServico.strCgcCli) <= 11 Then
    pGerarNotaServicoParaPessoaFisica
  Else
    pGerarNotaServicoParaPessoaJuridica;
end;

//Prestcon
function fGerarNotaServicoSIAM(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryAux:  TUniQuery;
    strArq:  String;
    strSQL:  String;
    strSQL2: String;
    strLin:  String;
    strItens: String;
    strDocOri: String;
    strInformacoes: String;
    fltQtdItem: Double;
    fltDeducoes: Double;
    txtArq:  TStringList;
    arrDuplicataCND: TarrDuplicata;

    function fTipoCliente: String;
    begin
      Result := IIF(qryAux.FieldByName('CGCCPF').AsString = '2', '0', '1');
    end;

    function fCEPFormatado(strCEP: String): String;
    begin
      Result := fFormataCEP(strCEP);
      Insert('.', Result, 3);
    end;

    function fEnderecos: String;
      Var
        qryEndere: TUniQuery;
        strSqlEnd: String;
        strEndere: String;
    begin
      qryEndere := fCriaQuery;

      With qryEndere, SQL Do
      Begin
        strSqlEnd := strSqlEnd + 'SELECT SQL_NO_CACHE ';
        strSqlEnd := strSqlEnd + '  IF(ETC_ENDENT IS NULL, CLI_ENDERE, ETC_ENDENT) AS ENDENT, ';
        strSqlEnd := strSqlEnd + '  IF(ETC_ENDENT IS NULL, CLI_ENDNUM, ""        ) AS NUMENT, ';
        strSqlEnd := strSqlEnd + '  IF(ETC_ENDENT IS NULL, CLI_ENDCOM, ""        ) AS COMENT, ';
        strSqlEnd := strSqlEnd + '  IF(ETC_ENDENT IS NULL, CLI_BAIRRO, ETC_BAIENT) AS BAIENT, ';

        strSqlEnd := strSqlEnd + '  (SELECT CONCAT(CID_NOMCID, " - ", CID_ESTADO) FROM CADCID ' +
                                 '   WHERE CID_CODCID = IFNULL(ETC_CIDENT, CLI_CODCID) ) AS CIDENT ';

        strSqlEnd := strSqlEnd + 'FROM       ';
        strSqlEnd := strSqlEnd + '  MOVGER G ';
        strSqlEnd := strSqlEnd + '  INNER JOIN CADCLI C  ON C.CLI_CODCLI  = G.GER_CODCLI ';
        strSqlEnd := strSqlEnd + '  LEFT JOIN AUXMOV ON G.AUTOINCREM = AUX_SEQGER ';

        strSqlEnd := strSqlEnd + '  LEFT JOIN ENTCLI ON ETC_CODCLI = G.GER_CODCLI AND                                     ';
        strSqlEnd := strSqlEnd + '                      IF(AUX_ENTGER <> NULL, ENTCLI.AUTOINCREM = AUX_ENTGER,            ';
        strSqlEnd := strSqlEnd + '                      ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = G.GER_CODCLI)) ';

        strSqlEnd := strSqlEnd + 'WHERE ';
        strSqlEnd := strSqlEnd + '  G.GER_NUMFAT = :NUMDOC AND ';
        strSqlEnd := strSqlEnd + '  G.GER_TIPFAT = :ESPDOC AND ';
        strSqlEnd := strSqlEnd + '  G.GER_EMPFAT = :CODEMP     ';

        Add(strSqlEnd);

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        Result := '';

        First;
        While (Not Eof) Do
        Begin
          strEndere := '';
          strEndere := strEndere + FieldByName('ENDENT').AsString;
          strEndere := strEndere + IIF(fEmptyStr(FieldByName('NUMENT').AsString), '', ', ' + FieldByName('NUMENT').AsString);
          strEndere := strEndere + IIF(fEmptyStr(FieldByName('COMENT').AsString), '', ', ' + FieldByName('COMENT').AsString) + ', ';
          strEndere := strEndere + FieldByName('BAIENT').AsString + ' - ';
          strEndere := strEndere + FieldByName('CIDENT').AsString + ' / ';

          If Pos(strEndere, Result) <= 0 Then
            Result := Result + strEndere;

          Next;
        End;

      End;

      FreeAndNil(qryEndere);
    end;

    function fDuplicatas: String;
      Var
        qryDuplicatas: TUniQuery;
    begin
      qryDuplicatas := fCriaQuery;

      With qryDuplicatas, SQL Do
      Begin
        Add('SELECT ');
        Add('  CTR_NUMDUP, ');
        Add('  CTR_PARCEL, ');
        Add('  CTR_DTAVEN ');
        Add('FROM ');
        Add('  CADREC ');
        Add('WHERE ');
        Add('  CTR_NUMDUP = :NUMDUP AND ');
        Add('  CTR_ESPDOC = :ESPDOC AND ');
        Add('  CTR_CODEMP = :CODEMP AND ');
        Add('  CTR_CODCLI = :CODCLI AND ');
        Add('  CTR_SEQBAI = 0 ');

        ParamByName('NUMDUP').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        Result := ' ';

        If qryAux.FieldByName('ORIGEM').AsString = 'MOVGER' Then
          pCarregaDuplicatasCND(2,qryAux.FieldByName('AUTOINCREM').AsString, arrDuplicataCND)
        Else
          pCarregaDuplicatasCND(3,qryAux.FieldByName('AUTOINCREM').AsString, arrDuplicataCND);

        First;
        While (Not Eof) Do
        Begin
          Result := Result + FieldByName('CTR_NUMDUP').AsString  +
                             FieldByName('CTR_PARCEL').AsString + '   ' +
                             FieldByName('CTR_DTAVEN').AsString + '   ' +
                             FormatFloat('#,##0.00', arrDuplicataCND[RecNo-1].curValor) + ' / ';

          Next;
        End;

      End;

      FreeAndNil(qryDuplicatas);
    end;

begin
  Result := True;
  Try
    Try
      strArq  := fCfgSis('PATNES') +  '\NFeS' + strNumDoc + strCodEmp + '.TXT';
      strSQL  := '';
      strSQL  := '';
      strSQL  := strSQL + 'SELECT SQL_NO_CACHE       ';
      strSQL  := strSQL + '  "MOVGER" AS ORIGEM,     ';
      strSQL  := strSQL + '  G.AUTOINCREM,           ';
      strSQL  := strSQL + '  G.GER_NUMDOC AS NUMDOC, ';
      strSQL  := strSQL + '  G.GER_ESPDOC AS ESPDOC, ';
      strSQL  := strSQL + '  G.GER_CODEMP AS CODEMP, ';
      strSQL  := strSQL + '  G.GER_CODCLI AS CODCLI, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_NOMCON,CLI_NOMCLI)       AS NOMCLI, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_ENDCON,CONCAT(CLI_ENDERE,", ",IFNULL(CLI_ENDNUM,""),IF(IFNULL(CLI_ENDCOM,"")="","",CONCAT("  ",CLI_ENDCOM)))) AS ENDCLI, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CIDCON,CLI_CODCID)       AS CIDCLI, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CEPCON,CLI_C_E_P_)       AS CEPCLI, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CGCCPF,CLI_CGCCPF)       AS CGCCPF, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CGCCON,CLI_C_G_C_)       AS CGCCLI, ';
      strSQL  := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","0",IF(IFNULL(CLI_EMAIL_,"")="","0",CLI_EMAIL_)) AS E_MAIL, ';
      strSQL  := strSQL + '  G.GER_DTAENT AS DTAENT, ';
      strSQL  := strSQL + '  D.DET_CODITE AS CODITE, ';
      strSQL  := strSQL + '  D.DET_DESCRI AS DESCRI, ';
      strSQL  := strSQL + '  D.DET_QTDITE AS QTDITE, ';
      strSQL  := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
      strSQL  := strSQL + '  D.DET_UNITAR - D.DET_DESESP / D.DET_QTDITE AS UNITAR, ';
      strSQL  := strSQL + '  D.DET_TOTITE - D.DET_DESESP AS TOTITE, ';
      strSQL  := strSQL + '  G.GER_TOTPRO - G.GER_TOTPRO AS TOTPRO, ';
      strSQL  := strSQL + '  G.GER_VLRCON AS VLRCON, ';
      strSQL  := strSQL + '  G.GER_DESESP AS DESESP, ';
      strSQL  := strSQL + '  F.FIS_BASISS AS BASISS, ';            
      strSQL  := strSQL + '  G.GER_PERISS AS PERISS, ';
      strSQL  := strSQL + '  G.GER_VALISS AS VALISS, ';

      strSQL  := strSQL + '  G.GER_MEN001 AS MEN001, ';
      strSQL  := strSQL + '  G.GER_MEN002 AS MEN002, ';
      strSQL  := strSQL + '  G.GER_MEN003 AS MEN003, ';
      strSQL  := strSQL + '  G.GER_MEN004 AS MEN004, ';
      strSQL  := strSQL + '  G.GER_MEN005 AS MEN005, ';
      strSQL  := strSQL + '  O.MOV_OBSERV AS OBSERV, ';      
      strSQL  := strSQL + '  O.MOV_OBSFIS AS OBSFIS, ';

      strSQL  := strSQL + '  G.GER_VPAR01 AS VPAR01, ';
      strSQL  := strSQL + '  G.GER_VPAR02 AS VPAR02, ';
      strSQL  := strSQL + '  G.GER_VPAR03 AS VPAR03, ';
      strSQL  := strSQL + '  G.GER_VPAR04 AS VPAR04, ';
      strSQL  := strSQL + '  G.GER_VPAR05 AS VPAR05, ';
      strSQL  := strSQL + '  G.GER_VPAR06 AS VPAR06, ';
      strSQL  := strSQL + '  G.GER_VPAR07 AS VPAR07, ';
      strSQL  := strSQL + '  G.GER_VPAR08 AS VPAR08, ';
      strSQL  := strSQL + '  G.GER_VPAR09 AS VPAR09, ';
      strSQL  := strSQL + '  G.GER_VPAR10 AS VPAR10, ';
      strSQL  := strSQL + '  G.GER_VPAR11 AS VPAR11, ';
      strSQL  := strSQL + '  G.GER_VPAR12 AS VPAR12, ';

      strSQL  := strSQL + '  F.FIS_BASPIS AS BASPIS, ';
      strSQL  := strSQL + '  F.FIS_BASCOF AS BASCOF, ';

      strSQL  := strSQL + '  F.FIS_TOTPIS AS TOTPIS, ';
      strSQL  := strSQL + '  F.FIS_TOTCOF AS TOTCOF, ';      

      strSQL  := strSQL + '  T.DET_SEQCCR AS SEQCCR ';

      strSQL  := strSQL + 'FROM                      ';
      strSQL  := strSQL + '  MOVGER G                ';
      strSQL  := strSQL + '  INNER JOIN MOVOBS O  ON O.MOV_SEQGER = G.AUTOINCREM ';
      strSQL  := strSQL + '  INNER JOIN MOVDET D  ON G.AUTOINCREM = D.DET_SEQGER ';
      strSQL  := strSQL + '  INNER JOIN MOVTRI T  ON T.DET_SEQGER = D.AUTOINCREM ';      
      strSQL  := strSQL + '  INNER JOIN CADCLI C  ON C.CLI_CODCLI = G.GER_CODCLI ';
      strSQL  := strSQL + '  INNER JOIN CADUNI U  ON U.UNI_CODUNI = D.DET_UNIDAD ';
      strSQL  := strSQL + '  INNER JOIN CADFIS F  ON G.GER_NUMDOC = F.FIS_NUMDOC AND  ';
      strSQL  := strSQL + '                          G.GER_ESPDOC = F.FIS_ESPDOC AND  ';
      strSQL  := strSQL + '                          G.GER_TIP_FC = F.FIS_TIP_FC AND  ';
      strSQL  := strSQL + '                          G.GER_CODCLI = F.FIS_FORCLI AND  ';
      strSQL  := strSQL + '                          G.GER_CODEMP = F.FIS_CODEMP      ';
      strSQL  := strSQL + 'WHERE ';
      strSQL  := strSQL + '  G.AUTOINCREM = D.DET_SEQGER AND ';
      strSQL  := strSQL + '  G.GER_NUMDOC = :NUMDOC      AND ';
      strSQL  := strSQL + '  G.GER_ESPDOC = :ESPDOC      AND ';
      strSQL  := strSQL + '  G.GER_CODEMP = :CODEMP          ';

      strSQL2 := strSQL;
      strSQL2 := AnsiReplaceStr(strSQL2, 'MOVGER', 'NOTGER');
      strSQL2 := AnsiReplaceStr(strSQL2, 'MOVDET', 'NOTDET');
      strSQL2 := AnsiReplaceStr(strSQL2, 'MOVTRI', 'NOTTRI');

      strSQL  := strSQL + '  UNION ALL ' + strSQL2;

      qryAux := fCriaQuery;
      With qryAux Do
      Begin
        Close;
        SQL.Text := strSQL;
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
        Begin
          strItens   := '';
          fltQtdItem := 0;

          First;

          While Not Eof Do
          Begin
            strDocOri := fCampoTabela('CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",IFNULL(DET_SERIE_,""))',
                                      'MOVDET D INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM',
                                      ['D.DET_NUMFAT','D.DET_TIPFAT','D.DET_EMPFAT','T.DET_SEQCCR'],
                                      [strNumDoc, strEspDoc, strCodEmp, FieldByName('SEQCCR').AsInteger]);

            strItens := strItens + '( ' +  strDocOri                       + '    ' +
                                           FieldByName('DESCRI').AsString  + '    ' +
                   FormatFloat('#,##0.00', FieldByName('QTDITE').AsFloat)  + ' ' +
                                           FieldByName('SIGUNI').AsString  + '   X   ' +
                   FormatFloat('#,##0.00', FieldByName('UNITAR').AsFloat)  + '   =   ' +
                   FormatFloat('#,##0.00', FieldByName('TOTITE').AsFloat)  + ' )     ';

            fltQtdItem := fltQtdItem + FieldByName('QTDITE').AsFloat;

            Next;
          End;

          strItens := AnsiReplaceStr(strItens, ';', '');

          strInformacoes := '';
          strInformacoes := strInformacoes + 'Mensagens: ';
          strInformacoes := strInformacoes + FieldByName('MEN001').AsString + ' ';
          strInformacoes := strInformacoes + FieldByName('MEN002').AsString + ' ';
          strInformacoes := strInformacoes + FieldByName('MEN003').AsString + ' ';
          strInformacoes := strInformacoes + FieldByName('MEN004').AsString + ' ';
          strInformacoes := strInformacoes + FieldByName('MEN005').AsString + ' ';
          strInformacoes := strInformacoes + FieldByName('OBSERV').AsString + ' ';
          strInformacoes := strInformacoes + FieldByName('OBSFIS').AsString + '. ';

          strInformacoes := strInformacoes + 'Vencimentos: ' + fDuplicatas + '. ';
          strInformacoes := strInformacoes + 'Endereço da Obra: ' + fEnderecos;

          If FieldByName('CGCCPF').AsString = '1' Then
            strInformacoes := strInformacoes + 'RETENÇÃO DO ISS, CONFORME LEGISLAÇÃO DO MUNICÍPIO';

          strInformacoes := AnsiReplaceStr(strInformacoes, #13#10, ' / ');

          strItens := strItens + ' ' + strInformacoes;

          strItens := AnsiReplaceStr(strItens, ';', '');

          First;

          fltDeducoes := FieldByName('VLRCON').AsFloat - FieldByName('BASISS').AsFloat;

          txtArq := TStringList.Create;

          strLin := FieldByName('NUMDOC').AsString                                 + ';' +
                    fTipoCliente                                                   + ';' +
                    FormatDateTime('dd/mm/yyyy', FieldByName('DTAENT').AsDateTime) + ';' +
                    FieldByName('NOMCLI').AsString                                 + ';' +
                    fFormataCpfCgc(FieldByName('CGCCLI').AsString, fSetaPais)      + ';' +
                    FieldByName('ENDCLI').AsString                                 + ';' +
                    fCEPFormatado(FieldByName('CEPCLI').AsString)                  + ';' +
                    fRetCodCidadeSIAM(FieldByName('CIDCLI').AsString)              + ';' +
                    fRetCodEstadoSIAM(FieldByName('CIDCLI').AsString)              + ';' +
                    FieldByName('E_MAIL').AsString                                 + ';' +
                    strItens                                                       + ';' +
                    fCfgSis('CODISP')                                              + ';' +
                    fCfgSis('DETISP')                                              + ';' +
                    FormatFloat('0.00', FieldByName('VLRCON').AsFloat / fltQtdItem)+ ';' +
                    FormatFloat('0',    fltQtdItem)                                + ';' +
                    FormatFloat('0.00', FieldByName('VLRCON').AsFloat)             + ';' +
                    FormatFloat('0.00', FieldByName('PERISS').AsFloat)             + ';' +
                    FormatFloat('0.00', FieldByName('VALISS').AsFloat)             + ';' +
                    fRetCodCidadeSIAM(fRetCidEmpresa(VS_strCodEmp))                + ';' +
                    FormatFloat('0.00', FieldByName('BASISS').AsFloat)             + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', 0)                                         + ';' +
                    FormatFloat('0.00', fltDeducoes);

          txtArq.Add(strLin);
          txtArq.SaveToFile(strArq);
        End;
      End;
    Finally
      FreeAndNil(qryAux);
      If (txtArq <> Nil) Then
        FreeAndNil(txtArq);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  If Result Then
    fMensagem('', 'Arquivo de nota de serviço gerado com sucesso!' + #13#10 + strArq, ['&Ok']);
end;

end.
