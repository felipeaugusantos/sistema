unit Contabilidade.Classes.LancamentosPeriodicos;

interface

uses System.Generics.Collections ;

type
  TPeriodicoCapa = class
  private
    FAutoincrem : string ;
    FDescri : string ;
    FCodope : string ;
    FDtaalt : TDate  ;
    FHraalt : string ;
  public
    property Autoincrem : string read FAutoincrem write FAutoincrem ;
    property Descri : string read FDescri write FDescri ;
    property Codope : string read FCodope write FCodope ;
    property Dtaalt : TDate  read FDtaalt write FDtaalt ;
    property Hraalt : string read FHraalt write FHraalt ;
  end ;

  TPeriodicoDetalhe = class
  private
    FAutoincrem : string ;
    FSeqger : string ;
    FSeqlan : integer ;
    FEmplan : string ;
    FConcre : string ;
    FCondeb : string ;
    FCcuscr : string ;
    FCcusto : string ;
    FHispad : integer ;
    FHistor : string ;
    FVallan  : double;
    FTiplan : string ;
    FParmul : integer ;
    FClifor : String ;
    FTip_fc : String ;
  public
    property Autoincrem : string read FAutoincrem write FAutoincrem ;
    property Seqger : string read FSeqger write FSeqger ;
    property Seqlan : integer read FSeqlan write FSeqlan ;
    property Emplan : string read FEmplan write FEmplan ;
    property Concre : string read FConcre write FConcre ;
    property Condeb : string read FCondeb write FCondeb ;
    property Ccuscr : string read FCcuscr write FCcuscr ;
    property Ccusto : string read FCcusto write FCcusto ;
    property Hispad : integer read FHispad write FHispad ;
    property Histor : string read FHistor write FHistor ;
    property ValLan : double read FVallan write FVallan ;
    property Tiplan : string read FTiplan write FTiplan ;
    property Parmul : integer read FParmul write FParmul ;
    property Clifor : String read FClifor write FClifor ;
    property Tip_fc : String read FTip_fc write FTip_fc ;
  end ;

  TPeriodicosDetalhe = TObjectList<TPeriodicoDetalhe> ;
  TPeriodicosCapa = TObjectList<TPeriodicoCapa> ;

  TDadosPeriodicoDetalhe = class
  private
    class function fSelect(const AstrSeqLan: string): TPeriodicosDetalhe ;
    class function fDelete(const AstrSeqLan: string): Boolean ;
    class function fInsert(const AlstDetalhe: TPeriodicosDetalhe): Boolean ;
    class function fTrataValor(const AstrValor: String):Variant ;
  public
    class function fSelecionaDados(const AstrSeqLan: string): TPeriodicosDetalhe ;
    class function fDeletaDados(const AstrSeqLan: string): Boolean ;
    class function fInsereDados(const AlstDetalhe: TPeriodicosDetalhe): Boolean ;
    class function fAtualizaDados(const AstrSeqLan: string; const AlstDetalhe: TPeriodicosDetalhe): Boolean ;
  end ;

  TDadosPeriodicoCapa = class
  private
    class function fSelect(const AstrAutoInc: string = ''): TPeriodicosCapa ;
    class function fDelete(const AstrAutoInc: string): Boolean ;
    class function fInsert(const AobjCapa: TPeriodicoCapa): String ;
    class function fUpdate(const AstrAutoInc: string; const AobjCapa: TPeriodicoCapa): Boolean ;
  public
    class function fSelecionaDados(const AstrAutoInc: string = ''): TPeriodicosCapa ;
    class function fDeletaDados(const AstrAutoInc: string): Boolean ;
    class function fInsereDados(const AobjCapa: TPeriodicoCapa): String ;
    class function fAtualizaDados(const AstrAutoInc: string; const AobjCapa: TPeriodicoCapa): Boolean ;
  end ;

implementation

uses Uni, untFuncoesSimples, SysUtils, StrUtils, Variants, Contabilidade.Funcoes ;

{ TDadosPeriodicoDetalhe }

class function TDadosPeriodicoDetalhe.fAtualizaDados(
  const AstrSeqLan: string; const AlstDetalhe: TPeriodicosDetalhe): Boolean;
begin
  result := False ;
  fStartTransaction;
  try
    result := fDelete(AstrSeqLan) ;
    result := fInsert(AlstDetalhe) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TDadosPeriodicoDetalhe.fAtualizaDados]');
    End;
  End;
end;

class function TDadosPeriodicoDetalhe.fDeletaDados(
  const AstrSeqLan: string): Boolean;
begin
  result := False ;
  fStartTransaction;
  try
    result := fDelete(AstrSeqLan) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TDadosPeriodicoDetalhe.fDeletaDados]');
    End;
  End;
end;

class function TDadosPeriodicoDetalhe.fDelete(const AstrSeqLan: string): Boolean;
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('DELETE FROM PERDET WHERE DET_SEQGER = :SEQGER ') ;
    LqryExec.ParamByName('SEQGER').AsString := AstrSeqLan ;
    LqryExec.ExecSQL ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

class function TDadosPeriodicoDetalhe.fInsereDados(
  const AlstDetalhe: TPeriodicosDetalhe): Boolean;
begin
  result := False ;
  fStartTransaction;
  try
    result := fInsert(AlstDetalhe) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TDadosPeriodicoDetalhe.fInsereDados]');
    End;
  End;
end;

class function TDadosPeriodicoDetalhe.fInsert(const AlstDetalhe: TPeriodicosDetalhe): Boolean;
var
  LobjItem: TPeriodicoDetalhe ;
  LqryExec: TUniQuery ;
  LstrAutoInc: String ;
  LblnSubCnt: Boolean ;
begin
  LblnSubCnt := fCfgDesmembrarSubContaCliFor = 'S' ;
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' INSERT INTO PERDET ( ') ;
    LqryExec.SQL.Add(' AUTOINCREM, ') ;
    LqryExec.SQL.Add(' DET_SEQGER, ') ;
    LqryExec.SQL.Add(' DET_SEQLAN, ') ;
    LqryExec.SQL.Add(' DET_EMPLAN, ') ;
    LqryExec.SQL.Add(' DET_CONCRE, ') ;
    LqryExec.SQL.Add(' DET_CONDEB, ') ;
    LqryExec.SQL.Add(' DET_CCUSCR, ') ;
    LqryExec.SQL.Add(' DET_CCUSTO, ') ;
    LqryExec.SQL.Add(' DET_HISPAD, ') ;
    LqryExec.SQL.Add(' DET_HISTOR, ') ;
    LqryExec.SQL.Add(' DET_VALLAN, ') ;
    LqryExec.SQL.Add(' DET_TIPLAN, ') ;
    if LblnSubCnt then
    begin
      LqryExec.SQL.Add(' DET_CLIFOR, ') ;
      LqryExec.SQL.Add(' DET_TIP_FC, ') ;
    end ;
    LqryExec.SQL.Add(' DET_PARMUL  ') ;
    LqryExec.SQL.Add(' ) ') ;
    LqryExec.SQL.Add(' VALUES ') ;
    LqryExec.SQL.Add(' ( ') ;
    LqryExec.SQL.Add(' :AUTOINCREM, ') ;
    LqryExec.SQL.Add(' :SEQGER, ') ;
    LqryExec.SQL.Add(' :SEQLAN, ') ;
    LqryExec.SQL.Add(' :EMPLAN, ') ;
    LqryExec.SQL.Add(' :CONCRE, ') ;
    LqryExec.SQL.Add(' :CONDEB, ') ;
    LqryExec.SQL.Add(' :CCUSCR, ') ;
    LqryExec.SQL.Add(' :CCUSTO, ') ;
    LqryExec.SQL.Add(' :HISPAD, ') ;
    LqryExec.SQL.Add(' :HISTOR, ') ;
    LqryExec.SQL.Add(' :VALLAN, ') ;
    LqryExec.SQL.Add(' :TIPLAN, ') ;
    if LblnSubCnt then
    begin
      LqryExec.SQL.Add(' :CLIFOR, ') ;
      LqryExec.SQL.Add(' :TIP_FC, ') ;
    end ;
    LqryExec.SQL.Add(' :PARMUL ') ;
    LqryExec.SQL.Add(' ) ; ') ;
    for LobjItem in AlstDetalhe do
    begin
      LstrAutoInc := fRetAutoIncrem('PERDET',Vs_strCodEmp) ;
      LqryExec.ParamByName('AUTOINCREM').AsString := LstrAutoInc ;
      LqryExec.ParamByName('SEQGER').AsString := LobjItem.Seqger ;
      LqryExec.ParamByName('SEQLAN').AsInteger := LobjItem.Seqlan ;
      LqryExec.ParamByName('EMPLAN').AsString := LobjItem.Emplan ;
      LqryExec.ParamByName('CONCRE').Value := fTrataValor(LobjItem.Concre) ;
      LqryExec.ParamByName('CONDEB').Value := fTrataValor(LobjItem.Condeb) ;
      LqryExec.ParamByName('CCUSCR').Value := fTrataValor(LobjItem.Ccuscr) ;
      LqryExec.ParamByName('CCUSTO').Value := fTrataValor(LobjItem.Ccusto) ;
      LqryExec.ParamByName('HISPAD').Value := fTrataValor(ifThen(LobjItem.Hispad = 0, '', IntToStr(LobjItem.Hispad))) ;
      LqryExec.ParamByName('HISTOR').Value := fTrataValor(LobjItem.Histor) ;
      LqryExec.ParamByName('VALLAN').AsFloat := LobjItem.ValLan ;
      LqryExec.ParamByName('TIPLAN').AsString := LobjItem.Tiplan ;
      if LblnSubCnt then
      begin
        LqryExec.ParamByName('CLIFOR').AsString := LobjItem.Clifor ;
        LqryExec.ParamByName('TIP_FC').AsString := LobjItem.Tip_fc ;
      end ;
      LqryExec.ParamByName('PARMUL').AsInteger := LobjItem.Parmul ;
      LqryExec.ExecSQL ;
    end ;

  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

class function TDadosPeriodicoDetalhe.fSelecionaDados(
  const AstrSeqLan: string): TPeriodicosDetalhe;
begin
  result := fSelect(AstrSeqLan) ;
end;

class function TDadosPeriodicoDetalhe.fSelect(
  const AstrSeqLan: string): TPeriodicosDetalhe;
var
  LobjItem: TPeriodicoDetalhe ;
  LqryDados: TUniQuery ;
  LblnSubCnt: Boolean ;
begin
  LblnSubCnt := fCfgDesmembrarSubContaCliFor = 'S' ;
  result := TPeriodicosDetalhe.Create();
  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT ') ;
    LqryDados.SQL.Add('   AUTOINCREM, ') ;
    LqryDados.SQL.Add('   DET_SEQGER, ') ;
    LqryDados.SQL.Add('   DET_SEQLAN, ') ;
    LqryDados.SQL.Add('   DET_EMPLAN, ') ;
    LqryDados.SQL.Add('   DET_CONCRE, ') ;
    LqryDados.SQL.Add('   DET_CONDEB, ') ;
    LqryDados.SQL.Add('   DET_CCUSCR, ') ;
    LqryDados.SQL.Add('   DET_CCUSTO, ') ;
    LqryDados.SQL.Add('   DET_HISPAD, ') ;
    LqryDados.SQL.Add('   DET_HISTOR, ') ;
    LqryDados.SQL.Add('   DET_VALLAN, ') ;
    LqryDados.SQL.Add('   DET_TIPLAN, ') ;
    if LblnSubCnt then
    begin
      LqryDados.SQL.Add('   DET_CLIFOR, ') ;
      LqryDados.SQL.Add('   DET_TIP_FC, ') ;
    end
    else
    begin
      LqryDados.SQL.Add('   CAST(NULL AS CHAR(1)) AS DET_CLIFOR, ') ;
      LqryDados.SQL.Add('   CAST(NULL AS CHAR(1)) AS DET_TIP_FC, ') ;
    end ;
    LqryDados.SQL.Add('   DET_PARMUL ') ;
    LqryDados.SQL.Add(' FROM PERDET ') ;
    LqryDados.SQL.Add(' WHERE DET_SEQGER = :SEQGER ') ;
    LqryDados.SQL.Add(' ORDER BY AUTOINCREM ') ;
    LqryDados.ParamByName('SEQGER').AsString := AstrSeqLan ;
    LqryDados.Open ;
    LqryDados.First ;
    while not LqryDados.Eof do
    begin
      LobjItem := TPeriodicoDetalhe.Create ;
      LobjItem.Autoincrem := LqryDados.FieldByName('AUTOINCREM').AsString ;
      LobjItem.Seqger := LqryDados.FieldByName('DET_SEQGER').AsString ;
      LobjItem.Seqlan := LqryDados.FieldByName('DET_SEQLAN').AsInteger ;
      LobjItem.Emplan := LqryDados.FieldByName('DET_EMPLAN').AsString ;
      LobjItem.Concre := LqryDados.FieldByName('DET_CONCRE').AsString ;
      LobjItem.Condeb := LqryDados.FieldByName('DET_CONDEB').AsString ;
      LobjItem.Ccuscr := LqryDados.FieldByName('DET_CCUSCR').AsString ;
      LobjItem.Ccusto := LqryDados.FieldByName('DET_CCUSTO').AsString ;
      LobjItem.Hispad := LqryDados.FieldByName('DET_HISPAD').AsInteger ;
      LobjItem.Histor := LqryDados.FieldByName('DET_HISTOR').AsString ;
      LobjItem.ValLan := LqryDados.FieldByName('DET_VALLAN').AsFloat ;
      LobjItem.Tiplan := LqryDados.FieldByName('DET_TIPLAN').AsString ;
      LobjItem.Parmul := LqryDados.FieldByName('DET_PARMUL').AsInteger ;
      LobjItem.Clifor := LqryDados.FieldByName('DET_CLIFOR').AsString ;
      LobjItem.tip_fc := LqryDados.FieldByName('DET_TIP_FC').AsString ;

      result.Add(LobjItem) ;

      LqryDados.Next ;
    end ;
  finally
    FreeAndNil(LqryDados) ;
  end ;
end;

class function TDadosPeriodicoDetalhe.fTrataValor(
  const AstrValor: String): Variant;
begin
  if fEmptyStr(AstrValor) then
    result := null
  else
    result := AstrValor ;
end;

{ TDadosPeriodicoCapa }

class function TDadosPeriodicoCapa.fAtualizaDados(const AstrAutoInc: string;
  const AobjCapa: TPeriodicoCapa): Boolean;
begin
  result := False ;
  fStartTransaction;
  try
    result := fUpdate(AstrAutoInc, AobjCapa) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TDadosPeriodicoCapa.fAtualizaDados]');
    End;
  End;
end;

class function TDadosPeriodicoCapa.fDeletaDados(
  const AstrAutoInc: string): Boolean;
begin
  result := False ;
  fStartTransaction;
  try
    result := fDelete(AstrAutoInc) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TDadosPeriodicoCapa.fDeletaDados]');
    End;
  End;
end;

class function TDadosPeriodicoCapa.fDelete(const AstrAutoInc: string): Boolean;
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('DELETE FROM PERGER WHERE AUTOINCREM = :AUTOINCREM ') ;
    LqryExec.ParamByName('AUTOINCREM').AsString := AstrAutoInc ;
    LqryExec.ExecSQL ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

class function TDadosPeriodicoCapa.fInsereDados(
  const AobjCapa: TPeriodicoCapa): String;
begin
  result := '' ;
  fStartTransaction;
  try
    result := fInsert(AobjCapa) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TDadosPeriodicoCapa.fInsereDados]');
    End;
  End;
end;

class function TDadosPeriodicoCapa.fInsert(
  const AobjCapa: TPeriodicoCapa): String;
var
  LqryExec: TUniQuery ;
  LstrAutoInc: String ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' INSERT INTO PERGER ( ') ;
    LqryExec.SQL.Add(' AUTOINCREM, ') ;
    LqryExec.SQL.Add(' GER_DESCRI, ') ;
    LqryExec.SQL.Add(' GER_CODOPE, ') ;
    LqryExec.SQL.Add(' GER_DTAALT, ') ;
    LqryExec.SQL.Add(' GER_HRAALT ') ;
    LqryExec.SQL.Add(' ) ') ;
    LqryExec.SQL.Add(' VALUES ') ;
    LqryExec.SQL.Add(' ( ') ;
    LqryExec.SQL.Add(' :AUTOINCREM, ') ;
    LqryExec.SQL.Add(' :DESCRI, ') ;
    LqryExec.SQL.Add(' :CODOPE, ') ;
    LqryExec.SQL.Add(' :DTAALT, ') ;
    LqryExec.SQL.Add(' :HRAALT ') ;
    LqryExec.SQL.Add(' ) ; ') ;
    LstrAutoInc := fRetAutoIncrem('PERGER',Vs_strCodEmp) ;
    LqryExec.ParamByName('AUTOINCREM').AsString := LstrAutoInc ;
    LqryExec.ParamByName('DESCRI').AsString := AobjCapa.Descri ;
    LqryExec.ParamByName('CODOPE').AsString := AobjCapa.Codope ;
    LqryExec.ParamByName('DTAALT').AsDate := AobjCapa.Dtaalt ;
    LqryExec.ParamByName('HRAALT').AsString := AobjCapa.Hraalt ;
    LqryExec.ExecSQL ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := LstrAutoInc ;
end;

class function TDadosPeriodicoCapa.fSelecionaDados(
  const AstrAutoInc: string): TPeriodicosCapa;
begin
  result := fSelect(AstrAutoInc) ;
end;

class function TDadosPeriodicoCapa.fSelect(
  const AstrAutoInc: string): TPeriodicosCapa;
var
  LobjItem: TPeriodicoCapa ;
  LqryDados: TUniQuery ;
begin
  result := TPeriodicosCapa.Create();
  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT ') ;
    LqryDados.SQL.Add('   AUTOINCREM, ') ;
    LqryDados.SQL.Add('   GER_DESCRI, ') ;
    LqryDados.SQL.Add('   GER_CODOPE, ') ;
    LqryDados.SQL.Add('   GER_DTAALT, ') ;
    LqryDados.SQL.Add('   GER_HRAALT ') ;
    LqryDados.SQL.Add(' FROM PERGER ') ;
    if not fEmptyStr(AstrAutoInc) then
    begin
      LqryDados.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM ') ;
      LqryDados.ParamByName('AUTOINCREM').AsString := AstrAutoInc ;
    end ;
    LqryDados.SQL.Add(' ORDER BY AUTOINCREM ') ;
    LqryDados.Open ;
    LqryDados.First ;
    while not LqryDados.Eof do
    begin
      LobjItem := TPeriodicoCapa.Create ;
      LobjItem.Autoincrem := LqryDados.FieldByName('AUTOINCREM').AsString ;
      LobjItem.Descri := LqryDados.FieldByName('GER_DESCRI').AsString ;
      LobjItem.Codope := LqryDados.FieldByName('GER_CODOPE').AsString ;
      LobjItem.Dtaalt := LqryDados.FieldByName('GER_DTAALT').AsDateTime ;
      LobjItem.Hraalt := LqryDados.FieldByName('GER_HRAALT').AsString ;

      result.Add(LobjItem) ;

      LqryDados.Next ;
    end ;
  finally
    FreeAndNil(LqryDados) ;
  end ;
end;

class function TDadosPeriodicoCapa.fUpdate(const AstrAutoInc: string;
  const AobjCapa: TPeriodicoCapa): Boolean;
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' UPDATE PERGER SET ') ;
    LqryExec.SQL.Add('   GER_DESCRI = :DESCRI, ') ;
    LqryExec.SQL.Add('   GER_CODOPE = :CODOPE, ') ;
    LqryExec.SQL.Add('   GER_DTAALT = :DTAALT, ') ;
    LqryExec.SQL.Add('   GER_HRAALT = :HRAALT ') ;
    LqryExec.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM ; ') ;
    LqryExec.ParamByName('AUTOINCREM').AsString := AstrAutoInc ;
    LqryExec.ParamByName('DESCRI').AsString := AobjCapa.Descri ;
    LqryExec.ParamByName('CODOPE').AsString := AobjCapa.Codope ;
    LqryExec.ParamByName('DTAALT').AsDate := AobjCapa.Dtaalt ;
    LqryExec.ParamByName('HRAALT').AsString := AobjCapa.Hraalt ;
    LqryExec.ExecSQL ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

end.
