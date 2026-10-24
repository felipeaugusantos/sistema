unit EmailContasReceber.Classes;

interface

uses System.Generics.Collections;

  Type

  TEmailContaReceber = class
    FstrID              : String;
    FstrNumeroDuplicata : String;
    FstrEspecie         : String;
    FstrCodigoEmpresa   : String;
    FstrParcela         : String;
    FstrCodigooOperador : String;
    FstrParametroEmail  : String;
    FblnEmailEnviado    : Boolean;
  public
    property strId              : String     read FstrID              write FstrID;
    property strNumeroDuplicata : String     read FstrNumeroDuplicata write FstrNumeroDuplicata;
    property strEspecie         : String     read FstrEspecie         write FstrEspecie;
    property strCodigoEmpresa   : String     read FstrCodigoEmpresa   write FstrCodigoEmpresa;
    property strParcela         : String     read FstrParcela         write FstrParcela;
    property strCodigooOperador : String     read FstrCodigooOperador write FstrCodigooOperador;
    property strParametroEmail  : String     read FstrParametroEmail  write FstrParametroEmail;
    property blnEmailEnviado    : Boolean    read FblnEmailEnviado    write FblnEmailEnviado;
  end;

  TEmailContaReceberRepositorio = class
  private
    function fGravar(AobjEmailContaReceber : TEmailContaReceber) : Boolean;
  end;

  TEmailContaReceberBuilder = class
    FstrNumeroDuplicata              : String;
    FstrEspecie                      : String;
    FstrCodigoEmpresa                : String;
    FstrParcela                      : String;
    FstrCodigooOperador              : String;
    FstrParametroEmail               : String;
    FblnEmailEnviado                 : Boolean;
    FobjEmailContaReceberRepositorio : TEmailContaReceberRepositorio;
  public
    constructor Create;
    destructor Destroy; override;

    function fGravar : Boolean;

    property strNumeroDuplicata       : String                           read FstrNumeroDuplicata write FstrNumeroDuplicata;
    property strEspecie               : String                           read FstrEspecie         write FstrEspecie;
    property strCodigoEmpresa         : String                           read FstrCodigoEmpresa   write FstrCodigoEmpresa;
    property strParcela               : String                           read FstrParcela         write FstrParcela;
    property strCodigooOperador       : String                           read FstrCodigooOperador write FstrCodigooOperador;
    property strParametroEmail        : String                           read FstrParametroEmail  write FstrParametroEmail;
    property blnEmailEnviado          : Boolean                          read FblnEmailEnviado    write FblnEmailEnviado;
  end;

implementation

uses untFuncoesSimples, Uni, Data.DB, System.Classes, SysUtils, untFuncoes,
     untTypesSistema;

{ TEmailContaReceberRepositorio }

function TEmailContaReceberRepositorio.fGravar(AobjEmailContaReceber: TEmailContaReceber): Boolean;
  Var
    LQuery : TUniQuery;
Begin
  Try
    Result := True;

    LQuery := fCriaQuery;
    Try
      LQuery.SQL.Text := ' INSERT INTO EMACTR (AUTOINCREM, CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_PARCEL, CTR_CODOPE, CTR_PARAME, CTR_DTACAD '+
                         ' ,CTR_HORCAD, CTR_EMAENV) '+
                         ' VALUES (:AUTINC, :NUMDUP, :ESPDOC, :CODEMP, :PARCEL, :CODOPE, :PARAME, :DTACAD, :HORCAD, :EMAENV) ';

      LQuery.ParamByName('AUTINC').AsString   := fRetAutoIncrem('EMACTR', VS_strCodEmp);
      LQuery.ParamByName('NUMDUP').AsString   := AobjEmailContaReceber.strNumeroDuplicata;
      LQuery.ParamByName('ESPDOC').AsString   := AobjEmailContaReceber.strEspecie;
      LQuery.ParamByName('CODEMP').AsString   := AobjEmailContaReceber.strCodigoEmpresa;
      LQuery.ParamByName('PARCEL').AsString   := AobjEmailContaReceber.strParcela;
      LQuery.ParamByName('CODOPE').AsString   := AobjEmailContaReceber.strCodigooOperador;
      LQuery.ParamByName('PARAME').AsString   := AobjEmailContaReceber.strParametroEmail;
      LQuery.ParamByName('DTACAD').AsDateTime := SysUtils.Date;
      LQuery.ParamByName('HORCAD').AsDateTime := SysUtils.Time;
      LQuery.ParamByName('EMAENV').AsString   := IIF(AobjEmailContaReceber.blnEmailEnviado, 'S', 'N');
      LQuery.ExecSQL

    Finally
      FreeAndNil(LQuery);
    End;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TEmailContaReceberRepositorio.fGravar');
    End;
  End;
end;

{ TEmailContaReceberBuilder }

constructor TEmailContaReceberBuilder.Create;
begin
  inherited;
  FobjEmailContaReceberRepositorio := TEmailContaReceberRepositorio.Create;
end;

destructor TEmailContaReceberBuilder.Destroy;
begin
  FreeAndNil(FobjEmailContaReceberRepositorio);
  inherited;
end;

function TEmailContaReceberBuilder.fGravar : Boolean;
  var
    LobjEmailContaReceber : TEmailContaReceber;
begin
  Try
    LobjEmailContaReceber                    := TEmailContaReceber.Create;
    LobjEmailContaReceber.strNumeroDuplicata := FstrNumeroDuplicata;
    LobjEmailContaReceber.strEspecie         := FstrEspecie;
    LobjEmailContaReceber.strCodigoEmpresa   := FstrCodigoEmpresa;
    LobjEmailContaReceber.strParcela         := FstrParcela;
    LobjEmailContaReceber.strCodigooOperador := FstrCodigooOperador;
    LobjEmailContaReceber.strParametroEmail  := FstrParametroEmail;
    LobjEmailContaReceber.blnEmailEnviado    := FblnEmailEnviado;

    Result := FobjEmailContaReceberRepositorio.fGravar(LobjEmailContaReceber);
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TEmailContaReceberBuilder.fGravar');
    End;
  End;
end;


end.
