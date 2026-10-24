unit untTRelacionamentoClienteProdutoGarantia;

interface

uses untIRelacionamentoClienteProdutoGarantia, untFuncoesSimples, Uni,
  System.SysUtils;

type
  TRelacionamentoClienteProdutoGarantia = class(TInterfacedObject, IRelacionamentoClienteProdutoGarantia)
  private
  public
    function GetSQL: String;
    procedure Excluir(const AAutInc: String);
    procedure Atualizar(const AAutInc, ACodIte: String);

    class function New(): IRelacionamentoClienteProdutoGarantia;
  end;

implementation

{ TRelacionamentoClienteProdutoGarantia }

procedure TRelacionamentoClienteProdutoGarantia.Atualizar(const AAutInc,
  ACodIte: String);
var
  qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery(Nil);
  Try
    qryUpd.Close;
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE ITECLI SET ITE_CODITE = :CODITE WHERE AUTOINCREM = :AUTINC');
    qryUpd.ParamByName('CODITE').AsString := ACodIte;
    qryUpd.ParamByName('AUTINC').AsString := AAutInc;
    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TRelacionamentoClienteProdutoGarantia.Excluir(const AAutInc: String);
var
  qryDel: TUniQuery;
begin
  qryDel := fCriaQuery(Nil);
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM ITECLI WHERE AUTOINCREM = :AUTINC');
    qryDel.ParamByName('AUTINC').AsString := AAutInc;
    qryDel.ExecSQL;
  Finally
    FreeAndNil(qryDel);
  End;
end;

function TRelacionamentoClienteProdutoGarantia.GetSQL: String;
begin
  Result := Result + 'SELECT I.ITE_CODITE   AS CODITE, ';
  Result := Result + '       I.ITE_DESITE   AS DESITE, ';
  Result := Result + '       C.CLI_CODCLI   AS CODCLI, ';
  Result := Result + '       C.CLI_NOMCLI   AS NOMCLI, ';
  Result := Result + '       ITC.ITE_CODITC AS CODITC, ';
  Result := Result + '       ITC.AUTOINCREM AS AUTINC  ';
  Result := Result + '  FROM ITECLI ITC ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = ITC.ITE_CODITE ';
  Result := Result + ' INNER JOIN CADCLI C ON C.CLI_CODCLI = ITC.ITE_CODCLI ';

  Result := Result + ' WHERE (1=1) ';
end;

class function TRelacionamentoClienteProdutoGarantia.New: IRelacionamentoClienteProdutoGarantia;
begin
  Result := Self.Create;
end;

end.
