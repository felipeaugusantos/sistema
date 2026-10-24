unit untGridRelatResult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Vcl.ComCtrls, cxMaskEdit,
  untInterfaceRelatorio, untfuncoesSimples, System.Actions, Vcl.ActnList;

type
  TcxGridSiteAccess = class(TcxGridSite);

  TfrmGridRelatResult = class(TfrmPaiEdit)
    pagPaginas: TPageControl;
    mnuClipboard: TPopupMenu;
    aclClipboard: TActionList;
    actCopy: TAction;
    actCopyWithHeader: TAction;
    mnuCopy: TMenuItem;
    mnuCopyWithHeaders: TMenuItem;
    btnImprimir: TBitBtnLocked;
    btnExcel: TBitBtnLocked;
    imgMarca: TImage;
    imgDesmarca: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actCopyWithHeaderExecute(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    procedure pAjustaDimensoesForm;

    Function fIndexGrid: Integer;

    procedure pRetornaValorCampo;

  public
    { Public declarations }
    intGridAtivo,
    intLarguraBotoes: Integer;

    blnConfirmarSaida: Boolean;

    intFinalRodape: Integer;

    objInteface: TInterfaceRelatorio;

    objGridRelatorio: Pointer;
  end;

var
  frmGridRelatResult: TfrmGridRelatResult;

implementation

{$R *.dfm}

uses
  untGridRelatorio,
  untPedeDestinoRel,
  untFuncEditorRel,
  cxGridExportLink;

Const
  INT_ESPACAMENTO_BOTAO = 1;

procedure TfrmGridRelatResult.actCopyExecute(Sender: TObject);
var
  objGridRel: TGridRelatorioGeral;
  intContador: Integer;
begin

  objGridRel := objGridRelatorio;

  with objGridRel do
  for intContador := Low(arrGrid) to High(arrGrid) do
  begin
    if Assigned(arrGrid[intContador]) then
    with arrGrid[intContador] do
    begin
      if Assigned(vdbConsultaView) then
      begin
        if (pagPaginas.PageCount = 0) or (intContador = pagPaginas.ActivePageIndex) then
        begin
          if vdbConsultaView.OptionsSelection.CellSelect then
          begin
             vdbConsultaView.OptionsBehavior.CopyCaptionsToClipboard := False;
             vdbConsultaView.CopyToClipboard(False);
          end;
        end;
      end;
    end;
  end;

end;

procedure TfrmGridRelatResult.actCopyWithHeaderExecute(Sender: TObject);
var
  objGridRel: TGridRelatorioGeral;
  intContador: Integer;
begin

  objGridRel := objGridRelatorio;

  with objGridRel do
  for intContador := Low(arrGrid) to High(arrGrid) do
  begin
    if Assigned(arrGrid[intContador]) then
    with arrGrid[intContador] do
    begin
      if Assigned(vdbConsultaView) then
      begin
        if (pagPaginas.PageCount = 0) or (intContador = pagPaginas.ActivePageIndex) then
        begin
          if vdbConsultaView.OptionsSelection.CellSelect then
          begin
             vdbConsultaView.OptionsBehavior.CopyCaptionsToClipboard := True;
             vdbConsultaView.CopyToClipboard(False);
          end;
        end;
      end;
    end;
  end;

end;

Function TfrmGridRelatResult.fIndexGrid: Integer;
Begin
  If (pagPaginas.PageCount = 0) Then
    Result := intGridAtivo
  Else
    Result := pagPaginas.ActivePage.Tag;
End;

procedure TfrmGridRelatResult.btnExcelClick(Sender: TObject);
  Var
    dlgOpen: TOpenDialog;
    objGridRel: TGridRelatorioGeral;
begin
  inherited;

  dlgOpen     := TOpenDialog.Create(Self);
  dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx';

  If dlgOpen.Execute Then
  Begin
    Try
     objGridRel := objGridRelatorio;

     If objGridRel.fGeraExcelJanela(fIndexGrid, dlgOpen.FileName) Then
       pMensagemOk('Arquivo gerado com sucesso!');

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.message, '[TfrmGridRelatResult.btnExcelClick]');
      End;
    End;
  End;

  FreeAndNil(dlgOpen);
end;

procedure TfrmGridRelatResult.pRetornaValorCampo;
  Var
    objGridRel: TGridRelatorioGeral;
    objInterface: TInterfaceRelatorio;
Begin
  objGridRel := objGridRelatorio;
  objInterface := TInterfaceRelatorio(objGridRel.objGeraFr3.fGetInterface);

  If Assigned(objInterface) And
     Assigned(objInterface.objParametrosRelatorio) And
     objInterface.objParametrosRelatorio.blnRetornaCampoComEnter And
     Assigned(objInterface.Dados[fIndexGrid].FindField(objInterface.objParametrosRelatorio.strCampoRetorno)) Then
  Begin
    objInterface.objParametrosRelatorio.strValorRetorno := objInterface.Dados[fIndexGrid].FieldByName(objInterface.objParametrosRelatorio.strCampoRetorno).AsString;
    Self.Close;
  End;
End;

procedure TfrmGridRelatResult.btnImprimirClick(Sender: TObject);
  Var
    frmPedeDestinoRel: TfrmPedeDestinoRel;
    objGridRel: TGridRelatorioGeral;
begin
  inherited;

  objGridRel := objGridRelatorio;

  If pagPaginas.Visible Then
    objInteface.intIndexGrid := pagPaginas.ActivePage.Tag;

  If (objInteface.intIndexGrid < Length(objGridRel.arrGrid)) And
     Assigned(objGridRel.arrGrid[objInteface.intIndexGrid]) Then
    If Assigned(objGridRel.arrGrid[objInteface.intIndexGrid].vdbConsultaView) Then
    Begin

      If Not fEmptyStr(objGridRel.arrGrid[objInteface.intIndexGrid].vdbConsultaView.ViewData.DataController.Filter.FilterCaption) Then
        TInterfaceRelatorio(objGridRel.arrGrid[0].objGeraFr3.objInterfaceGera).strFiltroGrid :=
          objGridRel.arrGrid[objInteface.intIndexGrid].vdbConsultaView.ViewData.DataController.Filter.FilterCaption

    End
    Else If Assigned(objGridRel.arrGrid[objInteface.intIndexGrid].vbtConsultaBandedView) Then
    Begin

      If Not fEmptyStr(objGridRel.arrGrid[objInteface.intIndexGrid].vbtConsultaBandedView.ViewData.DataController.Filter.FilterCaption) Then
        TInterfaceRelatorio(objGridRel.arrGrid[0]).strFiltroGrid :=
          objGridRel.arrGrid[objInteface.intIndexGrid].vbtConsultaBandedView.ViewData.DataController.Filter.FilterCaption;
    End;

  pCriarFormularios(TfrmPedeDestinoRel, frmPedeDestinoRel);

  frmPedeDestinoRel.pMontaDestinos(objInteface.arrCadRel[0].FieldByName('REL_DESTIN').AsString);
  If frmPedeDestinoRel.ShowModal = mrOK Then
  Begin
    objInteface.blnImpressaoGrid := True;

    Try
      objInteface.desDestinoGrid := frmPedeDestinoRel.fGetDestinoRel;
      objInteface.fExecutaRelatorio;

    Finally
      objInteface.blnImpressaoGrid := False;
    End;

  End;

  pFreeAndNil(frmPedeDestinoRel);
end;

procedure TfrmGridRelatResult.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If blnConfirmarSaida And (Not fPergunta('Deseja abandonar a tarefa?')) Then
  Begin
    Action := caNone;
    Exit;
  End;

  If Assigned(objInteface) Then
  Begin
    objInteface.intAlturaGrid  := Height;
    objInteface.intLarguraGrid := Width;
  End;

end;

procedure TfrmGridRelatResult.FormCreate(Sender: TObject);
begin
  inherited;

  intGridAtivo := 0;

  blnConfirmarSaida := False;

  intLarguraBotoes := btnExcel.Width + INT_ESPACAMENTO_BOTAO + btnSair.Width + INT_ESPACAMENTO_BOTAO;

  intFinalRodape := 0;

  objInteface := Nil;
end;

procedure TfrmGridRelatResult.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  objGridRel: TGridRelatorioGeral;
begin
  inherited;

  objGridRel := objGridRelatorio;

  Case Key Of
    VK_RETURN: pRetornaValorCampo;
  End;

  If (Key <> VK_RETURN) and (Key <> VK_ESCAPE) Then
    objGridRel.arrGrid[fIndexGrid].fGetObjBotoes.pExecutaRotinaTeclaAtalho(Key, Shift, Self.FlwBotoes);

end;

procedure TfrmGridRelatResult.FormShow(Sender: TObject);
Begin
  inherited;
  pAjustaDimensoesForm;

  btnExcel.Visible := objInteface.arrCadRel[0].FieldByName('REL_EXCGRI').AsString = 'S';

  If Assigned(objInteface) And Assigned(objInteface.arrCadRel) Then
    pnlInfo.Caption   := ' Rel: ' + objInteface.arrCadRel[0].FieldByName('REL_CODREL').AsString;

  pSetFocus(btnSair);
End;

procedure TfrmGridRelatResult.pAjustaDimensoesForm;
  Var
    objGridRel: TGridRelatorioGeral;
    intWidth,
    intMaxWidth,
    intContador,
    intColunas: Integer;
    blnPrimeiroGrid: Boolean;
begin
  If Not Assigned(objInteface) Then
    Exit;

  If (objInteface.intAlturaGrid > 0) Then
    Height := objInteface.intAlturaGrid;

  intMaxWidth := 0;

  Self.Width := Screen.Width;

  objGridRel := objGridRelatorio;

  blnPrimeiroGrid := True;

  With objGridRel Do
  For intContador := Low(arrGrid) To High(arrGrid) Do
    If Assigned(arrGrid[intContador]) Then
    With arrGrid[intContador] Do
    Begin

      If Assigned(vdbConsultaView) Then
      Begin
        intWidth := 14;

        For intColunas := 0 To vdbConsultaView.ViewInfo.HeaderViewInfo.Count - 1 Do
          If (Not blnPrimeiroGrid) Or vdbConsultaView.ViewInfo.HeaderViewInfo.Items[intColunas].Visible Then
            Inc(intWidth, vdbConsultaView.ViewInfo.HeaderViewInfo.Items[intColunas].Width);

        If TcxGridSiteAccess(vdbConsultaView.Site).VScrollBarVisible Then
          intWidth := intWidth +  TcxGridSiteAccess(vdbConsultaView.Site).VScrollBar.Width;

        If (intWidth > intMaxWidth) Then
          intMaxWidth := intWidth;

        blnPrimeiroGrid := False;

        vdbConsultaView.PopupMenu := mnuClipboard;
        vdbConsultaView.OptionsSelection.CellSelect := True;
        vdbConsultaView.OptionsSelection.MultiSelect := True;
        vdbConsultaView.OptionsSelection.CellMultiSelect := True;

      End Else If Assigned(vbtConsultaBandedView) Then
      Begin

        intWidth := 14;

        For intColunas := 0 To vbtConsultaBandedView.ViewInfo.HeaderViewInfo.Count - 1 Do
          If (Not blnPrimeiroGrid) Or vbtConsultaBandedView.ViewInfo.HeaderViewInfo.Items[intColunas].Visible Then
            Inc(intWidth, vbtConsultaBandedView.ViewInfo.HeaderViewInfo.Items[intColunas].Width);

        If TcxGridSiteAccess(vbtConsultaBandedView.Site).VScrollBarVisible Then
          intWidth := intWidth +  TcxGridSiteAccess(vbtConsultaBandedView.Site).VScrollBar.Width;

        If (intWidth > intMaxWidth) Then
          intMaxWidth := intWidth;

        blnPrimeiroGrid := False;

        vbtConsultaBandedView.PopupMenu := mnuClipboard;
        vbtConsultaBandedView.OptionsSelection.CellSelect := True;
        vbtConsultaBandedView.OptionsSelection.MultiSelect := True;
        vbtConsultaBandedView.OptionsSelection.CellMultiSelect := True;

      End;

    End;

  Self.ClientWidth := intMaxWidth;

  If pagPaginas.Visible Then
    Self.Width := Self.Width + 8;

  If intFinalRodape + 15 > Self.ClientWidth Then
    Self.ClientWidth := intFinalRodape + 15;

  If btnImprimir.Visible Then
    intLarguraBotoes := intLarguraBotoes + btnImprimir.Width + INT_ESPACAMENTO_BOTAO;

  If intLarguraBotoes > Self.ClientWidth Then
    Self.ClientWidth := intLarguraBotoes;

  If (Self.Width > Screen.Width) And (Self.Height > Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) Then
  Begin
    Self.WindowState := wsMaximized;
  End Else
  Begin
    If Self.Width > Screen.Width Then
      Self.Width := Screen.Width;

    If Self.Height > Screen.Height - VS_HEIGHT_START_MENU_WINDOWS Then
      Self.Height := Screen.Height - VS_HEIGHT_START_MENU_WINDOWS - 5;
  End;
end;


end.
