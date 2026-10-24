unit untTPickingCheckOut;

interface

uses
  untFuncoesSimples, Uni, untHelperCitel, System.SysUtils, untObservacao, VCL.Forms,
  VCL.DBCtrls, Data.DB, VCL.ComCTRLS;

type
  TPickingCheckOutDefinicaoDeLotes = class
  private
    FNumDoc  : String;
    FEspDoc  : String;
    FCodEmp  : String;
    FDefiniu : Boolean;
    procedure pDefinirLotesInterna;
  public
    constructor create(ANumDoc, AEspDoc, ACodEmp : String);
    procedure pDefinirLotes;
    property blnDefiniu : Boolean read FDefiniu;
  end;

  TPickingCheckOut = class
  private
  public

    class procedure pApagarLotDor(ANumDoc, AEspDoc, ACodEmp : String);

    class function fItemDoPedidoEhRetiraCaixa(ASeqFdo : String) : Boolean;
    class function fDocumentoTemAlgumItemRetiraCaixa(ANumDoc, AEspDoc, ACodEmp : String) : Boolean;
    class function fRetornaLotePickingCheckOut(ACodIte, ACodEmp : String) : String;
    class function fEhLocalizacaoPickingCheckOut(ACodLoc, ACodEmp : String) : Boolean;
    class function fJahExisteLotePickingCheckOut(ANumLot, ACodEmp, ACodIte : String) : Boolean;
    class function fWMSUtilizaPickingCheckOut : Boolean;
    class function fWMSUtilizaPickingCheckOutEMovimentacaoProgramada : Boolean;

  end;

implementation

uses
  UniClientDataSet, untTypesSistema, untGravando, untDefineLotesWMS;

{ TPickingCheckOut }

class procedure TPickingCheckOut.pApagarLotDor(ANumDoc, AEspDoc, ACodEmp: String);
  const
    DEL = 'DELETE FROM LOTDOR WHERE LDO_SEQFDO = :AUTINC';

    SQL = 'SELECT              '+
          '  FATDOR.AUTOINCREM '+
          'FROM                '+
          '  FATDOR            '+
          '  INNER JOIN EXTDOR ON (EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM) '+
          'WHERE FDO_NUMDOC = :NUMDOC '+
          '  AND FDO_ESPDOC = :ESPDOC '+
          '  AND FDO_CODEMP = :CODEMP '+
          '  AND FDO_ENTRET = "R"     '+
          '  AND FDO_LOCRET = "C"     ';

  var
    LqryAux : TUniQuery;
    LqryDel : TUniQuery;
begin

  LqryAux := fCriaQuery;
  LqryDel := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    LqryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.Open;

    If Not LqryAux.IsEmpty Then
    Begin
      LqryAux.First;
      While Not LqryAux.Eof Do
      Begin
        LqryDel.Close;
        LqryDel.SQL.Clear;
        LqryDel.SQL.Add(DEL);
        LqryDel.ParamByName('AUTINC').AsString := LqryAux.FieldByName('AUTOINCREM').AsString;;
        LqryDel.ExecSQL;
        LqryAux.Next;
      End;
    End;

  Finally
    FreeAndNil(LqryAux);
    FreeAndNil(LqryDel);
  End;

end;

class function TPickingCheckOut.fDocumentoTemAlgumItemRetiraCaixa(ANumDoc, AEspDoc, ACodEmp: String): Boolean;
  const
    SQL = 'SELECT            '+
          '  COUNT(*) AS TOT '+
          'FROM              '+
          '  FATDOR          '+
          '  INNER JOIN EXTDOR ON (EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM) '+
          'WHERE FDO_NUMDOC = :NUMDOC '+
          '  AND FDO_ESPDOC = :ESPDOC '+
          '  AND FDO_CODEMP = :CODEMP '+
          '  AND FDO_ENTRET = "R"     '+
          '  AND FDO_LOCRET = "C"     ';

  var
    LqryAux : TUniQuery;
begin

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    LqryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.Open;

    Result := (Not LqryAux.IsEmpty) And (LqryAux.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LqryAux);
  End;

end;

class function TPickingCheckOut.fEhLocalizacaoPickingCheckOut(ACodLoc, ACodEmp: String): Boolean;
  const
    SQL = 'SELECT            '+
          '  COUNT(*) AS TOT '+
          'FROM       '+
          '  CADLOC L '+
          'WHERE      '+
          '  L.LOC_CODLOC = :CODLOC AND '+
          '  L.LOC_CODEMP = :CODEMP AND '+
          '  L.LOC_PICKIN = "C"';
  var
    LqryAux : TUniQuery;
begin

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('CODLOC').AsString := ACodLoc;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.Open;

    Result := (Not LqryAux.IsEmpty) And (LqryAux.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LqryAux);
  End;

end;

class function TPickingCheckOut.fItemDoPedidoEhRetiraCaixa(ASeqFdo: String): Boolean;
  const
    SQL = 'SELECT            '+
          '  COUNT(*) AS TOT '+
          'FROM              '+
          '  FATDOR          '+
          '  INNER JOIN EXTDOR ON (EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM) '+
          'WHERE AUTOINCREM = :AUTINC '+
          '  AND FDO_ENTRET = "R"     '+
          '  AND FDO_LOCRET = "C"     ';

  var
    LqryAux : TUniQuery;
begin

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('AUTINC').AsString := ASeqFdo;
    LqryAux.Open;

    Result := (Not LqryAux.IsEmpty) And (LqryAux.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LqryAux);
  End;

end;

class function TPickingCheckOut.fJahExisteLotePickingCheckOut(ANumLot, ACodEmp, ACodIte: String): Boolean;
  const
    SQL = 'SELECT                    '+
          '  T.LOT_NUMLOT AS NUMLOT, '+
          '  T.LOT_LOCFIS AS LOCFIS, '+
          '  L.LOC_DESCRI AS DESCRI  '+
          'FROM       '+
          '  CADLOT T '+
          '  INNER JOIN CADLOC L ON (L.LOC_CODLOC = T.LOT_LOCFIS AND '+
          '                          L.LOC_CODEMP = T.LOT_CODEMP)    '+
          'WHERE                          '+
          '  (T.LOT_STATUS = "S")     AND '+
          '  (T.LOT_CODITE = :CODITE) AND '+
          '  (T.LOT_CODEMP = :CODEMP) AND '+
          '  (L.LOC_PICKIN = "C")     AND '+
          '  (T.LOT_NUMLOT <> :NUMLOT)    ';

    MSG = 'É permitido ter apenas um lote ativo cadastrado e vinculado a uma localização Picking Check-out.' + #13 + #13 +
          'Portanto, escolha outra localização para continuar ou acerte o cadastro da localização física.  ' + #13 + #13 +
          'Lote que está ativo e já vinculado à localização picking-ckeck-out: [NUMLOT] - [LOCFIS]';
  var
    LqryAux : TUniQuery;
    LstrMsg : String;
begin

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('CODITE').AsString := ACodIte;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.ParamByName('NUMLOT').AsString := ANumLot;
    LqryAux.Open;

    Result := Not LqryAux.IsEmpty;

    If (Result) Then
    Begin
      LstrMsg := MSG;
      LstrMsg := LstrMsg.Replace('[NUMLOT]', LqryAux.FieldByName('NUMLOT').AsString);
      LstrMsg := LstrMsg.Replace('[LOCFIS]', LqryAux.FieldByName('DESCRI').AsString);
      TfrmObservacao.fObservacao('ATENÇÃO!', LstrMsg);
    End;

  Finally
    FreeAndNil(LqryAux);
  End;

end;

class function TPickingCheckOut.fRetornaLotePickingCheckOut(ACodIte, ACodEmp: String): String;
  const
    SQL = 'SELECT          '+
          '  T.LOT_NUMLOT, '+
          '  T.LOT_LOCFIS  '+
          'FROM            '+
          '  CADLOT T      '+
          '  INNER JOIN CADLOC L ON (L.LOC_CODLOC = T.LOT_LOCFIS AND '+
          '                          L.LOC_CODEMP = T.LOT_CODEMP)    '+
          'WHERE                        '+
          '  T.LOT_STATUS = "S"     AND '+
          '  T.LOT_CODITE = :CODITE AND '+
          '  T.LOT_CODEMP = :CODEMP AND '+
          '  L.LOC_PICKIN = "C"';
  var
    LqryAux : TUniQuery;
    LCodIte : String;
begin

  LqryAux := fCriaQuery;

  Try

    LCodIte := ACodIte;

    {Cód. Barras}
    If (LCodIte.Length > fTamCodIte) Then
      LCodIte := fRetCodIte(LCodIte);

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('CODITE').AsString := LCodIte;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.Open;

    Result := IIF(Not LqryAux.IsEmpty, LqryAux.FieldByName('LOT_NUMLOT').AsString, '');

  Finally
    FreeAndNil(LqryAux);
  End;

end;

class function TPickingCheckOut.fWMSUtilizaPickingCheckOut: Boolean;
begin
  Result := fCfgSis('PICOUT', varString) = 'S';
end;

class function TPickingCheckOut.fWMSUtilizaPickingCheckOutEMovimentacaoProgramada: Boolean;
begin

  Result := False;

  If Not fWMSUtilizaPickingCheckOut Then
    Exit;

  Result := fCfgSis('PICWMS', varString) = 'S';

end;

{ TPickingCheckOutDefinicaoDeLotes }

constructor TPickingCheckOutDefinicaoDeLotes.create(ANumDoc, AEspDoc, ACodEmp: String);
begin
  FNumDoc  := ANumDoc;
  FEspDoc  := AEspDoc;
  FCodEmp  := ACodEmp;
  FDefiniu := False;
end;

procedure TPickingCheckOutDefinicaoDeLotes.pDefinirLotes;
begin
  fExecutarModal(pDefinirLotesInterna, 'Definindo lotes, Aguarde ...', '');
end;

procedure TPickingCheckOutDefinicaoDeLotes.pDefinirLotesInterna;
  var
    LQryAux        : TUniQuery;
    LCdsAux        : TUniClientDataSet;
    LDadosCodBarra : TarrayDadosCodBarra;
    LDefLot        : TDefineLotesWMS;
    prgProgresso   : TProgressBar;
begin

  FDefiniu := False;

  LQryAux := fCriaQuery();
  LDefLot := TDefineLotesWMS.CreateInstance(Nil, FNumDoc, FCodEmp, EmptyStr, False, EmptyStr, EmptyStr, EmptyStr, EmptyStr, True);

  prgProgresso := TProgressBar.Create(nil);

  Try

    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add(LDefLot.fGetSqlItensPedido);
    LQryAux.Open;

    If Not LQryAux.IsEmpty Then
    Begin

      LCdsAux := fCriaClientDatset(LQryAux);
      LDefLot.pAtualizaLotes(LCdsAux, True, LDadosCodBarra);

      If LDefLot.fValidaCadastroLotesProdutos Then
        FDefiniu := LDefLot.fValidarLotes(LCdsAux) And
                    LDefLot.fSalvarQuantidadeDigitadaBD(LCdsAux, prgProgresso);

    End;

  Finally

    If Assigned(LQryAux) Then
      FreeAndNil(LQryAux);

    If Assigned(LCdsAux) Then
      FreeAndNil(LCdsAux);

    If Assigned(prgProgresso) Then
      FreeAndNil(prgProgresso);

    If Assigned(LDefLot) Then
      FreeAndNil(LDefLot);

  End;

end;

end.
