unit untCadParametrosEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxDropDownEdit,
  cxGridBandedTableView, cxGridDBBandedTableView,
  untParametrosEmpresa, cxCheckBox, dxScreenTip, dxCustomHint, cxHint;

type
  TTipoNivelGiro = (tnvGeral, tnvNivelGiro, tnvCriticidade, tnvNivelGiroCriticidade, tnvIndefinido);

  TfrmCadParametrosEmpresa = class(TfrmPaiConfirma)
    cxgEmpresas: TcxGrid;
    cxgEmpresasLevel1: TcxGridLevel;
    cxvEmpresas: TcxGridDBBandedTableView;
    cxvEmpresasCODEMP: TcxGridDBBandedColumn;
    cxvEmpresasNOMEMP: TcxGridDBBandedColumn;
    cxvEmpresasTIPEMP: TcxGridDBBandedColumn;
    cxvEmpresasDIAMIN: TcxGridDBBandedColumn;
    cxvEmpresasFATMAX: TcxGridDBBandedColumn;
    cxvEmpresasDIAMAG: TcxGridDBBandedColumn;
    cxvEmpresasDIAMAA: TcxGridDBBandedColumn;
    cxvEmpresasDIAMAB: TcxGridDBBandedColumn;
    cxvEmpresasDIAMAC: TcxGridDBBandedColumn;
    cxvEmpresasPONPED: TcxGridDBBandedColumn;
    cxvEmpresasPONNIC: TcxGridDBBandedColumn;
    cxvEmpresasPONGER: TcxGridDBBandedColumn;
    cxvEmpresasPONNIB: TcxGridDBBandedColumn;
    cxvEmpresasPONNIA: TcxGridDBBandedColumn;
    cxvEmpresasMESGIR: TcxGridDBBandedColumn;
    cxvEmpresasDIAGIR: TcxGridDBBandedColumn;
    cxvEmpresasSUGGAR: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvEmpresasEMPHUB: TcxGridDBBandedColumn;
    cxvEmpresasDESABA: TcxGridDBBandedColumn;
    cxvEmpresasColumn2: TcxGridDBBandedColumn;
    cxvEmpresasDESMAI: TcxGridDBBandedColumn;
    btnCopia: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    cxvEmpresasMARDES: TcxGridDBBandedColumn;
    cxHintStyleController1: TcxHintStyleController;
    cxvEmpresasDIAMAX: TcxGridDBBandedColumn;
    cxvEmpresasDIAMAY: TcxGridDBBandedColumn;
    cxvEmpresasDIAMAZ: TcxGridDBBandedColumn;
    cxvEmpresasDIAMBY: TcxGridDBBandedColumn;
    cxvEmpresasDIAMBZ: TcxGridDBBandedColumn;
    cxvEmpresasDIAMBX: TcxGridDBBandedColumn;
    cxvEmpresasDIAMCX: TcxGridDBBandedColumn;
    cxvEmpresasDIAMCY: TcxGridDBBandedColumn;
    cxvEmpresasDIAMCZ: TcxGridDBBandedColumn;
    cxvEmpresasDIAMNX: TcxGridDBBandedColumn;
    cxvEmpresasDIAMNY: TcxGridDBBandedColumn;
    cxvEmpresasDIAMNZ: TcxGridDBBandedColumn;

    cxvEmpresasPONNIX: TcxGridDBBandedColumn;
    cxvEmpresasPONNIY: TcxGridDBBandedColumn;
    cxvEmpresasPONNIZ: TcxGridDBBandedColumn;
    cxvEmpresasPONNAX: TcxGridDBBandedColumn;
    cxvEmpresasPONNAY: TcxGridDBBandedColumn;
    cxvEmpresasPONNAZ: TcxGridDBBandedColumn;
    cxvEmpresasPONNBX: TcxGridDBBandedColumn;
    cxvEmpresasPONNBY: TcxGridDBBandedColumn;
    cxvEmpresasPONNBZ: TcxGridDBBandedColumn;
    cxvEmpresasPONNCX: TcxGridDBBandedColumn;
    cxvEmpresasPONNCY: TcxGridDBBandedColumn;
    cxvEmpresasPONNCZ: TcxGridDBBandedColumn;
    pnlAtivacaoPorProduto: TPanel;
    chkAtivaProduto: TCheckBox;
    pnlRodape: TPanel;
    chkReplicaItens: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cxvEmpresasEMPHUBPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvEmpresasEMPHUBPropertiesCloseUp(Sender: TObject);
    procedure btnCopiaClick(Sender: TObject);
    procedure cxvEmpresasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure cxvEmpresasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cxvEmpresasDESABAPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvEmpresasCanFocusRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure cxvEmpresasPONPEDPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure pDesabilitaDiasCompras;
    procedure pDesabilitaNivelSeguranca;
    procedure chkAtivaProdutoClick(Sender: TObject);
    procedure cxvEmpresasTIPEMPPropertiesCloseUp(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);


  private
    FHintDisplayed: Boolean;
    FblnOrigemProduto: Boolean;
    FColumn: TcxGridColumn;
    FCodIte: string;
    DadosBackup: OleVariant;
    { Private declarations }
    objParametros: TParametrosEmpresa;
    function fRetTIpoNivelGiro(strGiroSelecionado: string): TTipoNivelGiro;
    procedure pSetaEdicaoNivelSeguranca(TipoNivelGiro: TTipoNivelGiro);
    Procedure pSetaEdicaoNivelDiasCompra(TipoNivelGiro: TTipoNivelGiro);
    procedure pAjustaTelaQuandoOriundoCadProduto;
    procedure pRestauraDados;



  public
    strCodIte: String;
    class function fCriaTela: TfrmCadParametrosEmpresa;
    procedure pInicia(strCodIte: String);
    function fSalvaDadosCadProdutos(ACodIte: String): Boolean;
    procedure pConfirmaReplicacao;

    { Public declarations }
  end;

implementation

{$R *.dfm}

Uses
  Uni,
  untFuncoesSimples,
  untCopiaParametrosEmpresa;

procedure TfrmCadParametrosEmpresa.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  objParametros.blnReplicarMesmoFornecedor := chkReplicaItens.Checked;
end;

procedure TfrmCadParametrosEmpresa.btnCopiaClick(Sender: TObject);
  Var
    frmCopiaParametrosEmpresa: TfrmCopiaParametrosEmpresa;
begin
  inherited;

  pCriarFormularios(TfrmCopiaParametrosEmpresa, frmCopiaParametrosEmpresa);

  frmCopiaParametrosEmpresa.objParametros := objParametros;
  frmCopiaParametrosEmpresa.lblEmpresas.Caption := 'Copia as colunas da empresa: ' + objParametros.FieldByName('PAR_CODEMP').AsString + '-' +
                                                                                     objParametros.FieldByName('PAR_NOMEMP').AsString;
  frmCopiaParametrosEmpresa.cxvColunas.DataController.DataSource := objParametros.cdsColunasCopia.dtsSource;
  frmCopiaParametrosEmpresa.ShowModal;

  pFreeAndNil(frmCopiaParametrosEmpresa);
end;

procedure TfrmCadParametrosEmpresa.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objParametros.pMarcaTodasEmpresas(False);
end;

procedure TfrmCadParametrosEmpresa.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objParametros.pMarcaTodasEmpresas(True);
end;

procedure TfrmCadParametrosEmpresa.btnMarDesClick(Sender: TObject);
begin
  inherited;

  objParametros.pMarcaDesmarca;
end;

procedure TfrmCadParametrosEmpresa.pSetaEdicaoNivelSeguranca(TipoNivelGiro: TTipoNivelGiro);
Begin
  case TipoNivelGiro Of
    tnvGeral: cxvEmpresasPONGER.Options.Editing := True;

    tnvNivelGiro: Begin
                    cxvEmpresasPONNIA.Options.Editing := True;
                    cxvEmpresasPONNIB.Options.Editing := True;
                    cxvEmpresasPONNIC.Options.Editing := True;
                  End;

    tnvCriticidade: Begin
                      cxvEmpresasPONNIX.Options.Editing := True;
                      cxvEmpresasPONNIY.Options.Editing := True;
                      cxvEmpresasPONNIZ.Options.Editing := True;
                    End;

    tnvNivelGiroCriticidade: Begin
                                cxvEmpresasPONNAX.Options.Editing := True;
                                cxvEmpresasPONNAY.Options.Editing := True;
                                cxvEmpresasPONNAZ.Options.Editing := True;
                                cxvEmpresasPONNBX.Options.Editing := True;
                                cxvEmpresasPONNBY.Options.Editing := True;
                                cxvEmpresasPONNBZ.Options.Editing := True;
                                cxvEmpresasPONNCX.Options.Editing := True;
                                cxvEmpresasPONNCY.Options.Editing := True;
                                cxvEmpresasPONNCZ.Options.Editing := True;
                             End;
  End;
End;

Procedure TfrmCadParametrosEmpresa.pSetaEdicaoNivelDiasCompra(TipoNivelGiro: TTipoNivelGiro);
Begin
  case TipoNivelGiro Of
    tnvGeral: cxvEmpresasDIAMAG.Options.Editing := True;
    tnvNivelGiro: Begin
                    cxvEmpresasDIAMAA.Options.Editing := True;
                    cxvEmpresasDIAMAB.Options.Editing := True;
                    cxvEmpresasDIAMAC.Options.Editing := True;
                  End;
    tnvCriticidade: Begin
                      cxvEmpresasDIAMNX.Options.Editing := True;
                      cxvEmpresasDIAMNY.Options.Editing := True;
                      cxvEmpresasDIAMNZ.Options.Editing := True;
                    End;
    tnvNivelGiroCriticidade: Begin
                                cxvEmpresasDIAMAX.Options.Editing := True;
                                cxvEmpresasDIAMAY.Options.Editing := True;
                                cxvEmpresasDIAMAZ.Options.Editing := True;
                                cxvEmpresasDIAMBY.Options.Editing := True;
                                cxvEmpresasDIAMBZ.Options.Editing := True;
                                cxvEmpresasDIAMBX.Options.Editing := True;
                                cxvEmpresasDIAMCX.Options.Editing := True;
                                cxvEmpresasDIAMCY.Options.Editing := True;
                                cxvEmpresasDIAMCZ.Options.Editing := True;
                             End;
  End;
End;


procedure TfrmCadParametrosEmpresa.pDesabilitaDiasCompras;
begin
  cxvEmpresasDIAMAG.Options.Editing := False;

  cxvEmpresasDIAMAA.Options.Editing := False;
  cxvEmpresasDIAMAB.Options.Editing := False;
  cxvEmpresasDIAMAC.Options.Editing := False;

  cxvEmpresasDIAMNX.Options.Editing := False;
  cxvEmpresasDIAMNY.Options.Editing := False;
  cxvEmpresasDIAMNZ.Options.Editing := False;

  cxvEmpresasDIAMAX.Options.Editing := False;
  cxvEmpresasDIAMAY.Options.Editing := False;
  cxvEmpresasDIAMAZ.Options.Editing := False;
  cxvEmpresasDIAMBY.Options.Editing := False;
  cxvEmpresasDIAMBZ.Options.Editing := False;
  cxvEmpresasDIAMBX.Options.Editing := False;
  cxvEmpresasDIAMCX.Options.Editing := False;
  cxvEmpresasDIAMCY.Options.Editing := False;
  cxvEmpresasDIAMCZ.Options.Editing := False;
end;

procedure TfrmCadParametrosEmpresa.pDesabilitaNivelSeguranca;
begin
  cxvEmpresasPONGER.Options.Editing := False;
  cxvEmpresasPONNIA.Options.Editing := False;
  cxvEmpresasPONNIB.Options.Editing := False;
  cxvEmpresasPONNIC.Options.Editing := False;
  cxvEmpresasPONNIX.Options.Editing := False;
  cxvEmpresasPONNIY.Options.Editing := False;
  cxvEmpresasPONNIZ.Options.Editing := False;
  cxvEmpresasPONNAX.Options.Editing := False;
  cxvEmpresasPONNAY.Options.Editing := False;
  cxvEmpresasPONNAZ.Options.Editing := False;
  cxvEmpresasPONNBX.Options.Editing := False;
  cxvEmpresasPONNBY.Options.Editing := False;
  cxvEmpresasPONNBZ.Options.Editing := False;
  cxvEmpresasPONNCX.Options.Editing := False;
  cxvEmpresasPONNCY.Options.Editing := False;
  cxvEmpresasPONNCZ.Options.Editing := False;
End;


procedure TfrmCadParametrosEmpresa.chkAtivaProdutoClick(Sender: TObject);
begin
  inherited;
  If Not FblnOrigemProduto Then
    Exit;
  If chkAtivaProduto.Checked Then
  Begin
    If objParametros.IsEmpty then
    Begin
      pInicia(FCodIte);
      If objParametros.IsEmpty then
        objParametros.pCopiaParEmp;
      chkAtivaProduto.Checked := Not objParametros.IsEmpty;
    End;
  End
  Else
    objParametros.RemoveTodosQuandoPorItem;
end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasCanFocusRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
begin
  inherited;

  pDesabilitaDiasCompras;
  pDesabilitaNivelSeguranca;

  pSetaEdicaoNivelSeguranca(fRetTIpoNivelGiro(VarToStr(Sender.DataController.Values[ARecord.Index, cxvEmpresasPONPED.Index])));
  pSetaEdicaoNivelDiasCompra(fRetTIpoNivelGiro(VarToStr(Sender.DataController.Values[ARecord.Index, cxvEmpresasDESABA.Index])));

end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxvEmpresasMARDES.Index])) = 'S' Then
  Begin

    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;


End;


procedure TfrmCadParametrosEmpresa.cxvEmpresasDESABAPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  pDesabilitaDiasCompras;
  pSetaEdicaoNivelDiasCompra(fRetTIpoNivelGiro(DisplayValue));
end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasEMPHUBPropertiesCloseUp(
  Sender: TObject);
begin
  inherited;

  If objParametros.State = dsEdit Then
    objParametros.Post;
end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasEMPHUBPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;

  var Error: Boolean);
begin
  inherited;

  If (Not fEmptyStr(DisplayValue)) And
      SameText(DisplayValue, cxvEmpresas.DataController.Values[cxvEmpresas.DataController.FocusedRecordIndex,
                                                               cxvEmpresasCODEMP.Index]) Then
  Begin
    Error     := True;
    ErrorText := '';
    DisplayValue := '';
    pMensagemOk('A empresa não pode ser a HUB dela mesma!');
  End;

end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AHint: string;
  AColumn: TcxGridColumn;
begin
  AHint := '';
  if not Assigned(Sender) then exit;
  if not (Sender is TcxGridSite) then exit;
  //determine the current mouse position
  AHitTest := TcxGridSite(Sender).ViewInfo.GetHitTest(X, Y);
  //hide displayed hint if mouse is not over a grid header
  if (AHitTest.HitTestCode <> htBandHeader) And (AHitTest.HitTestCode <> htColumnHeader) then
  begin
    FHintDisplayed := False;
    TcxCustomHintStyleController(cxHintStyleController1).HideHint;
    Exit;
  end;

  if (AHitTest.HitTestCode = htBandHeader) Or
     (AHitTest.HitTestCode = htColumnHeader) Then
  with TcxGridColumnHeaderHitTest(AHitTest) do
  begin
    {check the current column over which the mouse is placed}
    AColumn := Column;


    If (AHitTest.HitTestCode = htColumnHeader) Then
      if (TcxGridDBColumn(AColumn).DataBinding.FieldName = 'PAR_DIAMIN') Or
         (TcxGridDBColumn(AColumn).DataBinding.FieldName = 'PAR_FATMAX') Then
        AHint := '  Os dados informados nos campos: "Dia est. mínimo" e "Fator est. máximo" serão utilizados para gravar os campos "Estoque mínimo" e "Estoque máximo" ' + #$A#$D +
                 'do cadastro de produtos e será utilizado nas rotinas de abastecimento e Digitação de Pedido de Compras tradicional, não tendo interferência alguma' + #$A#$D +
                 'na Pasta de compras"';
    If (AHitTest.HitTestCode = htBandHeader) Then
      if TcxGridBand(AColumn).Index = 4 Then
          AHint := 'A quantidade de dias informada no campo "Estoque de Segurança" é uma variável para definir qual será o Ponto de Pedido.' + #$A#$D +
                   'A fórmula para o Ponto de Pedido é a seguinte:' + #$A#$D +
                   'Média diária de venda * (Estoque de Segurança + Prazo de Entrega)' + #$A#$D +
                   'O campo "Prazo de Entrega" está localizado na aba "10 - Prazo de Entrega" do cadastro de Fornecedores e também é informada em dias.';
    if (FColumn <> Column) or (not FHintDisplayed) then
    begin
      //redisplay hint window is mouse has been moved to a new cell
      cxHintStyleController1.HideHint;
      {store the current column}
      FColumn := Column;
      {obtain the current cell display text}
      //AHint := cxGrid1DBTableView2.DataController.DisplayTexts[GridRecord.RecordIndex, Item.Index];
      with cxvEmpresas.Site.ClientToScreen(Point(X, Y)) do
      begin
        If AHint <> '' Then
        Begin
          FHintDisplayed := True;
          {show hint}
          cxHintStyleController1.ShowHint(X, Y, '', AHint);
        End;
      end;
    end;
  end;

end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasPONPEDPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  pDesabilitaNivelSeguranca;
  pSetaEdicaoNivelSeguranca(fRetTIpoNivelGiro(DisplayValue));
end;

procedure TfrmCadParametrosEmpresa.cxvEmpresasTIPEMPPropertiesCloseUp(
  Sender: TObject);
begin
  inherited;
  If objParametros.State = dsEdit Then
    objParametros.Post;
end;

procedure TfrmCadParametrosEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not objParametros.fValidaDados Then
    Begin
      Action := caNone;
      pSetFocus(cxgEmpresas);
      Exit;
    End;
    If FblnOrigemProduto Then
      Exit
    Else
    If objParametros.fSalvaDados Then
      pMensagemOk('Dados salvos com sucesso!')
    Else
      Action := caNone;

  End Else
  Begin

    If (objParametros.ChangeCount > 0) then
    Begin
      If (Not fPergunta('Há alterações não salvas, deseja abandonar a tarefa?', False)) Then
        Action := caNone
      Else
        pRestauraDados;
    End
    Else
      pRestauraDados;
  End;
end;

procedure TfrmCadParametrosEmpresa.pRestauraDados;
begin
  If FCodIte <> '' Then
    objParametros.Data := DadosBackup;
End;

procedure TfrmCadParametrosEmpresa.pInicia(strCodIte: String);
Begin
  If Assigned(objParametros) Then
    FreeAndNil(objParametros);
  FCodIte := strCodIte;
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;
  FblnOrigemProduto := strCodIte <> '' ;
  objParametros := TParametrosEmpresa.Create(Self);
  If strCodIte <> '' Then
    objParametros.pSetCodIte(FCodIte);
  objParametros.fCarregaDados;

  pAjustaTelaQuandoOriundoCadProduto;

  cxvEmpresas.DataController.DataSource := objParametros.dtsSource;
End;


procedure TfrmCadParametrosEmpresa.pAjustaTelaQuandoOriundoCadProduto;
Begin
  If not fEmptyStr(FCodIte) Then
  Begin
    pnlAtivacaoPorProduto.Visible := True;
    chkAtivaProduto.Checked := Not objParametros.IsEmpty;
  End;
End;

procedure TfrmCadParametrosEmpresa.pConfirmaReplicacao;
begin
  objParametros.pConfirmaReplicacaoMesmoFornecedor;
end;

class function TfrmCadParametrosEmpresa.fCriaTela: TfrmCadParametrosEmpresa;
Begin
  pCriarFormularios(TfrmCadParametrosEmpresa, Result);
End;

procedure TfrmCadParametrosEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    strCodEmp: String;
begin
  inherited;

  Case Key Of
    VK_F5:     btnCopia.Click;
    VK_F6:     btnMarcaTodos.Click;
    VK_F7:     btnDesmarcaTodos.Click;

    VK_F8:     btnMarDes.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgEmpresas) Then
               Begin
                 If cxvEmpresasDIAGIR.Focused Then
                 Begin
                   strCodEmp := objParametros.FieldByName('PAR_CODEMP').AsString;
                   cxvEmpresas.NavigatorButtons.Next.Click;

                   If strCodEmp = objParametros.FieldByName('PAR_CODEMP').AsString Then
                     pSetFocus(btnConfirma)
                   Else
                     cxvEmpresasTIPEMP.Focused := True;
                 End;
               End;

    VK_F10:     btnConfirma.Click;
  End;
end;

procedure TfrmCadParametrosEmpresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Case Key Of
    '-' : Key := #0;
  End;
end;

procedure TfrmCadParametrosEmpresa.FormShow(Sender: TObject);

  Function fRetListaEmpresas: String;
    Var
      qryCadEmp: TUniQuery;
      stlLista: TStringList;
  Begin
    qryCadEmp := fCriaQuery;

    qryCadEmp.SQL.Text := 'SELECT GROUP_CONCAT(EMP_CODEMP) AS EMPS FROM CADEMP ORDER BY EMP_CODEMP';
    qryCadEmp.Open;

    stlLista      := TStringList.Create;
    stlLista.CommaText := qryCadEmp.FieldByName('EMPS').AsString;

    Result := stlLista.Text;

    FreeAndNil(stlLista);
    FreeAndNil(qryCadEmp);
  End;

begin
  inherited;
  If Not FblnOrigemProduto Then
    pInicia('')
  Else
    DadosBackup := objParametros.Data;

  cxvEmpresasTIPEMP.Focused := True;

  TcxComboBoxProperties(cxvEmpresasEMPHUB.Properties).Items.Text := fRetListaEmpresas;

  If FblnOrigemProduto Then
    pAjustaTelaQuandoOriundoCadProduto
end;

function TfrmCadParametrosEmpresa.fRetTipoNivelGiro(strGiroSelecionado: string): TTipoNivelGiro;
begin
  If strGiroSelecionado = 'Geral' Then
    Result := tnvGeral
  Else If strGiroSelecionado = 'ABC' Then
    Result := tnvNivelGiro
  Else If strGiroSelecionado = 'XYZ' Then
    Result := tnvCriticidade
  Else If strGiroSelecionado = 'ABC+XYZ' Then
    Result := tnvNivelGiroCriticidade
  Else
    Result := tnvIndefinido

end;

function TfrmCadParametrosEmpresa.fSalvaDadosCadProdutos(ACodIte: String): Boolean;
begin
 Result := objParametros.fSalvaDadosCadProdutos(ACodIte, chkAtivaProduto.Checked)
end;

end.
