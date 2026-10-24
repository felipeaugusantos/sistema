unit Contabilidade.Classes.TSaldoContasControladas;

interface

uses
  Data.DB, Uni, System.Classes ;

type

  TRegSaldoContaControlada = record
    AUTOINCREM : integer ;
    SAL_CTACON : string ;
    SAL_DTALAN : TDate ;
    SAL_HISPAD : integer ;
    SAL_HISTOR : string ;
    SAL_VALLAN : double ;
    SAL_CREDEB : string ;
    SAL_AJLUCR : string ;
    SAL_NATAJU : string ;
    SAL_CODEMP : string ;
  end;

  TSaldoContasControladas = class
  private
    class function fAlteraDadosInterno(const ADados: TRegSaldoContaControlada): Boolean ;
    class function fSelecionaDatasCtaCon(const AStrCodigo: String): TUniQuery ;
    class function fDataPermitida(const AstrCodigo:String; const AdtaDtaLan: TDateTime): Boolean ;
  public
    class function fAlteraDados(var AQryDados: TUniQuery; const ADados: TRegSaldoContaControlada; const AstrCodigo:String): boolean ;
    class function fPreparaDadosAlterar(const AQryDados: TUniQuery): TRegSaldoContaControlada ;
    class function fCarregaDados(var AQryDados: TUniQuery; const ACodEmp, ACntCon: string): Boolean ;
    class function fDeletaDados(const AIntCodigo: integer): Boolean ;
    class function fOrigemAutomatica(const AIntCodigo: integer): Boolean ;
    class function fPodeIncluirDataCtaCon(const AstrCodigo:String; const AdtaDtaLan: TDateTime): Boolean ;
  end;


implementation

uses
  Contabilidade.View.SaldoContasControladasAltera, System.SysUtils,
  untFuncoesSimples, System.Variants ;

{ TSaldoContasControladas }

class function TSaldoContasControladas.fAlteraDados(var AQryDados: TUniQuery;
  const ADados: TRegSaldoContaControlada; const AstrCodigo:String): boolean;
var
  LFrmSaldoContasControladasAltera : TfrmSaldoContasControladasAltera ;
  LDados : TRegSaldoContaControlada ;
begin
  Result := False ;
  LFrmSaldoContasControladasAltera := TfrmSaldoContasControladasAltera.Create(Nil) ;
  LFrmSaldoContasControladasAltera.CodigoCtaCon := AstrCodigo ;
  LFrmSaldoContasControladasAltera.strEmpLan := ADados.SAL_CODEMP;
  try
    if ADados.AUTOINCREM <> 0 then
    begin
      LFrmSaldoContasControladasAltera.edtSAL_DTALAN.Date := ADados.SAL_DTALAN ;
      LFrmSaldoContasControladasAltera.edtSAL_HISPAD.Text := iif(ADados.SAL_HISPAD = 0, '', IntToStr(ADados.SAL_HISPAD))  ;
      LFrmSaldoContasControladasAltera.edtSAL_HISTOR.Text := ADados.SAL_HISTOR ;
      LFrmSaldoContasControladasAltera.edtSAL_VALLAN.Value := ADados.SAL_VALLAN ;
      LFrmSaldoContasControladasAltera.edtSAL_CREDEB.Text := ADados.SAL_CREDEB ;
      LFrmSaldoContasControladasAltera.edtSAL_AJLUCR.Checked := ADados.SAL_AJLUCR = '1' ;
      LFrmSaldoContasControladasAltera.edtSAL_NATAJU.Text := ADados.SAL_NATAJU ;
    end;
    LFrmSaldoContasControladasAltera.ShowModal ;
    if LFrmSaldoContasControladasAltera.blnConfirma then
    begin
      LDados.AUTOINCREM := ADados.AUTOINCREM ;
      LDados.SAL_CTACON := ADados.SAL_CTACON ;
      LDados.SAL_CODEMP := ADados.SAL_CODEMP ;
      ///informações alteradas/incluidas no form.
      LDados.SAL_DTALAN := LFrmSaldoContasControladasAltera.edtSAL_DTALAN.Date  ;
      LDados.SAL_HISPAD := StrToIntDef(LFrmSaldoContasControladasAltera.edtSAL_HISPAD.Text,0)  ;
      LDados.SAL_HISTOR := LFrmSaldoContasControladasAltera.edtSAL_HISTOR.Text ;
      LDados.SAL_VALLAN := LFrmSaldoContasControladasAltera.edtSAL_VALLAN.Value ;
      LDados.SAL_CREDEB := LFrmSaldoContasControladasAltera.edtSAL_CREDEB.Text;
      LDados.SAL_AJLUCR := iif(LFrmSaldoContasControladasAltera.edtSAL_AJLUCR.Checked, '1', '0') ;
      LDados.SAL_NATAJU := LFrmSaldoContasControladasAltera.edtSAL_NATAJU.Text ;

      Result := fAlteraDadosInterno(LDados) ;

    end;
  finally
    pFreeAndNil(LFrmSaldoContasControladasAltera) ;
  end;
end;

class function TSaldoContasControladas.fAlteraDadosInterno(
  const ADados: TRegSaldoContaControlada): Boolean;
var
  LqryExec: TUniQuery ;
begin
  result := False ;
  LqryExec := fCriaQuery() ;
  try
    fStartTransaction;
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      /// incluir
      if ADados.AUTOINCREM = 0 then
      begin
        LqryExec.SQL.Add(' INSERT INTO SALCCB (SAL_CTACON, SAL_DTALAN, SAL_HISPAD, SAL_HISTOR, SAL_VALLAN, SAL_CREDEB, SAL_AJLUCR, SAL_NATAJU, SAL_CODEMP) ') ;
        LqryExec.SQL.Add('  VALUES ') ;
        LqryExec.SQL.Add('  (:CTACON, :DTALAN, :HISPAD, :HISTOR, :VALLAN, :CREDEB, :AJLUCR, :NATAJU, :CODEMP); ') ;
      end
      else // alterar
      begin
       LqryExec.SQL.Add('UPDATE SALCCB SET ') ;
       LqryExec.SQL.Add('  SAL_CTACON = :CTACON, ') ;
       LqryExec.SQL.Add('  SAL_DTALAN = :DTALAN, ') ;
       LqryExec.SQL.Add('  SAL_HISPAD = :HISPAD, ') ;
       LqryExec.SQL.Add('  SAL_HISTOR = :HISTOR, ') ;
       LqryExec.SQL.Add('  SAL_VALLAN = :VALLAN, ') ;
       LqryExec.SQL.Add('  SAL_CREDEB = :CREDEB, ') ;
       LqryExec.SQL.Add('  SAL_AJLUCR = :AJLUCR, ') ;
       LqryExec.SQL.Add('  SAL_NATAJU = :NATAJU, ') ;
       LqryExec.SQL.Add('  SAL_CODEMP = :CODEMP ') ;
       LqryExec.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ; ') ;
       LqryExec.ParamByName('AUTOINCREM').AsInteger := ADados.AUTOINCREM ;
      end;
      LqryExec.ParamByName('CTACON').AsString := ADados.SAL_CTACON ;
      LqryExec.ParamByName('DTALAN').AsDate := ADados.SAL_DTALAN ;
      LqryExec.ParamByName('HISPAD').Value := iif(ADados.SAL_HISPAD=0, Null, ADados.SAL_HISPAD) ;
      LqryExec.ParamByName('HISTOR').AsString := ADados.SAL_HISTOR ;
      LqryExec.ParamByName('VALLAN').AsFloat := ADados.SAL_VALLAN ;
      LqryExec.ParamByName('CREDEB').AsString := ADados.SAL_CREDEB ;
      LqryExec.ParamByName('AJLUCR').AsString := ADados.SAL_AJLUCR ;
      LqryExec.ParamByName('NATAJU').Value := iif(fEmptyStr(ADados.SAL_NATAJU), Null, ADados.SAL_NATAJU)  ;
      LqryExec.ParamByName('CODEMP').AsString := ADados.SAL_CODEMP ;
      LqryExec.ExecSQL ;
      fCommit();
    except
      On E: Exception Do
      Begin
        fRollBack();
        Raise Exception.Create('Problemas ao gravar saldo da conta controlada !'+#13+E.Message);
      End;
    end;
    result := True ;
  finally
    FreeAndNil(LqryExec) ;
  end;
end;

class function TSaldoContasControladas.fCarregaDados(var AQryDados: TUniQuery;
  const ACodEmp, ACntCon: string): Boolean;
begin
  AQryDados.Close ;
  AQryDados.SQL.Clear ;
  AQryDados.SQL.Add(' SELECT ') ;
  AQryDados.SQL.Add('   SALCCB.AUTOINCREM, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_CTACON, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_DTALAN, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_HISPAD, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_HISTOR, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_VALLAN, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_CREDEB, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_AJLUCR, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_NATAJU, ') ;
  AQryDados.SQL.Add('   NATAJU.NAT_DESCRI, ') ;
  AQryDados.SQL.Add('   SALCCB.SAL_CODEMP ') ;
  AQryDados.SQL.Add(' FROM SALCCB LEFT JOIN NATAJU ON SAL_NATAJU = NAT_CODIGO ') ;
  AQryDados.SQL.Add(' WHERE SALCCB.SAL_CTACON = :CTACON AND SALCCB.SAL_CODEMP = :CODEMP ') ;
  AQryDados.SQL.Add(' ORDER BY SALCCB.SAL_DTALAN, SALCCB.AUTOINCREM ') ;
  AQryDados.ParamByName('CTACON').AsString := ACntCon ;
  AQryDados.ParamByName('CODEMP').AsString := ACodEmp ;
  AQryDados.Open ;
  result := True ;
end;

class function TSaldoContasControladas.fDataPermitida(const AstrCodigo: String;
  const AdtaDtaLan: TDateTime): Boolean;
var
  LqryConsulta : TUniQuery ;
begin
  result := True ;
  LqryConsulta := fSelecionaDatasCtaCon(AstrCodigo) ;
  try
    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      if not LqryConsulta.FieldByName('AUTOMATICO').IsNull then
      begin
        if LqryConsulta.FieldByName('SAL_DTALAN').AsDateTime >= AdtaDtaLan then
          exit(False)
      end ;
      LqryConsulta.Next ;
    end ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

class function TSaldoContasControladas.fDeletaDados(
  const AIntCodigo: integer): Boolean;
var
  LQryExec: TUniQuery ;
begin
  Result := False ;
  LQryExec := fCriaQuery ;
  try
    fStartTransaction;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LQryExec.SQL.Add('DELETE FROM SALCCB WHERE AUTOINCREM = :AUTOINCREM ;') ;
      LQryExec.ParamByName('AUTOINCREM').AsInteger := AIntCodigo ;
      LQryExec.ExecSQL ;
      fCommit();
    except
      On E: Exception Do
      Begin
        fRollBack();
        Raise Exception.Create('Problemas ao excluir saldo da conta controlada !'+#13+E.Message);
      End;
    end;
    Result := True ;
  finally
    FreeAndNil(LQryExec) ;
  end;
end;

class function TSaldoContasControladas.fOrigemAutomatica(
  const AIntCodigo: integer): Boolean;
var
  LqryVerifica: TUniQuery ;
begin
  LqryVerifica := fCriaQuery ;
  try
    LqryVerifica.Close ;
    LqryVerifica.SQL.Clear ;
    LqryVerifica.SQL.Add('SELECT SAL_CODSAL FROM APUSAL WHERE SAL_CODSAL = :CODSAL ;') ;
    LqryVerifica.ParamByName('CODSAL').AsInteger := AIntCodigo ;
    LqryVerifica.Open ;
    result := LqryVerifica.RecordCount > 0 ;
  finally
    FreeAndNil(LqryVerifica) ;
  end ;
end;

class function TSaldoContasControladas.fPodeIncluirDataCtaCon(
  const AstrCodigo: String; const AdtaDtaLan: TDateTime): Boolean;
begin
  result := fDataPermitida(AstrCodigo, AdtaDtaLan) ;
  if not result then
    fMensagem('ATENÇÃO!', 'Existe apuração do lucro real com data posterior. Antes de efetuar essa ação, a apuração deverá ser ajustada!', ['&Ok']);
end;

class function TSaldoContasControladas.fPreparaDadosAlterar(const AQryDados: TUniQuery): TRegSaldoContaControlada;
begin
  result.AUTOINCREM := AQryDados.FieldByName('AUTOINCREM').AsInteger ;
  result.SAL_CTACON := AQryDados.FieldByName('SAL_CTACON').AsString ;
  result.SAL_DTALAN := AQryDados.FieldByName('SAL_DTALAN').AsDateTime ;
  result.SAL_HISPAD := AQryDados.FieldByName('SAL_HISPAD').AsInteger ;
  result.SAL_HISTOR := AQryDados.FieldByName('SAL_HISTOR').AsString ;
  result.SAL_VALLAN := AQryDados.FieldByName('SAL_VALLAN').AsFloat ;
  result.SAL_CREDEB := AQryDados.FieldByName('SAL_CREDEB').AsString ;
  result.SAL_AJLUCR := AQryDados.FieldByName('SAL_AJLUCR').AsString ;
  result.SAL_NATAJU := AQryDados.FieldByName('SAL_NATAJU').AsString ;
  result.SAL_CODEMP := AQryDados.FieldByName('SAL_CODEMP').AsString ;
end;

class function TSaldoContasControladas.fSelecionaDatasCtaCon(
  const AstrCodigo: String): TUniQuery;
begin
  Result := fCriaQuery() ;
  Result.Close ;
  Result.SQL.Clear ;
  Result.SQL.Add(' SELECT SALCCB.AUTOINCREM, SALCCB.SAL_DTALAN, APUSAL.AUTOINCREM AS AUTOMATICO ') ;
  Result.SQL.Add(' FROM SALCCB LEFT JOIN APUSAL ON SALCCB.AUTOINCREM = APUSAL.SAL_CODSAL ') ;
  Result.SQL.Add(' WHERE SALCCB.SAL_CTACON = :CTACON ') ;
  Result.SQL.Add(' ORDER BY SALCCB.SAL_DTALAN, SALCCB.AUTOINCREM ') ;
  Result.ParamByName('CTACON').AsString := AstrCodigo ;
  Result.Open ;
end;

end.
