unit untTUpdateLogConWN;

interface

uses untIContabilidade, System.Generics.Collections, Uni;

type
  TUpdateLogConWN = Class(TInterfacedObject, IUpdateLogCon)
  private
    function fGetSqlInsert(const AFieldExcecao:boolean):string ;
    function fVerificaExcecao(const AFiltroExcecao: String; AQryExcecao: TUniQuery; const AIncons, AHistor : string):integer ;
  public
    procedure Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
    class function New: IUpdateLogCon;
  end;

implementation

uses untFuncoesSimples, SysUtils, Data.DB, Classes;

{ TUpdateLogConWN }

procedure TUpdateLogConWN.Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
  var
    LQryDados: TUniQuery;
    item : IParametrosUpdateLogCon;
    LQryExcecao: TUniQuery;
    blnFieldExcecao: Boolean;
    LlstControle: TStringList ;
begin
  LQryDados := fCriaQuery;
  LQryExcecao := fCriaQuery;
  LlstControle := TStringList.Create ;
  Try
    LlstControle.Sorted := True ;
    try
      blnFieldExcecao := fCampoExiste('CONLGD', 'LGD_EXCECA');

      fStartTransaction;

      if (AParams.Count > 0) and (AParams[0].Reenvio) then
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
        LQryDados.SQL.Add(fGetSqlInsert(blnFieldExcecao));
        LQryDados.ParamByName('INCONS').AsString := item.Inconsistencia;
        LQryDados.ParamByName('ORIPLA').AsString := item.Origem;
        LQryDados.ParamByName('HISTOR').AsString := item.Historico;
        LQryDados.ParamByName('DESVAL').AsString := item.DescricaoValor;
        LQryDados.ParamByName('NATOPE').AsString := item.NaturezaOperacao;
        LQryDados.ParamByName('SEQGER').AsInteger := item.Incremento;
        if blnFieldExcecao then
        begin
          LQryDados.ParamByName('EXCECA').AsInteger := fVerificaExcecao(AFiltroExcecao,
                                                                        LQryExcecao,
                                                                        item.Inconsistencia,
                                                                        item.Historico);
        end;

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
    FreeAndNil(LQryExcecao);
    FreeAndNil(LlstControle);
  End;
end;

function TUpdateLogConWN.fGetSqlInsert(const AFieldExcecao: boolean): string;
begin
  if AFieldExcecao then
  begin
    result := 'INSERT INTO CONLGD (LGD_INCONS, LGD_ORIPLA, LGD_HISTOR, LGD_DESVAL, LGD_NATOPE, LGD_SEQGER, LGD_EXCECA) ' ;
    result := result + ' VALUES (:INCONS, :ORIPLA, :HISTOR, :DESVAL, :NATOPE, :SEQGER, :EXCECA) ;' ;
  end
  else
  begin
    result := 'INSERT INTO CONLGD (LGD_INCONS, LGD_ORIPLA, LGD_HISTOR, LGD_DESVAL, LGD_NATOPE, LGD_SEQGER) ' ;
    result := result + ' VALUES (:INCONS, :ORIPLA, :HISTOR, :DESVAL, :NATOPE, :SEQGER) ;' ;
  end;
end;

function TUpdateLogConWN.fVerificaExcecao(const AFiltroExcecao: String; AQryExcecao: TUniQuery; const AIncons, AHistor : string): integer;
begin
  result := 0 ;
  if not fEmptyStr(AFiltroExcecao) then
  begin
    AQryExcecao.Close ;
    AQryExcecao.SQL.Clear ;
    AQryExcecao.SQL.Add(' SELECT 1 FROM ( ') ;
    AQryExcecao.SQL.Add(' 	SELECT "'+ AHistor +'" AS LGD_HISTOR, "'+ AIncons +'" AS LGD_INCONS ') ;
    AQryExcecao.SQL.Add(' ) AS SEL WHERE '+ AFiltroExcecao ) ;
    AQryExcecao.Open ;
    if not AQryExcecao.IsEmpty then
    begin
      result := 1 ;
    end;
  end;
end;

class function TUpdateLogConWN.New: IUpdateLogCon;
begin
  Result := Self.Create;
end;

end.
