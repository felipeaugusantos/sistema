unit untTestConfiguracoes;

interface

uses Shared.Functions.Configuracoes, System.Generics.Collections,
  System.SysUtils, System.StrUtils;

type
  TTestConfiguracoes = class(TInterfacedObject, IConfiguracoes)
  public
    class function New: IConfiguracoes;
    function fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp : String = ''): Variant;
    function fAtualizaValorConfiguracao(strCamCfg: String; strValCfg: String): Boolean;
  end;

type
  TConfiguracoesDefault = class
  public
    class procedure IniciarCanfiguracoesDefault;
  end;

type
  EConfiguracaoNaoEncontrada = class(Exception);

implementation

var
  dicConfiguracoesDefault: TDictionary<string, string>;

  { TTestConfiguracoes }

function TTestConfiguracoes.fAtualizaValorConfiguracao(strCamCfg,
  strValCfg: String): Boolean;
begin
  dicConfiguracoesDefault.AddOrSetValue(strCamCfg, strValCfg);
  Result := True;
end;

function TTestConfiguracoes.fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp : String = ''): Variant;
Var
    strValCfg: String;
begin
  if not dicConfiguracoesDefault.ContainsKey(strCamCfg) then
    raise EConfiguracaoNaoEncontrada.Create('A configuração CFG_' + strCamCfg +
      ' não existe ou não foi informada no dicionário de configurações!');

  strValCfg := dicConfiguracoesDefault[strCamCfg];

  Case varTipVar Of
    varString : Result := strValCfg;

    varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                Begin
                  Try
                    If strValCfg.IsEmpty Then
                      Result := 0
                    Else
                      Result := strToInt(strValCfg);
                  Except
                    Result := 0;
                  End;
                End;

    varDouble, varCurrency:
                Begin
                  Try
                    If strValCfg.IsEmpty Then
                      Result := 0.00
                    Else
                      Result := StrToFloatDef(AnsiReplaceStr(strValCfg, '.', ','), 0.0);
                  Except
                    Result := 0.00;
                  End;
                End;

    varDate:
                Begin
                  Try
                    If strValCfg.IsEmpty Then
                      Result := 0
                    Else
                      Result := StrToDateDef(strValCfg, 0);
                  Except
                    Result := 0;
                  End;
                End;

    varBoolean:
               Begin
                 Try
                   If strValCfg.IsEmpty Then
                     Result := False
                   Else If Pos(strValCfg, 'S_N_') > 0 Then
                     Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

                   Else If Pos(strValCfg, '0_1_') > 0  Then
                     Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
                   Else
                     Result := (Length(strValCfg) > 0) And CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

                 Except
                   Result := False;
                 End;

               End;

    Else
      Result := strValCfg;

  End;

end;

class function TTestConfiguracoes.New: IConfiguracoes;
begin
  Result := Self.Create;
end;

procedure pIniciarConfiguracoesDefault;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_BAIXA_ENTREGA_FUTURA_DE_ITEM_ESTRUTURA_EMITIR_DOCUMENTO_COM_ITEM, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_BAIXA_ENTREGA_FUTURA_DE_ITEM_ESTRUTURA_EXIBIR_ITEM, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICMS_DA_ABREVIACAO_FISCAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITAR_PERCENTUAL_BASE_DIFAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_DIFAL_COM_BASE_REDUZIDA_UTILIZANDO_ALIQUOTA_EFETIVA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_DIFERENCIAL_ALIQUOTA_PRODUTOS_ST, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONSIDERAR_ALIQUOTA_EFETIVA_DO_ESTADO_CALCULAR_DIFAL_PRODUTOS_IMPORTADOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPTANTE_SIMPLES_NACIONAL_ENVIAR_ICMS_DIFAL_REMETENTE_PARTILHA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPTANTE_SIMPLES_NACIONAL_ENVIAR_ICMS_DIFAL_DESTINO_PARTILHA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_RECEBIMENTO_GARANTIA_CLIENTE, '915');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPERACAO_COMPOSICAO_PRECO_PRODUTO, '+');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_FORMULA_PARA_CALCULO_PRECO_CUSTO, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANTIDADE_CASAS_DECIMAIS_VALOR_UNITARIO, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULO_MARGEM_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS_CONSIDERAR, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ROTINA_PRECO_VENDA_DINAMICO_INFLUENCIADO_POR_IMPOSTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_NOTA_REMESSA_CONTRA_ORDEM, '923');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MODELO_DE_CALCULO_DECRETO_REDUCAO_BASE_IMPOSTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_REGRA_FISCAL, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_DEVOLUCAO, '1202_2202_1411_2411');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPCAO_ENVIO_ST_RETIDA_ANTERIORMENTE, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_DEMONSTRACAO, '912');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACOES_DE_DEMONSTRACAO,'912_913_');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DIFAL_PRODUTOR_RURAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ITEM_TAXA_BOMBEAMENTO_BOMBA_MANGOTE_NOTA_CONCRETO, '00100');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ITEM_TAXA_BOMBEAMENTO_BOMBA_LANCA_NOTA_CONCRETO,   '00200');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ESTADOS_QUE_CONSIDERAM_REDUCAO_DE_CARGA_LIQUIDA,   'CE');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ESTADOS_QUE_CALCULAM_FCP_PROPRIO_E_FCP_ST_DENTRO_DO_ESTADO, 'ALRJ');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_CONTA_E_ORDEM, '119');
end;

{ TConfiguracoesDefault }

class procedure TConfiguracoesDefault.IniciarCanfiguracoesDefault;
begin
  pIniciarConfiguracoesDefault;
end;

initialization

dicConfiguracoesDefault := TDictionary<string, string>.Create;

SetObjConfiguracoes(TTestConfiguracoes.New());

pIniciarConfiguracoesDefault;

finalization

If Assigned(dicConfiguracoesDefault) Then
  FreeAndNil(dicConfiguracoesDefault);

end.
