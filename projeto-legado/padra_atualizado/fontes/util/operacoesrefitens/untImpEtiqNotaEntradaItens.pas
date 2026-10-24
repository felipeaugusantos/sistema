unit untImpEtiqNotaEntradaItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, untFuncoesEtiquetas,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, TypesRel, untTypesSistema,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,
  MemDS, DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, StrUtils;

type
  TfrmImpEtiqNotaEntradaItens = class(TfrmPaiOrdena)
    btnImprime: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    pnlLegenda: TPanel;
    lbl3: TLabel;
    shp2: TShape;
    shp3: TShape;
    lbl4: TLabel;
    lblDefinitQtde: TLabel;
    lblDefinirQuantidadeOriginal: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure lblDefinitQtdeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure lblDefinirQuantidadeOriginalClick(Sender: TObject);
  private
    { Private declarations }
    blnOrigemPedidoCompra: Boolean;
    procedure pImprimeEtiquetas;
    procedure pChecaItensPromocao;
    procedure pMarcarItensPromocao(strMarcarPromocao :String);
    function fApenasItensPromocaoSelecionados :Boolean;
    function fObtemCamposOrigemEGrupo: string;
    function fObtemLeftJoinCADITE: string;
    function fObtemUnionSelectParaApresentarItensDoGrupo: string;
    procedure pApresentarColunasGrupoEOrigem;
    function fGetListaGrupoPreco: string;
    const COLUNA_GRUPO = 6;
    const COLUNA_ORIGEM = 7;
  public
    { Public declarations }
    strSeqGer: String;
    blnImpNot,
    blnNaoMudouAOrdem: Boolean;
    blnProdInativo,
    blnImpGrp,
    blnImpFornNota: Boolean;
    function fFiltraSQL(blnLike: Boolean): String; override;
    procedure pAjustaPedido;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetOrderBy: String; Override;
  end;

var
  frmImpEtiqNotaEntradaItens: TfrmImpEtiqNotaEntradaItens;

implementation

uses untFuncoesSimples, untConstantes, untFuncoesRel,
     untFuncoesEtiqItens, untCadPro;

{$R *.dfm}

procedure TfrmImpEtiqNotaEntradaItens.FormCreate(Sender: TObject);
begin
  inherited;
  blnNaoMudouAOrdem := False;
  blnQuoteLista := False;
  blnImpNot     := False;
  dbgConsulta.Options := dbgConsulta.Options + [dgEditing];
  fFindColumnByName(dbgConsulta, 'QTDITE').ReadOnly := False;
  blnNaoMudouAOrdem := false;
  blnImpGrp := False;
  blnProdInativo := True;
end;

procedure TfrmImpEtiqNotaEntradaItens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of

    VK_F10:    btnImprime.Click;
    VK_F7:     btnMarca.Click;
    VK_F8:     btnDesmarca.Click;
    VK_F3:     btnMudaOrdem.Click;
    VK_F4:     lblDefinitQtde.OnClick(Self);
    VK_F6:     lblDefinirQuantidadeOriginal.OnClick(Self);

    VK_ESCAPE: If pnlPesquisa.Visible Then
                 inherited
               Else
                 Close;

    Else       inherited;

  End;

end;

procedure TfrmImpEtiqNotaEntradaItens.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.ClientWidth - btnSair.Width - 3;
end;

procedure TfrmImpEtiqNotaEntradaItens.pApresentarColunasGrupoEOrigem;
begin
  dbgConsulta.Columns[COLUNA_GRUPO].Visible := blnImpGrp;
  dbgConsulta.Columns[COLUNA_ORIGEM].Visible := blnImpGrp;
end;

procedure TfrmImpEtiqNotaEntradaItens.FormShow(Sender: TObject);
begin
  inherited;

  blnSelecionaComEnter   := True;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pApresentarColunasGrupoEOrigem;
  fAbreConsulta;

  pChecaItensPromocao;

  pMarcaTodos;
end;

procedure TfrmImpEtiqNotaEntradaItens.lblDefinirQuantidadeOriginalClick(
  Sender: TObject);
begin
  inherited;
  With cdsConsulta Do
  Begin
    First;
    While Not EOF Do
    Begin
      Edit;
      FieldByName('QTDITE').AsFloat := FieldByName('QTDITE_ORI').AsFloat;
      Post;
      Next;
    End;
  End;

end;

procedure TfrmImpEtiqNotaEntradaItens.lblDefinitQtdeClick(Sender: TObject);
begin
  inherited;
  With cdsConsulta Do
  Begin
    First;
    While Not EOF Do
    Begin
      Edit;
      FieldByName('QTDITE').AsFloat := 1;
      Post;
      Next;
    End;
  End;
end;

procedure TfrmImpEtiqNotaEntradaItens.btnMarDesClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
  dbgConsulta.Repaint;
end;

procedure TfrmImpEtiqNotaEntradaItens.btnMudaOrdemClick(Sender: TObject);
begin
  blnNaoMudouAOrdem := true;
  cdsConsulta.IndexFieldNames := '';
  inherited;

end;

procedure TfrmImpEtiqNotaEntradaItens.dbgConsultaDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If cdsConsulta.FieldByName('PROMOC').AsString = 'S' Then
  Begin
    dbgConsulta.Canvas.Font.Style := [fsBold];
    dbgConsulta.Canvas.Font.Color := clGreen;
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmImpEtiqNotaEntradaItens.btnDesmarcaClick(Sender: TObject);
begin
  inherited;

  pDesmarcaTodos;
end;

procedure TfrmImpEtiqNotaEntradaItens.btnImprimeClick(Sender: TObject);
begin
  inherited;

  pImprimeEtiquetas;
end;

procedure TfrmImpEtiqNotaEntradaItens.btnMarcaClick(Sender: TObject);
var
  ArrNomEti: TStringArray;
  intOpcao :Integer;
begin
  inherited;

  SetLength(ArrNomEti, 0);
  pAddDados(ArrNomEti, 'Selecionar todos');
  pAddDados(ArrNomEti, 'Produtos em promoção');
  pAddDados(ArrNomEti, 'Produtos fora da promoção');
  intOpcao := fGetMenu('Escolha a seleção:', ArrNomEti, 1);

  Case intOpcao Of
    1: pMarcaTodos;
    2: pMarcarItensPromocao('S');
    3: pMarcarItensPromocao('N');
  Else
    Exit;
  End;
end;

procedure TfrmImpEtiqNotaEntradaItens.pAjustaPedido;
begin
  dbgConsulta.Columns[0].FieldName := 'CODITE';
  dbgConsulta.Columns[1].FieldName := 'DESITE';
  dbgConsulta.Columns[2].FieldName := 'REFERE';
  dbgConsulta.Columns[3].FieldName := 'SIGUNI';
  dbgConsulta.Columns[4].FieldName := 'QTDITE';
  dbgConsulta.Columns[5].FieldName := 'PROMOC';

  dbgConsulta.Columns[0].Title.Caption := 'Código';
  dbgConsulta.Columns[1].Title.Caption := 'Descrição';
  dbgConsulta.Columns[2].Title.Caption := 'Referência';
  dbgConsulta.Columns[3].Title.Caption := 'Unidade';
  dbgConsulta.Columns[4].Title.Caption := 'Quantidade';
  dbgConsulta.Columns[5].Title.Caption := 'Promoc.';

  lblDefinirQuantidadeOriginal.Visible := True;

  blnOrigemPedidoCompra := true;
end;

function TfrmImpEtiqNotaEntradaItens.fApenasItensPromocaoSelecionados: Boolean;
begin
  With cdsConsulta Do
  Begin
    DisableControls;
    First;

    Result := (cdsConsulta.RecordCount > 0);

    While Not Eof Do
    Begin
      If stlListSelecao.IndexOf(FieldByName('AUTOINCREM').Text) <> -1 Then
        Result := (Result) And (FieldByName('PROMOC').AsString = 'S');

      Next;
    End;

    EnableControls;
  End;
end;

function TfrmImpEtiqNotaEntradaItens.fFiltraSQL(blnLike: Boolean): String;
var strSQL: string;
    strCampo: String;
begin
  strSQL := '';
  With qryConsulta, Sql Do
  Try
    Try
      If lflLastField.intIndCol <> -1 Then
      Begin

        If blnLike Then
        Begin
          If lflLastField.strNomCam = 'PROMOC' Then
          begin
            strSQL := strSQL + ' AND :CODPES = :CODPES ';
            Exit;
          End;

          If lflLastField.strNomCam  = 'NUMDOC' Then
            strCampo := 'DET_NUMDOC'
          Else If lflLastField.strNomCam  = 'CODITE' Then
            strCampo := 'DET_CODITE'
          Else If lflLastField.strNomCam  = 'DESITE' Then
            strCampo := 'DET_DESCRI'
          Else If lflLastField.strNomCam  = 'REFERE' Then
            strCampo := 'DET_REFERE'
          Else If lflLastField.strNomCam  = 'SIGUNI' Then
            strCampo := 'UNI_SIGUNI';

          Case lflLastField.ftyTipCam Of
            ftDate,
            ftDateTime : strSQL := strSQL + ' AND ' + fAsDate(strCampo,edtData.Text);

            ftString,
            ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                            strSQL := strSQL + ' AND ' + strCampo +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';

            ftInteger,
            ftLargeInt,
            ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                            strSQL := strSQL + ' AND ' + strCampo +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';

            ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                            strSQL := strSQL + ' AND ' + strCampo +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';
          End;
        End;

      End;
    Finally
      Result := strSQL;
    End;
  Except
    Result := '';
  End;

end;

function TfrmImpEtiqNotaEntradaItens.fObtemCamposOrigemEGrupo: string;
begin
  Result := EmptyStr;
  if blnImpGrp then
    Result := ', C.ITE_CODGPR AS GRUPO, "Nota" as ORIGEM ';
end;

function TfrmImpEtiqNotaEntradaItens.fObtemLeftJoinCADITE: string;
begin
  Result := EmptyStr;
  if blnImpGrp then
    Result := ' LEFT JOIN CADITE C ON C.ITE_CODITE = DET_CODITE ';
end;

function TfrmImpEtiqNotaEntradaItens.fObtemUnionSelectParaApresentarItensDoGrupo: string;
begin
  if not blnImpGrp then
    Exit(EmptyStr);

  Result := '  ';
  Result := Result + ' UNION ALL ';
  Result := Result + '  ';
  Result := Result + ' SELECT ';
  Result := Result + '  C.AUTOINCREM, ';
  Result := Result + '  "" AS NUMDOC, ';
  Result := Result + '  C.ITE_CODITE AS CODITE, ';
  Result := Result + '  C.ITE_DESITE AS DESITE, ';
  Result := Result + '  C.ITE_REFERE AS REFERE, ';
  Result := Result + '  UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '  ITE_LOCFIS AS LOCFIS,  ';
  Result := Result + '  "N" AS PROMOC, ';
  Result := Result + '  1 AS QTDITE,  ';
  Result := Result + '  C.ITE_CODGPR AS GRUPO,  ';
  Result := Result + '  "Grupo de preço" AS ORIGEM ';
  Result := Result + ' FROM CADITE C ';
  Result := Result + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + ' LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = C.ITE_CODITE AND ITEGER.ITE_CODEMP = C.ITE_CODEMP ';
  Result := Result + ' WHERE ';
  Result := Result + '   C.ITE_CODITE NOT IN (SELECT DET_CODITE AS CODITE ';
  Result := Result + '                      FROM MOVDET D ';
  Result := Result + '                      WHERE DET_SEQGER = ' + QuotedStr(strSeqGer) + ')';
  Result := Result + '   AND ';
  Result := Result + '   C.ITE_CODGPR IN (SELECT DISTINCT ITE_CODGPR ';
  Result := Result + '                      FROM MOVDET D ';
  Result := Result + '                      INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ';
  Result := Result + '                      WHERE DET_SEQGER = ' + QuotedStr(strSeqGer) + ')';
  Result := Result + IfThen(blnProdInativo, '', ' AND C.ITE_ITEATI = ''S''');
end;

function TfrmImpEtiqNotaEntradaItens.fGetOrderBy: String;
begin
  If blnImpGrp Then
  begin
    Result := ' ORDER BY NUMDOC DESC, GRUPO, CODITE';
    Exit;
  End;

  Result := inherited;
end;

function TfrmImpEtiqNotaEntradaItens.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  If blnOrigemPedidoCompra Then
  Begin
    strSQL := strSQL + 'SELECT D.AUTOINCREM,  ';
    strSQL := strSQL + '       PCD_NUMPED AS NUMDOC,  ';
    strSQL := strSQL + '       PCD_CODITE AS CODITE,  ';
    strSQL := strSQL + '       PCD_DESITE AS DESITE,  ';
    strSQL := strSQL + '       ITE_REFERE AS REFERE,  ';
    strSQL := strSQL + '       UNI_SIGUNI AS SIGUNI,  ';
    strSQL := strSQL + '       ITE_LOCFIS AS LOCFIS,  ';
    strSQL := strSQL + '       "N" AS PROMOC,  ';
    strSQL := strSQL + '       PCD_QTDITE  AS QTDITE_ORI,  ';
    strSQL := strSQL + '       PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) AS QTDITE  ';
    strSQL := strSQL + '  FROM PCMGER G  ';
    strSQL := strSQL + ' INNER JOIN PCMDET D ON D.PCD_NUMPED = G.PCG_NUMPED  ';
    strSQL := strSQL + '                    AND D.PCD_ESPDOC = G.PCG_ESPDOC  ';
    strSQL := strSQL + '                    AND D.PCD_CODEMP = G.PCG_CODEMP  ';
    strSQL := strSQL + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = PCD_CODITE  ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = PCD_CODUNI  ';
    strSQL := strSQL + '  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = CADITE.ITE_CODEMP ';
    strSQL := strSQL + ' WHERE G.AUTOINCREM = "'+strSeqGer+'"';
  End
  Else
  Begin
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  D.AUTOINCREM, ';
    strSQL := strSQL + '  DET_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  DET_CODITE AS CODITE, ';
    strSQL := strSQL + '  DET_DESCRI AS DESITE, ';
    strSQL := strSQL + '  DET_REFERE AS REFERE, ';
    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '  ITE_LOCFIS AS LOCFIS,  ';
    strSQL := strSQL + '  "N" AS PROMOC, ';
    strSQL := strSQL + '  DET_QTDITE AS QTDITE  ';
    strSQL := strSQL + fObtemCamposOrigemEGrupo;
    strSQL := strSQL + ' FROM MOVDET D ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';
    strSQL := strSQL + '  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ITEGER.ITE_CODEMP = D.DET_CODEMP ';
    strSQL := strSQL + fObtemLeftJoinCADITE;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_SEQGER = ' + QuotedStr(strSeqGer);
    strSQL := strSQL + fObtemUnionSelectParaApresentarItensDoGrupo;
  End;

  Result := strSQL;
End;

procedure TfrmImpEtiqNotaEntradaItens.pChecaItensPromocao;
begin
  with cdsConsulta do
  begin
    DisableControls;
    First;

    while not Eof do
    begin
      If not(fItemSemNenhumaPromocao(FieldByName('CODITE').Text, VS_strCodEmp)) Then
      Begin
        Edit;
        FieldByName('PROMOC').AsString := 'S';
        Post;
      End;

      Next;
    end;

    dbgConsulta.Repaint;
    EnableControls;
  End;
end;

function TfrmImpEtiqNotaEntradaItens.fGetListaGrupoPreco: string;
var
  stlLista: TStringList;
  strChave: string;
begin
  if not Self.blnImpGrp then
    Exit(EmptyStr);

  cdsConsulta.DisableControls;
  stlLista := TStringList.Create;
  try
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      if cdsConsulta.FieldByName('NUMDOC').AsString.Trim.IsEmpty and
        (blnTemSelecao Or (Assigned(stlListSelecao) And (stlListSelecao.Count > 0))) And fInLista Then
      begin
        If blnQuoteLista Then
          strChave  := '''' + cdsConsulta.Fieldbyname('CODITE').AsString + ''''
        Else
          strChave  := cdsConsulta.Fieldbyname('CODITE').AsString;

        stlLista.Add(strChave);
      end;
      cdsConsulta.Next;
    end;

    Result := fCommaText(stlLista, True);
  finally
    stlLista.DisposeOf;
  end;
  cdsConsulta.EnableControls;
end;

procedure TfrmImpEtiqNotaEntradaItens.pImprimeEtiquetas;
  Var
    prmDllEtq: TParamDllEtiquetas;
    tpeEtique: TTipoEtiqueta;
    blnPromoc: Boolean;
    blnPrePro: Boolean;
    strDesEti: string;
    intTabPre: Integer;
    strCodCnd: string;
    strCndPag: string;
    strNumPar: string;
begin
  If stlListSelecao.Count = 0 Then
  Begin
    pMensagemOk('Selecione os registros para impressão!');
    Exit;
  End;

  blnPromoc := False;
  blnPrePro := fApenasItensPromocaoSelecionados;

  intTabPre := 1;
  If Not fEscolheTipoEtiqueta(tpeEtique,
                              False,
                              blnPromoc,
                              intTabPre,
                              strCodCnd,
                              strCndPag,
                              strNumPar,
                              strDesEti,
                              blnPrePro) Then
   Exit;

  prmDllEtq := TParamDllEtiquetas.Create;
  prmDllEtq.tpeTipEtq := tpeEtique;
  prmDllEtq.intTabPre := intTabPre;
  prmDllEtq.blnPromoc := blnPromoc;
  prmDllEtq.strLisReg := fCommaText(stlListSelecao, True);
  prmDllEtq.strTabela := IIf(blnOrigemPedidoCompra, 'PCMDET', 'MOVDET');
  prmDllEtq.dtsImpres := cdsConsulta;
  prmDllEtq.stlPromoc := Nil;
  prmDllEtq.cdsPromoc := Nil;
  prmDllEtq.strPerDes := '0';
  prmDllEtq.blnPrePro := blnPrePro;
  prmDllEtq.strNomFrm := Self.Name;
  prmDllEtq.blnImpNot := blnImpNot;
  prmDllEtq.blnEtiNFe := true;
  prmDllEtq.blnImpGrp := Self.blnImpGrp;
  prmDllEtq.strLisGrpPre := fGetListaGrupoPreco;
  if (blnNaoMudouAOrdem) then
    prmDllEtq.strIdxFld := lflLastField.strNomCam;

  fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetaitens');

  FreeAndNil(prmDllEtq);


  cdsConsulta.Filtered := false;

End;

procedure TfrmImpEtiqNotaEntradaItens.pMarcarItensPromocao(strMarcarPromocao :String);
begin
  If Not cdsConsulta.Active Then
    Exit;

  stlListSelecao.Clear;

  With cdsConsulta Do
  Begin

    DisableControls;
    First;

    While Not Eof Do
    Begin
      If FieldByName('PROMOC').AsString = strMarcarPromocao Then
        pAddListaQuery;

      Next;
    End;

    EnableControls;

  End;

  dbgConsulta.Repaint;
end;

end.

