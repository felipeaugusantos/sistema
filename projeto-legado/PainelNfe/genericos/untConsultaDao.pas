unit untConsultaDao;

interface

uses SqlExpr, SimpleDS, Db, Classes, SysUtils, DateUtils, untConsultaModel,
  {$IF Defined(UNIDAC)}
    Uni, DBAccess,
  {$ELSE}
    ZDataset,
  {$IFEND}
  DBClient;
type
  TConsultaDao = Class
    private
      procedure pMontaQryConsultaGenerica(objConsulta: TConsultaModel;
        qryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    public
      procedure pCarregaLista(objConsulta: TConsultaModel; var cdsConsulta: TClientDataSet);
    end;

implementation

uses
  untUtil;

procedure TConsultaDao.pCarregaLista(objConsulta: TConsultaModel;
  var cdsConsulta: TClientDataSet);
var
  qryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryConsulta := fCriaQuery(nil);
  try
    try
      pMontaQryConsultaGenerica(objConsulta, qryConsulta);

      if cdsConsulta.Active then
      begin
        cdsConsulta.EmptyDataSet;
        cdsConsulta.Fields.Clear;
        cdsConsulta.FieldDefs.Clear;
        cdsConsulta.Close;
      end;

      cdsConsulta.SetProvider(qryConsulta);
      cdsConsulta.Open;
      cdsConsulta.SetProvider(nil);
    finally
      FreeAndNil(qryConsulta);
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possível retornar os registros da '+
        'tabela '+objConsulta.strTabela+'.'+#13+ 'Motivo: '+e.Message);
    end;
  end;
end;

procedure TConsultaDao.pMontaQryConsultaGenerica(objConsulta: TConsultaModel;
  qryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
var
  intCont: Integer;
begin
  qryConsulta.Close;
  qryConsulta.SQL. Clear;

  qryConsulta.SQL.Text := 'SELECT ';

  for intCont := 0 to objConsulta.stlCampos.Count - 1 do
  begin
    qryConsulta.SQL.Add(' ' + objConsulta.stlCampos[intCont]);
    if (intCont <> objConsulta.stlCampos.Count - 1) then
      qryConsulta.SQL.Add(',');
  end;

  qryConsulta.SQL.Add(' FROM ' + objConsulta.strTabela + ' ');

  if pos('WHERE', objConsulta.strCondicao) > 0 then
    qryConsulta.SQL.Add(objConsulta.strCondicao)
  else if objConsulta.strCondicao <> '' then
    qryConsulta.SQL.Add(' WHERE '+ objConsulta.strCondicao);

  for intCont := 0 to objConsulta.stlCampOrder.Count - 1 do
  begin
    if intCont = 0 then
      qryConsulta.SQL.Add(' ORDER BY ');

    qryConsulta.SQL.Add(' ' + objConsulta.stlCampOrder[intCont]);

    if (intCont <> objConsulta.stlCampOrder.Count - 1) then
      qryConsulta.SQL.Add(',');
  end;
end;

end.
