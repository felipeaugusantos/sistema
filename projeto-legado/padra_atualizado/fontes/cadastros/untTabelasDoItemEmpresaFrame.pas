unit untTabelasDoItemEmpresaFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxStyles, cxClasses,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxEdit,
  cxCurrencyEdit, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxVGrid, cxDBVGrid, cxInplaceContainer, cxCheckBox, Uni,
  untTabelasDoItem, cxTextEdit, Vcl.ExtCtrls, Data.DB, Vcl.Buttons, System.Math;

type

  TfrmTabelasDoItemEmpresaFrame = class(TFrame)
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
    cxvPrecosSUBFED: TcxDBEditorRow;
    cxvPrecosOUTVAL: TcxDBEditorRow;
    cxvPrecosICMSAI: TcxDBEditorRow;
    cxvPrecosIMPFED: TcxDBEditorRow;
    cxvPrecosDESOPE: TcxDBEditorRow;
    cxvPrecosDBEditorRow1: TcxDBEditorRow;
    procedure cxvPrecosSUBFEDPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosOUTVALPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosItemChanged(Sender: TObject; AOldRow: TcxCustomRow;
      AOldCellIndex: Integer);
    procedure cxvPrecosSUBFEDEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosIMPFEDEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosICMSAIEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosDESOPEEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    FDataSet: TDataSet;
    { Private declarations }
  public
    { Public declarations }
    Procedure pHabilitaCampos(blnHabilitaEdicao: Boolean);
    Procedure pInicializaDados(ADataSource: TDataSource);
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples, untConsultas, untTypesSistema,
  untPai, untSalvaConfiguracaoGrid;

Procedure TfrmTabelasDoItemEmpresaFrame.pInicializaDados(ADataSource: TDataSource);
Begin
  cxvPrecos.DataController.DataSource := ADataSource;
  FDataSet := ADataSource.DataSet;
  cxvPrecosOUTVAL.Properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
End;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosDESOPEEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If InRange(DisplayValue, 0 , 100) Then
    Exit;
  pMensagemOk('As Despesas Operacionais devem estar entre 0 e 100%');
  DisplayValue := 0
end;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosICMSAIEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If InRange(DisplayValue, 0 , 100) Then
    Exit;
  pMensagemOk('O ICMS de saída deve estar entre 0 e 100%');
  DisplayValue := 0

end;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosIMPFEDEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If InRange(DisplayValue, 0 , 100) Then
    Exit;
  pMensagemOk('O Impostos federais(+) deve estar entre 0 e 100%');
  DisplayValue := 0

end;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosItemChanged(Sender: TObject;
  AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  If FDataSet.State In dsEditModes Then
    FDataSet.Post;
end;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosOUTVALPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  AText :=  FormatFloat(fMskDigitos(2), fStrToFloat(AText)) + '    '
end;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosSUBFEDEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If InRange(DisplayValue, 0 , 100) Then
    Exit;
  pMensagemOk('O Impostos federais(-) deve estar entre 0 e 100%');
  DisplayValue := 0
end;

procedure TfrmTabelasDoItemEmpresaFrame.cxvPrecosSUBFEDPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  AText := FormatFloat(fMskDigitos(2), fStrToFloat(AText)) + ' %';

end;

Procedure TfrmTabelasDoItemEmpresaFrame.pHabilitaCampos(blnHabilitaEdicao: Boolean);
Begin

  cxvPrecosSUBFED.Properties.Options.Editing := blnHabilitaEdicao;
  cxvPrecosIMPFED.Properties.Options.Editing := blnHabilitaEdicao;
  cxvPrecosICMSAI.Properties.Options.Editing := blnHabilitaEdicao;
  cxvPrecosDESOPE.Properties.Options.Editing := blnHabilitaEdicao;
  cxvPrecosOUTVAL.Properties.Options.Editing := blnHabilitaEdicao;

End;

end.


