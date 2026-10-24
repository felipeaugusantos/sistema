unit untDisponibilidadeColorantesLojas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Datasnap.DBClient,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid;

type
  TfrmDisponibilidadeColorantesLojas = class(TfrmPai)
    cdsEmpresa: TUniClientDataSet;
    dtsEmpresa: TDataSource;
    cdsEmpresaEMP_NOMEMP: TStringField;
    cdsEmpresaITE_SALDIS: TFloatField;
    cdsEmpresaITE_QTDITE: TFloatField;
    cdsEmpresaEMP_CODEMP: TStringField;
    cdsEmpresaITE_CODITE: TStringField;
    btnConfirma: TBitBtnLocked;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableViewNOMEMP: TcxGridDBColumn;
    cxGrid1DBTableViewSALDOS: TcxGridDBColumn;
    cxGrid1DBTableViewQTDITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fltQtdFaturar: Double;
    function fValidaQuantidade(ftlQuantidade: Double): Boolean;
  public
    { Public declarations }
    fltQtdItem: Double;
  end;


implementation

uses untFuncoesSimples, untConsultas, untSolicitacaoColorantesLojas;

{$R *.dfm}

procedure TfrmDisponibilidadeColorantesLojas.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;
  if fValidaQuantidade(fltQtdFaturar) then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TfrmDisponibilidadeColorantesLojas.cxGrid1DBTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
  begin

    if AEdit.EditingValue < 1 then
    begin
      cdsEmpresa.Edit;
      cdsEmpresaITE_QTDITE.AsFloat := 0.00;
      cdsEmpresa.Post;
      exit;
    end
    else if  AEdit.EditingValue  = 1 then
    begin
      cdsEmpresa.Edit;
      cdsEmpresaITE_QTDITE.AsFloat := 1.00;
      cdsEmpresa.Post;
      exit;
    end
    else
    begin
      if Frac(AEdit.EditingValue) <> 0.00 then
      begin
        fMensagem('ATENÇÃO!', 'Quantidade informada não pode ser fracionada.', ['&Ok']);
        cdsEmpresa.Edit;
        cdsEmpresaITE_QTDITE.AsFloat := 0.00;
        cdsEmpresa.Post;
        exit;
      end;
    end;

    fltQtdFaturar := fltQtdItem - AEdit.EditingValue;
  end;

end;

procedure TfrmDisponibilidadeColorantesLojas.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEmpresa.CreateDataSet;
end;

procedure TfrmDisponibilidadeColorantesLojas.FormShow(Sender: TObject);
begin
  inherited;
  fltQtdFaturar := fltQtdItem;
end;

function TfrmDisponibilidadeColorantesLojas.fValidaQuantidade(
  ftlQuantidade: Double): Boolean;
begin
  Result := True;
  if ftlQuantidade <> 0 then
  begin
    fMensagem('ATENÇÃO!', 'A soma das quantidades informada deve ser '+FloatToStr(fltQtdItem)+' .', ['&Ok']);
    Result := False;
  end;
end;



end.
