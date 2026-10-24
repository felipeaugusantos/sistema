unit untConsultaCadastro;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
{$ENDIF}
  SysUtils,
  untRegistrarTarefa;

type
  TTipoDeConsultaCadastro = (tccDestinatario, tccEmitente);

  TConsultaCadastro = class
  private
    FNumeroMaxConsultas : Integer;
    FCodigoEmpresa : String;
    FTarefa: TRegistrarTarefa;
    FTipo: TTipoDeConsultaCadastro;
    procedure GravarConsultaDenegada(const ACodigoCliente, AIrregularidade : String);
    procedure MarcarRegistroComoConsultado(const AAutoincrem, AObservacoes, ADescricaoSituacao : String);
    function Concatenar(const arrInfo : Array Of String) : String;
    procedure ExecutarConsultaDestinatario;
    procedure ExecutarConsultaEmitente;
    procedure GravarConsultaCadastroEmitente(const AObservacoes, ADescricaoSituacao, ACNPJ, AInscEst, AUF, ACodigoEmpresa : String);
  public
    constructor Create(ATarefa: TRegistrarTarefa; const ATipo: TTipoDeConsultaCadastro);
    destructor Destroy; override;
    procedure Executar;
    property NumeroMaxConsultas : Integer read FNumeroMaxConsultas write FNumeroMaxConsultas;
    property CodigoEmpresa : String read FCodigoEmpresa write FCodigoEmpresa;
  end;

implementation

uses untInterfaces, untLibNfe, DB,
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ;

{ TConsultaCadastro }

procedure TConsultaCadastro.MarcarRegistroComoConsultado(const AAutoincrem, AObservacoes, ADescricaoSituacao: String);
  Var
    LUpdate : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LUpdate := fCriaQuery;
  Try
    LUpdate.SQL.Text := 'UPDATE BLODEN SET DEN_DESSIT = :DESSIT, DEN_OBSERV = :OBSERV, DEN_DTACON = CURRENT_DATE, DEN_HRACON = CURRENT_TIME WHERE AUTOINCREM = :AUTINC';
    LUpdate.ParamByName('AUTINC').AsString := AAutoincrem;
    LUpdate.ParamByName('OBSERV').AsString := AObservacoes;
    LUpdate.ParamByName('DESSIT').AsString := ADescricaoSituacao;
    LUpdate.ExecSQL;
  Finally
    FreeAndNil(LUpdate);
  End;
end;

function TConsultaCadastro.Concatenar(const arrInfo: array of String): String;
  Var
    LCount : Integer;
begin
  Result := '';
  For LCount := 0 To Length(arrInfo)-1 Do
  Begin
    If (fEmptyStr(arrInfo[LCount])) Then
      Continue;
    If (Not fEmptyStr(Result)) Then
      Result := Result + ' - ';
    Result := Result + arrInfo[LCount];
  End;
end;

constructor TConsultaCadastro.Create(ATarefa: TRegistrarTarefa; const ATipo: TTipoDeConsultaCadastro);
begin
  inherited Create;
  FTipo := ATipo;
  FTarefa := ATarefa;
end;

destructor TConsultaCadastro.Destroy;
begin

  inherited;
end;

procedure TConsultaCadastro.Executar;
begin
  ExecutarConsultaDestinatario;
  ExecutarConsultaEmitente;
end;

procedure TConsultaCadastro.ExecutarConsultaDestinatario;
  Var
    LRetornoConsultaCadastro : TRetornoConsultaCadastro;
    LConsultas : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LObservacoes : String;
begin
  If (FTipo <> tccDestinatario) Then
    Exit;
  LConsultas := fCriaQuery;
  Try
    LConsultas.SQL.Text := 'SELECT * FROM BLODEN WHERE DEN_CODEMP = :CODEMP AND DEN_DTACON IS NULL LIMIT ' + IntToStr(FNumeroMaxConsultas);
    LConsultas.ParamByName('CODEMP').AsString := FCodigoEmpresa;
    LConsultas.Open;
    LConsultas.First;

    FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

    While Not LConsultas.Eof Do
    Begin
      Try
        FTarefa.pSinalizarExecutando;

        If FTarefa.blnBloquear Then
          Break;

        FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat('CNPJ:'     +LConsultas.FieldByName('DEN_C_G_C_').AsString, ' / ',
                                                                       'Ins. Est.:'+LConsultas.FieldByName('DEN_INSCRI').AsString));

        LRetornoConsultaCadastro := fConsultaCadastro(LConsultas.FieldByName('DEN_ESTADO').AsString,
                                                      LConsultas.FieldByName('DEN_C_G_C_').AsString,
                                                      LConsultas.FieldByName('DEN_INSCRI').AsString,
                                                      frmModulo.Database);

        Try
          LObservacoes := Concatenar([Trim(LRetornoConsultaCadastro.strDescSituacao), LRetornoConsultaCadastro.strDescSituacao2, LRetornoConsultaCadastro.strDescSituacao3]);
          MarcarRegistroComoConsultado(LConsultas.FieldByName('AUTOINCREM').AsString, LObservacoes, Trim(LRetornoConsultaCadastro.strDescSituacao));
          GravarConsultaDenegada(LConsultas.FieldByName('DEN_CODCLI').AsString, LObservacoes);
        Finally
          FreeAndNil(LRetornoConsultaCadastro);
        End;
      Except
        On E: Exception Do
        Begin
          MarcarRegistroComoConsultado(LConsultas.FieldByName('AUTOINCREM').AsString, E.Message, E.Message);
        End;
      End;
      LConsultas.Next;
    End;
  Finally
    FreeAndNil(LConsultas);
  End;
end;

procedure TConsultaCadastro.ExecutarConsultaEmitente;
  Var
    LConsultas : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LRetornoConsultaCadastro : TRetornoConsultaCadastro;
    LObservacoes : String;
begin
  If (FTipo <> tccEmitente) Then
    Exit;
  LConsultas := fCriaQuery;
  Try
    LConsultas.Close;
    LConsultas.SQL.Clear;
    LConsultas.SQL.Add(' SELECT EMP_C_G_C_, EMP_I_E_S_, CID_ESTADO  ');
    LConsultas.SQL.Add('   FROM CADEMP ');
    LConsultas.SQL.Add('   JOIN CADCID ON CID_CODCID = EMP_CODCID ');
    LConsultas.SQL.Add('  WHERE EMP_CODEMP = :CODEMP ');
    LConsultas.ParamByName('CODEMP').AsString := FCodigoEmpresa;
    LConsultas.Open;
    If LConsultas.IsEmpty Then
      Exit;
    FTarefa.pAtualizarInformacao(FTarefa.strDescricao);
    Try
      FTarefa.pSinalizarExecutando;
      If FTarefa.blnBloquear Then
        Exit;
      FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat('CNPJ:' + LConsultas.FieldByName('EMP_C_G_C_').AsString, ' / ', 'Ins. Est.:' + LConsultas.FieldByName('EMP_I_E_S_').AsString));
      LRetornoConsultaCadastro := fConsultaCadastro(LConsultas.FieldByName('CID_ESTADO').AsString,
                                                    LConsultas.FieldByName('EMP_C_G_C_').AsString,
                                                    LConsultas.FieldByName('EMP_I_E_S_').AsString,
                                                    frmModulo.Database
      );
      Try
        LObservacoes := Concatenar([Trim(LRetornoConsultaCadastro.strDescSituacao), LRetornoConsultaCadastro.strDescSituacao2, LRetornoConsultaCadastro.strDescSituacao3]);
        GravarConsultaCadastroEmitente(LObservacoes, Trim(LRetornoConsultaCadastro.strDescSituacao), LConsultas.FieldByName('EMP_C_G_C_').AsString, LConsultas.FieldByName('EMP_I_E_S_').AsString, LConsultas.FieldByName('CID_ESTADO').AsString, FCodigoEmpresa);
      Finally
        FreeAndNil(LRetornoConsultaCadastro);
      End;
    Except
      On E: Exception Do
        GravarConsultaCadastroEmitente(E.Message, '', LConsultas.FieldByName('EMP_C_G_C_').AsString, LConsultas.FieldByName('EMP_I_E_S_').AsString, LConsultas.FieldByName('CID_ESTADO').AsString, FCodigoEmpresa);
    End;
  Finally
    FreeAndNil(LConsultas);
  End;
end;

procedure TConsultaCadastro.GravarConsultaDenegada(const ACodigoCliente, AIrregularidade : String);
  Var
    LDenega : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LDenega := fCriaQuery;
  Try
    LDenega.SQL.Text := 'INSERT INTO DENEGA (EGA_CODCLI, EGA_DTACON, EGA_HRACON, EGA_IRREGU) VALUES (:CODCLI, CURRENT_DATE, CURRENT_TIME, :IRREGU)';
    LDenega.ParamByName('CODCLI').AsString := ACodigoCliente;
    LDenega.ParamByName('IRREGU').AsString := AIrregularidade;
    LDenega.ExecSQL;
  Finally
    FreeAndNil(LDenega);
  End;
end;

procedure TConsultaCadastro.GravarConsultaCadastroEmitente(const AObservacoes, ADescricaoSituacao, ACNPJ, AInscEst, AUF, ACodigoEmpresa : String);
  Var
    LDtaSis, LHraSis : TDateTime;
    LConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LConsulta := fCriaQuery;
  Try
    pPegaDataHoraSistema(LDtaSis, LHraSis);
    LConsulta.SQL.Text := 'SELECT * FROM CNSCAD WHERE CAD_DTACON = :DTACON AND CAD_CODEMP = :CODEMP';
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('DTACON').AsDateTime := LDtaSis;
    LConsulta.Open;
    If LConsulta.IsEmpty Then
      LConsulta.Insert
    Else
      LConsulta.Edit;
    LConsulta.FieldByName('CAD_C_G_C_').AsString := ACNPJ;
    LConsulta.FieldByName('CAD_INSCRI').AsString := AInscEst;
    LConsulta.FieldByName('CAD_ESTADO').AsString := AUF;
    LConsulta.FieldByName('CAD_CODEMP').AsString := ACodigoEmpresa;
    LConsulta.FieldByName('CAD_OBSERV').AsString := AObservacoes;
    LConsulta.FieldByName('CAD_DESSIT').AsString := ADescricaoSituacao;
    LConsulta.FieldByName('CAD_DTACON').AsDateTime := LDtaSis;
    LConsulta.FieldByName('CAD_HRACON').AsDateTime := LHraSis;
    LConsulta.Post;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.
