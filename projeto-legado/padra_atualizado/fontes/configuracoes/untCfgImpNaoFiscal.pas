unit untCfgImpNaoFiscal;

interface

uses
  Windows, Classes, Controls, untPai, StdCtrls, ComboBoxFocus, Menus, Buttons,
  ExtCtrls, ComCtrls, FilenameEditFocus, AppEvnts, BitBtnLockedIncrem, Mask,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCfgImpNaoFiscal = class(TfrmPai)
    pnlCabecalho: TPanel;
    cmbMarca: TComboBoxFocus;
    Label1: TLabel;
    pgcGeral: TPageControl;
    tbsBematech: TTabSheet;
    Label2: TLabel;
    cmbBemaModelo: TComboBoxFocus;
    Label3: TLabel;
    cmbBemaPorta: TComboBoxFocus;
    Label4: TLabel;
    chkUsaImp: TCheckBox;
    tbsDaruma: TTabSheet;
    Label5: TLabel;
    cmbDarumaPorta: TComboBoxFocus;
    Label6: TLabel;
    btnGravar: TBitBtnLocked;
    edtDarumaPathDll: TFilenameEditFocus;
    edtBemaPathDll: TFilenameEditFocus;
    tbsEpson: TTabSheet;
    Label7: TLabel;
    cmbEpsonPorta: TComboBoxFocus;
    Label8: TLabel;
    edtEpsonPathDll: TFilenameEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pGravaArqIni;
    procedure pCarregaArqIni;

    function fIndiceMarca(strValor: String): Integer;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmCfgImpNaoFiscal.pCarregaArqIni;
begin
  chkUsaImp.Checked  := IIF(fArqIniLocal(0, 'GERAL', 'USAIMP', '', 'opcoes_nao_fiscal.ini') = 'S', True, False);
  cmbMarca.ItemIndex := fIndiceMarca(fArqIniLocal(0, 'GERAL', 'MARCA', '', 'opcoes_nao_fiscal.ini'));

  {*****************************************}
  {* BEMATECH                              *}
  {**************************************MV*}
  cmbBemaModelo.ItemIndex := StrToInt(fArqIniLocal(0, 'BEMATECH', 'MODELO', '0', 'opcoes_nao_fiscal.ini'));
  cmbBemaPorta.Text       := fArqIniLocal(0, 'BEMATECH', 'PORTA', 'LPT1', 'opcoes_nao_fiscal.ini');
  edtBemaPathDll.Text     := fArqIniLocal(0, 'BEMATECH', 'PATHDLL', '', 'opcoes_nao_fiscal.ini');

  {*****************************************}
  {* DARUMA                                *}
  {**************************************MV*}
  cmbDarumaPorta.Text     := fArqIniLocal(0, 'DARUMA', 'PORTA', 'LPT1', 'opcoes_nao_fiscal.ini');
  edtDarumaPathDll.Text   := fArqIniLocal(0, 'DARUMA', 'PATHDLL', '', 'opcoes_nao_fiscal.ini');

  {*****************************************}
  {* EPSON                                 *}
  {**************************************VA*}
  cmbEpsonPorta.Text     := fArqIniLocal(0, 'EPSON', 'PORTA', 'LPT1', 'opcoes_nao_fiscal.ini');
  edtEpsonPathDll.Text   := fArqIniLocal(0, 'EPSON', 'PATHDLL', '', 'opcoes_nao_fiscal.ini');
end;

procedure TfrmCfgImpNaoFiscal.pGravaArqIni;
begin

  fArqIniLocal(1, 'GERAL', 'MARCA', cmbMarca.Text, 'opcoes_nao_fiscal.ini');
  fArqIniLocal(1, 'GERAL', 'USAIMP', IIF(chkUsaImp.Checked, 'S', 'N'), 'opcoes_nao_fiscal.ini');

  {*****************************************}
  {* BEMATECH                              *}
  {**************************************MV*}
  fArqIniLocal(1, 'BEMATECH', 'MODELO', IntToStr(cmbBemaModelo.ItemIndex), 'opcoes_nao_fiscal.ini');
  fArqIniLocal(1, 'BEMATECH', 'PORTA', cmbBemaPorta.Text, 'opcoes_nao_fiscal.ini');
  fArqIniLocal(1, 'BEMATECH', 'PATHDLL', edtBemaPathDll.Text, 'opcoes_nao_fiscal.ini');

  {*****************************************}
  {* DARUMA                                *}
  {**************************************MV*}
  fArqIniLocal(1, 'DARUMA', 'PORTA', cmbDarumaPorta.Text, 'opcoes_nao_fiscal.ini');
  fArqIniLocal(1, 'DARUMA', 'PATHDLL', edtDarumaPathDll.Text, 'opcoes_nao_fiscal.ini');

  {*****************************************}
  {* EPSON                                *}
  {**************************************MV*}
  fArqIniLocal(1, 'EPSON', 'PORTA', cmbEpsonPorta.Text, 'opcoes_nao_fiscal.ini');
  fArqIniLocal(1, 'EPSON', 'PATHDLL', edtEpsonPathDll.Text, 'opcoes_nao_fiscal.ini');
end;

procedure TfrmCfgImpNaoFiscal.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravaArqIni;
  Close;
end;

procedure TfrmCfgImpNaoFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;

  pgcGeral.TabIndex := 0;

  edtDarumaPathDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';
  edtBemaPathDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';
  edtEpsonPathDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';
end;

procedure TfrmCfgImpNaoFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin

    If ((ActiveControl) = cmbMarca) Then
      SelectNext((ActiveControl), True, True);

  End;
end;

procedure TfrmCfgImpNaoFiscal.FormShow(Sender: TObject);
begin
  inherited;
  
  pSetFocus(chkUsaImp);
end;

function TfrmCfgImpNaoFiscal.fIndiceMarca(strValor: String): Integer;
begin
  Result := cmbMarca.Items.IndexOf(strValor);
end;

initialization
  RegisterClass(TfrmCfgImpNaoFiscal);
finalization
  UnRegisterClass(TfrmCfgImpNaoFiscal);

end.

