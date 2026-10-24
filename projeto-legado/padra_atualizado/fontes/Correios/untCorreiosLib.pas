unit untCorreiosLib;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  Variants,
  Winapi.Windows,
  Data.DB,
  Uni,
  cxProgressBar,
  Correios.Types,
  Correios.Interfaces;

type
  TGetCorreioClass = function (const ACodEmp: WideString; var AQuery: TUniQuery): ICorreios; stdcall;

  TCorreiosLib = class
  private
    FQuery: TUniQuery;
  protected
    FCorreios: ICorreios;
  public
    property Instance: ICorreios read FCorreios;

    constructor Create;
    destructor Destroy; override;
  end;

  TCorreioCep = class(TCorreiosLib)
  private
    FCep: String;
    FCidade: String;
    FEndereco: String;
    FBairro: String;
    FEstado: String;
  public
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property Endereco: String read FEndereco write FEndereco;
    property Bairro: String read FBairro write FBairro;
    property Estado: String read FEstado write FEstado;

    function ConsultaCep(pgbProgresso: TcxProgressBar): Boolean;
  end;

  TCorreiosServicos = class(TCorreiosLib)
  private
    FNumContrato: String;
    FNumCartao: String;
    FHomologacao: Boolean;
    FServicosCliente: TServicosCliente;
  public
    property NumContrato: String read FNumContrato write FNumContrato;
    property NumCartao: String read FNumCartao write FNumCartao;
    property Homologacao: Boolean read FHomologacao write FHomologacao;
    property ServicosCliente: TServicosCliente read FServicosCliente write FServicosCliente;

    function GetServicos(pgbProgresso: TcxProgressBar): Boolean;
  end;

  TCorreiosPrePostagem = class(TCorreiosLib)
  private
    FNumeroDocumento: String;
    FEspecieDocumento: String;
    FEmpresaDocumento: String;
    FClienteDocumento: String;
    FCodigoServico: String;
    FJsonEnvio: String;
    FJsonRetorno: String;
    FIdPostagem: String;
    FNumeroObjeto: String;
    FQtdVolumes: Integer;
    function GetSqlPrePostagem: String;
    function GetSqlItensPedido: String;
    function GetSqlItensDocumento: String;
  public
    property NumeroDocumento: String read FNumeroDocumento write FNumeroDocumento;
    property EspecieDocumento: String read FEspecieDocumento write FEspecieDocumento;
    property EmpresaDocumento: String read FEmpresaDocumento write FEmpresaDocumento;
    property ClienteDocumento: String read FClienteDocumento write FClienteDocumento;
    property CodigoServico: String read FCodigoServico write FCodigoServico;
    property JsonEnvio: String read FJsonEnvio write FJsonEnvio;
    property JsonRetorno: String read FJsonRetorno write FJsonRetorno;
    property IdPostagem: String read FIdPostagem write FIdPostagem;
    property NumeroObjeto: String read FNumeroObjeto write FNumeroObjeto;
    property QtdVolumes: Integer read FQtdVolumes write FQtdVolumes;

    function EnviaPrePostagem: Boolean;
  end;

const
  LIB_NAME = 'libCorreios.dll';

implementation

uses
  untFuncoesSimples,
  untSIGEPWebFuncoes;

{ TCorreiosLib }

constructor TCorreiosLib.Create;
  var
    LPathDll: String;
    LHandleDll: THandle;
    LGetCorreioClass: TGetCorreioClass;
begin
  LPathDll := ExtractFilePath(Application.ExeName) + LIB_NAME;

  if not FileExists(LPathDll) then
    raise Exception.Create('Biblioteca '+ LIB_NAME +' não encontrada na pasta de instalação do Autcom. Favor entrar em contato com o suporte.');

  LHandleDll := LoadLibrary(PChar(LPathDll));
  FQuery     := fCriaQuery;

  @LGetCorreioClass := GetProcAddress(LHandleDll, 'GetCorreioClass');

  //instância da ICorreios retornada pela dll
  FCorreios := LGetCorreioClass(VS_strCodEmp, FQuery);
end;

destructor TCorreiosLib.Destroy;
begin
  if Assigned(FQuery) then
    FreeAndNil(FQuery);
  inherited;
end;

{ TCorreioCep }

function TCorreioCep.ConsultaCep(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  try
    pgbProgresso.Visible := False;
    Result := FCorreios.ConsultaCep(fRetSomenteNumeros(FCep), FCidade, FEndereco, FBairro, FEstado);
  except
    on E: Exception do
      pMensagensErro('Erro ao consultar o CEP: '+ E.Message, '[TCorreioCep.ConsultaCep]');
  end;
end;

{ TCorreiosServicos }

function TCorreiosServicos.GetServicos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  try
    pgbProgresso.Visible := False;
    FServicosCliente := FCorreios.GetServicosCliente(FNumContrato, FNumCartao, FHomologacao);

    Result := Assigned(FServicosCliente);
  except
    on E: Exception do
      pMensagensErro('Erro ao obter os serviços: '+ E.Message, '[TCorreiosServicos.GetServicos]');
  end;
end;

function fGetValorDeclarado(const AValDoc: Double): Double;
  const
    VLR_MAX_CORREIOS = 35571.17;
begin
  if AValDoc < fCfgSis('CORVMI', varDouble) then
    Exit(fCfgSis('CORVMI', varDouble));

  if AValDoc > VLR_MAX_CORREIOS then
    Exit(VLR_MAX_CORREIOS);

  Result := AValDoc;
end;

function TCorreiosPrePostagem.EnviaPrePostagem: Boolean;
  var
    objPostagem: TDadosPostagem;
    qryPlpDoc, qryItens: TUniQuery;
begin
  Result := False;

  qryPlpDoc := fCriaQuery;
  qryItens  := fCriaQuery;
  objPostagem := TDadosPostagem.Create;

  try
    try
      qryPlpDoc.SQL.Text := GetSqlPrePostagem;

      qryPlpDoc.ParamByName('NUMDOC').AsString := FNumeroDocumento;
      qryPlpDoc.ParamByName('ESPDOC').AsString := FEspecieDocumento;
      qryPlpDoc.ParamByName('CODEMP').AsString := FEmpresaDocumento;
      qryPlpDoc.ParamByName('CODCLI').AsString := FClienteDocumento;
      qryPlpDoc.Open;

      if qryPlpDoc.IsEmpty then
        Exit;

      objPostagem.remetente.nome        := LeftStr(qryPlpDoc.FieldByName('EMP_NOMEMP').AsString, 50);
      objPostagem.remetente.telefone    := fTiraCaracEspeciaisPonto(qryPlpDoc.FieldByName('EMP_FONE01').AsString).Replace(' ', '');
      objPostagem.remetente.email       := fTiraCaracEspeciaisPonto(qryPlpDoc.FieldByName('EMP_EMAIL_').AsString).Replace(' ', '');
      objPostagem.remetente.cnpj        := IIF(not fEmptyStr(fCfgSis('CGCPLP')), fCfgSis('CGCPLP'),
                                               fTiraCaracEspeciaisPonto(qryPlpDoc.FieldByName('EMP_C_G_C_').AsString).Replace(' ', ''));
      objPostagem.remetente.cep         := fTiraCaracEspeciaisPonto(qryPlpDoc.FieldByName('EMP_C_E_P_').AsString).Replace(' ', '');
      objPostagem.remetente.endereco    := qryPlpDoc.FieldByName('EMP_ENDERE').AsString;
      objPostagem.remetente.numero      := qryPlpDoc.FieldByName('EMP_ENDNUM').AsString;
      objPostagem.remetente.compl       := qryPlpDoc.FieldByName('EMP_ENDCMP').AsString;
      objPostagem.remetente.bairro      := qryPlpDoc.FieldByName('EMP_BAIRRO').AsString;
      objPostagem.remetente.cidade      := qryPlpDoc.FieldByName('EMP_NOMCID').AsString;
      objPostagem.remetente.uf          := qryPlpDoc.FieldByName('EMP_ESTADO').AsString;

      objPostagem.destinatario.nome     := LeftStr(qryPlpDoc.FieldByName('NOMCLI').AsString, 50);
      objPostagem.destinatario.telefone := fTiraCaracEspeciaisPonto(qryPlpDoc.FieldByName('FONCLI').AsString).Replace(' ', '');
      objPostagem.destinatario.cep      := fTiraCaracEspeciaisPonto(qryPlpDoc.FieldByName('CEPCLI').AsString).Replace(' ', '');
      objPostagem.destinatario.endereco := qryPlpDoc.FieldByName('ENDCLI').AsString;
      objPostagem.destinatario.numero   := '00000';
      objPostagem.destinatario.compl    := qryPlpDoc.FieldByName('ENDCOM').AsString;
      objPostagem.destinatario.bairro   := qryPlpDoc.FieldByName('BAICLI').AsString;
      objPostagem.destinatario.cidade   := qryPlpDoc.FieldByName('NOMCID').AsString;
      objPostagem.destinatario.uf       := qryPlpDoc.FieldByName('ESTADO').AsString;

      objPostagem.codigoServico         := FCodigoServico.Trim;
      objPostagem.numeroNotaFiscal      := qryPlpDoc.FieldByName('NUMDOC').AsString;
      objPostagem.chaveNFe              := qryPlpDoc.FieldByName('CHAVNF').AsString;

      if fCfgSis('CORDCL', varBoolean) then
      begin
        objPostagem.valorServicoAdic  := fFormataFloat(fGetValorDeclarado(qryPlpDoc.FieldByName('VLRCON').AsFloat), 2);
        objPostagem.codigoServicoAdic := IIF(fRetDescricaoServicoCorreio(FCodigoServico.Trim).Contains('PAC'), '064', '019');
      end;

      if FEspecieDocumento = 'PD' then
        qryItens.SQL.Text := GetSqlItensPedido
      else
        qryItens.SQL.Text := GetSqlItensDocumento;

      qryItens.ParamByName('NUMDOC').AsString := FNumeroDocumento;
      qryItens.ParamByName('ESPDOC').AsString := FEspecieDocumento;
      qryItens.ParamByName('CODEMP').AsString := FEmpresaDocumento;
      qryItens.ParamByName('CODCLI').AsString := FClienteDocumento;
      qryItens.Open;

      qryItens.First;
      while not qryItens.Eof do
      begin
        objPostagem.itensConteudo.Add(TItemConteudo.Create(
          LeftStr(qryItens.FieldByName('DESCRI').AsString, 60),
          qryItens.FieldByName('QTDITE').AsFloat,
          qryItens.FieldByName('TOTITE').AsFloat));

        qryItens.Next;
      end;

      Result := FCorreios.EnviaPreListaPostagem(objPostagem, FJsonEnvio, FJsonRetorno, FIdPostagem, FNumeroObjeto);
    except
      raise;
    end;
  finally
    FreeAndNil(qryPlpDoc);
    FreeAndNil(qryItens);
    FreeAndNil(objPostagem);
  end;
end;

function fValorSeguroSigep: String;
Begin
  Result := fSQLIFClienteConsumidor('C.CLI_NOMCLI', 'CC.CID_VRMSEG', 'IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_VRMSEG, CE.CID_VRMSEG)');
End;

function fPercentualSeguroSigep: String;
Begin
  Result := fSQLIFClienteConsumidor('C.CLI_NOMCLI', 'CC.CID_PERSEG', 'IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_PERSEG, CE.CID_PERSEG)');
End;

//select adaptado de: untDespacho.fSQLDespacho
function TCorreiosPrePostagem.GetSqlPrePostagem: String;
  var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_NOMEMP, ';
  strSQL := strSQL + '  EMP_FONE01, ';
  strSQL := strSQL + '  EMP_EMAIL_, ';
  strSQL := strSQL + '  EMP_C_G_C_, ';
  strSQL := strSQL + '  EMP_C_E_P_, ';
  strSQL := strSQL + '  EMP_ENDERE, ';
  strSQL := strSQL + '  EMP_ENDNUM, ';
  strSQL := strSQL + '  EMP_ENDCMP, ';
  strSQL := strSQL + '  EMP_BAIRRO, ';
  strSQL := strSQL + '  EC.CID_NOMCID AS EMP_NOMCID, ';
  strSQL := strSQL + '  EC.CID_ESTADO AS EMP_ESTADO, ';
  strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_NOMCLI) > 0) AND (G.FGO_NOMCON IS NOT NULL)), G.FGO_NOMCON, C.CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_NOMCLI) > 0) AND (G.FGO_NOMCON IS NOT NULL)), G.FGO_TELCON, C.CLI_FONE01) AS FONCLI, ';
  strSQL := strSQL + '  FGO_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '  FGO_VLRCON AS VLRCON, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('C.CLI_NOMCLI',
                                             'G.FGO_CEPCON',
                                             'IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_C_E_P_, ETC_CEPENT)') + ' AS CEPCLI, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('C.CLI_NOMCLI',
                                             'G.FGO_ENDCON',
                                             'IF((ETC_ENDENT IS NULL OR ETC_ENDENT = "") OR (ETC_ENDFAT = "S"), CONCAT(C.CLI_ENDERE, IF(IFNULL(C.CLI_ENDNUM, "") = "", "", '+
                                             'CONCAT(", ", C.CLI_ENDNUM))), ETC_ENDENT)') + ' AS ENDCLI, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('C.CLI_NOMCLI',
                                             '""',
                                             'IF((ETC_ENDENT IS NULL OR ETC_ENDENT = "") OR (ETC_ENDFAT = "S"), CLI_ENDCOM, "")') + ' AS ENDCOM, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('C.CLI_NOMCLI',
                                             'G.FGO_BAICON',
                                             'IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_BAIRRO, ETC_BAIENT)') + ' AS BAICLI, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('C.CLI_NOMCLI',
                                             'CC.CID_NOMCID',
                                             'IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID)') + ' AS NOMCID, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('C.CLI_NOMCLI',
                                             'CC.CID_ESTADO',
                                             'IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO)') + ' AS ESTADO, ';

  strSQL := strSQL + '  IF((FGO_TOTPRO >= '+ fValorSeguroSigep +') AND ('+ fPercentualSeguroSigep +' > 0), ';
  strSQL := strSQL + '      FGO_TOTPRO * '+ fPercentualSeguroSigep +' / 100, 0) / '+ FQtdVolumes.ToString +' AS VALSEG, ';

  if FEspecieDocumento = 'PD' then
  begin
    strSQL := strSQL + '  "" AS NUMDOC, ';
    strSQL := strSQL + '  "" AS CHAVNF ';
  end
  else
  begin
    strSQL := strSQL + '  G.GER_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + ' (SELECT FIS_ACESSO FROM CADFIS ';
    strSQL := strSQL + '  WHERE FIS_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '    AND FIS_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '    AND FIS_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '    AND FIS_SERIE_ = G.GER_SERIE_ ';
    strSQL := strSQL + '    AND FIS_ORIDOC = G.GER_ORIDOC ';
    strSQL := strSQL + '    AND FIS_FORCLI = G.GER_CODCLI ';
    strSQL := strSQL + '    AND FIS_TIP_FC = G.GER_TIP_FC) AS CHAVNF ';
  end;

  strSQL := strSQL + 'FROM FATGOR G ';
  strSQL := strSQL + 'INNER JOIN CADEMP E  ON E.EMP_CODEMP = G.FGO_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN CADCID EC ON EC.CID_CODCID = E.EMP_CODCID ';

  strSQL := strSQL + ' LEFT JOIN AUXGOR ON AUX_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + ' LEFT JOIN ENTCLI ON ETC_CODCLI = G.FGO_CODCLI ';
  strSQL := strSQL + '                 AND IF(IFNULL(AUX_ENTGER,"") <> "", ';
  strSQL := strSQL + '                        ENTCLI.AUTOINCREM = AUX_ENTGER, ';
  strSQL := strSQL + '                        FALSE) ';

  strSQL := strSQL + ' LEFT JOIN CADCID CE ON CE.CID_CODCID = ETC_CIDENT ';
  strSQL := strSQL + ' LEFT JOIN CADCLI C  ON C.CLI_CODCLI = G.FGO_CODCLI ';
  strSQL := strSQL + ' LEFT JOIN CADCID CF ON CF.CID_CODCID = C.CLI_CODCID ';
  strSQL := strSQL + ' LEFT JOIN CADCID CC ON CC.CID_CODCID = G.FGO_CIDCON ';

  strSQL := strSQL + 'WHERE G.FGO_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND G.FGO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND G.FGO_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND G.FGO_CODCLI = :CODCLI ';

  if FEspecieDocumento = 'PD' then
    Result := strSQL
  else
  begin
    strSQL := strSQL + ' AND G.GER_TIP_FC = "C" AND G.GER_ORIDOC = "V" ';

    strSQL := strSQL.Replace('FGO_'  , 'GER_');
    strSQL := strSQL.Replace('FATGOR', 'MOVGER');
    strSQL := strSQL.Replace('AUXGOR', 'AUXMOV');

    Result := strSQL + ' UNION ALL ';

    strSQL := strSQL.Replace('MOVGER', 'NOTGER');
    strSQL := strSQL.Replace('AUXMOV', 'AUXNOT');

    Result := Result + strSQL;
  end;
end;

function TCorreiosPrePostagem.GetSqlItensPedido: String;
  var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT FDO_DESCRI AS DESCRI, ';
  strSQL := strSQL + '       SUM(FDO_QTDITE) AS QTDITE, ';
  strSQL := strSQL + '       SUM(FDO_TOTITE) AS TOTITE  ';
  strSQL := strSQL + 'FROM FATDOR ';
  strSQL := strSQL + 'WHERE FDO_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND FDO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND FDO_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND FDO_CODCLI = :CODCLI ';
  strSQL := strSQL + 'GROUP BY FDO_DESCRI';

  Result := strSQL;
end;

function TCorreiosPrePostagem.GetSqlItensDocumento: String;
  var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '       SUM(DET_QTDITE) AS QTDITE, ';
  strSQL := strSQL + '       SUM(DET_TOTITE) AS TOTITE  ';
  strSQL := strSQL + 'FROM MOVDET ';
  strSQL := strSQL + 'WHERE DET_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND DET_CODCLI = :CODCLI ';
  strSQL := strSQL + '  AND DET_TIP_FC = "C" ';
  strSQL := strSQL + '  AND DET_ORIDOC = "V" ';
  strSQL := strSQL + 'GROUP BY DET_DESCRI';

  Result := strSQL;
end;

end.
