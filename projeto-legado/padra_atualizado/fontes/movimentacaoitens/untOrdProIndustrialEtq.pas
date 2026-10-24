unit untOrdProIndustrialEtq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  Mask, DBCtrls, DBEditFocus, cxCurrencyEdit, cxMaskEdit, MaskEditFocus,
   Uni, StrUtils, untZClient, ComCtrls,
  DateUtils, MaskUtils, untOrdProIndustrial, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog,

  OrdemProducaoIndustrial.TEtiquetaProdutoAcabado;

type
  TfrmOrdProIndustrialEtq = class(TfrmPaiEdit)
    pnlFiltro: TPanel;
    Label1: TLabel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    pnlDados: TPanel;
    Label2: TLabel;
    dbeCodIte: TDBEditFocus;
    Label3: TLabel;
    dbeCodOrd: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    Label4: TLabel;
    dbeDtaCad: TDBEditFocus;
    dtsGranel: TDataSource;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensDTAVAL: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    cxgItensQTDETI: TcxGridDBColumn;
    cxgItensViewColumn8: TcxGridDBColumn;
    mskNumLot: TMaskEditFocus;
    dbeVolume: TDBEditFocus;
    cxgItensMARDES: TcxGridDBColumn;
    prgProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnCfgLay: TBitBtnLocked;
    Shape1: TShape;
    Label5: TLabel;
    cxgItensIMPETI: TcxGridDBColumn;
    Shape2: TShape;
    Label6: TLabel;
    cxgItensDESFAB: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewOBSOPI: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mskNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarClick(Sender: TObject);
    procedure cxgItensDTAVALPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCfgLayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mskNumLotExit(Sender: TObject);
  private
    { Private declarations }
    qryOrdPro: TUniQuery;
    cdsIteAca: TZClient;
    objEtiquetaProdutoAcabado : TEtiquetaProdutoAcabado;

    objOrdPro: TOrdProIndustrial;

    arrLayouts : array of string;



    Procedure pMarcaTodos(blnMarcar: Boolean);
    Procedure pMarcaItem;

    Procedure pGeraItensImpressao;
    Procedure pImprimeEtiquetas;


  public
    { Public declarations }
    Function fMostraAcabados(strAutInc: String): Boolean;
    function fBuscaOP : boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples, untTypesSistema,
  untCfgRel,
  untConsultas,
  untFuncoesRel, TypesRel, untFuncoesEtiquetas;

procedure TfrmOrdProIndustrialEtq.FormCreate(Sender: TObject);
begin
  inherited;

  qryOrdPro := fCriaQuery(Self);
  dtsGranel.DataSet := qryOrdPro;

  objEtiquetaProdutoAcabado := TEtiquetaProdutoAcabado.Create;
  objEtiquetaProdutoAcabado.strQuantidadeAmostras:= fCfgSis('QTDAMO', varString);

  cdsIteAca := TZClient.Create(Self, objEtiquetaProdutoAcabado.fSqlItens);
  cdsIteAca.pCriaSoma('VOLUME', 'VOLTOT');
  cdsIteAca.pCriaSoma('QTDETI', 'ETITOT');

  dbeVolume.DataSource                   := cdsIteAca.dtsSource;
  cxgItensView.DataController.DataSource := cdsIteAca.dtsSource;

  btnCfgLay.Visible := fVerificaAcessoSistema('frmEditorEtiquetasOPI', strLoginUsuarioLogado);

  objOrdPro := TOrdProIndustrial.Create(Self);
end;

procedure TfrmOrdProIndustrialEtq.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objEtiquetaProdutoAcabado);
end;

procedure TfrmOrdProIndustrialEtq.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5: btnMarcar.Click;
    VK_F6: btnMarcaTodos.Click;
    VK_F7: btnDesmarcaTodos.Click;
    VK_F8: btnCfgLay.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And
                  (cdsIteAca.State = dsEdit) And
                  (cxgItensQTDETI.Focused Or cxgItensDTAVAL.Focused) Then
                 Begin
                   cxgItensView.NavigatorButtons.Next.Click;
                   If (cdsIteAca.State = dsEdit) Then
                   Begin
                     cdsIteAca.Post;
                     pSetFocus(btnConfirma);
                   End;
                 End;
  End;

end;

procedure TfrmOrdProIndustrialEtq.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Case Key Of
    '-': Key := #0;
  End;

end;

procedure TfrmOrdProIndustrialEtq.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskNumLot);
  pSetaCodIte( dbeCodIte );

end;

function TfrmOrdProIndustrialEtq.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskNumLot) Then
    Begin

      If fEmptyStrEspeciais(mskNumLot.Text) Then
      Begin
        pMensagemOk('Informe o Número do Lote!');
        Result := False;
      End

      Else if not fBuscaOP then
      Begin
        pMensagemOk('Lote não encontrado!');
        Result := False;
      End Else
      Begin
        objEtiquetaProdutoAcabado.strNumeroLote := mskNumLot.Text;
        fMostraAcabados(qryOrdPro.FieldByName('AUTINC').AsString);

        cxgItensQTDETI.Focused := True;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmOrdProIndustrialEtq.mskNumLotExit(Sender: TObject);
begin
  inherited;
  {Não remover o evento pois o mesmo é usado na man ord prod ind}
  fValidaCampos(mskNumLot);
end;

procedure TfrmOrdProIndustrialEtq.mskNumLotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrLote: TConsultasArray;
begin
  inherited;

  If fPesqOrdProIndustrial(Self, mskNumLot, Nil, qryTabela, Key, arrLote, poiLote) Then
  Begin
    If fValidaCampos(mskNumLot, True) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmOrdProIndustrialEtq.btnCfgLayClick(Sender: TObject);
  Var
    strCodLay: String;
begin
  inherited;

  If Not btnCfgLay.Visible Then
    Exit;

  pEditorEtiqueta(tpeOPIndustrialArgox, strCodLay);
end;

procedure TfrmOrdProIndustrialEtq.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  pImprimeEtiquetas;
end;

procedure TfrmOrdProIndustrialEtq.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(False);
end;

procedure TfrmOrdProIndustrialEtq.btnMarcarClick(Sender: TObject);
begin
  inherited;

  pMarcaItem;
end;

procedure TfrmOrdProIndustrialEtq.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(True);
end;

procedure TfrmOrdProIndustrialEtq.cxgItensDTAVALPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If Not fValidaMesAno(DisplayValue, 'Validade incorreta!') Then
  Begin
    Error := True;
  End;

end;

procedure TfrmOrdProIndustrialEtq.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensMARDES.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;

    If (AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue;

  End Else
  Begin
    If Not AViewInfo.Selected Then
      ACanvas.Brush.Color := clWindow;
  End;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensIMPETI.Index]) = 'S') And
     (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensMARDES.Index]) = 'N') Then
  Begin
    ACanvas.Brush.Color := $00FFBA75;
  End;

end;


function TfrmOrdProIndustrialEtq.fBuscaOP: boolean;
begin
  Result := objOrdPro.fExisteLoteOP(qryOrdPro, mskNumLot.Text);
  if Result then
  Begin
    fMostraAcabados(qryOrdPro.FieldByName('AUTINC').AsString);

    cxgItensQTDETI.Focused := True;
  End;
end;

Function TfrmOrdProIndustrialEtq.fMostraAcabados(strAutInc: String): Boolean;
Begin
  With cdsIteAca, qryQuery Do
  Begin
    ParamByName('AUTINC').AsString := strAutInc;
//    ParamByName('DTACAD').AsDate   := VS_Date;

    Result := fAbreClient(True, 'TfrmOrdProIndustrialEtq.fMostraAcabados');

    pFormataDecimal('VOLUME', 3);
    pFormataDecimal('VOLTOT', 3);
    pFormataDecimal('QTDPRO', 2);
    pFormataDecimal('PESLIT', 3);

    pAlinhaCampoCentro('DTAVAL');
  End;
End;

Procedure TfrmOrdProIndustrialEtq.pMarcaTodos(blnMarcar: Boolean);
Begin
  With cdsIteAca Do
  Begin
    If IsEmpty Then
      Exit;

    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldbyName('MARDES').AsString := IIF(blnMarcar, 'S', 'N');
      Post;

      Next;
    End;

    First;
    EnableControls;
  End;
End;

Procedure TfrmOrdProIndustrialEtq.pMarcaItem;
Begin
  With cdsIteAca Do
  Begin
    If IsEmpty Then
      Exit;

    Edit;
    FieldbyName('MARDES').AsString := IIF(FieldbyName('MARDES').AsString = 'N', 'S', 'N');
    Post;

  End;

End;

Procedure TfrmOrdProIndustrialEtq.pGeraItensImpressao;
  var
    qryLayout       : TUniQuery;
    strLayoutPadrao : String;

  function fGetLayoutPadrao : String;
  var
    arrLayPadrao : array of string;
  begin
    Result := '';

    qryLayout.Close;
    qryLayout.SQL.Clear;
    qryLayout.SQL.Add('SELECT                                  ');
    qryLayout.SQL.Add('  LAY_CODLAY,                           ');
    qryLayout.SQL.Add('  LAY_DESCRI,                           ');
    qryLayout.SQL.Add('  LAY_NOMLAY                            ');
    qryLayout.SQL.Add('FROM                                    ');
    qryLayout.SQL.Add('  LAYETI                                ');
    qryLayout.SQL.Add('WHERE                                   ');
    qryLayout.SQL.Add('      LAY_TIPLAY = :TIPLAY              ');
    qryLayout.SQL.Add('  AND LAY_PADRAO = "S"                  ');
    qryLayout.SQL.Add('ORDER BY                                ');
    qryLayout.SQL.Add('  LAY_DESCRI                            ');

    qryLayout.ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[tpeOPIndustrialArgox];

    qryLayout.Open;

    {*****************************************************************}
    {* se não tiver layout, retorna vazio                            *}
    {* 1 layout, retorna ele                                         *}
    {* +1 layout, pede para o usuário selecionar qual será utilizado *}
    {*****************************************************************}
    if qryLayout.RecordCount = 1 then
      Result := qryLayout.FieldByName('LAY_CODLAY').AsString
    else if qryLayout.RecordCount > 1 then
    begin
      qryLayout.First;
      setLength(arrLayPadrao, 0);

      while not qryLayout.Eof do
      begin
        setLength(arrLayPadrao, Length(arrLayPadrao)+1);
        arrLayPadrao[High(arrLayPadrao)] := qryLayout.FieldByName('LAY_CODLAY').AsString + ' - ' +
                                            qryLayout.FieldByName('LAY_NOMLAY').AsString + ' ( ' +
                                            qryLayout.FieldByName('LAY_DESCRI').AsString + ' )';

        qryLayout.Next;
      end;

      qryLayout.RecNo := fGetMenu(  'Layout padrão para itens sem layout vinculado'
                                  , arrLayPadrao
                                  , 1
                                  , False
                                  , False
                                  , 400);


      Result := qryLayout.FieldByName('LAY_CODLAY').AsString;
    end;

  end;

  function fGetLayouItem : String;
  var
    arrLayIte : array of string;
  begin
    Result := '';

    //layouts vinculados ao produto, na aba produtos acabados
    qryLayout.Close;
    qryLayout.SQL.Clear;
    qryLayout.SQL.Add('SELECT                                                  ');
    qryLayout.SQL.Add('  LAYETI.LAY_CODLAY,                                    ');
    qryLayout.SQL.Add('  LAY_DESCRI,                                           ');
    qryLayout.SQL.Add('  LAY_NOMLAY                                            ');
    qryLayout.SQL.Add('FROM                                                    ');
    qryLayout.SQL.Add('  LAYITE                                                ');
    qryLayout.SQL.Add('   JOIN LAYETI ON LAYETI.LAY_CODLAY = LAYITE.LAY_CODLAY ');
    qryLayout.SQL.Add('WHERE                                                   ');
    qryLayout.SQL.Add('  LAY_CODITE = :CODITE                                  ');
    qryLayout.SQL.Add('ORDER BY                                                ');
    qryLayout.SQL.Add('  LAY_DESCRI                                            ');
    qryLayout.ParamByName('CODITE').AsString := cdsIteAca.FieldByName('CODITE').AsString;
    qryLayout.Open;

    {*****************************************************************}
    {* se não tiver layout, retorna vazio                            *}
    {* 1 layout, retorna ele                                         *}
    {* +1 layout, pede para o usuário selecionar qual será utilizado *}
    {*****************************************************************}
    if qryLayout.RecordCount = 1 then
      Result := qryLayout.FieldByName('LAY_CODLAY').AsString
    else
    begin
      qryLayout.First;
      setLength(arrLayIte, 0);

      while not qryLayout.Eof do
      begin
        setLength(arrLayIte, Length(arrLayIte)+1);
        arrLayIte[High(arrLayIte)] := qryLayout.FieldByName('LAY_CODLAY').AsString + ' - ' +
                                      qryLayout.FieldByName('LAY_NOMLAY').AsString + ' ( ' +
                                      qryLayout.FieldByName('LAY_DESCRI').AsString + ' )';

        qryLayout.Next;
      end;

      qryLayout.RecNo := fGetMenu(  'Layout: ' + cdsIteAca.FieldByName('CODITE').AsString
                                  + ' - '
                                  + cdsIteAca.FieldByName('DESCRI').AsString
                                  , arrLayIte
                                  , 1
                                  , False
                                  , False
                                  , 400);


      Result := qryLayout.FieldByName('LAY_CODLAY').AsString;
    end;

  end;
Begin
  With cdsIteAca Do
  Begin
    prgProgresso.Position := 0;
    prgProgresso.Visible  := True;
    prgProgresso.Max      := Trunc(fRetSoma('ETITOT'));

    SetLength(arrLayouts,0);

    DisableControls;

    objEtiquetaProdutoAcabado.cdsEtiquetas.EmptyDataSet;
    objEtiquetaProdutoAcabado.cdsEtiquetas.Filtered := False;

    Filtered := False;
    Filter   := '(MARDES = ' + QuotedStr('S') + ') AND (QTDETI > 0)';
    Filtered := True;
    qryLayout := fCriaQuery(nil);
    try

      strLayoutPadrao := '';
      //se houver itens sem um layout vinculado, antes de tudo pede o layout padrão
      if Locate('QTDLAY', '0', []) then
        strLayoutPadrao := fGetLayoutPadrao;

      First;
      While Not Eof Do
      Begin
        //adiciona o layout no array e no cds para fazer a impressão por layout
        if FieldByName('QTDETI').AsInteger > 0 then
        begin
          Edit;
          //se qtdlay = 0, não possui registro na layite, então utiliza o principal
          if FieldByName('QTDLAY').asInteger = 0 then
            FieldByName('LAYOUT').AsString := strLayoutPadrao
          else
            FieldByName('LAYOUT').AsString := fGetLayouItem;
          Post;

          //se o layout do item não estiver no array, adiciona ele para entrar na fila de impressão
          if not MatchStr(FieldByName('LAYOUT').AsString, arrLayouts) then
          begin
            SetLength(arrLayouts, Length(arrLayouts) + 1);
            arrLayouts[High(arrLayouts)] := FieldByName('LAYOUT').AsString;
          end;
        end;

        objEtiquetaProdutoAcabado.pAdicionaItensCdsEtiquetas(cdsIteAca);

        prgProgresso.StepBy(1);
        Application.ProcessMessages;

        Next;
      End;
    finally
      FreeAndNil(qryLayout);
    end;

    Filtered := False;
    First;

    EnableControls;
    prgProgresso.Visible := False;
  End;
End;

Procedure TfrmOrdProIndustrialEtq.pImprimeEtiquetas;
  Var
    strNomImp, strTipImp: String;
    prmDllEtq: TParamDllEtiquetas;
    qryUpdate: TUniQuery;
    i : Integer;
Begin
  Try
   If qryOrdPro.IsEmpty Then
     Exit;

   pGeraItensImpressao;

   If (Not objEtiquetaProdutoAcabado.cdsEtiquetas.IsEmpty) Then
   Begin
     pCarregaConfImprRel(Self.Name, strNomImp, strTipImp);

     prmDllEtq := TParamDllEtiquetas.Create;

     prmDllEtq.tpeTipEtq := tpeOPIndustrialArgox;
     prmDllEtq.dtsImpres := objEtiquetaProdutoAcabado.cdsEtiquetas;
     prmDllEtq.strNomFil := strNomImp;
     prmDllEtq.strNomFrm := Self.Name;
     prmDllEtq.blnImpEti := False;

     for i := 0 to High(arrLayouts) do
     begin
       objEtiquetaProdutoAcabado.cdsEtiquetas.Filtered := False;
       objEtiquetaProdutoAcabado.cdsEtiquetas.Filter   := 'LAYOUT = ' + QuotedStr(arrLayouts[i]);
       objEtiquetaProdutoAcabado.cdsEtiquetas.Filtered := True;

       prmDllEtq.strLayDoc := arrLayouts[i];

       If fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral') Then
       Begin
         Try
           qryUpdate := fCriaQuery(Self);
           With qryUpdate, Sql Do
             Add(' UPDATE ORDDET SET ORD_IMPETI = "S" WHERE AUTOINCREM = :AUTOIN ');

           With objEtiquetaProdutoAcabado.cdsEtiquetas Do
           Begin
             First;
             While not Eof Do
             Begin
               qryUpdate.ParamByName('AUTOIN').AsString := FieldByName('AUTOIN').AsString;
               qryUpdate.ExecSQL;
               Next;
             End;

           End;
         Finally
           FreeAndNil(qryUpdate);
         End;
         fMostraAcabados(qryOrdPro.FieldByName('AUTINC').AsString);
       End;
     end;

     FreeAndNil(prmDllEtq);
   End

   Else pMensagemOk('Nenhum registro selecionado para impressão!');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmOrdProIndustrialEtq.pImprimeEtiquetas');
    End;
  End;
End;



end.

