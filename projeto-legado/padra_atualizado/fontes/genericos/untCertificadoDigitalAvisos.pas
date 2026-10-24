unit untCertificadoDigitalAvisos;

interface

uses System.Classes, cxProgressBar, System.Generics.Collections;

type
  TCertificadoDigitalAvisos = class
  private
    type
      TCertificado = record
        CodigoEmpresa : String;
        DataVencto : TDateTime;
      End;
  private
    FProgresso : TcxProgressBar;
    function CorpoMensagemCertificadoDigitalAVencer(const ACodEmp : String; ADtaVencto : TDateTime) : TStringList;
    function CorpoMensagemCertificadoDigitalVencido(const ACodEmp : String; ADtaVencto : TDateTime) : TStringList;
    procedure EfetivarEnvioMensagens(const ACertificado : TCertificado; const ACodigoOperador : String);
    function GetCertificadosDigitaisComVencimento(const ADiasAntes, ADiasApos : Integer): TList<TCertificado>;
  public
    procedure DispararMensagens;
    constructor Create(const AProgresso: TcxProgressBar);
  End;

implementation

uses untFuncoesSimples, UntMsgInterna, System.SysUtils, Uni;

{ TCertificadoDigitalAvisos }

function TCertificadoDigitalAvisos.CorpoMensagemCertificadoDigitalAVencer(const ACodEmp: String; ADtaVencto: TDateTime): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;
  Result.Add('************************************************************************');
  Result.Add('*                            MENSAGEM                                  *');
  Result.Add('*                                                                      *');
  Result.Add(Format('*  CERTIFICADO DIGITAL DA EMPRESA %s IRÁ VENCER NO DIA %s.    *', [ACodEmp, FormatDateTime('dd/mm/yyyy', ADtaVencto)]));
  Result.Add('*                                                                      *');
  Result.Add('*                                                                      *');
  Result.Add(Format('*   %s                                                *', [FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow())]));
  Result.Add('************************************************************************');
end;

function TCertificadoDigitalAvisos.CorpoMensagemCertificadoDigitalVencido(const ACodEmp: String; ADtaVencto: TDateTime): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;
  Result.Add('***************************************************************************');
  Result.Add('*                            MENSAGEM                                     *');
  Result.Add('*                                                                         *');
  Result.Add(Format('* CERTIFICADO DIGITAL DA EMPRESA %s ESTÁ VENCIDO DESDE O DIA %s. *', [ACodEmp, FormatDateTime('dd/mm/yyyy', ADtaVencto)]));
  Result.Add('*                                                                         *');
  Result.Add('*                                                                         *');
  Result.Add(Format('*   %s                                                   *', [FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow())]));
  Result.Add('***************************************************************************');
end;

constructor TCertificadoDigitalAvisos.Create(const AProgresso: TcxProgressBar);
begin
  FProgresso := AProgresso;
end;

procedure TCertificadoDigitalAvisos.DispararMensagens;
  Var
    LOperadores : TUniQuery;
    LListaCertificados : TList<TCertificado>;
    LDiaAntDef : Integer;
    LDiaAposDef : Integer;
    LCertificado : TCertificado;
    LEmpresasAcesso : String;
begin
  LDiaAntDef := 16;
  LDiaAposDef := 20;
  pDiasAviso('CADOPE.OPE_MSGCER', LDiaAntDef, LDiaAposDef);
  LListaCertificados := GetCertificadosDigitaisComVencimento(LDiaAntDef, LDiaAposDef);
  Try
    If (LListaCertificados.Count = 0) Then
      Exit;
    LOperadores := fCriaQuery;
    Try
      LOperadores.SQL.Add('SELECT OPE_CODOPE, OPE_EMPACE FROM CADOPE WHERE OPE_MSGCER = "S"');
      LOperadores.Open;
      If (LOperadores.IsEmpty) Then
        Exit;
      FProgresso.Properties.Max := LOperadores.RecordCount;
      LOperadores.First;
      While Not LOperadores.Eof Do
      Begin
        FProgresso.Position := LOperadores.RecNo;
        For LCertificado in LListaCertificados Do
        Begin
          LEmpresasAcesso := LOperadores.FieldByName('OPE_EMPACE').AsString;
          If (Not LEmpresasAcesso.Contains(LCertificado.CodigoEmpresa)) Then
            Continue;
          EfetivarEnvioMensagens(LCertificado, LOperadores.FieldByName('OPE_CODOPE').AsString);
        End;
        LOperadores.Next;
      End;
      FProgresso.Position := 0;
    Finally
      FreeAndNil(LOperadores);
    End;
  Finally
    FreeAndNil(LListaCertificados);
  End;
end;

procedure TCertificadoDigitalAvisos.EfetivarEnvioMensagens(const ACertificado : TCertificado; const ACodigoOperador : String);
  Var
    LMensagem : TStringList;
    LMsgInterna : TMsgInterna;
begin
  LMsgInterna := TMsgInterna.Create(Nil);
  Try
    If (VS_Date > ACertificado.DataVencto) Then
    Begin
      LMensagem := CorpoMensagemCertificadoDigitalVencido(ACertificado.CodigoEmpresa, ACertificado.DataVencto);
      Try
        LMsgInterna.fEnviaMensagem(Format('Certificado digital da empresa %s VENCIDO!', [ACertificado.CodigoEmpresa]),
                                   LMensagem.Text,
                                   strLoginUsuarioLogado,
                                   ACodigoOperador,
                                   'N',
                                   EmptyStr);
      Finally
        FreeAndNil(LMensagem);
      End;
    End
    Else
    Begin
      LMensagem := CorpoMensagemCertificadoDigitalAVencer(ACertificado.CodigoEmpresa, ACertificado.DataVencto);
      Try
        LMsgInterna.fEnviaMensagem(Format('Certificado digital da empresa %s irá VENCER em breve!', [ACertificado.CodigoEmpresa]),
                                   LMensagem.Text,
                                   strLoginUsuarioLogado,
                                   ACodigoOperador,
                                   'N',
                                   EmptyStr);
      Finally
        FreeAndNil(LMensagem);
      End;
    End;
  Finally
    FreeAndNil(LMsgInterna);
  End;
end;

function TCertificadoDigitalAvisos.GetCertificadosDigitaisComVencimento(const ADiasAntes, ADiasApos : Integer): TList<TCertificado>;
  Var
    LCadCer : TUniQuery;
    LCertificado : TCertificado;
begin
  LCadCer := fCriaQuery(Nil);
  Try
    Result := TList<TCertificado>.Create;
    LCadCer.Close;
    LCadCer.SQL.Clear;
    LCadCer.SQL.Add(' SELECT CER_CODEMP, CER_DTAVAL, ');
    LCadCer.SQL.Add(Format(' DATE_SUB(CER_DTAVAL, INTERVAL %d DAY) AS DATA_ANTES, ', [ADiasAntes]));
    LCadCer.SQL.Add(Format(' DATE_ADD(CER_DTAVAL, INTERVAL %d DAY) AS DATA_APOS ', [ADiasApos]));
    LCadCer.SQL.Add('   FROM CADCER ');
    LCadCer.SQL.Add('  WHERE CER_DTAVAL IS NOT NULL ');
    LCadCer.SQL.Add(' HAVING CURRENT_DATE BETWEEN DATA_ANTES AND DATA_APOS ');
    LCadCer.Open;
    LCadCer.First;
    While Not LCadCer.Eof Do
    Begin
      FillChar(LCertificado, SizeOf(LCertificado), #0);
      LCertificado.CodigoEmpresa := LCadCer.FieldByName('CER_CODEMP').AsString;
      LCertificado.DataVencto := LCadCer.FieldByName('CER_DTAVAL').AsDateTime;
      Result.Add(LCertificado);
      LCadCer.Next;
    End;
  Finally
    FreeAndNil(LCadCer);
  End;
end;

end.
