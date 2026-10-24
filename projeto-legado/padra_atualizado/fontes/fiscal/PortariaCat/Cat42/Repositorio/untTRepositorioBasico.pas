unit untTRepositorioBasico;

interface

uses Uni,
     Classes,
     SysUtils,
     StrUtils,
     untTParticipante,
     untTProduto,
     untTCentroCusto,
     untTClassificacaoFiscal,
     System.Generics.Defaults,
     System.Generics.Collections;

Type
  TRepositorioBasico = class(TObject)
    private
      FClientes: TObjectList<TCliente>;
      FFornecedores: TObjectList<TFornecedor>;
      FProdutos: TObjectList<TProduto>;
      FListaCentroCusto: TObjectList<TCentroCusto>;
      FGrupos: TObjectList<TGrupo>;
      FParticipantes: TObjectList<TParticipante>;
      FCfops: TObjectList<TClassificacaoFiscal>;

      procedure pOrdenaListaProduto(blnCrescente: Boolean);

      function fRetSqlTodosGrupos(strGrupos: string = ''): string;
      function fRetSqlTodosProdutos(strProdutos: String = ''; blnNaoRetornarProdutoCAT42_Reg0200: Boolean = False): String;
      function fRetSqlTodosClientes(strParticipantes: String = ''): String;
      function fRetSqlTodosFornecedores(strParticipantes: String = ''): String;
      function fRetSqlTodosParticipantes(stlLista: TStringList; strCnpjEmpresaSelecionada: string; blnFiltraPorCodigo: Boolean = False): string;
      function fRetSqlTodosCfops: string;

      function fRetornaCodigosParticipantes(stlLista: TStringList; strPrefixo: String; blnCortaPrefixo: Boolean): string;
      function fRetornaCodigosParticipantesCli(stlLista: TStringList; strPrefixo: String; blnCortaPrefixo: Boolean): string;
      function fRetornaCodigosParticipantesFor(stlLista: TStringList; strPrefixo: String; blnCortaPrefixo: Boolean): string;
    public
      function fRetTodosGrupos(stlGrupos: TStringList): TObjectList<TGrupo>;
      function fRetTodosProdutos(strCodEmp: String): TObjectList<TProduto>; overload;
      function fRetTodosProdutos(strCodEmp: String; stlProdutos: TStringList; blnNaoRetornarProdutoCAT42_Reg0200: Boolean = False): TObjectList<TProduto>; overload;
      function fRetTodosClientes(dtaIni, dtaFin: TDateTime): TObjectList<TCliente>; overload;
      function fRetTodosClientes(stlClientes: TStringList): TObjectList<TCliente>; overload;
      function fRetTodosFornecedores(dtaIni, dtaFin: TDateTime): TObjectList<TFornecedor>; overload;
      function fRetTodosFornecedores(stlFornecedores: TStringList): TObjectList<TFornecedor>; overload;
      function fRetTodosCentroCusto: TObjectList<TCentroCusto>;
      function fRetTodosParticipantes(stlParticipantes: TStringList; strCnpjEmpresaSelecionada: string; blnFiltraPorCodigo: Boolean = False): TObjectList<TParticipante>;
      function fRetTodasClassificacoesFiscais(stlCfops: TStringList): TObjectList<TClassificacaoFiscal>;

      constructor Create;
      destructor Destroy; override;
  end;

  Const
  strCnpjInvalido = '00000000000000_11111111111111_22222222222222_33333333333333_' +
                    '44444444444444_55555555555555_66666666666666_77777777777777_' +
                    '88888888888888_99999999999999';

implementation

uses untFuncoes;

{ TRepositorioBasico }

constructor TRepositorioBasico.Create;
begin
  inherited;
  FListaCentroCusto := TObjectList<TCentroCusto>.Create;
  FClientes := TObjectList<TCliente>.Create;
  FFornecedores := TObjectList<TFornecedor>.Create;
  FProdutos := TObjectList<TProduto>.Create;
  FGrupos := TObjectList<TGrupo>.Create;
  FParticipantes := TObjectList<TParticipante>.Create;
  FCfops := TObjectList<TClassificacaoFiscal>.Create;
end;

destructor TRepositorioBasico.Destroy;
begin
  FCfops.Free;
  FListaCentroCusto.Free;
  FClientes.Free;
  FFornecedores.Free;
  FProdutos.Free;
  FGrupos.Free;
  FParticipantes.Free;
  inherited;
end;

function TRepositorioBasico.fRetSqlTodosCfops: string;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CFO_CODCFO, ';
  strSQL := strSQL + '  CFO_DESCR1 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCFO ';
  strSQL := strSQL + 'WHERE LOCATE(CFO_CODCFO, :CODCFO) > 0 ';

  Result := strSQL;
end;

function TRepositorioBasico.fRetSqlTodosClientes(strParticipantes: String = ''): String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  CLI_I_E_S_, ';
  strSQL := strSQL + '  CLI_BAIRRO, ';
  strSQL := strSQL + '  CLI_ENDERE, ';
  strSQL := strSQL + '  CLI_ENDNUM, ';
  strSQL := strSQL + '  CLI_DTACAD, ';
  strSQL := strSQL + '  CLI_CONCON, ';
  strSQL := strSQL + '  CLI_ENDNUM, ';
  strSQL := strSQL + '  CLI_CODCID, ';
  strSQL := strSQL + '  CLI_C_E_P_, ';
  strSQL := strSQL + '  CLI_FONE01, ';
  strSQL := strSQL + '  CLI_I_M_P_, ';
  strSQL := strSQL + '  CLI_ORGPUB, ';

  if fCampoExiste('CADCLI', 'CLI_CONRED') then
    strSQL := strSQL + '  CLI_CONRED, '
  else
    strSQL := strSQL + '  "" AS CLI_CONRED, ';

  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_COIBGE, ';
  strSQL := strSQL + '  CID_ESTADO ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = CLI_CODCID ';

  if not fEmptyStr(strParticipantes) then
  begin
    strSQL := strSQL + 'WHERE LOCATE(CLI_CODCLI, "' + strParticipantes + '") > 0 ';

    strSQL := strSQL + ' GROUP BY CLI_CODCLI ';
    strSQL := strSQL + ' ORDER BY CLI_CODCLI ';
  end
  else
    strSQL := strSQL + ' WHERE CLI_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;
end;

function TRepositorioBasico.fRetSqlTodosFornecedores(strParticipantes: String = ''): String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  FOR_C_G_C_, ';
  strSQL := strSQL + '  FOR_I_E_S_, ';
  strSQL := strSQL + '  FOR_BAIRRO, ';
  strSQL := strSQL + '  FOR_ENDERE, ';
  strSQL := strSQL + '  FOR_ENDNUM, ';
  strSQL := strSQL + '  FOR_DTACAD, ';
  strSQL := strSQL + '  FOR_CONCON, ';
  strSQL := strSQL + '  FOR_ENDNUM, ';
  strSQL := strSQL + '  FOR_CODCID, ';
  strSQL := strSQL + '  FOR_C_E_P_, ';
  strSQL := strSQL + '  FOR_FONE01, ';
  strSQL := strSQL + '  FOR_SIMPAU, ';

  if fCampoExiste('CADFOR', 'FOR_CONRED') then
    strSQL := strSQL + '  FOR_CONRED, '
  else
    strSQL := strSQL + '  "" AS FOR_CONRED, ';

  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_COIBGE, ';
  strSQL := strSQL + '  CID_ESTADO ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = FOR_CODCID ';

  if not fEmptyStr(strParticipantes) then
  begin
    strSQL := strSQL + 'WHERE LOCATE(FOR_CODFOR, "' + strParticipantes + '") > 0';

    strSQL := strSQL + ' GROUP BY FOR_CODFOR ';
    strSQL := strSQL + ' ORDER BY FOR_CODFOR ';
  end
  else
    strSQL := strSQL + ' WHERE FOR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;
end;

function TRepositorioBasico.fRetSqlTodosGrupos(strGrupos: string): string;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GRU_CODGRU, ';
  strSQL := strSQL + '  GRU_DESGRU ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADGRU ';

  if not fEmptyStr(strGrupos) then
  begin
    strSQL := strSQL + 'WHERE LOCATE(GRU_CODGRU, "' + strGrupos + '") > 0 ';

    strSQL := strSQL + ' GROUP BY GRU_CODGRU ';
    strSQL := strSQL + ' ORDER BY GRU_CODGRU ';
  end;

  Result := strSQL;
end;

function TRepositorioBasico.fRetSqlTodosParticipantes(stlLista: TStringList; strCnpjEmpresaSelecionada: string; blnFiltraPorCodigo: Boolean = False): string;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_CODCLI AS CODIGO, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '  CLI_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  IFNULL(CLI_C_G_C_, "") AS CGC, ';
  strSQL := strSQL + '  CLI_I_E_S_ AS IES, ';
  strSQL := strSQL + '  CLI_C_E_P_ AS CEP, ';
  strSQL := strSQL + '  "CADCLI" AS TABELA, ';
  strSQL := strSQL + '  CLI_ENDERE AS ENDERECO, ';
  strSQL := strSQL + '  CLI_ENDNUM AS NUMERO, ';
  strSQL := strSQL + '  CC.CID_COIBGE AS IBGE, ';
  strSQL := strSQL + '  CC.CID_CODPAI AS CODPAIS, ';
  strSQL := strSQL + '  CC.CID_ESTADO AS ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '    ON CC.CID_CODCID = CLI_CODCID ';

  if (blnFiltraPorCodigo) and (strCnpjEmpresaSelecionada <> '') then
    strSQL := strSQL + 'WHERE ( CLI_C_G_C_ = ' + '"' + strCnpjEmpresaSelecionada + '"' + ' OR CLI_CODCLI IN (' + fRetornaCodigosParticipantesCli(stlLista, '', True) + ') ) '
  else
    strSQL := strSQL + 'WHERE CLI_C_G_C_ IN (' + fRetornaCodigosParticipantesCli(stlLista, '', True) + ') ';

  strSQL := strSQL + ' UNION ALL ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_CODFOR AS CODIGO, ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '  FOR_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  FOR_C_G_C_ AS CGC, ';
  strSQL := strSQL + '  FOR_I_E_S_ AS IES, ';
  strSQL := strSQL + '  FOR_C_E_P_ AS CEP, ';
  strSQL := strSQL + '  "CADFOR" AS TABELA, ';
  strSQL := strSQL + '  FOR_ENDERE AS ENDERECO, ';
  strSQL := strSQL + '  FOR_ENDNUM AS NUMERO, ';
  strSQL := strSQL + '  CF.CID_COIBGE AS IBGE, ';
  strSQL := strSQL + '  CF.CID_CODPAI AS CODPAIS, ';
  strSQL := strSQL + '  CF.CID_ESTADO AS ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '    ON CF.CID_CODCID = FOR_CODCID ';

  if (blnFiltraPorCodigo) and (strCnpjEmpresaSelecionada <> '') then
    strSQL := strSQL + 'WHERE ( FOR_C_G_C_ = ' + '"' + strCnpjEmpresaSelecionada + '"' + ' OR FOR_CODFOR IN (' + fRetornaCodigosParticipantesFor(stlLista, '', True) + ') )'
  else
    strSQL := strSQL + 'WHERE FOR_C_G_C_ IN (' + fRetornaCodigosParticipantesFor(stlLista, '', True) + ') ';

  strSQL := strSQL + ' UNION ALL ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CON_CODCON AS CODIGO, ';
  strSQL := strSQL + '  CON_NOMCON AS NOME, ';
  strSQL := strSQL + '  CON_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  CON_C_P_F_ AS CGC, ';
  strSQL := strSQL + '  "" AS IES, ';
  strSQL := strSQL + '  CON_C_E_P_ AS CEP, ';
  strSQL := strSQL + '  "CLICON" AS TABELA, ';
  strSQL := strSQL + '  CON_ENDERE AS ENDERECO, ';
  strSQL := strSQL + '  0 AS NUMERO, ';
  strSQL := strSQL + '  CON.CID_COIBGE AS IBGE, ';
  strSQL := strSQL + '  CON.CID_CODPAI AS CODPAIS, ';
  strSQL := strSQL + '  CON.CID_ESTADO AS ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CLICON ';

  strSQL := strSQL + '  LEFT JOIN CADCID CON ';
  strSQL := strSQL + '    ON CON.CID_CODCID = CON_CODCID ';

  if (blnFiltraPorCodigo) and (strCnpjEmpresaSelecionada <> '') then
    strSQL := strSQL + 'WHERE ( CON_C_P_F_ = ' + '"' + strCnpjEmpresaSelecionada + '"' + ' OR CON_CODCON IN (' + fRetornaCodigosParticipantes(stlLista, '', True) + ') )'
  else
    strSQL := strSQL + 'WHERE CON_C_P_F_ IN (' + fRetornaCodigosParticipantes(stlLista, '', True) + ') ';

  strSQL := 'SELECT * FROM (' + strSQL + ') AS TAB ';

  strSQL := strSQL + ' GROUP BY CGC ';

  Result := strSQL;
end;

function TRepositorioBasico.fRetSqlTodosProdutos(strProdutos: String = ''; blnNaoRetornarProdutoCAT42_Reg0200: Boolean = False): String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  I.ITE_CODUNI AS CODUNI, ';
  strSQL := strSQL + '  I.ITE_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
  strSQL := strSQL + '  I.ITE_CDCEST AS CDCEST, ';

  strSQL := strSQL + '  G.ITE_IPISAI AS IPISAI, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '  G.ITE_TIPPRO AS TIPPRO, ';

  strSQL := strSQL + '  GRU_CODGRU, ';
  strSQL := strSQL + '  GRU_DESGRU, ';

  strSQL := strSQL + '  UNI_DESUNI, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';

  strSQL := strSQL + '  I.ITE_CODBAR ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';

  strSQL := strSQL + '  INNER JOIN ITEGER G ';
  strSQL := strSQL + '   ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   AND G.ITE_CODEMP = :CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADGRU ';
  strSQL := strSQL + '    ON GRU_CODGRU = I.ITE_CODGRU ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ';
  strSQL := strSQL + '    ON I.ITE_CODUNI = UNI_CODUNI ';

  if not fEmptyStr(strProdutos) then
  begin
    strSQL := strSQL + 'WHERE LOCATE(I.ITE_CODITE, "' + strProdutos + '") > 0 ';

    strSQL := strSQL + ' GROUP BY I.ITE_CODITE ';
    strSQL := strSQL + ' ORDER BY I.ITE_CODITE ';
  end
  else
  begin
    if blnNaoRetornarProdutoCAT42_Reg0200 then
    begin
      strProdutos:= '""';
      strSQL := strSQL + 'WHERE I.ITE_CODITE IN (' + strProdutos + ') ';
    end;
  end;

  Result := strSQL;
end;

function TRepositorioBasico.fRetTodosClientes(dtaIni, dtaFin: TDateTime): TObjectList<TCliente>;
  var
    strClienteAnterior: string;
    qryCliente: TUniQuery;
    cliente: TCliente;
begin
  Result := FClientes;
  strClienteAnterior := '';

  qryCliente := fCriaQuery(Nil);
  Try
    qryCliente.Close;
    qryCliente.SQL.Clear;
    qryCliente.SQL.Text := fRetSqlTodosClientes;
    qryCliente.ParamByName('DTAINI').AsDateTime := dtaIni;
    qryCliente.ParamByName('DTAFIN').AsDateTime := dtaFin;
    qryCliente.Open;

    qryCliente.First;
    While Not qryCliente.Eof  Do
    Begin
      if strClienteAnterior <> qryCliente.FieldByName('CLI_CODCLI').AsString then
      begin
        strClienteAnterior := qryCliente.FieldByName('CLI_CODCLI').AsString;

        cliente := TCliente.Create;

        cliente.strCodigo := qryCliente.FieldByName('CLI_CODCLI').AsString;
        cliente.strNome := qryCliente.FieldByName('CLI_NOMCLI').AsString;
        cliente.strCgcCpf := qryCliente.FieldByName('CLI_C_G_C_').AsString;
        cliente.strEndereco := qryCliente.FieldByName('CLI_ENDERE').AsString;
        cliente.strEnderecoNumero := qryCliente.FieldByName('CLI_ENDNUM').AsString;
        cliente.strTelefone := qryCliente.FieldByName('CLI_FONE01').AsString;
        cliente.dtaDataCadastro := qryCliente.FieldByName('CLI_DTACAD').AsDateTime;
        cliente.strBairro := qryCliente.FieldByName('CLI_BAIRRO').AsString;
        cliente.strMunicipio := qryCliente.FieldByName('CID_NOMCID').AsString;
        cliente.strCep := qryCliente.FieldByName('CLI_C_E_P_').AsString;
        cliente.strInscricaoEstadual := qryCliente.FieldByName('CLI_I_E_S_').AsString;
        cliente.strInscricaoMunicipalProdutor := qryCliente.FieldByName('CLI_I_M_P_').AsString;
        cliente.strOrgaoPublico := qryCliente.FieldByName('CLI_ORGPUB').AsString;
        cliente.strContaContabil := qryCliente.FieldByName('CLI_CONCON').AsString;
        cliente.strContaReduzida := qryCliente.FieldByName('CLI_CONRED').AsString;
        cliente.cidade.strCodigo := qryCliente.FieldByName('CLI_CODCID').AsString;
        cliente.cidade.strEstado := qryCliente.FieldByName('CID_ESTADO').AsString;
        cliente.cidade.strCodigoIbge := qryCliente.FieldByName('CID_COIBGE').AsString;
        Result.Add(cliente);
      end;

      qryCliente.Next;
    End;
  Finally
    qryCliente.Free;
  End;
end;

function TRepositorioBasico.fRetTodasClassificacoesFiscais(stlCfops: TStringList): TObjectList<TClassificacaoFiscal>;
  var
    cfop: TClassificacaoFiscal;
    qryCfop: TUniQuery;
begin
  FCfops.Clear;
  Result := FCfops;

  qryCfop := fCriaQuery(nil);
  try
    with qryCfop do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSqlTodosCfops;
      ParamByName('CODCFO').AsString := stlCfops.CommaText;
      Open;

      First;
      while not Eof do
      begin
        cfop := TClassificacaoFiscal.Create;

        cfop.strCodigo := FieldByName('CFO_CODCFO').AsString;
        cfop.strDescricao := FieldByName('CFO_DESCR1').AsString;

        Result.Add(cfop);

        Next;
      end;
    end;

  finally
    qryCfop.Free;
  end;
end;

function TRepositorioBasico.fRetTodosCentroCusto: TObjectList<TCentroCusto>;
begin
  Result := FListaCentroCusto;
end;

function TRepositorioBasico.fRetTodosClientes(stlClientes: TStringList): TObjectList<TCliente>;
  var
    strClienteAnterior: string;
    qryCliente: TUniQuery;
    cliente: TCliente;
begin
  Result := FClientes;
  strClienteAnterior := '';

  qryCliente := fCriaQuery(nil);
  try
    qryCliente.Close;
    qryCliente.SQL.Clear;
    qryCliente.SQL.Text := fRetSqlTodosClientes(stlClientes.CommaText);
    qryCliente.Open;

    qryCliente.First;
    while not qryCliente.Eof  do
    begin
      if strClienteAnterior <> qryCliente.FieldByName('CLI_CODCLI').AsString then
      begin
        strClienteAnterior := qryCliente.FieldByName('CLI_CODCLI').AsString;

        cliente := TCliente.Create;

        cliente.strCodigo := qryCliente.FieldByName('CLI_CODCLI').AsString;
        cliente.strNome := qryCliente.FieldByName('CLI_NOMCLI').AsString;
        cliente.strCgcCpf := qryCliente.FieldByName('CLI_C_G_C_').AsString;
        cliente.strEndereco := qryCliente.FieldByName('CLI_ENDERE').AsString;
        cliente.strEnderecoNumero := qryCliente.FieldByName('CLI_ENDNUM').AsString;
        cliente.strTelefone := qryCliente.FieldByName('CLI_FONE01').AsString;
        cliente.dtaDataCadastro := qryCliente.FieldByName('CLI_DTACAD').AsDateTime;
        cliente.strBairro := qryCliente.FieldByName('CLI_BAIRRO').AsString;
        cliente.strMunicipio := qryCliente.FieldByName('CID_NOMCID').AsString;
        cliente.strCep := qryCliente.FieldByName('CLI_C_E_P_').AsString;
        cliente.strInscricaoEstadual := qryCliente.FieldByName('CLI_I_E_S_').AsString;
        cliente.strInscricaoMunicipalProdutor := qryCliente.FieldByName('CLI_I_M_P_').AsString;
        cliente.strOrgaoPublico := qryCliente.FieldByName('CLI_ORGPUB').AsString;
        cliente.strContaContabil := qryCliente.FieldByName('CLI_CONCON').AsString;
        cliente.strContaReduzida := qryCliente.FieldByName('CLI_CONRED').AsString;
        cliente.cidade.strCodigo := qryCliente.FieldByName('CLI_CODCID').AsString;
        cliente.cidade.strEstado := qryCliente.FieldByName('CID_ESTADO').AsString;
        cliente.cidade.strCodigoIbge := qryCliente.FieldByName('CID_COIBGE').AsString;
        Result.Add(cliente);
      end;

      qryCliente.Next;
    end;
  finally
    qryCliente.Free;
  end;
end;

function TRepositorioBasico.fRetTodosFornecedores(stlFornecedores: TStringList): TObjectList<TFornecedor>;
  var
    strFornecedorAnterior: string;
    qryFornecedor: TUniQuery;
    fornecedor: TFornecedor;
begin
  Result := FFornecedores;

  qryFornecedor := fCriaQuery(Nil);
  Try
    qryFornecedor.Close;
    qryFornecedor.SQL.Clear;
    qryFornecedor.SQL.Text := fRetSqlTodosFornecedores(stlFornecedores.CommaText);
    qryFornecedor.Open;

    qryFornecedor.First;
    While Not qryFornecedor.Eof Do
    Begin
      if strFornecedorAnterior <> qryFornecedor.FieldByName('FOR_CODFOR').AsString then
      begin
        strFornecedorAnterior := qryFornecedor.FieldByName('FOR_CODFOR').AsString;

        fornecedor := TFornecedor.Create;

        fornecedor.strCodigo := qryFornecedor.FieldByName('FOR_CODFOR').AsString;
        fornecedor.strNome := qryFornecedor.FieldByName('FOR_NOMFOR').AsString;
        fornecedor.strCgcCpf := qryFornecedor.FieldByName('FOR_C_G_C_').AsString;
        fornecedor.strEndereco := qryFornecedor.FieldByName('FOR_ENDERE').AsString;
        fornecedor.strEnderecoNumero := qryFornecedor.FieldByName('FOR_ENDNUM').AsString;
        fornecedor.strTelefone := qryFornecedor.FieldByName('FOR_FONE01').AsString;
        fornecedor.dtaDataCadastro := qryFornecedor.FieldByName('FOR_DTACAD').AsDateTime;
        fornecedor.strBairro := qryFornecedor.FieldByName('FOR_BAIRRO').AsString;
        fornecedor.strMunicipio := qryFornecedor.FieldByName('CID_NOMCID').AsString;
        fornecedor.strCep := qryFornecedor.FieldByName('FOR_C_E_P_').AsString;
        fornecedor.strInscricaoEstadual := qryFornecedor.FieldByName('FOR_I_E_S_').AsString;
        fornecedor.strSimplesNacional := qryFornecedor.FieldByName('FOR_SIMPAU').AsString;
        fornecedor.strContaContabil := qryFornecedor.FieldByName('FOR_CONCON').AsString;
        fornecedor.strContaReduzida := qryFornecedor.FieldByName('FOR_CONRED').AsString;
        fornecedor.cidade.strCodigo := qryFornecedor.FieldByName('FOR_CODCID').AsString;
        fornecedor.cidade.strEstado := qryFornecedor.FieldByName('CID_ESTADO').AsString;
        fornecedor.cidade.strCodigoIbge := qryFornecedor.FieldByName('CID_COIBGE').AsString;

        Result.Add(fornecedor);
      end;

      qryFornecedor.Next;
    End;
  Finally
    qryFornecedor.Free;
  End;
end;

function TRepositorioBasico.fRetTodosGrupos(stlGrupos: TStringList): TObjectList<TGrupo>;
  var
    grupo: TGrupo;
    qryAux: TUniQuery;
begin
  Result := FGrupos;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSqlTodosGrupos(stlGrupos.CommaText);
      Open;

      while not Eof do
      begin
        grupo := TGrupo.Create;
        grupo.strCodigo := FieldByName('GRU_CODGRU').AsString;
        grupo.strDescricao := FieldByName('GRU_DESGRU').AsString;

        Result.Add(grupo);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioBasico.fRetornaCodigosParticipantes(stlLista: TStringList; strPrefixo: String; blnCortaPrefixo: Boolean): string;
  var
    intContador: Integer;
    strLinha: String;
    strOpcao: String;
begin
  strOpcao := '';

  If stlLista.Count = 0 Then
  Begin
    Result := '""';
    Exit;
  End;

  Result := '';
  For intContador := 0 To stlLista.Count -1 Do
  Begin
    If Pos(RightStr(stlLista[intContador], 1), 'C_F_') > 0 Then
      strLinha := LeftStr(stlLista[intContador], Length(stlLista[intContador]) -1)
    Else
      strLinha := stlLista[intContador];

    If Length(strLinha) > 11 Then
      strOpcao := '2'
    Else
      strOpcao := '1';

    If (fEmptyStr(strPrefixo)) Then
    Begin
      If (Pos(strLinha, 'C_F') <= 0) And
         (Pos(strLinha, strCnpjInvalido) <= 0) Then
      Begin
        Result := Result + '"' + strLinha + '"';
        Result := Result + ',';
      End;
    End
    Else If (AnsiStartsText(strPrefixo, strLinha)) Then
    Begin
      If blnCortaPrefixo Then
        Result := Result + '"' + RightStr(strLinha, Length(strLinha)-Length(strPrefixo)) + '"'
      Else
        Result := Result + '"' + strLinha + '"';

      Result := Result + ',';
    End;
  End;

  If AnsiEndsText(',', Result) Then
  Begin
    Result := LeftStr(Result, Length(Result)-1);
  End
  Else If fEmptyStr(Result) Then
  Begin
    Result := '""';
  End;

end;

function TRepositorioBasico.fRetornaCodigosParticipantesCli(stlLista: TStringList; strPrefixo: String; blnCortaPrefixo: Boolean): string;
  var
    intContador: Integer;
    strLinha: String;
    strOpcao: String;
begin
  strOpcao := '';

  If stlLista.Count = 0 Then
  Begin
    Result := '""';
    Exit;
  End;

  Result := '';
  For intContador := 0 To stlLista.Count -1 Do
  Begin
    If Pos(RightStr(stlLista[intContador], 1), 'C_') > 0 Then
      strLinha := stlLista[intContador];

    If Length(strLinha) > 11 Then
      strOpcao := '2'
    Else
      strOpcao := '1';

    If (fEmptyStr(strPrefixo)) Then
    Begin
      if RightStr(strLinha, 1) = 'C' then
      begin
        If (Pos(strLinha, strCnpjInvalido) <= 0) Then
        Begin
          Result := Result + '"' + Copy(strLinha, 0, Length(strLinha)-1) + '"';
          Result := Result + ',';
        End;
      end;
    End
    Else If (AnsiStartsText(strPrefixo, strLinha)) Then
    Begin
      If blnCortaPrefixo Then
        Result := Result + '"' + RightStr(Copy(strLinha, 0, Length(strLinha)-1), Length(strLinha)-Length(strPrefixo)) + '"'
      Else
        Result := Result + '"' + Copy(strLinha, 0, Length(strLinha)-1) + '"';

      Result := Result + ',';
    End;
  End;

  If AnsiEndsText(',', Result) Then
  Begin
    Result := LeftStr(Result, Length(Result)-1);
  End
  Else If fEmptyStr(Result) Then
  Begin
    Result := '""';
  End;

end;

function TRepositorioBasico.fRetornaCodigosParticipantesFor(stlLista: TStringList; strPrefixo: String; blnCortaPrefixo: Boolean): string;
  var
    intContador: Integer;
    strLinha: String;
    strOpcao: String;
begin
  strOpcao := '';

  If stlLista.Count = 0 Then
  Begin
    Result := '""';
    Exit;
  End;

  Result := '';
  For intContador := 0 To stlLista.Count -1 Do
  Begin
    If Pos(RightStr(stlLista[intContador], 1), 'F_') > 0 Then
      strLinha := stlLista[intContador];

    If Length(strLinha) > 11 Then
      strOpcao := '2'
    Else
      strOpcao := '1';

    If (fEmptyStr(strPrefixo)) Then
    Begin
      if RightStr(strLinha, 1) = 'F' then
      begin
        If (Pos(strLinha, strCnpjInvalido) <= 0) Then
        Begin
          Result := Result + '"' + Copy(strLinha, 0, Length(strLinha)-1) + '"';
          Result := Result + ',';
        End;
      end;
    End
    Else If (AnsiStartsText(strPrefixo, strLinha)) Then
    Begin
      If blnCortaPrefixo Then
        Result := Result + '"' + RightStr(Copy(strLinha, 0, Length(strLinha)-1), Length(strLinha)-Length(strPrefixo)) + '"'
      Else
        Result := Result + '"' + Copy(strLinha, 0, Length(strLinha)-1) + '"';

      Result := Result + ',';
    End;
  End;

  If AnsiEndsText(',', Result) Then
  Begin
    Result := LeftStr(Result, Length(Result)-1);
  End
  Else If fEmptyStr(Result) Then
  Begin
    Result := '""';
  End;

end;

function TRepositorioBasico.fRetTodosParticipantes(stlParticipantes: TStringList; strCnpjEmpresaSelecionada: string; blnFiltraPorCodigo: Boolean = False): TObjectList<TParticipante>;
  var
    qryPart: TUniQuery;
    participante: TParticipante;
begin
  FParticipantes.Clear;
  Result := FParticipantes;

  qryPart := fCriaQuery(nil);
  try
    with qryPart do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSqlTodosParticipantes(stlParticipantes, strCnpjEmpresaSelecionada, blnFiltraPorCodigo);
      Open;

      First;
      while Not Eof  do
      begin
        participante := TParticipante.Create;

        //# participante.strCodigo := FieldByName('CODIGO').AsString;
        participante.strCodigo := FieldByName('CGC').AsString;
        participante.strNome := FieldByName('NOME').AsString;
        participante.strBairro := FieldByName('BAIRRO').AsString;
        participante.strCgcCpf := FieldByName('CGC').AsString;
        participante.intCgcCpfInt := StrToInt64Def(FieldByName('CGC').AsString, 0);
        participante.strCep := FieldByName('CEP').AsString;
        participante.strTabela := FieldByName('TABELA').AsString;
        participante.strEndereco := FieldByName('ENDERECO').AsString;
        participante.strEnderecoNumero := FieldByName('NUMERO').AsString;
        participante.strInscricaoEstadual := FieldByName('IES').AsString;
        participante.cidade.strEstado := FieldByName('ESTADO').AsString;
        participante.cidade.strCodigoIbge := FieldByName('IBGE').AsString;
        participante.cidade.strCodPai := FieldByName('CODPAIS').AsString;
        Result.Add(participante);

        Next;
      end;
    end;
  finally
    qryPart.Free;
  end;
end;

function TRepositorioBasico.fRetTodosProdutos(strCodEmp: String; stlProdutos: TStringList; blnNaoRetornarProdutoCAT42_Reg0200: Boolean = False): TObjectList<TProduto>;
  Var
    qryProdutos: TUniQuery;
    Produto: TProduto;
begin
  Result := FProdutos;

  qryProdutos := fCriaQuery(Nil);
  Try
    qryProdutos.Close;
    qryProdutos.SQL.Clear;
    qryProdutos.SQL.Text := fRetSqlTodosProdutos(stlProdutos.CommaText, blnNaoRetornarProdutoCAT42_Reg0200);
    qryProdutos.ParamByName('CODEMP').AsString := strCodEmp;
    qryProdutos.Open;

    qryProdutos.First;
    While Not qryProdutos.Eof Do
    Begin
      Produto := TProduto.Create;
      Produto.strCodItem := qryProdutos.FieldByName('CODITE').AsString;
      Produto.strCodFabricaItemForn := '';
      Produto.fltQuantidade := 0;
      Produto.blnProdutoProduzido := false;
      Produto.strDescricaoItem := qryProdutos.FieldByName('DESITE').AsString;
      Produto.strReferencia := qryProdutos.FieldByName('REFERE').AsString;
      Produto.strCodigoUnidade := qryProdutos.FieldByName('CODUNI').AsString;
      Produto.dtaDataCadastro := qryProdutos.FieldByName('DTACAD').AsDateTime;
      Produto.strCodigoNCM := qryProdutos.FieldByName('CLAIPI').AsString;
      Produto.strcodBarra := qryProdutos.FieldByName('ITE_CODBAR').AsString;
      Produto.strCodigoCEST := qryProdutos.FieldByName('CDCEST').AsString;
      Produto.strGenero := qryProdutos.FieldByName('TIPPRO').AsString;

      If qryProdutos.FindField('COSTDE') <> nil Then
        Produto.strCodigoSituacaoTributaria := qryProdutos.FieldByName('COSTDE').AsString;

      If qryProdutos.FindField('PERBAS') <> nil Then
        Produto.fltBaseICMS := qryProdutos.FieldByName('PERBAS').AsFloat;

      If qryProdutos.FindField('PBASST') <> nil Then
        Produto.fltBaseICMS_ST := qryProdutos.FieldByName('PBASST').AsFloat;

      Produto.fltAliquotaIPI := qryProdutos.FieldByName('IPISAI').AsFloat;
      Produto.fltPrecoCusto := qryProdutos.FieldByName('PRECUS').AsFloat;
      Produto.fltSaldo := qryProdutos.FieldByName('SALDOS').AsFloat;
      Produto.grupo.strCodigo := qryProdutos.FieldByName('GRU_CODGRU').AsString;
      Produto.grupo.strDescricao := qryProdutos.FieldByName('GRU_DESGRU').AsString;
      Produto.unidade.strDescricao := qryProdutos.FieldByName('UNI_DESUNI').AsString;
      Produto.unidade.strSigla := qryProdutos.FieldByName('UNI_SIGUNI').AsString;

      Result.Add(Produto);

      qryProdutos.Next;
    end;
  finally
    qryProdutos.Free;
  end;

  pOrdenaListaProduto(True);
end;

function TRepositorioBasico.fRetTodosFornecedores(dtaIni, dtaFin: TDateTime): TObjectList<TFornecedor>;
  Var
    strFornecedorAnterior: string;
    qryFornecedor: TUniQuery;
    Fornecedor: TFornecedor;
begin
  Result := FFornecedores;

  qryFornecedor := fCriaQuery(Nil);
  Try
    qryFornecedor.Close;
    qryFornecedor.SQL.Clear;
    qryFornecedor.SQL.Text := fRetSqlTodosFornecedores;
    qryFornecedor.ParamByName('DTAINI').AsDateTime := dtaIni;
    qryFornecedor.ParamByName('DTAFIN').AsDateTime := dtaFin;
    qryFornecedor.Open;

    qryFornecedor.First;
    While Not qryFornecedor.Eof Do
    Begin
      if strFornecedorAnterior <> qryFornecedor.FieldByName('FOR_CODFOR').AsString then
      begin
        strFornecedorAnterior := qryFornecedor.FieldByName('FOR_CODFOR').AsString;

        fornecedor := TFornecedor.Create;

        fornecedor.strCodigo := qryFornecedor.FieldByName('FOR_CODFOR').AsString;
        fornecedor.strNome := qryFornecedor.FieldByName('FOR_NOMFOR').AsString;
        fornecedor.strCgcCpf := qryFornecedor.FieldByName('FOR_C_G_C_').AsString;
        fornecedor.strEndereco := qryFornecedor.FieldByName('FOR_ENDERE').AsString;
        fornecedor.strEnderecoNumero := qryFornecedor.FieldByName('FOR_ENDNUM').AsString;
        fornecedor.strTelefone := qryFornecedor.FieldByName('FOR_FONE01').AsString;
        fornecedor.dtaDataCadastro := qryFornecedor.FieldByName('FOR_DTACAD').AsDateTime;
        fornecedor.strBairro := qryFornecedor.FieldByName('FOR_BAIRRO').AsString;
        fornecedor.strMunicipio := qryFornecedor.FieldByName('CID_NOMCID').AsString;
        fornecedor.strCep := qryFornecedor.FieldByName('FOR_C_E_P_').AsString;
        fornecedor.strInscricaoEstadual := qryFornecedor.FieldByName('FOR_I_E_S_').AsString;
        fornecedor.strSimplesNacional := qryFornecedor.FieldByName('FOR_SIMPAU').AsString;
        fornecedor.strContaContabil := qryFornecedor.FieldByName('FOR_CONCON').AsString;
        fornecedor.strContaReduzida := qryFornecedor.FieldByName('FOR_CONRED').AsString;
        fornecedor.cidade.strCodigo := qryFornecedor.FieldByName('FOR_CODCID').AsString;
        fornecedor.cidade.strEstado := qryFornecedor.FieldByName('CID_ESTADO').AsString;
        fornecedor.cidade.strCodigoIbge := qryFornecedor.FieldByName('CID_COIBGE').AsString;

        Result.Add(fornecedor);
      end;

      qryFornecedor.Next;
    End;
  Finally
    qryFornecedor.Free;
  End;
end;

function TRepositorioBasico.fRetTodosProdutos(strCodEmp: String): TObjectList<TProduto>;
  Var
    qryProdutos: TUniQuery;
    Produto: TProduto;
begin
  Result := FProdutos;

  qryProdutos := fCriaQuery(Nil);
  Try
    qryProdutos.Close;
    qryProdutos.SQL.Clear;
    qryProdutos.SQL.Text := fRetSqlTodosProdutos;
    qryProdutos.ParamByName('CODEMP').AsString := strCodEmp;
    qryProdutos.Open;

    qryProdutos.First;
    While Not qryProdutos.Eof Do
    Begin
      Produto := TProduto.Create;
      Produto.strCodItem := qryProdutos.FieldByName('CODITE').AsString;
      Produto.strCodFabricaItemForn := '';
      Produto.fltQuantidade := 0;
      Produto.blnProdutoProduzido := false;
      Produto.strDescricaoItem := qryProdutos.FieldByName('DESITE').AsString;
      Produto.strReferencia := qryProdutos.FieldByName('REFERE').AsString;
      Produto.strCodigoUnidade := qryProdutos.FieldByName('CODUNI').AsString;
      Produto.dtaDataCadastro := qryProdutos.FieldByName('DTACAD').AsDateTime;
      Produto.strCodigoNCM := qryProdutos.FieldByName('CLAIPI').AsString;

      If qryProdutos.FindField('COSTDE') <> nil Then
        Produto.strCodigoSituacaoTributaria := qryProdutos.FieldByName('COSTDE').AsString;

      If qryProdutos.FindField('PERBAS') <> nil Then
        Produto.fltBaseICMS := qryProdutos.FieldByName('PERBAS').AsFloat;

      If qryProdutos.FindField('PBASST') <> nil Then
        Produto.fltBaseICMS_ST := qryProdutos.FieldByName('PBASST').AsFloat;

      Produto.fltAliquotaIPI := qryProdutos.FieldByName('IPISAI').AsFloat;
      Produto.fltPrecoCusto := qryProdutos.FieldByName('PRECUS').AsFloat;
      Produto.fltSaldo := qryProdutos.FieldByName('SALDOS').AsFloat;

      Result.Add(Produto);

      qryProdutos.Next;
    End;
  Finally
    qryProdutos.Free;
  End;

  pOrdenaListaProduto(True);
end;

procedure TRepositorioBasico.pOrdenaListaProduto(blnCrescente: Boolean);
  Var
    criterioComparacao: TComparison<TProduto>;
    comparador: IComparer<TProduto>;
begin
  criterioComparacao := function(const Left: TProduto; const Right: TProduto): Integer
  begin
    If Left.strCodItem = Right.strCodItem Then
    Begin
      Result := 0;
    End
    Else If Left.strCodItem > Right.strCodItem Then
    Begin
      Result := IIF(blnCrescente, 1, -1);
    End
    Else
    Begin
      Result := IIF(blnCrescente, -1, 1);
    End;

  End;
  comparador := TComparer<TProduto>.Construct(criterioComparacao);
end;

end.
