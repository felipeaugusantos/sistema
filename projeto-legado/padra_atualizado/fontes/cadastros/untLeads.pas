unit untLeads;

interface

uses untILeads, untFuncoesSimples, System.strUtils, System.SysUtils, EditFocus,
  untZClient, System.Variants, Vcl.Graphics, Data.DB, BitBtnLockedIncrem, Vcl.StdCtrls,
  Uni, untTypesCRM;

type
  TLeads = class(TInterfacedObject, ILeads)
  private
    FFaturamentoParcial: Boolean;
    FStatusLead: TStatusLead;
    FNumLead: String;
    FAutInc: String;
    FTip_Fc: String;
    FCodCli: String;
    FstrNomeFrmOrigem: String;
    FDatIniObr: TDateTime;
    FVenExt: String;
    FCodFas: String;
    FDatPreOrc: TDateTime;
    FRegist: String;
    FDescon: String;
    FstrNomPro: String;
    FCodIns: String;
    FfltTotVPr: Double;
    FstrStatus: String;
    FCodVen: String;
    FDtaUltAlt: TDateTime;
    FCodEmp: String;

    function GetStatusLead: TStatusLead;
    procedure SetStatusLead(const AValue: TStatusLead);
    function GetTip_Fc: string;
    procedure SetTip_Fc(const AValue: string);
    function GetNumLead: string;
    procedure SetNumLead(const AValue: string);
    function GetAutInc: string;
    procedure SetAutInc(const AValue: string);
    function GetCodCli: string;
    procedure SetCodCli(const AValue: string);
    procedure pAlterarStatusLeadReabrir(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
    procedure pAlterarStatusLeadFinalizar(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
    procedure pAlterarStatusLeadAberto(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
    procedure pAlterarStatusLeadFaturamentoParcial(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
    function fRetornaSQLOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto: String;
    function fStatusLeadToColor(const AStatus: TStatusLead): TColor;
    function fStatusLeadToStrDescri(const AStatus: TStatusLead): string;
    function fStatusLeadToStr(const AStatus: TStatusLead): string;
    function fStrToStatusLead(const AStatus: String): TStatusLead;
    function fExitemOcorrencias(const AAutInc: String): Boolean;
    function fRetornaSQLUpdateOrcamento: String;


    function GetNmFrmOri: String;
    procedure SetNmFrmOri(const AValue: String);
    function GetDatIniObr: TDateTime;
    procedure SetDatIniObr(const AValue: TDateTime);
    function GetVenExt: String;
    procedure SetVenExt(const AValue: String);
    function GetCodFas: String;
    procedure SetCodFas(const AValue: String);
    function GetDatPreOrc: TDateTime;
    procedure SetDatPreOrc(const AValue: TDateTime);
    function GetRegist: String;
    procedure SetRegist(const AValue: String);
    function GetDescon: String;
    procedure SetDescon(const AValue: String);
    function GetNomPro: String;
    procedure SetNomPro(const AValue: String);
    function GetCodIns: String;
    procedure SetCodIns(const AValue: String);
    function GetTotVPr: Double;
    procedure SetTotVPr(const AValue: Double);
    function GetstrStatus: String;
    procedure SetstrStatus(const AValue: String);
    function GetCodVen: String;
    procedure SetCodVen(const AValue: String);
    function GetDtaUltAlt: TDateTime;
    procedure SetDtaUltAlt(const AValue: TDateTime);
    function GetCodEmp: String;
    procedure SetCodEmp(const AValue: String);
  public
    function fRetornaStatusLead(const ADataSet: TDataSet): TStatusLead; overload;
    function fRetornaStatusLead(const AStatus: String): TStatusLead; overload;
    function fObtemStatusLead(const AAutInc: string): TStatusLead;
    procedure pAlterarStatusLead(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus;
      btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
    function fPermitidoExecutarOperacao(const ADataSet: TDataSet): Boolean;
    function fRetornaOperadorFormatado(const ACodOperador: String): String;
    function fExitemOcorrenciasVinculadasAoLeadEmAberto(const ADataSet: TDataSet): Boolean;
    procedure pExibirMensagemFinalizarLeadEmAberto;
    function fExitemOrcamentosVinculadosAoLead(const ANumeroLead: String): Boolean;
    function fExitemOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto(const ANumeroLead: String): Boolean;
    procedure pAtualizaInformacoesGeraisDoLead(lblStatusLead: TLabel; btnFinalizarLead: TBitBtnLocked;
      edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; const ADataSet: TDataSet);
    function fFinalizarLead(const ADataSet: TDataSet): Boolean;
    function fObterStatusLeadAndamento(const AAutInc, ANumLead: String): TStatusLead;
    procedure pAtualizaStatusLeadAndamento(const AAutInc, ANumLead: String);
    procedure pLimpar;
    function fAlterarStatusLeadBancoDados(const AStatus: TStatusLead; const AAutInc: string; Finalizar: Boolean = False; strFrmOri: String = ''): Boolean;

    procedure pVincularOrcamentoAoLead(const strOrcamento: string);
    procedure pDesVincularOrcamentoAoLead(const strOrcamento: string);
    procedure pGravarLogLadGer;
    procedure pCarregarDadosLead(const strAutInc: String);
    procedure pSetDadosLead(const ADataSet: TDataSet);

    class function New(): ILeads;

    class function IndiceToStatusLead(const Indice: Integer): TStatusLead;
    class function fObterNumLead(const ACodemp, ACodEsp, ANumDoc: String): string; overload;
    class function fObterNumLead(const ACodOco: String): string;overload;
    class function IndiceToTipoOrdenacao(const Indice: Integer): TOrdCnsLead;

    property StatusLead: TStatusLead read GetStatusLead write SetStatusLead;
    property Tip_Fc: String read GetTip_Fc write SetTip_Fc;
    property strNumLead: String read GetNumLead write SetNumLead;
    property strAutInc: String read GetAutInc write SetAutInc;
    property strCodCli: String read GetCodCli write SetCodCli;
    property strNomeFrmOrigem: String read GetNmFrmOri write SetNmFrmOri;
    property DatIniObr: TDateTime read GetDatIniObr write SetDatIniObr;
    property strVenExt: String read GetVenExt write SetVenExt;
    property strCodFas: String read GetCodFas write SetCodFas;
    property DatPreOrc: TDateTime read GetDatPreOrc write SetDatPreOrc;
    property Registro: String read GetRegist write SetRegist;
    property Desconto: String read GetDescon write SetDescon;
    property strNomPro: String read GetNomPro write SetNomPro;
    property strCodIns: String read GetCodIns write SetCodIns;
    property fltTotVPr: Double read GetTotVPr write SetTotVPr;
    property strStatus: String read GetstrStatus write SetstrStatus;
    property strCodVen: String read GetCodVen write SetCodVen;
    property DtaUltAlt: TDateTime read GetDtaUltAlt write SetDtaUltAlt;
    property strCodEmp: String read GetCodEmp write SetCodEmp;

  end;

  const
    SQLAlterarStatusLead =  ' UPDATE LADGER ' +
                            '    SET LDG_STATUS = :STATUS, ' +
                            '        LDG_DTAFIN = :DTAFIN, ' +
                            '        LDG_HORFIN = :HORFIN, ' +
                            '        LDG_OPEFIN = :OPEFIN, ' +
                            '        LDG_ULTALT = :ULTALT  ' +
                            '  WHERE AUTOINCREM = :AUTINC  ';

implementation

uses
  untFuncoes, untFuncoesCrm;

{ TLeads }

procedure TLeads.pAlterarStatusLead(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus;
      btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
begin
  Case FStatusLead Of
    slAndamento: pAlterarStatusLeadReabrir(lblStatusLead, edtDtaFin, edtHorFin, edtOpeFin, btnFinalizarLead, AAutInc);
    slFinalizado: pAlterarStatusLeadFinalizar(lblStatusLead, edtDtaFin, edtHorFin, edtOpeFin, btnFinalizarLead, AAutInc);
    slFaturamentoParcial: pAlterarStatusLeadFaturamentoParcial(lblStatusLead, edtDtaFin, edtHorFin, edtOpeFin, btnFinalizarLead, AAutInc);
    slAberto: pAlterarStatusLeadAberto(lblStatusLead, edtDtaFin, edtHorFin, edtOpeFin, btnFinalizarLead, AAutInc);
  End;
end;

procedure TLeads.pAlterarStatusLeadFinalizar(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
begin
  lblStatusLead.Caption := fStatusLeadToStrDescri(slFinalizado);
  lblStatusLead.Font.Color := fStatusLeadToColor(slFinalizado);
  edtDtaFin.Text  := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtHorFin.Text  := FormatDateTime('hh:mm:ss', fTime());
  edtOpeFin.Text  := fRetornaOperadorFormatado(strLoginUsuarioLogado);
  btnFinalizarLead.Caption := REABRIR_LEAD;
end;

procedure TLeads.pAlterarStatusLeadReabrir(lblStatusLead: TLabel; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked; const AAutInc: String);
begin
  lblStatusLead.Caption := fStatusLeadToStrDescri(slAndamento);
  lblStatusLead.Font.Color := fStatusLeadToColor(slAndamento);
  edtDtaFin.Clear;
  edtHorFin.Clear;
  edtOpeFin.Clear;
  btnFinalizarLead.Caption := FINALIZAR_LEAD;
end;

class function TLeads.New: ILeads;
begin
  Result := Self.Create;
end;

procedure TLeads.pAtualizaInformacoesGeraisDoLead(lblStatusLead: TLabel;
  btnFinalizarLead: TBitBtnLocked; edtDtaFin, edtHorFin, edtOpeFin: TEditFocus;
  const ADataSet: TDataSet);
begin
  FStatusLead := fObtemStatusLead( ADataSet.FieldByName('AUTOINCREM').AsString );

  FNumLead := ADataSet.FieldByName('LDG_NUMDOC').AsString;
  FAutInc := ADataSet.FieldByName('AUTOINCREM').AsString;

  lblStatusLead.Caption := fStatusLeadToStrDescri(statusLead);
  lblStatusLead.Font.Color := fStatusLeadToColor(statusLead);

  case FStatusLead of
    slAndamento,
    slAberto,
    slFaturamentoParcial: btnFinalizarLead.Caption := FINALIZAR_LEAD;
    slFinalizado: btnFinalizarLead.Caption := REABRIR_LEAD;
  end;

  edtDtaFin.Text := '';
  If (ADataSet.FieldByName('LDG_DTAFIN').AsDateTime > 0) Then
    edtDtaFin.Text  := FormatDateTime('dd/mm/yyyy', ADataSet.FieldByName('LDG_DTAFIN').AsDateTime);

  edtHorFin.Text := '';
  If (ADataSet.FieldByName('LDG_HORFIN').AsDateTime > 0) Then
    edtHorFin.Text  := FormatDateTime('hh:mm:ss', ADataSet.FieldByName('LDG_HORFIN').AsDateTime);

  edtOpeFin.Text := '';
  If Not fEmptyStr(ADataSet.FieldByName('LDG_OPEFIN').AsString) Then
    edtOpeFin.Text  := Self.fRetornaOperadorFormatado(ADataSet.FieldByName('LDG_OPEFIN').AsString);
end;

function TLeads.fPermitidoExecutarOperacao(const ADataSet: TDataSet): Boolean;
begin
  Result := False;

  If fRetornaStatusLead(ADataSet) = slFinalizado Then
  Begin
    fMensagem('Atenção', 'Não é possível alterar este Lead pois ele está finalizado.' + #13#10 +
                         'Se deseja reabrir, utilize o botão "Reabrir Lead"', ['&OK']);
    Exit;
  End;

  Result := True;
end;

procedure TLeads.pExibirMensagemFinalizarLeadEmAberto;
begin
  fMensagem('Atenção', 'Não é possível finalizar este Lead pois existem ocorrências vinculadas a ele,' + #13#10 +
                       'que ainda não estão finalizadas. Verifique o histórico de ocorrências e os' + #13#10 +
                       'orçamentos vinculados ao Lead e depois, tente novamente.', ['&OK']);
end;

procedure TLeads.pGravarLogLadGer;
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery;

  Try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(' INSERT INTO LOGLDG(AUTOINCREM, LOG_DTALOG, LOG_HORLOG, LOG_OPELOG, ' +
                      ' LOG_FRMLOG, LOG_INIOBR, LOG_VENEXT, LOG_CODFAS, LOG_PREORC,        ' +
                      ' LOG_REGIST, LOG_DESCON, LOG_NOMPRO, LOG_CODINS, LOG_TOTVPR, LOG_STATUS, ' +
                      ' LOG_CODVEN, LOG_ULTALT, LOG_SEQLDG, LOG_CODEMP) ');

    qryInsert.SQL.Add(' VALUES(:AUTOINCREM, :DTALOG, :HORLOG, :OPELOG, ' +
                      ' :FRMLOG, :INIOBR, :VENEXT, :CODFAS, :PREORC,   ' +
                      ' :REGIST, :DESCON, :NOMPRO, :CODINS, :TOTVPR,   ' +
                      ' :STATUS, :CODVEN, :ULTALT, :SEQLDG, :CODEMP)   ');

    qryInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGLDG', VS_strCodEmp);
    qryInsert.ParamByName('DTALOG').AsDateTime := fNow();
    qryInsert.ParamByName('HORLOG').AsDateTime := fNow();
    qryInsert.ParamByName('OPELOG').AsString := strLoginUsuarioLogado;
    qryInsert.ParamByName('FRMLOG').AsString := FstrNomeFrmOrigem;
    qryInsert.ParamByName('INIOBR').AsDateTime := FDatIniObr;
    qryInsert.ParamByName('VENEXT').AsString := FVenExt;
    qryInsert.ParamByName('CODFAS').AsString := FCodFas;
    qryInsert.ParamByName('PREORC').AsDateTime := FDatPreOrc;
    qryInsert.ParamByName('REGIST').AsString := FRegist;
    qryInsert.ParamByName('DESCON').AsString := FDescon;
    qryInsert.ParamByName('NOMPRO').AsString := FstrNomPro;
    qryInsert.ParamByName('CODINS').AsString := FCodIns;
    qryInsert.ParamByName('TOTVPR').AsFloat := FfltTotVPr;
    qryInsert.ParamByName('STATUS').AsString := FstrStatus;
    qryInsert.ParamByName('CODVEN').AsString := FCodVen;
    qryInsert.ParamByName('ULTALT').AsDateTime := FDtaUltAlt;
    qryInsert.ParamByName('SEQLDG').AsString := FAutInc;
    qryInsert.ParamByName('CODEMP').AsString := FCodEmp;
    qryInsert.ExecSQL;

  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TLeads.pLimpar;
begin
  FFaturamentoParcial := False;
  FStatusLead := slVazio;
  FNumLead := EmptyStr;
  FAutInc := EmptyStr;
  FTip_Fc := EmptyStr;
  FCodCli := EmptyStr;
end;

procedure TLeads.pSetDadosLead(const ADataSet: TDataSet);
begin
  FNumLead := ADataSet.FieldByName('LDG_NUMDOC').AsString;
  FAutInc := ADataSet.FieldByName('AUTOINCREM').AsString;
  FCodCli := ADataSet.FieldByName('LDG_CODCLI').AsString;
  FDatIniObr := ADataSet.FieldByName('LDG_INIOBR').AsDateTime;
  FVenExt := ADataSet.FieldByName('LDG_VENEXT').AsString;
  FCodFas := ADataSet.FieldByName('LDG_CODFAS').AsString;
  FDatPreOrc := ADataSet.FieldByName('LDG_PREORC').AsDateTime;
  FRegist := ADataSet.FieldByName('LDG_REGIST').AsString;
  FDescon := ADataSet.FieldByName('LDG_DESCON').AsString;
  FstrNomPro := ADataSet.FieldByName('LDG_NOMPRO').AsString;
  FCodIns := ADataSet.FieldByName('LDG_CONDIS').AsString;
  FfltTotVPr := ADataSet.FieldByName('LDG_TOTVPR').AsFloat;
  FstrStatus := ADataSet.FieldByName('LDG_STATUS').AsString;
  FCodVen := ADataSet.FieldByName('LDG_CODVEN').AsString;
  FDtaUltAlt := ADataSet.FieldByName('LDG_ULTALT').AsDateTime;
  FCodEmp := ADataSet.FieldByName('LDG_CODEMP').AsString;

  FStatusLead := fStrToStatusLead(FstrStatus);
end;

procedure TLeads.SetAutInc(const AValue: string);
begin
  FAutInc := AValue;
end;

procedure TLeads.SetCodCli(const AValue: string);
begin
  FCodCli := AValue;
end;

procedure TLeads.SetCodEmp(const AValue: String);
begin
  FCodEmp := AValue;
end;

procedure TLeads.SetCodFas(const AValue: String);
begin
  FCodFas := AValue;
end;

procedure TLeads.SetCodIns(const AValue: String);
begin
  FCodIns := AValue;
end;

procedure TLeads.SetCodVen(const AValue: String);
begin
  FCodVen := AValue;
end;

procedure TLeads.SetDatIniObr(const AValue: TDateTime);
begin
  FDatIniObr := AValue;
end;

procedure TLeads.SetDatPreOrc(const AValue: TDateTime);
begin
  FDatPreOrc := AValue;
end;

procedure TLeads.SetDescon(const AValue: String);
begin
  FDescon := AValue;
end;

procedure TLeads.SetDtaUltAlt(const AValue: TDateTime);
begin
  FDtaUltAlt := AValue;
end;

procedure TLeads.SetNmFrmOri(const AValue: String);
begin
  FstrNomeFrmOrigem := AValue;
end;

procedure TLeads.SetNomPro(const AValue: String);
begin
  FstrNomPro := AValue;
end;

procedure TLeads.SetNumLead(const AValue: string);
begin
  FNumLead := AValue;
end;

procedure TLeads.SetRegist(const AValue: String);
begin
  FRegist := AValue;
end;

procedure TLeads.SetStatusLead(const AValue: TStatusLead);
begin
  FStatuslead := AValue;
end;

procedure TLeads.SetstrStatus(const AValue: String);
begin
  FstrStatus := AValue;
end;

function TLeads.fExitemOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto(
  const ANumeroLead: String): Boolean;
var
  cdsOco: TZClient;
begin
  cdsOco := TZClient.Create(Nil);
  cdsOco.qryQuery.SQL.Add(fRetornaSQLOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto);
  cdsOco.qryQuery.ParamByName('NLEADS').AsString := ANumeroLead;
  cdsOco.fAbreClient(True, ' TLeads.ExitemOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto');

  Result := cdsOco.RecordCount > 0;
end;

function TLeads.fExitemOcorrenciasVinculadasAoLeadEmAberto(
  const ADataSet: TDataSet): Boolean;
begin
  Result := False;

  If ADataSet.RecordCount = 0 Then
    Exit;

  ADataSet.DisableControls;
  Try
   ADataSet.First;
   While Not ADataSet.Eof Do
   Begin
     If ADataSet.FieldByName('OCO_DTACON').AsDateTime = 0 Then
     Begin
       Result := True;
       Exit;
     End;

     ADataSet.Next;
   End;
  Finally
    ADataSet.EnableControls;
  End;
end;

function TLeads.fRetornaOperadorFormatado(const ACodOperador: String): String;
begin
  Result := ACodOperador;
  Result := Result + ' - ' + fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [ACodOperador]);
end;

function TLeads.fRetornaSQLOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto: String;
begin
  Result := '';
  Result := Result + 'SELECT FGO_NUMDOC, ';
  Result := Result + '       FGO_ESPDOC, ';
  Result := Result + '       FGO_CODCLI, ';
  Result := Result + '       CLI_NOMCLI, ';
  Result := Result + '       FGO_CODEMP, ';
  Result := Result + '       FGO_TOTPRO, ';
  Result := Result + '       OCO_DTACON, ';
  Result := Result + '       OCO_HORCON, ';
  Result := Result + '       OCO_DESCRI  ';
  Result := Result + '  FROM FATGOR G    ';
  Result := Result + ' INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM ';
  Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI   ';
  Result := Result + ' INNER JOIN MOVOCO ON OCO_NUMDOC = FGO_NUMDOC   ';
  Result := Result + '                  AND OCO_ESPDOC = FGO_ESPDOC   ';
  Result := Result + '                  AND OCO_CODCLI = FGO_CODCLI   ';
  Result := Result + '                  AND OCO_CODEMP = FGO_CODEMP   ';
  Result := Result + '  WHERE FGO_NLEADS = :NLEADS ';
  Result := Result + '    AND FGO_ESPDOC = "OR"    ';
  Result := Result + '    AND FGO_JAFATU = 0       ';
  Result := Result + '    AND OCO_DTACON IS NULL   ';
end;

procedure TLeads.SetTip_Fc(const AValue: string);
begin
  FTip_Fc := AValue;
end;

procedure TLeads.SetTotVPr(const AValue: Double);
begin
  FfltTotVPr := AValue;
end;

procedure TLeads.SetVenExt(const AValue: String);
begin
  FVenExt := AValue;
end;

function TLeads.fAlterarStatusLeadBancoDados(const AStatus: TStatusLead; const AAutInc: string; Finalizar: Boolean = False; strFrmOri: String = ''): Boolean;
var
  qryUpdate: TZClient;
begin
  FAutInc := AAutInc;
  FstrStatus := arrStatusLead[AStatus];
  FDtaUltAlt := fNow();

  qryUpdate := TZClient.Create(Nil);
  try
    qryUpdate.qryQuery.SQL.Add(SQLAlterarStatusLead);
    qryUpdate.qryQuery.ParamByName('STATUS').AsString := FstrStatus;
    qryUpdate.qryQuery.ParamByName('AUTINC').AsString := FAutInc;
    qryUpdate.qryQuery.ParamByName('ULTALT').AsDateTime := FDtaUltAlt;
    If Finalizar Then
    Begin
      qryUpdate.qryQuery.ParamByName('DTAFIN').AsDateTime := VS_Date;
      qryUpdate.qryQuery.ParamByName('HORFIN').AsDateTime := fTime();
      qryUpdate.qryQuery.ParamByName('OPEFIN').AsString := strLoginUsuarioLogado;
    End
    Else
    Begin
      qryUpdate.qryQuery.ParamByName('DTAFIN').Value := Null;
      qryUpdate.qryQuery.ParamByName('HORFIN').Value := Null;
      qryUpdate.qryQuery.ParamByName('OPEFIN').Value := Null;
    End;

    qryUpdate.qryQuery.ExecSQL;

    pGravarLogLadGer;

    Result := True;
  finally
    FreeAndNil(qryUpdate);
  end;
end;

procedure TLeads.pAlterarStatusLeadAberto(lblStatusLead: TLabel; edtDtaFin,
  edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked;
  const AAutInc: String);
begin
  lblStatusLead.Caption := fStatusLeadToStrDescri(slAberto);
  lblStatusLead.Font.Color := fStatusLeadToColor(slAberto);
  edtDtaFin.Clear;
  edtHorFin.Clear;
  edtOpeFin.Clear;
  btnFinalizarLead.Caption := FINALIZAR_LEAD;
end;

procedure TLeads.pAlterarStatusLeadFaturamentoParcial(lblStatusLead: TLabel;
  edtDtaFin, edtHorFin, edtOpeFin: TEditFocus; btnFinalizarLead: TBitBtnLocked;
  const AAutInc: String);
begin
  lblStatusLead.Caption := fStatusLeadToStrDescri(slFaturamentoParcial);
  lblStatusLead.Font.Color := fStatusLeadToColor(slFaturamentoParcial);
  edtDtaFin.Clear;
  edtHorFin.Clear;
  edtOpeFin.Clear;
  btnFinalizarLead.Caption := FINALIZAR_LEAD;
end;

function TLeads.fObtemStatusLead(const AAutInc: string): TStatusLead;
const
  SQLSelect =  'SELECT LDG_STATUS  ' +
               '  FROM LADGER      ' +
               '  WHERE AUTOINCREM = :NLEADS ';
var
  qryQuery: TUniQuery;
begin
  Result := slAberto;
  qryQuery := fCriaQuery;
  Try
    qryQuery.DisableControls;
    qryQuery.SQL.Add(SQLSelect);
    qryQuery.ParamByName('NLEADS').AsString := AAutInc;
    qryQuery.Open;
    If Not qryQuery.IsEmpty Then
    Begin
      Result := fRetornaStatusLead(qryQuery.FieldByName('LDG_STATUS').AsString);
    End;
  Finally
    FreeAndNil(qryQuery);
  End;

end;

function TLeads.fRetornaStatusLead(const AStatus: String): TStatusLead;
var
  Indice: Integer;
begin
  Indice := AnsiIndexStr(UpperCase(AStatus), arrStatusLead);
  Result := IndiceToStatusLead(Indice);
end;

function TLeads.fRetornaStatusLead(const ADataSet: TDataSet): TStatusLead;
var
  LStatus: String;
  Indice: Integer;
begin
  LStatus := ADataSet.FieldByName('LDG_STATUS').AsString;
  Indice := AnsiIndexStr(UpperCase(LStatus), arrStatusLead);
  Result := IndiceToStatusLead(Indice);
end;

function TLeads.fStatusLeadToColor(const AStatus: TStatusLead): TColor;
begin
  Case AStatus Of
    slAberto            : Result := clBlue;
    slAndamento         : Result := clGreen;
    slFaturamentoParcial: Result := clPurple;
    slFinalizado        : Result := clRed;
    Else
      Result := clNone;
  End;
end;

function TLeads.fStatusLeadToStr(const AStatus: TStatusLead): string;
begin
  Result := arrStatusLead[AStatus];
end;

function TLeads.fStatusLeadToStrDescri(const AStatus: TStatusLead): string;
begin
  Result := descricaoStatusLead[AStatus];
end;

function TLeads.fStrToStatusLead(const AStatus: String): TStatusLead;
var
  Indice: Integer;
begin
  Indice := AnsiIndexStr(UpperCase(AStatus), arrStatusLead);
  Result := IndiceToStatusLead(Indice);
end;

function TLeads.GetAutInc: string;
begin
  Result := FAutInc;
end;

function TLeads.GetCodCli: string;
begin
  Result := FCodCli;
end;

function TLeads.GetCodEmp: String;
begin
  Result := FCodEmp;
end;

function TLeads.GetCodFas: String;
begin
  Result := FCodFas;
end;

function TLeads.GetCodIns: String;
begin
  Result := FCodIns;
end;

function TLeads.GetCodVen: String;
begin
  Result := FCodVen;
end;

function TLeads.GetDatIniObr: TDateTime;
begin
  Result := FDatIniObr;
end;

function TLeads.GetDatPreOrc: TDateTime;
begin
  Result := FDatPreOrc;
end;

function TLeads.GetDescon: String;
begin
  Result := FDescon;
end;

function TLeads.GetDtaUltAlt: TDateTime;
begin
  Result := FDtaUltAlt;
end;

function TLeads.GetNmFrmOri: String;
begin
  Result := FstrNomeFrmOrigem;
end;

function TLeads.GetNomPro: String;
begin
  Result := FstrNomPro;
end;

function TLeads.GetNumLead: string;
begin
  Result := FNumLead;
end;

function TLeads.GetRegist: String;
begin
  Result := FRegist;
end;

function TLeads.GetStatusLead: TStatusLead;
begin
  Result := FStatusLead;
end;

function TLeads.GetstrStatus: String;
begin
  Result := FstrStatus;
end;

function TLeads.GetTip_Fc: string;
begin
  Result := FTip_Fc;
end;

function TLeads.GetTotVPr: Double;
begin
  Result := FfltTotVPr;
end;

function TLeads.GetVenExt: String;
begin
  Result := FVenExt;
end;

function TLeads.fExitemOrcamentosVinculadosAoLead(const ANumeroLead: String): Boolean;
const
  SQLSelect =  'SELECT FGO_SEQFGO,  ' +
               '       FDO_EMPFAT,  ' +
               '       FDO_TIPFAT,  ' +
               '       FDO_NUMFAT,  ' +
               '       FDO_JAFATU   ' +
               '  FROM FATGOR G    ' +
               ' INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM ' +
               ' LEFT JOIN FATDOR ON FDO_NUMDOC = FGO_NUMDOC AND FDO_CODEMP = FGO_CODEMP '+
               '  WHERE FGO_NLEADS = :NLEADS ' +
               '    AND FGO_ESPDOC = :ESPDOC ';

  SQLSelectParc =  'SELECT FDO_CODEMP,  ' +
                   '       FDO_ESPDOC,  ' +
                   '       FDO_NUMDOC,  ' +
                   '       FDO_JAFATU   ' +
                   ' FROM FATDOR  '+
                   '  WHERE FDO_CODEMP = :CODEMP ' +
                   '    AND FDO_ESPDOC = :ESPDOC ' +
                   '    AND FDO_NUMDOC = :NUMDOC ';
var
  qryParc: TUnIquery;
  qryOrc: TUnIquery;
begin
  Result := False;
  FFaturamentoParcial := False;

  qryOrc := fCriaQuery;
  qryParc:= fCriaQuery;
  Try
    qryParc.DisableControls;
    qryParc.SQL.Add(SQLSelectParc);
    qryParc.Prepare;

    qryOrc.DisableControls;
    qryOrc.SQL.Add(SQLSelect);
    qryOrc.ParamByName('NLEADS').AsString := ANumeroLead;
    qryOrc.ParamByName('ESPDOC').AsString := 'OR';
    qryOrc.Open;
    While Not qryOrc.EOF Do
    Begin
      Result := True;

      qryParc.Close;
      qryParc.ParamByName('CODEMP').AsString := qryOrc.FieldByName('FDO_EMPFAT').AsString;
      qryParc.ParamByName('ESPDOC').AsString := qryOrc.FieldByName('FDO_TIPFAT').AsString;
      qryParc.ParamByName('NUMDOC').AsString := qryOrc.FieldByName('FDO_NUMFAT').AsString;
      qryParc.Open;

      while Not qryParc.EOF do
      Begin
        If fPedidoFaturadoParcialmente(qryParc.FieldByName('FDO_NUMDOC').AsString,
                                       qryParc.FieldByName('FDO_ESPDOC').AsString,
                                       qryParc.FieldByName('FDO_CODEMP').AsString) Then
        Begin
          FFaturamentoParcial := True;
          Break;
        End;

        qryParc.Next;
      End;

      qryOrc.Next;
    End
  Finally
    FreeAndNil(qryParc);
    FreeAndNil(qryOrc);
  End;

end;

function TLeads.fFinalizarLead(const ADataSet: TDataSet): Boolean;
begin
  If Assigned(ADataSet) Then
    pSetDadosLead(ADataSet);

  FStatusLead := slFinalizado;
  FstrStatus  := fStatusLeadToStr(FStatusLead);

  Result := fAlterarStatusLeadBancoDados(slFinalizado, ADataSet.FieldByName('AUTOINCREM').AsString, True);
end;

procedure TLeads.pAtualizaStatusLeadAndamento(const AAutInc, ANumLead: String);
Begin
  FStatusLead := fObterStatusLeadAndamento(AAutInc, ANumLead);
  If FStatusLead in [slAberto, slAndamento, slFaturamentoParcial] Then
    fAlterarStatusLeadBancoDados(FStatusLead, AAutInc);
End;

procedure TLeads.pCarregarDadosLead(const strAutInc: String);
const
  SQLSelect = 'SELECT *                   ' +
              ' FROM LADGER               ' +
              ' WHERE AUTOINCREM = :AUTINC';
Var
  qryQuery: TUnIquery;
begin

  qryQuery := fCriaQuery;
  Try
    qryQuery.DisableControls;
    qryQuery.SQL.Add(SQLSelect);
    qryQuery.ParamByName('AUTINC').AsString := strAutInc;
    qryQuery.Open;
    If Not qryQuery.IsEmpty Then
    Begin
      FNumLead := qryQuery.FieldByName('LDG_NUMDOC').AsString;
      FAutInc := qryQuery.FieldByName('AUTOINCREM').AsString;
      FCodCli := qryQuery.FieldByName('LDG_CODCLI').AsString;
      FDatIniObr := qryQuery.FieldByName('LDG_INIOBR').AsDateTime;
      FVenExt := qryQuery.FieldByName('LDG_VENEXT').AsString;
      FCodFas := qryQuery.FieldByName('LDG_CODFAS').AsString;
      FDatPreOrc := qryQuery.FieldByName('LDG_PREORC').AsDateTime;
      FRegist := qryQuery.FieldByName('LDG_REGIST').AsString;
      FDescon := qryQuery.FieldByName('LDG_DESCON').AsString;
      FstrNomPro := qryQuery.FieldByName('LDG_NOMPRO').AsString;
      FCodIns := qryQuery.FieldByName('LDG_CODINS').AsString;
      FfltTotVPr := qryQuery.FieldByName('LDG_TOTVPR').AsFloat;
      FstrStatus := qryQuery.FieldByName('LDG_STATUS').AsString;
      FCodVen := qryQuery.FieldByName('LDG_CODVEN').AsString;
      FDtaUltAlt := qryQuery.FieldByName('LDG_ULTALT').AsDateTime;
      FCodEmp := qryQuery.FieldByName('LDG_CODEMP').AsString;
      FStatusLead := fStrToStatusLead(FstrStatus);
    End
  Finally
    FreeAndNil(qryQuery);
  End;
end;

class function TLeads.fObterNumLead(const ACodemp, ACodEsp, ANumDoc: String): string;
const
  SQLSelectOrc =  'SELECT COALESCE(LADGER.AUTOINCREM, B.AUTOINCREM) AS AUTOINCREM, ' +
                  'COALESCE(LADGER.LDG_NUMDOC, B.LDG_NUMDOC) AS LDG_NUMDOC,        ' +
                  'COALESCE(EXTGOR.FGO_SEQFGO, B.FGO_SEQFGO) AS FGO_SEQFGO         ' +
                  '     FROM FATGOR G                                              ' +
                  '     INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM             ' +
                  '     LEFT JOIN LADGER ON LADGER.AUTOINCREM = FGO_INCNLE        ' +
                  '     LEFT JOIN (SELECT LADGER.AUTOINCREM,                       ' +
                  '                       LDG_NUMDOC,                              ' +
                  '                       FGO_SEQFGO,                              ' +
                  '                       G.FGO_CODEMP AS CODEMP,                  ' +
                  '                       G.FGO_ESPDOC AS ESPDOC,                  ' +
                  '                       G.FGO_NUMDOC AS NUMDOC                   ' +
                  '                 FROM FATGOR G                                  ' +
                  'INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM                  ' +
                  'INNER JOIN LADGER ON LADGER.LDG_NUMDOC = FGO_NLEADS             ' +
                  '                 )AS B ON (B.CODEMP = :CODEMP AND B.ESPDOC = :CODESP AND B.NUMDOC = :NUMDOC) ' +
                  '       WHERE FGO_CODEMP = :CODEMP                               ' +
                  '         AND FGO_ESPDOC = :CODESP                               ' +
                  '         AND FGO_NUMDOC = :NUMDOC                               ';

  SQLSelect = 'SELECT LADGER.AUTOINCREM, LDG_NUMDOC, FGO_SEQFGO ' +
              ' FROM FATGOR G  ' +
              ' INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM ' +
              ' INNER JOIN LADGER ON LADGER.AUTOINCREM = FGO_INCNLE ' +
              ' INNER JOIN FATDOR ON FDO_EMPFAT = :CODEMP  AND FDO_TIPFAT = :CODESP AND FDO_NUMFAT = :NUMDOC ' +
              '  WHERE FDO_CODEMP = FGO_CODEMP  ' +
              '    AND FDO_ESPDOC = FGO_ESPDOC  ' +
              '    AND FDO_NUMDOC = FGO_NUMDOC  ';

Var
  qryQuery: TUnIquery;
begin
  Result := '';

  qryQuery := fCriaQuery;
  Try
    qryQuery.DisableControls;
    If ((ACodEsp = 'OR') or (ACodEsp = 'PD')) Then
      qryQuery.SQL.Add(SQLSelectOrc)
    Else
      qryQuery.SQL.Add(SQLSelect);
    qryQuery.ParamByName('CODEMP').AsString := ACodemp;
    qryQuery.ParamByName('CODESP').AsString := ACodEsp;
    qryQuery.ParamByName('NUMDOC').AsString := ANumDoc;
    qryQuery.Open;
    If Not qryQuery.IsEmpty Then
    Begin
      Result := qryQuery.FieldByName('AUTOINCREM').AsString;
    End
  Finally
    FreeAndNil(qryQuery);
  End;

end;

class function TLeads.fObterNumLead(const ACodOco: String): string;
const
  SQLSelect = 'SELECT LDG_NUMDOC AS NLEAD  ' +
              ' FROM LADGER  ' +
              ' INNER JOIN MOVOCO ON OCO_SEQLAG = LADGER.AUTOINCREM ' +
              ' WHERE OCO_CODOCO = :CODOCO';
Var
  qryQuery: TUnIquery;
begin
  Result := '';

  qryQuery := fCriaQuery;
  Try
    qryQuery.DisableControls;
    qryQuery.SQL.Add(SQLSelect);
    qryQuery.ParamByName('CODOCO').AsString := ACodOco;
    qryQuery.Open;
    If Not qryQuery.IsEmpty Then
    Begin
      Result := qryQuery.FieldByName('NLEAD').AsString;
    End
  Finally
    FreeAndNil(qryQuery);
  End;
end;

function TLeads.fObterStatusLeadAndamento(const AAutInc, ANumLead: String): TStatusLead;
begin
  Result := slAberto;

  If fExitemOcorrencias(AAutInc) Then
  Begin
    Result := slAndamento;
  End;

  If fExitemOrcamentosVinculadosAoLead(ANumLead) Then
  Begin
    Result := slAndamento;

    If FFaturamentoParcial Then
    Begin
      Result := slFaturamentoParcial;
      Exit;
    End;
  End;

end;

function TLeads.fExitemOcorrencias(const AAutInc: String): Boolean;
var
  cdsOco: TZClient;
begin
  cdsOco := TZClient.Create(Nil);
  cdsOco.qryQuery.SQL.Add(fRetornaSQLInformacoesOcorrencias(FTip_Fc, AAutInc));
  cdsOco.fAbreClient(True, ' TLeads.fExitemOcorrencias');

  Result := cdsOco.RecordCount > 0;
end;

class function TLeads.IndiceToStatusLead(const Indice: Integer): TStatusLead;
var
  iCnt: Integer;
  status: TStatusLead;
begin
  Result := slVazio;
  iCnt := 0;

  For status := Low(TStatusLead) to High(TStatusLead) do
  Begin
    if Indice = iCnt then
      Result := status;
    Inc(iCnt);
  End;
end;

class function TLeads.IndiceToTipoOrdenacao(const Indice: Integer): TOrdCnsLead;
var
  intCnt: Integer;
  ordCns: TOrdCnsLead;
begin
  Result := tpNenhum;
  intCnt := 0;

  For ordCns := Low(TOrdCnsLead) to High(TOrdCnsLead) do
  Begin
    If Indice = intCnt Then
    Begin
      Result := ordCns;
      Break;
    End;

    Inc(intCnt);
  End;
end;

function TLeads.fRetornaSQLUpdateOrcamento: String;
begin
  Result :=  ' UPDATE EXTGOR ' +
             '    SET FGO_NLEADS = :NLEADS, ' +
             '        FGO_INCNLE = :AUTOINCREM ' +
             '  WHERE FGO_SEQFGO = :SEQFGO ';
end;

procedure TLeads.pVincularOrcamentoAoLead(const strOrcamento: string);
var
  qryOrc: TZClient;
begin
  qryOrc := TZClient.Create(Nil);
  qryOrc.qryQuery.SQL.Add(fRetornaSQLUpdateOrcamento);
  qryOrc.qryQuery.ParamByName('SEQFGO').AsString := strOrcamento;
  qryOrc.qryQuery.ParamByName('NLEADS').AsString := FNumLead;
  qryOrc.qryQuery.ParamByName('AUTOINCREM').AsString := FAutInc;
  qryOrc.qryQuery.ExecSQL;
end;

procedure TLeads.pDesVincularOrcamentoAoLead(const strOrcamento: string);
const
  SQLUpdate = ' UPDATE EXTGOR ' +
              '    SET FGO_NLEADS = NULL, ' +
              '        FGO_INCNLE = NULL,  ' +
              '        FGO_LINGRU = NULL  ' +
              '  WHERE FGO_SEQFGO = :SEQFGO ';

  SQLUpdLDD = ' UPDATE LADDET ' +
              '    SET LDD_ORCVIN = NULL, ' +
              '        LDD_EMPORC = NULL  ' +
              '  WHERE LDD_SEQGER = :SEQGER ';
var
  qryOrc: TZClient;
begin
  qryOrc := TZClient.Create(Nil);
  qryOrc.qryQuery.SQL.Add(SQLUpdate);
  qryOrc.qryQuery.ParamByName('SEQFGO').AsString := strOrcamento;
  qryOrc.qryQuery.ExecSQL;

  qryOrc.qryQuery.SQL.Clear;
  qryOrc.qryQuery.SQL.Add(SQLUpdLDD);
  qryOrc.qryQuery.ParamByName('SEQGER').AsString := Self.GetAutInc();
  qryOrc.qryQuery.ExecSQL;
end;


end.

