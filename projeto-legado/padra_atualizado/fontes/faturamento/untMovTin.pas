unit untMovTin;

interface

uses
  untITintaDeMaquina, Uni, SysUtils, Variants,untFuncFatTypes, untTMatrizSaldosColorantes,  untFuncFat;

type
  TMovTin = class
  public
    class function fGravaMovTin(const tinta: ITintaDeMaquina; const strAutIncMovDet: string): Boolean;
  end;

implementation

uses
      untDDLFactory, untFuncoesSimples, untTintaDeMaquinaComponenteTipo;

{ TMovTin }

class function TMovTin.fGravaMovTin(const tinta: ITintaDeMaquina; const strAutIncMovDet: string): Boolean;
var
  qryGrava: TUniQuery;
  intCont: Integer;
  strNomeTabela: string;
begin
  qryGrava := nil;
  Result := False;
  Try
    Try
      if fEmptyStr(strAutIncMovDet) then
        Exit;

      if not Assigned(tinta)  then
        Exit;


      qryGrava := fCriaQuery();
      strNomeTabela := 'MOVTIN';

      for intCont := 0 to tinta.Count - 1 do
      begin
        qryGrava.Params.Clear;
        qryGrava.SQL.Text := TDDLFactory.GetInsert(strNomeTabela);

        qryGrava.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomeTabela, VS_strCodEmp);

        If fEmptyStr(tinta[intCont].CodIte) And (tinta[intCont].Tipo = tmctEmbalagemAutomotiva) Then
          qryGrava.ParamByName('TIN_CODITE').Value := Null
        Else
          qryGrava.ParamByName('TIN_CODITE').AsString := tinta[intCont].CodIte;

        qryGrava.ParamByName('TIN_FORMUL').AsString := Copy(tinta[intCont].Descricao, 1, 20);

        if tinta[intCont].Tipo in [tmctEmbalagemAutomotiva, tmctBaseImobiliaria]  then
          qryGrava.ParamByName('TIN_PROEMB').AsString := 'S'
        else
          qryGrava.ParamByName('TIN_PROEMB').AsString := 'N';

        if tinta[intCont].Tipo = tmctEmbalagemAutomotiva then
          qryGrava.ParamByName('TIN_QTDITE').AsFloat := tinta[intCont].Quantidade
        else
          qryGrava.ParamByName('TIN_QTDITE').AsFloat := tinta[intCont].Quantidade * tinta.Quantidade;

        qryGrava.ParamByName('TIN_SEQGER').AsString := strAutIncMovDet;
        qryGrava.ParamByName('TIN_TOTCUS').AsFloat := tinta[intCont].PrecoCusto * tinta.Quantidade;
        qryGrava.ParamByName('TIN_OUTVAL').AsFloat := tinta[intCont].OutrosValores * tinta.Quantidade;
        qryGrava.ParamByName('TIN_ICMSAI').AsFloat := tinta[intCont].IcmsSaida * tinta.Quantidade;
        qryGrava.ParamByName('TIN_IMPFED').AsFloat := tinta[intCont].ImpostosFederais * tinta.Quantidade;
        qryGrava.ParamByName('TIN_DESOPE').AsFloat := tinta[intCont].DespesasOperacionais * tinta.Quantidade;
        qryGrava.ParamByName('TIN_TOTCU2').AsFloat := tinta[intCont].PrecoCustoReal * tinta.Quantidade;
        qryGrava.ParamByName('TIN_TOTITE').AsFloat := tinta[intCont].PrecoVenda * tinta.Quantidade;
        qryGrava.ParamByName('TIN_DESESP').AsFloat := ((tinta[intCont].PrecoVenda / tinta.PrecoVenda) * tinta.DescontoEspecial);
        qryGrava.ExecSQL;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGrava) then FreeAndNil(qryGrava);
  End;
end;

end.
