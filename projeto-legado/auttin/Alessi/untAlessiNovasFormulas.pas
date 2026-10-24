unit untAlessiNovasFormulas;

interface

uses
  untAbstractAlessiGravando, untIGravando, ADODB,
  SysUtils, Classes, Uni,
  UniClientDataSet;

type
  TAlessiNovasFormulas = class(TAbstractAlessiGravando)
  public
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untFuncTinta, untStatusGravando, untAlessiImobiliariaNovasFormulasDinamica;

{ TAlessiNovasFormulas }

procedure TAlessiNovasFormulas.Executar(const gravando: IGravando);
var
  cdsNovasFormulas: TUniClientDataSet;
  nfm: TAlessiImobiliariaNovasFormulasDinamica;
begin
  cdsNovasFormulas := nil;
  nfm := nil;
  Try
    Try
      cdsNovasFormulas := fGeTUniClientDataSet(
        'SELECT * FROM ALE_CADNFM', 'NFM_CODNFM', True);

      nfm := TAlessiImobiliariaNovasFormulasDinamica.Create;

      while (not cdsNovasFormulas.Eof) and (gravando.Status <> sgCancelado) do
      begin
        Try
          Try
            nfm.fRemoverFormula(cdsNovasFormulas.FieldByName('NFM_CODNFM').AsString);
            if not nfm.fGravaCadNfm(cdsNovasFormulas) then
            begin
              gravando.Texto := Format('Não foi possivel importar a nova formula: %s, %s, %s',
                [cdsNovasFormulas.FieldByName('NFM_PRODUT').AsString, cdsNovasFormulas.FieldByName('NFM_BASE__').AsString,
                cdsNovasFormulas.FieldByName('NFM_CODUNI').AsString, cdsNovasFormulas.FieldByName('NFM_NOMCOR').AsString,
                cdsNovasFormulas.FieldByName('NFM_NOMLON').AsString]);
            end;  
            
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('Não foi possivel importar a nova formula: %s, %s, %s, [%s: %s]',
                [cdsNovasFormulas.FieldByName('NFM_PRODUT').AsString, cdsNovasFormulas.FieldByName('NFM_BASE__').AsString,
                cdsNovasFormulas.FieldByName('NFM_CODUNI').AsString, cdsNovasFormulas.FieldByName('NFM_NOMCOR').AsString,
                cdsNovasFormulas.FieldByName('NFM_NOMLON').AsString, E.ClassName, E.Message]);
            end;
          End;
        Finally
          cdsNovasFormulas.Next;
          gravando.RegistrarProgresso(0, cdsNovasFormulas.RecNo, cdsNovasFormulas.RecordCount);
        End;                            
      end;  
      
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    if Assigned(cdsNovasFormulas) then FreeAndNil(cdsNovasFormulas);
    if Assigned(nfm) then FreeAndNil(nfm);       
  End;
end;

end.
