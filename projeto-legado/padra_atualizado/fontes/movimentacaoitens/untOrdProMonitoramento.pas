unit untOrdProMonitoramento;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Controls,untFuncoesSimples,UniClientDataSet,
{$ENDIF}
  Classes, SysUtils, DB, untZClient, Uni,
  untTypesSistema, untConstantes, untLiberacao, untMsgLiberacao;

Type
  TOrdProMonitoramento = Class(TZClient)
    Private
      objLiberacao : TLiberacao;

      Function fSQLFases: String;
      Function fSQLOperacoes: String;

      Procedure pCriaFases;
      
      Function fCarregaMonitoramento(strAutOPI, strCodFas: String): Boolean;

      Function fTemFaseAnteriorIniciada(strAutOPI,
                                strCodFas: String;
                                Var strFasAnt: String;
                                Var strDesFasAnt: String): Boolean;

      Function fTemFasePosteriorIniciada(strAutOPI,
                        strCodFas: String; Var strFasPos: String): Boolean;
      Function fConfirmaSubProdutosFase(AStrCodFas, AStrCodOpi: String): Boolean;
    procedure pLimparCdsSubProd(AStrAutIncFase: String);

    Public
      qryMonOPI: TUniQuery;

      strIncOPI: String;

      qryFases: TUniQuery;

      cdsOperacoes: TZClient;

      cdsCabIpr: TZClient;
      fltVolume: Double;

      cdsSubProd: TUniClientDataSet;


      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaFases(strAutIncOP: String): Boolean;
      Function fRetCodFase(intRecNo: Integer): String;


      Function fSQLMonitoramento: String;

      Function fIniciaOperacao(strAutOPI, strOpeIni, strCodFas: String): Boolean;

      Function fFinalizaOperacao(strAutOPI, strOpeFin, strCodFas: String): Boolean;

      Function fCarregaOperacoes: Boolean;

      Function fCancelaOperacao(strAutInc, strCodOPI, strCodFas: String; dtaDtaFin: TDateTime): Boolean;

      Function fOPFinalizada(strAutInc: String; Var strMsg: String): Boolean;

      Function fTemOperacaoIniciada(strAutInc: String): Boolean;
      Class Function fTemOperacaoIniciadaDeOPAberta(var strOpisAbertas: String; strCodFas: String = ''; strCodIte: String = ''): Boolean;
      Class Function fValidaFasesBaixa(strCodPro: String): Boolean;
      Function fSQLPosicaoOperacoes: String;
  End;

implementation

Uses
{$IFDEF LINUX}
{$ELSE}
  untOrdProIndustrialOperacoes,
{$ENDIF}
  Faturamento.Classes.TFatVendaBase, untFuncoesGenerica;

constructor TOrdProMonitoramento.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

  strIncOPI := '';

  pCriaFases;

  cdsOperacoes := TZClient.Create(Self, fSQLOperacoes);

  objLiberacao := Tliberacao.Create;

  qryMonOPI := fCriaQuery(Self);
End;

Destructor TOrdProMonitoramento.Destroy;
Begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  Inherited;
End;

Function TOrdProMonitoramento.fSQLOperacoes: String;
Begin
  Result := '';
  Result := Result +  ' SELECT                                                ';
  Result := Result +  '   T.*,                                                ';
  Result := Result +  '   M.PRO_CODPRO,                                       ';
  Result := Result + '    F.FAS_DESFAS,                                       ';
  Result := Result + '    F.FAS_CODIGO,                                       ';
  Result := Result + '    F.FAS_SEQUEN                                        ';
  Result := Result +  ' FROM                                                  ';
  Result := Result +  '   MNTORD T                                            ';
  Result := Result + '  INNER JOIN FASGER F ON T.MNT_SEQFAS = F.AUTOINCREM    ';
  Result := Result + '  INNER JOIN MOVPRO M ON T.MNT_SEQORD = M.AUTOINCREM    ';
  Result := Result +  ' WHERE                                                 ';
  Result := Result +  '   MNT_SEQORD = :SEQORD                                ';
  Result := Result +  ' ORDER BY                                              ';
  Result := Result +  '   MNT_SEQFAS, MNT_DTAINI, MNT_HRAINI                  ';
End;

Function TOrdProMonitoramento.fSQLMonitoramento: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL +  ' SELECT * FROM MNTORD ';
  strSQL := strSQL +  ' WHERE ';
  strSQL := strSQL +  '   MNT_SEQORD = :SEQORD AND ';
  strSQL := strSQL +  '   MNT_SEQFAS = :SEQFAS ';

  Result := strSQL;
End;

Function TOrdProMonitoramento.fSQLFases: String;
  Var
    strSQL: String;
Begin
  strSQL := '/* TOrdProMonitoramento.fSQLFases */ ';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                    ';
  strSQL := strSQL + '   C.FAS_CODIGO,                                        ';
  strSQL := strSQL + '   C.FAS_DESFAS                                         ';
  strSQL := strSQL + ' FROM                                                   ';
  strSQL := strSQL + '   FASORD T                                             ';
  strSQL := strSQL + ' INNER JOIN FASGER C ON T.ORD_SEQFAS = C.AUTOINCREM     ';
  strSQL := strSQL + ' INNER JOIN FASMAT M ON M.MAT_SEQFAS = C.AUTOINCREM     ';
  strSQL := strSQL + ' WHERE                                                  ';
  strSQL := strSQL + '    T.ORD_SEQORD = :SEQORD                              ';
  strSQL := strSQL + ' ORDER BY FAS_SEQUEN                                    ';

  Result := strSQL;
End;

Procedure TOrdProMonitoramento.pCriaFases;
Begin
  qryFases := fCriaQuery(Self);
  qryFases.SQL.Text := fSQLFases;
End;

Function TOrdProMonitoramento.fCarregaFases(strAutIncOP: String): Boolean;
Begin
  Try

    With qryFases Do
    Begin
      Close;
      ParamByName('SEQORD').AsString := strAutIncOP;
      Open;

      Result := Not IsEmpty;

      If Result Then
        strIncOPI := strAutIncOP
      Else
        strIncOPI := '';

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProMonitoramento.fCarregaFases]');
    End;
  End;
End;

Function TOrdProMonitoramento.fRetCodFase(intRecNo: Integer): String;
Begin
  If intRecNo > 0 Then
  Begin
    qryFases.RecNo := intRecNo;
    Result         := qryFases.FieldByName('FAS_CODFAS').AsString;
  End

  Else Result := '';
End;

Function TOrdProMonitoramento.fTemFaseAnteriorIniciada(strAutOPI, strCodFas: String; Var strFasAnt: String; Var strDesFasAnt: String): Boolean;
  Var
    qryFasOrd: TUniQuery;
Begin
  strFasAnt := '';
  qryFasOrd := fCriaQuery;
  With qryFasOrd, SQL Do
  Begin
    Add('SELECT                                                ');
    Add('  C.FAS_CODIGO, C.FAS_DESFAS                          ');
    Add('FROM                                                  ');
    Add('  FASORD T                                            ');
    Add('INNER JOIN FASGER C ON T.ORD_SEQFAS = C.AUTOINCREM    ');
    Add('INNER JOIN FASMAT M ON M.MAT_SEQFAS = C.AUTOINCREM    ');
    Add('WHERE                                                 ');
    Add('  T.ORD_SEQORD = :SEQOPI AND                          ');
    Add('  C.FAS_SEQUEN < :SEQFAS                              ');
    Add('ORDER BY C.FAS_SEQUEN DESC LIMIT 1                    ');

    ParamByName('SEQOPI').AsString  := strAutOPI;
    ParamByName('SEQFAS').AsInteger := fCampoTabela('FAS_SEQUEN', 'FASGER', ['FAS_CODIGO'], [strCodFas]) ;

    Open;

    If IsEmpty Then
    Begin
      Result := True;  // NÃO HÁ FASES ANTERIORES NO CADASTRO PARA ESSA ORDEM DE PRODUÇÃO
    End Else
    Begin
      strFasAnt := FieldByName('FAS_CODIGO').AsString;
      strDesFasAnt := FieldByName('FAS_DESFAS').AsString;

      Close;
      Clear;
      Add(' SELECT * FROM MNTORD ');
      Add(' WHERE ');
      Add('   MNT_SEQORD = :SEQOPI AND ');
      Add('   MNT_SEQFAS = :SEQFAS    ');

      ParamByName('SEQOPI').AsString := strAutOPI;
      ParamByName('SEQFAS').AsString := fCampoTabela('AUTOINCREM', 'FASGER', ['FAS_CODIGO'], [strFasAnt]);

      Open;

      Result := Not IsEmpty;
    End;

  End;
  FreeAndNil(qryFasOrd);
End;

Function TOrdProMonitoramento.fIniciaOperacao(strAutOPI, strOpeIni, strCodFas: String): Boolean;
  Var
    strFasAnt,
    strDesFasAnt: String;
Begin
  Try
    If fCarregaMonitoramento(strAutOPI, strCodFas) Then
    Begin
      Result := False;

      If Not FieldByName('MNT_DTAFIN').IsNull Then
      Begin
         pMensagemOk('Essa Fase já foi iniciada e finalizada!');
      End Else
      Begin
        pMensagemOk('Essa Fase já foi iniciada!');
      End;

    End

    Else If Not fTemFaseAnteriorIniciada(strAutOPI, strCodFas, strFasAnt, strDesFasAnt) Then
    Begin
      Result := False;
      pMensagemOk('Ainda não foi iniciada a produção da fase anterior (' +  strFasAnt + '-' +
                   strDesFasAnt + ') !');
    End Else

    Begin
      Insert;
      FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MNTORD', VS_strCodEmp);
      FieldByName('MNT_SEQORD').AsString   := strAutOPI;
      FieldByName('MNT_SEQFAS').AsString   := fCampoTabela('AUTOINCREM', 'FASGER', ['FAS_CODIGO'], [strCodFas]);
      FieldByName('MNT_OPEINI').AsString   := strOpeIni;
      FieldByName('MNT_DTAINI').AsDateTime := VS_Date;
      FieldByName('MNT_HRAINI').AsDateTime := fTime();
      FieldByName('MNT_CODEMP').AsString   := VS_StrCodEmp;
      Post;
      Result := fSalva;

      EmptyDataSet;
      strIncOPI := '';
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProMonitoramento.fIniciaOperacao]');
    End;
  End;
End;

Function TOrdProMonitoramento.fFinalizaOperacao(strAutOPI, strOpeFin, strCodFas: String): Boolean;
Begin
  Try
    Result := False;

    If fCarregaMonitoramento(strAutOPI, strCodFas) Then
    Begin

      If Not FieldByName('MNT_DTAFIN').IsNull Then
      Begin
        pMensagemOk('Essa Fase já foi finalizada!');
      End Else
      Begin
        Edit;
        FieldByName('MNT_OPEFIN').AsString   := strOpeFin;
        FieldByName('MNT_DTAFIN').AsDateTime := VS_Date;
        FieldByName('MNT_HRAFIN').AsDateTime := fTime();
        Post;

        Result := fSalva;

        If Result Then
        Begin
          EmptyDataSet;
          strIncOPI := '';
        End;
      End;

    End Else
    Begin
      pMensagemOk('Essa Fase ainda não foi iniciada!');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProMonitoramento.fFinalizaOperacao]');
    End;
  End;
End;

Function TOrdProMonitoramento.fCarregaMonitoramento(strAutOPI, strCodFas: String): Boolean;
Begin
  Try

    With qryQuery Do
    Begin
      SQL.Text := fSQLMonitoramento;

      ParamByName('SEQORD').AsString := strAutOPI;
      ParamByName('SEQFAS').AsString := fCampoTabela('AUTOINCREM','FASGER',['FAS_CODIGO'], [strCodFas]);


      Result := fAbreClient(True) And (Not Self.IsEmpty);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProMonitoramento.fCarregaMonitoramento]');
    End;
  End;
End;

Function TOrdProMonitoramento.fCarregaOperacoes: Boolean;
Begin
  With cdsOperacoes, qryQuery Do
  Begin
    ParamByName('SEQORD').AsString := strIncOPI;

    Result := fAbreClient(True);

    If Result Then
    Begin
      pAlinhaCampoCentro('MNT_OPEINI');
      pAlinhaCampoCentro('MNT_DTAINI');
      pAlinhaCampoCentro('MNT_HRAINI');
      pAlinhaCampoCentro('MNT_DTAFIN');
      pAlinhaCampoCentro('MNT_HRAFIN');
    End;

  End;
End;

Function TOrdProMonitoramento.fTemFasePosteriorIniciada(strAutOPI,
                          strCodFas: String; Var strFasPos: String): Boolean;
  Var
    qryFasOrd: TUniQuery;
Begin
  strFasPos := '';
  qryFasOrd := fCriaQuery;
  With qryFasOrd, SQL Do
  Begin
    Clear;
    Add('SELECT C.FAS_CODIGO FROM MNTORD T                  ');
    Add('INNER JOIN FASGER C ON T.MNT_SEQFAS = C.AUTOINCREM ');
    Add('WHERE                                              ');
    Add('  T.MNT_SEQORD = :SEQOPI AND                       ');
    Add('  C.FAS_SEQUEN > :SEQFAS                           ');

    ParamByName('SEQOPI').AsString  := strAutOPI;
    ParamByName('SEQFAS').AsInteger := fCampoTabela('FAS_SEQUEN', 'FASGER', ['FAS_CODIGO'], [strCodFas]);

    Open;

    Result := Not IsEmpty;

    If Result Then
      strFasPos := FieldByName('FAS_CODIGO').AsString;

  End;
  FreeAndNil(qryFasOrd);
End;

Function TOrdProMonitoramento.fConfirmaSubProdutosFase(AStrCodFas, AStrCodOpi: String): Boolean;
var
  qryAux: TUniQuery;
  strMsg: String;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT DISTINCT SQL_NO_CACHE                       ');
    qryAux.SQL.Add('  C.ITE_CODITE,                                     ');
    qryAux.SQL.Add('  C.ITE_DESITE,                                     ');
    qryAux.SQL.Add('  G.FAS_DESFAS                                      ');
    qryAux.SQL.Add(' FROM CADITE C                                      ');
    qryAux.SQL.Add('  INNER JOIN DETPRO D ON DOP_ITESUB = C.ITE_CODITE  ');
    qryAux.SQL.Add('  INNER JOIN MOVPRO M ON DOP_SEQGER = M.AUTOINCREM  ');
    qryAux.SQL.Add('  INNER JOIN FASGER G ON DOP_SEQFAS = G.AUTOINCREM  ');
    qryAux.SQL.Add(' WHERE TRUE                                         ');
    qryAux.SQL.Add('   AND G.FAS_CODIGO = :CODFAS                       ');
    qryAux.SQL.Add('   AND M.PRO_CODEMP = :CODEMP                       ');
    qryAux.SQL.Add('   AND M.PRO_CODPRO = :CODPRO                       ');

    qryAux.ParamByName('CODFAS').AsString := AStrCodFas;
    qryAux.ParamByName('CODPRO').AsString := AStrCodOpi;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryAux.Open;

    Result := qryAux.IsEmpty;

    strMsg := '';
    If Not Result Then
    Begin
      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        strMsg := strMsg + qryAux.FieldByName('ITE_CODITE').AsString + '-' + qryAux.FieldByName('ITE_DESITE').AsString + #13#10;
        qryAux.Next;
      End;

      strMsg := 'Existem subprodutos associados com a FASE ' + qryAux.FieldByName('FAS_DESFAS').AsString + '. Ao cancelar a fase os subprodutos serão excluidos da Op.' + #13#10 + strMsg;

      Result := fMensagem('',strMsg,['&Confirmar','Cancelar']) = 1;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

Function TOrdProMonitoramento.fCancelaOperacao(strAutInc, strCodOPI, strCodFas: String; dtaDtaFin: TDateTime): Boolean;
  Var
    qryMonOrd: TUniQuery;
    strFasPos: String;
    strAutIncFas: String;
Begin
  Try
    qryMonOrd := fCriaQuery;
    strAutIncFas := fCampoTabela('AUTOINCREM', 'FASGER', ['FAS_CODIGO'],[strCodFas]);
    With qryMonOrd, SQL Do
    Begin

      If dtaDtaFin > 0 Then
      Begin
        Clear;
        Add('UPDATE MNTORD SET ');
        Add('  MNT_DTAFIN = (NULL), ');
        Add('  MNT_HRAFIN = (NULL), ');
        Add('  MNT_OPEFIN = (NULL)  ');
        Add('WHERE ');
        Add('  AUTOINCREM = :AUTINC ');

        ParamByName('AUTINC').AsString := strAutInc;

        ExecSQL;

        Result := True;

      End

      Else If fTemFasePosteriorIniciada(strCodOPI, strCodFas, strFasPos) Then
      Begin
        Result := False;
        pMensagemOk('A Fase posterior (' +  strFasPos + '-' + fRetDescricaoFase(strFasPos) + ') já foi iniciada e deve ser cancelada primeiro!');

      End Else
      Begin

        If fConfirmaSubProdutosFase(strCodFas, strCodOpi) Then
        Begin
          Clear;
          Add('DELETE FROM MNTORD     ');
          Add('WHERE ');
          Add('  AUTOINCREM = :AUTINC ');

          ParamByName('AUTINC').AsString := strAutInc;

          ExecSQL;

          Clear;

          Add('SELECT DOP_ITESUB FROM DETPRO WHERE DOP_SEQFAS = :AUTINC AND DOP_CODEMP = :CODEMP');
          ParamByName('CODEMP').AsString := VS_StrCodEmp;
          ParamByName('AUTINC').AsString := strAutIncFas;
          Open;
          First;
          While Not Eof Do
          Begin
            ReprocessarItem(FieldByName('DOP_ITESUB').AsString, VS_StrCodEmp, False);
            Next;
          End;

          Clear;
          Add('DELETE FROM DETPRO WHERE DOP_SEQFAS = :AUTINC');
          ParamByName('AUTINC').AsString := strAutIncFas;

          ExecSQL;

          pLimparCdsSubProd(strAutIncFas);

          Result := True;
        End

        Else Result := False;

      End;

    End;

    FreeAndNil(qryMonOrd);
  Except
    on E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProMonitoramento.fCancelaOperacao]');
    End;
  End;
End;

Procedure TOrdProMonitoramento.pLimparCdsSubProd(AStrAutIncFase: String);
var
  strFilterBkp: String;
  blnFilteredBkp: Boolean;
Begin
  blnFilteredBkp := cdsSubProd.Filtered;
  strFilterBkp := cdsSubProd.Filter;
  Try
    cdsSubProd.Filter := 'SEQFAS = ' + QuotedStr(AStrAutIncFase);
    cdsSubProd.Filtered := True;
    cdsSubProd.First;
    While Not cdsSubProd.Eof Do
      cdsSubProd.Delete;
  Finally
    cdsSubProd.Filter := strFilterBkp;
    cdsSubProd.Filtered := blnFilteredBkp;
  End;
End;

Function TOrdProMonitoramento.fSQLPosicaoOperacoes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL +  ' SELECT                                                ';
  strSQL := strSQL +  '   MNT_DTAINI,                                         ';
  strSQL := strSQL +  '   MNT_HRAINI,                                         ';
  strSQL := strSQL +  '   MNT_DTAFIN,                                         ';
  strSQL := strSQL +  '   MNT_HRAFIN,                                         ';
  strSQL := strSQL +  '   MNT_OPEINI,                                         ';
  strSQL := strSQL +  '   IF(MNT_DTAINI IS NULL, "S", "N") AS SEMINI,         ';
  strSQL := strSQL +  '   IF(MNT_DTAFIN IS NULL, "S", "N") AS SEMFIN,         ';
  strSQL := strSQL +  '   F.FAS_DESFAS AS FAS_DESFAS,                         ';
  strSQL := strSQL +  '   F.FAS_SEQUEN AS FAS_SEQFAS                          ';
  strSQL := strSQL +  ' FROM                                                  ';
  strSQL := strSQL +  '   FASORD T                                            ';
  strSQL := strSQL +  '   INNER JOIN FASGER F ON F.FAS_CODFAS = T.ORD_SEQFAS  ';
  strSQL := strSQL +  '   LEFT JOIN MNTORD M ON M.MNT_SEQORD = T.FAS_SEQORD   ';
  Result := Result + '                      AND M.MNT_SEQFAS = T.FAS_SEQFAS   ';
  strSQL := strSQL +  ' WHERE                                                 ';
  strSQL := strSQL +  '   T.FAS_SEQORD = :SEQORD                              ';
  strSQL := strSQL +  ' ORDER BY                                              ';
  strSQL := strSQL +  '   F.FAS_SEQUEN, MNT_DTAINI, MNT_HRAINI                ';
End;

Function TOrdProMonitoramento.fOPFinalizada(strAutInc: String; Var strMsg: String): Boolean;
Begin
  Try
    strMsg := '';

    With qryMonOPI Do
    Begin
      Close;

      SQL.Text := fSQLPosicaoOperacoes;

      ParamByName('SEQORD').AsString := strAutInc;

      Open;

      If Locate('SEMFIN', 'S', []) Then
      Begin
        Result := False;
        strMsg := 'Há Fases não finalizadas para essa ordem de produção!';
      End

      Else If Locate('SEMINI', 'S', []) Then
      Begin
        Result := False;
        strMsg := 'Há Fases não iniciadas para essa ordem de produção!';
      End

      Else Result := True;

    End;

  Except
    on E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProMonitoramento.fOPFinalizada]');
    End;
  End;
End;

Function TOrdProMonitoramento.fTemOperacaoIniciada(strAutInc: String): Boolean;
  Var
    qryMonOPI: TUniQuery;
Begin
  qryMonOPI := fCriaQuery;
  With qryMonOPI, SQL Do
  Begin
    Add('SELECT * FROM MNTORD');
    Add('WHERE');
    Add('  MON_SEQORD = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    Result := Not IsEmpty;
  End;
  FreeAndNil(qryMonOPI)
End;

Class Function TOrdProMonitoramento.fTemOperacaoIniciadaDeOPAberta(var strOpisAbertas: String; strCodFas: String = ''; strCodIte: String = ''): Boolean;
Var
  qryMonOPI: TUniQuery;
Begin
  qryMonOPI := fCriaQuery;
  strOpisAbertas := '';
  With qryMonOPI, SQL Do
  Begin
    Add('SELECT G.PRO_CODPRO FROM MNTORD M ');
    Add('INNER JOIN MOVPRO G ON G.AUTOINCREM = M.MNT_SEQORD');
    Add('WHERE');
    Add('  G.PRO_DTABAI IS NULL');

    If Not fEmptyStr(strCodFas) Then
    Begin
      Add('  AND MNT_SEQFAS = :SEQFAS');
      ParamByName('SEQFAS').AsString := fCampoTabela('AUTOINCREM', 'FASGER', ['FAS_CODIGO'], [strCodFas]);
    End;

    If Not fEmptyStr(strCodIte) Then
    Begin
      Add('  AND G.PRO_CODITE = :CODITE');
      ParamByName('CODITE').AsString := strCodIte;
    End;

    Add(' GROUP BY G.AUTOINCREM ');

    Open;

    Result := Not IsEmpty;

    If Result Then
    Begin
      First;
      While Not Eof Do
      Begin
        strOpisAbertas := strOpisAbertas + FieldByName('PRO_CODPRO').AsString + #13#10;
        Next;
      End;
    End;
  End;
  FreeAndNil(qryMonOPI)
End;

class function TOrdProMonitoramento.fValidaFasesBaixa(strCodPro: String): Boolean;
Var
  qryMonOPI: TUniQuery;
Begin
  qryMonOPI := fCriaQuery;
  Try
    With qryMonOPI, SQL Do
    Begin
      Add('  SELECT                                                                                        ');
      Add('    FASGER.AUTOINCREM,                                                                          ');
      Add('    FAS_CODIGO,                                                                                 ');
      Add('    FAS_SEQUEN,                                                                                 ');
      Add('    FAS_DESFAS                                                                                  ');
      Add('  FROM                                                                                          ');
      Add('    FASMAT                                                                                      ');
      Add('    INNER JOIN FASGER                                                                           ');
      Add('      ON MAT_SEQFAS = FASGER.AUTOINCREM                                                         ');
      Add('    LEFT JOIN MOVPRO                                                                            ');
      Add('      ON PRO_CODPRO = :CODPRO                                                                   ');
      Add('    INNER JOIN GERMAT                                                                           ');
      Add('      ON MAT_SEQMAT = GERMAT.AUTOINCREM                                                         ');
      Add('      AND GMT_CODITE = PRO_CODITE                                                               ');
      Add('    LEFT JOIN MNTORD                                                                            ');
      Add('      ON MNT_SEQFAS = FASGER.AUTOINCREM                                                         ');
      Add('      AND MNT_SEQORD = MOVPRO.AUTOINCREM                                                        ');
      Add('  WHERE TRUE                                                                                    ');
      Add('    AND MAT_CODEMP = :CODEMP                                                                    ');
      Add('    AND ((MNTORD.AUTOINCREM IS NULL) OR ((MNT_DTAINI IS NOT NULL) AND (MNT_DTAFIN IS NULL)))    ');
      Add('  GROUP BY FASGER.AUTOINCREM                                                                    ');
      Add('  ORDER BY FAS_SEQUEN                                                                           ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := IsEmpty;

      If Not Result Then
        pMensagemOk('Há fases não iniciadas ou não finalizadas para a ordem de produção!');
    End;
  Finally
    FreeAndNil(qryMonOPI);
  End;
End;

end.
