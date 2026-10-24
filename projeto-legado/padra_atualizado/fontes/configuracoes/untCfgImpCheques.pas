unit untCfgImpCheques;

interface

uses
  Windows, Classes, Controls, untPai, StdCtrls, FilenameEditFocus, ComboBoxFocus,
  ComCtrls, AppEvnts, Menus, Buttons, ExtCtrls, BitBtnLockedIncrem, Mask,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  frxClass, System.SysUtils, frxExportCSVTestabilidade;

type
  TfrmCfgImpCheques = class(TfrmPai)
    pgcGeral: TPageControl;
    tbsElgin: TTabSheet;
    Label7: TLabel;
    cmbElginPorta: TComboBoxFocus;
    Label4: TLabel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    cmbMarca: TComboBoxFocus;
    btnGravar: TBitBtnLocked;
    edtElginPathDll: TFilenameEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pGravarArqIni;
    procedure pCarregaArqIni;
  public
    { Public declarations }
  end;

implementation

uses Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgImpCheques.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravarArqIni;
  Close;
end;

procedure TfrmCfgImpCheques.pCarregaArqIni;
  Var
    intIndice: Integer;
begin
  intIndice := cmbMarca.Items.IndexOf(fArqIniLocal(0, 'GERAL', 'MARCA', '', ExtractFilePath(Application.ExeName) + 'opcoes_impchq.ini'));
  cmbMarca.ItemIndex := intIndice;

  cmbElginPorta.Text := fArqIniLocal(0, 'ELGIN', 'PORTA', 'COM1', ExtractFilePath(Application.ExeName) + 'opcoes_impchq.ini');
  edtElginPathDll.Text := fArqIniLocal(0, 'ELGIN', 'PATDLL', '', ExtractFilePath(Application.ExeName) + 'opcoes_impchq.ini');
end;

procedure TfrmCfgImpCheques.pGravarArqIni;
begin
  fArqIniLocal(1, 'GERAL', 'MARCA', cmbMarca.Text, ExtractFilePath(Application.ExeName) + 'opcoes_impchq.ini');

  fArqIniLocal(1, 'ELGIN', 'PORTA', cmbElginPorta.Text, ExtractFilePath(Application.ExeName) + 'opcoes_impchq.ini');
  fArqIniLocal(1, 'ELGIN', 'PATDLL', edtElginPathDll.Text, ExtractFilePath(Application.ExeName) + 'opcoes_impchq.ini');
end;

procedure TfrmCfgImpCheques.FormCreate(Sender: TObject);
begin
  inherited;
  edtElginPathDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';
end;

procedure TfrmCfgImpCheques.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  pSetFocus(cmbMarca);
end;

end.
