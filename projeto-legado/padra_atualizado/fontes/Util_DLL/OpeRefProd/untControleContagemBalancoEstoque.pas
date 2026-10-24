unit untControleContagemBalancoEstoque;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, cxProgressBar, untFuncoesSimples, untGravando,
{$ENDIF}
  SysUtils, untConstantes, Uni, Data.DB, untTypesSistema, Classes;

  Type
    TContagens = Array of double;
    TControleContagemBalancoEstoque = class
    private
      FstrAutIncBalGer,
      FstrCodDig,
      FstrCodIte,
      FstrLocFis: string;
      FfltSalCon,
      FfltSalMl: Double;
      FConsulta: TUniQuery;
      FComandSQL: TUniQuery;
      FIntContagem: Integer;
    private
      function  fRetQtdContagem: integer;
      function  fRetAutoincremBalGerAtivo: String;
      function  fTemBalDet(strIncBalGer: string; var strIncBalDet: string): Boolean;
      procedure pGravaBalGer(var strIncBalGer: String);
      procedure pGravaBalDet(strIncBalGer: string);
      procedure pFinalizaBalDet;
      procedure pInsereItemContagensAnterior(strIncBalGer: String);
      function  fDefineDivergencias: Boolean;
      function fDefinindoDivergencia(pgbStatus: TcxProgressBar = Nil): Boolean;
      function fConfirmaContagem(var fltValCon: Double; Contagens: TContagens): Boolean;
      procedure pBaixaBalGer;
      function fContagemBate(Contagens: TContagens; var valCon: Double): Boolean;
      function fEfetudaNasDuasCotangens(AVal1, AVal2: Double): Boolean;
      procedure pRemoveDivergencia(AstrCodIte: string; fltSalCon: Double);
      procedure pAtualzaSalCon(AstrCodIte: string);

    public
      property IntContagem: Integer Read fRetQtdContagem;
      constructor Create;
      Destructor  Destroy; override;
      function fVerficaLocFis(AstrLocFis: String): Boolean;
      function fTemContagemEmAbertoParaOutroOperador(AstrLocFis: String; AstrCodOperador: String): Boolean;
      function fTemContagemFinalizadaParaOperador(AstrLocFis, AstrCodOperador: String): Boolean;
      function fContagemFinalizadaPara_o_Item(AstrLocFis, AStrCodIte: String): Boolean;

      function  fFinalizaContagem(AstrLocFis: String; AstrCodOperador: String): Boolean;
      procedure pGravaContagem; overload;
      function fRetQuantidadeContagemMaxima: Integer;
      function fAtingiuLimiteContagem: Boolean;
      class function fTemBalGerAberta: Boolean;

      class procedure pGravaContagem(AstrCodDig, AstrCodIte, AstrLocFis: string; AfltSalCon, AfltSalMl: Double); overload;
      class procedure pCancelaContagem(AstrCodDig, AstrCodIte, AstrLocFis: string);
      class function fUtilizaContagemControladaBalanco: Boolean;

      class procedure pIncluiBalgerZeraSaldoProduto(strSQLFiltros, strArmazens: String; pSetaParametros: TSetaParametros);
      Class Procedure pLimpaBalgerSaldoProduto(strSQLFiltros: string; pSetaParametros: TSetaParametros);
      class procedure pConcluiBalgerFinalizadas;
      class procedure pRecalculaSalcon(strCodite: String);

      Class Procedure pIniciaAutInc;
      Class Procedure pFinalizaAutInc;
      Class function fVerficaTemBalGerAbertaSemContagem: Boolean;
      Class Procedure pRemoveBalGerSemContagem;




  end;

implementation

{ TControleContagemBalancoEstoque }

constructor TControleContagemBalancoEstoque.Create;
begin
  FConsulta := fCriaQuery;
  FComandSQL:= fCriaQuery;
end;

destructor TControleContagemBalancoEstoque.Destroy;
begin
  FreeAndNil(FConsulta);
  FreeAndNil(FComandSQL);
end;

function TControleContagemBalancoEstoque.fVerficaLocFis(AstrLocFis: String): Boolean;
begin
  FstrLocFis :=  AstrLocFis;
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CADLOC');
  FConsulta.SQL.Add(' WHERE LOC_CODLOC = :LOCFIS');
  FConsulta.SQL.Add('   AND LOC_CODEMP = :CODEMP');
  FConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  FConsulta.ParamByName('LOCFIS').AsString := FstrLocFis;

  FConsulta.Open;

  Result := FConsulta.FieldByName('QTD').AsInteger > 0
end;

class function TControleContagemBalancoEstoque.fVerficaTemBalGerAbertaSemContagem: Boolean;
var
  qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM BALGER');
    qryConsulta.SQL.Add(' WHERE BALGER.BLG_STATUS <> "C"');
    qryConsulta.SQL.Add('   AND (SELECT COUNT(1) FROM BALDET');
    qryConsulta.SQL.Add('         WHERE BALDET.BLD_SEQGER = BALGER.AUTOINCREM) = 0');
    qryConsulta.SQL.Add('   AND BALGER.BLG_CODEMP = "' + VS_StrCodEmp + '"');


    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

class procedure TControleContagemBalancoEstoque.pRemoveBalGerSemContagem;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('DELETE FROM BALGER');
    qryConsulta.SQL.Add('WHERE (SELECT COUNT(1) FROM BALDET');
    qryConsulta.SQL.Add('            WHERE BALDET.BLD_SEQGER = BALGER.AUTOINCREM) = 0');
    qryConsulta.SQL.Add(' AND BALGER.BLG_STATUS <> "C"');
    qryConsulta.SQL.Add(' AND BALGER.BLG_CODEMP = "' + VS_StrCodEmp + '"');

    qryConsulta.ExecSQL;

  Finally
    FreeAndNil(qryConsulta);
  End;
end;


procedure TControleContagemBalancoEstoque.pGravaContagem;
begin
  fRetQtdContagem;
  If fEmptyStr(FstrAutIncBalGer) Then
    pGravaBalGer(FstrAutIncBalGer);
  pGravaBalDet(FstrAutIncBalGer);
end;

procedure TControleContagemBalancoEstoque.pGravaBalGer(var strIncBalGer: String);
begin
  strIncBalGer := '';
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('INSERT INTO BALGER(');
  FConsulta.SQL.Add('        AUTOINCREM,');
  FConsulta.SQL.Add('        BLG_LOCFIS,');
  FConsulta.SQL.Add('        BLG_CODEMP,');
  FConsulta.SQL.Add('        BLG_STATUS');
  FConsulta.SQL.Add(') VALUES (');
  FConsulta.SQL.Add('        :AUTINC,');
  FConsulta.SQL.Add('        :LOCFIS,');
  FConsulta.SQL.Add('        :CODEMP,');
  FConsulta.SQL.Add('        "A")');
  strIncBalGer := fRetAutoIncrem('BALGER', VS_StrCodEmp);
  FConsulta.ParamByName('AUTINC').AsString  := strIncBalGer;
  FConsulta.ParamByName('LOCFIS').AsString  := FstrLocFis;
  FConsulta.ParamByName('CODEMP').AsString  := VS_StrCodEmp;

  FConsulta.ExecSQL;
end;

function TControleContagemBalancoEstoque.fDefineDivergencias: Boolean;
{$IFNDEF LINUX}
var frmGravando: TFrmGravando;
{$ENDIF}
begin
  FstrAutIncBalGer := fRetAutoincremBalGerAtivo;
  {$IFDEF LINUX}
  Result := fDefinindoDivergencia;
  {$ELSE}
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Verificando Divergencia de Contagens...';
  frmGravando.pgbStatus.Visible := False;
  frmGravando.fExecutarAcao := fDefinindoDivergencia;
  frmGravando.ShowModal;
  Result := frmGravando.blnConfirma;
  {$ENDIF}
end;

procedure TControleContagemBalancoEstoque.pFinalizaBalDet;
begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('UPDATE BALDET');
  FConsulta.SQL.Add(' INNER JOIN BALGER ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER');
  FConsulta.SQL.Add('   SET BLD_STATUS = "F"');
  FConsulta.SQL.Add(' WHERE BLD_SEQGER = :SEQGER');
  FConsulta.SQL.Add('   AND BLG_STATUS = "A"');
  FConsulta.SQL.Add('   AND BLG_LOCFIS = :LOCFIS');
  FConsulta.SQL.Add('   AND BLD_CODOPE = :CODOPE');
  FConsulta.SQL.Add('   AND BLD_NUMCON = :NUMCOM');


  FConsulta.ParamByName('SEQGER').AsString  := FstrAutIncBalGer;
  FConsulta.ParamByName('LOCFIS').AsString  := FstrLocFis;
  FConsulta.ParamByName('CODOPE').AsString  := FstrCodDig;
  FConsulta.ParamByName('NUMCOM').AsInteger := FIntContagem;

  FConsulta.ExecSQL;
end;

function TControleContagemBalancoEstoque.fFinalizaContagem(AstrLocFis,
  AstrCodOperador: String): Boolean;
begin
  Result := True;
  FIntContagem := fRetQtdContagem;
  FstrCodDig := AstrCodOperador;
  FstrLocFis := AstrLocFis;
  FstrAutIncBalGer := fRetAutoincremBalGerAtivo;
  fStartTransaction;
  Try
    pFinalizaBalDet;

    If FIntContagem > 1 Then
    Begin
      If fDefineDivergencias Then
      Begin
        fCommit;
        pMensagemOk('Contagem Finalizada com Sucesso!');
      End
      Else
        fRollback;
    End
    Else
    begin
      fCommit;
      pMensagemOk('Contagem Finalizada com Sucesso!');
    End;
  Except
    on e:Exception do
    Begin
      fRollback;
      Result := false;
      pMensagensErro(E.Message, '[TControleContagemBalancoEstoque.fFinalizaContagem]');
    End;
  End;
end;

procedure TControleContagemBalancoEstoque.pGravaBalDet(strIncBalGer: string);
  var
    strIncBalDet: String;
    blnInsereItemContagemAnterior: Boolean;
begin
  blnInsereItemContagemAnterior := False;
  If fTemBalDet(strIncBalGer, strIncBalDet) Then
  Begin
    FConsulta.SQL.Clear;

    FConsulta.SQL.Add('UPDATE BALDET');
    FConsulta.SQL.Add('   SET BLD_QTDITE = BLD_QTDITE + :QTDITE,');
    FConsulta.SQL.Add('       BLD_QTDGML = BLD_QTDGML + :QTDGML');
    FConsulta.SQL.Add(' WHERE AUTOINCREM = :AUTINC');
    FConsulta.ParamByName('AUTINC').AsString := strIncBalDet;
  End
  Else
  Begin
    FConsulta.SQL.Clear;

    FConsulta.SQL.Add('INSERT INTO BALDET(');
    FConsulta.SQL.Add('        AUTOINCREM,');
    FConsulta.SQL.Add('        BLD_SEQGER,');
    FConsulta.SQL.Add('        BLD_CODITE,');
    FConsulta.SQL.Add('        BLD_NUMCON,');
    FConsulta.SQL.Add('        BLD_QTDITE,');
    FConsulta.SQL.Add('        BLD_CODOPE,');
    FConsulta.SQL.Add('        BLD_DTACON,');
    FConsulta.SQL.Add('        BLD_STATUS,');
    FConsulta.SQL.Add('        BLD_QTDGML,');
    FConsulta.SQL.Add('        BLD_DIVERG');
    FConsulta.SQL.Add(') VALUES (');
    FConsulta.SQL.Add('        :AUTINC,');
    FConsulta.SQL.Add('        :SEQGER,');
    FConsulta.SQL.Add('        :CODITE,');
    FConsulta.SQL.Add('        :NUMCON,');
    FConsulta.SQL.Add('        :QTDITE,');
    FConsulta.SQL.Add('        :CODOPE,');
    FConsulta.SQL.Add('        :DTACON,');
    FConsulta.SQL.Add('        "A",');
    FConsulta.SQL.Add('        :QTDGML,');
    FConsulta.SQL.Add('        :DIVERG)');
    strIncBalDet := fRetAutoIncrem('BALDET', VS_StrCodEmp);
    FConsulta.ParamByName('AUTINC').AsString   := fRetAutoIncrem('BALDET', VS_StrCodEmp);
    FConsulta.ParamByName('SEQGER').AsString   := strIncBalGer;
    FConsulta.ParamByName('CODITE').AsString   := FstrCodIte;
    FConsulta.ParamByName('NUMCON').AsInteger  := FIntContagem;
    FConsulta.ParamByName('CODOPE').AsString   := FstrCodDig;
    FConsulta.ParamByName('DTACON').AsDateTime := fNow;
    FConsulta.ParamByName('DIVERG').AsString   := 'S';
    blnInsereItemContagemAnterior := FIntContagem > 1;
  End;
  FConsulta.ParamByName('QTDITE').AsFloat := FfltSalCon;
  FConsulta.ParamByName('QTDGML').AsFloat := FfltSalMl;

  FConsulta.ExecSQL;

  If blnInsereItemContagemAnterior Then
    pInsereItemContagensAnterior(strIncBalGer);
End;

class procedure TControleContagemBalancoEstoque.pGravaContagem(AstrCodDig,
  AstrCodIte, AstrLocFis: string; AfltSalCon, AfltSalMl: Double);
  var ControleContagemBalancoEstoque: TControleContagemBalancoEstoque;
begin
  ControleContagemBalancoEstoque := TControleContagemBalancoEstoque.Create;
  Try
    ControleContagemBalancoEstoque.FstrCodDig := AstrCodDig;
    ControleContagemBalancoEstoque.FstrCodIte := AstrCodIte;
    ControleContagemBalancoEstoque.FstrLocFis := AstrLocFis;
    ControleContagemBalancoEstoque.FfltSalCon := AfltSalCon;
    ControleContagemBalancoEstoque.FfltSalMl  := AfltSalMl;

    ControleContagemBalancoEstoque.pGravaContagem;

  Finally
    FreeAndNil(ControleContagemBalancoEstoque);
  End;
end;

Class Procedure TControleContagemBalancoEstoque.pIniciaAutInc;
  Var
    strAutInc: String;
    qryInsert: TUniQuery;
Begin
  qryInsert := fCriaQuery;
  qryInsert.SQL.Text := 'SELECT IFNULL(PRO_AUTINC, 1) AS AUTINC FROM PROINC WHERE PRO_NOMARQ = "BALGER"';
  qryInsert.Open;

  strAutInc := qryInsert.FieldByName('AUTINC').AsString;

  qryInsert.Close;
  qryInsert.SQL.Text := 'SET @AUTINC = ' + strAutInc;
  qryInsert.ExecSQL;

  FreeAndNil(qryInsert);
End;

Class Procedure TControleContagemBalancoEstoque.pFinalizaAutInc;
  Var
    qryInsert: TUniQuery;
Begin
  qryInsert := fCriaQuery;

  qryInsert.Close;
  qryInsert.SQL.Clear;
  qryInsert.SQL.Add('UPDATE PROINC SET');
  qryInsert.SQL.Add('  PRO_AUTINC = @AUTINC+1 WHERE PRO_NOMARQ = "BALGER"');
  qryInsert.ExecSQL;

  FreeAndNil(qryInsert);
End;

class procedure TControleContagemBalancoEstoque.pIncluiBalgerZeraSaldoProduto(
  strSQLFiltros, strArmazens: String; pSetaParametros: TSetaParametros);
  Var
    qryInsert: TUniQuery;
Begin
  If Not TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
    Exit;

  pIniciaAutInc;

  qryInsert := fCriaQuery;
  Try
    qryInsert.SQL.Add('INSERT INTO BALGER (AUTOINCREM, BLG_LOCFIS, BLG_CODEMP, BLG_STATUS)');
    qryInsert.SQL.Add('SELECT CONCAT(:CODEMP, RIGHT(CONCAT("00000000000000", @AUTINC:=(@AUTINC+1)), 14), :CODEMP), ');
    qryInsert.SQL.Add('       G.ITE_LOCFIS,');
    qryInsert.SQL.Add('       G.ITE_CODEMP,');
    qryInsert.SQL.Add('       "A"');
    qryInsert.SQL.Add(' FROM ITEGER G  ');
    qryInsert.SQL.Add('INNER JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ');
    qryInsert.SQL.Add(' LEFT JOIN CADLOT ON G.ITE_CODITE = LOT_CODITE ');
    qryInsert.SQL.Add('                 AND G.ITE_CODEMP = LOT_CODEMP');
    qryInsert.SQL.Add('WHERE G.ITE_DIGCON = "N"');
    qryInsert.SQL.Add('  AND G.ITE_CODEMP = :CODEMP');
    qryInsert.SQL.Add('  AND LOT_NUMLOT IS NULL');
    qryInsert.SQL.Add('  AND IFNULL(G.ITE_LOCFIS, "") <> ""');
    qryInsert.SQL.Add('  AND (SELECT COUNT(1) FROM BALGER WHERE BLG_CODEMP = G.ITE_CODEMP AND BLG_LOCFIS = G.ITE_LOCFIS AND BLG_STATUS <> "C")  = 0');
    qryInsert.SQL.Add('  ' + strSQLFiltros);

    If Not fEmptyStr(strArmazens) Then
      qryInsert.SQL.Add(' AND ((LOT_CODITE IS NULL) OR (LOT_NUMLOT IN (' + strArmazens + '))) ');
   qryInsert.SQL.Add('  GROUP BY ITE_LOCFIS');

   If Assigned(pSetaParametros) Then
     pSetaParametros(qryInsert);

   qryInsert.ExecSQL;

  Finally
    FreeAndNil(qryInsert);
  End;

  pFinalizaAutInc;
end;

class procedure TControleContagemBalancoEstoque.pLimpaBalgerSaldoProduto(
  strSQLFiltros: string; pSetaParametros: TSetaParametros);
  Var
    qryInsert: TUniQuery;
    stlItens: TStringList;
begin

  If Not TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
    Exit;

  qryInsert := fCriaQuery;
  stlItens := TStringList.Create;
  Try
    qryInsert.SQL.Clear;


    qryInsert.SQL.Add('SELECT BLD_CODITE');
    qryInsert.SQL.Add('  FROM BALGER');
    qryInsert.SQL.Add(' INNER JOIN BALDET ON BALGER.AUTOINCREM = BLD_SEQGER AND BLD_NUMCON = 1');
    qryInsert.SQL.Add(' WHERE  BALGER.BLG_STATUS = "F" AND BLG_CODEMP = :CODEMP');
    qryInsert.SQL.Add('  ' + strSQLFiltros);
    qryInsert.SQL.Add(' GROUP BY BLD_CODITE');
    If Assigned(pSetaParametros) Then
       pSetaParametros(qryInsert);

    qryInsert.Open;

    While not qryInsert.Eof Do
    Begin
      stlItens.Add(''''+qryInsert.FieldByName('BLD_CODITE').AsString+'''');
      qryInsert.Next;
    End;

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('DELETE BALGER.* FROM BALGER ');
    qryInsert.SQL.Add(' WHERE BLG_CODEMP = :CODEMP');
    qryInsert.SQL.Add('   AND BLG_STATUS <> "C"');
    qryInsert.SQL.Add('  ' + strSQLFiltros);

    If Assigned(pSetaParametros) Then
       pSetaParametros(qryInsert);

    qryInsert.ExecSQL;

    If stlItens.Count > 0 Then
    begin
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('UPDATE ITEGER ');
      qryInsert.SQL.Add('  SET ITE_SALCON  = IFNULL((SELECT SUM(BLD_EFECON)');
      qryInsert.SQL.Add('                              FROM BALDET BL2');
      qryInsert.SQL.Add('                             INNER JOIN BALGER ON BALGER.AUTOINCREM = BL2.BLD_SEQGER');
      qryInsert.SQL.Add('                             WHERE BL2.BLD_NUMCON = 1');
      qryInsert.SQL.Add('                               AND BLG_STATUS = "F"');
      qryInsert.SQL.Add('                               AND BLG_CODEMP = ITE_CODEMP          ');
      qryInsert.SQL.Add('                               AND BL2.BLD_CODITE = ITE_CODITE');
      qryInsert.SQL.Add('                                ), 0),');
      qryInsert.SQL.Add('      ITE_DIGCON = IF(IFNULL((SELECT SUM(BLD_EFECON)');
      qryInsert.SQL.Add('                              FROM BALDET BL2');
      qryInsert.SQL.Add('                             INNER JOIN BALGER ON BALGER.AUTOINCREM = BL2.BLD_SEQGER ');
      qryInsert.SQL.Add('                             WHERE BL2.BLD_NUMCON = 1                 ');
      qryInsert.SQL.Add('                               AND BLG_STATUS = "F"');
      qryInsert.SQL.Add('                               AND BLG_CODEMP = ITE_CODEMP');
      qryInsert.SQL.Add('                               AND BL2.BLD_CODITE = ITE_CODITE), 0) = 0, "N", "S")');
      qryInsert.SQL.Add('WHERE ITE_CODITE IN (' + stlItens.CommaText + ')');
      qryInsert.SQL.Add('AND ITE_CODEMP = "' + VS_StrCodEmp + '"');
      qryInsert.ExecSQL;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TControleContagemBalancoEstoque.pInsereItemContagensAnterior(strIncBalGer: String);
  var
    i: integer;
begin

  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT BALDET.*, (SELECT COUNT(1)');
  FConsulta.SQL.Add('                    FROM BALDET');
  FConsulta.SQL.Add('                   WHERE BLD_SEQGER = :SEQGER');
  FConsulta.SQL.Add('                     AND BLD_CODITE = :CODITE');
  FConsulta.SQL.Add('                     AND BLD_NUMCON = :CONTAG');
  FConsulta.SQL.Add('                   ) AS QTD');
  FConsulta.SQL.Add('  FROM BALDET  ');
  FConsulta.SQL.Add(' WHERE BLD_SEQGER = :SEQGER');
  FConsulta.SQL.Add('   AND BLD_NUMCON = :CONTAG');
  FConsulta.SQL.Add('   LIMIT 1');


  FComandSQL.SQL.Clear;
  FComandSQL.SQL.Add('INSERT INTO BALDET(');
  FComandSQL.SQL.Add('        AUTOINCREM,');
  FComandSQL.SQL.Add('        BLD_SEQGER,');
  FComandSQL.SQL.Add('        BLD_CODITE,');
  FComandSQL.SQL.Add('        BLD_NUMCON,');
  FComandSQL.SQL.Add('        BLD_QTDITE,');
  FComandSQL.SQL.Add('        BLD_CODOPE,');
  FComandSQL.SQL.Add('        BLD_DTACON,');
  FComandSQL.SQL.Add('        BLD_STATUS,');
  FComandSQL.SQL.Add('        BLD_QTDGML,');
  FComandSQL.SQL.Add('        BLD_DIVERG');
  FComandSQL.SQL.Add(') VALUES (');
  FComandSQL.SQL.Add('        :AUTINC,');
  FComandSQL.SQL.Add('        :SEQGER,');
  FComandSQL.SQL.Add('        :CODITE,');
  FComandSQL.SQL.Add('        :NUMCON,');
  FComandSQL.SQL.Add('        :QTDITE,');
  FComandSQL.SQL.Add('        :CODOPE,');
  FComandSQL.SQL.Add('        :DTACON,');
  FComandSQL.SQL.Add('        "F",');
  FComandSQL.SQL.Add('        :QTDGML,');
  FComandSQL.SQL.Add('        :DIVERG)');

  For i := (FIntContagem -1) downto 1 do
  Begin
    FConsulta.Close;
    FConsulta.ParamByName('SEQGER').AsString := strIncBalGer;
    FConsulta.ParamByName('CODITE').AsString := FstrCodIte;
    FConsulta.ParamByName('CONTAG').AsInteger:= i;

    FConsulta.Open;

    If FConsulta.FieldByName('QTD').AsInteger = 0 Then
    Begin
      FComandSQL.ParamByName('AUTINC').AsString   := fRetAutoIncrem('BALDET', VS_StrCodEmp);
      FComandSQL.ParamByName('SEQGER').AsString   := strIncBalGer;
      FComandSQL.ParamByName('CODITE').AsString   := FstrCodIte;
      FComandSQL.ParamByName('NUMCON').AsInteger  := i;
      FComandSQL.ParamByName('QTDITE').AsFloat    := -1;
      FComandSQL.ParamByName('CODOPE').AsString   := FConsulta.FieldByName('BLD_CODOPE').AsString;
      FComandSQL.ParamByName('DTACON').AsDateTime := fNow;
      FComandSQL.ParamByName('QTDGML').AsFloat    := -1;
      FComandSQL.ParamByName('DIVERG').AsString   := 'S';

      FComandSQL.ExecSQL;
    End;
  End;
end;


function TControleContagemBalancoEstoque.fRetAutoincremBalGerAtivo: String;
begin
  Result := '';
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT AUTOINCREM');
  FConsulta.SQL.Add('  FROM BALGER');
  FConsulta.SQL.Add(' WHERE BLG_LOCFIS = :LOCFIS');
  FConsulta.SQL.Add('   AND BLG_CODEMP = :CODEMP');
  FConsulta.SQL.Add('   AND BLG_STATUS <> "C"');

  FConsulta.ParamByName('LOCFIS').AsString := FstrLocFis;
  FConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;

  FConsulta.Open;

  If Not FConsulta.IsEmpty Then
    Result := FConsulta.FieldByName('AUTOINCREM').AsString;
end;

function TControleContagemBalancoEstoque.fRetQtdContagem: integer;
begin
  FConsulta.SQL.Clear;

  If FstrCodDig = '' Then
    Raise Exception.Create('Digitador não definido!');

  If FstrLocFis = '' Then
    Raise Exception.Create('Localização Fisica não definida!');


  FstrAutIncBalGer := fRetAutoincremBalGerAtivo;
  If FstrAutIncBalGer = '' Then
    FIntContagem := 1
  Else
  Begin
    FConsulta.SQL.Clear;
    FConsulta.SQL.Add('SELECT MAX(BLD_NUMCON) AS QTD FROM BALDET');
    FConsulta.SQL.Add(' WHERE BLD_SEQGER = :SEQGER');
    FConsulta.SQL.Add('   AND BLD_CODOPE <> :CODOPE');

    FConsulta.ParamByName('SEQGER').AsString := FstrAutIncBalGer;
    FConsulta.ParamByName('CODOPE').AsString := FstrCodDig;

    FConsulta.Open;

    FIntContagem:= FConsulta.FieldByName('QTD').AsInteger + 1;
  End;

  Result := FIntContagem;

end;

function TControleContagemBalancoEstoque.fTemBalDet(strIncBalGer: string; var strIncBalDet: string): Boolean;
begin
  strIncBalDet := '';
  Result := True;

  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT AUTOINCREM');
  FConsulta.SQL.Add('  FROM BALDET');
  FConsulta.SQL.Add(' WHERE BLD_SEQGER = :SEQGER');
  FConsulta.SQL.Add('   AND BLD_CODITE = :CODITE');
  FConsulta.SQL.Add('   AND BLD_CODOPE = :CODOPE');
  FConsulta.SQL.Add('   AND BLD_STATUS = "A"');

  FConsulta.ParamByName('SEQGER').AsString := strIncBalGer;
  FConsulta.ParamByName('CODITE').AsString := FstrCodIte;
  FConsulta.ParamByName('CODOPE').AsString := FstrCodDig;

  FConsulta.Open;


  If FConsulta.IsEmpty Then
    Exit(False);

  strIncBalDet := FConsulta.FieldByName('AUTOINCREM').AsString;
end;

class function TControleContagemBalancoEstoque.fTemBalGerAberta: Boolean;
  var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM BALGER');
    qryConsulta.SQL.Add(' WHERE BLG_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('   AND BLG_STATUS = "A"');

    qryConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TControleContagemBalancoEstoque.fTemContagemEmAbertoParaOutroOperador(AstrLocFis, AstrCodOperador: String): Boolean;
begin
  FstrLocFis := AstrLocFis;
  FstrCodDig := AstrCodOperador;
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM BALGER');
  FConsulta.SQL.Add(' INNER JOIN BALDET ON BLD_SEQGER = BALGER.AUTOINCREM');
  FConsulta.SQL.Add(' WHERE BLG_LOCFIS = :LOCFIS');
  FConsulta.SQL.Add('   AND BLG_CODEMP = :CODEMP');
  FConsulta.SQL.Add('   AND BLD_CODOPE <> :CODOPE');
  FConsulta.SQL.Add('   AND BLD_STATUS = "A"');

  FConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  FConsulta.ParamByName('LOCFIS').AsString := FstrLocFis;
  FConsulta.ParamByName('CODOPE').AsString := FstrCodDig;

  FConsulta.Open;

  Result := FConsulta.FieldByName('QTD').AsInteger > 0;
end;

function TControleContagemBalancoEstoque.fTemContagemFinalizadaParaOperador(AstrLocFis, AstrCodOperador: String): Boolean;
begin
  FstrLocFis := AstrLocFis;
  FstrCodDig := AstrCodOperador;
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM BALGER');
  FConsulta.SQL.Add(' INNER JOIN BALDET ON BLD_SEQGER = BALGER.AUTOINCREM');
  FConsulta.SQL.Add(' WHERE BLG_LOCFIS = :LOCFIS');
  FConsulta.SQL.Add('   AND BLG_CODEMP = :CODEMP');
  FConsulta.SQL.Add('   AND BLD_CODOPE = :CODOPE');
  FConsulta.SQL.Add('   AND BLD_STATUS = "F"');
  FConsulta.SQL.Add('   AND BLG_STATUS <> "C"');

  FConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  FConsulta.ParamByName('LOCFIS').AsString := FstrLocFis;
  FConsulta.ParamByName('CODOPE').AsString := FstrCodDig;

  FConsulta.Open;

  Result := FConsulta.FieldByName('QTD').AsInteger > 0;
end;

class function TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco: Boolean;
begin
  Result := fCfgSis('UCCBEA', varBoolean) And
            fCfgSis('SLFBEA', varBoolean) And
            fCfgSis('CONACU', varBoolean) And
            (fCfgSis('CONEST') = '1') And
            (fCfgSis('QCRBEA', varInteger) > 1);
End;

function TControleContagemBalancoEstoque.fRetQuantidadeContagemMaxima: Integer;
Begin
  Result := fCfgSis('QCRBEA', varInteger);
End;

function TControleContagemBalancoEstoque.fAtingiuLimiteContagem: Boolean;
Begin
  Result := fRetQtdContagem > fRetQuantidadeContagemMaxima;
End;

function TControleContagemBalancoEstoque.fDefinindoDivergencia(
  pgbStatus: TcxProgressBar): Boolean;
  var i: Integer;
      Contagens: TContagens;
      fltValCon: Double;
begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT BALGER.AUTOINCREM,');
  For i := 1 to FIntContagem  do
    FConsulta.SQL.Add('       IFNULL(CON' + IntToStr(i) + '.BLD_QTDITE, -1) AS CONTAGE_' + IntToStr(i) + ',' );

  FConsulta.SQL.Add('       CON1.BLD_CODITE ');


  FConsulta.SQL.Add('  FROM BALGER');
  FConsulta.SQL.Add(' INNER JOIN BALDET CON1 ON CON1.BLD_SEQGER = BALGER.AUTOINCREM AND CON1.BLD_NUMCON = 1');
  For i := 2 to FIntContagem  do
  Begin
    FConsulta.SQL.Add('  LEFT JOIN BALDET CON' + IntToStr(i) + ' ON CON' + IntToStr(i) + '.BLD_SEQGER = BALGER.AUTOINCREM ');
    FConsulta.SQL.Add('                                         AND CON' + IntToStr(i) + '.BLD_NUMCON = ' + IntToStr(i));
    FConsulta.SQL.Add('                                         AND CON' + IntToStr(i) + '.BLD_CODITE = CON1.BLD_CODITE');
  End;
  FConsulta.SQL.Add(' WHERE BALGER.AUTOINCREM = :SEQGER');
  FConsulta.SQL.Add('   AND CON1.BLD_DIVERG = "S"');
  FConsulta.SQL.Add(' GROUP BY CON1.BLD_SEQGER, CON1.BLD_NUMCON, CON1.BLD_CODITE');

  FConsulta.ParamByName('SEQGER').AsString := FstrAutIncBalGer;

  FConsulta.Open;
  FConsulta.First;
  pgbStatus.Properties.Max := FConsulta.RecordCount -1;

  SetLength(Contagens, FIntContagem);
  While not FConsulta.Eof Do
  Begin
    For i := 1 To FIntContagem do
    begin
      Contagens[i-1] := FConsulta.FieldByName('CONTAGE_' + IntToStr(i)).AsFloat;
    End;
    If fConfirmaContagem(fltValCon, Contagens) Then
    Begin
      pRemoveDivergencia(FConsulta.FieldByName('BLD_CODITE').AsString, fltValCon);
      pAtualzaSalCon(FConsulta.FieldByName('BLD_CODITE').AsString);
    End;
    FConsulta.Next;
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  pBaixaBalGer;
  Result := True;
end;

function TControleContagemBalancoEstoque.fEfetudaNasDuasCotangens(AVal1,
  AVal2: Double): Boolean;
begin
  Result := (AVal1 > -1) And (AVal2 > -1)
end;

function TControleContagemBalancoEstoque.fConfirmaContagem(var fltValCon: Double; Contagens: TContagens): Boolean;
begin
  If FIntContagem = fRetQuantidadeContagemMaxima Then
  begin
    fltValCon := Contagens[FIntContagem -1];
    Result := True;
  End
  Else
    Result := fContagemBate(Contagens, fltValCon);
end;

function TControleContagemBalancoEstoque.fContagemBate(Contagens: TContagens; var valCon: Double): Boolean;
var inicio: Integer;
    proximos: Integer;
    blnBateu: Boolean;
begin
  blnBateu := False;
  valCon := 0;
  For inicio := 0 To  FIntContagem -1 do
  Begin
    For proximos := inicio + 1 To  FIntContagem -1 do
    Begin
      If fEfetudaNasDuasCotangens(Contagens[inicio], Contagens[proximos]) Then
      Begin
        blnBateu := Contagens[inicio] = Contagens[proximos];
        If blnBateu Then
        Begin
          valCon := Contagens[inicio];
          Break;
        End;
      End;
    End;
    If blnBateu Then
      Break;
  End;

  Result := blnBateu;
end;

function TControleContagemBalancoEstoque.fContagemFinalizadaPara_o_Item(
  AstrLocFis, AStrCodIte: String): Boolean;
begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM BALGER');
  FConsulta.SQL.Add(' INNER JOIN BALDET ON BLD_SEQGER = BALGER.AUTOINCREM');
  FConsulta.SQL.Add(' WHERE BLG_LOCFIS = :LOCFIS');
  FConsulta.SQL.Add('   AND BLG_CODEMP = :CODEMP');
  FConsulta.SQL.Add('   AND BLD_CODITE = :CODITE');
  FConsulta.SQL.Add('   AND BLD_DIVERG = "N"');
  FConsulta.SQL.Add('   and BLG_STATUS <> "C"');

  FConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  FConsulta.ParamByName('LOCFIS').AsString := AstrLocFis;
  FConsulta.ParamByName('CODITE').AsString := AStrCodIte;

  FConsulta.Open;
  Result := FConsulta.FieldByName('QTD').AsInteger > 0;

end;

class procedure TControleContagemBalancoEstoque.pRecalculaSalcon(
  strCodite: String);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQl.Clear;
    qryUpdate.SQL.Add('UPDATE ITEGER');
    qryUpdate.SQL.Add('   SET ITE_SALCON = (SELECT SUM(BLD_EFECON) FROM BALDET');
    qryUpdate.SQL.Add('                      INNER JOIN BALGER ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER');
    qryUpdate.SQL.Add('                      WHERE BALGER.BLG_STATUS = "F"');
    qryUpdate.SQL.Add('                       AND BLD_CODITE = "' + strCodite + '"');
    qryUpdate.SQL.Add('                       AND BLG_CODEMP = "' + VS_StrCodEmp + '")');
    qryUpdate.SQL.Add('WHERE ITE_CODITE = "' + strCodite + '"');
    qryUpdate.SQL.Add('  AND ITE_CODEMP = "' + VS_StrCodEmp + '"');

    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TControleContagemBalancoEstoque.pRemoveDivergencia(AstrCodIte: string; fltSalCon: Double);
begin
  FComandSQL.SQL.Clear;
  FComandSQL.SQL.Add('UPDATE BALDET');
  FComandSQL.SQL.Add('   SET BLD_DIVERG = "N",');
  FComandSQL.SQL.Add('       BLD_EFECON = :EFECON');
  FComandSQL.SQL.Add(' WHERE BLD_SEQGER = :SEQGER');
  FComandSQL.SQL.Add('   AND BLD_CODITE = :CODITE');

  FComandSQL.ParamByName('CODITE').AsString := AstrCodIte;
  FComandSQL.ParamByName('SEQGER').AsString := FstrAutIncBalGer;
  FComandSQL.ParamByName('EFECON').AsFloat  := fltSalCon;

  FComandSQL.ExecSQL;
end;

procedure TControleContagemBalancoEstoque.pAtualzaSalCon(AstrCodIte: string);
begin
  FComandSQL.SQL.Clear;

  FComandSQL.SQL.Add('UPDATE BALGER');
  FComandSQL.SQL.Add(' INNER JOIN BALDET ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER AND BLD_DIVERG = "N"');
  FComandSQL.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODEMP = BALGER.BLG_CODEMP AND ITEGER.ITE_CODITE = BALDET.BLD_CODITE');
  FComandSQL.SQL.Add('   SET ITEGER.ITE_SALCON = ITEGER.ITE_SALCON + BALDET.BLD_EFECON');
  FComandSQL.SQL.Add(' WHERE BALGER.AUTOINCREM = :AUTINC');
  FComandSQL.SQL.Add('   AND BALDET.BLD_CODITE = :CODITE');

  FComandSQL.ParamByName('AUTINC').AsString := FstrAutIncBalGer;
  FComandSQL.ParamByName('CODITE').AsString := AstrCodIte;
  FComandSQL.ExecSQL;
End;

procedure TControleContagemBalancoEstoque.pBaixaBalGer;
begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM BALDET');
  FConsulta.SQL.Add(' WHERE BLD_SEQGER = :SEQGER');
  FConsulta.SQL.Add('   AND BLD_DIVERG = "S"');

  FConsulta.ParamByName('SEQGER').Asstring := FstrAutIncBalGer;

  FConsulta.Open;

  If FConsulta.FieldByName('QTD').AsInteger = 0 Then
  Begin
    FComandSQL.SQL.Clear;
    FComandSQL.SQL.Add('UPDATE BALGER');
    FComandSQL.SQL.Add('   SET BLG_STATUS = "F"');
    FComandSQL.SQL.Add(' WHERE AUTOINCREM = :AUTINC');
    FComandSQL.ParamByName('AUTINC').Asstring := FstrAutIncBalGer;
    FComandSQL.ExecSQL;
  End;
end;



class procedure TControleContagemBalancoEstoque.pCancelaContagem(AstrCodDig,
  AstrCodIte, AstrLocFis: string);
  var
    qryConsulta: TUniQuery;
    qryCommand: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  qryCommand := fCriaQuery;
  Try
    qryConsulta.SQL.Add('    SELECT BLD.AUTOINCREM FROM BALGER');
    qryConsulta.SQL.Add('     INNER JOIN BALDET BLD ON BLD.BLD_SEQGER = BALGER.AUTOINCREM');
    qryConsulta.SQL.Add('     WHERE BLG_LOCFIS = :LOCFIS');
    qryConsulta.SQL.Add('       AND BLG_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('       AND BLG_STATUS = "A"');
    qryConsulta.SQL.Add('       AND BLD.BLD_CODITE = :CODITE');
    qryConsulta.SQL.Add('       AND BLD.BLD_CODOPE = :CODOPE');
    qryConsulta.SQL.Add('       AND BLD.BLD_STATUS = "A"');

    qryConsulta.ParamByName('LOCFIS').AsString := AstrLocFis;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.ParamByName('CODOPE').AsString := AstrCodDig;
    qryConsulta.ParamByName('CODITE').AsString := AstrCodIte;

    qryConsulta.Open;

    While not qryConsulta.Eof Do
    Begin
      qryCommand.SQL.Text := 'DELETE FROM BALDET WHERE AUTOINCREM = "' + qryConsulta.FieldByName('AUTOINCREM').AsString + '"';
      qryCommand.ExecSQL;
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(qryCommand);
  End;
end;

class procedure TControleContagemBalancoEstoque.pConcluiBalgerFinalizadas;
 var
   qryCommand: TUniQuery;
begin
  qryCommand := fCriaQuery;
  Try
    qryCommand.SQL.Clear;
    qryCommand.SQL.Add('UPDATE BALGER');
    qryCommand.SQL.Add('   SET BLG_STATUS = "C"');
    qryCommand.SQL.Add(' WHERE BLG_STATUS = "F"');
    qryCommand.SQL.Add('   AND BLG_CODEMP = "'+VS_StrCodEmp+'"');
    qryCommand.ExecSQL;
  Finally
    FreeAndNil(qryCommand);
  End;
end;

end.
