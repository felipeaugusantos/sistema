unit untFatMostraComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, StdCtrls, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, DB, UniClientDataSet, BitBtnLockedIncrem, EditFocus;

type
  TfrmFatMostraComissao = class(TfrmPaiSimples)
    dbgItens: TDBGridCitel;
    pnlTotais: TPanel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    dtsDados: TDataSource;
    Label4: TLabel;
    edtTotGer: TEditFocus;
    Label5: TLabel;
    edtTotCom: TEditFocus;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fltTotGer,
    fltTotCom: Double;
    cdsDados : TUniClientDataSet;
  end;

var
  frmFatMostraComissao: TfrmFatMostraComissao;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraComissao.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraComissao.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnFechar.Click;
end;

procedure TfrmFatMostraComissao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados  := TUniClientDataSet.Create(Self);

  fltTotGer := 0;
  fltTotCom := 0;
end;

procedure TfrmFatMostraComissao.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(cdsDados.FieldByName('ITE_TOTITE')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('GRU_PERCOM')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('ITE_COMVEN')).DisplayFormat := fMskDigitos(2);

  dtsDados.DataSet  := cdsDados;

  edtTotGer.Text := FormatFloat(fMskDigitos(2), fltTotGer);
  edtTotCom.Text := FormatFloat(fMskDigitos(2), fltTotCom);

end;

end.
