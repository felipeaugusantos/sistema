unit untLogAlteracaoParticipante;

interface

uses SysUtils, Uni;

Type
  TCampoAlterado = (caNome, caCodPais, caCnpj, caCpf, caIES, caCodMunicipio,
    caSuframa, caEndereco, caNumEndereco, caComplEndereco, caBairro);

  procedure pAlteracaoDadosParticipante(const campoAlterado: TCampoAlterado;
    const strCodPar, strTip_FC, strValorAtual, strValorAntigo: String);

  procedure pAlteraCnpjOuCpf(const strCodPar, strTip_FC, strValorAtual,
    strValorAntigo: String);

  procedure pAlteraCidade(strCodPar, strTip_FC, strCodCidAtual, strCodCidAntigo: String);

implementation

uses untFuncoesSimples;

function fRetornaCodigoCampo(const campoAlterado: TCampoAlterado): String;
begin
  Case campoAlterado Of
    caNome: Result := '03';
    caCodPais: Result := '04';
    caCnpj: Result := '05';
    caCpf: Result := '06';
    caIES: Result := '07';
    caCodMunicipio: Result := '08';
    caSuframa: Result := '09';
    caEndereco: Result := '10';
    caNumEndereco: Result := '11';
    caComplEndereco: Result := '12';
    caBairro: Result := '13';
  End;
end;

procedure pAlteracaoDadosParticipante(const campoAlterado: TCampoAlterado;
  const strCodPar, strTip_FC, strValorAtual, strValorAntigo: String);
  Var
    qryAltPar: TUniQuery;
begin
  If strValorAtual = strValorAntigo Then
  Begin
    Exit;
  End;

  qryAltPar := fCriaQuery(Nil);
  qryAltPar.SQL.Add('REPLACE INTO ALTPAR (');
  qryAltPar.SQL.Add('  ALT_OPEALT, ');
  qryAltPar.SQL.Add('  ALT_CODPAR, ');
  qryAltPar.SQL.Add('  ALT_TIP_FC, ');
  qryAltPar.SQL.Add('  ALT_DTAALT, ');
  qryAltPar.SQL.Add('  ALT_NUMCAM, ');
  qryAltPar.SQL.Add('  ALT_CONANT, ');
  qryAltPar.SQL.Add('  AUTOINCREM) ');
  qryAltPar.SQL.Add('VALUES (      ');
  qryAltPar.SQL.Add('  :OPEALT,    ');
  qryAltPar.SQL.Add('  :CODPAR,    ');
  qryAltPar.SQL.Add('  :TIP_FC,    ');
  qryAltPar.SQL.Add('  :DTAALT,    ');
  qryAltPar.SQL.Add('  :NUMCAM,    ');
  qryAltPar.SQL.Add('  :CONANT,    ');
  qryAltPar.SQL.Add('  :AUTOINCREM)');

  qryAltPar.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;  
  qryAltPar.ParamByName('CODPAR').AsString := strCodPar;
  qryAltPar.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAltPar.ParamByName('DTAALT').AsDateTime := VS_Date;
  qryAltPar.ParamByName('NUMCAM').AsString := fRetornaCodigoCampo(campoAlterado);
  qryAltPar.ParamByName('CONANT').AsString := strValorAntigo;
  qryAltPar.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ALTPAR',VS_strCodEmp);  
  qryAltPar.ExecSQL;

  FreeAndNil(qryAltPar);
end;

procedure pAlteraCnpjOuCpf(const strCodPar, strTip_FC, strValorAtual,
  strValorAntigo: String);
  Var
    caCampo: TCampoAlterado;
begin
  If Length(strValorAntigo) <= 11 Then
  Begin
    caCampo := caCpf;
  End
  Else
  Begin
    caCampo := caCnpj;
  End;
  pAlteracaoDadosParticipante(caCampo, strCodPar, strTip_FC, strValorAtual, strValorAntigo);
end;

procedure pAlteraCidade(strCodPar, strTip_FC, strCodCidAtual, strCodCidAntigo: String);
  Var
    qryCidAtu: TUniQuery;
    qryCidAnt: TUniQuery;
  Const
    SQL = 'SELECT CID_COIBGE, CID_CODPAI FROM CADCID WHERE CID_CODCID = :CODCID';
begin
  If strCodCidAtual = strCodCidAntigo Then
  Begin
    Exit;
  End;

  qryCidAtu := fCriaQuery(Nil);
  qryCidAnt := fCriaQuery(Nil);

  qryCidAtu.SQL.Add(SQL);
  qryCidAnt.SQL.Add(SQL);

  qryCidAtu.ParamByName('CODCID').AsString := strCodCidAtual;
  qryCidAnt.ParamByName('CODCID').AsString := strCodCidAntigo;

  qryCidAtu.Open;
  qryCidAnt.Open;

  pAlteracaoDadosParticipante(caCodMunicipio, strCodPar, strTip_FC,
    qryCidAtu.FieldByName('CID_COIBGE').AsString, qryCidAnt.FieldByName('CID_COIBGE').AsString);

  pAlteracaoDadosParticipante(caCodMunicipio, strCodPar, strTip_FC,
    qryCidAtu.FieldByName('CID_CODPAI').AsString, qryCidAnt.FieldByName('CID_CODPAI').AsString);

  FreeAndNil(qryCidAtu);
  FreeAndNil(qryCidAnt);
end;

end.
