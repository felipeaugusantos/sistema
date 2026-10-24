unit untCFOPRegrasDeTributacaoEstado;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPRegrasDeTributacaoEstado = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function RetornaClassificacaoSubstituido: String;
    function RetornaClassificacaoTributada: String;
    function EhSubstitutoNaOperacaoComImportacaoDireta: boolean;
    function EhImportacaoDireta: Boolean;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Constantes, Shared.Functions.Funcoes.Faturamento, System.SysUtils;

{ TCFOPRegrasDeTributacaoEstado }

constructor TCFOPRegrasDeTributacaoEstado.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPRegrasDeTributacaoEstado.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;

  If FInputDefine.EhOperacaoDeVendaInternaDeProdutosDoDecretoDoCeara Then
  Begin
    Result.Classificacao := FInputDefine.ClassificacaoDeVendaInternaDeProdutosDoDecretoDoCeara;
    Exit;
  End;

  If FInputDefine.ItemSubstituido Then
    Result.Classificacao := RetornaClassificacaoSubstituido
  Else
    Result.Classificacao := RetornaClassificacaoTributada
end;

function TCFOPRegrasDeTributacaoEstado.RetornaClassificacaoSubstituido: String;
begin
  {******************************************************************************}
  {* SUBSTITUÍDO: CLIENTE ZONA FRANCA/CLIENTE ZONA FRANCA COM DESCONTO ESPECIAL *}
  {***************************************************************************BZ*}
  If (FConfiguracoes.fGetValorConfiguracao(CFG_QUANDO_VENDER_PARA_CLIENTE_ZONA_FRANCA_DE_MANAUS_ONDE_O_PRODUTO_E_SUBSTITUIDO_USAR_CFOP_X109_OU_X110, varString) = 'S') And
     ((FInputDefine.ClienteZonaFranca) Or (FInputDefine.ClienteZonaFrancaComDescontoEspecial)) Then
  Begin
    If (TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda)) Then
      Result := FInputOutputClassificacao.PrefixoClassificacao + '109'
    Else
      Result := FInputOutputClassificacao.PrefixoClassificacao + '110';
  End
  {*****************************************}
  {* SUBSTITUÍDO: COMBUSTÍVEL/LUBRIFICANTE *}
  {**************************************MV*}
  Else If FInputDefine.CombustivelLubrificanteDoItem Then
  Begin
    If (Not FInputDefine.ClienteConsumidorFinal) Then
      Result := FInputOutputClassificacao.PrefixoClassificacao + '655'
    Else
      Result := FInputOutputClassificacao.PrefixoClassificacao + '656';
  End
  {*****************************************}
  {* SUBSTITUÍDO NORMAL: NÃO CONSUMIDOR.   *}
  {**************************************MV*}
  Else If (Not FInputDefine.ClienteConsumidorFinal) Then
  Begin

    {*****************************************}
    {* CONTRIBUINTE DE IPI É SEMPRE X401.    *}
    {**************************************MV*}
    If (FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varString) = 'S') Then
    Begin
      If TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda) Then
        Result := FInputOutputClassificacao.PrefixoClassificacao + '401'
      Else
      Begin
        {*******************************************************}
        {* IMPORTACAO DIRETA OU REVENDA DE PRODUTOS IMPORTADOS  }
        {*******************************************************}
        If (EhSubstitutoNaOperacaoComImportacaoDireta) Then
        Begin
          If (Not (FInputDefine.ClienteInscricaoEstadual = EmptyStr)) Or (FInputDefine.ClienteMicroEmpreendedor) Then
            Result := FInputOutputClassificacao.PrefixoClassificacao + '403'

          Else If (FInputDefine.DentroDoEstadoCFOP) Then
          Begin
            If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS) = EmptyStr) Then
              Result := FInputOutputClassificacao.PrefixoClassificacao + '405'
            Else
              Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS);
          End

          Else
            Result := FInputOutputClassificacao.PrefixoClassificacao + '404';
        End
        Else
        Begin
          If (FInputDefine.DentroDoEstadoCFOP) Then
            Result := FInputOutputClassificacao.PrefixoClassificacao + '405'
          Else
          Begin
            If not (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_CONTRIBUINTE_DE_IPI_QUE_REALIZA_VENDA_FORA_DO_ESTADO_PARA_PRODUTOS_ST_NAO_INDUSTRIALIZADOS_NAO_CONSUMIDOR) = EmptyStr) Then
            Begin
              Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_CONTRIBUINTE_DE_IPI_QUE_REALIZA_VENDA_FORA_DO_ESTADO_PARA_PRODUTOS_ST_NAO_INDUSTRIALIZADOS_NAO_CONSUMIDOR);
            End
            Else If (Not (FInputDefine.ClienteInscricaoEstadual = EmptyStr)) Or (FInputDefine.ClienteMicroEmpreendedor) Then
            Begin
              Result := FInputOutputClassificacao.PrefixoClassificacao + '403';
            End
            Else
            Begin
              Result := FInputOutputClassificacao.PrefixoClassificacao + '404';
            End;
          End;
        End;
      End;
    End
    Else
    Begin
      // DENTRO DO ESTADO
      If (FInputDefine.DentroDoEstadoCFOP) Then
      Begin

        {*******************************************************}
        {* IMPORTACAO DIRETA OU REVENDA DE PRODUTOS IMPORTADOS  }
        {*******************************************************}
        If (EhSubstitutoNaOperacaoComImportacaoDireta) Then
        Begin
          If (Not (FInputDefine.ClienteInscricaoEstadual = EmptyStr)) Or (FInputDefine.ClienteMicroEmpreendedor) Then
            Result := FInputOutputClassificacao.PrefixoClassificacao + '403'
          Else
            Result := FInputOutputClassificacao.PrefixoClassificacao + '405';
        End
        Else
        Begin
          If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS) = EmptyStr) Then
            Result := FInputOutputClassificacao.PrefixoClassificacao + '405'
          Else
            Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS);
        End;

      End
      // FORA DO ESTADO
      Else
      Begin
        If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS) = EmptyStr) Then
          Result := FInputOutputClassificacao.PrefixoClassificacao + '403'
        Else
          Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS);
      End;
    End;

  End
  {*****************************************}
  {* SUBSTITUÍDO NORMAL: CONSUMIDOR.       *}
  {**************************************MV*}
  Else
  Begin
    // DENTRO DO ESTADO
    If (FInputDefine.DentroDoEstadoCFOP) Then
    Begin
      If (EhSubstitutoNaOperacaoComImportacaoDireta) Then
      Begin
        If (Not (FInputDefine.ClienteInscricaoEstadual = EmptyStr)) Or (FInputDefine.ClienteMicroEmpreendedor) Then
          Result := FInputOutputClassificacao.PrefixoClassificacao + '403'
        Else
        Begin
          If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS) = EmptyStr)  Then
            Result := FInputOutputClassificacao.PrefixoClassificacao + '405'
          Else
            Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS);
        End
      End
      Else
      Begin
        If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS) = EmptyStr) Then
          Result := FInputOutputClassificacao.PrefixoClassificacao + '405'
        Else
          Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS);
      End;
    End

    // FORA DO ESTADO
    Else
    Begin
      //Cliente contribuinte e não construtura tera cfop X403
      If ((Not (FInputDefine.ClienteInscricaoEstadual = EmptyStr)) Or (FInputDefine.ClienteMicroEmpreendedor)) And (Not FInputDefine.AtividadeConstrutora) Then
      Begin
        If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS_CONSUMIDOR) = EmptyStr) Then
        Begin
          If (FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS) = EmptyStr) Then
            Result := FInputOutputClassificacao.PrefixoClassificacao + '403'
          Else
            Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS);
        End
        Else
          Result := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS_CONSUMIDOR);
      End
      Else
        Result := FInputOutputClassificacao.PrefixoClassificacao + '404';
    End;

    If (FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varString) = 'S') And (TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda)) Then
      Result := FInputOutputClassificacao.PrefixoClassificacao + '401'
  End;
end;

function TCFOPRegrasDeTributacaoEstado.RetornaClassificacaoTributada: String;
begin
  Result := FInputDefine.ClassificacaoFiscalDoItem;

  If not FInputDefine.VendaDeProducao Then
  Begin
    If FInputDefine.CombustivelLubrificanteDoItem And FConfiguracoes.fGetValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, varBoolean) Then
    Begin
      {*****************************************}
      {* TRIBUTADO: COMBUSTÍVEL/LUBRIFICANTE   *}
      {**************************************VA*}
      If Not FInputDefine.ClienteConsumidorFinal Then
        Result := FInputOutputClassificacao.PrefixoClassificacao + '655'
      Else
        Result := FInputOutputClassificacao.PrefixoClassificacao + '656';
    End
    Else
    Begin
      If (TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda)) Then
        Result := FInputOutputClassificacao.PrefixoClassificacao + '101'
      Else
        Result := FInputOutputClassificacao.PrefixoClassificacao + '102';
    End;

    If (FInputDefine.ClienteZonaFranca) Or (FInputDefine.ClienteZonaFrancaComDescontoEspecial) Then
    Begin
      if not FInputDefine.TributaZonaFrancaManaus then
      begin
        If (TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda)) Then
          Result := FInputOutputClassificacao.PrefixoClassificacao + '109'
        Else
          Result := FInputOutputClassificacao.PrefixoClassificacao + '110';
      end;
    End;
  End
end;

function TCFOPRegrasDeTributacaoEstado.EhImportacaoDireta: Boolean;
begin
  Result := False;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varString) = 'N') Then
    Exit;

  If (Not FInputDefine.ImportacaoDiretaDoItem) Then
    Exit;

  Result := True;
end;

function TCFOPRegrasDeTributacaoEstado.EhSubstitutoNaOperacaoComImportacaoDireta: boolean;
begin
  Result := True;

  If ((EhImportacaoDireta) And (FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA) = SUBSTITUTO_TRIBUTARIO)) Then
    Exit;

  If ((EhImportacaoDireta) And (FConfiguracoes.fGetValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, varBoolean))) Then
    Exit;

  Result := False;
end;

end.