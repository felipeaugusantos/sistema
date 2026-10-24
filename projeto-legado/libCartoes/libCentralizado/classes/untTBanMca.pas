unit untTBanMca;

interface

uses
  SysUtils, Generics.Collections, System.Classes,  System.StrUtils,

  Uni,

  untLogBan, untTLibCartoesFuncoes;

Type
  TListaBanMCA = TObjectList<TLogBanDS>;

Type
  TBanMcaDS = Class(TLogBanDS)
  private
    FMCA_NUMDUP,
    FMCA_PARCEL,
    FMCA_CODEMP,
    FMCA_CODCLI,
    FMCA_CODCAR,
    FMCA_HIST01,
    FMCA_HIST02,
    FMCA_NUMCCD,
    FMCA_NUMNSU,
    FMCA_IDENTI: String;

    FMCA_VALSTA,
    FMCA_VALTAX,
    FMCA_VALREC,
    FMCA_FREMKT,
    FMCA_VALAJU,
    FMCA_CUPMKT: double;

    function getBandei: string;
    function getCartao: string;
  protected
    procedure AdicionaParametros(ALogBanDS: TLogBanDS;
                                 var ARegistros: TUniQuery); override;
    function RetornaSQLInsert: String; override;

    function getOperad: String; override;
    function getOrigem: String; override;
    function getTabela: String; override;
  public
    property strNumDup: string read FMCA_NUMDUP write FMCA_NUMDUP;
    property strParcel: string read FMCA_PARCEL write FMCA_PARCEL;
    property strCodEmp: string read FMCA_CODEMP write FMCA_CODEMP;
    property strCodCli: string read FMCA_CODCLI write FMCA_CODCLI;
    property strCodCar: string read FMCA_CODCAR write FMCA_CODCAR;
    property strHist01: string read FMCA_HIST01 write FMCA_HIST01;
    property strHist02: string read FMCA_HIST02 write FMCA_HIST02;
    property strNumCcd: string read FMCA_NUMCCD write FMCA_NUMCCD;
    property strNumNsu: string read FMCA_NUMNSU write FMCA_NUMNSU;
    property strIdenti: string read FMCA_IDENTI write FMCA_IDENTI;
    property fltValSta: double read FMCA_VALSTA write FMCA_VALSTA;
    property fltValTax: double read FMCA_VALTAX write FMCA_VALTAX;
    property fltValRec: double read FMCA_VALREC write FMCA_VALREC;
    property fltFreMkt: double read FMCA_FREMKT write FMCA_FREMKT;
    property fltValAju: double read FMCA_VALAJU write FMCA_VALAJU;
    property fltCupMkt: double read FMCA_CUPMKT write FMCA_CUPMKT;
    property strBandei: string read getBandei;
    property strCartao: string read getCartao;
  end;

implementation

{ TBanMcaDS }

procedure TBanMcaDS.AdicionaParametros(ALogBanDS: TLogBanDS;
  var ARegistros: TUniQuery);
  Var
    LBanMcaDS: TBanMcaDS;
begin
  LBanMcaDS := ALogBanDS As TBanMcaDS;

  ARegistros.ParamByName('AUTOIN').AsString := LBanMcaDS.strAutInc;
  ARegistros.ParamByName('SEQLAN').AsString := LBanMcaDS.strSeqLan;

  ARegistros.ParamByName('CODCAR').AsString := LBanMcaDS.strCodCar;
  ARegistros.ParamByName('CODCLI').AsString := LBanMcaDS.strCodCli;
  ARegistros.ParamByName('CODEMP').AsString := LBanMcaDS.strCodEmp;
  ARegistros.ParamByName('HIST01').AsString := LBanMcaDS.strHist01;
  ARegistros.ParamByName('HIST02').AsString := LBanMcaDS.strHist02;
  ARegistros.ParamByName('IDENTI').AsString := LBanMcaDS.strIdenti;
  ARegistros.ParamByName('NUMCCD').AsString := LBanMcaDS.strNumCCD;
  ARegistros.ParamByName('NUMDUP').AsString := LBanMcaDS.strNumDup;
  ARegistros.ParamByName('NUMNSU').AsString := LBanMcaDS.strNumNsu;
  ARegistros.ParamByName('PARCEL').AsString := LBanMcaDS.strParcel;
  ARegistros.ParamByName('VALREC').AsFloat := LBanMcaDS.fltValRec;
  ARegistros.ParamByName('VALSTA').AsFloat := LBanMcaDS.fltValSta;
  ARegistros.ParamByName('VALTAX').AsFloat := LBanMcaDS.fltValTax;
  ARegistros.ParamByName('FREMKT').AsFloat := LBanMcaDS.fltFreMkt;
  ARegistros.ParamByName('VALAJU').AsFloat := LBanMcaDS.fltValAju;
  ARegistros.ParamByName('CUPMKT').AsFloat := LBanMcaDS.fltCupMkt;
end;

function TBanMcaDS.getBandei: string;
begin
  Result := EmptyStr;

  If Not FMCA_CODCAR.IsEmpty Then
    Result := VS_FuncoesExternas.fICampoTabela('CAR_NOMBAN', 'CADCAR', ['CAR_CODCAR'], [FMCA_CODCAR]);
end;

function TBanMcaDS.getCartao: string;
begin
  Result := EmptyStr;

  If Not FMCA_CODCAR.IsEmpty Then
    Result := Concat(FMCA_CODCAR, '-', VS_FuncoesExternas.fICampoTabela('CAR_DESCAR', 'CADCAR', ['CAR_CODCAR'], [FMCA_CODCAR]));
end;

function TBanMcaDS.getOperad: String;
begin
  Result := '';
  If Not VS_FuncoesExternas.fIRetOperadorLogado.IsEmpty Then
    Result := VS_FuncoesExternas.fIRetOperadorLogado + ' - ' +
              TLibCartoesFuncoes.RetornaNomeOperador(VS_FuncoesExternas.fIRetOperadorLogado);
end;

function TBanMcaDS.getOrigem: String;
begin
  Result := 'MCA';
end;

function TBanMcaDS.getTabela: String;
begin
  Result := 'BANMCA';
end;

function TBanMcaDS.RetornaSQLInsert: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO BANMCA ( ';
  Result := Result + '  AUTOINCREM,        ';
  Result := Result + '  CTB_SEQLAN,        ';
  Result := Result + '  MCA_CODCAR,        ';
  Result := Result + '  MCA_CODCLI,        ';
  Result := Result + '  MCA_CODEMP,        ';
  Result := Result + '  MCA_HIST01,        ';
  Result := Result + '  MCA_HIST02,        ';
  Result := Result + '  MCA_IDENTI,        ';
  Result := Result + '  MCA_NUMCCD,        ';
  Result := Result + '  MCA_NUMDUP,        ';
  Result := Result + '  MCA_NUMNSU,        ';
  Result := Result + '  MCA_PARCEL,        ';
  Result := Result + '  MCA_VALREC,        ';
  Result := Result + '  MCA_VALSTA,        ';
  Result := Result + '  MCA_VALTAX,        ';
  Result := Result + '  MCA_FREMKT,        ';
  Result := Result + '  MCA_VALAJU,        ';
  Result := Result + '  MCA_CUPMKT         ';
  Result := Result + ') VALUES (           ';
  Result := Result + '  :AUTOIN,           ';
  Result := Result + '  :SEQLAN,           ';
  Result := Result + '  :CODCAR,           ';
  Result := Result + '  :CODCLI,           ';
  Result := Result + '  :CODEMP,           ';
  Result := Result + '  :HIST01,           ';
  Result := Result + '  :HIST02,           ';
  Result := Result + '  :IDENTI,           ';
  Result := Result + '  :NUMCCD,           ';
  Result := Result + '  :NUMDUP,           ';
  Result := Result + '  :NUMNSU,           ';
  Result := Result + '  :PARCEL,           ';
  Result := Result + '  :VALREC,           ';
  Result := Result + '  :VALSTA,           ';
  Result := Result + '  :VALTAX,           ';
  Result := Result + '  :FREMKT,           ';
  Result := Result + '  :VALAJU,           ';
  Result := Result + '  :CUPMKT            ';
  Result := Result + ')                    ';
end;

end.
