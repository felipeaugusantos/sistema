unit untFatSelCliCon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, MaskUtils,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmFatSelCliCon = class(TfrmPai)
    gridConsumidoresDBTableView1: TcxGridDBTableView;
    gridConsumidoresLevel1: TcxGridLevel;
    gridConsumidores: TcxGrid;
    cdsCliCon: TUniClientDataSet;
    dtsCadEmp: TDataSource;
    cdsCliConCGCCPF: TStringField;
    cdsCliConCGCCON: TStringField;
    cdsCliConNOMCON: TStringField;
    cdsCliConQTDDOC: TIntegerField;
    gridConsumidoresDBTableView1CGCCPF: TcxGridDBColumn;
    gridConsumidoresDBTableView1CGCCON: TcxGridDBColumn;
    gridConsumidoresDBTableView1NOMCON: TcxGridDBColumn;
    gridConsumidoresDBTableView1QTDPEN: TcxGridDBColumn;
    lbl1: TLabel;
    procedure gridConsumidoresDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure gridConsumidoresDBTableView1CGCCONGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strCgcCpfSel: String;
    strCgcConSel: String;
    strNomConSel: String;

    procedure pAddConsumidor(strCgcCpf, strCgcCon, strNomCon: String);

  end;

var
  frmFatSelCliCon: TfrmFatSelCliCon;

implementation

uses untFuncoesGenerica, untFuncoesSimples;

{$R *.dfm}

{ TfrmFatSelCliCon }

procedure TfrmFatSelCliCon.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCliCon.CreateDataSet;
end;

procedure TfrmFatSelCliCon.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(gridConsumidores);
end;

procedure TfrmFatSelCliCon.gridConsumidoresDBTableView1CGCCONGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    intIndex: Integer;
begin
  intIndex := gridConsumidoresDBTableView1CGCCPF.Index;

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

procedure TfrmFatSelCliCon.gridConsumidoresDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: Begin
                 btnSair.Click;
               End;
    VK_RETURN: Begin
                 strCgcCpfSel := cdsCliCon.FieldByName('CGCCPF').AsString;
                 strCgcConSel := cdsCliCon.FieldByName('CGCCON').AsString;
                 strNomConSel := cdsCliCon.FieldByName('NOMCON').AsString;
                 ModalResult  := mrOk;
               End;
  End;
end;

procedure TfrmFatSelCliCon.pAddConsumidor(strCgcCpf, strCgcCon,
  strNomCon: String);
begin
  If cdsCliCon.Locate('CGCCPF;CGCCON;NOMCON',
           VarArrayOf([Trim(strCgcCpf), Trim(strCgcCon), Trim(strNomCon)]), []) Then
  Begin
    cdsCliCon.Edit;
    cdsCliCon.FieldByName('QTDPEN').AsInteger := cdsCliCon.FieldByName('QTDPEN').AsInteger + 1;
    cdsCliCon.Post;
  End
  Else
  Begin
    cdsCliCon.Append;
    cdsCliCon.FieldByName('QTDPEN').AsInteger := 1;
    cdsCliCon.FieldByName('CGCCPF').AsString  := Trim(strCgcCpf);
    cdsCliCon.FieldByName('CGCCON').AsString  := Trim(strCgcCon);
    cdsCliCon.FieldByName('NOMCON').AsString  := Trim(strNomCon);
    cdsCliCon.Post;
  End;
end;

end.
