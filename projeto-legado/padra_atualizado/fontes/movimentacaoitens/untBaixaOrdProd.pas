unit untBaixaOrdProd;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  DB, EditFocus, Uni, untOrdPro, BitBtnLockedIncrem, Grids, DBGridCitel, DBGrids, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, cxCalc, cxTextEdit,  System.UITypes,
  Vcl.Mask, MaskEditFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls,
  untZClient, Vcl.Graphics, untOrdProCorrecoes;

type
  TfrmBaixaOrdProd = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnCadRapLotWMS: TBitBtnLocked;
    btnLocFis: TBitBtnLocked;
    pgcPagina: TPageControl;
    tbsBaixa: TTabSheet;
    tbsFases: TTabSheet;
    pnlIteEst: TPanel;
    dbgIteEst: TcxGridCitel;
    dbgIteEstTV: TcxGridDBTableViewCitel;
    dbgIteEstTVITESUB: TcxGridDBColumn;
    dbgIteEstTVDESITE: TcxGridDBColumn;
    dbgIteEstTVREFERE: TcxGridDBColumn;
    dbgIteEstTVUNIDAD: TcxGridDBColumn;
    dbgIteEstTVQTDPRO: TcxGridDBColumn;
    dbgIteEstTVNUMLOT: TcxGridDBColumn;
    dbgIteEstLvl: TcxGridLevel;
    pnlConLot: TPanel;
    chkConLot: TCheckBox;
    pnlArmEnt: TPanel;
    lblArmEnt: TLabel;
    edtDesArm: TEditFocus;
    edtArmEnt: TMaskEditFocus;
    pnlConferido: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    edtProduzido: TEditFocus;
    edtConfPor: TEditFocus;
    btnArmInd: TBitBtnLocked;
    pnlDadCli: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodCli: TEditFocus;
    edtCodIte: TEditFocus;
    edtObs001: TEditFocus;
    edtObs002: TEditFocus;
    edtProduzir: TEditFocus;
    edtDesCli: TEditFocus;
    edtDesIte: TEditFocus;
    pnlOrdPro: TPanel;
    Label3: TLabel;
    edtOrdPro: TEditFocus;
    cxgCadFas: TcxGridCitel;
    cxgCadFasView: TcxGridDBTableViewCitel;
    cxgCadFasCODIGO: TcxGridDBColumn;
    cxgCadFasDESFAS: TcxGridDBColumn;
    cxgCadFasSEQUEN: TcxGridDBColumn;
    cxgCadFasSTATUS: TcxGridDBColumn;
    cxgCadFasLevel1: TcxGridLevel;
    btnCorrecoes: TBitBtnLocked;
    procedure edtOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtArmEntKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadRapLotWMSClick(Sender: TObject);
    procedure btnLocFisClick(Sender: TObject);
    procedure dbgIteEstTVQTDPROPropertiesEditValueChanged(Sender: TObject);
    procedure dbgIteEstTVNUMLOTPropertiesEditValueChanged(Sender: TObject);
    procedure dbgIteEstTVKeyPress(Sender: TObject; var Key: Char);
    procedure dbgIteEstTVEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkConLotClick(Sender: TObject);
    procedure btnArmIndClick(Sender: TObject);
    procedure dbgIteEstTVEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnCorrecoesClick(Sender: TObject);
  private
    { Private declarations }
    qryConIte: TUniQuery;

    blnFecharForm: Boolean;
    blnMonFas: Boolean;

    cdsCadFas: TZClient;

    frmCorrecoes: TFrmOrdProCorrecoes;

    function fValidaEdtOrdPro(blnBuscaPorChave: Boolean): Boolean;
    function fValidaEdtProduzido: Boolean;
    function fValidaEdtArmazem: Boolean;

    function fCarregaDados : Boolean;
    procedure pLimpaCampos;
    procedure pBuscaLoteItem(var Key : Char);
    procedure pProximoItem;
    function fCarregaFases(AStrCodIte, AStrCodOrd: String): boolean;
    function fGetSQLFases: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objOrdPro: TOrdPro;
    strOrdPro: String;
    blnBaixou: Boolean;
    function fOrdPro: TOrdPro;
  end;

implementation

uses SysUtils, Forms, UniClientDataSet, untFuncoesSimples, untConsultas,
  untTypesSistema, untCadLoteItens, untCadLocFisica, untCadLote,
  untOrdProMonitoramento;

{$R *.dfm}

procedure TfrmBaixaOrdProd.btnArmIndClick(Sender: TObject);
begin
  inherited;
  if not fValidaCampos(edtProduzido, True) then
    exit;

  objOrdPro.objLotInd.pDigLoteIndividual;

  if not objOrdPro.objLotInd.cdsLotInd.isEmpty then
  begin
    edtArmEnt.clear;
    edtArmEnt.enabled := False;
  end
  else
    edtArmEnt.enabled := not fCfgSis('LOTORD', varBoolean);

  pSetFocus(edtConfPor);

end;

procedure TfrmBaixaOrdProd.btnCadRapLotWMSClick(Sender: TObject);
  Var
    frmCadLoteItens: TfrmCadLoteItens;
    strLotCad: String;
begin
  inherited;
  If Not btnCadRapLotWMS.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('frmCadLoteItensRapido') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Lotes!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    frmCadLoteItens.strCodigoItemCadastroRapidoWMS := edtCodIte.Text;
    frmCadLoteItens.ShowModal;
    strLotCad := frmCadLoteItens.strNumeroLoteCadastroRapidoWMS;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadLoteItens);

  //Caso gravou um novo Lote para o produto
  If Not fEmptyStr(strLotCad) Then
    edtArmEnt.Text := strLotCad;

end;

procedure TfrmBaixaOrdProd.btnCorrecoesClick(Sender: TObject);
begin
  inherited;
  If Not btnCorrecoes.Visible Then
    Exit;

  If Not Assigned(frmCorrecoes) Then
    frmCorrecoes := TfrmOrdProCorrecoes.Create(Self);

  frmCorrecoes.blnMontarCds := edtOrdPro.Text <> frmCorrecoes.strCodPro;
  frmCorrecoes.strCodPro := edtOrdPro.Text;
  frmCorrecoes.edtProdutos.Text     := edtCodIte.Text;
  frmCorrecoes.edtDesProduto.Text   := edtDesIte.Text;
  frmCorrecoes.edtCodFab.Text       := fRetCodFabrica(edtCodIte.Text);
  frmCorrecoes.edtReferencia.Text   := fRetReferenciaProd(edtCodIte.Text);
  frmCorrecoes.edtUnidade.Text      := fRetUnidadeItem(edtCodIte.Text);

  frmCorrecoes.ShowModal;
end;

procedure TfrmBaixaOrdProd.btnGravarClick(Sender: TObject);
begin
  inherited;
  If not objOrdPro.qryOrdPro.Active Then
    Exit;

  If blnMonFas Then
  Begin
    If Not TOrdProMonitoramento.fValidaFasesBaixa(edtOrdPro.Text) Then
      Exit;

    If Assigned(frmCorrecoes) Then
    Begin
      If frmCorrecoes.fPossuiCorrecoes Then
      Begin
        frmCorrecoes.blnDefinirDestino := True;
        objOrdPro.cdsItensDefinidosCorrecao := frmCorrecoes.cdsCorrecoes;
        If Not (frmCorrecoes.ShowModal = mrOk) Then
          Exit;
      End;
    End;

  End;

  try
    objOrdPro.cdsIteEst.Filtered := False;

    If fVerificaCampos Then
    Begin

      //valida lotes unitários para entrada da estrutura
      if not objOrdPro.objLotInd.fValidaLotesIndividuais then
      begin
        btnArmInd.click;
        Exit;
      end;

      //verifica se os itens possuem lotes informados na ordem de produção ou lote principal para baixa automática
      if not objOrdPro.fVerificaLoteSubItens then
        exit;

      if fEmptyStr(objOrdPro.strCodCli) then
      begin
        if fEmptyStr(fCfgSis('CLIOPR', varString)) Then
        Begin
          fMensagem('','A ordem de produção não tem um cliente definido e a configuração [CFG_CLIOPR] deve estar definida para setar um cliente para esta ordem de produção!',['&OK']);
          Exit;
        End;
      end;

      If (fCfgSis('TCORPR') = '2') or (fCfgSis('LOTBOP') = '2') Then
        blnBaixou := objOrdPro.fBaixaOrdPro2(fStrToFloat(edtProduzido.Text), edtConfPor.Text)
      else
        blnBaixou := objOrdPro.fBaixaOrdPro(fStrToFloat(edtProduzido.Text), edtConfPor.Text);

      If blnBaixou Then
      Begin
        pLimpaCampos;
        blnBaixou := True;

        If Not fEmptyStr(strOrdPro) Then
          blnFecharForm := True;

        Self.Repaint;
      End;
    End;
  finally
    chkConLotClick(chkConLot);
  end;
end;

procedure TfrmBaixaOrdProd.btnLocFisClick(Sender: TObject);
begin
  inherited;
  If not btnLocFis.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('frmCadLocFisica') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Localização Física!', ['&O k']);
    Exit;
  End;

  pCriarForm(TfrmCadLocFisica);

end;

procedure TfrmBaixaOrdProd.chkConLotClick(Sender: TObject);
begin
  inherited;
  if pnlConLot.Visible then
  begin
    if chkConLot.Checked then
    begin
      objOrdPro.cdsIteEst.Filtered := False;
      objOrdPro.cdsIteEst.Filter   := 'CONLOT = ' + QuoteDStr('S');
      objOrdPro.cdsIteEst.Filtered := True;
    end
    else
      objOrdPro.cdsIteEst.Filtered := False;
  end;
end;

procedure TfrmBaixaOrdProd.dbgIteEstTVEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not objOrdPro.CdsIteEst.Active then
    exit;

  Case Key of
    VK_RETURN: if dbgIteEstTVQTDPRO.Focused then
               begin
                 if dbgIteEstTVNUMLOT.Options.Focusing then
                   dbgIteEstTVNUMLOT.Focused := True
                 else
                   pProximoItem;
               end
               else if dbgIteEstTVNUMLOT.Focused then
                 pProximoItem;
  end;
end;

procedure TfrmBaixaOrdProd.dbgIteEstTVEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  if not objOrdPro.CdsIteEst.Active then
    exit;

  if AItem = dbgIteEstTVNUMLOT then
  begin
    pBuscaLoteItem(Key);
  end;
end;


procedure TfrmBaixaOrDProd.pBuscaLoteItem(var Key : Char);
var
  arrNumLot : TConsultasArray;
begin
  inherited;
  if dbgIteEstTVNUMLOT.Options.Editing then
  begin
    If fPesqLoteItens(Self, nil, nil, fCfgSis('DECUNI'), Nil, Key, arrNumLot, True, objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString) Then
    Begin
      If not (objOrdPro.cdsIteEst.State in [dsEdit]) then
        objOrdPro.cdsIteEst.Edit;

      objOrdPro.cdsIteEst.FieldByName('NUMLOT').AsString := fCampoTabela('LOT_NUMLOT', 'CADLOT', ['AUTOINCREM'], [arrNumLot[0].strCodigo]);
      objOrdPro.cdsIteEst.FieldByName('SALDOS').AsFloat  := TOrdPro.fSaldoLote(objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString, objOrdPro.cdsIteEst.FieldByName('NUMLOT').AsString, VS_strCodEmp);
      objOrdPro.cdsIteEst.Post;
    End;
  end;
end;

procedure TfrmBaixaOrdProd.dbgIteEstTVKeyPress(Sender: TObject; var Key: Char);
begin
  if not objOrdPro.CdsIteEst.Active then
    exit;

  if dbgIteEstTVNUMLOT.Focused then
    pBuscaLoteItem(Key);
end;

procedure TfrmBaixaOrdProd.dbgIteEstTVNUMLOTPropertiesEditValueChanged(
  Sender: TObject);
var
  qryLote : TUniQuery;
begin
  inherited;
  if fEmptyStr(TcxTextEdit(Sender).Text) then
    exit;

  if not objOrdPro.CdsIteEst.Active then
    exit;

  If objOrdPro.CdsIteEst.State in [dsEdit] then
  begin
    qryLote := fCriaQuery(nil);
    try

      qryLote.SQL.Add('SELECT                    ');
      qryLote.SQL.Add('  LOT_SALDOS              ');
      qryLote.SQL.Add('FROM                      ');
      qryLote.SQL.Add('  CADLOT                  ');
      qryLote.SQL.Add('WHERE                     ');
      qryLote.SQL.Add('      LOT_CODITE = :CODITE');
      qryLote.SQL.Add('  AND LOT_NUMLOT = :NUMLOT');
      qryLote.SQL.Add('  AND LOT_CODEMP = :CODEMP');

      qryLote.Params.ParamByName('CODITE').AsString := objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString;
      qryLote.Params.ParamByName('NUMLOT').AsString := TcxTextEdit(Sender).Text;
      qryLote.Params.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryLote.Open;

      if qryLote.IsEmpty then
      begin
        pMensagemOk('Lote Inválido!');
        objOrdPro.CdsIteEst.Cancel;
      end
      else
      begin
        objOrdPro.cdsIteEst.FieldByName('SALDOS').AsFloat := qryLote.FieldByName('LOT_SALDOS').AsFloat;
        if (fCfgSis('SLD_OI') <> 'N')  and (objOrdPro.cdsIteEst.FieldByName('SALDOS').AsFloat < objOrdPro.cdsIteEst.FieldByName('QTDPRO').AsFloat) then
        begin
          if fCfgSis('SLD_OI') = 'T' Then
          begin
            pMensagemOk('Saldo do lote insulficiente!');
            objOrdPro.CdsIteEst.Cancel;
          end
          else if fMensagem('AVISO', 'Saldo do lote insulficiente, continuar assim mesmo?', ['','']) = 2 then
            objOrdPro.CdsIteEst.Cancel
          else begin
            IF objOrdPro.CdsIteEst.State in [dsEdit] then
            begin
              objOrdPro.cdsIteEst.FieldByName('NUMLOT').AsString := TcxTextEdit(Sender).Text;
              objOrdPro.cdsIteEst.Post;
            end;
          end;
        end
        else
        begin
          If objOrdPro.CdsIteEst.State in [dsEdit] then
          begin
            objOrdPro.cdsIteEst.FieldByName('NUMLOT').AsString := TcxTextEdit(Sender).Text;
            objOrdPro.cdsIteEst.Post;
          end;
        end;
      end;

    finally
      qryLote.Close;
      FreeAndNil(qryLote);
    end;
  end;

end;

procedure TfrmBaixaOrdProd.pProximoItem;
begin
  objOrdPro.cdsIteEst.Next;
  If objOrdPro.cdsIteEst.Eof Then
    pSetFocus(btnGravar)
  else
  begin
    if dbgIteEstTVQTDPRO.Options.Focusing then
      dbgIteEstTVQTDPro.Focused := True
    else
      dbgIteEstTVNUMLOT.Focused := True;
  end;
end;

procedure TfrmBaixaOrdProd.dbgIteEstTVQTDPROPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if not objOrdPro.CdsIteEst.Active then
    exit;

  If objOrdPro.CdsIteEst.State in [dsEdit] then
  begin
    If ( TcxCalcEdit(Sender).Value < 0) Then
    begin
      pMensagemOk('A quantidade não pode ser menor que zero!');
      objOrdPro.CdsIteEst.Cancel;
    end
    else if (not fEmptyStr(objOrdPro.cdsIteEst.FieldByName('NUMLOT').AsString)) and (TcxCalcEdit(Sender).Value > objOrdPro.cdsIteEst.FieldByName('SALDOS').AsFloat) and (fCfgSis('SLD_OI') <> 'N') and dbgIteEstTVNUMLOT.Options.Editing then
    begin
      if fCfgSis('SLD_OI') = 'T' then
      begin
        pMensagemOk('Saldo do lote insulficiente!');
        objOrdPro.CdsIteEst.Cancel;
      end
      else
      begin
        if fMensagem('AVISO', 'Saldo do lote insulficiente, continuar assim mesmo?', ['','']) = 2 then
        begin
          objOrdPro.CdsIteEst.Cancel;
        end
        else
        begin
          if not dbgIteEstTVNUMLOT.Options.Focusing then
          begin
            IF objOrdPro.CdsIteEst.State in [dsEdit] then
            begin
              objOrdPro.cdsIteEst.FieldByName('QTDPRO').AsFloat := TcxCalcEdit(Sender).Value;

              If (fCfgSis('ATPCPM') = 'S') Then
              Begin
                objOrdPro.GravaQuantidadeEditaDoSubItem(objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString,
                                                        objOrdPro.cdsIteEst.FieldByName('QTDPRO').AsFloat);
              End;

              objOrdPro.cdsIteEst.Post;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if not dbgIteEstTVNUMLOT.Options.Focusing then
      begin
        IF objOrdPro.CdsIteEst.State in [dsEdit] then
        begin
          objOrdPro.cdsIteEst.FieldByName('QTDPRO').AsFloat := TcxCalcEdit(Sender).Value;

          If (fCfgSis('ATPCPM') = 'S') Then
          Begin
            objOrdPro.GravaQuantidadeEditaDoSubItem(objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString,
                                                    objOrdPro.cdsIteEst.FieldByName('QTDPRO').AsFloat);
          End;

          objOrdPro.cdsIteEst.Post;
        end;
      end;
    end;
  end;
end;

procedure TfrmBaixaOrdProd.edtArmEntKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqLoteFat(Self,
                  edtArmEnt,
                  fCfgSis('DECUNI'),
                  objOrdPro.strCodIte,
                  False,
                  True,
                  Nil,
                  Key,
                  arrSel,
                  VS_strCodEmp) Then
  Begin
    If fValidaCampos(edtArmEnt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaOrdProd.edtOrdProKeyPress(Sender: TObject; var Key: Char);
  Var
    strSQL: String;
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'WHERE                    ';
    strSQL := strSQL + '  PRO_DTABAI IS NULL AND ';
    strSQL := strSQL + '  PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    if fPesqOrdemProd(conSimples,
                      Self,
                      edtOrdPro,
                      nil,
                      objOrdPro.qryOrdPro,
                      Key,
                      arrSel,
                      strSQL) then
    Begin
      objOrdPro.pAtuDados;                            
      edtOrdPro.Text := objOrdPro.strCodPro;

      If fValidaCampos(edtOrdPro) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmBaixaOrdProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pLimpaCampos;
  inherited;
end;

procedure TfrmBaixaOrdProd.FormCreate(Sender: TObject);
begin
  inherited;
  edtProduzido.EditFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  edtProduzir.EditFormat  := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  blnFecharForm := False;
  blnBaixou := False;
  edtOrdPro.MaxLength := fTamDocCadRec;
  edtOrdPro.TamCampo := fTamDocCadRec;

  Try
    btnCadRapLotWMS.Visible := fUsaRotinaWMS;
    btnLocFis.Visible := fUsaRotinaWMS;
    edtDesArm.Visible := (fCfgSis('CTLEST') = '2');
    btnArmInd.Visible := (fCfgSis('CTLEST') = '1');

    If (fCfgSis('TCORPR') = '1') and (fCfgSis('LOTBOP') = '1') Then
    Begin
      pnlIteEst.Visible := False;
      Height := (Height +5) - pnlIteEst.Height;
    End
    else
    begin
      if fCfgSis('TCORPR') = '2' then
      begin
        dbgIteEstTVQTDPRO.Options.Editing := True;
        dbgIteEstTVQTDPRO.Options.Focusing := True;
      end
      Else
      begin
        dbgIteEstTVQTDPRO.Options.Editing := False;
        dbgIteEstTVQTDPRO.Options.Focusing := False;
      end;

      if fCfgSis('LOTBOP') = '2' then
      begin
        dbgIteEstTVNUMLOT.Options.Editing := True;
        dbgIteEstTVNUMLOT.Options.Focusing := True;
        pnlConLot.Visible := True;
      end
      else
      begin
        dbgIteEstTVNUMLOT.Options.Editing := False;
        dbgIteEstTVNUMLOT.Options.Focusing := False;
        pnlConLot.Visible := False;
      end;
    end;

    objOrdPro := TOrdPro.Create(Self, False);
    qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
    dbgIteEstTV.DataController.DataSource := objOrdPro.dtsIteEst;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'');
      Close;
    End;
  End;

  blnMonFas := fCfgSis('MONFAS', varBoolean);
  tbsFases.TabVisible := blnMonFas;
  btnCorrecoes.Visible := blnMonFas;
end;

procedure TfrmBaixaOrdProd.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsCadFas) Then
    FreeAndNil(cdsCadFas);
  If Assigned(frmCorrecoes) Then
    FreeAndNil(frmCorrecoes);
end;

procedure TfrmBaixaOrdProd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: If Not fEmptyStr(edtOrdPro.Text) Then
               Begin
                 Key := 0;
                 pLimpaCampos;

                 If Not fEmptyStr(strOrdPro) Then
                   blnFecharForm := True;

                 Self.Repaint;
               End;

    VK_F8    : Begin
                 Key := 0;
                 btnCadRapLotWMS.Click;
               End;
    VK_F9    : Begin
                 Key := 0;
                 btnCorrecoes.Click;
               End;

    VK_F7 : Begin
              Key := 0;
              btnLocFis.Click;
            End;

    VK_F3 : btnArmInd.click;


  End;


end;

procedure TfrmBaixaOrdProd.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmBaixaOrdProd.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtOrdPro);

  If Not fEmptyStr(strOrdPro) Then
  Begin
    edtOrdPro.Text := strOrdPro;
    If fValidaCampos(edtOrdPro, True) Then
    Begin
      edtOrdPro.Enabled := False;
      pSetFocus(edtProduzido);
    End
    Else
      blnFecharForm := True;
  End;
end;

function TfrmBaixaOrdProd.fValidaEdtArmazem: Boolean;
Begin
  Result := True;

  If Not pnlArmEnt.Visible Then
    Exit;

  If (fCfgSis('CTLEST') = '2') Then
  Begin
    If fEmptyStr(edtArmEnt.Text) Then
    Begin
      pMensagemOk('Informe o Armazém para o qual será dada a entrada do Produto Estrutura!');;
      Result := False;
    End
    Else
    Begin
      edtDesArm.Text := fRetNomeArmazem(edtArmEnt.Text);

      If fEmptyStr(edtDesArm.Text) Then
      Begin
        pMensagemOk('Armazém não encontrado!');
        Result := False;
      End

      Else If fCampoTabela('LOT_CODITE', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'],
               [objOrdPro.strCodIte, VS_strCodEmp, edtArmEnt.Text]) <> objOrdPro.strCodIte Then
      Begin
        pMensagemOk('Armazém não encontrado para esse item!');
        Result := False;
      End

      Else objOrdPro.strCodArm := edtArmEnt.Text;

    End;
  End
  Else
  Begin
    if fUsaRotinaWMS or objOrdPro.blnTemArm then
    begin
      //se informou os armazéns individuais, limpa o armazém único.
      if not objOrdPro.objLotInd.cdsLotInd.isEmpty then
      begin
        objOrdPro.strCodArm := '';
        Result := True;
        exit;
      end;

      If fEmptyStr(edtArmEnt.Text) Then
      Begin
        pMensagemOk('Informe o Lote para o qual será dada a entrada do Produto Estrutura!');;
        Result := False;
      End
      Else
      Begin

        If fCampoTabela('LOT_CODITE', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'],
                 [objOrdPro.strCodIte, VS_strCodEmp, edtArmEnt.Text]) <> objOrdPro.strCodIte Then
        Begin
          If Not fCfgSis('LOTORD', varBoolean) Then {LOTORD -> habilitada irá gerar o cadastro do lote automaticamente}
          Begin
            pMensagemOk('Lote não encontrado para esse item!');
            Result := False;
          End
          Else
            objOrdPro.strCodArm := edtArmEnt.Text;
        End

        Else objOrdPro.strCodArm := edtArmEnt.Text;

      End;
    End;
  End;

End;

function TfrmBaixaOrdProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtOrdPro)And blnBuscaPorChave Then
    Result := fValidaEdtOrdPro(blnBuscaPorChave)

  Else If (Sender = edtProduzido) Then
    Result := fValidaEdtProduzido

  Else If (Sender = edtArmEnt) Then
    Result := fValidaEdtArmazem;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmBaixaOrdProd.fValidaEdtOrdPro(blnBuscaPorChave: Boolean): Boolean;
begin
  Try
    If fEmptyStr(edtOrdPro.Text) Then
    Begin
      fMensagem('','O campo ordem de produção deve ser digitado!', ['&OK']);
      Result := False;
    End
    Else
    Begin

      If blnBuscaPorChave And objOrdPro.fCarregaOrdPro(edtOrdPro.Text) Then
      Begin
        Result := fCarregaDados;
        If Not Result Then
        Begin
          objOrdPro.qryOrdPro.Close;
          objOrdPro.pAtuDados;
        End
        Else
        Begin
          If blnMonFas Then
            fCarregaFases(edtCodIte.Text, edtOrdPro.Text);
        End;
      End
      Else
      Begin
        fMensagem('','Ordem de produção não encontrada!',['&OK']);
        Result := False;
      End;

    End;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[function TfrmBaixaOrdProd.fValidaEdtProduzido: Boolean;]');
    End;
  End;
end;

function TfrmBaixaOrdProd.fValidaEdtProduzido: Boolean;
begin
  Try
    Result := True;
    If fEmptyStr(edtProduzido.Text) Then
    Begin
      fMensagem('','O campo produzido deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else If (fStrToFloat(edtProduzido.Text) <= 0) Then
    Begin
      fMensagem('','A quantidade produzida deve ser maior que zero!', ['&OK']);
      Result := False;
    End
    Else If objOrdPro.blnRecSub Then
      Result := objOrdPro.fAtualizaQtdSubProd(objOrdPro.strCodPro, fStrToFloat(edtProduzido.Text));

    if Result then
      objOrdPro.strQtdPro := edtProduzido.Text;
  Except
    Result := False;
  End;
end;

function TfrmBaixaOrdProd.fCarregaDados : Boolean;
begin
  Result := True;
  If fEmptyStr(strOrdPro) And (Not fLock_Unlock('ORDPRO_' + edtOrdPro.Text + '_' + VS_strCodEmp, True, False, False, '', False)) Then
  Begin
    Screen.Cursor := crDefault;

    Result := fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                             fGetHostLock('ORDPRO_' + edtOrdPro.Text + '_' + VS_strCodEmp)  + '!', ['&Ok']) = -1;
    Exit;
  End;

  edtCodCli.Text    := objOrdPro.strCodCli;
  edtDesCli.Text    := objOrdPro.strDesCli;
  edtCodIte.Text    := objOrdPro.strCodIte;
  edtDesIte.Text    := objOrdPro.strDesIte;
  edtObs001.Text    := objOrdPro.strObs001;
  edtObs002.Text    := objOrdPro.strObs002;
  edtProduzir.Text  := objOrdPro.strQtdApr;

  chkConLotClick(chkConLot);

  If (fCfgSis('BXOPPA', varString) = 'N') Then
  Begin
    edtProduzido.Text := edtProduzir.Text;
    edtProduzido.ReadOnly := True;
  End;

  If (fCfgSis('TCORPR') = '2') or (fCfgSis('LOTBOP') = '2') Then
    objOrdPro.fAtualizaQtdSubProd(objOrdPro.strCodPro,
      IIF(objOrdPro.blnRecSub, 1, fStrToFloat(objOrdPro.strQtdApr)));


  edtArmEnt.Enabled := (not fCfgSis('LOTORD', varBoolean)) and objOrdPro.blnTemArm;
  lblArmEnt.Enabled := edtArmEnt.Enabled;

  If edtArmEnt.Enabled or fCfgSis('LOTORD', varBoolean) Then
  Begin
    edtArmEnt.Text := objOrdPro.strCodArm;
    edtDesArm.Text := fRetNomeArmazem(edtArmEnt.Text);
  End;  
end;

function TfrmBaixaOrdProd.fOrdPro: TOrdPro;
begin
  Result := objOrdPro;
end;

procedure TfrmBaixaOrdProd.pLimpaCampos;
begin
  If NOT fEmptyStr(edtOrdPro.Text) Then
    fLock_Unlock('ORDPRO_' + edtOrdPro.Text + '_' + VS_strCodEmp, False, False, False, '', False);

  edtOrdPro.Clear;
  edtCodCli.Clear;
  edtDesCli.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtObs001.Clear;
  edtObs002.Clear;
  edtProduzir.Clear;
  edtProduzido.Clear;
  edtConfPor.Clear;
  pSetFocus(edtOrdPro);
  objOrdPro.cdsIteEst.Close;

  edtArmEnt.Clear;
  edtDesArm.Clear;
  edtArmEnt.Enabled := False;
  lblArmEnt.Enabled := False;

  If Assigned(cdsCadFas) Then
    cdsCadFas.EmptyDataSet;
end;

function TfrmBaixaOrdProd.fGetSQLFases: String;
begin
  Result := '';
  Result := Result + 'SELECT                                                                ';
  Result := Result + ' FASGER.AUTOINCREM,                                                   ';
  Result := Result + ' FAS_CODIGO,                                                          ';
  Result := Result + ' FAS_SEQUEN,                                                          ';
  Result := Result + ' FAS_DESFAS,                                                          ';
  Result := Result + ' (CASE                                                                ';
  Result := Result + '   WHEN MNTORD.AUTOINCREM IS NULL THEN "Não iniciada"                 ';
  Result := Result + '   WHEN (MNT_DTAINI IS NOT NULL) AND (MNT_DTAFIN IS NULL) THEN "Não finalizada" ';
  Result := Result + '   ELSE "Finalizada"                                                  ';
  Result := Result + '  END) AS FAS_STATUS                                                  ';
  Result := Result + ' FROM FASMAT                                                          ';
  Result := Result + '  INNER JOIN FASGER ON MAT_SEQFAS = FASGER.AUTOINCREM                 ';
  Result := Result + '  INNER JOIN GERMAT ON MAT_SEQMAT = GERMAT.AUTOINCREM                 ';
  Result := Result + '                   AND GMT_CODITE = :CODITE                           ';
  Result := Result + '  LEFT JOIN MOVPRO ON PRO_CODPRO = :CODORD                            ';
  Result := Result + '  LEFT JOIN MNTORD ON MNT_SEQFAS = FASGER.AUTOINCREM                  ';
  Result := Result + '                  AND MNT_SEQORD = MOVPRO.AUTOINCREM                  ';
  Result := Result + ' WHERE TRUE                                                           ';
  Result := Result + '   AND MAT_CODEMP = :CODEMP                                           ';
  Result := Result + '   AND PRO_CODEMP = :CODEMP                                           ';
  Result := Result + ' GROUP BY FASGER.AUTOINCREM                                           ';
  Result := Result + ' ORDER BY FAS_SEQUEN                                                  ';
end;

function TfrmBaixaOrdProd.fCarregaFases(AStrCodIte, AStrCodOrd: String): boolean;
begin
  cdsCadFas := TZClient.Create(Self, fGetSQLFases);
  cdsCadFas.qryQuery.ParamByName('CODITE').AsString := AStrCodIte;
  cdsCadFas.qryQuery.ParamByName('CODORD').AsString := AStrCodOrd;
  cdsCadFas.qryQuery.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  Result := cdsCadFas.fAbreClient(True, 'TfrmManOrdPro.fCarregaFases');
  cdsCadFas.IndexFieldNames := 'FAS_SEQUEN';

  cxgCadFasView.DataController.DataSource := cdsCadFas.dtsSource;

  tbsFases.TabVisible := Not cdsCadFas.isEmpty;
end;

end.
