unit untTBanTrf;

interface

uses
  System.SysUtils, Generics.Collections, System.Classes, untLogBan, Uni;

Type
  TListaBanTrf = TList<TLogBanDS>;

type
  TBanTrfDS = Class(TLogBanDS)
  private
    FRCX_CODOPE,
    FRCX_CODEMP,
    FRCX_DESCRI: String;

    FRCX_VALDOC,
    FRCX_DINREC,
    FRCX_CHQAVI,
    FRCX_CHQPRE,
    FRCX_CARREC,
    FRCX_ORDREC,
    FRCX_VALFIN: Double;
  protected
    procedure AdicionaParametros(ALogBanDS: TLogBanDS;
                                 var ARegistros: TUniQuery); override;
    function RetornaSQLInsert: String; override;

    function getOperad: String; override;
    function getOrigem: String; override;
    function getTabela: String; override;
  public
    property strCodOpe: string    read FRCX_CODOPE write FRCX_CODOPE;
    property strCodEmp: string    read FRCX_CODEMP write FRCX_CODEMP;
    property strDescri: string    read FRCX_DESCRI write FRCX_DESCRI;
    property fltValDoc: double    read FRCX_VALDOC write FRCX_VALDOC;
    property fltDinRec: double    read FRCX_DINREC write FRCX_DINREC;
    property fltChqAvi: double    read FRCX_CHQAVI write FRCX_CHQAVI;
    property fltChqPre: double    read FRCX_CHQPRE write FRCX_CHQPRE;
    property fltCarRec: double    read FRCX_CARREC write FRCX_CARREC;
    property fltOrdRec: double    read FRCX_ORDREC write FRCX_ORDREC;
    property fltValFin: double    read FRCX_VALFIN write FRCX_VALFIN;
  end;

implementation

uses untFuncoesSimples;

{ TBanTrfDS }

function TBanTrfDS.getOrigem: String;
begin
  Result := 'TRF';
end;

function TBanTrfDS.getTabela: String;
begin
  Result := 'BANTRF';
end;

function TBanTrfDS.getOperad: string;
begin
  Result := '';
  If Not FRCX_CODOPE.IsEmpty Then
    Result := FRCX_CODOPE + ' - ' + fRetNomeOperador(FRCX_CODOPE);
end;

procedure TBanTrfDS.AdicionaParametros(ALogBanDS: TLogBanDS;
  var ARegistros: TUniQuery);
  Var
    LBanTrfDS: TBanTrfDS;
begin
  LBanTrfDS := ALogBanDS As TBanTrfDS;

  ARegistros.ParamByName('AUTOIN').AsString := LBanTrfDS.strAutInc;
  ARegistros.ParamByName('SEQLAN').AsString := LBanTrfDS.strSeqLan;

  ARegistros.ParamByName('CODOPE').AsString := LBanTrfDS.strCodOpe;
  ARegistros.ParamByName('CODEMP').AsString := LBanTrfDS.strCodEmp;
  ARegistros.ParamByName('DESCRI').AsString := LBanTrfDS.strDescri;

  ARegistros.ParamByName('VALDOC').AsFloat := LBanTrfDS.fltValDoc;
  ARegistros.ParamByName('DINREC').AsFloat := LBanTrfDS.fltDinRec;
  ARegistros.ParamByName('CHQAVI').AsFloat := LBanTrfDS.fltChqAvi;
  ARegistros.ParamByName('CHQPRE').AsFloat := LBanTrfDS.fltChqPre;
  ARegistros.ParamByName('CARREC').AsFloat := LBanTrfDS.fltCarRec;
  ARegistros.ParamByName('ORDREC').AsFloat := LBanTrfDS.fltOrdRec;
  ARegistros.ParamByName('VALFIN').AsFloat := LBanTrfDS.fltValFin;
end;

function TBanTrfDS.RetornaSQLInsert: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO BANTRF ( ';
  Result := Result + '  AUTOINCREM,        ';
  Result := Result + '  CTB_SEQLAN,        ';
  Result := Result + '  RCX_CARREC,        ';
  Result := Result + '  RCX_CHQAVI,        ';
  Result := Result + '  RCX_CHQPRE,        ';
  Result := Result + '  RCX_CODEMP,        ';
  Result := Result + '  RCX_CODOPE,        ';
  Result := Result + '  RCX_DESCRI,        ';
  Result := Result + '  RCX_DINREC,        ';
  Result := Result + '  RCX_ORDREC,        ';
  Result := Result + '  RCX_VALDOC,        ';
  Result := Result + '  RCX_VALFIN         ';
  Result := Result + ') VALUES (           ';
  Result := Result + '  :AUTOIN,           ';
  Result := Result + '  :SEQLAN,           ';
  Result := Result + '  :CARREC,           ';
  Result := Result + '  :CHQAVI,           ';
  Result := Result + '  :CHQPRE,           ';
  Result := Result + '  :CODEMP,           ';
  Result := Result + '  :CODOPE,           ';
  Result := Result + '  :DESCRI,           ';
  Result := Result + '  :DINREC,           ';
  Result := Result + '  :ORDREC,           ';
  Result := Result + '  :VALDOC,           ';
  Result := Result + '  :VALFIN            ';
  Result := Result + ')                    ';
end;

end.
