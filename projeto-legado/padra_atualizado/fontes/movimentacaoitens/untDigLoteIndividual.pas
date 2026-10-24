unit untDigLoteIndividual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Datasnap.DBClient, cxCalc, cxTextEdit, cxLabel, untTypesSistema,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, cxGridCitel, untLoteIndividual,
  untPai, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmDigLoteIndividual = class(TfrmPaiConfirma)
    dtsLotes: TDataSource;
    btnCadLot: TBitBtnLocked;
    cxgLotes: TcxGridCitel;
    cxgLotesTV: TcxGridDBTableViewCitel;
    cxgLotesTVITEM: TcxGridDBColumn;
    cxgLotesTVNUMLOT: TcxGridDBColumn;
    cxgLotesLvl: TcxGridLevel;
    btnLimpar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnCadLotClick(Sender: TObject);
    procedure cxgLotesTVEditKeyUp(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgLotesTVKeyPress(Sender: TObject; var Key: Char);
    procedure cxgLotesTVEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    procedure pBuscaLoteItem(var Key: Char);
    { Private declarations }
  public
    objLotInd : TLoteIndividual;
    { Public declarations }
  end;

var
  frmDigLoteIndividual: TfrmDigLoteIndividual;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples;

procedure TfrmDigLoteIndividual.btnCadLotClick(Sender: TObject);
begin
  objLotInd.pGeraLotesIndividuais;
end;

procedure TfrmDigLoteIndividual.pBuscaLoteItem(var Key : Char);
var
  arrNumLot : TConsultasArray;
begin
  inherited;
  if cxgLotesTVNUMLOT.Options.Editing then
  begin
    If fPesqLoteFat(Self,nil,fCfgSis('DECUNI'),objLotInd.strCodIte,False,True,Nil,Key,arrNumLot, VS_strCodEmp) Then
    Begin
      If not (objLotInd.cdsLotIndAux.State in [dsEdit]) then
        objLotInd.cdsLotIndAux.Edit;

      objLotInd.cdsLotIndAux.FieldByName('NUMLOT').AsString := arrNumLot[0].strCodigo;
      objLotInd.cdsLotIndAux.Post;
    End;
  end;
end;

procedure TfrmDigLoteIndividual.btnConfirmaClick(Sender: TObject);
begin
  if objLotInd.fValidaLotesIndividuais then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmDigLoteIndividual.btnLimparClick(Sender: TObject);
begin
  inherited;
  if fMensagem('', 'Deseja excluir todos os lotes gerados?',['','']) = 1 then
  begin
    objLotInd.cdsLotIndAux.EmptyDataSet;
    close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmDigLoteIndividual.cxgLotesTVEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  if not objLotInd.cdsLotIndAux.Active then
    exit;

  if AItem = cxgLotesTVNUMLOT then
    pBuscaLoteItem(Key);

end;

procedure TfrmDigLoteIndividual.cxgLotesTVEditKeyUp(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_RETURN: if cxgLotesTVNUMLOT.Focused then
               begin
                 objLotInd.cdsLotIndAux.Next;
                 If objLotInd.cdsLotIndAux.Eof Then
                   pSetFocus(btnConfirma)
               end;
  end;
end;

procedure TfrmDigLoteIndividual.cxgLotesTVKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not objLotInd.cdsLotIndAux.Active then
    exit;

  if cxgLotesTVNUMLOT.Focused then
    pBuscaLoteItem(Key);
end;

procedure TfrmDigLoteIndividual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10 : btnConfirma.Click;
    VK_F3  : btnCadLot.Click;
    VK_F4  : btnLimpar.Click;
  end;
end;

procedure TfrmDigLoteIndividual.FormShow(Sender: TObject);
begin
  inherited;
  dtsLotes.DataSet := objLotInd.cdsLotIndAux;
end;

end.
