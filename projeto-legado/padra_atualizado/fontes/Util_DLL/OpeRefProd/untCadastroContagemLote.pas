unit untCadastroContagemLote;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants, untGravando,
  cxProgressBar, untTLock;

Type
  TCadastroContagemLote = Class(TZClient)
  Private

    blnTMQLOT,
    blnUsaRotinaWMS: Boolean;

    strAutIncLot: String;

    qryCadLot: TUniQuery;
    objLock: TLock;

    frmGravando: TfrmGravando;

    FLocFis: String;

    Function fSQLItens: String;

    Function fAdicionaContagemExternaPrg(cxpProgressBar: TcxProgressBar): Boolean;

    Function fCadastraLote: Boolean;

  Public

    cdsContagemExterna: TUniClientDataSet;

    constructor Create(Owner: TComponent); Reintroduce; Overload;

    Destructor Destroy; override;

    function fIniciaLotes(strLocFis: String): Boolean;

    Procedure pApagaRegistro;

    Function fAdicionaRegistro(strCodIte, strDesIte, strLocFis, strNumLot: String; fltQtdIte: Double; dtaDtaVal: TDateTime): Boolean;

    Function fAdicionaContagemExterna: Boolean;

  End;

implementation

uses
  untCadLote,
  untConstantes,
  untCadLoteItens,
  untFuncoesSimples,
  untMensagemTravaLote,
  untBalancoEstoqueAjuste;

constructor TCadastroContagemLote.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLItens);

  qryCadLot := fCriaQuery(Self);
  qryCadLot.SQL.Text := 'SELECT * FROM CADLOT WHERE FALSE';
  objLock := TLock.Create;

  blnUsaRotinaWMS := fUsaRotinaWMS;
  blnTMQLOT       := fCfgSis('TMQLOT', varBoolean);
End;

Destructor TCadastroContagemLote.Destroy;
Begin
  objLock.pDestravarTodos;
  FreeAndNil(objLock);
  Inherited;
End;

Function TCadastroContagemLote.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_LOCFIS   AS LOCFIS, ';
  strSQL := strSQL + '   LOT_NUMLOT   AS NUMLOT, ';
  strSQL := strSQL + '   LOT_DTAVAL   AS DTAVAL, ';
  strSQL := strSQL + '   0.0000       AS DIGCON  ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   CADITE C   ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADLOT   ON   LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + ' WHERE FALSE  ';

  Result := strSQL;
End;

function TCadastroContagemLote.fIniciaLotes(strLocFis: String): Boolean;
Begin
  FLocFis := strLocFis;

  Result := fLeDados('TCadastroContagemLote.fIniciaLotes');

  If Result Then
  Begin
    IndexFieldNames := 'CODITE;DTAVAL';

    pAlinhaCampoCentro('CODITE');
    pAlinhaCampoCentro('DTAVAL');
  End;
End;

Procedure TCadastroContagemLote.pApagaRegistro;
  Var
    strCodIte: String;
Begin
  If IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão da contagem do produto ' + FieldByName('CODITE').AsString + '-' + FieldByName('DESITE').AsString + '?') Then
  Begin
    strCodIte := FieldByName('CODITE').AsString;

    Delete;

    If Not Locate('CODITE', strCodIte, []) Then
      objLock.fLock_Unlock(STR_TRAVA_LOTE + strCodIte, False, False, False, '', True, 'LOTE');

  End;
End;

Function TCadastroContagemLote.fAdicionaRegistro(strCodIte, strDesIte, strLocFis, strNumLot: String; fltQtdIte: Double; dtaDtaVal: TDateTime): Boolean;
Begin

  If Locate('CODITE', strCodIte, []) Or
     objLock.fLock_Unlock(STR_TRAVA_LOTE + strCodIte, True, False, False, '', True, 'LOTE') Then
  Begin
    if (fUsaRotinaWMS and (fCfgSis('TPLREC', varString) <> 'N')) then
    begin
      If fCfgSis('COLVAL', varBoolean) then
      begin
        if Locate('CODITE;LOCFIS;DTAVAL', VarArrayOf([strCodIte, strLocFis, dtaDtaVal]), []) Then
          Edit
        else
          Append;
      end
      else begin
        if Locate('CODITE;LOCFIS', VarArrayOf([strCodIte, strLocFis]), []) Then
          Edit
        else
          Append;
      end;


    end
    else
    begin

      If FindKey([strCodIte, dtaDtaVal]) Then
        Edit
      Else
        Append;

    end;

    FieldByName('CODITE').AsString   := strCodIte;
    FieldByName('DESITE').AsString   := strDesIte;
    FieldByName('NUMLOT').AsString   := strNumLot;
    FieldByName('LOCFIS').AsString   := strLocFis;

    FieldByName('DIGCON').AsFloat    := fltQtdIte;

    If dtaDtaVal = 0 Then
      FieldByName('DTAVAL').Clear
    Else
     FieldByName('DTAVAL').AsDateTime := dtaDtaVal;

    Post;

    Result := True;
  End

  Else
  Begin
    TfrmMensagemTravaLote.pMostraTravaLote('O item ' + strCodIte + ' está sendo utilizado na estação: ' + fGetHostLock(STR_TRAVA_LOTE + strCodIte));

    Result := False;
  End;
End;

Function TCadastroContagemLote.fAdicionaContagemExterna: Boolean;
Begin
  Result := TfrmGravando.fExecuta(fAdicionaContagemExternaPrg, frmGravando, 'Gravando contagens, aguarde...');
End;

Function TCadastroContagemLote.fCadastraLote: Boolean;
  Var
    objCadLot: TCadLot;
    blnUsarSaldoItem: Boolean;
Begin
  objCadLot := TCadLot.Create(Self, qryCadLot);

  qryCadLot.Insert;
  qryCadLot.FieldByName('AUTOINCREM').AsString := strAutIncLot;
  qryCadLot.FieldByName('LOT_CODEMP').AsString := VS_strCodEmp;
  qryCadLot.FieldByName('LOT_ABSAUT').AsString := 'S';
  qryCadLot.FieldByName('LOT_STATUS').AsString := 'S';

  qryCadLot.FieldByName('LOT_CODITE').AsString := FieldByName('CODITE').AsString;
  qryCadLot.FieldByName('LOT_NUMLOT').AsString := FieldByName('NUMLOT').AsString;
  qryCadLot.FieldByName('LOT_LOCFIS').AsString := FieldByName('LOCFIS').AsString;
  qryCadLot.FieldByName('LOT_DTAVAL').Value    := FieldByName('DTAVAL').Value;

  TfrmCadLoteItens.pGravaLoteItemParte1(qryCadLot, objCadLot, blnUsaRotinaWMS Or blnTMQLOT, blnUsarSaldoItem);

  If qryCadLot.FieldByName('LOT_SALDOS').IsNull Then
    qryCadLot.FieldByName('LOT_SALDOS').AsFloat := 0;

  If qryCadLot.FieldByName('LOT_SAL_ML').IsNull Then
    qryCadLot.FieldByName('LOT_SAL_ML').AsFloat := 0;

  qryCadLot.Post;

  Result := TfrmCadLoteItens.fGravaLoteItemParte2(qryCadLot, objCadLot, Nil, True, blnUsarSaldoItem, False, False);

  strAutIncLot := fNextAutoIncrem(strAutIncLot);

  FreeAndNil(objCadLot);
End;

Function TCadastroContagemLote.fAdicionaContagemExternaPrg(cxpProgressBar: TcxProgressBar): Boolean;
  Var
    qryItem: TUniQuery;
    intContador: Integer;
Begin
  DisableControls;
  cdsContagemExterna.DisableControls;

  Try

    Try
      fStartTransaction;

      qryItem := fCriaQuery;
      qryItem.SQL.Text := fSQLCamposDigColetivo + ' WHERE I.ITE_CODITE = :CODITE AND I.ITE_CODEMP = :CODEMP AND LOT_NUMLOT = :NUMLOT';

      cxpProgressBar.Properties.Max := RecordCount;
      Application.ProcessMessages;

      strAutIncLot := fRetAutoIncrem('CADLOT', VS_strCodEmp, RecordCount);

      First;

      While Not Eof Do
      Begin

        If fCadastraLote Then
        Begin
          qryItem.Close;
          qryItem.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryItem.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
          qryItem.ParamByName('NUMLOT').AsString := FieldByName('NUMLOT').AsString;
          qryItem.Open;

          If Not qryItem.IsEmpty Then
          Begin
            cdsContagemExterna.Append;

            For intContador := 0 To cdsContagemExterna.FieldCount - 1 Do
              cdsContagemExterna.Fields[intContador].Value := qryItem.Fields[intContador].Value;

            cdsContagemExterna.FieldByName('DIGCON').AsFloat := FieldByName('DIGCON').AsFloat;

            cdsContagemExterna.Post;
          End;
        End;

        Next;

        cxpProgressBar.Position := cxpProgressBar.Position + 1;
        Application.ProcessMessages;
      End;

      fCommit;

      objLock.pDestravarTodos;

      Result := True;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TCadastroContagemLote.fAdicionaContagemExternaPrg');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryItem);

    EnableControls;

    cdsContagemExterna.EnableControls;
  End;
End;

end.
