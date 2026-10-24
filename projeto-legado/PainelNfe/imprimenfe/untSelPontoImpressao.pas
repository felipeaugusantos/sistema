unit untSelPontoImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, Winapi.ShlObj, cxShellCommon,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxListView, cxShellListView,
  Printers, WinSpool, System.UITypes, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Uni, strUtils,
  {$IFDEF VER270}

  {$ELSE}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  System.ImageList,
  cxImageList,
  {$ENDIF}
  Data.DB, cxDBData,
  cxImageComboBox, cxTextEdit, cxGridLevel, cxGridCustomTableView,
  cxGridCardView, cxGridDBCardView, cxClasses, cxGridCustomView,
  cxGridCustomLayoutView, cxGrid, cxGridCitel, Vcl.ImgList,
  Datasnap.DBClient, UniClientDataSet;

type
  TfrmSelPontoImpressao = class(TForm)
    cdsImpressoras: TUniClientDataSet;
    cdsImpressorasicone: TIntegerField;
    cdsImpressorasnome_impressora: TStringField;
    dtsImpressoras: TDataSource;
    imgImpressoras: TcxImageList;
    cxgImpressoras: TcxGridCitel;
    cxgImpressorasView: TcxGridDBCardView;
    cxgImpressorasViewicone: TcxGridDBCardViewRow;
    cxgImpressorasViewnome_impressora_exibir: TcxGridDBCardViewRow;
    cxgImpressorasLevel: TcxGridLevel;
    cdsImpressorasnome_impressora_exibir: TStringField;
    procedure FormShow(Sender: TObject);
    procedure cxgImpressorasViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgImpressorasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    procedure pCarregarPontosImpressaoCadastrados;
    procedure pConfirmar;
    { Private declarations }
  public
    { Public declarations }
    strImpSelecionada: String;
    strTipoImpSelecionada: String;
  end;

var
  frmSelPontoImpressao: TfrmSelPontoImpressao;

Const
  IMP_MATRICIAL = 'Matricial';
  IMP_JATO_LASER = 'Jato de Tinta/Laser';

implementation

{$R *.dfm}

uses untSpoolImpressao;

{ TfrmSelPontoImpressao }

procedure TfrmSelPontoImpressao.pConfirmar;
begin
  inherited;
  strImpSelecionada := cdsImpressorasnome_impressora.AsString;

  strTipoImpSelecionada := '';

  If Pos('('+ IMP_MATRICIAL + ')', cdsImpressorasnome_impressora_exibir.AsString) > 0 Then
    strTipoImpSelecionada := IMP_MATRICIAL;

  If Pos('('+ IMP_JATO_LASER + ')', cdsImpressorasnome_impressora_exibir.AsString) > 0 Then
    strTipoImpSelecionada := IMP_JATO_LASER;

  If strImpSelecionada.IsEmpty Then
  Begin
    MessageDlg('Selecione uma Impressora!', mtInformation, [mbOK], 0);
    Exit;
  End;

  Close;
end;

procedure TfrmSelPontoImpressao.cxgImpressorasViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pConfirmar;
end;

procedure TfrmSelPontoImpressao.cxgImpressorasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pConfirmar;
    VK_ESCAPE: Self.Close;
  End;
end;

procedure TfrmSelPontoImpressao.pCarregarPontosImpressaoCadastrados;
Var
  LPontoImpressao: TSpoolImpressaoCitel.TPontoImpressao;
begin
  inherited;
  cdsImpressoras.CreateDataSet;
  cdsImpressoras.LogChanges := False;

  For LPontoImpressao In TSpoolImpressaoCitel.fGetPontosImpressao Do
    cdsImpressoras.AppendRecord([0, LPontoImpressao.NomeFila, LPontoImpressao.NomeFila +
      ' (' + IfThen(LPontoImpressao.TipoImpressora = 'M', IMP_MATRICIAL, IMP_JATO_LASER) + ')']);

  cdsImpressoras.First;
end;

procedure TfrmSelPontoImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  strImpSelecionada     := '';
  strTipoImpSelecionada := '';
end;

procedure TfrmSelPontoImpressao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarPontosImpressaoCadastrados;

  cdsImpressoras.First;

  If cxgImpressoras.CanFocus Then
    cxgImpressoras.SetFocus;
end;

end.
