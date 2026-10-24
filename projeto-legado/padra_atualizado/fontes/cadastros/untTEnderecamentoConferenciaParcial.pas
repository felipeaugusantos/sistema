unit untTEnderecamentoConferenciaParcial;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
   untFuncoesSimples,
{$ENDIF}
  SysUtils, Classes, Uni, Data.DB;

 Type
  TItemDocumento = record
      CodigoItem: string;
      SeqFatDor: String;
      QuantidadeSolicitada: double;
      QuantidadeAtendida: double; // Inicialmente zero, será preenchido
  end;

  TItemConferido = record
    CodigoItem: string;
    Quantidade: Double;
  end;

  TArrayItensDocumento = TArray<TItemDocumento>;
  TArrayItensConferido = TArray<TItemConferido>;



   TEnderecamentoConferenciaParcial = class
   private
     ItensDocumento: TArrayItensDocumento;
     ItensDocumentoSintetizado: TArrayItensDocumento;
     ItensConferidos: TArrayItensConferido;
     procedure DistribuirQuantidadesConferidas;
   protected
     FSeqFgo: String;
     FIdeDig: String;
     procedure Processa(AAutIncFatGor, AIdeDig: string; AGeraDigEleAutomatica: Boolean);
     procedure pGeraDigEleAutomatica;
     procedure AdicionarItemDocumento(Codigo: string; Quantidade: Double; ASeqFatDor: string);
     procedure AdicionarItemDocumentoSintetizado(Codigo: string; Quantidade: Double);

     procedure AdicionarItemConferido(Codigo: string; Quantidade: Double);
     procedure pInsereDigCon;

   public
     class procedure pGeraDigConItensSemConferencia(AAutIncFatGor, AIdeDig: string; AGeraDigEleAutomatica: Boolean);
     class procedure pItemTemLiberacaoParaConferencia(AAutIncFatGor, ACodIte: String; var AQtdLiberada: Double);
     class function fTemLiberacaoParaEnderecamento(AAutIncFatGor: String): Boolean;
     class procedure pAjustaFatgor(AAutIncFatGor: String);
     class function JaTeveEnderecamento(AAutIncFatGor: String): Boolean;
     class function fTemPendenciaEnderecamento(AAutIncFatGor: String): Boolean;
     class function GerarCodigoUnico(const CodigoUsuario: string): string;
     class function ConferenciaSemDigConCorreta(AIncFatGor: string): Boolean;
     class function ConferenciaSemDigConCorretaPorDigEle(AIdeDig: string): Boolean;


 end;

implementation


procedure TEnderecamentoConferenciaParcial.DistribuirQuantidadesConferidas();
var
  i, j: integer;
   Disponivel, Falta, Aplicar: double;
begin
  for i := 0 to High(ItensConferidos) do
  begin
    Disponivel := ItensConferidos[i].Quantidade;
    for j := 0 to High(ItensDocumento) do
    begin
      if (ItensDocumento[j].CodigoItem = ItensConferidos[i].CodigoItem) and (Disponivel > 0) then
      begin
        Falta := ItensDocumento[j].QuantidadeSolicitada - ItensDocumento[j].QuantidadeAtendida;
        if Falta > 0 then
        begin
          Aplicar := Disponivel;
          if Falta < Aplicar then
            Aplicar := Falta;

          ItensDocumento[j].QuantidadeAtendida := ItensDocumento[j].QuantidadeAtendida + Aplicar;
          Disponivel := Disponivel - Aplicar;
        end;
      end;
    end;
  end;
end;

class function TEnderecamentoConferenciaParcial.fTemLiberacaoParaEnderecamento(
  AAutIncFatGor: String): Boolean;
var
  qryDigCon: TUniQuery;
begin
  qryDigCon := fCriaQuery;
  Try
    qryDigCon.SQL.Add('SELECT COUNT(1) AS DIC_QTDITE FROM DIGCON ');
    qryDigCon.SQL.Add(' WHERE DIC_SEQGER = "' + AAutIncFatGor + '"');
    qryDigCon.Open;
    Result := qryDigCon.FieldByName('DIC_QTDITE').AsInteger > 0;
  Finally
    FreeAndNil(qryDigCon);
  End;
end;

class function TEnderecamentoConferenciaParcial.fTemPendenciaEnderecamento(
  AAutIncFatGor: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT FATDOR.AUTOINCREM FROM FATGOR');
    qryConsulta.SQL.Add(' INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM');
    qryConsulta.SQL.Add(' WHERE FATGOR.AUTOINCREM = "'+AAutIncFatGor+'"');
    qryConsulta.SQL.Add('   AND (FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)) > 0');
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
  finally
    FreeAndNil(qryConsulta)
  End;
end;

class procedure TEnderecamentoConferenciaParcial.pAjustaFatgor(
  AAutIncFatGor: String);
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  try
    qryComand.SQL.Add('UPDATE FATGOR');
    qryComand.SQL.Add(' INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM');
    qryComand.SQL.Add(' SET FDO_QTDBAI = 0');
    qryComand.SQL.Add(' WHERE FATGOR.AUTOINCREM = "' + AAutIncFatGor + '"');
    qryComand.ExecSQL;
  finally
    FreeAndNil(qryComand);
  end;
end;

class function TEnderecamentoConferenciaParcial.JaTeveEnderecamento(AAutIncFatGor: String): Boolean;
var qryConsulta: TUniQuery;
begin
  Result := false;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM DIGCON');
    qryConsulta.SQL.Add('INNER JOIN FATGOR F ON F.AUTOINCREM = DIC_SEQGER');
    qryConsulta.SQL.Add('INNER JOIN FATDOR D ON D.FDO_SEQGER = F.AUTOINCREM');
    qryConsulta.SQL.Add(' WHERE DIC_SEQGER = "' + AAutIncFatGor + '"');
    qryConsulta.SQL.Add(' AND FDO_QTDBAI > 0');
    qryConsulta.Open;
    If qryConsulta.FieldByName('QTD').AsInteger > 0 then
      Exit(True);
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM DIGCON');
    qryConsulta.SQL.Add('INNER JOIN DEL_FATGOR F ON F.AUTOINCREM = DIC_SEQGER');
    qryConsulta.SQL.Add('INNER JOIN DEL_FATDOR D ON D.FDO_SEQGER = F.AUTOINCREM');
    qryConsulta.SQL.Add(' WHERE DIC_SEQGER = "' + AAutIncFatGor + '"');
    qryConsulta.Open;
    If qryConsulta.FieldByName('QTD').AsInteger > 0 then
      Exit(True);
  finally
    FreeAndNil(qryConsulta);
  End;
End;

class procedure TEnderecamentoConferenciaParcial.pGeraDigConItensSemConferencia(
  AAutIncFatGor, AIdeDig: string; AGeraDigEleAutomatica: Boolean);
var EnderecamentoConferenciaParcial: TEnderecamentoConferenciaParcial;
begin
  EnderecamentoConferenciaParcial := TEnderecamentoConferenciaParcial.Create;
  try
    EnderecamentoConferenciaParcial.Processa(AAutIncFatGor, AIdeDig, AGeraDigEleAutomatica);
  finally
    FreeAndNil(EnderecamentoConferenciaParcial);
  End;
  {}
end;

procedure TEnderecamentoConferenciaParcial.pGeraDigEleAutomatica;
var
  i : TItemDocumento;
  qryComand: TUniquery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQl.Add('INSERT INTO DIGELE(');
    qryComand.SQl.Add('  AUTOINCREM,');
    qryComand.SQl.Add('  DIG_CODITE,');
    qryComand.SQl.Add('  DIG_QTDITE,');
    qryComand.SQl.Add('  DIG_IDEDIG,');
    qryComand.SQl.Add('  DIG_CODEMP,');
    qryComand.SQl.Add('  DIG_CONFER) VALUES (');
    qryComand.SQl.Add('  :AUTOINCREM,');
    qryComand.SQl.Add('  :DIG_CODITE,');
    qryComand.SQl.Add('  :DIG_QTDITE,');
    qryComand.SQl.Add('  "'+FIdeDig+'",');
    qryComand.SQl.Add('  "'+VS_StrCodEmp+'",');
    qryComand.SQl.Add('  "N")');

    For i in ItensDocumentoSintetizado do
    Begin
      qryComand.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('DIGELE', VS_StrCodemp);
      qryComand.ParamByName('DIG_CODITE').AsString := i.CodigoItem;
      qryComand.ParamByName('DIG_QTDITE').ASFloat := i.QuantidadeSolicitada;
      qryComand.ExecSQL
    End;
  finally
    FreeAndNil(qryComand);
  End;
end;

procedure TEnderecamentoConferenciaParcial.pInsereDigCon;
var i : TItemDocumento;
    qryComand: TUniquery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('INSERT INTO DIGCON');
    qryComand.SQL.Add('(AUTOINCREM, DIC_SEQGER, DIC_CODITE, DIC_QTDITE, DIC_IDEDIG, DIC_SEQDOR)');
    qryComand.SQL.Add('VALUES (:AUTOINCREM, :DIC_SEQGER, :DIC_CODITE, :DIC_QTDITE, :DIC_IDEDIG, :DIC_SEQDOR)');
    For i in ItensDocumento do
    begin
//      If (i.QuantidadeSolicitada > 0) and (i.QuantidadeSolicitada > i.QuantidadeAtendida) then
      If (i.QuantidadeSolicitada > 0) and (i.QuantidadeAtendida = 0) then
      begin
        qryComand.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DIGCON', VS_strCodEmp);
        qryComand.ParamByName('DIC_SEQGER').AsString := FSeqFgo;
        qryComand.ParamByName('DIC_CODITE').AsString := i.CodigoItem;
        qryComand.ParamByName('DIC_QTDITE').AsCurrency :=  (i.QuantidadeSolicitada);
        qryComand.ParamByName('DIC_IDEDIG').AsString := FIdeDig;
        qryComand.ParamByName('DIC_SEQDOR').AsString := i.SeqFatDor;
        qryComand.ExecSQL;
      End;
    end;
  Finally
    FreeAndNil(qryComand);
  End;
end;

class procedure TEnderecamentoConferenciaParcial.pItemTemLiberacaoParaConferencia(
  AAutIncFatGor, ACodIte: String; var AQtdLiberada: Double);
var
  qryDigCon: TUniQuery;
begin
  AQtdLiberada := 0;
  qryDigCon := fCriaQuery;
  Try
    qryDigCon.SQL.Add('SELECT SUM(DIC_QTDITE) AS DIC_QTDITE FROM DIGCON ');
    qryDigCon.SQL.Add(' WHERE DIC_SEQGER = "' + AAutIncFatGor + '"');
    qryDigCon.SQL.Add('   AND DIC_CODITE = "' + ACodIte + '"');
    qryDigCon.Open;
    AQtdLiberada := qryDigCon.FieldByName('DIC_QTDITE').AsFloat;
  Finally
    FreeAndNil(qryDigCon);
  End;
end;

procedure TEnderecamentoConferenciaParcial.AdicionarItemDocumento(Codigo: string; Quantidade: Double; ASeqFatDor: string);
var
  Index: Integer;
begin
  Index := Length(ItensDocumento);
  SetLength(ItensDocumento, Index + 1);
  ItensDocumento[Index].CodigoItem := Codigo;
  ItensDocumento[Index].QuantidadeSolicitada := Quantidade;
  ItensDocumento[Index].QuantidadeAtendida := 0; // Inicializa como zero
  ItensDocumento[Index].SeqFatDor := ASeqFatDor;
end;

procedure TEnderecamentoConferenciaParcial.AdicionarItemDocumentoSintetizado(Codigo: string; Quantidade: Double);
var
  i : Integer;
begin
  for i := 0 to High(ItensDocumentoSintetizado) do
  begin
    if ItensDocumentoSintetizado[i].CodigoItem = Codigo then
    begin
      ItensDocumentoSintetizado[i].QuantidadeSolicitada := ItensDocumentoSintetizado[i].QuantidadeSolicitada + Quantidade;
      Exit; // Sai do procedimento após atualizar
    end;
  end;

  // Se chegou aqui, é porque não encontrou o item
  SetLength(ItensDocumentoSintetizado, Length(ItensDocumentoSintetizado) + 1);
  ItensDocumentoSintetizado[High(ItensDocumentoSintetizado)].CodigoItem := Codigo;
  ItensDocumentoSintetizado[High(ItensDocumentoSintetizado)].QuantidadeSolicitada := Quantidade;

End;

procedure TEnderecamentoConferenciaParcial.AdicionarItemConferido(Codigo: string; Quantidade: Double);
var
  i: Integer;
begin
  for i := 0 to High(ItensConferidos) do
  begin
    if ItensConferidos[i].CodigoItem = Codigo then
    begin
      ItensConferidos[i].Quantidade := ItensConferidos[i].Quantidade + Quantidade;
      Exit; // Sai do procedimento após atualizar
    end;
  end;

  // Se chegou aqui, é porque não encontrou o item
  SetLength(ItensConferidos, Length(ItensConferidos) + 1);
  ItensConferidos[High(ItensConferidos)].CodigoItem := Codigo;
  ItensConferidos[High(ItensConferidos)].Quantidade := Quantidade;
end;


procedure TEnderecamentoConferenciaParcial.Processa(AAutIncFatGor, AIdeDig: string; AGeraDigEleAutomatica: Boolean);
var qryDigCon: TUniQuery;
    qryFatGor: TUniQuery;
    blnTerminouDigCon: Boolean;
    blnTerminouDocumento: Boolean;
begin
  qryDigCon := fCriaQuery;
  qryFatGor := fCriaQuery;
  blnTerminouDigCon := False;
  blnTerminouDocumento := False;
  SetLength(ItensDocumento, 0);
  SetLength(ItensConferidos, 0);
  Try
    Try
      FSeqFgo := AAutIncFatGor;
      FIdeDig  := AIdeDig;
      qryDigCon.SQL.Add('SELECT * FROM DIGCON WHERE DIC_SEQGER = "'+AAutIncFatGor+'"');
      qryDigCon.Open;

      qryFatGor.SQL.Add('SELECT FDO_QTDITE, FDO_CODITE, AUTOINCREM FROM FATDOR WHERE FDO_SEQGER = "'+AAutIncFatGor+'"');
      qryFatGor.Open;
      TThread.CreateAnonymousThread(procedure
                                    begin
                                      blnTerminouDigCon := False;
                                      while not qryDigCon.Eof do
                                      begin
                                        AdicionarItemConferido(qryDigCon.FieldByName('DIC_CODITE').AsString,
                                                               qryDigCon.FieldByName('DIC_QTDITE').AsFloat);
                                        qryDigCon.Next;
                                      end;
                                      blnTerminouDigCon := True;

                                    end).Start;

      TThread.CreateAnonymousThread(procedure
                                    begin
                                      blnTerminouDocumento := False;
                                      while not qryFatGor.Eof do
                                      begin
                                        AdicionarItemDocumento(qryFatGor.FieldByName('FDO_CODITE').AsString,
                                                               qryFatGor.FieldByName('FDO_QTDITE').AsFloat,
                                                               qryFatGor.FieldByName('AUTOINCREM').AsString);
                                        AdicionarItemDocumentoSintetizado(qryFatGor.FieldByName('FDO_CODITE').AsString,
                                                                          qryFatGor.FieldByName('FDO_QTDITE').AsFloat);
                                        qryFatGor.Next;
                                      end;
                                      blnTerminouDocumento := True;
                                    end).Start;


      // Espera as thread terminarem
      while Not (blnTerminouDocumento)do;
      while Not (blnTerminouDigCon)do;
      DistribuirQuantidadesConferidas;
      pInsereDigCon;
      If AGeraDigEleAutomatica then
        pGeraDigEleAutomatica;
    Finally
      FreeAndNil(qryDigCon);
      FreeAndNil(qryFatGor);
    End;
  Except
    on e: Exception do
    begin
      raise Exception.Create('[TEnderecamentoConferenciaParcial.Processa]' + e.message);
    End;
  End;

end;

class function TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorreta(AIncFatGor: string): Boolean;
{Função serve para saber se a conferencia foi iniciada em versão anterior ao requisito que criou o campo DIC_SEQDOR }
var qryDigCon: TUniQuery;
begin
  Result := False;
  qryDigCon := fCriaQuery;
  Try
    If fEmptyStr(AIncFatGor) Then
      Exit;

    qryDigCon.SQL.Clear;
    qryDigCon.SQL.Add('SELECT * FROM DIGCON');
    qryDigCon.SQL.Add('WHERE DIC_SEQGER = "'+AIncFatGor+'"');
    qryDigCon.Open;

    If qryDigCon.IsEmpty Then
      Exit;
    If qryDigCon.FieldByName('DIC_SEQDOR').AsString = '' Then
      Exit(True)
  finally
    FreeAndNil(qryDigCon)
  End;
end;


class function TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorretaPorDigEle(AIdeDig: string): Boolean;
var qryDigCon: TUniQuery;
begin
  Result := False;
  qryDigCon := fCriaQuery;
  Try
    If fEmptyStr(AIdeDig) Then
      Exit;

    qryDigCon.SQL.Clear;
    qryDigCon.SQL.Add('SELECT * FROM DIGCON');
    qryDigCon.SQL.Add('WHERE DIC_IDEDIG = "'+AIdeDig+'"');
    qryDigCon.SQL.Add('  AND IFNULL(DIC_SEQDOR, "") = ""');
    qryDigCon.Open;

    Result := Not qryDigCon.IsEmpty;
  finally
    FreeAndNil(qryDigCon)
  End;
end;

class function TEnderecamentoConferenciaParcial.GerarCodigoUnico(const CodigoUsuario: string): string;
var
  Ano, Mes, Dia, Hora, Min, Seg, MSeg: Word;
  DataHoraAtual: TDateTime;
begin
  // Obtém a data e hora atual
  DataHoraAtual := fNow;
  DecodeDate(DataHoraAtual, Ano, Mes, Dia);
  DecodeTime(DataHoraAtual, Hora, Min, Seg, MSeg);

  // Formata a data/hora como AAAAMMDD-HHMMSS
  // e concatena com o código do usuário
  Result := Format('%.4d%.2d%.2d%.2d%.2d%.2d%.3d%s',
                  [Ano, Mes, Dia, Hora, Min, Seg, MSeg, CodigoUsuario]);
end;


end.

