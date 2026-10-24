unit untTUpdateLogConER;

interface

uses untIContabilidade, System.Generics.Collections;

type
  TUpdateLogConER = Class(TInterfacedObject, IUpdateLogCon)
  public
    procedure Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
    class function New: IUpdateLogCon;
  end;

implementation

uses untFuncoesSimples, Uni, SysUtils, Classes;

{ TUpdateLogConER }

procedure TUpdateLogConER.Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
  var
    LQryDados: TUniQuery;
    item : IParametrosUpdateLogCon;
    LlstControle: TStringList ;
begin
  LQryDados := fCriaQuery;
  LlstControle := TStringList.Create ;
  Try
    LlstControle.Sorted := True ;
    try
      fStartTransaction;

      if (AParams[0].Reenvio) then
      begin
        LQryDados.SQL.Clear;
        LQryDados.SQL.Add('DELETE FROM CONLGD WHERE LGD_SEQGER = :SEQGER');
        LQryDados.ParamByName('SEQGER').AsInteger := AParams[0].Incremento;
        LQryDados.ExecSql;
      end;

      for item in AParams do
      begin

        if LlstControle.IndexOf(IntToStr(item.Incremento)) = -1 then
        begin
          LlstControle.Add(IntToStr(item.Incremento)) ;
          LQryDados.SQL.Clear;
          LQryDados.SQL.Add(' UPDATE CONLOG  ');
          LQryDados.SQL.Add('    SET LOG_STATUS = :STATUS, ');
          LQryDados.SQL.Add('        LOG_PROCES = :PROCES  ');
          LQryDados.SQL.Add('  WHERE AUTOINCREM = :AUTOIN  ');
          LQryDados.ParamByName('STATUS').AsString := item.Status;
          LQryDados.ParamByName('PROCES').AsInteger := item.Processado;
          LQryDados.ParamByName('AUTOIN').AsInteger := item.Incremento;
          LQryDados.ExecSql;
        end ;

        LQryDados.SQL.Clear;
        LQryDados.SQL.Add(' INSERT INTO CONLGD (LGD_INCONS, LGD_ORIPLA, LGD_HISTOR, LGD_DESVAL, LGD_NATOPE, LGD_SEQGER) ');
        LQryDados.SQL.Add('    VALUES (:INCONS, :ORIPLA, :HISTOR, :DESVAL, :NATOPE, :SEQGER) ');
        LQryDados.ParamByName('INCONS').AsString := item.Inconsistencia;
        LQryDados.ParamByName('ORIPLA').AsString := item.Origem;
        LQryDados.ParamByName('HISTOR').AsString := item.Historico;
        LQryDados.ParamByName('DESVAL').AsString := item.DescricaoValor;
        LQryDados.ParamByName('NATOPE').AsString := item.NaturezaOperacao;
        LQryDados.ParamByName('SEQGER').AsInteger := item.Incremento;
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
    FreeAndNil(LlstControle) ;
  End;
end;

class function TUpdateLogConER.New: IUpdateLogCon;
begin
  Result := Self.Create;
end;

end.
