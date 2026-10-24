unit untTintadeMaquinaFactory;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untGTinForTipos,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untITintaDeMaquina, untIDadosTinta,  SysUtils;

type
  TTintadeMaquinaFactory = class(TInterfacedObject)
  private
    class procedure pRecalcularComponentes(const tintaDeMaquina:
        ITintaDeMaquina);
  public
    class function GetITintadeMaquina(const dadosTinta: IDadosTinta; const
        calculadorFatVendas: TObject; dicInfEmp: TDicionario = Nil): ITintaDeMaquina; stdcall;
  end;

implementation

uses
  untTintaMaquina, untICalculadorFatVendas, untFuncEspecificas;

{ TTintadeMaquinaFactory }

class function TTintadeMaquinaFactory.GetITintadeMaquina(const dadosTinta: IDadosTinta; const
        calculadorFatVendas: TObject; dicInfEmp: TDicionario = Nil): ITintaDeMaquina;
var
  dicRetorno: TDicionario;
  intCont: Integer;

begin
  dicRetorno := nil;
  Result := nil;
  Try
    Try
      dicRetorno := TDicionario.Create;
      dicRetorno['idepro'] := dadosTinta.IdePro;
      dicRetorno['montad'] := dadosTinta.Montadora;
      dicRetorno['a_n_o_'] := dadosTinta.Ano;
      dicRetorno['itetin'] := dadosTinta.IteTin;
      dicRetorno['tippre'] := dadosTinta.TipoPreco;
      dicRetorno['itebas'] := dadosTinta.Base;
      dicRetorno['iteemb'] := dadosTinta.Embalagem;
      dicRetorno['codemp'] := dadosTinta.Empresa;
      dicRetorno['codempprd'] := dadosTinta.EmpresaPrd;
      dicRetorno['volpro'] := dadosTinta.Volume;
      dicRetorno['linha_'] := dadosTinta.Linha;
      dicRetorno['qtdemb'] := dadosTinta.QuantidadeEmbalagem;
      dicRetorno['tabpre'] := dadosTinta.TabelaPreco;
      dicRetorno['tabelaunica'] := dadosTinta.TabelaPreco;
      dicRetorno['descri'] := dadosTinta.Descricao;
      dicRetorno['catali'] := dadosTinta.Catalisador;
      dicRetorno['propre'] := (fCfgSis('PROPRE') = 2);

      If dicInfEmp <> Nil Then
      Begin
        dicRetorno['oprflj'] := IfNull(dicInfEmp['oprflj'], '');
        dicRetorno['empprd'] := IfNull(dicInfEmp['empprd'], '');
        dicRetorno['emp_cd'] := IfNull(dicInfEmp['emp_cd'], '');
        dicRetorno['Cd_S_N'] := IfNull(dicInfEmp['Cd_S_N'], '');
        dicRetorno['empfat'] := IfNull(dicInfEmp['empfat'], '');
        dicRetorno['FatS_N'] := IfNull(dicInfEmp['FatS_N'], '');
      End;


      for intCont := 0 to dadosTinta.ComponentesCount - 1 do
      begin
        dicRetorno['base' + fStrZero(intCont + 1, 2)] := dadosTinta[intCont].Componente;
        dicRetorno['qtdb' + fStrZero(intCont + 1, 2)] := dadosTinta[intCont].Quantidade / dadosTinta.Quantidade;
      end;

      if Assigned(calculadorFatVendas) then
      begin
        if Supports(calculadorFatVendas, ICalculadorFatVendas) then
        Begin
          dicRetorno.AdicionarObjeto('calculadorFatVendas', calculadorFatVendas);
        End;
      end;

      pTintaRetornaTabelaPreco(dicRetorno, dadosTinta.FatorAcerto);

      if not Supports(dicRetorno.RetornaObjeto('tintaDeMaquina'), ITintaDeMaquina, Result) then
      begin
        Result := nil;
        Exit;
      end;

      Result.Descricao := Format('%d) %s', [dadosTinta.RecNo, dadosTinta.Descricao]) ;
      Result.DescontoEspecial := dadosTinta.DescontoEspecial;
      Result.Quantidade := dadosTinta.Quantidade;
      pRecalcularComponentes(Result);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
  End;
end;

class procedure TTintadeMaquinaFactory.pRecalcularComponentes(const
    tintaDeMaquina: ITintaDeMaquina);
var
  intCont: Integer;
  fltDescontoComponente: Double;
  IcmsSaida: Double;
  ImpostosFederais: Double;
  DespesasOperacionais: Double;
  PrecoVenda: Double;
begin
  for intCont := 0 to tintaDeMaquina.Count - 1 do
  begin
    if fFormataFloat(tintaDeMaquina[intCont].PrecoVenda, 2) = 0 then
      Continue;
      
    fltDescontoComponente := (fFormataFloat(tintaDeMaquina.DescontoEspecial, 2) / fFormataFloat(tintaDeMaquina.Quantidade, 2)) *
      (fFormataFloat(tintaDeMaquina[intCont].PrecoVenda, 2) / fFormataFloat(tintaDeMaquina.PrecoVenda, 2));
    fltDescontoComponente := fFormataFloat(fltDescontoComponente, 2);

    IcmsSaida := 100 * (fFormataFloat(tintaDeMaquina[intCont].IcmsSaida, 2) / fFormataFloat(tintaDeMaquina[intCont].PrecoVenda, 2));
    ImpostosFederais := 100 * (fFormataFloat(tintaDeMaquina[intCont].ImpostosFederais, 2) / fFormataFloat(tintaDeMaquina[intCont].PrecoVenda, 2));
    DespesasOperacionais := 100 * (fFormataFloat(tintaDeMaquina[intCont].DespesasOperacionais, 2) / fFormataFloat(tintaDeMaquina[intCont].PrecoVenda, 2));
    PrecoVenda := tintaDeMaquina[intCont].PrecoVenda - fltDescontoComponente;

    tintaDeMaquina[intCont].PrecoCustoReal := fCalculaPrecoCusto2(PrecoVenda,
                                                                  tintaDeMaquina[intCont].PrecoCusto,
                                                                  tintaDeMaquina[intCont].OutrosValores,
                                                                  IcmsSaida,
                                                                  ImpostosFederais,
                                                                  DespesasOperacionais);

    tintaDeMaquina[intCont].PrecoCustoReal := fFormataFloat(tintaDeMaquina[intCont].PrecoCustoReal, 2);
  end;
end;

end.
