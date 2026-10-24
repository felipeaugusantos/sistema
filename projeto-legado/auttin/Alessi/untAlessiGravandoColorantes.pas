unit untAlessiGravandoColorantes;

interface

uses
  untAbstractAlessiGravando, untIGravando, ADODB,
  SysUtils, Classes, Uni,  UniClientDataSet;

type
  TAlessiGravandoColorantes = class(TAbstractAlessiGravando)
  public
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untFuncoesSimples, untFuncoes, untFuncTinta, untStatusGravando;

{ TAlessiGravandoColorantes }

procedure TAlessiGravandoColorantes.Executar(const gravando: IGravando);
var
  qryGen: TADOQuery;
  strNomeArquivo: string;
  strNomePlanilha: string;
  stlPlanilhas: TStringList;
  cmdGrava: TUniQuery;
  strInsert: string;
  intIncrem: Integer;
  cdsColorantes: TUniClientDataSet;
  strCodCol: string;
begin
  cmdGrava := nil;
  stlPlanilhas := nil;
  cdsColorantes := nil;
  Try
    Try
      cmdGrava := fCriaQuery();
      stlPlanilhas := TStringList.Create;

      strInsert := fGetInsert('ALE_CADCOL');
      intIncrem := fRetAutoIncremInteger('ALE_CADCOL', VS_strCodEmp);
      cdsColorantes := fGeTUniClientDataSet('SELECT DISTINCT COL_CODCOL FROM ALE_CADCOL',
        'COL_CODCOL', True);

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
                qryGen.SQL.Text := 'SELECT COR1 FROM [' + strNomePlanilha + '] ' +
                  ' UNION SELECT COR2 FROM [' + strNomePlanilha + '] ' +
                  ' UNION SELECT COR3 FROM [' + strNomePlanilha + '] ' +
                  ' UNION SELECT COR4 FROM [' + strNomePlanilha + '] ';
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
                    strCodCol := Trim(UpperCase(fRemoveAcento(qryGen.FieldByName('COR1').AsString)));
                    if cdsColorantes.FindKey([strCodCol]) then
                      Continue;

                    if  fEmptyStr(strCodCol) then
                      Continue;

                    Inc(intIncrem);

                    cmdGrava.Close;
                    cmdGrava.SQL.Clear;
                    cmdGrava.SQL.Text := strInsert;

                    cmdGrava.ParamByName('INCREM').AsString    := fFormataAutInc(intIncrem, VS_strCodEmp, VS_strCodEmp);
                    cmdGrava.ParamByName('CODCOL').AsString    := strCodCol;
                    cmdGrava.ParamByName('CODITE').AsString    := '';
                    cmdGrava.ParamByName('PRECUS').AsFloat     := 0;
                    cmdGrava.ParamByName('PREVEN').AsFloat     := 0;
                    cmdGrava.ParamByName('MARGEM').AsFloat     := 0;
                    cmdGrava.ExecSQL;
                    cdsColorantes.AppendRecord([strCodCol]);
                  Except
                    on E: Exception do
                    begin
                      gravando.Texto := Format('Não foi possivel importar a formula: %s [%s: %s]',
                        [cmdGrava.ParamByName('CODCOL').AsString, E.ClassName,E.Message ]);
                    end;
                  End;
                Finally
                  qryGen.Next;
                  gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
                End;
              end;
            end;

            if gravando.Status <> sgCancelado then
              fGravaAutoIncrem('ALE_CADCOL', intIncrem);
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('Não foi possivel abrir o arquivo %s, [%s: %s]',
                [ExtractFileName(strNomeArquivo), E.ClassName, E.Message]) ;
            end;
          End;
        Finally
          if Assigned(qryGen) then
          begin
            qryGen.Close;
            FreeAndNil(qryGen);
          end;

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
    if Assigned(cdsColorantes) then FreeAndNil(cdsColorantes)    
  End;                            
end;


end.
