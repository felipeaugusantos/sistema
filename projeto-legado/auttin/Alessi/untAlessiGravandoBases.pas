unit untAlessiGravandoBases;

interface

uses
  untAbstractAlessiGravando, untIGravando, ADODB,  SysUtils,
  Classes, Uni, UniClientDataSet;

type
  TAlessiGravandoBases = class(TAbstractAlessiGravando)
  private
    cdsCadBas: TUniClientDataSet;
  public
    procedure Executar(const gravando: IGravando); override;
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples, untFuncoes, untFuncTinta, untStatusGravando;

{ TAlessiGravandoBases }

constructor TAlessiGravandoBases.Create;
begin
  inherited Create;
  cdsCadBas := fGeTUniClientDataSet(
    'SELECT DISTINCT BAS_PRODUT, BAS_BASE__, BAS_CODUNI FROM ALE_CADBAS',
    'BAS_PRODUT;BAS_BASE__;BAS_CODUNI', True);
end;

destructor TAlessiGravandoBases.Destroy;
begin
  if Assigned(cdsCadBas) then FreeAndNil(cdsCadBas);
  inherited Destroy;
end;

procedure TAlessiGravandoBases.Executar(const gravando: IGravando);
var
  qryGen: TADOQuery;
  strNomeArquivo: string;
  strNomePlanilha: string;
  stlPlanilhas: TStringList;
  cmdGrava: TUniQuery;
  strInsert: string;
  intIncrem: Integer;  
  strUnidade: string;
  strBase: string;
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

      strInsert := fGetInsert('ALE_CADBAS');
      intIncrem := fRetAutoIncremInteger('ALE_CADBAS', VS_strCodEmp);

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
                qryGen.SQL.Text := 'SELECT DISTINCT PRODUTO, [BASE C] FROM [' + strNomePlanilha + ']';
                qryGen.Open;
              Except
                on E: Exception do
                begin
                  Try
                    if gravando.Status = sgCancelado then
                      Break;
                    qryGen.Close;
                    qryGen.SQL.Clear;
                    qryGen.SQL.Text := 'SELECT DISTINCT PRODUTO, [BASE] FROM [' + strNomePlanilha + ']';
                    qryGen.Open;
                  Except
                    on E: Exception do
                    begin
                      Continue;
                    end;
                  End;
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

                    for strUnidade in arrUni do
                    begin
                      if Assigned(qryGen.FindField('BASE C')) then
                        strBase    := Trim(UpperCase(fRemoveAcento(qryGen.FieldByName('BASE C').AsString)))
                      else
                        strBase    := Trim(UpperCase(fRemoveAcento(qryGen.FieldByName('BASE').AsString)));

                      if (strUnidade = 'LA') and (Pos('GEL', strProduto) > 0) then
                        Continue;

                      if (strUnidade = 'QT') and (Pos('TEXTURA', strProduto) > 0) then
                        Continue;

                      if cdsCadBas.FindKey([strProduto, strBase, GetUnidade(strProduto, strUnidade)]) then
                        Continue;

                      cmdGrava.ParamByName('PRODUT').AsString    := strProduto;
                      cmdGrava.ParamByName('BASE__').AsString    := strBase;

                      Inc(intIncrem);
                      cmdGrava.ParamByName('CODUNI').AsString    := GetUnidade(strProduto, strUnidade);
                      cmdGrava.ParamByName('INCREM').AsString    := fFormataAutInc(intIncrem, VS_strCodEmp, VS_strCodEmp);

                      cmdGrava.ExecSQL;
                      cdsCadBas.AppendRecord([cmdGrava.ParamByName('PRODUT').AsString,
                        cmdGrava.ParamByName('BASE__').AsString,
                        cmdGrava.ParamByName('CODUNI').AsString]);
                    end;

                  Except
                    on E: Exception do
                    begin
                      if Assigned(qryGen.FindField('BASE C')) then
                      begin
                        gravando.Texto := Format('Não foi possivel importar a formula: %s, %s [%s: %s]',
                          [qryGen.FieldByName('PRODUTO').AsString, qryGen.FieldByName('BASE C').AsString, E.ClassName,E.Message ]);
                      end
                      else
                      begin
                        gravando.Texto := Format('Não foi possivel importar a formula: %s, %s [%s: %s]',
                          [qryGen.FieldByName('PRODUTO').AsString, qryGen.FieldByName('BASE').AsString, E.ClassName,E.Message ]);
                      end;
                    end;
                  End;
                Finally
                  qryGen.Next;
                  gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
                End;
              end;
            end;

            if gravando.Status <> sgCancelado then
              fGravaAutoIncrem('ALE_CADBAS', intIncrem);

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


end.
