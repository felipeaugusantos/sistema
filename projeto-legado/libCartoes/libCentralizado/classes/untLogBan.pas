unit untLogBan;

interface

uses
  System.SysUtils, Generics.Collections, System.Classes,

  Uni,

  untTLibCartoesFuncoes, untTBatchSQL, untTBatchSQL.Helper;

Type
  TLogBanDS = Class
  private
    FAUTOINCREM,
    FCTB_SEQLAN: String;
  protected
    function RetornaSQLInsert: String; virtual;
    procedure AdicionaParametros(ALogBanDS: TLogBanDS; var ARegistros: TUniQuery); virtual;

    function getOperad: string; virtual;
    function getOrigem: string; virtual;
    function getTabela: string; virtual;
  public
    property strAutInc: string    read FAUTOINCREM write FAUTOINCREM;
    property strSeqLan: String    read FCTB_SEQLAN write FCTB_SEQLAN;
    property strOperad: string    read getOperad;
    property fGetOrigem: string   read getOrigem;
    property strTabela: string    read getTabela;
  End;

Type
  TGravaLogBanDS = Class
  private
  public
    class function GravaLogBanDS(ALogBan: TLogBanDS;
                                 strCodEmp: String;
                                 strSeqLan: String;
                                 ABatchSQL: TBatchSQL = Nil): Boolean;

    class function fGetOrigem(ALogBan: TLogBanDS): String;
  End;

implementation

{ TLogBanDS }

procedure TLogBanDS.AdicionaParametros(ALogBanDS: TLogBanDS;
  var ARegistros: TUniQuery);
begin
  //criar no filho
end;

function TLogBanDS.getOperad: string;
begin
  //criar no filho
end;

function TLogBanDS.getOrigem: string;
begin
  //criar no filho
end;

function TLogBanDS.getTabela: string;
begin
  //criar no filho
end;

function TLogBanDS.RetornaSQLInsert: String;
begin
  //criar no filho
end;

{ TGravaLogBanDS }

class function TGravaLogBanDS.fGetOrigem(ALogBan: TLogBanDS): String;
begin
  Result := ALogBan.fGetOrigem;
end;

class function TGravaLogBanDS.GravaLogBanDS(ALogBan: TLogBanDS; strCodEmp,
  strSeqLan: String; ABatchSQL: TBatchSQL = Nil): Boolean;
  Var
    LGravarRegistros: TUniQuery;
begin
  Result := False;

  LGravarRegistros := VS_FuncoesExternas.fICriaQuery;

  Try
    Try
      ALogBan.strSeqLan := strSeqLan;

      If ALogBan.strAutInc.IsEmpty Then
        ALogBan.strAutInc := VS_FuncoesExternas.fIRetAutoIncrem(ALogBan.strTabela, strCodEmp);

      LGravarRegistros.SQL.Text := ALogBan.RetornaSQLInsert;
      ALogBan.AdicionaParametros(ALogBan, LGravarRegistros);

      If Assigned(ABatchSQL) Then
        TBatchHelper.AddQueryToBatch(ABatchSQL, LGravarRegistros)
      Else
        LGravarRegistros.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    LGravarRegistros.Close;

    FreeAndNil(LGravarRegistros);
  End;
end;

end.
