unit untCfgSATCFe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FilenameEditFocus, EditFocus, QColorLabel, frxClass, Printers, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxLookAndFeelPainters, cxGraphics,
  cxControls, cxLookAndFeels, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit,
  cxMaskEdit, cxButtonEdit;

type
  TfrmCfgSATCFe = class(TForm)
    pnlBotoes: TPanel;
    FlwBotoes: TFlowPanel;
    btnSair: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    pnlBotoesTrace: TPanel;
    btnIniciarTrace: TSpeedButton;
    btnPausarTrace: TSpeedButton;
    btnSalvarTrace: TSpeedButton;
    btnViewerTrace: TSpeedButton;
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ColorLabel2: TColorLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edtNumPdv: TEditFocus;
    edtImpressora: TEditFocus;
    edtUsaTef: TEditFocus;
    edtCodigoAtivacao: TEditFocus;
    edtAssinaturaAC: TEditFocus;
    cbxModImpGav: TComboBox;
    edtPatDll: TFilenameEditFocus;
    edtMargem: TEditFocus;
    chkUsaSat: TCheckBox;
    chkGravarSessao: TCheckBox;
    btnLocImp: TBitBtnLocked;
    edtNumSer: TEditFocus;
    Label10: TLabel;
    edtSomenteImpressao: TEditFocus;
    ColorLabel1: TColorLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLocImpClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    procedure pCarregaArqIni;
    procedure pGravaArqIni;
    procedure pImpressorasConfGaveta(stlLista: TStrings);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCfgSATCFe: TfrmCfgSATCFe;

implementation

{$R *.dfm}

uses untUtil;//, untCfgRel;

{ TfrmCfgSATCFe }

procedure TfrmCfgSATCFe.pImpressorasConfGaveta(stlLista: TStrings);
Begin
  stlLista.Clear;
  stlLista.Add('NENHUM');
  stlLista.Add('ELGIN');
  stlLista.Add('EPSON');
  stlLista.Add('DIEBOLD');
  stlLista.Add('BEMATECH');
  stlLista.Add('DARUMA');
  stlLista.Add('DIEBOLD ANSI');
End;

procedure TfrmCfgSATCFe.btnLocImpClick(Sender: TObject);
Var
  LPrintDialog: TPrintDialog;
begin
  LPrintDialog := TPrintDialog.Create(nil);
  Try
    LPrintDialog.Options := [poWarning, poHelp, poDisablePrintToFile];

    If LPrintDialog.Execute() Then
    Begin
      edtImpressora.Text := Printer.Printers[Printer.PrinterIndex];
    End;

  Finally
    FreeAndNil(LPrintDialog);
  End;
end;

procedure TfrmCfgSATCFe.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCfgSATCFe.btnGravarClick(Sender: TObject);
begin
  If (fEmptyStr(edtPatDll.Text)) Then
  Begin
    pMensagemOk('O path para DLL deve ser preenchido!');
    edtPatDll.SetFocus;
    Exit;
  End;

  If (fEmptyStr(edtNumSer.Text)) Then
  Begin
    pMensagemOk('O número de série deve ser preenchido!');
    edtNumSer.SetFocus;
    Exit;
  End;

  If (fEmptyStr(edtImpressora.Text)) Then
  Begin
    pMensagemOk('A impressora deve ser preenchida!');
    edtImpressora.SetFocus;
    Exit;
  End;

  pGravaArqIni;

  ModalResult := mrOk;

  Close;
end;

procedure TfrmCfgSATCFe.FormActivate(Sender: TObject);
begin
  pSetFocus(edtNumPdv);
end;

procedure TfrmCfgSATCFe.FormCreate(Sender: TObject);
begin
  chkUsaSat.Visible := fCfgSis('SATECF', varBoolean);
  pImpressorasConfGaveta(cbxModImpGav.Items);
  pCarregaArqIni;

  edtPatDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';

  If fCfgSis('SPOIMP', varBoolean) Then
  Begin
    edtImpressora.ReadOnly    := True;
    edtImpressora.TabStop     := False;
    edtImpressora.Color       := $00FFDFB8;
    edtImpressora.NormalColor := $00FFDFB8;
    edtImpressora.FocusColor  := $00FFDFB8;
  End;
end;

procedure TfrmCfgSATCFe.pCarregaArqIni;
  Var
    strDirIni: String;
begin
  If not fEmptyStr(VS_PathSat) Then
  Begin
    strDirIni := VS_PathSat;
  End
  Else
  Begin
    strDirIni := fCfgSis('PATSAT');
  End;

  If (fEmptyStr(strDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações do SAT-CFe.');
    Exit;
  End;

  edtNumPdv.Text          := fArqIni(0, 'SATCFE', 'PDV', '', strDirIni + '\opcoes_sat.ini');
  edtImpressora.Text      := fArqIni(0, 'SATCFE', 'IMPRESSORA', '', strDirIni + '\opcoes_sat.ini');
  edtUsaTef.Text          := fArqIni(0, 'SATCFE', 'TEF', 'N', strDirIni + '\opcoes_sat.ini');
  edtCodigoAtivacao.Text  := fArqIni(0, 'SATCFE', 'CODIGO_ATIVACAO', '', strDirIni + '\opcoes_sat.ini');
  edtPatDll.Text          := fArqIni(0, 'SATCFE', 'PATHDLL', '', strDirIni + '\opcoes_sat.ini');
  edtAssinaturaAC.Text    := fArqIni(0, 'SATCFE', 'ASSINATURA_AC', '', strDirIni + '\opcoes_sat.ini');
  cbxModImpGav.ItemIndex  := cbxModImpGav.Items.IndexOf(fArqIni(0, 'SATCFE', 'MODELO_IMP_GAVETA', 'NENHUM', strDirIni + '\opcoes_sat.ini'));
  edtMargem.Text          := fArqIni(0, 'SATCFE', 'MARGEM', '0', strDirIni + '\opcoes_sat.ini');
  chkUsaSat.Checked       := StrToBool( fArqIni(0, 'SATCFE', 'USASAT', '0', strDirIni + '\opcoes_sat.ini') );
  chkGravarSessao.Checked := (fArqIni(0, 'SATCFE', 'GRAVAR_SESSAO', 'N', strDirIni + '\opcoes_sat.ini') = 'S');
  edtNumSer.Text          := fArqIni(0, 'SATCFE', 'NUMERO_SERIE', '', strDirIni + '\opcoes_sat.ini');
  edtSomenteImpressao.Text:= fArqIni(0, 'SATCFE', 'SOMENTE_IMPRESSAO', 'N', strDirIni + '\opcoes_sat.ini');
end;

procedure TfrmCfgSATCFe.pGravaArqIni;
  Var
    strDirIni: String;
begin
  If not fEmptyStr(VS_PathSat) Then
  Begin
    strDirIni := VS_PathSat;
  End
  Else
  Begin
    strDirIni := fCfgSis('PATSAT');
  End;

  If (fEmptyStr(strDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações do SAT-CFe.');
    Exit;
  End;

  fArqIni(1, 'SATCFE', 'PDV', edtNumPdv.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'IMPRESSORA', edtImpressora.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'TEF', edtUsaTef.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'CODIGO_ATIVACAO', edtCodigoAtivacao.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'PATHDLL', edtPatDll.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'ASSINATURA_AC', edtAssinaturaAC.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'MODELO_IMP_GAVETA', cbxModImpGav.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'MARGEM', edtMargem.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'USASAT', IfThen(chkUsaSat.Checked, '1', '0'), strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'GRAVAR_SESSAO', IfThen(chkGravarSessao.Checked, 'S', 'N'), strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'NUMERO_SERIE', edtNumSer.Text, strDirIni + '\opcoes_sat.ini');
  fArqIni(1, 'SATCFE', 'SOMENTE_IMPRESSAO', edtSomenteImpressao.Text, strDirIni + '\opcoes_sat.ini');
end;

end.
