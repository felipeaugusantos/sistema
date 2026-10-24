unit untConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untConsultaModel, StdCtrls,
  BitBtnLockedIncrem, DBClient, madExceptVcl, AppEvnts, cxEditRepositoryItems,
  cxLabel, cxMaskEdit,
  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}
  Buttons;

type
  TfrmConsulta = class(TForm)
    pnlFundo: TPanel;
    pnlBotoes: TPanel;
    cxgConsulta: TcxGrid;
    cxgConsultaView: TcxGridDBTableView;
    cxgConsultaNivel: TcxGridLevel;
    btnConfirma: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    dtsConsulta: TDataSource;
    cdsConsulta: TClientDataSet;
    procedure cxgConsultaViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    objConsulta: TConsultaModel;
    strSel: TStringList;
    procedure pSelecionar;
    procedure pCriaColunasGrid;
    procedure pSetaNomeColunas;
    procedure populaObjConsulta(stlCampos, stlNomesCol, stlCampOrder: TStringList;
      strCondicao, strTabela, strTitulo, strNomeForm: String);
    procedure pMontaColunasGrid;
    { Private declarations }
  public
    destructor Destroy; override;
    procedure pConsulta(var stlSelecao: TStringList; stlCampos, stlNomesCol,
      stlCampOrder: TStringList; strCondicao, strTabela, strTitulo, strNomeForm: String);
    { Public declarations }
  end;

implementation

uses
  untConsultaController;

{$R *.dfm}

procedure TfrmConsulta.btnConfirmaClick(Sender: TObject);
begin
  pSelecionar;
  ModalResult := mrOk;
end;

procedure TfrmConsulta.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsulta.cxgConsultaViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnConfirma.Click;
end;

destructor TfrmConsulta.Destroy;
begin
  if objConsulta <> nil then
    FreeAndNil(objConsulta);
end;

procedure TfrmConsulta.pConsulta(var stlSelecao: TStringList; stlCampos, stlNomesCol,
  stlCampOrder: TStringList; strCondicao, strTabela, strTitulo, strNomeForm: String);
begin
  Self.Caption := strTitulo;
  strSel := stlSelecao;

  populaObjConsulta(stlCampos, stlNomesCol, stlCampOrder, strCondicao, strTabela,
    strTitulo, strNomeForm);

  TConsultaController.get.pConsulta(cdsConsulta, objConsulta);

  cxgConsultaView.BeginUpdate;
  try
    pMontaColunasGrid;
  finally
    cxgConsultaView.EndUpdate;
  end;
end;

procedure TfrmConsulta.pMontaColunasGrid;
begin
  pSetaNomeColunas;
  pCriaColunasGrid;
end;

procedure TfrmConsulta.populaObjConsulta(stlCampos, stlNomesCol, stlCampOrder: TStringList;
  strCondicao, strTabela, strTitulo, strNomeForm: String);
begin
  objConsulta := TConsultaModel.Create(stlCampos, stlNomesCol, stlCampOrder, strCondicao,
    strTabela, strTitulo, strNomeForm)
end;

procedure TfrmConsulta.pSelecionar;
begin
  strSel.Add(cdsConsulta.FieldByName(objConsulta.stlCampos[0]).AsString);
end;

procedure TfrmConsulta.pSetaNomeColunas;
var
  intCont: Integer;
begin
  for intCont := 0 To cdsConsulta.FieldCount - 1 do
  begin
    if Assigned(objConsulta.stlNomesCol) then
      cdsConsulta.Fields[intCont].DisplayLabel := objConsulta.stlNomesCol[intCont]
    else
      cdsConsulta.Fields[intCont].DisplayLabel := objConsulta.stlCampos[intCont];

    cdsConsulta.Fields[intCont].Visible := not SameText(cdsConsulta.Fields[intCont].FieldName, 'AUTOINCREM');
  end;
end;

procedure TfrmConsulta.pCriaColunasGrid;
var
  intCont: Integer;
  cxColuna: TcxGridDBColumn;
begin
  for intCont := 0 to cdsConsulta.FieldCount - 1 do
  begin
    cxColuna := TcxGridDBColumn(cxgConsultaView.FindItemByName(Concat('cxgConsultaView', cdsConsulta.Fields[intCont].FieldName)));

    if not Assigned(cxColuna) then
    begin
      if cdsConsulta.Fields[intCont].Visible then
        cxgConsultaView.DataController.CreateItemByField(cdsConsulta.Fields[intCont]);
    end
    else
      cxColuna.DataBinding.FieldName := cdsConsulta.Fields[intCont].FieldName;
  end;
end;

end.
