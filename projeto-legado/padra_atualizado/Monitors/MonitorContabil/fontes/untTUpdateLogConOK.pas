unit untTUpdateLogConOK;

interface

uses untIContabilidade, System.Generics.Collections;

type
  TUpdateLogConOK = Class(TInterfacedObject, IUpdateLogCon)
  public
    procedure Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
    class function New: IUpdateLogCon;
  end;

implementation

uses untFuncoesSimples, Uni, SysUtils;

{ TUpdateLogConOK }

procedure TUpdateLogConOK.Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
  var
    LQryDados: TUniQuery;
    item: IParametrosUpdateLogCon;
begin
  LQryDados := fCriaQuery;
  Try
    try
      fStartTransaction;

      for item in AParams do
      begin
        LQryDados.SQL.Clear;
        LQryDados.SQL.Add(' UPDATE CONLOG  ');
        LQryDados.SQL.Add('    SET LOG_STATUS = :STATUS, ');
        LQryDados.SQL.Add('        LOG_PROCES = :PROCES  ');
        LQryDados.SQL.Add('  WHERE AUTOINCREM = :AUTOIN  ');
        LQryDados.ParamByName('STATUS').AsString := item.Status;
        LQryDados.ParamByName('PROCES').AsInteger := item.Processado;
        LQryDados.ParamByName('AUTOIN').AsInteger := item.Incremento;
        LQryDados.ExecSql;
      end;

      if (AParams[0].Reenvio) then
      begin
        LQryDados.SQL.Clear;
        LQryDados.SQL.Add('DELETE FROM CONLGD WHERE LGD_SEQGER = :SEQGER');
        LQryDados.ParamByName('SEQGER').AsInteger := AParams[0].Incremento;
        LQryDados.ExecSql;
      end;

      fCommit;
    except
      On E: Exception do
      begin
        fRollBack;
        raise;
      end;
    end;
  Finally
    FreeAndNil(LQryDados);
  End;
end;

class function TUpdateLogConOK.New: IUpdateLogCon;
begin
  Result := Self.Create;
end;

end.
