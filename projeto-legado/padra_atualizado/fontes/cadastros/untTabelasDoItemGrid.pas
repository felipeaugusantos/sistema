unit untTabelasDoItemGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, cxTextEdit, untTabelasDoItem, cxCurrencyEdit,
  cxVGrid, cxDBVGrid, cxInplaceContainer;

Type
  TfrmTabelasDoItemGrid = class(TFrame)
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    cxsColunaFixa: TcxStyle;
    cxsColunaFixaDestaque: TcxStyle;
    cxsPreco: TcxStyle;
    cxsMargem: TcxStyle;
    cxsTituloBlue: TcxStyle;
    cxsTituloRed: TcxStyle;
    cxsNegrito: TcxStyle;
    cxsDolar: TcxStyle;
    cxvPrecos: TcxDBVerticalGrid;
    cxvPrecosTABELA: TcxDBEditorRow;
    cxvPrecosTabFornecedor: TcxDBEditorRow;
    cxvPrecosDBEditorRow3: TcxDBEditorRow;
    cxvPrecosDBEditorRow2: TcxDBEditorRow;
    cxvPrecosCatMarIde: TcxCategoryRow;
    cxvPrecosMARIDE: TcxDBEditorRow;
    cxvPrecosPREIDE: TcxDBEditorRow;
    cxvPrecosCatPreVen: TcxCategoryRow;
    cxvPrecosMARBRU: TcxDBEditorRow;
    cxvPrecosMARMK3: TcxDBEditorRow;
    cxvPrecosCOMTBL: TcxDBEditorRow;
    cxvPrecosPREVEN: TcxDBEditorRow;
    cxvPrecosVENDOL: TcxDBEditorRow;
    cxvPrecosPromocao: TcxCategoryRow;
    cxvPrecosPRO_MARGEM: TcxDBEditorRow;
    cxvPrecosPRO_PREVEN: TcxDBEditorRow;
    procedure cxvPrecosPRO_MARGEMPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosPRO_PREVENPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
  private
    { Private declarations }
    Procedure pAjustarFundoTema;
  public
    { Public declarations }
    frmPai: TForm;

    objTabelas: TTabelasDoItem;

    Procedure pInicializaDados;

  end;

implementation

{$R *.dfm}

Uses
  Uni,
  Vcl.Themes,
  untConstantes,
  untTypesSistema,
  untFuncoesSimples,
  untConsultas;



procedure TfrmTabelasDoItemGrid.cxvPrecosPRO_MARGEMPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
 If Not fEmptyStr(AText) Then
  If StrToFloat(AText) = 0 Then
    AText := '';
end;

procedure TfrmTabelasDoItemGrid.cxvPrecosPRO_PREVENPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
 If Not fEmptyStr(AText) Then
  If StrToFloat(AText) = 0 Then
    AText := '';
end;

Procedure TfrmTabelasDoItemGrid.pInicializaDados;
Begin
  cxvPrecos.DataController.DataSource := objTabelas.cdsDados.dtsSource;

  If fCfgSis('PCMPRO') = '1' Then
    cxvPrecosCOMTBL.Visible := False;

//  cxvPrecosPREDOL.Visible := objTabelas.blnCotDor;
  cxvPrecosVENDOL.Visible := objTabelas.blnCotDor;

  pAjustarFundoTema;
End;

// Com skin, o TfrmPai troca o azul $00FFE4D5 dos containers pela cor de painel do estilo, mas o fundo vazio
// do grid vem de cxsColunaFixa e continuava azul. cxsColunaFixa tambem pinta os cabecalhos, entao o fundo
// ganha um estilo proprio com a cor de painel.
Procedure TfrmTabelasDoItemGrid.pAjustarFundoTema;
Var
  objFundo: TcxStyle;
Begin
  If blnUsuarioLogadoUtilizaModoClassico Then
    Exit;

  If TStyleManager.ActiveStyle.Name <> AUTCOM_STYLE_NAME Then
    Exit;

  objFundo := TcxStyle(cxStyleRepository.CreateItemEx(TcxStyle, Self));
  objFundo.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
  cxvPrecos.Styles.Background := objFundo;
End;

end.
