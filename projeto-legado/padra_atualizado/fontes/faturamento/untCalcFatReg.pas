unit untCalcFatReg;

interface

Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  cxEdit,
  cxGridDBTableView,
  cxGridCustomTableView,
  Winapi.Windows;

type
  TCalcFatReg = class(TZClient)
    private
      FOwner: TWinControl;
      FView: TcxGridDBTableView;

      function fSQLFatorRegional: String;
      function fGravaAliquotasPadrao(strCodigo: string; fltIVAOri: Double): Boolean;
      function fCalculaFatorRegional(fltIVAOri, fltAlqInt, fltAlqEst: Double; strEstado: string): Double;
      function fExisteRegistro(strCodigo: string): Boolean;  
      procedure pFormataCampos(Dataset: TDataset);
    public
      constructor Create(Owner: TWinControl; cxgView: TcxGridDBTableView); reintroduce;

      function fCarregaAliquota(strCodigo: string; fltIVAOri: Double): Boolean;
      procedure fAtualizaCalculoFatorRegional(fltIVAOri: Double);

      class function fIniciaALIQUOTAS_ICMS_INTERESTADUAIS: Boolean;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untConstantes;

{ TCalcFatReg }

constructor TCalcFatReg.Create(Owner: TWinControl; cxgView: TcxGridDBTableView);
begin
  Inherited Create(Owner, fSQLFatorRegional);
  FOwner := Owner;
  FView := cxgView;
end;

procedure TCalcFatReg.fAtualizaCalculoFatorRegional(fltIVAOri: Double);
begin

  try
    DisableControls;
    First;

    while not Eof do
    begin
      Edit;
      FieldByName('CFR_FATREG').AsFloat := fCalculaFatorRegional(fltIVAOri, FieldByName('CFR_ALQINT').AsFloat, FieldByName('CFR_ALQEST').AsFloat, FieldByName('CFR_ESTADO').AsString);
      Post;
      Next;
    end;
    fSalva;
    First;
    EnableControls;
  except
    on E: exception do
    begin
      pMensagensErro(E.Message, '[TCalcFatReg.fAtualizaCalculoFatorRegional]');
    end;    
  end;
end;

function TCalcFatReg.fCalculaFatorRegional(fltIVAOri, fltAlqInt,
  fltAlqEst: Double; strEstado: string): Double;
var
  fltResultMVA,
  fltResultALQ: Double;
begin
  fltResultMVA := (((fltIVAOri * fltAlqInt)/100) + fltAlqInt);
  fltResultMVA := fFormataFloat(fltResultMVA, 2);

  if (strEstado = 'EX') then
  begin
    Result := fltResultMVA - fltAlqEst; 
  end
  else
  begin
    fltResultALQ := ((100 - fltAlqEst)/100);
    fltResultALQ := (fltAlqEst / fltResultALQ);
    fltResultALQ := fFormataFloat(fltResultALQ, 2);
    Result := fltResultMVA - fltResultALQ;    
  end;

end;

function TCalcFatReg.fCarregaAliquota(strCodigo: string;
  fltIVAOri: Double): Boolean;
begin
  try
    Result := False;

    if not fExisteRegistro(strCodigo) then
    begin
      if not fGravaAliquotasPadrao(strCodigo, fltIVAOri) then
      begin  
        Exit;
      end;
    end;

    qryQuery.SQL.Text := fSQLFatorRegional;
    qryQuery.ParamByName('CODFRE').AsString := strCodigo;
    qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Result := fAbreClient(True, 'TCalcFatReg.fCarregaAliquota');

    qryQuery.FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
    Self.pSetUpdateMode(upWhereKeyOnly);
    pFormataCampos(Self);    
  except
    on E: exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TCalcFatReg.fCarregaAliquota]');
    end;
  end;
end;

function TCalcFatReg.fExisteRegistro(strCodigo: string): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;

  try
    Result := False;

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(fSQLFatorRegional);
    qryConsulta.ParamByName('CODFRE').AsString := strCodigo;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    Result := not qryConsulta.IsEmpty;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function TCalcFatReg.fGravaAliquotasPadrao(strCodigo: string; fltIVAOri: Double): Boolean;
var
  qryPadrao: TUniQuery;
  intOrigem: integer;
  intDestino: integer;
  strUFEmpresa: string;
  fltAlqInterna: Double;
begin
  qryPadrao := fCriaQuery;
  strUFEmpresa := fRetUFEmpresa;
  
  for intDestino := Low(ALIQUOTAS_ICMS_UF) to High(ALIQUOTAS_ICMS_UF) do
  begin  
    if strUFEmpresa = ALIQUOTAS_ICMS_UF[intDestino] then
    begin
      Break;
    end;
  end;

  fltAlqInterna := ALIQUOTAS_ICMS_INTERESTADUAIS[intDestino, intDestino];

  try
    Result := False;
    fStartTransaction;

    try
      qryPadrao.Close;
      qryPadrao.SQL.Clear;
      qryPadrao.SQL.Add('INSERT INTO CALCFR(AUTOINCREM, CFR_CODFRE, CFR_CODEMP, CFR_ESTADO, CFR_ALQINT, CFR_ALQEST, CFR_FATREG)');
      qryPadrao.SQL.Add('VALUES(:AUTINC, :CODFRE, :CODEMP, :ESTADO, :ALQINT, :ALQEST, :FATREG)');

      for intOrigem := Low(ALIQUOTAS_ICMS_UF) to High(ALIQUOTAS_ICMS_UF) do
      begin  
        qryPadrao.ParamByName('AUTINC').AsString := fRetAutoIncrem('CALCFR', VS_strCodEmp);
        qryPadrao.ParamByName('CODFRE').AsString := strCodigo;
        qryPadrao.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryPadrao.ParamByName('ESTADO').AsString := ALIQUOTAS_ICMS_UF[intOrigem];
        qryPadrao.ParamByName('ALQINT').AsFloat := fltAlqInterna;
        qryPadrao.ParamByName('ALQEST').AsFloat := ALIQUOTAS_ICMS_INTERESTADUAIS[intOrigem, intDestino];
        qryPadrao.ParamByName('FATREG').AsFloat := fCalculaFatorRegional(fltIVAOri, fltAlqInterna, ALIQUOTAS_ICMS_INTERESTADUAIS[intOrigem, intDestino], ALIQUOTAS_ICMS_UF[intOrigem]);
        qryPadrao.ExecSQL;
      end;

      fCommit;

      Result := True;
    except
      Result := False;
      fRollBack;
    end;
  finally
    FreeAndNil(qryPadrao);
  end;
end;


function TCalcFatReg.fSQLFatorRegional: String;
begin
  Result := ' SELECT * FROM CALCFR WHERE CFR_CODFRE = :CODFRE AND CFR_CODEMP = :CODEMP ';
end;

procedure TCalcFatReg.pFormataCampos(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('CFR_ALQINT')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('CFR_ALQINT')).EditFormat    := '#,##0.00';

  TFloatField(Dataset.FieldByName('CFR_ALQEST')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('CFR_ALQEST')).EditFormat    := '#,##0.00';

  TFloatField(Dataset.FieldByName('CFR_FATREG')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('CFR_FATREG')).EditFormat    := '#,##0.00';
end;


class function TCalcFatReg.fIniciaALIQUOTAS_ICMS_INTERESTADUAIS: Boolean;
var qryAliquotas: TZClient;
    qryComand: TUniQuery;
    coluna,
    Linha: integer;
begin
  Result := True;
  qryAliquotas := TZClient.Create(nil);
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Text := 'SELECT * FROM  ALQ_ICMS_INTER';
    qryComand.Open;
    If qryComand.IsEmpty Then
    begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add('INSERT INTO ALQ_ICMS_INTER (ALQ_ORDEM,ALQ_EST_UF, ALQ_EST_AC, ALQ_EST_AL, ALQ_EST_AM, ALQ_EST_AP, ALQ_EST_BA, ALQ_EST_CE, ALQ_EST_DF, ALQ_EST_ES, ALQ_EST_GO, ALQ_EST_MA, ALQ_EST_MG, ALQ_EST_MS, ALQ_EST_MT, ALQ_EST_PA, ALQ_EST_PB, ALQ_EST_PE, ALQ_EST_PI, ');
      qryComand.SQL.Add('ALQ_EST_PR, ALQ_EST_RJ, ALQ_EST_RN, ALQ_EST_RO, ALQ_EST_RR, ALQ_EST_RS, ALQ_EST_SC, ALQ_EST_SE, ALQ_EST_SP, ALQ_EST_TO, ALQ_EST_EX) VALUES');
      qryComand.SQL.Add('(1, "AC","19.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(2, "AL","12.00","19.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00",');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(3,"AM","12.00","12.00","20.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00",');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(4,"AP","12.00","12.00","12.00","18.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00",');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(5,"BA","12.00","12.00","12.00","12.00","19.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00",');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(6,"CE","12.00","12.00","12.00","12.00","12.00","18.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00",');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(7,"DF","12.00","12.00","12.00","12.00","12.00","12.00","18.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00",');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(8,"ES","12.00","12.00","12.00","12.00","12.00","12.00","12.00","17.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(9,"GO","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","17.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(10,"MA","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","20.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(11,"MG","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","18.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00", ');
      qryComand.SQL.Add('"12.00","7.00","7.00","7.00","12.00","12.00","7.00","12.00","7.00","4.00"),');
      qryComand.SQL.Add('(12,"MS","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","17.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(13,"MT","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","17.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(14,"PA","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","19.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(15,"PB","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","18.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(16,"PE","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","18.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(17,"PI","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"21.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(18,"PR","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00","7.00","7.00","7.00","7.00","7.00","7.00","19.00", ');
      qryComand.SQL.Add('"12.00","7.00","7.00","7.00","12.00","12.00","7.00","12.00","7.00","4.00"),');
      qryComand.SQL.Add('(19,"RJ","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00", ');
      qryComand.SQL.Add('"18.00","7.00","7.00","7.00","12.00","12.00","7.00","12.00","7.00","4.00"),');
      qryComand.SQL.Add('(20,"RN","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","20.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(21,"RO","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","17.50","12.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(22,"RR","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","20.00","12.00","12.00","12.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(23,"RS","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00", ');
      qryComand.SQL.Add('"12.00","7.00","7.00","7.00","17.50","12.00","7.00","12.00","7.00","4.00"),');
      qryComand.SQL.Add('(24,"SC","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00", ');
      qryComand.SQL.Add('"12.00","7.00","7.00","7.00","12.00","17.00","7.00","12.00","7.00","4.00"),');
      qryComand.SQL.Add('(25,"SE","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add('"12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","22.00","12.00","12.00","4.00"),');
      qryComand.SQL.Add('(26,"SP","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00","7.00","7.00","7.00","7.00","7.00","7.00","12.00", ');
      qryComand.SQL.Add('"12.00","7.00","7.00","7.00","12.00","12.00","7.00","18.00","7.00","4.00"),');
      qryComand.SQL.Add('(27,"TO","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00", ');
      qryComand.SQL.Add(' "12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","12.00","20.00","4.00"),');
      qryComand.SQL.Add('(28,"EX","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00",');
      qryComand.SQL.Add('"4.00","4.00","4.00","4.00","4.00","4.00","4.00","4.00","0.00");');
      qryComand.ExecSQL;
    End;

    qryAliquotas.qryQuery.SQL.Add('SELECT ALQ_EST_UF,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_AC,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_AL,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_AM,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_AP,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_BA,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_CE,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_DF,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_ES,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_GO,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_MA,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_MG,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_MS,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_MT,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_PA,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_PB,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_PE,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_PI,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_PR,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_RJ,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_RN,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_RO,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_RR,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_RS,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_SC,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_SE,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_SP,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_TO,');
    qryAliquotas.qryQuery.SQL.Add('       ALQ_EST_EX');
    qryAliquotas.qryQuery.SQL.Add('  FROM ALQ_ICMS_INTER  ');
    qryAliquotas.qryQuery.SQL.Add(' ORDER BY  ALQ_ORDEM ');

    qryAliquotas.fAbreClient(False, 'TCalcFatReg.fIniciaALIQUOTAS_ICMS_INTERESTADUAIS');


    while not qryAliquotas.Eof Do
    Begin
      Linha := qryAliquotas.RecNo -1;
      For coluna := 1 To (qryAliquotas.Fields.Count -1) do
      Begin
        ALIQUOTAS_ICMS_INTERESTADUAIS[linha, coluna -1] := qryAliquotas.Fields[coluna].AsFloat;
      End;
      qryAliquotas.Next;
    End;

(*
      ALIQUOTAS_ICMS_INTERESTADUAIS := ;
      {      AC  AL  AM  AP  BA  CE  DF  ES  GO  MA  MG  MS  MT  PA  PB  PE  PI  PR  RJ  RN  RO  RR  RS  SC  SE  SP  TO  EX
     0 {AC} ( 19, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04),
     1 {AL} ( 12, 19, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     2 {AM} ( 12, 12, 20, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     3 {AP} ( 12, 12, 12, 18, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     4 {BA} ( 12, 12, 12, 12, 19, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     5 {CE} ( 12, 12, 12, 12, 12, 18, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     6 {DF} ( 12, 12, 12, 12, 12, 12, 18, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     7 {ES} ( 12, 12, 12, 12, 12, 12, 12, 17, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     8 {GO} ( 12, 12, 12, 12, 12, 12, 12, 12, 17, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
     9 {MA} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 20, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    10 {MG} ( 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 18, 07, 07, 07, 07, 07, 07, 12, 12, 07, 07, 07, 12, 12, 07, 12, 07, 04 ),
    11 {MS} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 17, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    12 {MT} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 17, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    13 {PA} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 19, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    14 {PB} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 18, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    15 {PE} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 18, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    16 {PI} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 21, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 04 ),
    17 {PR} ( 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 12, 07, 07, 07, 07, 07, 07, 19, 12, 07, 07, 07, 12, 12, 07, 12, 07, 04 ),
    18 {RJ} ( 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 12, 07, 07, 07, 07, 07, 07, 12, 18, 07, 07, 07, 12, 12, 07, 12, 07, 04 ),
    19 {RN} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 20, 12, 12, 12, 12, 12, 12, 12, 04 ),
    20 {RO} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,17.5,12, 12, 12, 12, 12, 12, 04 ),
    21 {RR} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 20, 12, 12, 12, 12, 12, 04 ),
    22 {RS} ( 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 12, 07, 07, 07, 07, 07, 07, 12, 12, 07, 07, 07,17.5,12, 07, 12, 07, 04 ),
    23 {SC} ( 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 12, 07, 07, 07, 07, 07, 07, 12, 12, 07, 07, 07, 12, 17, 07, 12, 07, 04 ),
    24 {SE} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 22, 12, 12, 04 ),
    25 {SP} ( 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 12, 07, 07, 07, 07, 07, 07, 12, 12, 07, 07, 07, 12, 12, 07, 18, 07, 04 ),
    26 {TO} ( 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 20, 04 ),
    27 {EX} ( 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 00 ) );

*)
  Finally
    FreeAndNil(qryAliquotas);
    FreeAndNil(qryComand);
  End;
End;


end.
