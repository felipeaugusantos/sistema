unit untBannerProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxImageComboBox,
  System.ImageList, Vcl.ImgList, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, Uni,
  Vcl.ExtCtrls, dxGDIPlusClasses, cxImage, cxEditRepositoryItems,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, cxLabel, cxGridCardView,
  cxGridDBCardView, cxCurrencyEdit, StrUtils, UniClientDataSet;

type
  TfrmBannerProdutos = class(TForm)
    dtsCadPro: TDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBLayoutView1: TcxGridDBLayoutView;
    cxGrid1DBLayoutView1Item1: TcxGridDBLayoutViewItem;
    cxGrid1DBLayoutView1Item2: TcxGridDBLayoutViewItem;
    cxGrid1DBLayoutView1Item3: TcxGridDBLayoutViewItem;
    cxGrid1DBLayoutView1Group_Root: TdxLayoutGroup;
    cxGrid1DBLayoutView1LayoutItem2: TcxGridLayoutItem;
    cxGrid1DBLayoutView1LayoutItem3: TcxGridLayoutItem;
    cxGridLayoutItem1: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    cxGrid1Level1: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBLayoutView1Item1PropertiesAssignPicture(Sender: TObject;
      const Picture: TPicture);
  private
    qryCadPro: TUniQuery;
  public
    { Public declarations }
  end;

var
  frmBannerProdutos: TfrmBannerProdutos;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmBannerProdutos.cxGrid1DBLayoutView1Item1PropertiesAssignPicture(
  Sender: TObject; const Picture: TPicture);
begin
  Picture.LoadFromFile('C:\Users\Paulo.Zanon\Documents\AUTPAS\379\379.48.02.30_TMP\padra_atualizado\Imagens\00001.jpg');
end;

procedure TfrmBannerProdutos.FormShow(Sender: TObject);
Var
  strSQL: String;
  cdsCadPro: TUniClientDataSet;
  strPath: String;
  Bmp: TMemoryStream;
begin
  qryCadPro := fCriaQuery(Self);

  cdsCadPro := TUniClientDataSet.Create(Owner);
  cdsCadPro.AggregatesActive := True;

  With cdsCadPro.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := 005; Required := False; End;
  With cdsCadPro.FieldDefs.AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 100; Required := False; End;
  With cdsCadPro.FieldDefs.AddFieldDef Do Begin Name := 'PREVEN'; DataType := ftFloat;               Required := False; End; //(12,02)
  With cdsCadPro.FieldDefs.AddFieldDef Do Begin Name := 'IMAGEM'; DataType := ftBlob;                Required := False; End;

  cdsCadPro.CreateDataSet;

  TBlobField.Create(cdsCadPro.FieldByName('IMAGEM') as TBlobField);

  strPath := ExtractFilePath(Application.ExeName) + 'imagens\';
  strPath := ReplaceStr(strPath, '\', '\\');

  //strSQL := 'SELECT ITE_CODITE AS CODITE, ITE_DESITE AS DESITE, 100 AS PREVEN, CONCAT(' + QuotedStr(strPath) + ', ITE_CODITE,' + QuotedStr('.jpg') + ') AS PATIMG  FROM CADITE WHERE ITE_CODITE IN(''00001'',''00002'', ''00005'') ';
  strSQL := 'SELECT ITE_CODITE AS CODITE, ITE_DESITE AS DESITE, 100 AS PREVEN, CONCAT(' + QuotedStr(strPath) + ', ITE_CODITE,' + QuotedStr('.jpg') + ') AS PATIMG  FROM CADITE ';

  With qryCadPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    First;

    While Not Eof Do
    Begin
      cdsCadPro.Insert;
      cdsCadPro.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
      cdsCadPro.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
      cdsCadPro.FieldByName('PREVEN').AsFloat  := FieldByName('PREVEN').AsFloat;

      If (FileExists(FieldByName('PATIMG').AsString)) Then
        TBlobField(cdsCadPro.FieldByName('IMAGEM')).LoadFromFile(FieldByName('PATIMG').AsString);
      cdsCadPro.Post;
      Next;
    End;

    dtsCadPro.DataSet := cdsCadPro;
  End;

end;

end.
