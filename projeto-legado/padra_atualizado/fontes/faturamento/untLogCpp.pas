unit untLogCpp;

interface

uses
  System.SysUtils, Uni;

type
  TLogCpp = class
  private
    qryLogCpp: TUniQuery;
    function fRetornaSQLInsert: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pGravar(strAutIncCpg: String);
  end;

implementation

uses
  untFuncoesSimples;

{ TLogCpp}

constructor TLogCpp.Create;
begin
  qryLogCpp := fCriaQuery;
end;

destructor TLogCpp.Destroy;
begin
  FreeAndNil(qryLogCpp);
end;

function TLogCpp.fRetornaSQLInsert: String;
begin
  Result := 'INSERT INTO LOGCPP (    '+
            '  AUTOINCREM,           '+
            '  LGC_CODEMP,           '+
            '  LGC_CODOPE,           '+
            '  LGC_SEQCPG,           '+
            '  LGC_DTALOG,           '+
            '  LGC_HRALOG            '+
            ')                       '+
            'VALUES                  '+
            '  (                     '+
            '    :AUTOINCREM,        '+
            '    :LGC_CODEMP,        '+
            '    :LGC_CODOPE,        '+
            '    :LGC_SEQCPG,        '+
            '    :LGC_DTALOG,        '+
            '    :LGC_HRALOG         '+
            '  )                     ';
end;

procedure TLogCpp.pGravar(strAutIncCpg: String);
begin
  Try
    fStartTransaction;

    qryLogCpp.Close;
    qryLogCpp.SQL.Clear;
    qryLogCpp.SQL.Text := fRetornaSQLInsert;

    qryLogCpp.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCPP', VS_strCodEmp);
    qryLogCpp.ParamByName('LGC_CODEMP').AsString   := VS_strCodEmp;
    qryLogCpp.ParamByName('LGC_CODOPE').AsString   := strLoginUsuarioLogado;
    qryLogCpp.ParamByName('LGC_SEQCPG').AsString   := strAutIncCpg;
    qryLogCpp.ParamByName('LGC_DTALOG').AsDateTime := VS_Date;
    qryLogCpp.ParamByName('LGC_HRALOG').AsTime     := fRetHoraServidor;
    qryLogCpp.ExecSQL;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

end.
