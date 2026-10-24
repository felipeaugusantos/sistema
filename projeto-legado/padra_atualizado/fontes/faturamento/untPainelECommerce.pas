unit untPainelECommerce;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, ComboBoxFocus, Mask, MaskEditFocus, Grids, DBGrids, untZClient,
  DB, DBClient, ImgList, Uni, cxProgressBar, System.ImageList, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, DBGridCitel;

type
  THackDBGrid = class(TDBGrid);
  
  TfrmPainelECommerce = class(TfrmPai)
    pnlFiltros: TPanel;
    cmbForPgt: TComboBoxFocus;
    cmbStatus: TComboBoxFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnAtualizar: TBitBtnLocked;
    dbgDados: TDBGridCitel;
    imgLista: TImageList;
    imgSemLib: TImage;
    imgLibCom: TImage;
    imgLibera: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    btnConfirma: TBitBtnLocked;
    btnItensPend: TBitBtnLocked;
    imgSep: TImage;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDadosCellClick(Column: TColumn);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnItensPendClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    cdsPedidos : TZClient;

    function fGetSql : String;

    procedure pOnGetTextStatus(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pOnGetTextFormaPgto(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pMarcar(intOpcao: Integer);
    function fLiberaPedidos(Progresso: TcxProgressBar): Boolean;
    procedure pImprimeSeparacao(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; intQtdImp: Integer);

  public
    { Public declarations }
  end;

implementation

uses untTypesPainel, untFuncoesSimples, untGravando,
  untMovGer, untMostraItensPendentes, untFuncoesRel, untFuncoesRel2,
  untFatImpressao;

{$R *.dfm}

procedure TfrmPainelECommerce.btnAtualizarClick(Sender: TObject);
  Var
    objField : TStringField;
begin
  inherited;
  cdsPedidos.Close;
  With cdsPedidos.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add( fGetSql );
    If (not fEmptyDate(mskDtaIni.Text)) And (Not fEmptyDate(mskDtaFin.Text) ) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

  End;

  cdsPedidos.fAbreClient(True, 'TfrmPainelECommerce.btnAtualizarClick');

  Try
    cdsPedidos.DisableControls;
    cdsPedidos.First;
    While Not cdsPedidos.Eof Do
    Begin
      if (cdsPedidos.FieldByName('LIBERA').AsInteger > 0) And
         (cdsPedidos.FieldByName('LIBCOM').AsInteger > 0) Then
      Begin
        cdsPedidos.Edit;
        cdsPedidos.FieldByName('MARCA').AsInteger :=  1;
        cdsPedidos.Post;
      End;
      cdsPedidos.Next;
    End;
  Finally
    cdsPedidos.First;  
    cdsPedidos.EnableControls;
  End;

  TFloatField(cdsPedidos.FieldByName('TOTPRO')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

  If cdsPedidos.FindField('STATUS') = Nil Then
  Begin
    objField := TStringField.Create(cdsPedidos);
    objField.FieldKind := fkCalculated;
    objField.FieldName := 'STATUS';
    objField.Name      := 'cdsPedidosSTATUS';
    objField.Size      := 50;
    objField.OnGetText := pOnGetTextStatus;
    cdsPedidos.Fields.Add(objField);
  End;  

  If cdsPedidos.FindField('FORMA') = Nil Then
  Begin
    objField := TStringField.Create(cdsPedidos);
    objField.FieldKind := fkCalculated;
    objField.FieldName := 'FORMA';
    objField.Name      := 'cdsPedidosFORMA';
    objField.Size      := 50;
    objField.OnGetText := pOnGetTextFormaPgto;
    cdsPedidos.Fields.Add(objField);
  End;

  pSetFocus(dbgDados);

end;

function TfrmPainelECommerce.fLiberaPedidos(Progresso : TcxProgressBar) : Boolean;
  Var
    qryUpdate : TUniQuery;
    intQtdImp : Integer;
    blnLiberou: Boolean;
Begin
  qryUpdate := fCriaQuery(Self);
  Try
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE FATGOR SET         ');
      Add(' FGO_LIBCOM = :LIBCOM,     ');
      Add(' FGO_OPELIC = :OPELIC,     ');
      Add(' FGO_DIGLIC = :DIGLIC,     ');
      Add(' FGO_HORLIC = :HORLIC,     ');
      Add(' FGO_DTALIC = :DTALIC      ');
      Add(' WHERE AUTOINCREM = :AUTINC');
    End;

    intQtdImp := 1;
    If (fCfgSis('VIA_SE') = 'S') Then
    Begin
      intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir','1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
      If intQtdImp = 1 Then
        intQtdImp := -1
      Else
        intQtdImp := intQtdImp - 1;
    End
    Else
    Begin
      If fCfgSis('QTDVSE') > 1 Then
        intQtdImp := fCfgSis('QTDVSE');
    End;

    With cdsPedidos Do
    Begin
      DisableControls;
      Filter   := 'MARCA = 1';
      Filtered := True;

      Progresso.Properties.Max := RecordCount;
      Progresso.Position := 0;

      First;
      While not Eof Do
      Begin
        blnLiberou := False;
        If FieldByName('LIBCOM').AsInteger <= 0 Then
        Begin
          qryUpdate.ParamByName('LIBCOM').AsInteger  := 1;
          qryUpdate.ParamByName('OPELIC').AsString   := strLoginUsuarioLogado;
          qryUpdate.ParamByName('DIGLIC').AsString   := strLoginUsuarioLogado;
          qryUpdate.ParamByName('HORLIC').AsDateTime := fNow;
          qryUpdate.ParamByName('DTALIC').AsDateTime := fNow;
          qryUpdate.ParamByName('AUTINC').AsString   := FieldByName('AUTINC').AsString;
          qryUpdate.ExecSQL;
          blnLiberou := True;
        End;

        if (cdsPedidos.FieldByName('LIBERA').AsInteger > 0) And
           (blnLiberou Or (cdsPedidos.FieldByName('LIBCOM').AsInteger > 0)) Then
          pImprimeSeparacao(FieldByName('DOCMAT').AsString, FieldByName('ESPMAT').AsString, FieldByName('EMPMAT').AsString, FieldByName('CLIMAT').AsString, intQtdImp);

        Next;
        Progresso.Position := Progresso.Position + 1;
      End;
      pSetFocus(cmbForPgt);
    End;
    cdsPedidos.Close;
    Result := True;
  Finally
    cdsPedidos.EnableControls;
    FreeAndNil(qryUpdate);
    cdsPedidos.Filtered := False;
    cdsPedidos.Filter   := '';
  End;

End;

procedure TfrmPainelECommerce.pImprimeSeparacao(strNumDoc, strEspDoc, strCodEmp, strCodCli : String; intQtdImp: Integer);
  Var
    strNomeArquivo : String;
begin
  Try
    If intQtdImp > 0 Then
    Begin
      pImprimeFatImp('FATDOR',
                     strNumDoc,
                     strEspDoc,
                     strCodEmp,
                     strCodCli,
                     'C',
                     'V',
                     False,
                     strNomeArquivo,
                     False,
                     'I',
                     intQtdImp,
                     impSemPrecoGeral,
                     0,
                     True,
                     False,
                     True,
                     False,
                     '',
                     '',
                     False,
                     False,
                     False,
                     False);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeSeparacao]');
    End;
  End;
end;

procedure TfrmPainelECommerce.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if cdsPedidos.Active And (cdsPedidos.RecordCount > 0) Then
  Begin
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fLiberaPedidos;
    frmGravando.ShowModal;
    FreeAndNil(frmGravando);
  End;  
end;

procedure TfrmPainelECommerce.btnItensPendClick(Sender: TObject);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FDO_CODITE AS PCD_CODITE, ');
  qryAux.SQL.Add('  FDO_DESCRI AS PCD_DESITE, ');
  qryAux.SQL.Add('  UNI_SIGUNI AS UNI_SIGUNI, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDITE, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDITE, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDBAI, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDBAI, ');
  qryAux.SQL.Add('  FORMAT(IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI), 2) AS PCD_QTDRES, ');
  qryAux.SQL.Add('  CAST("" AS CHAR(1)) AS DOCENT, ');
  qryAux.SQL.Add('  FDO_QTDBAI  AS PCD_QTDBAI_NO_FORMAT, ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) AS PCD_QTDRES_NO_FORMAT ');


  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FATDOR ');
  qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = FDO_CODITE ');
  qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) > 0 ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  FDO_DESCRI ');

  qryAux.ParamByName('NUMDOC').AsString := cdsPedidos.FieldByName('DOCMAT').AsString;
  qryAux.ParamByName('ESPDOC').AsString := 'PD';
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryAux.Open;

  Try
    pCriarFormularios(TfrmMostraItensPendentes, frmMostraItensPendentes);
    frmMostraItensPendentes.dtsPedido.DataSet := qryAux;
    frmMostraItensPendentes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmConsultaFatPedOrc.pMostraItensPendentes]');
  End;

  pFreeAndNil(frmMostraItensPendentes);
  qryAux.Close;
  FreeAndNil(qryAux);

end;

procedure TfrmPainelECommerce.dbgDadosCellClick(Column: TColumn);
begin
  inherited;
  If Column.Field.FieldName = 'MARCA' Then
    pMarcar(2);
end;

procedure TfrmPainelECommerce.pMarcar(intOpcao: Integer);
begin
  If (not cdsPedidos.Active) Or (cdsPedidos.RecordCount <= 0) then
    Exit;
    
  cdsPedidos.Edit;
  Case intOpcao Of
    0,
    1 : cdsPedidos.FieldByName('MARCA').AsInteger := intOpcao;
    2 : cdsPedidos.FieldByName('MARCA').AsInteger := IIF( cdsPedidos.FieldByName('MARCA').AsInteger = 0, 1, 0);
  End;
  cdsPedidos.Post;
end;


procedure TfrmPainelECommerce.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGrid(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    if SameText(Column.Field.FieldName, 'MARCA') then
    Begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left+1, Rect.Top, 0);
      If (Column.Field.AsInteger = 1) then
        imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left+1, Rect.Top+1, 1)
      Else
        imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left+1, Rect.Top+1, 2);
    End;

    if SameText(Column.Field.FieldName, 'LIBERA') then
    Begin
      Canvas.Rectangle(Rect);

      if (cdsPedidos.FieldByName('LIBERA').AsInteger > 0) And
         (cdsPedidos.FieldByName('LIBCOM').AsInteger > 0) Then
        Canvas.Draw(Rect.Left+1, Rect.Top+1, imgSep.Picture.Graphic)
      Else
      if cdsPedidos.FieldByName('LIBERA').AsInteger > 0 Then
        Canvas.Draw(Rect.Left+1, Rect.Top+1, imgLibera.Picture.Graphic)
      Else if cdsPedidos.FieldByName('LIBCOM').AsInteger > 0 Then
        Canvas.Draw(Rect.Left+1, Rect.Top+1, imgLibCom.Picture.Graphic)
      Else
        Canvas.Draw(Rect.Left+1, Rect.Top+1, imgSemLib.Picture.Graphic);
    end;

  End;

end;

procedure TfrmPainelECommerce.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in [VK_RETURN, VK_SPACE] Then
    pMarcar(2);
end;

function TfrmPainelECommerce.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT G1.AUTOINCREM AS AUTINC,                                       ';
  Result := Result + '        G1.FGO_NUMDOC AS DOCMAT,                                       ';
  Result := Result + '        G1.FGO_ESPDOC AS ESPMAT,                                       ';
  Result := Result + '        G1.FGO_CODEMP AS EMPMAT,                                       ';
  Result := Result + '        G1.FGO_CODCLI AS CLIMAT,                                       ';
  Result := Result + '        G2.FGO_NUMDOC AS DOCFIL,                                       ';
  Result := Result + '        CLI_NOMCLI    AS NOMCLI,                                       ';
  Result := Result + '        G2.FGO_STASIT AS STASIT,                                       ';
  Result := Result + '        G2.FGO_FPGSIT AS FPGSIT,                                       ';
  Result := Result + '        G2.FGO_PEDSIT AS PEDSIT,                                       ';
  Result := Result + '        G2.FGO_TOTPRO AS TOTPRO,                                       ';
  Result := Result + '        G2.FGO_VLRCON AS VLRCON,                                       ';
  Result := Result + '        G1.FGO_LIBERA AS LIBERA,                                       ';
  Result := Result + '        G1.FGO_LIBCOM AS LIBCOM,                                       ';  
  Result := Result + '        0 AS MARCA                                                     ';
  Result := Result + ' FROM FATGOR G1                                                        ';

  Result := Result + '   INNER JOIN FATGOR G2 ON G2.FGO_JAFATU = 0 AND G2.FGO_CODEMP = "100" ';
  Result := Result + '                    AND G2.FGO_PEDSIT = G1.FGO_PEDSIT                  ';
  Result := Result + '   INNER JOIN CADCLI C  ON C.CLI_CODCLI = G2.FGO_CODCLI                ';

  Result := Result + ' WHERE G1.FGO_CODEMP = "001"                                           ';
  Result := Result + '   AND G1.FGO_JAFATU = 0                                               ';
  Result := Result + '   AND ((G1.FGO_LIBERA = 0) OR (G1.FGO_LIBCOM =0) OR (IFNULL(G1.FGO_SEPIMP,"N") = "N")) ';
  Result := Result + '   AND G1.FGO_PEDSIT IS NOT NULL                                       ';
  Result := Result + '   AND G1.FGO_PEDSIT > 0                                               ';

  If cmbForPgt.ItemIndex > 0 Then
    Result := Result + ' AND G2.FGO_FPGSIT = ' + QuotedStr(IntToStr(fTraduzDescricao(arrFormaPgto, cmbForPgt.Text)));

  If cmbStatus.ItemIndex > 0 Then
    Result := Result + ' AND G2.FGO_STASIT = ' + QuotedStr(IntToStr(fTraduzDescricao(arrStatusPed, cmbStatus.Text)));

  If (not fEmptyDate(mskDtaIni.Text)) And (Not fEmptyDate(mskDtaFin.Text) ) Then
    Result := Result + ' AND G2.FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

end;

procedure TfrmPainelECommerce.FormCreate(Sender: TObject);
  Var
    intIndex : Integer;
Begin
  inherited;
  cdsPedidos := TZClient.Create(Self);
  dbgDados.DataSource := cdsPedidos.dtsSource;

  For intIndex := Low(arrFormaPgto) to High(arrFormaPgto) Do
    cmbForPgt.Items.Add(arrFormaPgto[intIndex].strDescri);

  For intIndex := Low(arrStatusPed) to High(arrStatusPed) Do
    cmbStatus.Items.Add(arrStatusPed[intIndex].strDescri);

end;

procedure TfrmPainelECommerce.pOnGetTextStatus(Sender: TField; var Text: string; DisplayText: Boolean);
Begin
  Text := fTraduzCodigo(arrStatusPed, cdsPedidos.FieldByName('STASIT').AsInteger );
End;

procedure TfrmPainelECommerce.pOnGetTextFormaPgto(Sender: TField; var Text: string; DisplayText: Boolean);
Begin
  Text := fTraduzCodigo(arrFormaPgto, cdsPedidos.FieldByName('FPGSIT').AsInteger );
End;

procedure TfrmPainelECommerce.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsPedidos);
end;

procedure TfrmPainelECommerce.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F11 Then
    btnItensPend.Click;
end;

procedure TfrmPainelECommerce.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(cmbForPgt);
end;

end.
