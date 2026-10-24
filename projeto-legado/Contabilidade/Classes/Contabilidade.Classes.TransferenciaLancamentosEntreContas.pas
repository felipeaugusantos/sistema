unit Contabilidade.Classes.TransferenciaLancamentosEntreContas;

interface

uses
  Data.DB, Uni, Datasnap.DBClient, UniClientDataSet,
  System.Generics.Collections, StrUtils, SysUtils ;

type
  TFormaPesquisaLancon = (plDebito, plCredito, plTodos) ;

  TParametrosTransferenciaLancamentosEntreContas = record
    CodEmp: String ;
    DataInicio: TDateTime ;
    DataFinal: TDateTime ;
    TipLan: String ;
    FormaPesq: TFormaPesquisaLancon ;
    Planco: String ;
  end ;

  TInfoAutoIncTransf = class
  strict private
    FstrAutoIncren: String ;
    FstrCreDeb: String ;
  public
    property AutoIncrem: String read FstrAutoIncren write FstrAutoIncren;
    property CreDeb: String read FstrCreDeb write FstrCreDeb;
  end ;

  TListInfoAutoIncTransf = TObjectList<TInfoAutoIncTransf> ;

  TTransferenciaLancamentosEntreContas = class
  private
    class procedure pDesmembrarDataHora(const AdtaNow: TDateTime; var AdtaData: TDate; var AstrHora: String) ;
  public
    class function fCarregarDados(var   ALancon: TDataSet;
                                  const AParams: TParametrosTransferenciaLancamentosEntreContas): Boolean ;
    class function fGravaDados(const AstrContaContabil, AstrContaContabilOriginal: String;
                               const AListInfoLancon: TListInfoAutoIncTransf): Boolean ;
    class function fInfoOperadorTransferencia(const AstrAutoIncLancon: String): String ;
  end ;

implementation

uses
  untFuncoesSimples, Contabilidade.Model.TDadosImportacaoContabil,
  Contabilidade.Classes.TGravacaoEmLote, DateUtils ;

{ TTransferenciaLancamentosEntreContas }

class function TTransferenciaLancamentosEntreContas.fCarregarDados(
  var   ALancon: TDataSet;
  const AParams: TParametrosTransferenciaLancamentosEntreContas): Boolean;
var
  LqryConsulta: TUniQuery ;
begin

  if Assigned(ALancon) then
    LqryConsulta := ALancon as TUniQuery
  else
    LqryConsulta := fCriaQuery() ;

  LqryConsulta.Close ;
  LqryConsulta.SQL.Clear ;
  LqryConsulta.SQL.Add(' SELECT ') ;
  LqryConsulta.SQL.Add('    L.AUTOINCREM, ') ;
  LqryConsulta.SQL.Add('    L.CON_EMPLAN, ') ;
  LqryConsulta.SQL.Add('    L.CON_DTALAN, ') ;
  LqryConsulta.SQL.Add('    L.CON_TIPLAN, ') ;
  LqryConsulta.SQL.Add('    L.CON_DESVAL, ') ;
  LqryConsulta.SQL.Add('    L.CON_CONCRE, ') ;
  LqryConsulta.SQL.Add('    CONCRE.NCO_DESCRI AS CON_DESCRE, ') ;
  LqryConsulta.SQL.Add('    L.CON_CONDEB, ') ;
  LqryConsulta.SQL.Add('    CONDEB.NCO_DESCRI AS CON_DESDEB, ') ;
  LqryConsulta.SQL.Add('    L.CON_HISTOR, ') ;
  LqryConsulta.SQL.Add('    L.CON_VALLAN ') ;
  LqryConsulta.SQL.Add(' FROM LANCON L ') ;
  LqryConsulta.SQL.Add('     INNER JOIN CADEMP E      ON L.CON_EMPLAN = E.EMP_CODEMP ') ;
  LqryConsulta.SQL.Add('     LEFT  JOIN PLANCO CONCRE ON CON_CONCRE = CONCRE.NCO_CODCON AND CONCRE.NCO_TPLACO = E.EMP_TPLACO ') ;
  LqryConsulta.SQL.Add('     LEFT  JOIN PLANCO CONDEB ON CON_CONDEB = CONDEB.NCO_CODCON AND CONDEB.NCO_TPLACO = E.EMP_TPLACO ') ;
  LqryConsulta.SQL.Add(' WHERE ') ;
  LqryConsulta.SQL.Add('   L.CON_EMPLAN = :EMPLAN ') ;
  LqryConsulta.SQL.Add('   AND L.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
  LqryConsulta.ParamByName('EMPLAN').AsString := AParams.CodEmp ;
  LqryConsulta.ParamByName('DTAINI').AsDateTime := AParams.DataInicio ;
  LqryConsulta.ParamByName('DTAFIN').AsDateTime := AParams.DataFinal ;
  if not fEmptyStr(AParams.TipLan) then
  begin
    LqryConsulta.SQL.Add('   AND L.CON_TIPLAN = :TIPLAN ') ;
    LqryConsulta.ParamByName('TIPLAN').AsString := AParams.TipLan ;
  end ;
  case AParams.FormaPesq of
    plDebito  :
               begin
                 LqryConsulta.SQL.Add('   AND L.CON_CONDEB = :CONDEB ') ;
                 LqryConsulta.ParamByName('CONDEB').AsString := AParams.Planco ;
               end ;
    plCredito :
               begin
                 LqryConsulta.SQL.Add('   AND L.CON_CONCRE = :CONCRE ') ;
                 LqryConsulta.ParamByName('CONCRE').AsString := AParams.Planco ;
               end ;
    plTodos :
               begin
                 LqryConsulta.SQL.Add('   AND (L.CON_CONDEB = :CONDEB OR L.CON_CONCRE = :CONCRE) ') ;
                 LqryConsulta.ParamByName('CONDEB').AsString := AParams.Planco ;
                 LqryConsulta.ParamByName('CONCRE').AsString := AParams.Planco ;
               end ;
  end ;

  LqryConsulta.SQL.Add(' ORDER BY L.CON_DTALAN ') ;

  LqryConsulta.Open ;

  LqryConsulta.First ;

  ALancon := LqryConsulta ;

  Result := True ;
end;

class function TTransferenciaLancamentosEntreContas.fGravaDados(
  const AstrContaContabil, AstrContaContabilOriginal: String;
  const AListInfoLancon: TListInfoAutoIncTransf): Boolean;
var
  LItem: TInfoAutoIncTransf ;
  LqryExec: TUniQuery ;
  LItemGravar: TInfoPersistirTransfCnt ;
  LGravacaoEmLote: TGravacaoEmLote ;
  LlstTransferencia: TObjectList<TInfoPersistirTransfCnt> ;
  LstrHora: String ;
  LdtaData: TDate ;
begin
  Result := False ;

  if AListInfoLancon.Count > 0 then
  begin
    LqryExec := fCriaQuery() ;
    LGravacaoEmLote := TGravacaoEmLote.Create(Nil,
                                              LqryExec.Connection.Database,
                                              LqryExec.Connection.Username,
                                              LqryExec.Connection.Password,
                                              IntToStr(LqryExec.Connection.Port),
                                              LqryExec.Connection.Server);
    LlstTransferencia := TObjectList<TInfoPersistirTransfCnt>.Create();
    try
      Result := True ;
      for LItem in AListInfoLancon do
      begin
        pDesmembrarDataHora(fNow(), LdtaData, LstrHora);

        LItemGravar := TInfoPersistirTransfCnt.Create ;
        LItemGravar.Lancon := StrToInt64(LItem.AutoIncrem) ;
        LItemGravar.ContaContabil := AstrContaContabil ;
        LItemGravar.CreDeb := LItem.CreDeb ;
        LItemGravar.CodOpe := strLoginUsuarioLogado ;
        LItemGravar.DtaTrn := LdtaData ;
        LItemGravar.HraTrn := LstrHora ;
        LlstTransferencia.Add(LItemGravar) ;
      end ;

      LGravacaoEmLote.fStartTransaction ;
      try
        LGravacaoEmLote.pGravarTrnCnt(LlstTransferencia, AstrContaContabilOriginal);
        LGravacaoEmLote.fCommit ;
      except
        on E: Exception do
        begin
          LGravacaoEmLote.fRollBack ;
          fMensagem('','Erro na gravação dos dados. ' + E.message, ['&OK']);
          Result := False;
        end ;
      end ;

    finally
      FreeAndNil(LqryExec) ;
      FreeAndNil(LlstTransferencia) ;
      FreeAndNil(LGravacaoEmLote) ;
    end ;

  end ;

end;

class function TTransferenciaLancamentosEntreContas.fInfoOperadorTransferencia(
  const AstrAutoIncLancon: String): String;
var
  LqryConsulta: TUniQuery ;
  LstrConteudo: String ;
begin
  Result := '' ;

  if not fTabelaExiste('TRNCNT') then
    Exit ;

   LqryConsulta := fCriaQuery() ;
   try
     LqryConsulta.close ;
     LqryConsulta.SQL.Clear ;
     LqryConsulta.SQL.Add(' SELECT TRN_CNTORI, TRN_CNTNOV, TRN_CREDEB, TRN_CODOPE, TRN_DTATRN, TRN_HRATRN ') ;
     LqryConsulta.SQL.Add(' FROM TRNCNT WHERE TRN_LANCON = :LANCON ORDER BY AUTOINCREM ') ;
     LqryConsulta.ParamByName('LANCON').AsString := AstrAutoIncLancon ;
     LqryConsulta.Open ;

     if LqryConsulta.IsEmpty then
       Exit ;

     LstrConteudo := #13#10 + 'Histórico de Transferência entre Contas ' + #13#10 ;
     LstrConteudo := LstrConteudo + fPadL('Conta Original', 20) + ' ' + fPadL('Conta Alterada', 20) + ' ' + fPadL('D/C', 3) + ' ' + fPadL('Operador', 8) + ' ' + fPadL('Data Alt.', 10) + ' ' + fPadL('Hora Alt.', 9) + #13#10 ;
     LstrConteudo := LstrConteudo + fReplicatorStr('-', 20) + ' ' + fReplicatorStr('-', 20) + ' ' + fReplicatorStr('-', 3) + ' ' + fReplicatorStr('-', 8) + ' ' + fReplicatorStr('-', 10) + ' ' + fReplicatorStr('-', 9) + #13#10 ;
     LqryConsulta.First ;
     while not LqryConsulta.Eof do
     begin
       LstrConteudo := LstrConteudo + fPadL(LqryConsulta.FieldByName('TRN_CNTORI').AsString, 20) + ' ' +
                                      fPadL(LqryConsulta.FieldByName('TRN_CNTNOV').AsString, 20) + ' ' +
                                      fPadL(LqryConsulta.FieldByName('TRN_CREDEB').AsString, 3) + ' ' +
                                      fPadL(LqryConsulta.FieldByName('TRN_CODOPE').AsString, 8) + ' ' +
                                      fPadL(LqryConsulta.FieldByName('TRN_DTATRN').AsString, 10) + ' ' +
                                      fPadL(LqryConsulta.FieldByName('TRN_HRATRN').AsString, 9) + #13#10 ;
       LqryConsulta.Next ;
     end ;

     Result := LstrConteudo ;

   finally
     FreeAndNil(LqryConsulta) ;
   end ;

end;

class procedure TTransferenciaLancamentosEntreContas.pDesmembrarDataHora(
  const AdtaNow: TDateTime; var AdtaData: TDate; var AstrHora: String);
var
  LintDia, LintMes, LintAno, LintHora, LintMinuto, LintSegundo: Word ;
begin
  LintDia := DayOf(AdtaNow) ;
  LintMes := MonthOf(AdtaNow) ;
  LintAno := YearOf(AdtaNow) ;

  LintHora := HourOf(AdtaNow) ;
  LintMinuto := MinuteOf(AdtaNow) ;
  LintSegundo := SecondOf(AdtaNow) ;

  AdtaData := EncodeDate(LintAno, LintMes, LintDia) ;
  AstrHora := TimeToStr(EncodeTime(LintHora, LintMinuto, LintSegundo, 0)) ;

end;

end.
