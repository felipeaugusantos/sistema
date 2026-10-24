unit untFaturamentoImpostosFuncoes;

interface

uses Faturamento.Impostos.Interfaces.Model, Shared.Functions.DataSet,
  untTypesIPI, Shared.Functions.Types, Shared.Functions.Core,
  Shared.Functions.Utils;

type
  TFaturamentoImpostosFuncoes = class
  public
    class function VendaDentroDoEstado(AEstadoEntrega, AEmpresaEstado: String; AVendaPresencial: Boolean): Boolean;
    class function RetornarTrocaUFEndEntrega(const AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      const ACodigoDaEmpresa, AOpcaoDoDocumento: String; const ADocumentoParaFornecedor: Boolean): String;
    class function RetornarNotaDeImportacao(AClassificacaoFiscalDoItem: String): String;
    class function RetornarClienteAtividade(const AClienteAtividade, ACodigoDaEmpresa: String): IMyCampoTabela;
    class function CarregarDadosIpi(const AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String;
      const AIpiSaidaProduto : Double; const ASituacaoDoIpi : String): TResultadoAbreviacaoIpi;
    class function RetornarResultadoAbreviacaoIpi(const ABaseDeCalculoIPI, AAliquotaDeCalculoIPI: Double): TResultadoAbreviacaoIpi;
    class function RetornarDadosAbreviacaoIpi(const  AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String ): TResultadoAbreviacaoIpi;
    class procedure AdicionarValorChave(const AValor: Variant; var AValorChave: ArrOfVariant);
    class function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
  end;

implementation

uses Shared.Functions.Funcoes.Faturamento, Shared.Functions.Interfaces,
  Shared.Functions.Configuracoes, Shared.Functions.Constantes;

{ TFaturamentoImpostosFuncoes }

class function TFaturamentoImpostosFuncoes.VendaDentroDoEstado(
  AEstadoEntrega, AEmpresaEstado: String; AVendaPresencial: Boolean): Boolean;
Var
  LDentroDoEstado : Boolean;
begin
  LDentroDoEstado :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstado(AEstadoEntrega,
                      AEmpresaEstado);

  Result :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstadoFaturamento(LDentroDoEstado,
                                 AVendaPresencial);
end;

class function TFaturamentoImpostosFuncoes.RetornarTrocaUFEndEntrega(
  const AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
  const ACodigoDaEmpresa, AOpcaoDoDocumento: String; const ADocumentoParaFornecedor: Boolean): String;
Var
  LAtendeRegraFiscalEndEntrega: Boolean;
  LClienteAtividadeBD         : String;
  LAtividadeConstrutora       : Boolean;
begin
  LClienteAtividadeBD :=
    Self.RetornarClienteAtividade(AModelClienteFornecedor.ClienteAtividade,
                                  ACodigoDaEmpresa).FieldByName('ATI_CODATI');

  LAtividadeConstrutora :=
    TFunctionFuncoesFaturamento.
      fAtividadeConstrutora(AModelClienteFornecedor.ClienteAtividade,
                            LClienteAtividadeBD);

  LAtendeRegraFiscalEndEntrega :=
    TFunctionFuncoesFaturamento.
      fAtendeRegraFiscalEndEntrega(AOpcaoDoDocumento,
                                   LAtividadeConstrutora,
                                   ADocumentoParaFornecedor,
                                   AModelClienteFornecedor.ClienteRegraFiscal);

  Result :=
    TFunctionFuncoesFaturamento.
      fTrocaUFEndEntrega(LAtendeRegraFiscalEndEntrega,
                         AModelClienteFornecedor.ClienteEstadoEntrega,
                         AModelClienteFornecedor.ClienteEstado);
end;

class function TFaturamentoImpostosFuncoes.RetornarNotaDeImportacao(
  AClassificacaoFiscalDoItem: String): String;
begin
  If Copy(AClassificacaoFiscalDoItem,1,1) = '3' Then
  Begin
    Result := 'S';
    Exit;
  End;

  Result := 'N';
end;

class function TFaturamentoImpostosFuncoes.RetornarClienteAtividade(const AClienteAtividade, ACodigoDaEmpresa: String): IMyCampoTabela;
begin
  Result := objCore.fCampoTabela(['ATI_CODATI'], 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [AClienteAtividade, ACodigoDaEmpresa], False);
end;

Class function TFaturamentoImpostosFuncoes.CarregarDadosIpi(
  const AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String;
  const AIpiSaidaProduto : Double; const ASituacaoDoIpi : String): TResultadoAbreviacaoIpi;
Var
  LAliquotaDeCalculoIPI : Double;
  LBaseDeCalculoIpi     : Double;
begin
  LAliquotaDeCalculoIPI := 0;
  LBaseDeCalculoIpi     := 0;

  If TFunctionFuncoesFaturamento.ValidarIpiSaida(AEspecieDoDocumento) Then
  Begin
    LAliquotaDeCalculoIPI := AIpiSaidaProduto;
    Result := RetornarResultadoAbreviacaoIpi(LBaseDeCalculoIpi, LAliquotaDeCalculoIPI);
    Exit;
  End;

  If TFunctionFuncoesFaturamento.ValidarSituacaoDoIpi(ASituacaoDoIpi) = Integer(sitTributado) Then
  Begin
    Result := RetornarDadosAbreviacaoIpi(AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa);
    Exit;
  End;

  Result := RetornarResultadoAbreviacaoIpi(LBaseDeCalculoIpi, LAliquotaDeCalculoIPI);
end;

class function TFaturamentoImpostosFuncoes.fClienteConsumidor(strNomCli: String;
  blnCliBal, blnSeguradora: Boolean): Boolean;
begin
  Result := False;

  If Pos('CONSUMIDOR', strNomCli) > 0 Then
    Result := True;

  If blnCliBal Then
  Begin

    If Pos('BALCAO', strNomCli) > 0 Then
      Result := True

    Else If Pos('BALCÃO', strNomCli) > 0 Then
      Result := True;

  End;

  If blnSeguradora And (Pos('SEGURADORA', strNomCli) > 0) Then
    Result := True;
end;

Class function TFaturamentoImpostosFuncoes.RetornarResultadoAbreviacaoIpi(const ABaseDeCalculoIPI, AAliquotaDeCalculoIPI: Double): TResultadoAbreviacaoIpi;
begin
  FillChar(Result, Sizeof(Result), #0);
  Result.BaseDeCalculoIPI := ABaseDeCalculoIpi;
  Result.AliquotaDeCalculoIPI := AAliquotaDeCalculoIPI;
end;

Class function TFaturamentoImpostosFuncoes.RetornarDadosAbreviacaoIpi(const  AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String ): TResultadoAbreviacaoIpi;
  Var
    strSQL : String;
    LAbrevicaoIpi : IMyCampoTabela;

    LValorChave: ArrOfVariant;

    LBaseDeCalculoIPI: String;
    LAliquotaDeCalculoIPI: String;

    LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  strSQL :=
    TFunctionFuncoesFaturamento.
      GetSelectAbreviacaoIpi(AClassificacaoFiscalDoItem);

  SetLength(LValorChave, 0);
  AdicionarValorChave(ACodigoDoProduto, LValorChave);

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI) = UMA_PARA_CADA_EMPRESA Then
    AdicionarValorChave(ACodigoDaEmpresa, LValorChave);

  AdicionarValorChave(AClassificacaoFiscalDoItem, LValorChave);

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(strSQL);

  LAbrevicaoIpi :=
    objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, LDesmembrarSelectParaCampoTabela.CampoChave, LValorChave, False);

  LBaseDeCalculoIPI := 'BASE';
  LAliquotaDeCalculoIPI := 'ALQ';

  FillChar(Result, Sizeof(Result), #0);
  Result.BaseDeCalculoIPI := LAbrevicaoIpi.FieldByName(LBaseDeCalculoIPI);
  Result.AliquotaDeCalculoIPI := LAbrevicaoIpi.FieldByName(LAliquotaDeCalculoIPI);
end;

Class procedure TFaturamentoImpostosFuncoes.AdicionarValorChave(const AValor: Variant; var AValorChave: ArrOfVariant);
begin
  SetLength(AValorChave, Length(AValorChave) + 1);
  AValorChave[Length(AValorChave) - 1] := AValor;
end;

end.
