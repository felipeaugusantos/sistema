unit untCadDetAjustIcm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxImage, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  Vcl.Grids, Vcl.DBGrids, MemDS, DBAccess, dxLayoutContainer,
  cxGridViewLayoutContainer, cxGridLayoutView, cxGridDBLayoutView,
  cxGridCustomLayoutView, Vcl.DBCtrls, cxImageComboBox, System.ImageList,
  Vcl.ImgList, cxImageList, MemoFocus;

type
  TfrmCadDetAjustIcm = class(TfrmPaiSimples)
    cxgDetAjuDBTableView: TcxGridDBTableViewCitel;
    cxgDetAjuLevel: TcxGridLevel;
    cxgDetAju: TcxGridCitel;
    lblOcorrencias: TLabel;
    cxImageListMsg: TcxImageList;
    Panel1: TPanel;
    FlowPanel1: TFlowPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnDel: TBitBtnLocked;
    btnInc: TBitBtnLocked;
    dtsAdiAju: TDataSource;
    cdsAdiAju: TUniClientDataSet;
    cdsAdiAjuAJU_CODEMP: TStringField;
    cdsAdiAjuAJU_MESANO: TStringField;
    cdsAdiAjuAJU_NUMDAE: TStringField;
    cdsAdiAjuAJU_NUMPAV: TStringField;
    cdsAdiAjuAJU_INDORI: TStringField;
    cdsAdiAjuAJU_DESAJU: TStringField;
    cdsAdiAjuAJU_COMPLE: TStringField;
    AJU_CODEMP: TcxGridDBColumn;
    AJU_MESANO: TcxGridDBColumn;
    AJU_NUMDAE: TcxGridDBColumn;
    AJU_NUMPAV: TcxGridDBColumn;
    AJU_INDORI: TcxGridDBColumn;
    AJU_DESAJU: TcxGridDBColumn;
    AJU_COMPLE: TcxGridDBColumn;
    cdsAdiAjuAUTOINCREM: TStringField;
    procedure cxgDetAjuDBTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnDelClick(Sender: TObject);
    procedure btnIncClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnEdicao: Boolean;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untGravando, untConsultas;

{$R *.dfm}

procedure TfrmCadDetAjustIcm.btnDelClick(Sender: TObject);
begin
  inherited;
  If cdsAdiAju.IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão da Informação Adicional do Ajuste da Apuração (E112)?') Then
  Begin
    cdsAdiAju.Delete;
  End;
end;

procedure TfrmCadDetAjustIcm.btnIncClick(Sender: TObject);
var
  arrSel : TConsultasArray;
  qryConsulta: TUniQuery;
  chrKey : Char;
begin
  chrKey := '/';

  Try
    qryConsulta := fCriaQuery;
    If fPesqAdiAjusteApu(Self, qryConsulta, chrKey, arrSel) Then
    Begin
      If Not cdsAdiAju.Locate('AUTOINCREM', qryConsulta.FieldByName('AUTOINCREM').AsString, []) Then
      Begin
        cdsAdiAju.Insert;
        cdsAdiAju.FieldByName('AUTOINCREM').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
        cdsAdiAju.FieldByName('AJU_CODEMP').AsString := qryConsulta.FieldByName('AJU_CODEMP').AsString;
        cdsAdiAju.FieldByName('AJU_MESANO').AsString := qryConsulta.FieldByName('AJU_MESANO').AsString;
        cdsAdiAju.FieldByName('AJU_NUMDAE').AsString := qryConsulta.FieldByName('AJU_NUMDAE').AsString;
        cdsAdiAju.FieldByName('AJU_NUMPAV').AsString := qryConsulta.FieldByName('AJU_NUMPAV').AsString;
        cdsAdiAju.FieldByName('AJU_INDORI').AsString := qryConsulta.FieldByName('AJU_INDORI').AsString;
        cdsAdiAju.FieldByName('AJU_DESAJU').AsString := qryConsulta.FieldByName('AJU_DESAJU').AsString;
        cdsAdiAju.FieldByName('AJU_COMPLE').AsString := qryConsulta.FieldByName('AJU_COMPLE').AsString;
        cdsAdiAju.Post;
      End
      Else
        fMensagem('', 'Informação Adicional já vinculada ao Ajuste de Icms!', ['&Ok']);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadDetAjustIcm.cxgDetAjuDBTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key Of
    VK_DELETE: btnDel.Click;
  end;
end;

procedure TfrmCadDetAjustIcm.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAdiAju.CreateDataSet;
end;

procedure TfrmCadDetAjustIcm.FormShow(Sender: TObject);
begin
  inherited;
  btnInc.Enabled := blnEdicao;
  btnDel.Enabled := blnEdicao;

  dtsAdiAju.DataSet := cdsAdiAju;
end;

end.
