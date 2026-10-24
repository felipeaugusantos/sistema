unit untLiberacaoTransferenciaArmazem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxProgressBar, untCadLote, System.StrUtils;

type
  TfrmLiberacaoTransferenciaArmazem = class(TfrmPaiOrdena)
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    tmrAtualizaConsulta: TTimer;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure tmrAtualizaConsultaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCadLot: TCadLot;
    blnProcessando : Boolean;
    function fCarregaDocumentos(pgbProgresso: TcxProgressBar): Boolean;
    function fMarcaDocumentos(pgbProgresso: TcxProgressBar): Boolean;
    function fLiberaDocumentos(pgbProgresso: TcxProgressBar): Boolean;
    function fApagaReserva(AAutIncMovDet: String): boolean;
    procedure pMarcaTodosDocumentos;
    procedure pCarregaDocumentos;
    function fValidaSaldoDisponivel(blnMostraMensagem: Boolean = True): Boolean;
    function fQuantidadeUsada(strCodIte, strArmaze: String): Double;

    { Private declarations }
  protected
    FQryTmp: TUniQuery;
    cdsBackup: TUniClientDataSet;
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetOrderBy: String; Override;

    procedure pAddListaQuery; override;

  public

    { Public declarations }
  end;

Const
  STR_CLAENT = '1999';
  STR_CLASAI = '5999';

implementation

{$R *.dfm}

uses untGravando, untFuncoesSimples;

procedure TfrmLiberacaoTransferenciaArmazem.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos;
end;

procedure TfrmLiberacaoTransferenciaArmazem.btnDesmarcaClick(Sender: TObject);
begin
  If blnProcessando Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  inherited;
  stlListselecao.Clear;
  dbgConsulta.Repaint;
  btnGravar.Enabled := (stlListselecao.Count > 0)

end;

procedure TfrmLiberacaoTransferenciaArmazem.btnGravarClick(Sender: TObject);
begin
  inherited;
  If blnProcessando Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;
  If (stlListselecao.Count > 0) and
     (fMensagem('','Confirma liberação dos pedidos selecionados ?', ['','']) = 1) Then
  Begin
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.strChave := '"Aguarde... Liberando documentos."';
    frmGravando.fExecutarAcao := fLiberaDocumentos;
    frmGravando.ShowModal;
  End
  Else
    pMensagemOk('É preciso selecionar ao menos um documento.');
end;

procedure TfrmLiberacaoTransferenciaArmazem.btnMarcaClick(Sender: TObject);
begin
  If blnProcessando Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  inherited;
  pMarcaTodosDocumentos;
  dbgConsulta.Refresh;
  btnGravar.Enabled := (stlListselecao.Count > 0)

end;

procedure TfrmLiberacaoTransferenciaArmazem.btnMudaOrdemClick(Sender: TObject);
begin
  If blnProcessando Then
    Exit;
  inherited;

end;

procedure TfrmLiberacaoTransferenciaArmazem.btnPesquisarClick(Sender: TObject);
begin
  If blnProcessando Then
    Exit;

  inherited;

end;

procedure TfrmLiberacaoTransferenciaArmazem.dbgConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If key = ' '  Then
    pAddListaQuery
end;

function TfrmLiberacaoTransferenciaArmazem.fApagaReserva(AAutIncMovDet: String): boolean;
var
  strNumdoc,
  strEspdoc,
  strSerie,
  strTipFc,
  strCliFor,
  strCodEmp,
  strChave,
  strAutIncReserva,
  strAutIncDetReserva,
  strDocIte,
  strNumLot: string;
begin
  Result := True;
  Try
    FQryTmp.SQL.Clear;

    FQryTmp.SQL.Add('SELECT * FROM MOVDET');
    FQryTmp.SQL.Add('WHERE AUTOINCREM = "'+AAutIncMovDet+'"');
    FQryTmp.Open;


    strNumdoc := FQryTmp.FieldByName('DET_NUMDOC').AsString;
    strEspdoc := FQryTmp.FieldByName('DET_ESPDOC').AsString;
    strSerie := FQryTmp.FieldByName('DET_SERIE_').AsString;
    strTipFc := FQryTmp.FieldByName('DET_TIP_FC').AsString;
    Case AnsiIndexStr(FQryTmp.FieldByName('DET_TIP_FC').AsString, ['C','F']) Of
      0: strCliFor := FQryTmp.FieldByName('DET_CODCLI').AsString;
      1: strCliFor := FQryTmp.FieldByName('DET_CODFOR').AsString;
    End;

    strCodEmp := FQryTmp.FieldByName('DET_CODEMP').AsString;
    strDocIte := FQryTmp.FieldByName('DET_CODITE').AsString;
    strNumLot := FQryTmp.FieldByName('DET_NUMLOT').AsString;

    strChave := '';
    strChave := strChave + fPadL(strNumDoc , fTamNumDoc);
    strChave := strChave + fPadR(strEspDoc , 02);
    strChave := strChave + fPadR(strSerie , 03);
    strChave := strChave + fPadR(strCodEmp , 03);
    strChave := strChave + fPadR(strCliFor , 08);
    strChave := strChave + fPadR(strTipFc , 01);


    FQryTmp.SQL.Clear;
    If fCfgSis('SPCDEN', varBoolean) Then
    Begin
      FQryTmp.SQL.Add('SELECT FATDOR.AUTOINCREM, FATDOR.FDO_SEQGER FROM EXTGOR');
      FQryTmp.SQL.Add(' INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
      FQryTmp.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
      FQryTmp.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
      FQryTmp.SQL.Add(' WHERE FGO_DCENUM = "'+strNumdoc+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCEESP = "'+strEspdoc+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCESER = "'+strSerie+'"  ');
      FQryTmp.SQL.Add('   AND FGO_DCEEMP = "'+strCodEmp+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCEFOR = "'+strCliFor+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCETFC = "'+strTipFc+'"  ');
      FQryTmp.SQL.Add('   AND FDO_CODITE = "'+strDocIte+'" ');
      FQryTmp.SQL.Add('   AND FDO_NUMLOT = "'+strNumLot+'" ');
      FQryTmp.SQL.Add('   AND FDO_AUTDET = "'+AAutIncMovDet+'" ');
    End
    Else
    begin
      FQryTmp.SQL.Add('SELECT FATDOR.AUTOINCREM, FATDOR.FDO_SEQGER FROM EXTGOR ');
      FQryTmp.SQL.Add(' INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
      FQryTmp.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
      FQryTmp.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');

      FQryTmp.SQL.Add(' WHERE FGO_DOCEND = "'+strChave+'"');
      FQryTmp.SQL.Add('   AND FDO_CODITE = "'+strDocIte+'" ');
      FQryTmp.SQL.Add('   AND FDO_NUMLOT = "'+strNumLot+'" ');
      FQryTmp.SQL.Add('   AND FDO_AUTDET = "'+AAutIncMovDet+'" ');

    End;
    FQryTmp.Open;

    strAutIncDetReserva := FQryTmp.FieldByName('AUTOINCREM').AsString;
    strAutIncReserva := FQryTmp.FieldByName('FDO_SEQGER').AsString;
    FQryTmp.sql.Clear;

    FQryTmp.sql.Add('DELETE FROM FATDOR');
    FQryTmp.sql.Add(' WHERE AUTOINCREM = "'+strAutIncDetReserva+'";');
    FQryTmp.sql.Add('DELETE FROM FATGOR');
    FQryTmp.sql.Add(' WHERE  AUTOINCREM  = "'+strAutIncReserva+'"');
    FQryTmp.sql.Add('   AND (SELECT COUNT(1) FROM FATDOR');
    FQryTmp.sql.Add('         WHERE FDO_SEQGER = "'+strAutIncReserva+'") = 0;');
    FQryTmp.ExecSQL;

    FQryTmp.SQL.Clear;
    FQryTmp.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    FqryTmp.ParamByName('CODITE').AsString := strDocIte;
    FqryTmp.ParamByName('CODEMP').AsString := strCodEmp;
    FQryTmp.ExecSQL;

  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmLiberacaoTransferenciaArmazem.fApagaReserva]');
    End;
  End;
end;

function TfrmLiberacaoTransferenciaArmazem.fCarregaDocumentos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fAbreConsulta;
  dbgConsulta.Columns[0].Width := 65;
  dbgConsulta.Columns[1].Width := 131;
  dbgConsulta.Columns[2].Width := 47;
  dbgConsulta.Columns[3].Width := 209;
  dbgConsulta.Columns[4].Width := 80;
  dbgConsulta.Columns[5].Width := 80;
  dbgConsulta.Columns[6].Width := 64;
  dbgConsulta.Columns[7].Width := 198;
  dbgConsulta.Columns[8].Width := 25;
end;

function TfrmLiberacaoTransferenciaArmazem.fGetOrderBy: String;
begin
  Result := '';
end;

function TfrmLiberacaoTransferenciaArmazem.fGetSql(blnLike: Boolean): String;
begin
  Result := Result + 'SELECT DET_DTAENT,';
  Result := Result + '       D.AUTOINCREM, ';
  Result := Result + '       G.AUTOINCREM AS AUTGER,  ';
  Result := Result + '       ENTRADA.AUTOINCREM AS INCENT, ';
  Result := Result + '       CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NUMDOC,';
  Result := Result + '       D.DET_CODITE,';
  Result := Result + '       DET_DESCRI,';
  Result := Result + '       D.DET_NUMLOT AS ORIGEM,';
  Result := Result + '       CONCAT(D.DET_NUMLOT ," - ", A.AMZ_DESCRI) AS ORIGEM_DESCRI,';
  Result := Result + '       ENTRADA.DET_NUMLOT AS DESTINO,';
  Result := Result + '       CONCAT(ENTRADA.DET_NUMLOT ," - ", ENTRADA.AMZ_DESCRI) AS DESTINO_DESCRI,';
  Result := Result + '       D.DET_QTDITE,';
  Result := Result + '       CONCAT(DET_CODMAR, " - ", MAR_DESMAR) AS MARCA,';
  Result := Result + '       DET_CLAFIS,';
  Result := Result + '       DET_UNIDAD,';
  Result := Result + '       U.UNI_SIGUNI, ';
  Result := Result + '       G.GER_CODDIG,  ';
  Result := Result + '       LOT_LOCFIS LOCDES ';
  Result := Result + '  FROM MOVGER G';
  Result := Result + ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
  Result := Result + '  LEFT JOIN TRAREL ON TRAREL.TRA_SEQGER = G.AUTOINCREM  AND TRAREL.TRA_SEQSAI = D.AUTOINCREM ';
  Result := Result + ' INNER JOIN CADMAR M ON M.MAR_CODMAR = D.DET_CODMAR ';
  Result := Result + '  LEFT JOIN CADUNI U ON U.UNI_CODUNI = D.DET_UNIDAD ';
  Result := Result + '  LEFT JOIN CADAMZ A ON A.AMZ_CODAMZ = D.DET_NUMLOT ';
  Result := Result + '                    AND A.AMZ_CODEMP = D.DET_CODEMP ';
  Result := Result + '  LEFT JOIN (SELECT D2.AUTOINCREM, ';
  Result := Result + '                    D2.DET_NUMLOT, ';
  Result := Result + '                    D2.DET_SEQGER, ';
  Result := Result + '                    D2.DET_CODITE, ';
  Result := Result + '                    A2.AMZ_DESCRI,  ';
  Result := Result + '                    CADLOT.LOT_LOCFIS';
  Result := Result + '               FROM MOVDET D2 ';
  Result := Result + '               LEFT JOIN CADAMZ A2 ON A2.AMZ_CODAMZ = D2.DET_NUMLOT ';
  Result := Result + '                                  AND A2.AMZ_CODEMP = D2.DET_CODEMP ';

  Result := Result + '               LEFT JOIN CADLOT ON LOT_CODEMP = D2.DET_CODEMP AND ';
  Result := Result + '                                   LOT_NUMLOT = D2.DET_NUMLOT AND ';
  Result := Result + '                                   LOT_CODITE = D2.DET_CODITE ';

  Result := Result + '              WHERE LEFT(D2.DET_CLAFIS, 1) < 5) ENTRADA ON ENTRADA.DET_SEQGER = G.AUTOINCREM ';
  Result := Result + '                                                       AND ENTRADA.DET_CODITE = D.DET_CODITE ';
  Result := Result + '                                                       AND IF(IFNULL(TRAREL.TRA_SEQENT, "") <> "", ENTRADA.AUTOINCREM = TRAREL.TRA_SEQENT, TRUE) ';


  Result := Result + ' WHERE DET_ESPDOC = "TA"';

  If fCfgSis('AMZRES', varBoolean) Then
    Result := Result + ' AND IF(IFNULL(A.AMZ_OPERES,"") <> "", A.AMZ_OPERES = "' + strLoginUsuarioLogado + '", TRUE)' ;

  Result := Result + '   AND DET_FILKAR = 1';
  Result := Result + '   AND LEFT(DET_CLAFIS, 1) >= 5';
  Result := Result + '   AND GER_CODEMP = "' + VS_StrCodEmp + '"';

  Result := Result + ' GROUP BY G.AUTOINCREM,';
  Result := Result + '          D.DET_CODITE,';
  Result := Result + '          D.DET_NUMLOT, ';
  Result := Result + '          ENTRADA.DET_NUMLOT';

  Result := Result + ' ORDER BY DET_DTAENT,';
  Result := Result + '       NUMDOC,';
  Result := Result + '       DET_DESCRI';
end;

function TfrmLiberacaoTransferenciaArmazem.fLiberaDocumentos(pgbProgresso: TcxProgressBar): Boolean;
  var i: integer;
begin
  blnProcessando := True;
  pgbProgresso.Properties.Max := stlListselecao.Count;
  cdsConsulta.DisableControls;
  Try
    For i:= 0 To stlListselecao.Count -1 Do
    Begin
      cdsConsulta.Filtered := False;
      cdsConsulta.Filter := 'AUTGER = ' + fQuotedStr(stlListselecao[i]);
      cdsConsulta.Filtered := True;
      If Not cdsConsulta.IsEmpty Then
      Begin
        Try
          fStartTransaction;
          While not cdsConsulta.Eof Do
          begin
            FQryTmp.SQL.Clear;
            FQryTmp.SQL.Add('UPDATE MOVDET');
            FQryTmp.SQL.Add('   SET DET_DTAENT = ' + fCurrentDate + ',');
            FQryTmp.SQL.Add('       DET_FILKAR = 0');
            FQryTmp.SQL.Add(' WHERE AUTOINCREM IN (' + fQuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString) + ',' +
                                                       fQuotedStr(cdsConsulta.FieldByName('INCENT').AsString) + ')');
            FQryTmp.ExecSQL;

            // Movimentar o SALDO ENTRDA
            FCadLot.fAtualizaEstoqueLote(cdsConsulta.FieldByName('DET_CODITE').AsString,
                    'E',
                    cdsConsulta.FieldByName('DESTINO').AsString,
                    cdsConsulta.FieldByName('DET_QTDITE').AsFloat);
            //Movimentar o SALDO SAIDA
            FCadLot.fAtualizaEstoqueLote(cdsConsulta.FieldByName('DET_CODITE').AsString,
                    'S',
                    cdsConsulta.FieldByName('ORIGEM').AsString,
                    cdsConsulta.FieldByName('DET_QTDITE').AsFloat);
            fApagaReserva(cdsConsulta.FieldByName('AUTOINCREM').AsString);

            cdsConsulta.Next;

            {}


          End;

          FQryTmp.SQL.Clear;
          FQryTmp.SQL.Add('UPDATE MOVGER');
          FQryTmp.SQL.Add('   SET GER_DTAENT = ' + fCurrentDate);
          FQryTmp.SQL.Add(' WHERE AUTOINCREM  = ' + fQuotedStr(cdsConsulta.FieldByName('AUTGER').AsString));
          FQryTmp.ExecSQL;

          fCommit;




        Except
          on E:Exception do
          Begin
            fRollback;
            pMensagensErro(E.Message, '[fLiberaDocumentos]');
          end;
        End;
      End;
      pStepStatusGravacao(pgbProgresso);
    End;
  Finally
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.EnableControls;
  End;
  Result := True;
  stlListselecao.Clear;
  pCarregaDocumentos;
  blnProcessando := False;
end;

procedure TfrmLiberacaoTransferenciaArmazem.pAddListaQuery;
begin
  If Not fInLista Then
    If (Not fValidaSaldoDisponivel) Then
      Exit;

    inherited;
    dbgConsulta.Refresh;
    btnGravar.Enabled := (stlListselecao.Count > 0)
end;

procedure TfrmLiberacaoTransferenciaArmazem.pMarcaTodosDocumentos;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.strChave := '"Aguarde... Marcando todos documentos."';
  frmGravando.fExecutarAcao := fMarcaDocumentos;
  frmGravando.Showmodal;
end;

procedure TfrmLiberacaoTransferenciaArmazem.tmrAtualizaConsultaTimer(
  Sender: TObject);
begin
  inherited;
  btnAtualizar.OnClick(Nil);
end;

function TfrmLiberacaoTransferenciaArmazem.fMarcaDocumentos(
  pgbProgresso: TcxProgressBar): Boolean;
  var intIndex: integer;
begin

  cdsConsulta.First;
  pgbProgresso.Properties.Max := cdsConsulta.RecordCount;
  While Not cdsConsulta.Eof Do
  Begin
    stlListselecao.Sort;
    intIndex := 0;
    If not stlListselecao.Find(cdsConsulta.FieldByName('AUTGER').AsString, intIndex) Then
    Begin
      If fValidaSaldoDisponivel(False) Then      
        stlListselecao.Add(cdsConsulta.FieldByName('AUTGER').AsString);
    End;
    pStepStatusGravacao(pgbProgresso);
    cdsConsulta.Next;
  End;
  cdsConsulta.First;
  Result := True;
end;

procedure TfrmLiberacaoTransferenciaArmazem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tmrAtualizaConsulta.Enabled:= False;
end;

procedure TfrmLiberacaoTransferenciaArmazem.FormCreate(Sender: TObject);
begin
  inherited;
  blnProcessando := False;
  FQryTmp := fCriaQuery(nil);
  FCadLot := TCadLot.Create(Nil);
  cdsBackup := TUniClientDataSet.Create(Nil);
  tmrAtualizaConsulta.Enabled:= True;
  blnQuoteLista := False;
end;

procedure TfrmLiberacaoTransferenciaArmazem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryTmp);
  FreeAndNil(FCadLot);
  FreeAndNil(cdsBackup);
end;

procedure TfrmLiberacaoTransferenciaArmazem.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Inherited;
  Case Key Of
    VK_F8 : btnDesmarcaClick(btnDesmarca);
    VK_F7 : btnMarcaClick(btnMarca);
    VK_F10: btnGravarClick(btnGravar);
    VK_F11: btnAtualizarClick(btnAtualizar);
  End
end;

procedure TfrmLiberacaoTransferenciaArmazem.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;

  pCarregaDocumentos;
  strCampoLista := 'AUTGER';

  stlListselecao.Sorted := True;
  stlListselecao.Duplicates := dupIgnore;
end;

function TfrmLiberacaoTransferenciaArmazem.fQuantidadeUsada(
  strCodIte, strArmaze: String): Double;
Var
  intRecNo: Integer;
  blnBkpFiltered: Boolean;
  strBkpString: String;
begin
  Result := 0.0;

  If Not stlListSelecao.Count > 0 Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  cdsConsulta.DisableControls;
  intRecNo := cdsConsulta.recNo;
  blnBkpFiltered := False;
  If cdsConsulta.Filtered Then
  Begin
    strBkpString := '';
    blnBkpFiltered := True;
    strBkpString := cdsConsulta.Filter;
  End;

  Try
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter  := 'ORIGEM = ' + QuotedStr(strArmaze) + ' AND DET_CODITE = ' + QuotedStr(strCodIte);
    cdsConsulta.Filtered := True;
    cdsConsulta.First;
    While Not cdsConsulta.eof Do
    begin
      If fInLista And SameText(cdsConsulta.FieldByName('DET_CODITE').AsString, strCodIte) Then
        Result := Result +  cdsConsulta.FieldByName('DET_QTDITE').AsFloat;
      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Filtered := False;

    If blnBkpFiltered Then
    Begin
      cdsConsulta.Filter := strBkpString;
      cdsConsulta.Filtered := True;
    End;

    cdsConsulta.recNo := intRecNo;

    cdsConsulta.EnableControls;
  End;
end;

function TfrmLiberacaoTransferenciaArmazem.fValidaSaldoDisponivel(blnMostraMensagem: Boolean = True): Boolean;
Var
  fltQtdUsada,
  fltQtdDisponivel,
  fltQtdTransferir: Double;
begin
  Result := True;
  fltQtdTransferir := 0;

  If cdsConsulta.isEmpty Then
    Exit;

  fltQtdUsada := fQuantidadeUsada(cdsConsulta.FieldByName('DET_CODITE').AsString,cdsConsulta.FieldByName('ORIGEM').AsString);
  fltQtdDisponivel := fRetornaSaldoDisponivel(cdsConsulta.FieldByName('DET_CODITE').AsString, False, True, cdsConsulta.FieldByName('ORIGEM').AsString);
  {Se estiver habilitado a configuração TRAMZ2, o saldo disponivel já está com o saldo reservado do pedido}
  If Not fCfgSis('TRAMZ2', varBoolean) Then
    fltQtdTransferir := cdsConsulta.FieldByName('DET_QTDITE').AsFloat;

  If ((fltQtdDisponivel - fltQtdTransferir - fltQtdUsada) < 0) Then
  Begin
    if blnMostraMensagem Then
      pMensagemOk('Não há saldo suficiente para essa transferência!');
    Result := False;
  End;
end;

procedure TfrmLiberacaoTransferenciaArmazem.pCarregaDocumentos;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.strChave := '"Aguarde... Carregando documentos."';
  frmGravando.fExecutarAcao := fCarregaDocumentos;
  frmGravando.Showmodal;
End;

end.
