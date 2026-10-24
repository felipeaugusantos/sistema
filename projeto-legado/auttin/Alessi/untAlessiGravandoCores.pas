unit untAlessiGravandoCores;

interface

uses
  untAbstractAlessiGravando, untIGravando, ADODB,
  SysUtils, Classes, Uni, UniClientDataSet;

type
  TAlessiGravandoCores = class(TAbstractAlessiGravando)
  private
    function BasesCadastradas(): Boolean;
    function ColorantesCadastrados(): Boolean;
  public
    class function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;
    class procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
    class function GetFatorInteiroOnca(intParteInteira: Integer; fltParteFracao: Double; strUnidade: string): Integer; overload;
    class function GetFatorInteiroOnca(intParteInteira: Integer; fltParteFracao: Double; fltFator: Double): Integer; overload;
    class function GetFatorFracaoOnca(intParteInteira: Integer; fltParteFracao: Double; strUnidade: string): Double; overload;
    class function GetFatorFracaoOnca(intParteInteira: Integer; fltParteFracao: Double; fltFator: Double): Double; overload;
  public
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untFuncoesSimples, untFuncoes, untStatusGravando, untFuncTinta;

{ TAlesseGravandoCores }

function TAlessiGravandoCores.BasesCadastradas: Boolean;
var
  cdsBases: TUniClientDataSet;
begin
  Result := False;
  Try
    Try
      cdsBases := fGeTUniClientDataSet('SELECT COUNT(*) AS QTD FROM ALE_CADBAS WHERE IFNULL(BAS_CODITE, '''') <> '''' ',
        '', True);
      Result := cdsBases.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(cdsBases) then FreeAndNil(cdsBases);
  End;
end;

function TAlessiGravandoCores.ColorantesCadastrados: Boolean;
var
  cdsBases: TUniClientDataSet;
begin
  Result := False;
  Try
    Try
      cdsBases := fGeTUniClientDataSet('SELECT COUNT(*) AS QTD FROM ALE_CADCOL WHERE IFNULL(COL_CODITE, '''') <> '''' ',
        '', True);
      Result := cdsBases.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(cdsBases) then FreeAndNil(cdsBases);
  End;
end;

procedure TAlessiGravandoCores.Executar(const gravando: IGravando);
var
  qryGen: TADOQuery;
  strNomeArquivo: string;
  strNomePlanilha: string;
  stlPlanilhas: TStringList;
  cmdGrava: TUniQuery;
  strInsert: string;
  intIncrem: Integer;
  intCol: Integer;
  
  strUnidade: string;
  strProduto: string;
const
  arrUni: array [0..2] of string = ('QT', 'GL', 'LA');
begin
  cmdGrava := nil;
  stlPlanilhas := nil;
  Try
    Try
      cmdGrava := fCriaQuery();
      stlPlanilhas := TStringList.Create;

      if not BasesCadastradas then
      begin
        fMensagem('ATENÇÃO', 'As bases não estão configuradas!', ['&OK']);
        gravando.Cancelar;
        Exit;
      end;

      if not ColorantesCadastrados then
      begin
        fMensagem('ATENÇÃO', 'Os colorantes não estão configurados!', ['&OK']);
        gravando.Cancelar;
        Exit;
      end;

      if fMensagem('ATENÇÃO', 'Deseja limpar a tabela de tintas?', ['&SIM', '&NÃO']) = 1 then
      begin
        pZapTable('ALE_CADALE');
      end;

      strInsert := fGetInsert('ALE_CADALE');
      intIncrem := fRetAutoIncremInteger('ALE_CADALE', VS_strCodEmp);

      for strNomeArquivo in stlArquivos do
      begin
        Try
          Try
            if gravando.Status = sgCancelado then
              Break;

            stlPlanilhas.Clear;
            qryGen := GetQuery(strNomeArquivo, stlPlanilhas);

            for strNomePlanilha in stlPlanilhas do
            begin
              Try
                if gravando.Status = sgCancelado then
                  Break;
                qryGen.Close;
                qryGen.SQL.Clear;
                qryGen.SQL.Text := 'SELECT * FROM [' + strNomePlanilha + ']';
                qryGen.Open;
              Except
                on E: Exception do
                begin
                  Continue;
                end;
              End;

              gravando.Texto := Format('Processando [%s][%s]',
                [ExtractFileName(strNomeArquivo), strNomePlanilha]);

              while (not qryGen.Eof) and (gravando.Status <> sgCancelado) do
              begin
                Try
                  Try
                    strProduto := UpperCase(Trim(fRemoveAcento(qryGen.FieldByName('PRODUTO').AsString)));

                    if fEmptyStr(strProduto) then
                      Continue;

                    cmdGrava.Close;
                    cmdGrava.SQL.Clear;
                    cmdGrava.SQL.Text := strInsert;
                    cmdGrava.ParamByName('PRODUT').AsString    := strProduto;

                    if Assigned(qryGen.FindField('BASE C')) then
                      cmdGrava.ParamByName('BASE__').AsString    := Trim(UpperCase(qryGen.FieldByName('BASE C').AsString))
                    else
                      cmdGrava.ParamByName('BASE__').AsString    := Trim(UpperCase(qryGen.FieldByName('BASE').AsString));

                    cmdGrava.ParamByName('NOMCOR').AsString    := Trim(UpperCase(qryGen.FieldByName('NOME COR').AsString));
                    cmdGrava.ParamByName('NOMLON').AsString    := Trim(UpperCase(qryGen.FieldByName('NOME LONGO').AsString));

                    for strUnidade in arrUni do
                    begin
                      if (strUnidade = 'LA') and (Pos('GEL', strProduto) > 0) then
                        Continue;

                      if (strUnidade = 'QT') and (Pos('TEXTURA', strProduto) > 0) then
                        Continue;

                      for intCol := 1 to 4 do
                      begin
                        if not fEmptyStr(Trim(UpperCase(fRemoveAcento(qryGen.FieldByName('COR' + IntToStr(intCol)).AsString)))) then
                        begin
                          cmdGrava.ParamByName('CODC' + fStrZero(intCol, 2)).AsString    := Trim(UpperCase(fRemoveAcento(qryGen.FieldByName('COR' + IntToStr(intCol)).AsString)));
                          cmdGrava.ParamByName('QTOZ' + fStrZero(intCol, 2)).AsInteger   := GetFatorInteiroOnca(StrToIntDef(qryGen.FieldByName('OZ' + IntToStr(intCol)).AsString, 0),
                                                                                              fStrToFloat(qryGen.FieldByName('SHOT' + IntToStr(intCol)).AsString), strUnidade);
                          cmdGrava.ParamByName('QSHO' + fStrZero(intCol, 2)).AsFloat     := GetFatorFracaoOnca(StrToIntDef(qryGen.FieldByName('OZ' + IntToStr(intCol)).AsString, 0),
                                                                                              fStrToFloat(qryGen.FieldByName('SHOT' + IntToStr(intCol)).AsString), strUnidade);
                        end;
                      end;

                      Inc(intIncrem);
                      cmdGrava.ParamByName('CODUNI').AsString    := GetUnidade(strProduto, strUnidade);
                      cmdGrava.ParamByName('INCREM').AsString    := fFormataAutInc(intIncrem, VS_strCodEmp, VS_strCodEmp);
                      cmdGrava.ParamByName('MD5KEY').AsString    := GetMD5(cmdGrava.ParamByName('PRODUT').AsString +
                                                                      cmdGrava.ParamByName('BASE__').AsString +
                                                                      cmdGrava.ParamByName('CODUNI').AsString +
                                                                      cmdGrava.ParamByName('NOMCOR').AsString +
                                                                      cmdGrava.ParamByName('NOMLON').AsString +
                                                                      cmdGrava.ParamByName('CODNFM').AsString);
                      cmdGrava.ExecSQL;
                    end;

                  Except
                    on E: Exception do
                    begin
                      if Assigned(qryGen.FindField('BASE C')) then
                      begin
                        gravando.Texto := Format('Não foi possivel importar a formula: %s, %s, %s, %s, [%s: %s]',
                          [qryGen.FieldByName('PRODUTO').AsString, qryGen.FieldByName('BASE C').AsString,
                          qryGen.FieldByName('NOME COR').AsString, qryGen.FieldByName('NOME LONGO').AsString, E.ClassName,E.Message ]);
                      end
                      else
                      begin
                        gravando.Texto := Format('Não foi possivel importar a formula: %s, %s, %s, %s, [%s: %s]',
                          [qryGen.FieldByName('PRODUTO').AsString, qryGen.FieldByName('BASE').AsString,
                          qryGen.FieldByName('NOME COR').AsString, qryGen.FieldByName('NOME LONGO').AsString, E.ClassName,E.Message ]);
                      end;
                    end;
                  End;
                Finally
                  qryGen.Next;
                  gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
                End;
              end;
              gravando.Texto := Format('%d registros processados', [qryGen.RecNo]);
            end;

            if gravando.Status <> sgCancelado then
              fGravaAutoIncrem('ALE_CADALE', intIncrem);

          Except
            on E: Exception do
            begin
              gravando.Texto := Format('Não foi possivel abrir o arquivo %s, [%s: %s]',
                [ExtractFileName(strNomeArquivo), E.ClassName, E.Message]) ;
            end;
          End;
        Finally
          if Assigned(qryGen) then FreeAndNil(qryGen);
        End;
      end;
    Except
      on E: Exception do
      begin
        gravando.Texto := E.ClassName + ': ' + E.Message;
      end;
    End;
  Finally
    if Assigned(stlPlanilhas) then FreeAndNil(stlPlanilhas);
    if Assigned(cmdGrava) then FreeAndNil(cmdGrava);
  End;
end;

class function TAlessiGravandoCores.GetFatorFracaoOnca(intParteInteira: Integer; fltParteFracao: Double; strUnidade: string): Double;
var
  fltCalculo: Double;
begin
  fltCalculo := OncaParaMl(intParteInteira, fltParteFracao);
  if strUnidade = 'QT' then
    fltCalculo := fltCalculo / 4
  else if strUnidade = 'LA' then
    fltCalculo := fltCalculo * 5;

  MlParaOnca(fltCalculo, intParteInteira, fltParteFracao);
  Result := fltParteFracao;
end;

class function TAlessiGravandoCores.GetFatorFracaoOnca(intParteInteira: Integer; fltParteFracao, fltFator: Double): Double;
var
  fltCalculo: Double;
begin
  fltCalculo := OncaParaMl(intParteInteira, fltParteFracao) * fltFator;
  MlParaOnca(fltCalculo, intParteInteira, fltParteFracao);
  Result := fltParteFracao;
end;

class function TAlessiGravandoCores.GetFatorInteiroOnca(intParteInteira: Integer; fltParteFracao, fltFator: Double): Integer;
var
  fltCalculo: Double;
begin
  fltCalculo := OncaParaMl(intParteInteira, fltParteFracao) * fltFator;
  MlParaOnca(fltCalculo, intParteInteira, fltParteFracao);
  Result := intParteInteira;
end;

class function TAlessiGravandoCores.GetFatorInteiroOnca(intParteInteira: Integer; fltParteFracao: Double; strUnidade: string): Integer;
var
  fltCalculo: Double;
begin
  fltCalculo := OncaParaMl(intParteInteira, fltParteFracao);
  if strUnidade = 'QT' then
    fltCalculo := fltCalculo / 4
  else if strUnidade = 'LA' then
    fltCalculo := fltCalculo * 5;

  MlParaOnca(fltCalculo, intParteInteira, fltParteFracao);
  Result := intParteInteira;
end;

class procedure TAlessiGravandoCores.MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
end;

class function TAlessiGravandoCores.OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;
begin
  Result := (intParteInteira * 29.574) + (fltParteFracao * 0.616125);
end;

end.

