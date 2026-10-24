unit untOrdProIndCorrecoes;

interface

Uses
  Classes,
  SysUtils,
  Controls,
  ComCtrls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  StrUtils,
  Math,
  frxClass,
  DBEditFocus,
  System.Variants;

Type

  TOrdProIndCorrecoes = Class(TZClient)
    Private
      FCopia: TUniClientDataSet;
      FPesquisaLoteApenasComLocalizacao: Boolean;

      Function fSQLCorrecoes(blnCarregaInfoGravada: Boolean = False; strAutInc: String = ''): String;
      function fCriaReservaCorrecoes(ASeqOrd: String): Boolean;
      Procedure pAbreCadIte(qryCadIte: TUniQuery; strCodIte: String);


    Public
      objOrdPro : Pointer;
      blnMATBOP : Boolean;

      constructor Create(Owner: TComponent; blnCarregaInfoGravada: Boolean = False; strAutInc: String = ''); Reintroduce;
      Destructor Destroy; override;

      Function fGravaCorrecoes(strSeqOrd, strCodEmp: String; blnCadCorrecoes: Boolean = False): Boolean;
      Function fJaIncluiuItem(strCodIte: String): Boolean;

      Function fIncluiCorrecao: Boolean;
      Function fAlteraCorrecao: Boolean;
      Function fExcluiCorrecao: Boolean;

      Function fRetTotalCustoCorrecoes : Double;
      Function fRetQtdCorrecaoNegativaDoItem(strCodSubItem: String) : Double;
      function fRetQtdCorrecaoDoItem(strCodSubItem: String): Double;

      Function fOrdemBaixada(ASeqOrd: String): Boolean;

      class function fAtualizaReservaCorrecao(ASeqOrd: String; strJaFatu: string): Boolean;
      class function fExluiReservaCorrecao(ASeqOrd: String; qryCorrecoesReserva: TUniQuery): Boolean;

      procedure pResetarEstadoAposRollback;

      property blnPesquisaLoteApenasComLocalizacao: Boolean read FPesquisaLoteApenasComLocalizacao write FPesquisaLoteApenasComLocalizacao;

  End;

implementation

Uses
  untFuncoesSimples, untBaixaOrdProdIndCorrecoes, untAtualizaOcorrenciasCRM, untTypesSistema, untFatGor;

constructor TOrdProIndCorrecoes.Create(Owner: TComponent; blnCarregaInfoGravada: Boolean = False; strAutInc: String = '');
Begin
  Inherited Create(Owner, fSQLCorrecoes(blnCarregaInfoGravada, strAutInc));

  fAbreClient(True, 'TOrdProIndCorrecoes.Create');

  blnMATBOP := fCfgSis('MATBOP', varBoolean);

  pFormataDecimal('DMT_QTDITE', 4);
  pFormataDecimal('QTD_OP', 4);
  pFormataDecimal('QTD_UTILIZADA', 4);

  IndexFieldNames := 'DMT_SEQUEN';

  FCopia := TUniClientDataSet.Create(Self);

  FPesquisaLoteApenasComLocalizacao:= False;

End;

Destructor TOrdProIndCorrecoes.Destroy;
Begin
  Inherited;

End;

Function TOrdProIndCorrecoes.fSQLCorrecoes(blnCarregaInfoGravada: Boolean = False; strAutInc: String = ''): String;
  Var
    strSQL: String;
Begin
  if blnCarregaInfoGravada then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT *, 0.0000 AS QTD_OP , '+
                       '        CAST(DMT_QTDITE AS DECIMAL(12,4)) AS QTD_UTILIZADA, '+
                       '        "" AS REFERENCIA, '+
                       '        CAST(DMT_NUMLOT AS CHAR(30)) AS NUMLOT, '+
                       '        CAST(0.0000 AS DECIMAL(12,4)) AS QTD_UTILIZADA_LOTE, '+
                       '        CAST(0.0000 AS DECIMAL(12,4)) AS SALDO_ATUAL_LOTE, '+
                       '        CAST("N" AS CHAR(1)) AS ORI_FORAORDEM, '+
                       '        CAST("N" AS CHAR(1)) AS DIGITADO '+
                       ' FROM DEICOR D ';

    strSQL := strSQL + ' WHERE DMT_SEQORD = "'+strAutInc+'"';
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT *, 0.0000 AS QTD_OP , '+
                       '       0.0000 AS QTD_UTILIZADA, '+
                       '       "" AS REFERENCIA, '+
                       '       CAST(DMT_NUMLOT AS CHAR(30)) AS NUMLOT, '+
                       '       CAST(0.0000 AS DECIMAL(12,4)) AS QTD_UTILIZADA_LOTE, '+
                       '       CAST(0.0000 AS DECIMAL(12,4)) AS SALDO_ATUAL_LOTE, '+
                       '       CAST("N" AS CHAR(1)) AS ORI_FORAORDEM, '+
                       '       CAST("N" AS CHAR(1)) AS DIGITADO '+
                       ' FROM DEICOR D ';

    strSQL := strSQL + ' WHERE FALSE';
  End;

  Result := strSQL;

End;


Procedure TOrdProIndCorrecoes.pAbreCadIte(qryCadIte: TUniQuery; strCodIte: String);
Begin
  qryCadIte.Close;
  qryCadIte.SQL.Clear;
  qryCadIte.SQL.Add('SELECT');
  qryCadIte.SQL.Add('  ITE_DESITE,');
  qryCadIte.SQL.Add('  ITE_CODMAR,');
  qryCadIte.SQL.Add('  ITE_REFERE,');
  qryCadIte.SQL.Add('  ITE_CODUNI,');
  qryCadIte.SQL.Add('  ITE_CODFOR ');
  qryCadIte.SQL.Add('FROM');
  qryCadIte.SQL.Add('  CADITE');
  qryCadIte.SQL.Add('WHERE');
  qryCadIte.SQL.Add('  ITE_CODITE = :CODITE');

  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.Open;
End;

function  TOrdProIndCorrecoes.fCriaReservaCorrecoes(ASeqOrd: String): Boolean;
var qryCadIte, qryComand: TUniQuery;
    qryConsulta: TUniQuery;
    strSeqFgo, strAutFdo, strNumDoc, strCodCli, strMens01, strMens02: String;
    objOcoCrm: TAtuOcoCrm;
    recServicos: TDadosServicos;
    intIdxIte: integer;
    bltTemSaldoPositivo: Boolean;
    arrDuplic : TarrDuplicata;







begin
  Self.First;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT FDO_CODITE,  FDO_SEQGER  FROM RESCOR');
    qryConsulta.SQL.Add('INNER JOIN FATDOR ON FATDOR.AUTOINCREM = RESCOR.COR_SEQFDO');
    qryConsulta.SQL.Add(' WHERE COR_SEQORD = "'+ASeqOrd+'"');
    qryConsulta.Open;
    qryComand := fCriaQuery;
    qryCadIte := fCriaQuery;
    Try
      qryComand.SQL.Add('DELETE FROM FATGOR WHERE AUTOINCREM = "'+qryConsulta.FieldByName('FDO_SEQGER').AsString + '"');
      qryComand.ExecSQL;

      qryComand.SQL.Clear;
      qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE');

      while not qryConsulta.eOF do
      Begin
        qryComand.ParamByName('CODITE').AsString := qryConsulta.FieldByName('FDO_CODITE').AsString;
        qryComand.ExecSQL;
        qryConsulta.Next;
      End;

      Self.First;
      bltTemSaldoPositivo := False;
      while not self.Eof do
      Begin
        If (Self.FieldByName('DMT_QTDITE').AsFloat > 0) Then
        Begin
          bltTemSaldoPositivo := True;
          Break
        End;
        self.Next;
      End;

      If Not bltTemSaldoPositivo Then
        Exit(True);


      Self.First;

      strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE OP-' + ASeqOrd + ' ' + 'Correções';

      strCodCli := fCadEmp('CLIFIL');

      If fEmptyStr(strCodCli) Then
      Begin
        Result := (fMensagem('ATENÇÃO', 'Informe o código do cliente filial no cadastro de empresas para continuar!', ['&OK']) = -1);
        Exit;
      End;

      strNumDoc := fRetSequencialPedido;

      objOcoCrm := Nil;

      If Assigned(objOcoCrm) Then
        objOcoCrm.strNomFrm := Self.Name;

      FillChar(recServicos, SizeOf(TDadosServicos), #0);
      FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
      {$region 'fGravaFatGor'}

      Result := fGravaFatGor(strSeqFgo,             // strIncrem
                           VS_strCodEmp,          // strCodEmp
                           strNumDoc,             // strNumDoc
                           'PD',                  // strEspDoc
                           strCodCli,             // strCodCli
                           strLoginUsuarioLogado, // strCodVen
                           '',                    // strCodTra
                           '',                    // strSerie:
                           VS_Date,               // dtaDtaEnt
                           fTime(),               // dtaHorEnt
                           '01000',               // strConPag
                           '',                    // strEstado
                           '',                    // strNomCom
                           '',                    // strEndCon
                           '',                    // strBaiCon
                           '',                    // strCepCon
                           '',                    // strCidCon
                           '',                    // strEstCon
                           '',                    // strCodAti
                           '',                    // strTelCon
                           0,                     //  dtaNasCon
                           '',                    // strCgcCpf
                           '',                    // strCgcCon
                           '',                    // strIesCon
                           '',                    // strCli_Rg
                           0.0,                   // fltBasSim
                           0.0,                   // fltBasIpi
                           0.0,                   // fltAlqIpi
                           0.0,                   // fltTotIpi
                           0.0,                   // fltBasIcm
                           0.0,                   // fltAlqIcm
                           0.0,                   // fltTotIcm
                           0.0,                   // fltTotRet
                           0.0,                   // fltAlqRet
                           0.0,                   // fltBasRet
                           0.0,                   // fltDesEsp
                           0.0,                   // fltVlrCon
                           0.0,                   // fltTotPro
                           0.0,                   // fltTotCus
                           0.0,                   // fltTotMed
                           '',                    // strTipFre
                           0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                           0.0,                   // fltTotFre
                           0.0,                   // fltTotFre
                           0.0,                   // fltPesBru
                           0.0,                   // fltPesLiq
                           0,                     // fltVolume
                           arrDuplic,             // arrDuplic
                           '',                    // strEspeci
                           '',                    // strMarca,
                           strMens01,             // strMen001
                           strMens02,             // strMen002
                           False,                 // blnJaFatu
                           '',                    // strTipFat
                          // '',
                           '',                    // strNumFat
                           '',                    // strEmpFat
                           0,                     // dtaDtaFat
                           '',                    // strVenFat
                           '',                    // strCndFat
                           0.0,                   // fltValFat
                           0.0,                   // fltPorDes
                           strLoginUsuarioLogado, // strCodDig
                           '',                    // strCodCnd
                           '',                    // strCodFpg
                           recServicos, '',       // strConEnt
                           VS_Date,               // dtaPreVis
                           0.0,                   // fltVPgAnt
                           VS_Date,               // dtaUltAlt
                           '',                    // strNTrava
                           'A',                   // strTipPed
                           '',                    // strCliCtt
                           0,                     // intLibera
                           'S',                   // strEntFat
                           0.0,                   // fltDesCon
                           '1',                   // strTabPre
                           '',                    // strEntFut
                           0.0,                   // fltMargem
                           '',                    // strNumPok
                           '',                    // strEmp_CD
                           False,                 // blnEnt_CD
                           'N',                   // strOprFlj
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '', '', False,         // blnPedLib
                           0.0,
                           'N',
                           '',
                           0,
                           'P',                   // strTipFin
                           0,                     // fltDesFin
                           '',                    // strAutEnt
                           '',
                           '',
                           False,
                           '',
                           Nil,
                           '',
                           '',
                           0,
                           0,
                           0,
                           '',
                           objOcoCrm,
                           '',
                           0,
                           0,
                           '',
                           '',
                           0,
                           '',
                           0,
                           '',
                           '',
                           '',
                           'N');

      {$endregion}
      {$region 'fGravaMovDet'}
      intIdxIte := 0;
      If Result Then
      Begin
        Self.First;
        while not Self.Eof Do
        Begin
          If Not (Self.FieldByName('DMT_QTDITE').AsFloat > 0) Then
          begin
            Self.Next;
            Continue;
          End;

          pAbreCadIte(qryCadIte, Self.FieldByName('DMT_ITESUB').AsString);
          inc(intIdxIte);

          strAutFdo := '';
          Result := Result And fGravaFatDor(strAutFdo,
                                            strSeqFgo,                                    // strSeqGer
                                            VS_strCodEmp,                                 // strCodEmp
                                            strCodCli,                                    // strCodCli
                                            strLoginUsuarioLogado,                        // strCodVen
                                            Self.FieldByName('DMT_ITESUB').AsString,      // strCodIte
                                            qryCadIte.FieldByName('ITE_CODMAR').AsString, // strCodMar
                                            '',                                           // strCodDiv
                                            strNumDoc,                                    // strNumDoc
                                            'PD',                                         // strEspDoc
                                            '',                                           // strSerie:
                                            VS_Date, fTime(),                             // dtaHorEnt
                                            '01000',                                      // strConPag
                                            '',                                           //strEstado
                                            qryCadIte.FieldByName('ITE_DESITE').AsString, // strDescri
                                            qryCadIte.FieldByName('ITE_REFERE').AsString, // strRefere
                                            qryCadIte.FieldByName('ITE_CODUNI').AsString, // strUnidad
                                            qryCadIte.FieldByName('ITE_CODFOR').AsString, // strForIte
                                            Self.FieldByName('DMT_QTDITE').AsFloat,       // fltQtdIte
                                            0.0,                                          // fltUnitar
                                            0.0,                                          // fltUniOri
                                            0.0,                                          // fltUniVis
                                            0.0,                                          // fltTotIte
                                            0.0,                                          // fltVlrCon
                                            0.0,                                          // fltTotCus
                                            0.0,                                          // fltTotMed
                                            0.0,                                          // fltDesCon
                                            0.0,                                          // fltTotFre
                                            0.0,                                          // fltDesEsp
                                            0.0,                                          // fltDesAce
                                            '',                                           // strCodRep
                                            '',                                           // strCodVe2
                                            0.0,                                          // fltPerCom
                                            0.0,                                          // fltTotCom
                                            0.0,                                          // fltTotCo2
                                            '',                                           // strClaFis
                                            '',                                           // strCodFis
                                            0.0,                                          // fltValIpi
                                            0.0,                                          // fltAlqIpi
                                            0.0,                                          // fltBasIpi
                                            0.0,                                          // fltValIcm
                                            0.0,                                          // fltAlqIcm
                                            0.0,                                          // fltBasIcm
                                            0.0,                                          // fltValRet
                                            0.0,                                          // fltAlqRet
                                            0.0,                                          // fltBasRet
                                            0.0,                                          // fltTotPes
                                            0.0,                                          // fltPerBas
                                            0.0,                                          // fltPerRed
                                            False,                                        // blnJaFatu
                                            '',                                           // strTipFat
                                           //'',
                                            '',                                           // strNumFat
                                            '',                                           // strEmpFat
                                            0,                                            // dtaDtaFat
                                            '',                                           // strVenFat
                                            '',                                           // strCndFat
                                            0.0,                                          // fltValFat
                                            'NOR',                                        // strIdePro
                                            'N',                                          // strIncPis
                                            strLoginUsuarioLogado,                        // strCodDig
                                            '',                                           // strConPag
                                            '',                                           // strProEmb
                                            '',                                           // strCodFpg
                                            '',                                           // strIteCha
                                            '',                                           // strIteTin
                                            '',                                           // strDesCor
                                            '',                                           // strTipEmb
                                            0.0,                                          // fltQtdEmb
                                            0.0,                                          // fltPreEmb
                                            '',                                           // strTipPre
                                            0.0,                                          // fltPrvTin
                                            0.0,                                          // fltPrcTin
                                            0.0,                                          // fltFatTin
                                            '',                                           // strIteEmb
                                            '',                                           // strGruEmb
                                            0,                                            // intLazQua
                                            'N',                                          // strPromoc
                                            '',                                           // strSeqTin
                                            0.0,                                          // fltQtdPul
                                            intIdxIte,                                    // intSeqInd
                                            0.0,                                          // fltQtdBai
                                            0.0,                                          // fltUniDig
                                            '',                                           // strComple
                                            0.0,                                          // fltVolPro
                                            '',                                           // strCodAca
                                            '',                                           // strEmpAca
                                            False,                                        // blnProAca
                                            '',                                           // strTabPre
                                            '',                                           // strLinha:
                                            '',                                           // strCatali
                                            '',                                           // strCodDil
                                            0.0,                                          // fltPorDil
                                            '',                                           // strDilCon
                                            0.0,                                          // fltPorCat: Double;
                                            '',                                           // strEntRet,
                                            '',                                           // strLocRet,
                                            '',                                           // strEntFut,
                                            '',                                           // strMotFut: String;
                                            0,                                            // dtaDtEntr: TDateTime;
                                            0,                                            // fltTotCu2: Double;
                                            0,                                            // fltComRep,
                                            0,                                            // fltPerRep: Double;
                                            '',                                           // strKey_EP,
                                            Self.FieldByname('DMT_NUMLOT').AsString,     // strNumLot: String;
                                            '',                                           // strEmpPrd: String;
                                            False,                                        // blnBxSbIt: Boolean;
                                            '',                                           // strEmpIte: String;
                                            '',                                           // strDocDev,
                                            '',                                           // strEspDev,
                                            '',                                           // strEmpDev: String;
                                            '',                                           // strEmpFor: String;
                                            '',                                           // strOrdPro: String;
                                            0,                                            // fltFreSug: Double;
                                            0,                                            // fltQtdExp: Double;
                                            '',                                           // strBarEmb: String;
                                            '',                                           // strNumCmp: String;
                                            0,                                            // intNItCmp: Integer;
                                            '',                                           // strCodMec: String;
                                            '',                                           // strSeqRcd: String;
                                            0,                                            // intSeqInc: Integer;
                                            0,                                            // intOrdIte: Integer;
                                            0);                                           // fltPesLiq: Double;

           qryComand.SQL.Clear;
           qryComand.SQL.Add('INSERT INTO RESCOR (AUTOINCREM, COR_SEQORD, COR_SEQFDO, COR_SEQCOR) VALUES (');
           qryComand.SQL.Add('"' + fRetAutoIncrem('RESCOR', VS_StrCodEmp)+ '",');
           qryComand.SQL.Add('"' + ASeqOrd + '",');
           qryComand.SQL.Add('"' + strAutFdo + '",');
           qryComand.SQL.Add('"' +Self.FieldByName('AUTOINCREM').AsString + '")');
           qryComand.ExecSQL;


           qryComand.SQL.Clear;
           qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = "'+Self.FieldByName('DMT_ITESUB').AsString+'"');
           qryComand.ExecSQL;


           If Not Result Then
             Break;
          Self.Next;
        End;
      {$endregion}
      End;


    Finally
      FreeAndNil(qryCadIte);
      FreeAndNil(qryComand);
    End;

  Finally
    FreeAndNil(qryConsulta);
  End;
  {}
end;

Function TOrdProIndCorrecoes.fGravaCorrecoes(strSeqOrd, strCodEmp: String; blnCadCorrecoes: Boolean = False): Boolean;
Type
  TLinhaZerada = Record
    arrValores: Array Of Variant;
  End;
Var
  arrZeradas: Array Of TLinhaZerada;
  intI, intF: Integer;
Begin
  Result := True;
  Try
    Try
      DisableControls;
      SetLength(arrZeradas, 0);

      // 1) Percorre uma unica vez: grava chaves nas QTD<>0 e memoriza QTD=0 pendentes
      First;
      While Not Eof Do
      Begin
        If RoundTo(FieldByName('DMT_QTDITE').AsFloat, -fCfgSis('DECMOP', varInteger)) <> 0 Then
        Begin
          Edit;
          If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DEICOR', VS_strCodEmp);
          FieldByName('DMT_CODEMP').AsString := strCodEmp;
          FieldByName('DMT_SEQORD').AsString := strSeqOrd;
          Post;
          Next;
        End
        Else If UpdateStatus = usInserted Then
        Begin
          // Memoriza todos os campos da linha antes de descarta-la do delta
          intI := Length(arrZeradas);
          SetLength(arrZeradas, intI + 1);
          SetLength(arrZeradas[intI].arrValores, FieldCount);
          For intF := 0 To FieldCount - 1 Do
            arrZeradas[intI].arrValores[intF] := Fields[intF].Value;
          Delete;  // remove do delta (nao gera SQL, pois estava usInserted)
        End
        Else
          Next;  // registro persistido com QTD=0 -> preserva no banco, nao mexe
      End;

      // 2) ApplyUpdates: grava somente QTD<>0
      If Not Self.IsEmpty Then
        Result := fSalva;

      // 3) Reintroduz as linhas QTD=0 apenas em memoria (para o grid)
      For intI := 0 To High(arrZeradas) Do
      Begin
        Self.Append;
        For intF := 0 To FieldCount - 1 Do
        Begin
          If Fields[intF].FieldKind <> fkData Then
            Continue;
          If VarIsNull(arrZeradas[intI].arrValores[intF]) Or
             VarIsEmpty(arrZeradas[intI].arrValores[intF]) Then
            Continue;
          Fields[intF].Value := arrZeradas[intI].arrValores[intF];
        End;
        Self.Post;
      End;

      // 4) Consolida os re-appends como usUnmodified (nada mais no delta)
      If Self.ChangeCount > 0 Then
        Self.MergeChangeLog;

      Self.First;

      If blnCadCorrecoes And (fCfgSis('CORROP', varString) = 'N') And (Not fOrdemBaixada(strSeqOrd)) Then
        Result := fCriaReservaCorrecoes(strSeqOrd);
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TOrdProIndCorrecoes.fGravaCorrecoes]');
      End;
    End;
  Finally
    EnableControls;
  End;
End;

Function TOrdProIndCorrecoes.fIncluiCorrecao: Boolean;
  Var
    frmBaixaOrdProdIndCorrecoes : TfrmBaixaOrdProdIndCorrecoes;
Begin
  Try
    If FCopia.Active Then
       FCopia.EmptyDataSet;

    FCopia.Data := Self.Data;

    Append;

    pCriarFormularios(TfrmBaixaOrdProdIndCorrecoes, frmBaixaOrdProdIndCorrecoes);

    frmBaixaOrdProdIndCorrecoes.Caption := 'Inclusão de Correção';
    frmBaixaOrdProdIndCorrecoes.dtsItens.DataSet := Self;
    frmBaixaOrdProdIndCorrecoes.objOrdCor := Self;
    frmBaixaOrdProdIndCorrecoes.blnPesquisaLoteApenasComLocalizacao:= blnPesquisaLoteApenasComLocalizacao;
    frmBaixaOrdProdIndCorrecoes.ShowModal;

    If frmBaixaOrdProdIndCorrecoes.blnConfirma Then
    begin
      FieldByName('QTD_OP').AsFloat := 0;
      FieldByName('QTD_UTILIZADA').AsFloat := FieldByName('DMT_QTDITE').AsFloat;
      FieldByName('NUMLOT').AsString       := FieldByName('DMT_NUMLOT').AsString;
      FieldByName('REFERENCIA').AsString   := fRetReferenciaProd(FieldByName('DMT_ITESUB').AsString);
      FieldByName('DIGITADO').AsString     := 'S';
      {comentado a alteração feita no requisito 278447  rev .: 318190, pois está gerando o erro do req 291209
       FieldByName('DMT_OPECON').AsString   := strLoginUsuarioLogado;
       FieldByName('DMT_DTACON').AsDateTime := VS_Date;
       FieldByName('DMT_HRACON').AsDateTime := fTime(); }

      Post;
    end
    Else
      Cancel;

    pFreeAndNil(frmBaixaOrdProdIndCorrecoes);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndCorrecoes.fIncluiCorrecao]');
    End;
  End;
End;

Function TOrdProIndCorrecoes.fJaIncluiuItem(strCodIte: String): Boolean;
Begin
  Result := FCopia.Locate('DMT_ITESUB', strCodIte, []);
End;

function TOrdProIndCorrecoes.fOrdemBaixada(ASeqOrd: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta :=fCriaQuery;
  try
    qryConsulta.SQL.Text := 'SELECT ORD_DTABAI FROM ORDGER WHERE AUTOINCREM = "'+ASeqOrd+'" AND ORD_DTABAI IS NOT NULL';
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
  Finally
    freeAndNil(qryConsulta)
  End;

end;

function TOrdProIndCorrecoes.fRetQtdCorrecaoNegativaDoItem(
  strCodSubItem: String): Double;
begin
  Try
    Result := 0.00;
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If (FieldByName('DMT_ITESUB').AsString = strCodSubItem) And (FieldByName('DMT_QTDITE').AsFloat < 0) Then
      Result := Result + (FieldByName('DMT_QTDITE').AsFloat);
      Next;
    End;
  Finally
    First;
    EnableControls;
  End;
end;


function TOrdProIndCorrecoes.fRetQtdCorrecaoDoItem(strCodSubItem: String): Double;
begin
  Try
    Result := 0.00;
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If (FieldByName('DMT_ITESUB').AsString = strCodSubItem) Then
      Result := Result + (FieldByName('DMT_QTDITE').AsFloat);
      Next;
    End;
  Finally
    First;
    EnableControls;
  End;
end;


function TOrdProIndCorrecoes.fRetTotalCustoCorrecoes: Double;
begin
  Try
    Result := 0.00;
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Result := Result + (FieldByName('DMT_QTDITE').AsFloat * fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [FieldByName('DMT_ITESUB').AsString, VS_strCodEmp]));
      Next;
    End;
  Finally
    First;
    EnableControls;
  End;
end;

Function TOrdProIndCorrecoes.fAlteraCorrecao: Boolean;
  Var
    frmBaixaOrdProdIndCorrecoes : TfrmBaixaOrdProdIndCorrecoes;
Begin
  Try
    Result := True;
    
    If IsEmpty Then
      Exit;

    Edit;

    pCriarFormularios(TfrmBaixaOrdProdIndCorrecoes, frmBaixaOrdProdIndCorrecoes);

    frmBaixaOrdProdIndCorrecoes.Caption := 'Alteração de Correção';
    frmBaixaOrdProdIndCorrecoes.dtsItens.DataSet := Self;
    frmBaixaOrdProdIndCorrecoes.blnPesquisaLoteApenasComLocalizacao:= blnPesquisaLoteApenasComLocalizacao;
    frmBaixaOrdProdIndCorrecoes.objOrdCor := Self;

    frmBaixaOrdProdIndCorrecoes.ShowModal;

    If frmBaixaOrdProdIndCorrecoes.blnConfirma Then
    Begin
      If (fUsaRotinaWMS) Then
      Begin
        FieldByName('NUMLOT').AsString      := FieldByName('DMT_NUMLOT').AsString;
        FieldByName('QTD_UTILIZADA').AsFloat:= FieldByName('DMT_QTDITE').AsFloat;
      End;
      Post;
    End
    Else
      Cancel;

    pFreeAndNil(frmBaixaOrdProdIndCorrecoes);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndCorrecoes.fAlteraCorrecao]');
    End;
  End;
End;

class function TOrdProIndCorrecoes.fAtualizaReservaCorrecao(ASeqOrd: String; strJaFatu: string): Boolean;
var qryConsulta, qryComand: TUniquery;
begin
  qryConsulta := fCriaQuery;

  Try
    qryConsulta.SQL.Add('SELECT FDO_CODITE,  FDO_SEQGER  FROM RESCOR');
    qryConsulta.SQL.Add('INNER JOIN FATDOR ON FATDOR.AUTOINCREM = RESCOR.COR_SEQFDO');
    qryConsulta.SQL.Add(' WHERE COR_SEQORD = "'+ASeqOrd+'"');
    qryConsulta.Open;
    qryComand := fCriaQuery;
    Try
      qryComand.SQL.Add('UPDATE FATGOR SET FGO_JAFATU = '+strJaFatu+' WHERE AUTOINCREM = "'+qryConsulta.FieldByName('FDO_SEQGER').AsString + '";');
      qryComand.SQL.Add('UPDATE FATDOR SET FDO_JAFATU =  '+strJaFatu+' WHERE FDO_SEQGER = "'+qryConsulta.FieldByName('FDO_SEQGER').AsString + '";');
      qryComand.ExecSQL;
      qryComand.SQL.Clear;
      qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE');

      while not qryConsulta.eOF do
      Begin
        qryComand.ParamByName('CODITE').AsString := qryConsulta.FieldByName('FDO_CODITE').AsString;
        qryComand.ExecSQL;
        qryConsulta.Next;
      End;
      Result := True;
    finally
       FreeAndNil(qryComand);
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

Function TOrdProIndCorrecoes.fExcluiCorrecao: Boolean;
Begin
  Try
    Result := True;
    
    If IsEmpty Then
      Exit;

    if FieldByName('QTD_OP').AsFloat > 0 then
    begin
      pMensagemOk('Não é possível excluir as matérias primas da fórmula!');
      exit(False);
    end;

    If fPergunta('Confirma a exclusão da correção?') Then
      Delete;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndCorrecoes.fExcluiCorrecao]');
    End;
  End;
End;


class function TOrdProIndCorrecoes.fExluiReservaCorrecao(ASeqOrd: String; qryCorrecoesReserva: TUniQuery): Boolean;
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('DELETE FROM FATGOR WHERE AUTOINCREM = "'+qryCorrecoesReserva.FieldByName('FDO_SEQGER').AsString + '";');
    qryComand.ExecSQL;
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE');

    while not qryCorrecoesReserva.eOF do
    Begin
      qryComand.ParamByName('CODITE').AsString := qryCorrecoesReserva.FieldByName('FDO_CODITE').AsString;
      qryComand.ExecSQL;
      qryCorrecoesReserva.Next;
    End;
    qryComand.SQL.Clear;
    qryComand.SQL.Add('DELETE FROM RESCOR ');
    qryComand.SQL.Add(' WHERE COR_SEQORD = "'+ASeqOrd+'"');
    qryComand.ExecSQL;

    Result := True;
  finally
     FreeAndNil(qryComand);
  End
end;


Procedure TOrdProIndCorrecoes.pResetarEstadoAposRollback;
Type
  TLinhaBkp = Record
    arrValores: Array Of Variant;
  End;
Var
  arrBkp: Array Of TLinhaBkp;
  intI, intF: Integer;
Begin
  // Captura todos os valores de todas as linhas (preserva o que o usuario digitou)
  DisableControls;
  Try
    SetLength(arrBkp, Self.RecordCount);
    First;
    intI := 0;
    While Not Eof Do
    Begin
      SetLength(arrBkp[intI].arrValores, FieldCount);
      For intF := 0 To FieldCount - 1 Do
        arrBkp[intI].arrValores[intF] := Fields[intF].Value;
      Inc(intI);
      Next;
    End;

    // Descarta qualquer delta pendente + esvazia o CDS
    If Self.ChangeCount > 0 Then
      Self.CancelUpdates;
    Self.EmptyDataSet;

    // Re-insere todas as linhas SEM AUTOINCREM -> todas viram usInserted "limpas"
    For intI := 0 To High(arrBkp) Do
    Begin
      Self.Append;
      For intF := 0 To FieldCount - 1 Do
      Begin
        If Fields[intF].FieldKind <> fkData Then
          Continue;
        // Nao restaura AUTOINCREM: precisa ser regenerado na proxima tentativa
        If SameText(Fields[intF].FieldName, 'AUTOINCREM') Then
          Continue;
        If VarIsNull(arrBkp[intI].arrValores[intF]) Or
           VarIsEmpty(arrBkp[intI].arrValores[intF]) Then
          Continue;
        Fields[intF].Value := arrBkp[intI].arrValores[intF];
      End;
      Self.Post;
    End;
    Self.First;
  Finally
    EnableControls;
  End;
End;

end.
