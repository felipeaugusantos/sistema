{*********************************************************}
{* CLASSE PARA CLUBE FIDELIDADE                          *}
{* (MANUTENÇÃO / RELATORIO / POR ENQUANTO)               *}
{*                                                       *}
{* DATA......: 17/03/2008                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untClubeFidelidade;

interface

uses Classes, Uni, UniClientDataSet, UniDataSetProvider, DB, EditFocus,
  untFuncoesSimples, untTypesSistema;

Type TCluFid = Class(TComponent)
  Private
    FCodSeq: String;
    FDtaCad: TDateTime;
    FNumDoc: String;
    FEspDoc: String;
    FCreDeb: String;
    FQtdPto: Double;
    FObs001: String;

    FDtaIni: TDateTime;
    FDtaFin: TDateTime;

    FarrEmp    : TConsultasArray;
    FedtCodEmp : TEditFocus;
    FstrCodEmp : String;

    FarrCli    : TConsultasArray;
    FedtCodCli : TEditFocus;
    FstrCodCli : String;

    {****************************}
    {* FILTRO POR REDE DE LOJAS *}
    {*************************DP*}
    FarrRed    : TConsultasArray;
    FedtCodRed : TEditFocus;
    FstrCodRed : String;

    FarrVen    : TConsultasArray;
    FedtCodVen : TEditFocus;
    FstrCodVen : String;

    FarrRep    : TConsultasArray;
    FedtCodRep : TEditFocus;
    FstrCodRep : String;

    function getDtaCad: String;
    function getQtdPto: String;
    function getDtaFin: String;
    function getDtaIni: String;

    procedure setDtaCad(const Value: String);
    procedure setQtdPto(const Value: String);
    procedure setDtaFin(const Value: String);
    procedure setDtaIni(const Value: String);

    {**************************************}
    {* PROCEDURES E FUNÇÕES GERAIS        *}
    {***********************************AF*}
    procedure pAfterOpen(DataSet: TDataSet);

  Public

    qryCluFid: TUniQuery;
    cpvCluFid: TUniDataSetProvider;
    cdsCluFid: TUniClientDataSet;

    property strCodSeq  : String          Read FCodSeq     Write FCodSeq;
    property strDtaCad  : String          Read getDtaCad   Write setDtaCad;
    property strNumDoc  : String          Read FNumDoc     Write FNumDoc;
    property strEspDoc  : String          Read FEspDoc     Write FEspDoc;
    property strCreDeb  : String          Read FCreDeb     Write FCreDeb;
    property strQtdPto  : String          Read getQtdPto   Write setQtdPto;
    property strObs001  : String          Read FObs001     Write FObs001;
    property strDtaIni  : String          Read getDtaIni   Write setDtaIni;
    property strDtaFin  : String          Read getDtaFin   Write setDtaFin;

    property arrCli     : TConsultasArray Read FarrCli     Write FarrCli;
    property arrEmp     : TConsultasArray Read FarrEmp     Write FarrEmp;
    property arrRed     : TConsultasArray Read FarrRed     Write FarrRed;
    property arrVen     : TConsultasArray Read FarrVen     Write FarrVen;
    property arrRep     : TConsultasArray Read FarrRep     Write FarrRep;

    property edtCodCli  : TEditFocus      Read FedtCodCli  Write FedtCodCli;
    property edtCodEmp  : TEditFocus      Read FedtCodEmp  Write FedtCodEmp;
    property edtCodRed  : TEditFocus      Read FedtCodRed  Write FedtCodRed;
    property edtCodVen  : TEditFocus      Read FedtCodVen  Write FedtCodVen;
    property edtCodRep  : TEditFocus      Read FedtCodRep  Write FedtCodRep;

    property strCodCli  : String          Read FstrCodCli  Write FstrCodCli;
    property strCodEmp  : String          Read FstrCodEmp  Write FstrCodEmp;
    property strCodRed  : String          Read FstrCodRed  Write FstrCodRed;
    property strCodVen  : String          Read FstrCodVen  Write FstrCodVen;
    property strCodRep  : String          Read FstrCodRep  Write FstrCodRep;

    procedure pGeraRelatorioPontuacao(strAnaSin: String);

    function fGravaCluFid(strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCreDeb,
                          strObserv: String;
                          fltQtdPto: Double): Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;
  End;

implementation

uses SysUtils, StrUtils, untFuncoesConsulta;

{ TClubFide }

constructor TCluFid.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  qryCluFid := fCriaQuery(Self);
  qryCluFid.AfterOpen := pAfterOpen;

  cpvCluFid := TUniDataSetProvider.Create(Self);
  cpvCluFid.DataSet := qryCluFid;

  cdsCluFid := TUniClientDataSet.Create(Self);
  cdsCluFid.SetProvider(cpvCluFid);

  With qryCluFid Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CLUFID LIMIT 0');
  End;

end;

destructor TCluFid.Destroy;
Begin
  FreeAndNil(qryCluFid);
  FreeAndNil(cdsCluFid);
  FreeAndNil(cpvCluFid);
  inherited Destroy;
End;

function TCluFid.getDtaCad: String;
begin
  Result := IfThen(FDtaCad = 0, '', FormatDateTime('dd/mm/yyyy',FDtaCad));
end;

function TCluFid.getQtdPto: String;
begin
  Result := FloatToStrF(FQtdPto,ffFixed,12,2);
end;

procedure TCluFid.pAfterOpen(DataSet: TDataSet);
begin

  With qryCluFid Do
  Begin
    (FieldByName('FID_DTACAD') As TDateField).EditMask       := '99/99/9999';
    (FieldByName('FID_QTDPTO') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('FID_QTDPTO') As TFloatField).EditFormat    := '#,##0.00';
  End;

end;

procedure TCluFid.setDtaCad(const Value: String);
begin
  FDtaCad := StrToDateDef(Value,0);
end;

procedure TCluFid.setQtdPto(const Value: String);
begin
  FQtdPto := fStrToFloat(Value);
end;

function TCluFid.fGravaCluFid(strNumDoc,
                              strEspDoc,
                              strCodCli,
                              strCreDeb,
                              strObserv: String;
                              fltQtdPto: Double): Boolean;
Var
  strESPNPC : String;
Begin

  Try
    Result := True;

    strESPNPC := fCfgSis('ESPNPC', VarString);

    If (Not fEmptyStr(strEspDoc)) And (strESPNPC.Contains(strEspDoc)) Then
      Exit(True);

    If fltQtdPto = 0 Then
      Exit(True);

    With qryCluFid Do
    Begin
      If Not Active Then
        Open;

      Insert;

      FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CLUFID',VS_strCodEmp);
      FieldByName('FID_CODFID').AsString   := fAtualizaProCod('CLUFID', 'FID_CODFID');
      FieldByName('FID_DTACAD').AsDateTime := VS_Date;
      FieldByName('FID_NUMDOC').AsString   := strNumDoc;
      FieldByName('FID_ESPDOC').AsString   := strEspDoc;
      FieldByName('FID_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('FID_CODCLI').AsString   := strCodCli;
      FieldByName('FID_CREDEB').AsString   := strCreDeb;
      FieldByName('FID_OBS001').AsString   := strObserv;
      FieldByName('FID_QTDPTO').AsFloat    := fltQtdPto;

      Post;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaCluFid]');
    End;
  End;

End;

function TCluFid.getDtaFin: String;
begin
  Result := IfThen(FDtaFin = 0, '', FormatDateTime('dd/mm/yyyy', FDtaFin));
end;

function TCluFid.getDtaIni: String;
begin
  Result := IfThen(FDtaIni = 0, '', FormatDateTime('dd/mm/yyyy', FDtaIni));
end;

procedure TCluFid.setDtaFin(const Value: String);
begin
  FDtaFin := StrToDateDef(Value, 0);
end;

procedure TCluFid.setDtaIni(const Value: String);
begin
  FDtaIni := StrToDateDef(Value, 0);
end;

{**************************************}
{* GERA O RELATÓRIO DE PONTUAÇÃO      *}
{***********************************AF*}
procedure TCluFid.pGeraRelatorioPontuacao(strAnaSin: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FID_DTACAD, ';
  strSQL := strSQL + '  FID_NUMDOC, ';
  strSQL := strSQL + '  FID_ESPDOC, ';
  strSQL := strSQL + '  FID_CODEMP, ';
  strSQL := strSQL + '  FID_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';

  If strAnaSin = 'A' Then
    strSQL := strSQL + '  FID_QTDPTO, '
  Else
    strSQL := strSQL + '  SUM(IF(FID_CREDEB = "C", FID_QTDPTO, -FID_QTDPTO)) AS FID_QTDPTO, ';

  strSQL := strSQL + '  FID_CREDEB, ';
  strSQL := strSQL + '  FID_OBS001  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  CLUFID      ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = FID_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FID_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  {***************************}
  {* FILTRO DE REDE DE LOJAS *}
  {************************DP*}
  strSQL := strSQL + fStrLocate(FedtCodCli, FarrCli, 'FID_CODCLI', 'CODCLI');
  strSQL := strSQL + fStrLocateEmpresa(FedtCodEmp, FarrEmp, 'FID_CODEMP', 'CODEMP');
  strSQL := strSQL + fStrLocate(FedtCodRed, FarrRed, 'CLI_CODRED', 'CODRED');
  strSQL := strSQL + fStrLocate(FedtCodVen, FarrVen, 'CLI_CODVEN', 'CODVEN');
  strSQL := strSQL + fStrLocate(FedtCodRep, FarrRep, 'CLI_CODREP', 'CODREP');

  If strAnaSin = 'A' Then
  Begin
    strSQL := strSQL + 'ORDER BY     ';
    strSQL := strSQL + '  CLI_NOMCLI ';
  End
  Else
  Begin
    strSQL := strSQL + 'GROUP BY     ';
    strSQL := strSQL + '  FID_CODCLI ';
    strSQL := strSQL + 'ORDER BY     ';
    strSQL := strSQL + '  FID_CODCLI ';
  End;

  With qryCluFid Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate := FDtaIni;
    ParamByName('DTAFIN').AsDate := FDtaFin;

    pSetaParam(FedtCodCli.Text, FarrCli, FstrCodCli, 'CODCLI', qryCluFid);
    pSetaParam(FedtCodEmp.Text, FarrEmp, FstrCodEmp, 'CODEMP', qryCluFid);
    pSetaParam(FedtCodRed.Text, FarrRed, FstrCodRed, 'CODRED', qryCluFid);
    pSetaParam(FedtCodVen.Text, FarrVen, FstrCodVen, 'CODVEN', qryCluFid);
    pSetaParam(FedtCodRep.Text, FarrRep, FstrCodRep, 'CODREP', qryCluFid);

    Open;

    If IsEmpty Then
      Raise Exception.Create('Não há dados para gerar relatório!');

  End;

end;

end.

